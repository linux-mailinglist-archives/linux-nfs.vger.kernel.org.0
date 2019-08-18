Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA137918C5
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfHRSV3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:29 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:40769 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfHRSV3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:29 -0400
Received: by mail-io1-f52.google.com with SMTP id t6so16110082ios.7
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgKYMz813mTgubN3jIYvlY//WBYpfQ2oOh3VBH2oqz4=;
        b=VpyLQ5b7qdJSxHucYikZzMrhMWB+JBNSbmiMVbdHweniFSMeIlRO0jRizcMvuCS/uy
         vcGaaeUly7BKCplnq1G5+n124FBz0Mkc0o32i3qY+rndPDYcAZUMnRu5v4q8nfVERF98
         0abt8w+58FlLkHw1MLRNltyQF32c1ZZQLCpK4Xz9PJNze9a1J/y2agvGVy2HuEZQMV19
         aqKhhjBkobVumuFD1rb6CNRgXstvI8dOPgjRt01wX9sAng1CtNaNOv0XkdKCT9Hed9NZ
         TrcpJi21bmTXfklkCLWWxQE9/VKG7FnJ0fIBXPIMCK+d6sATlVdR9BhlJDdhbxK57vls
         eVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgKYMz813mTgubN3jIYvlY//WBYpfQ2oOh3VBH2oqz4=;
        b=oH0Ixc7R3btarZd8cDlr/49vnG+X8T6/LXBDSLO4HoVuZv0+hU00OxwSVIPoMtGy3H
         L+d2LIvhZ18qImPavY/93Vx8C0Gh87qPAXONsdR8C3wYGTWpa4COWj8wg2yT5Gd4DkhU
         rFh85jY0tLbiB/KqZhTCKDrMSvRa0/5ZUG5fuSOLhKFOj7sSvZa1gojhHZ8BYEgNeGy7
         ZSrDAHFHUZ/7Pyi6qfjenzXvlCeteP4BFeLqHPtlvf+H4zhaOBWawOtV0obZ/NQ32Xm/
         S9iBaOK161gns5sOH3JaWMBwQoI/5us3ns9a5nDg+9i+L6B6FLMXRnMYY5MFyaskwfjC
         gsvg==
X-Gm-Message-State: APjAAAW4zwvBujZeRAQotMlESoGGdULv16/R628kQTbOIfxHQmkgCUNr
        fb+ls2rHdGPuDF++GQrbxiNvZhA=
X-Google-Smtp-Source: APXvYqy3dSNHarkt9hrfkEk9l1r/D0CSyu6DDbXCSNAcFsWD0Q4HriYq65j9FB1eo/dfBsVUF6Ksmw==
X-Received: by 2002:a02:a409:: with SMTP id c9mr23315328jal.74.1566152487484;
        Sun, 18 Aug 2019 11:21:27 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:26 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 13/16] nfsd: rip out the raparms cache
Date:   Sun, 18 Aug 2019 14:18:56 -0400
Message-Id: <20190818181859.8458-14-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-13-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
 <20190818181859.8458-8-trond.myklebust@hammerspace.com>
 <20190818181859.8458-9-trond.myklebust@hammerspace.com>
 <20190818181859.8458-10-trond.myklebust@hammerspace.com>
 <20190818181859.8458-11-trond.myklebust@hammerspace.com>
 <20190818181859.8458-12-trond.myklebust@hammerspace.com>
 <20190818181859.8458-13-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

The raparms cache was set up in order to ensure that we carry readahead
information forward from one RPC call to the next. In other words, it
was set up because each RPC call was forced to open a struct file, then
close it, causing the loss of readahead information that is normally
cached in that struct file, and used to keep the page cache filled when
a user calls read() multiple times on the same file descriptor.

Now that we cache the struct file, and reuse it for all the I/O calls
to a given file by a given user, we no longer have to keep a separate
readahead cache.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfssvc.c |  13 +----
 fs/nfsd/vfs.c    | 149 -----------------------------------------------
 fs/nfsd/vfs.h    |   6 --
 3 files changed, 1 insertion(+), 167 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a6b1eab7b722..d02712ca2685 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -317,22 +317,12 @@ static int nfsd_startup_generic(int nrservs)
 	ret = nfsd_file_cache_init();
 	if (ret)
 		goto dec_users;
-	/*
-	 * Readahead param cache - will no-op if it already exists.
-	 * (Note therefore results will be suboptimal if number of
-	 * threads is modified after nfsd start.)
-	 */
-	ret = nfsd_racache_init(2*nrservs);
-	if (ret)
-		goto out_file_cache;
 
 	ret = nfs4_state_start();
 	if (ret)
-		goto out_racache;
+		goto out_file_cache;
 	return 0;
 
-out_racache:
-	nfsd_racache_shutdown();
 out_file_cache:
 	nfsd_file_cache_shutdown();
 dec_users:
@@ -347,7 +337,6 @@ static void nfsd_shutdown_generic(void)
 
 	nfs4_state_shutdown();
 	nfsd_file_cache_shutdown();
-	nfsd_racache_shutdown();
 }
 
 static bool nfsd_needs_lockd(struct nfsd_net *nn)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ec254bff1893..8e2c8f36eba3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,34 +49,6 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
