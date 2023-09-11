Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B679BA45
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbjIKV6m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243989AbjIKShA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 14:37:00 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBF21A5
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:36:55 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-655cee6f752so17135216d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694457414; x=1695062214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kP7iypwtX7pO39BGsBWfV+2MBf2gYf4BoqLo9DVTK+8=;
        b=mDvVWjyojPsRO2dQSMAn7aH/6T4AIxnimSwsZTNX/zs3p1RSG4dxlNOPv9iXm4GZ22
         xmZ1M9O6baoiJEUNziU94YUoQBZtrnYwp4G52NNWkv0KRhkiSAl8Qq3v3T09jl23N+nh
         CkLj0feyg+Du7kp9V+o+S6U3XMQLvCuynoHTJLVFGpYmDXivq/XDYjcOST+qDxUeR5gl
         VUA7rFf41pEVqcrVW3cijWQf1KPNLvdEjRd58LOIYYpnoTsOjQf0eqWWmA702a/jpEoF
         Kn45rlNeTLI30TWA/O1xqEIHez00pkLO1vuMEDh/nVyiMbjLz5DOkO+cCbZhin6sf/B2
         vGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694457414; x=1695062214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP7iypwtX7pO39BGsBWfV+2MBf2gYf4BoqLo9DVTK+8=;
        b=BCY6VrfqeoFyxE6chV0fpNBulT928DZmbB4KimSOBFXX4t3ZRk+hjqNNZQQ489nvHr
         6Zhfj4pMbc96/LA78nmW3DMrqkHWMPofIHSpBB8JuG3BZOR2A4MmjNvYhPMkXMp17WvX
         Kao9z8JhJt3HnfFJBiQH86p3KtK/7MXCtuoCHaOi40yup20/XS4z2buy1aTgE3VVi5TF
         SNoY1evHUifwlEfYkfrAxfbIU5pNvTFyG9/Z2DhUTJdRZEWW0mMI6JUDuNrd0qnh2XOk
         n3TbY/7ywgzs961BWsMfC+CVuGk87KIB2+VEzxr2MRiJI7Kf+2rf8NWJQQXlp3yj6Sz/
         3FoQ==
X-Gm-Message-State: AOJu0YznurbKpR0GQtyLEqMWwAjlD9zAwiUlzthqC6bphnkXtlsoc+Wb
        CPktg9rxXTsRG/ZzzaFCFJcUQOCZ0g==
X-Google-Smtp-Source: AGHT+IGIhgjO2wSwC96QqwS3jdeleyfUKyNmWFnvunsS+OdFPwG2uhgastp1XjqPDSf7vFidrNrIaQ==
X-Received: by 2002:a0c:c982:0:b0:649:b37f:46f6 with SMTP id b2-20020a0cc982000000b00649b37f46f6mr11839532qvk.13.1694457414365;
        Mon, 11 Sep 2023 11:36:54 -0700 (PDT)
