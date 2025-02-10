Return-Path: <linux-nfs+bounces-10015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B6A2F366
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 17:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43472160EA7
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36A2580ED;
	Mon, 10 Feb 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2fA2IgC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E082580D6
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204757; cv=none; b=bLvC3Y9hZkDiHTvnjTYxBPrK4s9w+xzPOQkVXJN9z7fhDAhIeLSq0pvdAJgsQuRPXSzMkSq+uzgDECzZuMwOu71ei2odimDMBn+X6MmguVsqQKSfroVIeLlKwXG06VMG+BmgctQBcRE1eAJeu1n6mwmDeRhdi5KIcFu/qWp9R0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204757; c=relaxed/simple;
	bh=V2y9So9Ortmhqbm5JD2EFIymrB45ymasPAnsbItIxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyBmOtHyg/lwxhnjmWD74Y2yvyK+8wpMEUnX0w7Xru9XgGB8e21z5gOefi9OQGvKK7oWz4ICmiyFwH5cCSDSH4QD3JvxSWPElHXAzH0DsGRePlL6SRBXk04pYfbbAc2uTtl6oaM9AFCGPqDP5u21rjFmbOwIDEqGnu3rMD81DR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2fA2IgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2504AC4CED1;
	Mon, 10 Feb 2025 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739204756;
	bh=V2y9So9Ortmhqbm5JD2EFIymrB45ymasPAnsbItIxDo=;
	h=From:To:Cc:Subject:Date:From;
	b=t2fA2IgCvdYl6GEPGAJ6C9e7/4J4Oa35p3NQvJhBOvzcmNPWZ7I5ad1l/z/bQFzkj
	 IUcpkFL1XZ5rxGMr0ImseblYyKIIhwFi6jF6TCdDM0Mzjh/VF2V9H3pmuZDWuagymS
	 kQWuepemfcPsX7DEMUHGwiWb6tV+3+o76Rh5KtTBNXP5cHAtZuxy6i55OFGRAeTtFQ
	 //grOtSbkLbdoweYzdogmRc7I9Dw2Fc3QNwZz25QBk6kW1u5/H18o2qZivX+03sYVR
	 knqMS0zK04qPZeeEcfecUytDulbx00ozG/28/lSdgCgRKt7tbI87EedCORKYYJut0X
	 9kJxJO57dBbTA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v4] nfsd: disallow file locking and delegations for NFSv4 reexport
Date: Mon, 10 Feb 2025 11:25:53 -0500
Message-ID: <20250210162553.112705-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

We do not and cannot support file locking with NFS reexport over
NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
server reboot cannot allow clients to recover locks because the source
NFS server has not rebooted, and so it is not in grace.  Since the
source NFS server is not in grace, it cannot offer any guarantees that
the file won't have been changed between the locks getting lost and
any attempt to recover/reclaim them.  The same applies to delegations
and any associated locks, so disallow them too.

Clients are no longer allowed to get file locks or delegations from a
reexport server, any attempts will fail with operation not supported.

Update the "Reboot recovery" section accordingly in
Documentation/filesystems/nfs/reexport.rst

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/filesystems/nfs/reexport.rst | 10 +++++++---
 fs/nfs/export.c                            |  3 ++-
 fs/nfsd/nfs4state.c                        | 18 ++++++++++++++++++
 include/linux/exportfs.h                   | 14 +++++++++++++-
 4 files changed, 40 insertions(+), 5 deletions(-)


Jeff and I believe that it is better to prevent data corruption for
now than to continue to enable risky use cases. Thus I've forward-
ported this patch to v6.14-rc2 and intend to include it in the
nfsd-6.15 pull request.

We remain open to considering solutions that enable locking through
to the back-end NFS server with appropriate lock recovery.


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
index be686b8e0c54..e9c233b6fd20 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -154,5 +154,6 @@ const struct export_operations nfs_export_ops = {
 		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
 		 EXPORT_OP_REMOTE_FS		|
 		 EXPORT_OP_NOATOMIC_ATTR	|
-		 EXPORT_OP_FLUSH_ON_CLOSE,
+		 EXPORT_OP_FLUSH_ON_CLOSE	|
+		 EXPORT_OP_NOLOCKS,
 };
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b42e2ab7a042..f0fb6ca4b70c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6000,6 +6000,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!nf)
 		return ERR_PTR(-EAGAIN);
 
+	/*
+	 * File delegations and associated locks cannot be recovered if the
+	 * export is from an NFS proxy server.
+	 */
+	if (exportfs_cannot_lock(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
+		nfsd_file_put(nf);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
 	if (nfs4_delegation_exists(clp, fp))
@@ -8140,6 +8149,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0);
 	if (status != nfs_ok)
 		return status;
+	if (exportfs_cannot_lock(cstate->current_fh.fh_dentry->d_sb->s_export_op)) {
+		status = nfserr_notsupp;
+		goto out;
+	}
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -8479,6 +8492,11 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfserr_lock_range;
 		goto put_stateid;
 	}
+	if (exportfs_cannot_lock(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
+		status = nfserr_notsupp;
+		goto put_file;
+	}
+
 	file_lock = locks_alloc_lock();
 	if (!file_lock) {
 		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 4cc8801e50e3..ca6c605072c7 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -259,10 +259,22 @@ struct export_operations {
 						  atomic attribute updates
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
-#define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
+#define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
 	unsigned long	flags;
 };
 
+/**
+ * exportfs_cannot_lock() - check if export implements file locking
+ * @export_ops:	the nfs export operations to check
+ *
+ * Returns true if the export does not support file locking.
+ */
+static inline bool
+exportfs_cannot_lock(const struct export_operations *export_ops)
+{
+	return export_ops->flags & EXPORT_OP_NOLOCKS;
+}
+
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent,
 				    int flags);
-- 
2.47.0


