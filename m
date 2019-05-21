Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE824F2F
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEUMtR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 08:49:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40470 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfEUMtR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 08:49:17 -0400
Received: by mail-io1-f66.google.com with SMTP id s20so13805603ioj.7
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yvd08hZwHj0WOPQBOc8y50kIfDMDBLgAaLTQJ0rzgHI=;
        b=GXaPovFIJim8v98IAUpOcLr0FYjbv6i8loTCe6jrTYL2Olw0ZWhqboVf/5Os2eBfEW
         cCTvIqe+8/7CITaPLn/5SyuftFHNtWKru47AzcIHIIJmAc3TeSBAFge59sHEL5eMdDzf
         /m0e/+Z7HAfV3k+RnISUi1wTVMO/pq3V1TsRRKkixaz89ZJSaQqSByKb5yZWx+gjYHqZ
         eTU7rkMZlhdsrrSvEtAnl9o6/6feqI/7ygPVr6k/5LqP6TC9LdEpRpvEhpdos/lY/6fd
         CVvLLJmhiIYXMuGuURoPQobWh6qIiqvgUTyvDYWgXgGweVklRIhtSXBYSh8NkRlDxVzI
         twtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yvd08hZwHj0WOPQBOc8y50kIfDMDBLgAaLTQJ0rzgHI=;
        b=LpBh03RKniWSLcR89J8epV+TSUo72HqMGvnAIV1r6LmQlrEoybrGZUNKSl5p6VCs9t
         b5vtagEEn6uNp3a3Ev0B8GTg2KLApsUr4Fca4xExu0y8vOMEKLQrPJzQ51VKx5e6DNPm
         yE2IvPgQ4TfYw48BzK89523MP74wCYuG2xwc0G7LIhVcP80UiYoQVriEflxkDZ2SDBwD
         Yuw4atYMso3Mi4egDp51RCGqS/YGME0QIf817wib5d65I/NIZm8rzTyREAgYDu4niYL+
         bFErXLyBj7SoFrTFleqGLe/BIKx4rXUtPXuJp4inl/Xkc+xWJRork6o/sh65T2CeXeD6
         HBFQ==
X-Gm-Message-State: APjAAAVkcciUBM3tdqrrrFIVGvr53Tgnz4jkr3SKlx1rzNv7/ajSKIWn
        B+N64QRc2pjeDCPqw3koZg==
X-Google-Smtp-Source: APXvYqw0e0iKuYjH4hlRYJQpg9Gfd2hS/ZddNLAu19uON94c59fr/UxK+eZ4iaEyGxYWvK3hB8s1Iw==
X-Received: by 2002:a6b:e90e:: with SMTP id u14mr12705470iof.121.1558442956123;
        Tue, 21 May 2019 05:49:16 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v139sm1693180itb.25.2019.05.21.05.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:49:15 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 5/7] Add helpers to read/write to a file through the chrooted thread
Date:   Tue, 21 May 2019 08:46:59 -0400
Message-Id: <20190521124701.61849-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521124701.61849-5-trond.myklebust@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <20190521124701.61849-2-trond.myklebust@hammerspace.com>
 <20190521124701.61849-3-trond.myklebust@hammerspace.com>
 <20190521124701.61849-4-trond.myklebust@hammerspace.com>
 <20190521124701.61849-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add helper functions to do synchronous I/O to a file from inside the
chrooted environment. This ensures that calls to kern_path() in the
kernel resolves to paths that are relative to the nfsd root directory.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/include/workqueue.h |  4 ++
 support/misc/workqueue.c    | 78 +++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/support/include/workqueue.h b/support/include/workqueue.h
index 518be82f1b34..21b1ee6bc873 100644
--- a/support/include/workqueue.h
+++ b/support/include/workqueue.h
@@ -15,4 +15,8 @@ void xthread_work_run_sync(struct xthread_workqueue *wq,
 void xthread_workqueue_chroot(struct xthread_workqueue *wq,
 		const char *path);
 
+ssize_t xthread_read(struct xthread_workqueue *wq,
+		int fd, char *buf, size_t len);
+ssize_t xthread_write(struct xthread_workqueue *wq,
+		int fd, const char *buf, size_t len);
 #endif
diff --git a/support/misc/workqueue.c b/support/misc/workqueue.c
index b8d03446f2c7..9d967cef6547 100644
--- a/support/misc/workqueue.c
+++ b/support/misc/workqueue.c
@@ -1,3 +1,4 @@
+#include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
 
@@ -197,6 +198,72 @@ void xthread_workqueue_chroot(struct xthread_workqueue *wq,
 	xthread_work_run_sync(wq, xthread_workqueue_do_chroot, (void *)path);
 }
 
+struct xthread_read_data {
+	int fd;
+	char *buf;
+	size_t len;
+	ssize_t ret;
+	int err;
+};
+
+static void xthread_readfunc(void *data)
+{
+	struct xthread_read_data *d = data;
+
+	d->ret = read(d->fd, d->buf, d->len);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+ssize_t xthread_read(struct xthread_workqueue *wq,
+		int fd, char *buf, size_t len)
+{
+	struct xthread_read_data data = {
+		fd,
+		buf,
+		len,
+		0,
+		0
+	};
+	xthread_work_run_sync(wq, xthread_readfunc, &data);
+	if (data.ret < 0)
+		errno = data.err;
+	return data.ret;
+}
+
+struct xthread_write_data {
+	int fd;
+	const char *buf;
+	size_t len;
+	ssize_t ret;
+	int err;
+};
+
+static void xthread_writefunc(void *data)
+{
+	struct xthread_write_data *d = data;
+
+	d->ret = write(d->fd, d->buf, d->len);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+ssize_t xthread_write(struct xthread_workqueue *wq,
+		int fd, const char *buf, size_t len)
+{
+	struct xthread_write_data data = {
+		fd,
+		buf,
+		len,
+		0,
+		0
+	};
+	xthread_work_run_sync(wq, xthread_writefunc, &data);
+	if (data.ret < 0)
+		errno = data.err;
+	return data.ret;
+}
+
 #else
 
 struct xthread_workqueue {
@@ -225,4 +292,15 @@ void xthread_workqueue_chroot(struct xthread_workqueue *wq,
 	xlog_err("Unable to run as chroot");
 }
 
+ssize_t xthread_read(struct xthread_workqueue *wq,
+		int fd, char *buf, size_t len)
+{
+	return read(fd, buf, len);
+}
+
+ssize_t xthread_write(struct xthread_workqueue *wq,
+		int fd, const char *buf, size_t len)
+{
+	return write(fd, buf, len);
+}
 #endif /* defined(HAVE_SCHED_H) && defined(HAVE_LIBPTHREAD) && defined(HAVE_UNSHARE) */
-- 
2.21.0

