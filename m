Return-Path: <linux-nfs+bounces-16005-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C93C31C1B
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 16:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA361883506
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6EB661;
	Tue,  4 Nov 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAd/l1nD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A0224244
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268808; cv=none; b=VLtV3YqkcM02y8QfPQngEsYbpxU7lgFwnihD70C8OW/TbBn/E84B192mjxUg5hZQ2MuAZqUyNX6sPFwipmyCBX4pJ0uIlGjkrmsFp7RntpTMTyvdP16VQhk7UgDrG5uQN5X/iDM0NTPeILgplTumw0k2I9QWeYkxrq4ALAqB3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268808; c=relaxed/simple;
	bh=sQxUpvc6yiF1qd0r73C7hKubJ76Cpe2gHORvPMGXKA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XW1TDmeVl6vH4sxprLWn3zNL3BL2az8l6Fi8sHAOxIilnq0k8my60tOgT4aENukOtojilz6sf+KjZfj03DMifm+6hV1Ay2q9EO7wioDk0+O2S7PLeoNYvu1a0GBgDRWCup6GAIq+T9bV31W8TAspgsJT56C6969hHuG0eRb2HgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAd/l1nD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F02AC16AAE;
	Tue,  4 Nov 2025 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268807;
	bh=sQxUpvc6yiF1qd0r73C7hKubJ76Cpe2gHORvPMGXKA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAd/l1nDKxLQ2RFcGIHJJ+G8YWjtGupbMMizoFqMwqM82ctKO3azSeIzp9wiih6IB
	 MhKP+8dwAG9RkDSp+DqZwNcOf8adZ1EK+eYH3eUr3/hlgQW+3ypAJUViwQPAhU7TW7
	 +JVZORjy0GhBSLHu1+s+dNQ9qX63wP+de2v5juZyViEHQXAx8KqLAbBj6UxPxQEsJg
	 e/14mZyuoOMw6PtcdYEV7PdtelcbjNHBb/GiBlMjdTpLoiJhJPkkAWZt2g1DUPC7KR
	 hvwN7SVexf3F7HpQrpPFJRQh4tI/mRQS5J92NcxiQfFom14HdFJSVXzlizpCWGh2ml
	 Rdpc3CNMX/Y6A==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 2/5] NFS: Request a directory delegation on ACCESS, CREATE, and UNLINK
Date: Tue,  4 Nov 2025 10:06:42 -0500
Message-ID: <20251104150645.719865-3-anna@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104150645.719865-1-anna@kernel.org>
References: <20251104150645.719865-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This patch adds a new flag: NFS_INO_REQ_DIR_DELEG to signal that a
directory wants to request a directory delegation the next time it does
a GETATTR. I have the client request a directory delegation when doing
an access, create, or unlink call since these calls indicate that a user
is working with a directory.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/delegation.c       |  1 +
 fs/nfs/delegation.h       |  6 +++++
 fs/nfs/nfs4proc.c         | 55 ++++++++++++++++++++++++++++++++++++---
 include/linux/nfs_fs.h    |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 5 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 9d3a5f29f17f..b4c192f00e94 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -379,6 +379,7 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 	delegation->inode = NULL;
 	rcu_assign_pointer(nfsi->delegation, NULL);
 	spin_unlock(&delegation->lock);
+	clear_bit(NFS_INO_REQ_DIR_DELEG, &nfsi->flags);
 	return delegation;
 }
 
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 08ec2e9c68a4..def50e8a83bf 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -124,6 +124,12 @@ static inline int nfs_have_delegated_mtime(struct inode *inode)
 						 NFS_DELEGATION_FLAG_TIME);
 }
 
