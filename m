Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D230724F2D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 14:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfEUMtQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 08:49:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54574 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfEUMtP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 08:49:15 -0400
Received: by mail-it1-f194.google.com with SMTP id h20so2156673itk.4
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4SlCwu18mEUGkbPDNHJL0EYP1qCKU4LYpKACHLEmVyE=;
        b=Cm9lkIj5p62oDQkGXMU3ZoUqr7YirTcegw+QLRsFhTDmJvIkqXPC/LbdcxI73FgtQO
         QVpSZ9dF6SlA2fyeWW/UyAGGgzJIBfAVh5gP2x9HNqGnEIbLwvSLTHs9LPe+d4WqCQl7
         EgTP07iZa9ly3UOSWG1JTmW/VuGcm9yrRoZh8952zUrFmV82PE2avGTdaRarD6RCfCGJ
         sfH2Puii3rynR9vC3yP37hTHwgCW1AtXbEo5+f4HtEWbZg7LODl+jmKUiT3lVbR/m8Rq
         1iJIfa+fd4R6e6f2K/BoX+O7TwPgG0B4OuBMyk6cItb+PXqO9wm9tI0YfTxczW9kb0Pv
         5cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SlCwu18mEUGkbPDNHJL0EYP1qCKU4LYpKACHLEmVyE=;
        b=mMuIvanw07qyLorh2IsQt8i5r5AVW+Dclo+KK/cPsJ/AwRBK3YnRQd7W5wnPg7orWM
         jUlbJ+GTuGh991gotOgsQ/g3oBipaL4ga7flOvbAyLDERxxp2n/zZXyzW9pstqztHJgI
         brKEuWQLxIKWDbhUICCm7w3RH4cAgTXhiiOAq8cevMDm5G6UJRNOpV9NFp8LHvKZTyoa
         6FXRbDi/Tfk3Lnj/W8SAnFX3QKjwDP6F/MxXJ63fU74u2Xf2m6EsVI1oxIf7rjlcioFg
         +Z4JPIvM3k7Yq/QNIKB1NOrVJtXVDsP9487clhRTLbHD9ugiAwwyZH8qK4GA0CHgIvaT
         t5PA==
X-Gm-Message-State: APjAAAXfqJ5pJn4Ts1zsoaMVr4LECsxu99LNwqmeJnJVgyrJkoa/E0Wy
        41Uu3iGoCx16lpW52v4PLQzs2Yc=
X-Google-Smtp-Source: APXvYqwVPCQh1aaM7HAJa01QSXY4Wgo5iHHC6INg4k5O5I4l2QH5taWqxmE7iUFoIxd35RtD+kboXQ==
X-Received: by 2002:a24:d613:: with SMTP id o19mr3476490itg.8.1558442954695;
        Tue, 21 May 2019 05:49:14 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v139sm1693180itb.25.2019.05.21.05.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:49:14 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 3/7] Add utilities for resolving nfsd paths and stat()ing them
Date:   Tue, 21 May 2019 08:46:57 -0400
Message-Id: <20190521124701.61849-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521124701.61849-3-trond.myklebust@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <20190521124701.61849-2-trond.myklebust@hammerspace.com>
 <20190521124701.61849-3-trond.myklebust@hammerspace.com>
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
 support/include/Makefile.am |   1 +
 support/include/nfsd_path.h |  17 ++++
 support/misc/Makefile.am    |   3 +-
 support/misc/nfsd_path.c    | 173 ++++++++++++++++++++++++++++++++++++
 5 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 support/include/nfsd_path.h
 create mode 100644 support/misc/nfsd_path.c

