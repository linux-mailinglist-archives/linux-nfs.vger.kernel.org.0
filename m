Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282C51D0CE
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfENUp0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 16:45:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38714 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENUpZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 16:45:25 -0400
Received: by mail-it1-f194.google.com with SMTP id i63so1021069ita.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eg7MpNFkzhEOUSAGGmk4fFCaObC0r4PIPOBA3yJuZPk=;
        b=f1q0CKCXpcH2EToT+VT2xquLmNF3+LpTAgdm3Wm+B32O+uaAqATf0qTaKgnlnqfE7y
         5iN/NVPCo93c4qLJX7aIlqJLWtr7W8/hnudq+Xz0s4igT1MKWIAUF6HU+ClVSOiK1Nwo
         aGc/ZZlf//3SOh3oF4Kk9ADVC7RdrMcTXMROqf6F36J611qhj2zFSAUQGQNtlJH4eEfR
         PlIOd8m1CwwxaYGPXi+2bm0yB4Qw0njMrwHg20RGJvlmbGzy5EGJnXUqRKbDz+/QJ3PH
         cubgR8SAtxSTk8aCuZyD1gS5U6+plIMOarz1I8fcqX6Y0kGeBEaXOrZfGBhFZMvrAqei
         pZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eg7MpNFkzhEOUSAGGmk4fFCaObC0r4PIPOBA3yJuZPk=;
        b=VUt/MYMmokPSfqbFc/Ke2NqUp+KoZFh+cOn7Vb5eZU3nq2APEdiaKV40Z6+0jj7Vvn
         c/+BXlZHU6DFDzwH0d+FM/N88gGSuzUQyGDvOwwnYHe4KiD0f30sI/EVsdtkzbPpjnc0
         kb7EcCqpybUxPgwb4gEsc7YEI9EiDzxUhAQZ3B5f+OKHD4BwNF/S5kn90feFjKDmHKU/
         4wSfZpoEUy5nmNWFtnfNs64AvTfACOqdO1I3saVZWePQYK3s6DZst8SO/JgLJnCHbw5g
         L9GMxAeILTG2Rtl3OjGfZGvBckyl+8VmVp6gA9zi3kGvxdS8pv1Yq7kZ6+X9pZCobwr1
         uHAw==
X-Gm-Message-State: APjAAAUwfTkqfDX8ofvbcFc5A1stjWv7PVktiqXVvJVyvGmGxfT8107i
        uNN9BD7dHS/AYiQNvrJaJfWB4tg=
X-Google-Smtp-Source: APXvYqyajIK3CE8JuxrbGS3sFyp74p3tFNICN2JaNqdYD1Vwsp6voHWXUj1g1YDVOIp5Itoc1kwrJw==
X-Received: by 2002:a24:9486:: with SMTP id j128mr5180042ite.94.1557866724299;
        Tue, 14 May 2019 13:45:24 -0700 (PDT)
Received: from localhost.localdomain ([172.56.10.94])
        by smtp.gmail.com with ESMTPSA id r139sm64943ita.22.2019.05.14.13.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:45:23 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 2/5] Add a simple workqueue mechanism
Date:   Tue, 14 May 2019 16:41:50 -0400
Message-Id: <20190514204153.79603-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514204153.79603-2-trond.myklebust@hammerspace.com>
References: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
 <20190514204153.79603-2-trond.myklebust@hammerspace.com>
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
 aclocal/libpthread.m4    |  13 +--
 configure.ac             |   6 +-
 support/include/misc.h   |   9 ++
 support/misc/Makefile.am |   2 +-
 support/misc/workqueue.c | 228 +++++++++++++++++++++++++++++++++++++++
 utils/mountd/Makefile.am |   3 +-
 6 files changed, 252 insertions(+), 9 deletions(-)
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
diff --git a/support/include/misc.h b/support/include/misc.h
index 06e2a0c7b061..40fb9a37621a 100644
--- a/support/include/misc.h
+++ b/support/include/misc.h
@@ -20,6 +20,15 @@ _Bool generic_setup_basedir(const char *, const char *, char *, const size_t);
 
 extern int is_mountpoint(char *path);
 
+/* Naive stack implementation */
+struct xthread_workqueue;
+struct xthread_workqueue *xthread_workqueue_alloc(void);
+void xthread_workqueue_shutdown(struct xthread_workqueue *wq);
+void xthread_work_run_sync(struct xthread_workqueue *wq,
+		void (*fn)(void *), void *data);
+void xthread_workqueue_chroot(struct xthread_workqueue *wq,
+		const char *path);
+
 /* size of the file pointer buffers for rpc procfs files */
 #define RPC_CHAN_BUF_SIZE 32768
 
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
index 000000000000..16e95e1f6c86
--- /dev/null
+++ b/support/misc/workqueue.c
@@ -0,0 +1,228 @@
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "config.h"
+#include "misc.h"
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
+		xlog(L_FATAL, "unshare() failed: %m");
+		return;
+	}
+	if (chroot(path) != 0)
+		xlog(L_FATAL, "chroot() failed: %m");
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
+	xlog(L_FATAL, "Unable to run as chroot");
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

