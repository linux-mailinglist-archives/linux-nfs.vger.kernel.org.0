Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486D964E348
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Dec 2022 22:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiLOVgN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Dec 2022 16:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLOVgM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Dec 2022 16:36:12 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2658F1BEA6
        for <linux-nfs@vger.kernel.org>; Thu, 15 Dec 2022 13:36:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l10so337823plb.8
        for <linux-nfs@vger.kernel.org>; Thu, 15 Dec 2022 13:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj+z7OIgrBD5G5SAFT5f0UT7YjJ5qwgnKhisUW+az4M=;
        b=ptbOlCp1XsAC3MsoU1gCOPsaEJ4FiVk2q7PtXCdbC5NmT/p6xaQGCSIaj9oSU8E1HU
         oos31yhuzqEoPbe0FHs5BMMFHi1t79Tz7/FigaU/9EfYlxK8sVz+56B6418NxbKLB0mR
         to8E3rIZBWZApUc5OTJAeS8rW+KTxnb8pjMuKR1A69B2xeERMTiEgM4zRO+wpUhzpInO
         1bbjHvvdT2vdFO16LE89XjdU4UYgpoiQ85b3KAi+o2qbo+tm5vAvVkMb7i3s7r2dZjgp
         RHu8EmU/Ly9ph4LV0LxEhyEn18I6lJ2akwluLjkftwBzO50dRmStHFDfVXvsx/vW19E0
         46Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qj+z7OIgrBD5G5SAFT5f0UT7YjJ5qwgnKhisUW+az4M=;
        b=bStBqxxhJl2qBIfRUs8XUcEspHOpoKQmkjdCJO3jYCe+EdKAGnO9thqs9zhiIvD/FA
         YDk56/zYwlT3S4m3CGIC8hYR/XTIzdndbzv9y2s0GwfkjZfXOsXilPFnWntpl8t/Prg5
         lLuH/xvkDKAv5DAg67uUClTbzu8Iqyl0gv+FFZACmIQI7FmIq5s6YZM6L/nUGhC9ts04
         l8TsODKHru9TKvMNglgjonBp7U9+Oyo2l9ey9boZRDvfWPEq6WMgy9WrhZEcGcrkyl31
         BoImcH3OA9BEuZkvpr2vQMCgR/DENusMA5u58J+nTmXsupi3w6uan7WHXuajppjXRUPp
         ibVA==
X-Gm-Message-State: ANoB5plpulCUWdyP4kT475DQGVUu5VQZtRlOl396O/4JTPvq6M7vz8DI
        WxUVmlwiVBQg7SNmyMAWPZrxK+NPnQ8=
X-Google-Smtp-Source: AA0mqf6W2hiYLwnMFdBOYWvLF5k5SV9x2+5p8qbCqb8/vJpMHBHmYK14zLr5PMo6xEh1wBi1IPyN3Q==
X-Received: by 2002:a17:903:3255:b0:189:86cd:d7c0 with SMTP id ji21-20020a170903325500b0018986cdd7c0mr30604334plb.18.1671140168988;
        Thu, 15 Dec 2022 13:36:08 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902cf1000b00186a2444a43sm125118plg.27.2022.12.15.13.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:36:08 -0800 (PST)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Replace statfs64 with statfs
Date:   Thu, 15 Dec 2022 13:36:05 -0800
Message-Id: <20221215213605.4061853-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

autoconf AC_SYS_LARGEFILE is used by configure to add needed defines
when needed for enabling 64bit off_t, therefore replacing statfs64 with
statfs should be functionally same. Additionally this helps compiling
with latest musl where 64bit LFS functions like statfs64 and friends are
now moved under _LARGEFILE64_SOURCE feature test macro, this works on
glibc systems because _GNU_SOURCE macros also enables
_LARGEFILE64_SOURCE indirectly. This is not case with musl and this
latest issue is exposed.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 support/export/cache.c      | 14 +++++++-------
 support/include/nfsd_path.h |  6 +++---
 support/misc/nfsd_path.c    | 24 ++++++++++++------------
 utils/exportfs/exportfs.c   |  4 ++--
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index a5823e9..2497d4f 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -346,27 +346,27 @@ static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid)
 
 	/* Possible sources of uuid are
 	 * - blkid uuid
-	 * - statfs64 uuid
+	 * - statfs uuid
 	 *
-	 * On some filesystems (e.g. vfat) the statfs64 uuid is simply an
+	 * On some filesystems (e.g. vfat) the statfs uuid is simply an
 	 * encoding of the device that the filesystem is mounted from, so
 	 * it we be very bad to use that (as device numbers change).  blkid
 	 * must be preferred.
-	 * On other filesystems (e.g. btrfs) the statfs64 uuid contains
+	 * On other filesystems (e.g. btrfs) the statfs uuid contains
 	 * important info that the blkid uuid cannot contain:  This happens
 	 * when multiple subvolumes are exported (they have the same
-	 * blkid uuid but different statfs64 uuids).
+	 * blkid uuid but different statfs uuids).
 	 * We rely on get_uuid_blkdev *knowing* which is which and not returning
-	 * a uuid for filesystems where the statfs64 uuid is better.
+	 * a uuid for filesystems where the statfs uuid is better.
 	 *
 	 */
