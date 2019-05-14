Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE331D0CF
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfENUp1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 16:45:27 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54152 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENUp0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 16:45:26 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so1140216ita.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJ2oJu2m41mvtp0KSs8FygA0nY0SUxW3tOHlG6cKRUs=;
        b=usjUnB4FJraPl2tebMK1JCpObS7OGu0j98kCNt1KfSnNltXGq5aY0u0vuhI7j3CvAq
         nJ3EcMb25qC2fn4WCb2KvZjnr5uWbEBVdSFmuEL7uFGmm5TCStTq7jOUEU4YbnwVwHs6
         sre5/rfM4RhMQUjGS3OtjZReJ55ODK8cG7mb2C5rWxVABv5d/0cEj7ET79AI2V4nCjU+
         cEsC04wjD6mTX4q+9r2W72Zl3x0uLcmCgYEXnyJx3G0NEFqFUGCID2h+JAF9PwijZlsu
         GYYEqAcNudkuP1+4J0bk3TTFzawspH3icpuFdQ5rFviMMB2t7rpXYC0PVmUUR0YInguV
         FgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJ2oJu2m41mvtp0KSs8FygA0nY0SUxW3tOHlG6cKRUs=;
        b=t8ev+Am3WwJk1E1oYZvbxCqCYlzsHLlOvWk+LAuqQFOCE19JGliWOp120V9EZQnUMK
         XPRemq99xvom1ad7t7dnloOzSL/DDtH+PMUgh/AHwL/tTDaw55MHlZvfITTZzN2FevcT
         krG35o2rRjKwsaVF1v3LxFbMp7fLSmCzgA0mY2ZsOJRolHUGxjKXig9YvqNO4rentcqu
         oxO6uwcsVXvYGK/+UzvuCzpt3Bv2v9BbX0rFJoeF/+ZIs54xWDZqJPToQc1o3zdgiQCk
         aSVwwWF+1atwDAQzb/IKGOG+QFBnWzgQ2PWM120A858k1ALesS9CtcJ4poteINKwsPiw
         KU7w==
X-Gm-Message-State: APjAAAUKdkFCxOFXMRaDs8bpziZqTZ3E0msNxhe9AbLkE50afhP8b1gs
        w+G9Z5srNbkcV2Jr84R+zQ==
X-Google-Smtp-Source: APXvYqz9FSjiwriqOGlwwy+RHmnq0NEDA+oFYrSG0mT07ayaSCdKqpunIBVJxKoBYqCnAL6/ErtATg==
X-Received: by 2002:a24:4585:: with SMTP id c5mr5490016itd.79.1557866725482;
        Tue, 14 May 2019 13:45:25 -0700 (PDT)
Received: from localhost.localdomain ([172.56.10.94])
        by smtp.gmail.com with ESMTPSA id r139sm64943ita.22.2019.05.14.13.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:45:24 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 3/5] Add a helper to write to a file through the chrooted thread
Date:   Tue, 14 May 2019 16:41:51 -0400
Message-Id: <20190514204153.79603-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514204153.79603-3-trond.myklebust@hammerspace.com>
References: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
 <20190514204153.79603-2-trond.myklebust@hammerspace.com>
 <20190514204153.79603-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/include/misc.h   |  2 ++
 support/misc/workqueue.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/support/include/misc.h b/support/include/misc.h
index 40fb9a37621a..0632df101bbb 100644
--- a/support/include/misc.h
+++ b/support/include/misc.h
@@ -28,6 +28,8 @@ void xthread_work_run_sync(struct xthread_workqueue *wq,
 		void (*fn)(void *), void *data);
 void xthread_workqueue_chroot(struct xthread_workqueue *wq,
 		const char *path);
+ssize_t xthread_write(struct xthread_workqueue *wq,
+		int fd, const char *buf, size_t len);
 
 /* size of the file pointer buffers for rpc procfs files */
 #define RPC_CHAN_BUF_SIZE 32768
diff --git a/support/misc/workqueue.c b/support/misc/workqueue.c
index 16e95e1f6c86..7af76a84e8dd 100644
--- a/support/misc/workqueue.c
+++ b/support/misc/workqueue.c
@@ -1,3 +1,4 @@
+#include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
 
@@ -197,6 +198,39 @@ void xthread_workqueue_chroot(struct xthread_workqueue *wq,
 	xthread_work_run_sync(wq, xthread_workqueue_do_chroot, (void *)path);
 }
 
+struct xthread_io_data {
+	int fd;
+	const char *buf;
+	size_t len;
+	ssize_t ret;
+	int err;
+};
+
+static void xthread_writefunc(void *data)
+{
+	struct xthread_io_data *d = data;
+
+	d->ret = write(d->fd, d->buf, d->len);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+ssize_t xthread_write(struct xthread_workqueue *wq,
+		int fd, const char *buf, size_t len)
+{
+	struct xthread_io_data data = {
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
@@ -225,4 +259,9 @@ void xthread_workqueue_chroot(struct xthread_workqueue *wq,
 	xlog(L_FATAL, "Unable to run as chroot");
 }
 
+ssize_t xthread_write(struct xthread_workqueue *wq,
+		int fd, const char *buf, size_t len)
+{
+	return write(fd, buf, len);
+}
 #endif /* defined(HAVE_SCHED_H) && defined(HAVE_LIBPTHREAD) && defined(HAVE_UNSHARE) */
-- 
2.21.0

