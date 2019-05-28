Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9642D06D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfE1Ude (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40367 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfE1Ude (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:34 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so10767088ioc.7
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTJIEF64GQ5WaLkZVqyDs/M6F2K2o7LdsId5gPgoX24=;
        b=GOGqf0dc+EiLh3kOA0ZdMppBUs7iVSudCTGNZAV+K5UTDY4h5GKcZxtx94w7abl7E3
         a7i2OGTLIzpCw96AXguw4DpZ5qIJ22+G+Rf0vqqj2Dr3V61Qm5QcDJITv+GvPU1IQ7i3
         beq5oego4xk+40LjqhiAs5gJd9zi3Hfs6aiP5ENmL6P8NvP4hQjSCzu+/lA3b94xq4oQ
         Pd6wOCOSOxR8Mj6ojSGJA8xjfUXDayJEIXmNt97mZkh5WGtlDMMlh6fVQ2pyiXDK4ONY
         IeUl6Sj8MEgXvVWGLHPmYIJpIm5pmg0uZ3Zu0xzE20jfo3mXwGiNoWsxOjBHHiGZ7efh
         tU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTJIEF64GQ5WaLkZVqyDs/M6F2K2o7LdsId5gPgoX24=;
        b=DRGfam5q8JpusxO/sF/8nR88dfc5RRGqgZNGXtqTenmM2QCCTlxDJkoYDvcG7H+lYJ
         /Pte+VuOoZjnwoDHvkRC1/6/fAIPOmIxnc/m90oslNXtN30XU8W+grqfTmhyJwlbaoQO
         a6pUfCsQ64s3Awrs8hT09r/C2AHQ90tLuqWIIBkjeiJKsFWS31QNA+1989Tx7kbrbaRd
         ghP3RdjDBqemP/yGXWQwR4i0ZUAhwjtNv0m7QzsDchkal/4fV9oZmv79oABgiyZpBUNP
         4jUrpKCSZ5XVOXPqG7jzpf31z4yMKlturfFXunZlk4/Ayh0rqzySPIfeIE4cIr4Y+fGi
         0LHw==
X-Gm-Message-State: APjAAAUKhiYAirVF6HbCR3SO+Q752WdKPzOOGY7mPYEwV3+HKCLtTVZ2
        Ud8jxEp991Zawj4vHGySQQ==
X-Google-Smtp-Source: APXvYqzEN+PdZOBI8vhXTKA/UHcUJziAmxF8HB8PMFVCDx6VygaDXNuKJhHnbUMSRwQTUQ8AemXCeA==
X-Received: by 2002:a5d:968e:: with SMTP id m14mr40478686ion.49.1559075612399;
        Tue, 28 May 2019 13:33:32 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:31 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 02/11] Add a simple workqueue mechanism
Date:   Tue, 28 May 2019 16:31:13 -0400
Message-Id: <20190528203122.11401-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-2-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a simple workqueue mechanism to allow us to run threads that are
subject to chroot(), and have them operate on the knfsd kernel daemon.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 aclocal/libpthread.m4       |  13 +-
 configure.ac                |   6 +-
 support/include/Makefile.am |   1 +
 support/include/workqueue.h |  18 +++
 support/misc/Makefile.am    |   2 +-
 support/misc/workqueue.c    | 228 ++++++++++++++++++++++++++++++++++++
 utils/mountd/Makefile.am    |   3 +-
 7 files changed, 262 insertions(+), 9 deletions(-)
 create mode 100644 support/include/workqueue.h
 create mode 100644 support/misc/workqueue.c

diff --git a/aclocal/libpthread.m4 b/aclocal/libpthread.m4
index e87d2a0c2dc5..55e046e38cd1 100644
--- a/aclocal/libpthread.m4
+++ b/aclocal/libpthread.m4
@@ -3,11 +3,12 @@ dnl
 AC_DEFUN([AC_LIBPTHREAD], [
 
     dnl Check for library, but do not add -lpthreads to LIBS
-    AC_CHECK_LIB([pthread], [pthread_create], [LIBPTHREAD=-lpthread],
-                 [AC_MSG_ERROR([libpthread not found.])])
-  AC_SUBST(LIBPTHREAD)
-
-  AC_CHECK_HEADERS([pthread.h], ,
-                   [AC_MSG_ERROR([libpthread headers not found.])])
+    AC_CHECK_LIB([pthread], [pthread_create],
+		[AC_DEFINE([HAVE_LIBPTHREAD], [1],
+				[Define to 1 if you have libpthread.])
+		AC_CHECK_HEADERS([pthread.h], [],
+				[AC_MSG_ERROR([libpthread headers not found.])])
+		 AC_SUBST([LIBPTHREAD],[-lpthread])],
+                 [$1])
 
 ])dnl
diff --git a/configure.ac b/configure.ac
index 4d7096193d0b..c6c2d73b06dd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -320,6 +320,10 @@ AC_CHECK_FUNC([getservbyname], ,
 
 AC_CHECK_LIB([crypt], [crypt], [LIBCRYPT="-lcrypt"])
 
+AC_CHECK_HEADERS([sched.h], [], [])
+AC_CHECK_FUNCS([unshare], [] , [])
+AC_LIBPTHREAD([])
+
 if test "$enable_nfsv4" = yes; then
   dnl check for libevent libraries and headers
   AC_LIBEVENT
@@ -417,7 +421,7 @@ if test "$enable_gss" = yes; then
   AC_KERBEROS_V5
 
   dnl Check for pthreads
-  AC_LIBPTHREAD
+  AC_LIBPTHREAD([AC_MSG_ERROR([libpthread not found.])])
 
   dnl librpcsecgss already has a dependency on libgssapi,
   dnl but we need to make sure we get the right version
diff --git a/support/include/Makefile.am b/support/include/Makefile.am
index 599f500e2b40..df5e47836d29 100644
--- a/support/include/Makefile.am
+++ b/support/include/Makefile.am
@@ -19,6 +19,7 @@ noinst_HEADERS = \
 	sockaddr.h \
 	tcpwrapper.h \
 	v4root.h \
+	workqueue.h \
 	xio.h \
 	xlog.h \
 	xmalloc.h \
diff --git a/support/include/workqueue.h b/support/include/workqueue.h
new file mode 100644
index 000000000000..518be82f1b34
--- /dev/null
+++ b/support/include/workqueue.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ */
+#ifndef WORKQUEUE_H
+#define WORKQUEUE_H
+
+struct xthread_workqueue;
+
+struct xthread_workqueue *xthread_workqueue_alloc(void);
+void xthread_workqueue_shutdown(struct xthread_workqueue *wq);
+
+void xthread_work_run_sync(struct xthread_workqueue *wq,
+		void (*fn)(void *), void *data);
+
+void xthread_workqueue_chroot(struct xthread_workqueue *wq,
+		const char *path);
+
+#endif
diff --git a/support/misc/Makefile.am b/support/misc/Makefile.am
index 8936b0d64e45..d0bff8feb6ae 100644
--- a/support/misc/Makefile.am
+++ b/support/misc/Makefile.am
@@ -1,6 +1,6 @@
 ## Process this file with automake to produce Makefile.in
 
 noinst_LIBRARIES = libmisc.a
-libmisc_a_SOURCES = tcpwrapper.c from_local.c mountpoint.c file.c
+libmisc_a_SOURCES = tcpwrapper.c from_local.c mountpoint.c file.c workqueue.c
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/support/misc/workqueue.c b/support/misc/workqueue.c
new file mode 100644
index 000000000000..b8d03446f2c7
--- /dev/null
+++ b/support/misc/workqueue.c
@@ -0,0 +1,228 @@
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "config.h"
+#include "workqueue.h"
+#include "xlog.h"
+
+#if defined(HAVE_SCHED_H) && defined(HAVE_LIBPTHREAD) && defined(HAVE_UNSHARE)
+#include <sched.h>
+#include <pthread.h>
+
+struct xwork_struct {
+	struct xwork_struct *next;
+	void (*fn)(void *);
+	void *data;
+};
+
+struct xwork_queue {
+	struct xwork_struct *head;
+	struct xwork_struct **tail;
+
+	unsigned char shutdown : 1;
+};
+
+static void xwork_queue_init(struct xwork_queue *queue)
+{
+	queue->head = NULL;
+	queue->tail = &queue->head;
+	queue->shutdown = 0;
+}
+
+static void xwork_enqueue(struct xwork_queue *queue,
+		struct xwork_struct *entry)
+{
+	entry->next = NULL;
+	*queue->tail = entry;
+	queue->tail = &entry->next;
+}
+
+static struct xwork_struct *xwork_dequeue(struct xwork_queue *queue)
+{
+	struct xwork_struct *entry = NULL;
+	if (queue->head) {
+		entry = queue->head;
+		queue->head = entry->next;
+		if (!queue->head)
+			queue->tail = &queue->head;
+	}
+	return entry;
+}
+
+struct xthread_work {
+	struct xwork_struct work;
+
+	pthread_cond_t cond;
+};
+
+struct xthread_workqueue {
+	struct xwork_queue queue;
+
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+};
+
+static void xthread_workqueue_init(struct xthread_workqueue *wq)
+{
+	xwork_queue_init(&wq->queue);
+	pthread_mutex_init(&wq->mutex, NULL);
+	pthread_cond_init(&wq->cond, NULL);
+}
+
+static void xthread_workqueue_fini(struct xthread_workqueue *wq)
+{
+	pthread_cond_destroy(&wq->cond);
+	pthread_mutex_destroy(&wq->mutex);
+}
+
+static int xthread_work_enqueue(struct xthread_workqueue *wq,
+		struct xthread_work *work)
+{
+	xwork_enqueue(&wq->queue, &work->work);
+	pthread_cond_signal(&wq->cond);
+	return 0;
+}
+
+static struct xthread_work *xthread_work_dequeue(struct xthread_workqueue *wq)
+{
+	return (struct xthread_work *)xwork_dequeue(&wq->queue);
+}
+
+static void xthread_workqueue_do_work(struct xthread_workqueue *wq)
+{
+	struct xthread_work *work;
+
+	pthread_mutex_lock(&wq->mutex);
+	/* Signal the caller that we're up and running */
+	pthread_cond_signal(&wq->cond);
+	for (;;) {
+		work = xthread_work_dequeue(wq);
+		if (work) {
+			work->work.fn(work->work.data);
+			pthread_cond_signal(&work->cond);
+			continue;
+		}
+		if (wq->queue.shutdown)
+			break;
+		pthread_cond_wait(&wq->cond, &wq->mutex);
+	}
+	pthread_mutex_unlock(&wq->mutex);
+}
+
+void xthread_workqueue_shutdown(struct xthread_workqueue *wq)
+{
+	pthread_mutex_lock(&wq->mutex);
+	wq->queue.shutdown = 1;
+	pthread_cond_signal(&wq->cond);
+	pthread_mutex_unlock(&wq->mutex);
+}
+
+static void xthread_workqueue_free(struct xthread_workqueue *wq)
+{
+	xthread_workqueue_fini(wq);
+	free(wq);
+}
+
+static void xthread_workqueue_cleanup(void *data)
+{
+	xthread_workqueue_free(data);
+}
+
+static void *xthread_workqueue_worker(void *data)
+{
+	pthread_cleanup_push(xthread_workqueue_cleanup, data);
+	xthread_workqueue_do_work(data);
+	pthread_cleanup_pop(1);
+	return NULL;
+}
+
+struct xthread_workqueue *xthread_workqueue_alloc(void)
+{
+	struct xthread_workqueue *ret;
+	pthread_t thread;
+
+	ret = malloc(sizeof(*ret));
+	if (ret) {
+		xthread_workqueue_init(ret);
+
+		pthread_mutex_lock(&ret->mutex);
+		if (pthread_create(&thread, NULL,
+					xthread_workqueue_worker,
+					ret) == 0) {
+			/* Wait for thread to start */
+			pthread_cond_wait(&ret->cond, &ret->mutex);
+			pthread_mutex_unlock(&ret->mutex);
+			return ret;
+		}
+		pthread_mutex_unlock(&ret->mutex);
+		xthread_workqueue_free(ret);
+		ret = NULL;
+	}
+	return NULL;
+}
+
+void xthread_work_run_sync(struct xthread_workqueue *wq,
+		void (*fn)(void *), void *data)
+{
+	struct xthread_work work = {
+		{
+			NULL,
+			fn,
+			data
+		},
+		PTHREAD_COND_INITIALIZER,
+	};
+	pthread_mutex_lock(&wq->mutex);
+	xthread_work_enqueue(wq, &work);
+	pthread_cond_wait(&work.cond, &wq->mutex);
+	pthread_mutex_unlock(&wq->mutex);
+	pthread_cond_destroy(&work.cond);
+}
+
+static void xthread_workqueue_do_chroot(void *data)
+{
+	const char *path = data;
+
+	if (unshare(CLONE_FS) != 0) {
+		xlog_err("unshare() failed: %m");
+		return;
+	}
+	if (chroot(path) != 0)
+		xlog_err("chroot() failed: %m");
+}
+
+void xthread_workqueue_chroot(struct xthread_workqueue *wq,
+		const char *path)
+{
+	xthread_work_run_sync(wq, xthread_workqueue_do_chroot, (void *)path);
+}
+
+#else
+
+struct xthread_workqueue {
+};
+
+static struct xthread_workqueue ret;
+
+struct xthread_workqueue *xthread_workqueue_alloc(void)
+{
+	return &ret;
+}
+
+void xthread_workqueue_shutdown(struct xthread_workqueue *wq)
+{
+}
+
+void xthread_work_run_sync(struct xthread_workqueue *wq,
+		void (*fn)(void *), void *data)
+{
+	fn(data);
+}
+
+void xthread_workqueue_chroot(struct xthread_workqueue *wq,
+		const char *path)
+{
+	xlog_err("Unable to run as chroot");
+}
+
+#endif /* defined(HAVE_SCHED_H) && defined(HAVE_LIBPTHREAD) && defined(HAVE_UNSHARE) */
diff --git a/utils/mountd/Makefile.am b/utils/mountd/Makefile.am
index 73eeb3f35070..18610f18238c 100644
--- a/utils/mountd/Makefile.am
+++ b/utils/mountd/Makefile.am
@@ -19,7 +19,8 @@ mountd_LDADD = ../../support/export/libexport.a \
 	       ../../support/nfs/libnfs.la \
 	       ../../support/misc/libmisc.a \
 	       $(OPTLIBS) \
-	       $(LIBBSD) $(LIBWRAP) $(LIBNSL) $(LIBBLKID) $(LIBTIRPC)
+	       $(LIBBSD) $(LIBWRAP) $(LIBNSL) $(LIBBLKID) $(LIBTIRPC) \
+	       $(LIBPTHREAD)
 mountd_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) \
 		  -I$(top_builddir)/support/include \
 		  -I$(top_srcdir)/support/export
-- 
2.21.0