-	struct statfs64 st;
+	struct statfs st;
 	char fsid_val[17];
 	const char *blkid_val = NULL;
 	const char *val;
 	int rc;
 
-	rc = nfsd_path_statfs64(path, &st);
+	rc = nfsd_path_statfs(path, &st);
 
 	if (type == 0 && rc == 0) {
 		const unsigned long *bad;
diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index 3b73aad..aa1e1dd 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -7,7 +7,7 @@
 #include <sys/stat.h>
 
 struct file_handle;
-struct statfs64;
+struct statfs;
 
 void 		nfsd_path_init(void);
 
@@ -18,8 +18,8 @@ char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
 int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
 int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
 
-int		nfsd_path_statfs64(const char *pathname,
-				   struct statfs64 *statbuf);
+int		nfsd_path_statfs(const char *pathname,
+				   struct statfs *statbuf);
 
 char *		nfsd_realpath(const char *path, char *resolved_path);
 
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 65e53c1..c3dea4f 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -184,46 +184,46 @@ nfsd_path_lstat(const char *pathname, struct stat *statbuf)
 	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
 }
 
-struct nfsd_statfs64_data {
+struct nfsd_statfs_data {
 	const char *pathname;
-	struct statfs64 *statbuf;
+	struct statfs *statbuf;
 	int ret;
 	int err;
 };
 
 static void
-nfsd_statfs64func(void *data)
+nfsd_statfsfunc(void *data)
 {
-	struct nfsd_statfs64_data *d = data;
+	struct nfsd_statfs_data *d = data;
 
-	d->ret = statfs64(d->pathname, d->statbuf);
+	d->ret = statfs(d->pathname, d->statbuf);
 	if (d->ret < 0)
 		d->err = errno;
 }
 
 static int
-nfsd_run_statfs64(struct xthread_workqueue *wq,
+nfsd_run_statfs(struct xthread_workqueue *wq,
 		  const char *pathname,
-		  struct statfs64 *statbuf)
+		  struct statfs *statbuf)
 {
-	struct nfsd_statfs64_data data = {
+	struct nfsd_statfs_data data = {
 		pathname,
 		statbuf,
 		0,
 		0
 	};
-	xthread_work_run_sync(wq, nfsd_statfs64func, &data);
+	xthread_work_run_sync(wq, nfsd_statfsfunc, &data);
 	if (data.ret < 0)
 		errno = data.err;
 	return data.ret;
 }
 
 int
-nfsd_path_statfs64(const char *pathname, struct statfs64 *statbuf)
+nfsd_path_statfs(const char *pathname, struct statfs *statbuf)
 {
 	if (!nfsd_wq)
-		return statfs64(pathname, statbuf);
-	return nfsd_run_statfs64(nfsd_wq, pathname, statbuf);
+		return statfs(pathname, statbuf);
+	return nfsd_run_statfs(nfsd_wq, pathname, statbuf);
 }
 
 struct nfsd_realpath_data {
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 0897b22..6d79a5b 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -513,7 +513,7 @@ validate_export(nfs_export *exp)
 	 */
 	struct stat stb;
 	char *path = exportent_realpath(&exp->m_export);
-	struct statfs64 stf;
+	struct statfs stf;
 	int fs_has_fsid = 0;
 
 	if (stat(path, &stb) < 0) {
@@ -528,7 +528,7 @@ validate_export(nfs_export *exp)
 	if (!can_test())
 		return;
 
-	if (!statfs64(path, &stf) &&
+	if (!statfs(path, &stf) &&
 	    (stf.f_fsid.__val[0] || stf.f_fsid.__val[1]))
 		fs_has_fsid = 1;
 
-- 
2.39.0

