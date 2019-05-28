Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7932D06F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfE1Udg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42047 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfE1Udf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:35 -0400
Received: by mail-io1-f66.google.com with SMTP id g16so16904000iom.9
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XqEpVzB6pdIBPKKe3DYeMe1MU19xVZqtRve9/VfUHc=;
        b=iQ6I35QK3hPJCfSvb0yUaES4rKWOUrIb+vx2XV5zZTtmCptxKIo3INyGkHUKfZ5FQ8
         mscTHJVCdHj+xbkYZ5RmWRtc7QWkLAO+fjlethW4ft8QfXMEap+oy3/ftpdhqHovEeZO
         /LuqKs1KGnNQ9qGnMqI6VZubcH4r45J7KYwNm8LvQeFHZLai61dmOEZ6olLrdUidydbX
         6RQbGj0dRgwqKVM96JLUcQPXAhwzBNJQceEYhQpSh1DXdqc7GPErvK627LgTfxzM/zI5
         Wl36QmuUF2cMM8C9WLdBM4vo185c0e08eIDDt13pctxDx01YmuGaSNfJ3iAJSwMgj3ul
         vmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XqEpVzB6pdIBPKKe3DYeMe1MU19xVZqtRve9/VfUHc=;
        b=lzDCIFxWzxjQLi8NnFpqIPnWLrKJ7OXFNMkiTTMtalcEXoXRrBW2zl3cUDxo1h1VHS
         +pIQuwUt3icSEdcdfG/vRmzZnR26PtJs96oJZAwAO9ZLeeZ2/EfFjp9hrZBL4uTzJCQM
         i7TXLpX1tk+XTNxVvNG1vq7KNCqvjVM2vr9QFAhqBzA5Ah+uvkzFmuzAD0Q50o9M7JaI
         lJM1SaMTGTsTgyXFfNPSF396mPBLiIoeCmveS9+9XTQ1t36257pZgh5lTz7ieH/OANhe
         uSCaGoOU0SLPweqGEg/QCsb9PrTcxxLcVbnvF55DLgUooBGvN52ecaIWzllPfCCNjTG0
         My2A==
X-Gm-Message-State: APjAAAURJ1n2qOlYsXhZdtb+B9zpCCoGlps/+IlRd6o1oGGwcsnAZGxm
        M6oi3vIn/hLWD01Bo41QbBWcSo4=
X-Google-Smtp-Source: APXvYqwi7mklIZla9K+l5hI73gwd6F6x57dE08C05vnf2MWJUUVmlGbWL8T0sTOzmFfgV676Oket7Q==
X-Received: by 2002:a6b:fb09:: with SMTP id h9mr8636285iog.19.1559075614547;
        Tue, 28 May 2019 13:33:34 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:33 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 04/11] Add utilities for resolving nfsd paths and stat()ing them
Date:   Tue, 28 May 2019 16:31:15 -0400
Message-Id: <20190528203122.11401-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-4-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add helper functions that can resolve nfsd paths by prepending the
necessary prefix if the admin has specified a root path in the
nfs.conf file.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 configure.ac                |   2 +-
 support/include/Makefile.am |   2 +
 support/include/nfsd_path.h |  16 ++++
 support/include/xstat.h     |  11 +++
 support/misc/Makefile.am    |   3 +-
 support/misc/nfsd_path.c    | 168 ++++++++++++++++++++++++++++++++++++
 support/misc/xstat.c        |  33 +++++++
 7 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100644 support/include/nfsd_path.h
 create mode 100644 support/include/xstat.h
 create mode 100644 support/misc/nfsd_path.c
 create mode 100644 support/misc/xstat.c

