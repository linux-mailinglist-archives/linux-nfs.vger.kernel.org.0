Return-Path: <linux-nfs+bounces-7394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C79ACFAB
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3775DB23CCE
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56C31C876D;
	Wed, 23 Oct 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7jaFKyH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE01A76BC
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699128; cv=none; b=ge2JaGcYFNmPXu8AmkIaMppJqmVqwHoZ5B5mR2FIPiot8muiIb66FAk7DPeHTXgFvkREcCgvBjIJ/AWKl691dSd5FqE6/nWBw/YJRgga/CKk6sEN+f1uGg0IfaP5SWiPsWlFsDZtyFLA1yjkb+rd5zeW6q0WbCi0DoTo5CCSdO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699128; c=relaxed/simple;
	bh=FNPcsJGoiMllQlxQHyJyYIeSjm3xLDOulVKEnZfm7Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ang/ypFxeifWeG1EFZg8nRdIB1TmbrqunWJZ8FmPDc6/lbpyr+/s3KeEf+t21F6iRMYAT0VQa6GWawYiiDXDKA9ch1ZJnzUJMrbDKaH1o+th8fj+pXw8qRI53NsOFX+Ru4zqaHpMZa/Xb42TTuJ7RmQ9iOdH1rpYbpzfThSBoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7jaFKyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B848EC4CEC6;
	Wed, 23 Oct 2024 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729699128;
	bh=FNPcsJGoiMllQlxQHyJyYIeSjm3xLDOulVKEnZfm7Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7jaFKyH5Gc4dt3F40e8zw8ofpL1cvJaoWJkOpmlEiwYkg3A2VeEqvYhOjYV45kQm
	 NLSt5HTJeofvyYt/RiFRyR2Tv+JcFobeq3bOvvwvTIPkRqDdAO3/ev8rLkGQ0IlmT5
	 qD93OA4CTxY5RwAN9Xa0YqQ9IDlsJjUYP5+U3Qgr2JgdnL5oyRWNu4cOm89C5I0g5n
	 oFhRW6M9NeesFnFMOiTLNf6GqfXLhVafINJvkqT3k/3YzcpqvC2TqmwpksSbJuDu5A
	 B38WTmbFtC/5v6BsLg3cgKdALfWtjbsy2O1VTWPmP87GKhZSqCE3h10/xZ/SYcz60F
	 Nbhel0qiDDxPg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
Date: Wed, 23 Oct 2024 11:58:46 -0400
Message-ID: <20241023155846.63621-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241023152940.63479-1-snitzer@kernel.org>
References: <20241023152940.63479-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not and cannot support file locking with NFS reexport over
NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
server reboot cannot allow clients to recover locks because the source
NFS server has not rebooted, and so it is not in grace.  Since the
source NFS server is not in grace, it cannot offer any guarantees that
the file won't have been changed between the locks getting lost and
any attempt to recover/reclaim them.  The same applies to delegations
and any associated locks, so disallow them too.

Add EXPORT_OP_NOLOCKSUPPORT and exportfs_lock_op_is_unsupported(), set
EXPORT_OP_NOLOCKSUPPORT in nfs_export_ops and check for it in
nfsd4_lock(), nfsd4_locku() and nfs4_set_delegation().  Clients are
not allowed to get file locks or delegations from a reexport server,
any attempts will fail with operation not supported.

Update the "Reboot recovery" section accordingly in
Documentation/filesystems/nfs/reexport.rst

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/reexport.rst | 10 +++++++---
 fs/nfs/export.c                            |  3 ++-
 fs/nfsd/nfs4state.c                        | 20 ++++++++++++++++++++
 include/linux/exportfs.h                   | 14 ++++++++++++++
 4 files changed, 43 insertions(+), 4 deletions(-)

v3: refine the patch header and reexport.rst to be clear that both
    locks and delegations will fail against an NFS reexport server.

diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/filesystems/nfs/reexport.rst
index ff9ae4a46530..044be965d75e 100644
--- a/Documentation/filesystems/nfs/reexport.rst
+++ b/Documentation/filesystems/nfs/reexport.rst
@@ -26,9 +26,13 @@ Reboot recovery
 ---------------
 
 The NFS protocol's normal reboot recovery mechanisms don't work for the
-case when the reexport server reboots.  Clients will lose any locks
-they held before the reboot, and further IO will result in errors.
-Closing and reopening files should clear the errors.
+case when the reexport server reboots because the source server has not
+rebooted, and so it is not in grace.  Since the source server is not in
+grace, it cannot offer any guarantees that the file won't have been
+changed between the locks getting lost and any attempt to recover them.
+The same applies to delegations and any associated locks.  Clients are
+not allowed to get file locks or delegations from a reexport server, any
+attempts will fail with operation not supported.
 
 Filehandle limits
 -----------------
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index be686b8e0c54..2f001a0273bc 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -154,5 +154,6 @@ const struct export_operations nfs_export_ops = {
 		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
 		 EXPORT_OP_REMOTE_FS		|
 		 EXPORT_OP_NOATOMIC_ATTR	|
-		 EXPORT_OP_FLUSH_ON_CLOSE,
+		 EXPORT_OP_FLUSH_ON_CLOSE	|
+		 EXPORT_OP_NOLOCKSUPPORT,
 };
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ac1859c7cc9d..63297ea82e4e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5813,6 +5813,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!nf)
 		return ERR_PTR(-EAGAIN);
 
+	/*
+	 * File delegations and associated locks cannot be recovered if
+	 * export is from NFS proxy server.
+	 */
+	if (exportfs_lock_op_is_unsupported(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
+		nfsd_file_put(nf);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
 	if (nfs4_delegation_exists(clp, fp))
@@ -7917,6 +7926,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	sb = cstate->current_fh.fh_dentry->d_sb;
 
+	if (exportfs_lock_op_is_unsupported(sb->s_export_op)) {
+		status = nfserr_notsupp;
+		goto out;
+	}
+
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
 			/* See rfc 5661 18.10.3: given clientid is ignored: */
@@ -8266,6 +8280,12 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfserr_lock_range;
 		goto put_stateid;
 	}
+
+	if (exportfs_lock_op_is_unsupported(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
+		status = nfserr_notsupp;
+		goto put_file;
+	}
+
 	file_lock = locks_alloc_lock();
 	if (!file_lock) {
 		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 893a1d21dc1c..106fd590d323 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -247,6 +247,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
+#define EXPORT_OP_NOLOCKSUPPORT		(0x80) /* no file locking support */
 	unsigned long	flags;
 };
 
@@ -263,6 +264,19 @@ exportfs_lock_op_is_async(const struct export_operations *export_ops)
 	return export_ops->flags & EXPORT_OP_ASYNC_LOCK;
 }
 
+/**
+ * exportfs_lock_op_is_unsupported() - export does not support file locking
+ * @export_ops:	the nfs export operations to check
+ *
+ * Returns true if the nfs export_operations structure has
+ * EXPORT_OP_NOLOCKSUPPORT in their flags set
+ */
+static inline bool
+exportfs_lock_op_is_unsupported(const struct export_operations *export_ops)
+{
+	return export_ops->flags & EXPORT_OP_NOLOCKSUPPORT;
+}
+
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent,
 				    int flags);
-- 
2.44.0


