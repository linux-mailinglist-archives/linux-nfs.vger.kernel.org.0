Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A101F24F30
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfEUMtT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 08:49:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36744 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfEUMtS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 08:49:18 -0400
Received: by mail-io1-f67.google.com with SMTP id e19so13833559iob.3
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLr9Jev1vzFH2WxtXzDL6iC0Z9XJSGhBflc8iGqtz0M=;
        b=mbbuhIXgMro0QiEdIcNthIsiAgUwKUBuf2Zw+JLwUXUv0sNL9T8iuKWQ9iYDIkcfAt
         TJ9kKymKSNA3aDP316rKyshzA9Lce+5fXTpPdSUvmCnJkGd5XZkl+HTdPZvfQvDZ9KCu
         pKQVor/+Q1vLuPuYYBsjtCNd0LuAwH2JKvpZlt/m2lYVjfZ/4lPksF0jvJeEisxAe9sP
         6NRsngRGaljQa6fp1KSwuHYdWsSpSdOK6mGnHO49QOrELFKj5wj7yk3yEovYqGzK4Md1
         LfR3kMxuQTqmbylfwLSkkJvhDtwlXQ01cPmeDa3jWLPFzeR7xRZwIBqG+VNW0tFe72rw
         zp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLr9Jev1vzFH2WxtXzDL6iC0Z9XJSGhBflc8iGqtz0M=;
        b=WSIU3lKMXfj2Z9t6zlN0dXV6X24covVznbuKLGksas98s48tYEc7+xM+eRGggv0Zic
         gGuvS2jM8HFoTjgVJTK5W+d5OojMoSTv0P7e3TiJUkQnEL7RudWTs/Pwu+OmPCqF+IYE
         E8M06orWCZ56Knrb/66gkOak1oJEld91WAHcQojOySqjtIB7+zMOXwRLgcLCT4LftKWl
         L5RePRVlpFyyVn3cCoZoU6mUawqei0Iaby4UxJ3wErRiAfB6+GAidYbhU8CqIxuakuVe
         UM5tUPxNkhT/9e07Oq3LCetHZUvpCa++kTkL5LMC/gM5CcFLl1t7EVLubkVvnHx3N5T2
         N2xw==
X-Gm-Message-State: APjAAAXqja3kwo4fs3/WpLJIMZIHXe3/kTKjvyA8YbqID6jHrB9YSlp+
        JfU5Mu+gzi2Atqrc2xLmo3ZTda4=
X-Google-Smtp-Source: APXvYqyDwurOJsnLd5Jq8g2sjUxAnz1sR7lENjUfEPMG/DoP77TusXDwVIZVFXz/HeD4zwQZsvzqag==
X-Received: by 2002:a5e:d50e:: with SMTP id e14mr10541868iom.224.1558442956868;
        Tue, 21 May 2019 05:49:16 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v139sm1693180itb.25.2019.05.21.05.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:49:16 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 6/7] Add support for the nfsd rootdir configuration option to rpc.mountd
Date:   Tue, 21 May 2019 08:47:00 -0400
Message-Id: <20190521124701.61849-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521124701.61849-6-trond.myklebust@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <20190521124701.61849-2-trond.myklebust@hammerspace.com>
 <20190521124701.61849-3-trond.myklebust@hammerspace.com>
 <20190521124701.61849-4-trond.myklebust@hammerspace.com>
 <20190521124701.61849-5-trond.myklebust@hammerspace.com>
 <20190521124701.61849-6-trond.myklebust@hammerspace.com>
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
 nfs.conf                  |  1 +
 support/misc/mountpoint.c |  5 ++-
 systemd/nfs.conf.man      |  3 +-
 utils/mountd/cache.c      | 79 ++++++++++++++++++++++++++++-----------
 utils/mountd/mountd.c     |  8 ++--
 utils/nfsd/nfsd.man       |  6 +++
 6 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 27e962c8a2a9..4d3bc512c4be 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -60,6 +60,7 @@
 # vers4.1=y
 # vers4.2=y
 # rdma=n
+# root_dir=/export
 #
 [statd]
 # debug=0
