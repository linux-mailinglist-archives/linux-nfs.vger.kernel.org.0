Return-Path: <linux-nfs+bounces-3865-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D02190A1B6
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AEF281463
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5407EAC5;
	Mon, 17 Jun 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPIcAeL3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AADDDDA
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587512; cv=none; b=rPMsKbA3m1NubRcNRn+3e1XDkGaXpOuC7YGd4xGqAzqwmkl3NPFtRsUomsX1ayv5aYCcQj2QYgbBBJWZ310i5oj3Hvo8PwGWKeUUT4hJhhnvflQuMnlyBVC/2Nk5r1ODQtyzgBy5mPe+c8kddPXlJB6swjF7c54NRkeSWykwFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587512; c=relaxed/simple;
	bh=JrvP2wtsZ4uDSVVA0lgcRIBFKJtr18IhO4Oyf+SiPIc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTVc6fx1e96WalJKYQYGGfKziNgeNEBqscxWD7VHLZ7DHn6zgnG3H6nlwWuJSWWUUHae4PHmT+0fSfAC7V2pNB8tt1VBqR7Oz0OxcRG6ePF1BFkEEj7dFqwewkpJPj7KDkVStytZEw9xYfsrrLc5W5UPjA3OwCANLV1ra9D07ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPIcAeL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15129C4AF1C
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587512;
	bh=JrvP2wtsZ4uDSVVA0lgcRIBFKJtr18IhO4Oyf+SiPIc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vPIcAeL3/q4oI4K5gMTYup2XJrShkDl9s2N5hhwb9iu2UpwhOoKKoFiVm7LtHzx5r
	 P1Usnp3YVfzbzMldy9qKSpaOTwc+S1Q85fzHr83f+mCbpz+sSeLXJWJGyXgm5p/ryW
	 jLIrJK1VSvXyBy6qMlCgK3N16B6aO2+fvlAjh/6WxOpnzBro8sXa6OnevRJmsfhzqp
	 eQ3dTE1c1KC85Ga1J7RUa+wnC95muRSTsMIwMswebxx2WmV6Hsg2GuKcJRHAXHQb5M
	 hEa6QWd7Zf4B5TAMzug+sweHqbpnhfFqzZkT4+5jee7JcObbzrD0COeuKPnP9eD8F7
	 FUYewEsGh6dxg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 06/19] NFSv4: Add a flags argument to the 'have_delegation' callback
Date: Sun, 16 Jun 2024 21:21:24 -0400
Message-ID: <20240617012137.674046-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-6-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

This argument will be used to allow the caller to specify whether or not
they need to know that this is an attribute delegation.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c     | 26 +++++++++++++-------------
 fs/nfs/delegation.h     | 16 +++++++++++++---
 fs/nfs/dir.c            |  2 +-
 fs/nfs/file.c           |  4 ++--
 fs/nfs/inode.c          |  7 +++----
 fs/nfs/nfs3proc.c       |  2 +-
 fs/nfs/nfs4proc.c       | 14 +++++++-------
 fs/nfs/proc.c           |  2 +-
 fs/nfs/write.c          |  2 +-
 include/linux/nfs_xdr.h |  2 +-
 10 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6bace5fece04..6fdffd25cb2b 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -82,11 +82,10 @@ static void nfs_mark_return_delegation(struct nfs_server *server,
 	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
 }
 