diff --git a/configure.ac b/configure.ac
index c6c2d73b06dd..e870862a8abb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -321,7 +321,7 @@ AC_CHECK_FUNC([getservbyname], ,
 AC_CHECK_LIB([crypt], [crypt], [LIBCRYPT="-lcrypt"])
 
 AC_CHECK_HEADERS([sched.h], [], [])
-AC_CHECK_FUNCS([unshare], [] , [])
+AC_CHECK_FUNCS([unshare fstatat], [] , [])
 AC_LIBPTHREAD([])
 
 if test "$enable_nfsv4" = yes; then
diff --git a/support/include/Makefile.am b/support/include/Makefile.am
index df5e47836d29..1373891a7c76 100644
--- a/support/include/Makefile.am
+++ b/support/include/Makefile.am
@@ -10,6 +10,7 @@ noinst_HEADERS = \
 	misc.h \
 	nfs_mntent.h \
 	nfs_paths.h \
+	nfsd_path.h \
 	nfslib.h \
 	nfsrpc.h \
 	nls.h \
@@ -24,6 +25,7 @@ noinst_HEADERS = \
 	xlog.h \
 	xmalloc.h \
 	xcommon.h \
+	xstat.h \
 	conffile.h
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
new file mode 100644
index 000000000000..db9b41a179ad
--- /dev/null
+++ b/support/include/nfsd_path.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ */
+#ifndef NFSD_PATH_H
+#define NFSD_PATH_H
+
+void 		nfsd_path_init(void);
+
+const char *	nfsd_path_nfsd_rootdir(void);
+char *		nfsd_path_strip_root(char *pathname);
+char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
+
+int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
+int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
+
+#endif
diff --git a/support/include/xstat.h b/support/include/xstat.h
new file mode 100644
index 000000000000..f1241bbfdc0e
--- /dev/null
+++ b/support/include/xstat.h
@@ -0,0 +1,11 @@
+/*
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ */
+#ifndef XSTAT_H
+#define XSTAT_H
+
+struct stat;
+
+int xlstat(const char *pathname, struct stat *statbuf);
+int xstat(const char *pathname, struct stat *statbuf);
+#endif
diff --git a/support/misc/Makefile.am b/support/misc/Makefile.am
index d0bff8feb6ae..f9993e3ac897 100644
--- a/support/misc/Makefile.am
+++ b/support/misc/Makefile.am
@@ -1,6 +1,7 @@
 ## Process this file with automake to produce Makefile.in
 
 noinst_LIBRARIES = libmisc.a
-libmisc_a_SOURCES = tcpwrapper.c from_local.c mountpoint.c file.c workqueue.c
+libmisc_a_SOURCES = tcpwrapper.c from_local.c mountpoint.c file.c \
+		    nfsd_path.c workqueue.c xstat.c
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
new file mode 100644
index 000000000000..fe2c011b1521
--- /dev/null
+++ b/support/misc/nfsd_path.c
@@ -0,0 +1,168 @@
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "config.h"
+#include "conffile.h"
+#include "xmalloc.h"
+#include "xlog.h"
+#include "xstat.h"
+#include "nfsd_path.h"
+#include "workqueue.h"
+
+static struct xthread_workqueue *nfsd_wq;
+
+static int
+nfsd_path_isslash(const char *path)
+{
+	return path[0] == '/' && path[1] == '/';
+}
+
+static int
+nfsd_path_isdot(const char *path)
+{
+	return path[0] == '.' && path[1] == '/';
+}
+
+static const char *
+nfsd_path_strip(const char *path)
+{
+	if (!path || *path == '\0')
+		goto out;
+	for (;;) {
+		if (nfsd_path_isslash(path)) {
+			path++;
+			continue;
+		}
+		if (nfsd_path_isdot(path)) {
+			path += 2;
+			continue;
+		}
+		break;
+	}
+out:
+	return path;
+}
+
+const char *
+nfsd_path_nfsd_rootdir(void)
+{
+	const char *rootdir;
+
+	rootdir = nfsd_path_strip(conf_get_str("exports", "rootdir"));
+	if (!rootdir || rootdir[0] ==  '\0')
+		return NULL;
+	if (rootdir[0] == '/' && rootdir[1] == '\0')
+		return NULL;
+	return rootdir;
+}
+
+char *
+nfsd_path_strip_root(char *pathname)
+{
+	const char *dir = nfsd_path_nfsd_rootdir();
+	char *ret;
+
+	ret = strstr(pathname, dir);
+	if (!ret || ret != pathname)
+		return pathname;
+	return pathname + strlen(dir);
+}
+
+char *
+nfsd_path_prepend_dir(const char *dir, const char *pathname)
+{
+	size_t len, dirlen;
+	char *ret;
+
+	dirlen = strlen(dir);
+	while (dirlen > 0 && dir[dirlen - 1] == '/')
+		dirlen--;
+	if (!dirlen)
+		return NULL;
+	len = dirlen + strlen(pathname) + 1;
+	ret = xmalloc(len + 1);
+	snprintf(ret, len, "%.*s/%s", (int)dirlen, dir, pathname);
+	return ret;
+}
+
+static void
+nfsd_setup_workqueue(void)
+{
+	const char *rootdir = nfsd_path_nfsd_rootdir();
+
+	if (!rootdir)
+		return;
+	nfsd_wq = xthread_workqueue_alloc();
+	if (!nfsd_wq)
+		return;
+	xthread_workqueue_chroot(nfsd_wq, rootdir);
+}
+
+void
+nfsd_path_init(void)
+{
+	nfsd_setup_workqueue();
+}
+
+struct nfsd_stat_data {
+	const char *pathname;
+	struct stat *statbuf;
+	int ret;
+	int err;
+};
+
+static void
+nfsd_statfunc(void *data)
+{
+	struct nfsd_stat_data *d = data;
+
+	d->ret = xstat(d->pathname, d->statbuf);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+static void
+nfsd_lstatfunc(void *data)
+{
+	struct nfsd_stat_data *d = data;
+
+	d->ret = xlstat(d->pathname, d->statbuf);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+static int
+nfsd_run_stat(struct xthread_workqueue *wq,
+		void (*func)(void *),
+		const char *pathname,
+		struct stat *statbuf)
+{
+	struct nfsd_stat_data data = {
+		pathname,
+		statbuf,
+		0,
+		0
+	};
+	xthread_work_run_sync(wq, func, &data);
+	if (data.ret < 0)
+		errno = data.err;
+	return data.ret;
+}
+
+int
+nfsd_path_stat(const char *pathname, struct stat *statbuf)
+{
+	if (!nfsd_wq)
+		return xstat(pathname, statbuf);
+	return nfsd_run_stat(nfsd_wq, nfsd_statfunc, pathname, statbuf);
+}
+
+int
+nfsd_path_lstat(const char *pathname, struct stat *statbuf)
+{
+	if (!nfsd_wq)
+		return xlstat(pathname, statbuf);
+	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
+}
diff --git a/support/misc/xstat.c b/support/misc/xstat.c
new file mode 100644
index 000000000000..d092f73dfd65
--- /dev/null
+++ b/support/misc/xstat.c
@@ -0,0 +1,33 @@
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "config.h"
+#include "xstat.h"
+
+#ifdef HAVE_FSTATAT
+
+int xlstat(const char *pathname, struct stat *statbuf)
+{
+	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT |
+			AT_SYMLINK_NOFOLLOW);
+}
+
+int xstat(const char *pathname, struct stat *statbuf)
+{
+	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT);
+}
+
+#else
+
+int xlstat(const char *pathname, struct stat *statbuf)
+{
+	return lstat(pathname, statbuf);
+}
+
+int xstat(const char *pathname, struct stat *statbuf)
+{
+	return stat(pathname, statbuf);
+}
+#endif
-- 
2.21.0