diff --git a/support/misc/mountpoint.c b/support/misc/mountpoint.c
index 9f9ce44ec1e3..9723dcede79d 100644
--- a/support/misc/mountpoint.c
+++ b/support/misc/mountpoint.c
@@ -7,6 +7,7 @@
 #include "xcommon.h"
 #include <sys/stat.h>
 #include "misc.h"
+#include "nfsd_path.h"
 
 int
 is_mountpoint(char *path)
@@ -26,8 +27,8 @@ is_mountpoint(char *path)
 	dotdot = xmalloc(strlen(path)+4);
 
 	strcat(strcpy(dotdot, path), "/..");
-	if (lstat(path, &stb) != 0 ||
-	    lstat(dotdot, &pstb) != 0)
+	if (nfsd_path_lstat(path, &stb) != 0 ||
+	    nfsd_path_lstat(dotdot, &pstb) != 0)
 		rv = 0;
 	else
 		if (stb.st_dev != pstb.st_dev ||
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index e3654a3c2c2b..a88799769365 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -136,7 +136,8 @@ Recognized values:
 .BR vers4.0 ,
 .BR vers4.1 ,
 .BR vers4.2 ,
-.BR rdma .
+.BR rdma ,
+.BR root_dir .
 
 Version and protocol values are Boolean values as described above,
 and are also used by
diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index bdbd1904eb76..6e15ecd986aa 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -27,17 +27,21 @@
 #include <grp.h>
 #include <mntent.h>
 #include "misc.h"
+#include "nfsd_path.h"
 #include "nfslib.h"
 #include "exportfs.h"
 #include "mountd.h"
 #include "fsloc.h"
 #include "pseudoflavors.h"
+#include "workqueue.h"
 #include "xcommon.h"
 
 #ifdef USE_BLKID
 #include "blkid/blkid.h"
 #endif
 
+static struct xthread_workqueue *cache_workqueue;
+
 /*
  * Invoked by RPC service loop
  */
@@ -55,6 +59,34 @@ enum nfsd_fsid {
 	FSID_UUID16_INUM,
 };
 
+static ssize_t cache_read(int fd, char *buf, size_t len)
+{
+	if (cache_workqueue)
+		return xthread_read(cache_workqueue, fd, buf, len);
+	return read(fd, buf, len);
+}
+
+static ssize_t cache_write(int fd, const char *buf, size_t len)
+{
+	if (cache_workqueue)
+		return xthread_write(cache_workqueue, fd, buf, len);
+	return write(fd, buf, len);
+}
+
+static void
+cache_setup_workqueue(void)
+{
+	const char *chroot;
+
+	chroot = nfsd_path_nfsd_rootdir();
+	if (!chroot)
+		return;
+	cache_workqueue = xthread_workqueue_alloc();
+	if (!cache_workqueue)
+		return;
+	xthread_workqueue_chroot(cache_workqueue, chroot);
+}
+
 /*
  * Support routines for text-based upcalls.
  * Fields are separated by spaces.
@@ -221,7 +253,7 @@ static const char *get_uuid_blkdev(char *path)
 	if (cache == NULL)
 		blkid_get_cache(&cache, NULL);
 
-	if (stat(path, &stb) != 0)
+	if (nfsd_path_stat(path, &stb) != 0)
 		return NULL;
 	devname = blkid_devno_to_devname(stb.st_dev);
 	if (!devname)
@@ -373,21 +405,22 @@ static char *next_mnt(void **v, char *p)
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
@@ -458,9 +491,9 @@ fallback:
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
@@ -610,7 +643,7 @@ static bool match_fsid(struct parsed_fsid *parsed, nfs_export *exp, char *path)
 	int type;
 	char u[16];
 
-	if (stat(path, &stb) != 0)
+	if (nfsd_path_stat(path, &stb) != 0)
 		return false;
 	if (!S_ISDIR(stb.st_mode) && !S_ISREG(stb.st_mode))
 		return false;
@@ -692,7 +725,7 @@ static void nfsd_fh(int f)
 	char buf[RPC_CHAN_BUF_SIZE], *bp;
 	int blen;
 
-	blen = read(f, buf, sizeof(buf));
+	blen = cache_read(f, buf, sizeof(buf));
 	if (blen <= 0 || buf[blen-1] != '\n') return;
 	buf[blen-1] = 0;
 
@@ -829,7 +862,7 @@ static void nfsd_fh(int f)
 	if (found)
 		qword_add(&bp, &blen, found_path);
 	qword_addeol(&bp, &blen);
-	if (blen <= 0 || write(f, buf, bp - buf) != bp - buf)
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf)
 		xlog(L_ERROR, "nfsd_fh: error writing reply");
 out:
 	if (found_path)
@@ -921,7 +954,7 @@ static int dump_to_cache(int f, char *buf, int buflen, char *domain,
 		qword_adduint(&bp, &blen, now + ttl);
 	qword_addeol(&bp, &blen);
 	if (blen <= 0) return -1;
-	if (write(f, buf, bp - buf) != bp - buf) return -1;
+	if (cache_write(f, buf, bp - buf) != bp - buf) return -1;
 	return 0;
 }
 
@@ -1298,7 +1331,7 @@ static void nfsd_export(int f)
 	char buf[RPC_CHAN_BUF_SIZE], *bp;
 	int blen;
 
-	blen = read(f, buf, sizeof(buf));
+	blen = cache_read(f, buf, sizeof(buf));
 	if (blen <= 0 || buf[blen-1] != '\n') return;
 	buf[blen-1] = 0;
 
@@ -1381,6 +1414,8 @@ extern int manage_gids;
 void cache_open(void) 
 {
 	int i;
+
+	cache_setup_workqueue();
 	for (i=0; cachelist[i].cache_name; i++ ) {
 		char path[100];
 		if (!manage_gids && cachelist[i].cache_handle == auth_unix_gid)
@@ -1456,7 +1491,7 @@ static int cache_export_ent(char *buf, int buflen, char *domain, struct exporten
 		if (strlen(path) <= l || path[l] != '/' ||
 		    strncmp(exp->e_path, path, l) != 0)
 			break;
-		if (stat(exp->e_path, &stb) != 0)
+		if (nfsd_path_stat(exp->e_path, &stb) != 0)
 			break;
 		dev = stb.st_dev;
 		while(path[l] == '/') {
@@ -1469,7 +1504,7 @@ static int cache_export_ent(char *buf, int buflen, char *domain, struct exporten
 				l++;
 			c = path[l];
 			path[l] = 0;
-			err2 = lstat(path, &stb);
+			err2 = nfsd_path_lstat(path, &stb);
 			path[l] = c;
 			if (err2 < 0)
 				break;
@@ -1508,7 +1543,7 @@ int cache_export(nfs_export *exp, char *path)
 	qword_adduint(&bp, &blen, time(0) + exp->m_export.e_ttl);
 	qword_add(&bp, &blen, exp->m_client->m_hostname);
 	qword_addeol(&bp, &blen);
-	if (blen <= 0 || write(f, buf, bp - buf) != bp - buf) blen = -1;
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf) blen = -1;
 	close(f);
 	if (blen < 0) return -1;
 
@@ -1546,12 +1581,12 @@ cache_get_filehandle(nfs_export *exp, int len, char *p)
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
index 88a207b3a85a..db9891269051 100644
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
@@ -886,6 +887,7 @@ main(int argc, char **argv)
 	if (num_threads > 1)
 		fork_workers();
 
+	nfsd_path_init();
 	/* Open files now to avoid sharing descriptors among forked processes */
 	cache_open();
 
diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
index d83ef869d26e..1f3bdf75a2b4 100644
--- a/utils/nfsd/nfsd.man
+++ b/utils/nfsd/nfsd.man
@@ -167,6 +167,12 @@ Setting these to "off" or similar will disable the selected minor
 versions.  Setting to "on" will enable them.  The default values
 are determined by the kernel, and usually minor versions default to
 being enabled once the implementation is sufficiently complete.
+.B root_dir
+Setting this to a valid path causes the nfs server to act as if the
+supplied path is being prefixed to all the exported entries. For
+instance, if "root_dir=/my/root", and there is an entry in /etc/exports
+for '/filesystem', then the client can mount '/filesystem', but the
+actual path on the server will resolve to '/my/root/filesystem'.
 
 .SH NOTES
 If the program is built with TI-RPC support, it will enable any protocol and
-- 
2.21.0

