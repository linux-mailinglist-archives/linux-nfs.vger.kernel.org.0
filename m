Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4A1AD29C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 00:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgDPWPC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 18:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgDPWPB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:01 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC29221F9;
        Thu, 16 Apr 2020 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075300;
        bh=UBxOfKwmooiVMIBZRcKC/SzyfEfO3jdrx0sJu4y+Nmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzBDqnQD3DblWJL/zo55P51ilF6bGp2azZMYek7e7uJzZO3Jn4yDuqJWBYUrUmwxp
         +9Q4Xd/qM36WuBFCaaALBoRXxSiSdTYpUWnmd4Z9VgVLVP5vBWG0mlCRxz0kcsHdxO
         MW1xVd9780NnYzzkWfgACPWRHiJT9HGljQ6iXuYE=
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/7] mountd: Add a helper nfsd_path_statfs64() for uuid_by_path()
Date:   Thu, 16 Apr 2020 18:12:46 -0400
Message-Id: <20200416221252.82102-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416221252.82102-1-trondmy@kernel.org>
References: <20200416221252.82102-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure uuid_by_path() works correctly when 'rootdir'
is set in the [exports] section of nfs.conf.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/include/nfsd_path.h |  5 +++++
 support/misc/nfsd_path.c    | 43 +++++++++++++++++++++++++++++++++++++
 utils/mountd/cache.c        |  2 +-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index b42416bbff58..8331ff96a277 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -6,6 +6,8 @@
 
 #include <sys/stat.h>
 
+struct statfs64;
+
 void 		nfsd_path_init(void);
 
 const char *	nfsd_path_nfsd_rootdir(void);
@@ -15,6 +17,9 @@ char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
 int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
 int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
 
+int		nfsd_path_statfs64(const char *pathname,
+				   struct statfs64 *statbuf);
+
 char *		nfsd_realpath(const char *path, char *resolved_path);
 
 ssize_t		nfsd_path_read(int fd, char *buf, size_t len);
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index f078a668fb8f..ab6c98dbe395 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -5,6 +5,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/vfs.h>
 #include <limits.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -180,6 +181,48 @@ nfsd_path_lstat(const char *pathname, struct stat *statbuf)
 	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
 }
 
+struct nfsd_statfs64_data {
+	const char *pathname;
+	struct statfs64 *statbuf;
+	int ret;
+	int err;
+};
+
+static void
+nfsd_statfs64func(void *data)
+{
+	struct nfsd_statfs64_data *d = data;
+
+	d->ret = statfs64(d->pathname, d->statbuf);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+static int
+nfsd_run_statfs64(struct xthread_workqueue *wq,
+		  const char *pathname,
+		  struct statfs64 *statbuf)
+{
+	struct nfsd_statfs64_data data = {
+		pathname,
+		statbuf,
+		0,
+		0
+	};
+	xthread_work_run_sync(wq, nfsd_statfs64func, &data);
+	if (data.ret < 0)
+		errno = data.err;
+	return data.ret;
+}
+
+int
+nfsd_path_statfs64(const char *pathname, struct statfs64 *statbuf)
+{
+	if (!nfsd_wq)
+		return statfs64(pathname, statbuf);
+	return nfsd_run_statfs64(nfsd_wq, pathname, statbuf);
+}
+
 struct nfsd_realpath_data {
 	const char *pathname;
 	char *resolved;
diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 8f54e37b7936..7d8657c91323 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -352,7 +352,7 @@ static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid)
 	const char *val;
 	int rc;
 
-	rc = statfs64(path, &st);
+	rc = nfsd_path_statfs64(path, &st);
 
 	if (type == 0 && rc == 0) {
 		const unsigned long *bad;
-- 
2.25.2