Received: from localhost.localdomain (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id e19-20020a0caa53000000b0064f70c57531sm3150069qvb.57.2023.09.11.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:36:53 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Handle EOPENSTALE correctly in the filecache
Date:   Mon, 11 Sep 2023 14:30:27 -0400
Message-ID: <20230911183027.11372-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The nfsd_open code handles EOPENSTALE correctly, by retrying the call to
fh_verify() and __nfsd_open(). However the filecache just drops the
error on the floor, and immediately returns nfserr_stale to the caller.

This patch ensures that we propagate the EOPENSTALE code back to
nfsd_file_do_acquire, and that we handle it correctly.

Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 27 +++++++++++++++++++--------
 fs/nfsd/vfs.c       | 28 +++++++++++++---------------
 fs/nfsd/vfs.h       |  2 +-
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e0..07bf219f9ae4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -989,22 +989,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_file *new, *nf;
-	const struct cred *cred;
+	bool stale_retry = true;
 	bool open_retry = true;
 	struct inode *inode;
 	__be32 status;
 	int ret;
 
+retry:
 	status = fh_verify(rqstp, fhp, S_IFREG,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
 	if (status != nfs_ok)
 		return status;
 	inode = d_inode(fhp->fh_dentry);
-	cred = get_current_cred();
 
-retry:
 	rcu_read_lock();
-	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
+	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
 	rcu_read_unlock();
 
 	if (nf) {
@@ -1026,7 +1025,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	rcu_read_lock();
 	spin_lock(&inode->i_lock);
-	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
+	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
 	if (unlikely(nf)) {
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
@@ -1058,6 +1057,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto construction_err;
 		}
 		open_retry = false;
+		fh_put(fhp);
 		goto retry;
 	}
 	this_cpu_inc(nfsd_file_cache_hits);
@@ -1074,7 +1074,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_file_check_write_error(nf);
 		*pnf = nf;
 	}
-	put_cred(cred);
 	trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
 	return status;
 
@@ -1088,8 +1087,20 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfs_ok;
 			trace_nfsd_file_opened(nf, status);
 		} else {
-			status = nfsd_open_verified(rqstp, fhp, may_flags,
-						    &nf->nf_file);
+			ret = nfsd_open_verified(rqstp, fhp, may_flags,
+						 &nf->nf_file);
+			if (ret == -EOPENSTALE && stale_retry) {
+				stale_retry = false;
+				nfsd_file_unhash(nf);
+				clear_and_wake_up_bit(NFSD_FILE_PENDING,
+						      &nf->nf_flags);
+				if (refcount_dec_and_test(&nf->nf_ref))
+					nfsd_file_free(nf);
+				nf = NULL;
+				fh_put(fhp);
+				goto retry;
+			}
+			status = nfserrno(ret);
 			trace_nfsd_file_open(nf, status);
 		}
 	} else
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2c9074ab2315..98fa4fd0556d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -823,7 +823,7 @@ int nfsd_open_break_lease(struct inode *inode, int access)
  * and additional flags.
  * N.B. After this call fhp needs an fh_put
  */
-static __be32
+static int
 __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 			int may_flags, struct file **filp)
 {
@@ -831,14 +831,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	struct inode	*inode;
 	struct file	*file;
 	int		flags = O_RDONLY|O_LARGEFILE;
-	__be32		err;
-	int		host_err = 0;
+	int		host_err = -EPERM;
 
 	path.mnt = fhp->fh_export->ex_path.mnt;
 	path.dentry = fhp->fh_dentry;
 	inode = d_inode(path.dentry);
 
-	err = nfserr_perm;
 	if (IS_APPEND(inode) && (may_flags & NFSD_MAY_WRITE))
 		goto out;
 
@@ -847,7 +845,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 
 	host_err = nfsd_open_break_lease(inode, may_flags);
 	if (host_err) /* NOMEM or WOULDBLOCK */
-		goto out_nfserr;
+		goto out;
 
 	if (may_flags & NFSD_MAY_WRITE) {
 		if (may_flags & NFSD_MAY_READ)
@@ -859,13 +857,13 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	file = dentry_open(&path, flags, current_cred());
 	if (IS_ERR(file)) {
 		host_err = PTR_ERR(file);
-		goto out_nfserr;
+		goto out;
 	}
 
 	host_err = ima_file_check(file, may_flags);
 	if (host_err) {
 		fput(file);
-		goto out_nfserr;
+		goto out;
 	}
 
 	if (may_flags & NFSD_MAY_64BIT_COOKIE)
@@ -874,10 +872,8 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		file->f_mode |= FMODE_32BITHASH;
 
 	*filp = file;
-out_nfserr:
-	err = nfserrno(host_err);
 out:
-	return err;
+	return host_err;
 }
 
 __be32
@@ -885,6 +881,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		int may_flags, struct file **filp)
 {
 	__be32 err;
+	int host_err;
 	bool retried = false;
 
 	validate_process_creds();
@@ -904,12 +901,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 retry:
 	err = fh_verify(rqstp, fhp, type, may_flags);
 	if (!err) {
-		err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
-		if (err == nfserr_stale && !retried) {
+		host_err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
+		if (host_err == -EOPENSTALE && !retried) {
 			retried = true;
 			fh_put(fhp);
 			goto retry;
 		}
+		err = nfserrno(host_err);
 	}
 	validate_process_creds();
 	return err;
@@ -922,13 +920,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
  * @may_flags: internal permission flags
  * @filp: OUT: open "struct file *"
  *
- * Returns an nfsstat value in network byte order.
+ * Returns a posix error.
  */
-__be32
+int
 nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
 		   struct file **filp)
 {
-	__be32 err;
+	int err;
 
 	validate_process_creds();
 	err = __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index a6890ea7b765..e4b7207ef2e0 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -104,7 +104,7 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
-__be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
+int		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
 				int, struct file **);
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
-- 
2.41.0