-static bool
-nfs4_is_valid_delegation(const struct nfs_delegation *delegation,
-		fmode_t flags)
+static bool nfs4_is_valid_delegation(const struct nfs_delegation *delegation,
+				     fmode_t type)
 {
-	if (delegation != NULL && (delegation->type & flags) == flags &&
+	if (delegation != NULL && (delegation->type & type) == type &&
 	    !test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) &&
 	    !test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
 		return true;
@@ -103,16 +102,16 @@ struct nfs_delegation *nfs4_get_valid_delegation(const struct inode *inode)
 	return NULL;
 }
 
-static int
-nfs4_do_check_delegation(struct inode *inode, fmode_t flags, bool mark)
+static int nfs4_do_check_delegation(struct inode *inode, fmode_t type,
+				    int flags, bool mark)
 {
 	struct nfs_delegation *delegation;
 	int ret = 0;
 
-	flags &= FMODE_READ|FMODE_WRITE;
+	type &= FMODE_READ|FMODE_WRITE;
 	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
-	if (nfs4_is_valid_delegation(delegation, flags)) {
+	if (nfs4_is_valid_delegation(delegation, type)) {
 		if (mark)
 			nfs_mark_delegation_referenced(delegation);
 		ret = 1;
@@ -124,22 +123,23 @@ nfs4_do_check_delegation(struct inode *inode, fmode_t flags, bool mark)
  * nfs4_have_delegation - check if inode has a delegation, mark it
  * NFS_DELEGATION_REFERENCED if there is one.
  * @inode: inode to check
- * @flags: delegation types to check for
+ * @type: delegation types to check for
+ * @flags: various modifiers
  *
  * Returns one if inode has the indicated delegation, otherwise zero.
  */
-int nfs4_have_delegation(struct inode *inode, fmode_t flags)
+int nfs4_have_delegation(struct inode *inode, fmode_t type, int flags)
 {
-	return nfs4_do_check_delegation(inode, flags, true);
+	return nfs4_do_check_delegation(inode, type, flags, true);
 }
 
 /*
  * nfs4_check_delegation - check if inode has a delegation, do not mark
  * NFS_DELEGATION_REFERENCED if it has one.
  */
-int nfs4_check_delegation(struct inode *inode, fmode_t flags)
+int nfs4_check_delegation(struct inode *inode, fmode_t type)
 {
-	return nfs4_do_check_delegation(inode, flags, false);
+	return nfs4_do_check_delegation(inode, type, 0, false);
 }
 
 static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_stateid *stateid)
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index a6f495d012cf..257b3d726043 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -75,8 +75,8 @@ bool nfs4_refresh_delegation_stateid(nfs4_stateid *dst, struct inode *inode);
 
 struct nfs_delegation *nfs4_get_valid_delegation(const struct inode *inode);
 void nfs_mark_delegation_referenced(struct nfs_delegation *delegation);
-int nfs4_have_delegation(struct inode *inode, fmode_t flags);
-int nfs4_check_delegation(struct inode *inode, fmode_t flags);
+int nfs4_have_delegation(struct inode *inode, fmode_t type, int flags);
+int nfs4_check_delegation(struct inode *inode, fmode_t type);
 bool nfs4_delegation_flush_on_close(const struct inode *inode);
 void nfs_inode_find_delegation_state_and_recover(struct inode *inode,
 		const nfs4_stateid *stateid);
@@ -84,9 +84,19 @@ int nfs4_inode_make_writeable(struct inode *inode);
 
 #endif
 
+static inline int nfs_have_read_or_write_delegation(struct inode *inode)
+{
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
+}
+
+static inline int nfs_have_write_delegation(struct inode *inode)
+{
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE, 0);
+}
+
 static inline int nfs_have_delegated_attributes(struct inode *inode)
 {
-	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ);
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
 }
 
 #endif
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 07a7be27182e..4cb97ef41350 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1437,7 +1437,7 @@ static void nfs_set_verifier_locked(struct dentry *dentry, unsigned long verf)
 
 	if (!dir || !nfs_verify_change_attribute(dir, verf))
 		return;
-	if (inode && NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+	if (inode && NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0))
 		nfs_set_verifier_delegated(&verf);
 	dentry->d_time = verf;
 }
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 7f1295475a90..834e612262e6 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -732,7 +732,7 @@ do_getlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 	}
 	fl->c.flc_type = saved_type;
 
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+	if (nfs_have_read_or_write_delegation(inode))
 		goto out_noconflict;
 
 	if (is_local)
@@ -815,7 +815,7 @@ do_setlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 	 * This makes locking act as a cache coherency point.
 	 */
 	nfs_sync_mapping(filp->f_mapping);
