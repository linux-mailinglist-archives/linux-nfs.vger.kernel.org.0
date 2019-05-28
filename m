Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A12D074
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfE1Udk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32920 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfE1Udk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:40 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so8233179iop.0
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dN1Eq3TOZT1HBwM1BI5GuVgNd5bxjRFNIaTzj4gtaoQ=;
        b=kMYzL4iexvnEQbbnhD+NFUaCJA8H/C39q9yeBwfs7mP1iMgV1ehxqW4Jj5BmGEqEKI
         DTVLT0vjpA4schixXbwVkn3drAVAyD/vcV6mLRyGPJRQdzwkwDJvrfqv1ZQgmH/EI/rH
         Gxn0oROb4bhuzBIU4PNFR+k3xq3jfnAdQComETH/vk0Kt+9RsztiPjGJ6QYB1pQmQUAf
         uc9RMNtcNH0L7LtYNV1sileOp9400TaHu1xSm8PuzmP6vx7XS8KAYoU0BF2Ln6JLvYR2
         etXWp7992+EG9S7oYrU94E9imGMrI/gPIK2iasE8MVfxP8pOzZLvd2zKoeYN7Sbsc3oD
         TXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dN1Eq3TOZT1HBwM1BI5GuVgNd5bxjRFNIaTzj4gtaoQ=;
        b=G62aNhlOnLqhgcb91TGvT2si3gntOkrhO7CgniZSxQiE3BJxMPgH9LQxv4JYcb7NJk
         V/EYsl2fDq5aablQDUJwuAmG7X3ptebFiExJwL1ggQR7v2D4PoucbUFzuj5MSK4NZX2J
         AmncwyvTnVQYI8fRrANc4asuAaWf2VVcSYFRlWQCD5zPXe1SwKToO8qJi2AJyxM6tg4L
         OzsIFgeQZWPsFyy8Pi07VxGahbUh+Em1UPxCe1a8tN0lI9ZooiotXSM0Mx1D9eC8UK7u
         N7MRxEvvVMm6FdjS6Y1OldlNT7iXgJJQ/6z9++XKE7VN7cT1pvqz2WBtktjYhBl1ol+f
         RAUg==
X-Gm-Message-State: APjAAAXTyndm9rg1f2TxSODSniryYEjuY+srQKTpoeeoI9lDtDMBlxK4
        BPwSJBp+kN0eOuxgJwLOZzFsYKc=
X-Google-Smtp-Source: APXvYqzqODSuDxHNK8X9uxFvUeXd9hAI/CX/HCHN9Bj8lcQFNroPI35GdEwB3eT0NNiXVfBtvu8fYQ==
X-Received: by 2002:a6b:6e07:: with SMTP id d7mr49571757ioh.88.1559075618658;
        Tue, 28 May 2019 13:33:38 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:38 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 08/11] Add support for the "[exports] rootdir" nfs.conf option to rpc.mountd
Date:   Tue, 28 May 2019 16:31:19 -0400
Message-Id: <20190528203122.11401-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-8-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
 <20190528203122.11401-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that I/O to those pseudo files that resolve filehandles and exports
go through the chrooted threads, so that we can use paths that are relative
to the nfsd root directory.
Ensure that any stat() or lstat() calls go through their nfsd_path_*
equivalent so that they too can be resolved correctly.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 nfs.conf              |  3 +++
 systemd/nfs.conf.man  | 20 +++++++++++++-
 utils/mountd/cache.c  | 63 ++++++++++++++++++++++++++++---------------
 utils/mountd/mountd.c | 13 +++++----
 4 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 27e962c8a2a9..85097fd197c0 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -5,6 +5,9 @@
 [general]
 # pipefs-directory=/var/lib/nfs/rpc_pipefs
 #
+[exports]
+# rootdir=/export
+#
 [exportfs]
 # debug=0
 #
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index e3654a3c2c2b..d375bcc1d5a7 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -107,6 +107,24 @@ and
 .BR rpc.gssd (8)
 for details.
 
+.TP
+.B exports
+Recognized values:
+.BR rootdir .
+
+Setting
+.B rootdir
+to a valid path causes the nfs server to act as if the
+supplied path is being prefixed to all the exported entries. For
+instance, if
+.BR rootdir=/my/root ,
+and there is an entry in /etc/exports for
+.BR /filesystem ,
+then the client will be able to mount the path as
+.BR /filesystem ,
+but on the server, this will resolve to the path
+.BR /my/root/filesystem .
+
 .TP
 .B nfsdcltrack
 Recognized values:
@@ -136,7 +154,7 @@ Recognized values:
 .BR vers4.0 ,
 .BR vers4.1 ,
 .BR vers4.2 ,
-.BR rdma .
+.BR rdma ,
 
 Version and protocol values are Boolean values as described above,
 and are also used by
diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index bdbd1904eb76..d818c971bded 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -27,6 +27,7 @@
 #include <grp.h>
 #include <mntent.h>
 #include "misc.h"
+#include "nfsd_path.h"
 #include "nfslib.h"
 #include "exportfs.h"
 #include "mountd.h"
@@ -55,6 +56,22 @@ enum nfsd_fsid {
 	FSID_UUID16_INUM,
 };
 
+#undef is_mountpoint
+static int is_mountpoint(char *path)
+{
+	return check_is_mountpoint(path, nfsd_path_lstat);
+}
+
+static ssize_t cache_read(int fd, char *buf, size_t len)
+{
+	return nfsd_path_read(fd, buf, len);
+}
+
+static ssize_t cache_write(int fd, const char *buf, size_t len)
+{
+	return nfsd_path_write(fd, buf, len);
+}
+
 /*
  * Support routines for text-based upcalls.
  * Fields are separated by spaces.
@@ -221,7 +238,7 @@ static const char *get_uuid_blkdev(char *path)
 	if (cache == NULL)
 		blkid_get_cache(&cache, NULL);
 
-	if (stat(path, &stb) != 0)
+	if (nfsd_path_stat(path, &stb) != 0)
 		return NULL;
 	devname = blkid_devno_to_devname(stb.st_dev);
 	if (!devname)
@@ -373,21 +390,22 @@ static char *next_mnt(void **v, char *p)
 	FILE *f;
 	struct mntent *me;
 	size_t l = strlen(p);
+	char *mnt_dir = NULL;
+
 	if (*v == NULL) {
 		f = setmntent("/etc/mtab", "r");
 		*v = f;
 	} else
 		f = *v;
-	while ((me = getmntent(f)) != NULL && l > 1 &&
-	       (strncmp(me->mnt_dir, p, l) != 0 ||
-		me->mnt_dir[l] != '/'))
-		;
-	if (me == NULL) {
-		endmntent(f);
-		*v = NULL;
-		return NULL;
+	while ((me = getmntent(f)) != NULL && l > 1) {
+		mnt_dir = nfsd_path_strip_root(me->mnt_dir);
+
+		if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] != '/')
+			return mnt_dir;
 	}
-	return me->mnt_dir;
+	endmntent(f);
+	*v = NULL;
+	return NULL;
 }
 
 /* same_path() check is two paths refer to the same directory.
@@ -458,9 +476,9 @@ fallback:
 	 * bind-mounted in two places and both are exported, it
 	 * could give a false positive
 	 */
-	if (lstat(p, &sc) != 0)
+	if (nfsd_path_lstat(p, &sc) != 0)
 		return 0;
-	if (lstat(parent, &sp) != 0)
+	if (nfsd_path_lstat(parent, &sp) != 0)
 		return 0;
 	if (sc.st_dev != sp.st_dev)
 		return 0;
@@ -610,7 +628,7 @@ static bool match_fsid(struct parsed_fsid *parsed, nfs_export *exp, char *path)
 	int type;
 	char u[16];
 
-	if (stat(path, &stb) != 0)
+	if (nfsd_path_stat(path, &stb) != 0)
 		return false;
 	if (!S_ISDIR(stb.st_mode) && !S_ISREG(stb.st_mode))
 		return false;
@@ -692,7 +710,7 @@ static void nfsd_fh(int f)
 	char buf[RPC_CHAN_BUF_SIZE], *bp;
 	int blen;
 
-	blen = read(f, buf, sizeof(buf));
+	blen = cache_read(f, buf, sizeof(buf));
 	if (blen <= 0 || buf[blen-1] != '\n') return;
 	buf[blen-1] = 0;
 
@@ -829,7 +847,7 @@ static void nfsd_fh(int f)
 	if (found)
 		qword_add(&bp, &blen, found_path);
 	qword_addeol(&bp, &blen);
-	if (blen <= 0 || write(f, buf, bp - buf) != bp - buf)
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf)
 		xlog(L_ERROR, "nfsd_fh: error writing reply");
 out:
 	if (found_path)
@@ -921,7 +939,7 @@ static int dump_to_cache(int f, char *buf, int buflen, char *domain,
 		qword_adduint(&bp, &blen, now + ttl);
 	qword_addeol(&bp, &blen);
 	if (blen <= 0) return -1;
-	if (write(f, buf, bp - buf) != bp - buf) return -1;
+	if (cache_write(f, buf, bp - buf) != bp - buf) return -1;
 	return 0;
 }
 
@@ -1298,7 +1316,7 @@ static void nfsd_export(int f)
 	char buf[RPC_CHAN_BUF_SIZE], *bp;
 	int blen;
 
-	blen = read(f, buf, sizeof(buf));
+	blen = cache_read(f, buf, sizeof(buf));
 	if (blen <= 0 || buf[blen-1] != '\n') return;
 	buf[blen-1] = 0;
 
