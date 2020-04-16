Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C081AD29D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 00:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgDPWPD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 18:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbgDPWPB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:01 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF7622202;
        Thu, 16 Apr 2020 22:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075301;
        bh=T4yeFO6a2Xdolflm5Sk9634oTQJvbzJs/jNvsRwN3WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGwuRcQKsVWEt4ewo6qZk9fAhzxWTd3O9O5+X9l/oALtWLfS6xgBIyyuebHqwyABu
         FBfo8i6Iebztpw06608cynpDWHhXiL13nhhdVKVH59D2STRSa/TmmSMc8Fwpxd1j9Q
         r5SEVSZxPACtw22bmA6sBgGa6aRcMVih96L91N0A=
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] nfsd: Support running nfsd_name_to_handle_at() in the root jail
Date:   Thu, 16 Apr 2020 18:12:47 -0400
Message-Id: <20200416221252.82102-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416221252.82102-2-trondmy@kernel.org>
References: <20200416221252.82102-1-trondmy@kernel.org>
 <20200416221252.82102-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When running nfsd_name_to_handle_at(), we usually want to see the same
namespace as knfsd, so add helpers.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/include/nfsd_path.h |  4 +++
 support/misc/nfsd_path.c    | 66 +++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index 8331ff96a277..3b73aadd8af7 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -6,6 +6,7 @@
 
 #include <sys/stat.h>
 
+struct file_handle;
 struct statfs64;
 
 void 		nfsd_path_init(void);
@@ -25,4 +26,7 @@ char *		nfsd_realpath(const char *path, char *resolved_path);
 ssize_t		nfsd_path_read(int fd, char *buf, size_t len);
 ssize_t		nfsd_path_write(int fd, const char *buf, size_t len);
 
+int		nfsd_name_to_handle_at(int fd, const char *path,
+				       struct file_handle *fh,
+				       int *mount_id, int flags);
 #endif
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index ab6c98dbe395..1f6dfd4b642b 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -6,6 +6,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/vfs.h>
+#include <fcntl.h>
 #include <limits.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -14,6 +15,7 @@
 #include "xmalloc.h"
 #include "xlog.h"
 #include "xstat.h"
+#include "nfslib.h"
 #include "nfsd_path.h"
 #include "workqueue.h"
 
@@ -340,3 +342,67 @@ nfsd_path_write(int fd, const char *buf, size_t len)
 		return write(fd, buf, len);
 	return nfsd_run_write(nfsd_wq, fd, buf, len);
 }
+
+#if defined(HAVE_NAME_TO_HANDLE_AT)
+struct nfsd_handle_data {
+	int fd;
+	const char *path;
+	struct file_handle *fh;
+	int *mount_id;
+	int flags;
+	int ret;
+	int err;
+};
+
+static void
+nfsd_name_to_handle_func(void *data)
+{
+	struct nfsd_handle_data *d = data;
+
+	d->ret = name_to_handle_at(d->fd, d->path,
+			d->fh, d->mount_id, d->flags);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+static int
+nfsd_run_name_to_handle_at(struct xthread_workqueue *wq,
+		int fd, const char *path, struct file_handle *fh,
+		int *mount_id, int flags)
+{
+	struct nfsd_handle_data data = {
+		fd,
+		path,
+		fh,
+		mount_id,
+		flags,
+		0,
+		0
+	};
+
+	xthread_work_run_sync(wq, nfsd_name_to_handle_func, &data);
+	if (data.ret < 0)
+		errno = data.err;
+	return data.ret;
+}
+
+int
+nfsd_name_to_handle_at(int fd, const char *path, struct file_handle *fh,
+		int *mount_id, int flags)
+{
+	if (!nfsd_wq)
+		return name_to_handle_at(fd, path, fh, mount_id, flags);
+
+	return nfsd_run_name_to_handle_at(nfsd_wq, fd, path, fh,
+			mount_id, flags);
+}
+#else
+int
+nfsd_name_to_handle_at(int UNUSED(fd), const char *UNUSED(path),
+		struct file_handle *UNUSED(fh),
+		int *UNUSED(mount_id), int UNUSED(flags))
+{
+	errno = ENOSYS;
+	return -1;
+}
+#endif
-- 
2.25.2