diff --git a/configure.ac b/configure.ac
index c6c2d73b06dd..4793daeb2716 100644
--- a/configure.ac
+++ b/configure.ac
@@ -321,7 +321,7 @@ AC_CHECK_FUNC([getservbyname], ,
 AC_CHECK_LIB([crypt], [crypt], [LIBCRYPT="-lcrypt"])
 
 AC_CHECK_HEADERS([sched.h], [], [])
-AC_CHECK_FUNCS([unshare], [] , [])
+AC_CHECK_FUNCS([unshare openat fstatat], [] , [])
 AC_LIBPTHREAD([])
 
 if test "$enable_nfsv4" = yes; then
diff --git a/support/include/Makefile.am b/support/include/Makefile.am
index df5e47836d29..fbf487eee0e2 100644
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
diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
new file mode 100644
index 000000000000..5936cd5ed666
--- /dev/null
+++ b/support/include/nfsd_path.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ */
+#ifndef XPATH_H
+#define XPATH_H
+
+void 		nfsd_path_init(void);
+void 		nfsd_path_nfsd_rootfs_close(void);
+
+const char *	nfsd_path_nfsd_rootdir(void);
+char *		nfsd_path_strip_root(char *pathname);
+char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
+
+int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
+int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
+
+#endif
diff --git a/support/misc/Makefile.am b/support/misc/Makefile.am
index d0bff8feb6ae..ff1e8ab79ae3 100644
--- a/support/misc/Makefile.am
+++ b/support/misc/Makefile.am
@@ -1,6 +1,7 @@
 ## Process this file with automake to produce Makefile.in
 
 noinst_LIBRARIES = libmisc.a
-libmisc_a_SOURCES = tcpwrapper.c from_local.c mountpoint.c file.c workqueue.c
+libmisc_a_SOURCES = tcpwrapper.c from_local.c mountpoint.c file.c \
+		    nfsd_path.c workqueue.c
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
new file mode 100644
index 000000000000..481ba49a38fd
--- /dev/null
+++ b/support/misc/nfsd_path.c
@@ -0,0 +1,173 @@
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "config.h"
+#include "conffile.h"
+#include "xmalloc.h"
+#include "xlog.h"
+#include "nfsd_path.h"
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
+	rootdir = nfsd_path_strip(conf_get_str("nfsd", "root_dir"));
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
+#if defined(HAVE_FSTATAT) && defined(HAVE_OPENAT)
+static int nfsd_rootfs = AT_FDCWD;
+
+void nfsd_path_nfsd_rootfs_close(void)
+{
+	if (nfsd_rootfs != AT_FDCWD) {
+		close(nfsd_rootfs);
+		nfsd_rootfs = AT_FDCWD;
+	}
+}
+
+void nfsd_path_init(void)
+{
+	const char *rootdir = nfsd_path_nfsd_rootdir();
+
+	nfsd_path_nfsd_rootfs_close();
+	if (rootdir) {
+		nfsd_rootfs = openat(AT_FDCWD, rootdir, O_PATH);
+		if (nfsd_rootfs == -1)
+			xlog_err("Could not open directory %s: %m", rootdir);
+	}
+}
+
+int nfsd_path_stat(const char *pathname, struct stat *statbuf)
+{
+	if (nfsd_rootfs != AT_FDCWD) {
+		while (pathname[0] == '/')
+			pathname++;
+	}
+	return fstatat(nfsd_rootfs, pathname, statbuf, AT_EMPTY_PATH |
+			AT_NO_AUTOMOUNT);
+}
+
+int nfsd_path_lstat(const char *pathname, struct stat *statbuf)
+{
+	if (nfsd_rootfs != AT_FDCWD) {
+		while (pathname[0] == '/')
+			pathname++;
+	}
+	return fstatat(nfsd_rootfs, pathname, statbuf, AT_EMPTY_PATH |
+			AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW);
+}
+
+#else /* defined(HAVE_FSTATAT) && defined(HAVE_OPENAT) */
+void nfsd_path_init(void)
+{
+}
+
+void nfsd_path_nfsd_rootfs_close(void)
+{
+}
+
+int nfsd_path_stat(const char *pathname, struct stat *statbuf)
+{
+	const char *rootdir = nfsd_path_nfsd_rootdir();
+	char *str;
+	int ret;
+
+	if (!rootdir)
+		goto out_stat;
+	str = nfsd_path_prepend_dir(rootdir, nfsd_path_strip(pathname));
+	if (!str)
+		goto out_stat;
+	ret = stat(str, statbuf);
+	xfree(str);
+	return ret;
+out_stat:
+	return stat(pathname, statbuf);
+}
+
+int nfsd_path_lstat(const char *pathname, struct stat *statbuf)
+{
+	const char *rootdir = nfsd_path_nfsd_rootdir();
+	char *str;
+	int ret;
+
+	if (!rootdir)
+		goto out_lstat;
+	str = nfsd_path_prepend_dir(rootdir, nfsd_path_strip(pathname));
+	if (!str)
+		goto out_lstat;
+	ret = lstat(str, statbuf);
+	xfree(str);
+	return ret;
+out_lstat:
+	return lstat(pathname, statbuf);
+}
+#endif
-- 
2.21.0