-	if (!NFS_PROTO(inode)->have_delegation(inode, FMODE_READ)) {
+	if (!nfs_have_read_or_write_delegation(inode)) {
 		nfs_zap_caches(inode);
 		if (mapping_mapped(filp->f_mapping))
 			nfs_revalidate_mapping(inode, filp->f_mapping);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 6d185af4cb29..1363cb082ea0 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -190,9 +190,8 @@ static bool nfs_has_xattr_cache(const struct nfs_inode *nfsi)
 void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	bool have_delegation = NFS_PROTO(inode)->have_delegation(inode, FMODE_READ);
 
-	if (have_delegation) {
+	if (nfs_have_delegated_attributes(inode)) {
 		if (!(flags & NFS_INO_REVAL_FORCED))
 			flags &= ~(NFS_INO_INVALID_MODE |
 				   NFS_INO_INVALID_OTHER |
@@ -1013,7 +1012,7 @@ void nfs_close_context(struct nfs_open_context *ctx, int is_sync)
 	if (!is_sync)
 		return;
 	inode = d_inode(ctx->dentry);
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+	if (nfs_have_read_or_write_delegation(inode))
 		return;
 	nfsi = NFS_I(inode);
 	if (inode->i_mapping->nrpages == 0)
@@ -1483,7 +1482,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	unsigned long invalid = 0;
 	struct timespec64 ts;
 
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+	if (nfs_have_delegated_attributes(inode))
 		return 0;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 74bda639a7cf..cab6c73d25d6 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -979,7 +979,7 @@ nfs3_proc_lock(struct file *filp, int cmd, struct file_lock *fl)
 	return status;
 }
 
-static int nfs3_have_delegation(struct inode *inode, fmode_t flags)
+static int nfs3_have_delegation(struct inode *inode, fmode_t type, int flags)
 {
 	return 0;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index af0758210162..4455ee510c2f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -293,7 +293,7 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	unsigned long cache_validity;
 
 	memcpy(dst, src, NFS4_BITMASK_SZ*sizeof(*dst));
-	if (!inode || !nfs4_have_delegation(inode, FMODE_READ))
+	if (!inode || !nfs_have_read_or_write_delegation(inode))
 		return;
 
 	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity) | flags;
@@ -1264,7 +1264,7 @@ nfs4_update_changeattr_locked(struct inode *inode,
 		if (S_ISDIR(inode->i_mode))
 			nfs_force_lookup_revalidate(inode);
 
-		if (!NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+		if (!nfs_have_delegated_attributes(inode))
 			cache_validity |=
 				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
@@ -3700,7 +3700,7 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 
 	if (calldata->arg.fmode == 0 || calldata->arg.fmode == FMODE_READ) {
 		/* Close-to-open cache consistency revalidation */
-		if (!nfs4_have_delegation(inode, FMODE_READ)) {
+		if (!nfs4_have_delegation(inode, FMODE_READ, 0)) {
 			nfs4_bitmask_set(calldata->arg.bitmask_store,
 					 server->cache_consistency_bitmask,
 					 inode, 0);
@@ -4638,7 +4638,7 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 	};
 	int status = 0;
 
-	if (!nfs4_have_delegation(inode, FMODE_READ)) {
+	if (!nfs4_have_delegation(inode, FMODE_READ, 0)) {
 		res.fattr = nfs_alloc_fattr();
 		if (res.fattr == NULL)
 			return -ENOMEM;
@@ -5607,7 +5607,7 @@ bool nfs4_write_need_cache_consistency_data(struct nfs_pgio_header *hdr)
 	/* Otherwise, request attributes if and only if we don't hold
 	 * a delegation
 	 */
-	return nfs4_have_delegation(hdr->inode, FMODE_READ) == 0;
+	return nfs4_have_delegation(hdr->inode, FMODE_READ, 0) == 0;
 }
 
 void nfs4_bitmask_set(__u32 bitmask[], const __u32 src[],
@@ -7654,10 +7654,10 @@ static int nfs4_add_lease(struct file *file, int arg, struct file_lease **lease,
 	int ret;
 
 	/* No delegation, no lease */
-	if (!nfs4_have_delegation(inode, type))
+	if (!nfs4_have_delegation(inode, type, 0))
 		return -EAGAIN;
 	ret = generic_setlease(file, arg, lease, priv);
-	if (ret || nfs4_have_delegation(inode, type))
+	if (ret || nfs4_have_delegation(inode, type, 0))
 		return ret;
 	/* We raced with a delegation return */
 	nfs4_delete_lease(file, priv);
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index d105e5b2659d..995cc42b0fa0 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -687,7 +687,7 @@ static int nfs_lock_check_bounds(const struct file_lock *fl)
 	return -EINVAL;
 }
 
-static int nfs_have_delegation(struct inode *inode, fmode_t flags)
+static int nfs_have_delegation(struct inode *inode, fmode_t type, int flags)
 {
 	return 0;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446..be19ac3110d1 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1320,7 +1320,7 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 		return 0;
 	if (!nfs_folio_write_uptodate(folio, pagelen))
 		return 0;
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE))
+	if (nfs_have_write_delegation(inode))
 		return 1;
 	if (!flctx || (list_empty_careful(&flctx->flc_flock) &&
 		       list_empty_careful(&flctx->flc_posix)))
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index f40be64ce942..51611583af51 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1830,7 +1830,7 @@ struct nfs_rpc_ops {
 				int open_flags,
 				struct iattr *iattr,
 				int *);
-	int (*have_delegation)(struct inode *, fmode_t);
+	int (*have_delegation)(struct inode *, fmode_t, int);
 	struct nfs_client *(*alloc_client) (const struct nfs_client_initdata *);
 	struct nfs_client *(*init_client) (struct nfs_client *,
 				const struct nfs_client_initdata *);
-- 
2.45.2


