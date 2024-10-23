Return-Path: <linux-nfs+bounces-7391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C629ACE06
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA771F21F10
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7751C3039;
	Wed, 23 Oct 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th+XB5jh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BD1C231D
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695278; cv=none; b=jPwQF1SOdOwCIlFTsc5XyZofNXlztD8gmcYmz5f+pJYtw6DNuly2m3eO0oe4TNyhGC4VZrJJIzgcFQiKSg8AI6UgphY48nZ5mxYWeuJDCmXwfY8aq0vdpPk65J8IswzPy0E/MMYoLcjiG0+nvM8tWOe5sIircRiPDCRerBv/vXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695278; c=relaxed/simple;
	bh=jtBwQROSmLdUD7/5xYw04knKB9mfwdRiFcjfl0Ml3Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRy4RXUwqycuN6O1rv9HUGZcM/XPrLzuqaOwUwytpfgpUfUXUbitDpjdWeDpc1Gm5MS1WA05WRY7u55OjCZFjDVC5wf3CvZr+i6SfDyoPddhnchygSCzKerpfb8isk7XDR9BrkIH8eGqgxnUVi5Ef1y6pw/VApV7CMpIQPZLhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th+XB5jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12E9C4CEC6;
	Wed, 23 Oct 2024 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729695278;
	bh=jtBwQROSmLdUD7/5xYw04knKB9mfwdRiFcjfl0Ml3Gs=;
	h=From:To:Cc:Subject:Date:From;
	b=Th+XB5jhz2mULw3mgcMj5snrnMs/dj5M2E8D9nR7LcAGekxzOVs73YquhenqWEAds
	 WE0bpHTe32IJO/U8nYVo8TDmLCSYqwsRdL2LCJ6kwNW53de9exZCJw/hrQ3ZZ1X5r/
	 SivTGu9dh4WBCACmWU6tVcA5pz0zyIZDKiYytc8vP9noAkzjW/zHqK9r4r6AeYDTPO
	 IdrqzUyR4GFI/oSRt3n4AXTI+vTMVnNSWaYmXzecjjIn77p9V3Pwx9pDSFyH9jKdfC
	 nlPasj68ENSyiEKsvj1f4De/QZobobjm5Y7afwzRB9cWG4wweT54vWrx8FZNGWkOWA
	 Csk//s/NJUoHw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] nfsd: disallow file locking and delegations for NFSv4 proxy
Date: Wed, 23 Oct 2024 10:54:36 -0400
Message-ID: <20241023145436.63240-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not and cannot support NFS proxy server file locking over
NFSv4.x for the same reason we don't do it for NFSv3: NFS proxy server
reboot cannot allow clients to recover locks because the source NFS
server has not rebooted, and so it is not in grace.  Since the source
NFS server is not in grace, it cannot offer any guarantees that the
file won't have been changed between the locks getting lost and any
attempt to recover/reclaim them.  The same applies to delegations and
any associated locks, so disallow them too.

Add EXPORT_OP_NOLOCKSUPPORT and exportfs_lock_op_is_unsupported(), set
EXPORT_OP_NOLOCKSUPPORT in nfs_export_ops and check for it in
nfsd4_lock(), nfsd4_locku() and nfs4_set_delegation().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/export.c          |  3 ++-
 fs/nfsd/nfs4state.c      | 20 ++++++++++++++++++++
 include/linux/exportfs.h | 14 ++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

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


