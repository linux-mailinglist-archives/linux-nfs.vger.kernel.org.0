Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83F2D076
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfE1Udl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38942 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfE1Udl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:41 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so6136667itf.4
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=643A/JXkc2fq/8damgxL6JCgtP0wyB1q+dhVeiGdlgE=;
        b=WwrrXhpHWqnxdeAFcjg7vGnP89MgU8IsU7sQJG2xDzEZtpc8v/FojypESYP+Oeu+W/
         4jAOAyNXDymL/WkkwjBMMrU5o4S5d+JUbFRe+QWz8/vXQiCUOddkrzh2nTXzP8/EpLyO
         5bzexbhfmG1++svvXJXebARMmEI17VcRlYgw1S1yUSLt35cFT5d5Hw9ptjFLkMQj3EN2
         n5WNdEymN0Vk+qNr2WCohubBh5tnvcRlT2FtoPxPfL4ah4Y9PjIk34bicDC36H1+yUwH
         SfKFma14iQmQIEMp0px5fnKVa+mirjnuAWtJpFScAUo5A58qu57J31DlL6yb2CaMgx7n
         +zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=643A/JXkc2fq/8damgxL6JCgtP0wyB1q+dhVeiGdlgE=;
        b=KIEAY5aJ0TCVaHJ65vUsm/PRlSb3WBFZKXIuAgcVmDK/nX4S0Bkvp5VmaHDnX0SDX5
         pjS2y4rslTy3FJmi0lFhQvwfDGw5rtA2Eiik/sIHVmpz77r/aK08op6U1ICZryxcxZqC
         dvZaXTHTnkfeNYqfmLK+aaFMeE2bligYHKKMCZhkgkWO/1ln4QVOKHuOCGi43sNZp7y+
         MfbBXOiWvTgdZt10/Ntz8hPoLkxMZgPGc8tW4snDO/HkZ2mSjuR+pGlnp3JMBOVHxfj2
         wHGDkM7qn8UmbYpmzb5kciP8/A8CV9NKF4m4idP2We4P1giKVNnIb1EReDTjELeJ02gL
         YJ2g==
X-Gm-Message-State: APjAAAUYVOj20+9zUXaDWYMXXFanV1NB1v+YTRn8+Po3P04nLhBL605a
        gJBujNeCCVnKHg6f5gFGB4/MXec=
X-Google-Smtp-Source: APXvYqxwtR2z0OP7qO0aTCWT3Z32GQXLlvUDzAR2tuo2kWTAVtSDfM6bxFhTcvbHNRDOu0v5E3iOng==
X-Received: by 2002:a05:660c:6c1:: with SMTP id z1mr5057526itk.126.1559075620105;
        Tue, 28 May 2019 13:33:40 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:39 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 10/11] Add a helper for resolving symlinked nfsd paths via realpath()
Date:   Tue, 28 May 2019 16:31:21 -0400
Message-Id: <20190528203122.11401-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-10-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
 <20190528203122.11401-8-trond.myklebust@hammerspace.com>
 <20190528203122.11401-9-trond.myklebust@hammerspace.com>
 <20190528203122.11401-10-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a helper to resolve symlinked nfsd paths when the user has set the
"[exports] rootdir" nfs.conf option.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/include/nfsd_path.h |  2 ++
 support/misc/nfsd_path.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index f4a7f0a4337f..ca2570a92e68 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -13,6 +13,8 @@ char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
 int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
 int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
 
+char *		nfsd_realpath(const char *path, char *resolved_path);
+
 ssize_t		nfsd_path_read(int fd, char *buf, size_t len);
 ssize_t		nfsd_path_write(int fd, const char *buf, size_t len);
 
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 8ddafd65ab76..2f41a793c534 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <stdlib.h>
 #include <unistd.h>
 
 #include "config.h"
@@ -169,6 +170,40 @@ nfsd_path_lstat(const char *pathname, struct stat *statbuf)
 	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
 }
 
+struct nfsd_realpath_data {
+	const char *pathname;
+	char *resolved;
+	int err;
+};
+
+static void
+nfsd_realpathfunc(void *data)
+{
+	struct nfsd_realpath_data *d = data;
+
+	d->resolved = realpath(d->pathname, d->resolved);
+	if (!d->resolved)
+		d->err = errno;
+}
+
+char *
+nfsd_realpath(const char *path, char *resolved_path)
+{
+	struct nfsd_realpath_data data = {
+		path,
+		resolved_path,
+		0
+	};
+
+	if (!nfsd_wq)
+		return realpath(path, resolved_path);
+
+	xthread_work_run_sync(nfsd_wq, nfsd_realpathfunc, &data);
+	if (!data.resolved)
+		errno = data.err;
+	return data.resolved;
+}
+
 struct nfsd_read_data {
 	int fd;
 	char *buf;
-- 
2.21.0