+static inline void nfs_request_directory_delegation(struct inode *inode)
+{
+	if (S_ISDIR(inode->i_mode))
+		set_bit(NFS_INO_REQ_DIR_DELEG, &NFS_I(inode)->flags);
+}
+
 int nfs4_delegation_hash_alloc(struct nfs_server *server);
 
 #endif
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 411776718494..bd718a270e72 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4460,6 +4460,28 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 	return status;
 }
 
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+static bool should_request_dir_deleg(struct inode *inode)
+{
+	if (!inode)
+		return false;
+	if (!S_ISDIR(inode->i_mode))
+		return false;
+	if (!nfs_server_capable(inode, NFS_CAP_DIR_DELEG))
+		return false;
+	if (!test_and_clear_bit(NFS_INO_REQ_DIR_DELEG, &(NFS_I(inode)->flags)))
+		return false;
+	if (nfs4_have_delegation(inode, FMODE_READ, 0))
+		return false;
+	return true;
+}
+#else
+static bool should_request_dir_deleg(struct inode *inode)
+{
+	return false;
+}
+#endif /* CONFIG_NFS_V4_1 */
+
 static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr, struct inode *inode)
 {
@@ -4477,7 +4499,9 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
+	struct nfs4_gdd_res gdd_res;
 	unsigned short task_flags = 0;
+	int status;
 
 	if (nfs4_has_session(server->nfs_client))
 		task_flags = RPC_TASK_MOVEABLE;
@@ -4486,11 +4510,26 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
 		task_flags |= RPC_TASK_TIMEOUT;
 
+	args.get_dir_deleg = should_request_dir_deleg(inode);
+	if (args.get_dir_deleg)
+		res.gdd_res = &gdd_res;
+
 	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label), inode, 0);
 	nfs_fattr_init(fattr);
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
-	return nfs4_do_call_sync(server->client, server, &msg,
-			&args.seq_args, &res.seq_res, task_flags);
+
+	status = nfs4_do_call_sync(server->client, server, &msg,
+				   &args.seq_args, &res.seq_res, task_flags);
+	if (args.get_dir_deleg) {
+		if (status == -EOPNOTSUPP) {
+			server->caps &= ~NFS_CAP_DIR_DELEG;
+		} else if (status == 0 && gdd_res.status == GDD4_OK) {
+			status = nfs_inode_set_delegation(inode, current_cred(),
+							  FMODE_READ, &gdd_res.deleg,
+							  0, NFS4_OPEN_DELEGATE_READ);
+		}
+	}
+	return status;
 }
 
 int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
@@ -4503,8 +4542,10 @@ int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	do {
 		err = _nfs4_proc_getattr(server, fhandle, fattr, inode);
 		trace_nfs4_getattr(server, fhandle, fattr, err);
-		err = nfs4_handle_exception(server, err,
-				&exception);
+		if (err == -EOPNOTSUPP)
+			exception.retry = true;
+		else
+			err = nfs4_handle_exception(server, err, &exception);
 	} while (exception.retry);
 	return err;
 }
@@ -4765,6 +4806,7 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 	int status = 0;
 
 	if (!nfs4_have_delegation(inode, FMODE_READ, 0)) {
+		nfs_request_directory_delegation(inode);
 		res.fattr = nfs_alloc_fattr();
 		if (res.fattr == NULL)
 			return -ENOMEM;
@@ -4872,6 +4914,8 @@ nfs4_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 
 	ilabel = nfs4_label_init_security(dir, dentry, sattr, &l);
 
+	nfs_request_directory_delegation(dir);
+
 	if (!(server->attr_bitmask[2] & FATTR4_WORD2_MODE_UMASK))
 		sattr->ia_mode &= ~current_umask();
 	state = nfs4_do_open(dir, ctx, flags, sattr, ilabel, NULL);
@@ -4968,6 +5012,7 @@ static void nfs4_proc_unlink_setup(struct rpc_message *msg,
 	nfs4_init_sequence(&args->seq_args, &res->seq_res, 1, 0);
 
 	nfs_fattr_init(res->dir_attr);
+	nfs_request_directory_delegation(d_inode(dentry->d_parent));
 
 	if (inode) {
 		nfs4_inode_return_delegation(inode);
@@ -10819,6 +10864,7 @@ static const struct nfs4_minor_version_ops nfs_v4_1_minor_ops = {
 	.minor_version = 1,
 	.init_caps = NFS_CAP_READDIRPLUS
 		| NFS_CAP_ATOMIC_OPEN
+		| NFS_CAP_DIR_DELEG
 		| NFS_CAP_POSIX_LOCK
 		| NFS_CAP_STATEID_NFSV41
 		| NFS_CAP_ATOMIC_OPEN_V1
@@ -10845,6 +10891,7 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 	.minor_version = 2,
 	.init_caps = NFS_CAP_READDIRPLUS
 		| NFS_CAP_ATOMIC_OPEN
+		| NFS_CAP_DIR_DELEG
 		| NFS_CAP_POSIX_LOCK
 		| NFS_CAP_STATEID_NFSV41
 		| NFS_CAP_ATOMIC_OPEN_V1
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index c585939b6cd6..a6624edb7226 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -344,6 +344,7 @@ struct nfs4_copy_state {
 #define NFS_INO_LAYOUTCOMMITTING (10)		/* layoutcommit inflight */
 #define NFS_INO_LAYOUTSTATS	(11)		/* layoutstats inflight */
 #define NFS_INO_ODIRECT		(12)		/* I/O setting is O_DIRECT */
+#define NFS_INO_REQ_DIR_DELEG	(13)		/* Request a directory delegation */
 
 static inline struct nfs_inode *NFS_I(const struct inode *inode)
 {
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d30c0245031c..4ba04de6b1ca 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -305,6 +305,7 @@ struct nfs_server {
 #define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
 #define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
 #define NFS_CAP_ZERO_RANGE	(1U << 10)
+#define NFS_CAP_DIR_DELEG	(1U << 11)
 #define NFS_CAP_OPEN_XOR	(1U << 12)
 #define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
-- 
2.51.2