-
-/*
- * This is a cache of readahead params that help us choose the proper
- * readahead strategy. Initially, we set all readahead parameters to 0
- * and let the VFS handle things.
- * If you increase the number of cached files very much, you'll need to
- * add a hash table here.
- */
-struct raparms {
-	struct raparms		*p_next;
-	unsigned int		p_count;
-	ino_t			p_ino;
-	dev_t			p_dev;
-	int			p_set;
-	struct file_ra_state	p_ra;
-	unsigned int		p_hindex;
-};
-
-struct raparm_hbucket {
-	struct raparms		*pb_head;
-	spinlock_t		pb_lock;
-} ____cacheline_aligned_in_smp;
-
-#define RAPARM_HASH_BITS	4
-#define RAPARM_HASH_SIZE	(1<<RAPARM_HASH_BITS)
-#define RAPARM_HASH_MASK	(RAPARM_HASH_SIZE-1)
-static struct raparm_hbucket	raparm_hash[RAPARM_HASH_SIZE];
-
 /* 
  * Called from nfsd_lookup and encode_dirent. Check if we have crossed 
  * a mount point.
@@ -822,67 +794,6 @@ nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	return err;
 }
 
-
-
-struct raparms *
-nfsd_init_raparms(struct file *file)
-{
-	struct inode *inode = file_inode(file);
-	dev_t dev = inode->i_sb->s_dev;
-	ino_t ino = inode->i_ino;
-	struct raparms	*ra, **rap, **frap = NULL;
-	int depth = 0;
-	unsigned int hash;
-	struct raparm_hbucket *rab;
-
-	hash = jhash_2words(dev, ino, 0xfeedbeef) & RAPARM_HASH_MASK;
-	rab = &raparm_hash[hash];
-
-	spin_lock(&rab->pb_lock);
-	for (rap = &rab->pb_head; (ra = *rap); rap = &ra->p_next) {
-		if (ra->p_ino == ino && ra->p_dev == dev)
-			goto found;
-		depth++;
-		if (ra->p_count == 0)
-			frap = rap;
-	}
-	depth = nfsdstats.ra_size;
-	if (!frap) {	
-		spin_unlock(&rab->pb_lock);
-		return NULL;
-	}
-	rap = frap;
-	ra = *frap;
-	ra->p_dev = dev;
-	ra->p_ino = ino;
-	ra->p_set = 0;
-	ra->p_hindex = hash;
-found:
-	if (rap != &rab->pb_head) {
-		*rap = ra->p_next;
-		ra->p_next   = rab->pb_head;
-		rab->pb_head = ra;
-	}
-	ra->p_count++;
-	nfsdstats.ra_depth[depth*10/nfsdstats.ra_size]++;
-	spin_unlock(&rab->pb_lock);
-
-	if (ra->p_set)
-		file->f_ra = ra->p_ra;
-	return ra;
-}
-
-void nfsd_put_raparams(struct file *file, struct raparms *ra)
-{
-	struct raparm_hbucket *rab = &raparm_hash[ra->p_hindex];
-
-	spin_lock(&rab->pb_lock);
-	ra->p_ra = file->f_ra;
-	ra->p_set = 1;
-	ra->p_count--;
-	spin_unlock(&rab->pb_lock);
-}
-
 /*
  * Grab and keep cached pages associated with a file in the svc_rqst
  * so that they can be passed to the network sendmsg/sendpage routines
@@ -2094,63 +2005,3 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
-
-void
-nfsd_racache_shutdown(void)
-{
-	struct raparms *raparm, *last_raparm;
-	unsigned int i;
-
-	dprintk("nfsd: freeing readahead buffers.\n");
-
-	for (i = 0; i < RAPARM_HASH_SIZE; i++) {
-		raparm = raparm_hash[i].pb_head;
-		while(raparm) {
-			last_raparm = raparm;
-			raparm = raparm->p_next;
-			kfree(last_raparm);
-		}
-		raparm_hash[i].pb_head = NULL;
-	}
-}
-/*
- * Initialize readahead param cache
- */
-int
-nfsd_racache_init(int cache_size)
-{
-	int	i;
-	int	j = 0;
-	int	nperbucket;
-	struct raparms **raparm = NULL;
-
-
-	if (raparm_hash[0].pb_head)
-		return 0;
-	nperbucket = DIV_ROUND_UP(cache_size, RAPARM_HASH_SIZE);
-	nperbucket = max(2, nperbucket);
-	cache_size = nperbucket * RAPARM_HASH_SIZE;
-
-	dprintk("nfsd: allocating %d readahead buffers.\n", cache_size);
-
-	for (i = 0; i < RAPARM_HASH_SIZE; i++) {
-		spin_lock_init(&raparm_hash[i].pb_lock);
-
-		raparm = &raparm_hash[i].pb_head;
-		for (j = 0; j < nperbucket; j++) {
-			*raparm = kzalloc(sizeof(struct raparms), GFP_KERNEL);
-			if (!*raparm)
-				goto out_nomem;
-			raparm = &(*raparm)->p_next;
-		}
-		*raparm = NULL;
-	}
-
-	nfsdstats.ra_size = cache_size;
-	return 0;
-
-out_nomem:
-	dprintk("nfsd: kmalloc failed, freeing readahead buffers\n");
-	nfsd_racache_shutdown();
-	return -ENOMEM;
-}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 31fdae34e028..e0f7792165a6 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -40,8 +40,6 @@
 typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 
 /* nfsd/vfs.c */
-int		nfsd_racache_init(int);
-void		nfsd_racache_shutdown(void);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
@@ -80,7 +78,6 @@ __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
 __be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
-struct raparms;
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				unsigned long *count);
@@ -118,9 +115,6 @@ __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 				struct dentry *, int);
 
-struct raparms *nfsd_init_raparms(struct file *file);
-void		nfsd_put_raparams(struct file *file, struct raparms *ra);
-
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
-- 
2.21.0