@@ -1381,6 +1399,7 @@ extern int manage_gids;
 void cache_open(void) 
 {
 	int i;
+
 	for (i=0; cachelist[i].cache_name; i++ ) {
 		char path[100];
 		if (!manage_gids && cachelist[i].cache_handle == auth_unix_gid)
@@ -1456,7 +1475,7 @@ static int cache_export_ent(char *buf, int buflen, char *domain, struct exporten
 		if (strlen(path) <= l || path[l] != '/' ||
 		    strncmp(exp->e_path, path, l) != 0)
 			break;
-		if (stat(exp->e_path, &stb) != 0)
+		if (nfsd_path_stat(exp->e_path, &stb) != 0)
 			break;
 		dev = stb.st_dev;
 		while(path[l] == '/') {
@@ -1469,7 +1488,7 @@ static int cache_export_ent(char *buf, int buflen, char *domain, struct exporten
 				l++;
 			c = path[l];
 			path[l] = 0;
-			err2 = lstat(path, &stb);
+			err2 = nfsd_path_lstat(path, &stb);
 			path[l] = c;
 			if (err2 < 0)
 				break;
@@ -1508,7 +1527,7 @@ int cache_export(nfs_export *exp, char *path)
 	qword_adduint(&bp, &blen, time(0) + exp->m_export.e_ttl);
 	qword_add(&bp, &blen, exp->m_client->m_hostname);
 	qword_addeol(&bp, &blen);
-	if (blen <= 0 || write(f, buf, bp - buf) != bp - buf) blen = -1;
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf) blen = -1;
 	close(f);
 	if (blen < 0) return -1;
 
@@ -1546,12 +1565,12 @@ cache_get_filehandle(nfs_export *exp, int len, char *p)
 	qword_add(&bp, &blen, p);
 	qword_addint(&bp, &blen, len);
 	qword_addeol(&bp, &blen);
-	if (blen <= 0 || write(f, buf, bp - buf) != bp - buf) {
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf) {
 		close(f);
 		return NULL;
 	}
 	bp = buf;
-	blen = read(f, buf, sizeof(buf));
+	blen = cache_read(f, buf, sizeof(buf));
 	close(f);
 
 	if (blen <= 0 || buf[blen-1] != '\n')
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index 88a207b3a85a..f062cac28be4 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -29,6 +29,7 @@
 #include "mountd.h"
 #include "rpcmisc.h"
 #include "pseudoflavors.h"
+#include "nfsd_path.h"
 #include "nfslib.h"
 
 extern void my_svc_run(void);
@@ -374,7 +375,7 @@ mount_pathconf_2_svc(struct svc_req *rqstp, dirpath *path, ppathcnf *res)
 	exp = auth_authenticate("pathconf", sap, p);
 	if (exp == NULL)
 		return 1;
-	else if (stat(p, &stb) < 0) {
+	else if (nfsd_path_stat(p, &stb) < 0) {
 		xlog(L_WARNING, "can't stat exported dir %s: %s",
 				p, strerror(errno));
 		return 1;
@@ -483,7 +484,7 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 		*error = MNT3ERR_ACCES;
 		return NULL;
 	}
-	if (stat(p, &stb) < 0) {
+	if (nfsd_path_stat(p, &stb) < 0) {
 		xlog(L_WARNING, "can't stat exported dir %s: %s",
 				p, strerror(errno));
 		if (errno == ENOENT)
@@ -497,7 +498,7 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 		*error = MNT3ERR_NOTDIR;
 		return NULL;
 	}
-	if (stat(exp->m_export.e_path, &estb) < 0) {
+	if (nfsd_path_stat(exp->m_export.e_path, &estb) < 0) {
 		xlog(L_WARNING, "can't stat export point %s: %s",
 		     p, strerror(errno));
 		*error = MNT3ERR_NOENT;
@@ -511,9 +512,10 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 		return NULL;
 	}
 	if (exp->m_export.e_mountpoint &&
-		   !is_mountpoint(exp->m_export.e_mountpoint[0]?
+		   !check_is_mountpoint(exp->m_export.e_mountpoint[0]?
 				  exp->m_export.e_mountpoint:
-				  exp->m_export.e_path)) {
+				  exp->m_export.e_path,
+				  nfsd_path_lstat)) {
 		xlog(L_WARNING, "request to export an unmounted filesystem: %s",
 		     p);
 		*error = MNT3ERR_NOENT;
@@ -886,6 +888,7 @@ main(int argc, char **argv)
 	if (num_threads > 1)
 		fork_workers();
 
+	nfsd_path_init();
 	/* Open files now to avoid sharing descriptors among forked processes */
 	cache_open();
 
-- 
2.21.0

