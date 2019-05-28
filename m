Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95512D070
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfE1Udg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54342 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfE1Udg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:36 -0400
Received: by mail-it1-f195.google.com with SMTP id h20so6577788itk.4
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3/TxchU2n2gzIYFsg7JMYu+zzAMXglufU3zmYXuRPo=;
        b=W6Rif6RO7xt43y6PWH7P/ll2Lp2yUXIRb2NfC3F9gc656KzDaCGYJoYnZo3gE6yhPS
         UzLAQpG+PJmNLTOc6J19QJSJDIJoHSA0vatEG2ORML9xswcPrxasmdcJhrTGnQGaioUU
         ygCpybsoNc1EjlRlqvyum9dlM0YyPuvThN9Gpop+yGQffSHO43x/t/oVunTc4O2qIHCf
         kGmTJtlIZi2QFm1bUKUt1nmZugvmUUVbZ40uOO1qdqlV+kaTRHTF+eH3v5ds58XqciEX
         SBygKHzzndGQq/nKVNwP27Wc/6kimpZiLQ7pJhH/eu1aGT3MI9R9lTtAWJll48pT7Kja
         yxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3/TxchU2n2gzIYFsg7JMYu+zzAMXglufU3zmYXuRPo=;
        b=oGyqAV23nR139CYwKjkFM78/VZieDAY4TybQRryrXLUeVLUmNC1rYVefiNJHg1eBoe
         6AB6kJJpD4+hZqWKxVb8igUQQDO7ZJ4bpfH48cY5nnCsk4aX800M1VBNFIAwctZLv0qC
         Tbu8xkdMAMYEVj40B8L81teR/gDBBPSQwFvuS/dyGglxwdXNBj0JeCaHMTA1plgB5QgY
         w+G/x9Aw0UUS0yUrGD8gMC5SZHJQsuSUNKWp+6i4ZT8KJH2ZrviPY5OxdbrcFNhHz/EM
         yNmWjElEmPsbvLhmOfATWgvF62QjeDE0TEBTrZUMoFd+wpgha/aCQ7zW30xcLVKKIuuW
         eIEQ==
X-Gm-Message-State: APjAAAWon41Ng4unnVMD7SKV3wqw2Jw11rqxDGe02+mxNSnKp962axzm
        RkRA7YWHQKLIz5CtHNNlQF2kX+Y=
X-Google-Smtp-Source: APXvYqw3ZphSZBY82lzccLETPo+16wo1huFJ2UjRTE6Y+Mq8C5+aTslHBODOfVSZWG8hRNACFUYM+A==
X-Received: by 2002:a05:660c:8a:: with SMTP id t10mr4611146itj.152.1559075615505;
        Tue, 28 May 2019 13:33:35 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:34 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 05/11] Use xstat() with no synchronisation if available
Date:   Tue, 28 May 2019 16:31:16 -0400
Message-Id: <20190528203122.11401-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-5-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We normally expect the exported system to be stable, so don't
revalidate attributes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 configure.ac         |  2 +-
 support/misc/xstat.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index e870862a8abb..50002b4a5677 100644
--- a/configure.ac
+++ b/configure.ac
@@ -321,7 +321,7 @@ AC_CHECK_FUNC([getservbyname], ,
 AC_CHECK_LIB([crypt], [crypt], [LIBCRYPT="-lcrypt"])
 
 AC_CHECK_HEADERS([sched.h], [], [])
-AC_CHECK_FUNCS([unshare fstatat], [] , [])
+AC_CHECK_FUNCS([unshare fstatat statx], [] , [])
 AC_LIBPTHREAD([])
 
 if test "$enable_nfsv4" = yes; then
diff --git a/support/misc/xstat.c b/support/misc/xstat.c
index d092f73dfd65..fa047880cfd0 100644
--- a/support/misc/xstat.c
+++ b/support/misc/xstat.c
@@ -1,21 +1,93 @@
+#include <errno.h>
 #include <sys/types.h>
 #include <fcntl.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <unistd.h>
 
 #include "config.h"
 #include "xstat.h"
 
 #ifdef HAVE_FSTATAT
+#ifdef HAVE_STATX
+
+static void
+statx_copy(struct stat *stbuf, const struct statx *stxbuf)
+{
+	stbuf->st_dev = makedev(stxbuf->stx_dev_major, stxbuf->stx_dev_minor);
+	stbuf->st_ino = stxbuf->stx_ino;
+	stbuf->st_mode = stxbuf->stx_mode;
+	stbuf->st_nlink = stxbuf->stx_nlink;
+	stbuf->st_uid = stxbuf->stx_uid;
+	stbuf->st_gid = stxbuf->stx_gid;
+	stbuf->st_rdev = makedev(stxbuf->stx_rdev_major, stxbuf->stx_rdev_minor);
+	stbuf->st_size = stxbuf->stx_size;
+	stbuf->st_blksize = stxbuf->stx_blksize;
+	stbuf->st_blocks = stxbuf->stx_blocks;
+	stbuf->st_atim.tv_sec = stxbuf->stx_atime.tv_sec;
+	stbuf->st_atim.tv_nsec = stxbuf->stx_atime.tv_nsec;
+	stbuf->st_mtim.tv_sec = stxbuf->stx_mtime.tv_sec;
+	stbuf->st_mtim.tv_nsec = stxbuf->stx_mtime.tv_nsec;
+	stbuf->st_ctim.tv_sec = stxbuf->stx_ctime.tv_sec;
+	stbuf->st_ctim.tv_nsec = stxbuf->stx_ctime.tv_nsec;
+}
+
+static int
+statx_do_stat(int fd, const char *pathname, struct stat *statbuf, int flags)
+{
+	static int statx_supported = 1;
+	struct statx stxbuf;
+	int ret;
+
+	if (statx_supported) {
+		ret = statx(fd, pathname, flags,
+				STATX_BASIC_STATS,
+				&stxbuf);
+		if (ret == 0) {
+			statx_copy(statbuf, &stxbuf);
+			return 0;
+		}
+		if (errno == ENOSYS)
+			statx_supported = 0;
+	} else
+		errno = ENOSYS;
+	return -1;
+}
+
+static int
+statx_stat_nosync(int fd, const char *pathname, struct stat *statbuf, int flags)
+{
+	return statx_do_stat(fd, pathname, statbuf, flags | AT_STATX_DONT_SYNC);
+}
+
+#else
+
+static int
+statx_stat_nosync(int fd, const char *pathname, struct stat *statbuf, int flags)
+{
+	errno = ENOSYS;
+	return -1;
+}
+
+#endif /* HAVE_STATX */
 
 int xlstat(const char *pathname, struct stat *statbuf)
 {
+	if (statx_stat_nosync(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT|
+				AT_SYMLINK_NOFOLLOW) == 0)
+		return 0;
+	else if (errno != ENOSYS)
+		return -1;
 	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT |
 			AT_SYMLINK_NOFOLLOW);
 }
 
 int xstat(const char *pathname, struct stat *statbuf)
 {
+	if (statx_stat_nosync(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT) == 0)
+		return 0;
+	else if (errno != ENOSYS)
+		return -1;
 	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT);
 }
 
-- 
2.21.0

