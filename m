Return-Path: <linux-nfs+bounces-3866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE090A1B7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DB9B21B6D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77A4EEB3;
	Mon, 17 Jun 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofppHbGT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D6E542
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587512; cv=none; b=Ll5inn0JOTANuMwZQIkLaasOFGqSUwlp/afTqPUnBJ60l4NAps7oVgHVATHPC+y4Vaj/RmRbpm5ZKW+aNKwVmM9/5InxR7LIQWHWryTF+JkGHhD4ZWJooYmXyELvHclS8q+Kdxpssug7HdjSKsZbSclZZ/3msR+SPO0EHXnAn2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587512; c=relaxed/simple;
	bh=OuHfyOF+FMSPqy4SSZ0O3kkhWjyd6IGon7HwWx/QTEQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8lURGqUTA8WK5ltJiy9xKWsWI+k8AsOogFAXioaaKwIkuHHbfme6jXzIT61LvONk+MlPpGmv+ZInDbfwBHo+t/BpU9B/lcCI3cyeo7hxxD726tNGsAJky8h/PGhic/Q3Oegl3S5aM0cu1S1pDX3fG/96GcQQJi01VoSRRhxQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofppHbGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78702C2BBFC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587512;
	bh=OuHfyOF+FMSPqy4SSZ0O3kkhWjyd6IGon7HwWx/QTEQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ofppHbGTW5Ag3mOmIw4XmD9J0x7EkXFRwj2MTMoH88JNFNOTqBal9X6CDCTO/jjz1
	 LfM9RWnIX4I6rrKCseb5HR7P2DM5rZMf72G3VywKdWizBcnf3DDlUHuBQdqSqICTuh
	 hiNFb0TxjKMqepNOLjL3bH4sUDF3l7DXU6BhqgfgT1rS0QTXzeFut1sxwC/d4u+JGT
	 K4QTQWmByPmy1ztDrqE/d9OEEc/HLRA7yao4d7blXfYVbR7uju9k0oDOWtdc06tIFU
	 MwRLJOsj17301jWYYlFeGz0b7UBdz7P57LfVwDz0+I2mHPG+FHhHV84g61BithSoxk
	 m7yplMpYQP8mw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/19] NFSv4: Add support for delegated atime and mtime attributes
Date: Sun, 16 Jun 2024 21:21:25 -0400
Message-ID: <20240617012137.674046-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-7-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Ensure that we update the mtime and atime correctly when we read
or write data to the file and when we truncate. Let the server manage
ctime on other attribute updates.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 32 ++++++++++++++++++++++-----
 fs/nfs/delegation.h | 25 +++++++++++++++++++--
 fs/nfs/inode.c      | 54 +++++++++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs4proc.c   | 21 ++++++++++--------
 fs/nfs/read.c       |  3 +++
 fs/nfs/write.c      |  9 ++++++++
 6 files changed, 124 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6fdffd25cb2b..d9117630e062 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -115,6 +115,9 @@ static int nfs4_do_check_delegation(struct inode *inode, fmode_t type,
 		if (mark)
 			nfs_mark_delegation_referenced(delegation);
 		ret = 1;
+		if ((flags & NFS_DELEGATION_FLAG_TIME) &&
+		    !test_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags))
+			ret = 0;
 	}
 	rcu_read_unlock();
 	return ret;
@@ -221,11 +224,12 @@ static int nfs_delegation_claim_opens(struct inode *inode,
  * @type: delegation type
  * @stateid: delegation stateid
  * @pagemod_limit: write delegation "space_limit"
+ * @deleg_type: raw delegation type
  *
  */
 void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 				  fmode_t type, const nfs4_stateid *stateid,
-				  unsigned long pagemod_limit)
+				  unsigned long pagemod_limit, u32 deleg_type)
 {
 	struct nfs_delegation *delegation;
 	const struct cred *oldcred = NULL;
@@ -239,6 +243,14 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 		delegation->pagemod_limit = pagemod_limit;
 		oldcred = delegation->cred;
 		delegation->cred = get_cred(cred);
+		switch (deleg_type) {
+		case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+		case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+			set_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
+			break;
+		default:
+			clear_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
+		}
 		clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
 		if (test_and_clear_bit(NFS_DELEGATION_REVOKED,
 				       &delegation->flags))
@@ -250,7 +262,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 	} else {
 		rcu_read_unlock();
 		nfs_inode_set_delegation(inode, cred, type, stateid,
-					 pagemod_limit);
+					 pagemod_limit, deleg_type);
 	}
 }
 
@@ -418,13 +430,13 @@ nfs_update_inplace_delegation(struct nfs_delegation *delegation,
  * @type: delegation type
  * @stateid: delegation stateid
  * @pagemod_limit: write delegation "space_limit"
+ * @deleg_type: raw delegation type
  *
  * Returns zero on success, or a negative errno value.
  */
 int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
-				  fmode_t type,
-				  const nfs4_stateid *stateid,
-				  unsigned long pagemod_limit)
+			     fmode_t type, const nfs4_stateid *stateid,
+			     unsigned long pagemod_limit, u32 deleg_type)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_client *clp = server->nfs_client;
@@ -444,6 +456,11 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	delegation->cred = get_cred(cred);
 	delegation->inode = inode;
 	delegation->flags = 1<<NFS_DELEGATION_REFERENCED;
+	switch (deleg_type) {
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+		delegation->flags |= BIT(NFS_DELEGATION_DELEGTIME);
+	}
 	delegation->test_gen = 0;
 	spin_lock_init(&delegation->lock);
 
@@ -508,6 +525,11 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	atomic_long_inc(&nfs_active_delegations);
 
 	trace_nfs4_set_delegation(inode, type);
+
+	/* If we hold writebacks and have delegated mtime then update */
+	if (deleg_type == NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG &&
+	    nfs_have_writebacks(inode))
+		nfs_update_delegated_mtime(inode);
 out:
 	spin_unlock(&clp->cl_lock);
 	if (delegation != NULL)
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 257b3d726043..001551e2ab60 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -38,12 +38,15 @@ enum {
 	NFS_DELEGATION_TEST_EXPIRED,
 	NFS_DELEGATION_INODE_FREEING,
 	NFS_DELEGATION_RETURN_DELAYED,
+	NFS_DELEGATION_DELEGTIME,
 };
 
 int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
-		fmode_t type, const nfs4_stateid *stateid, unsigned long pagemod_limit);
+			     fmode_t type, const nfs4_stateid *stateid,
+			     unsigned long pagemod_limit, u32 deleg_type);
 void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
-		fmode_t type, const nfs4_stateid *stateid, unsigned long pagemod_limit);
+				  fmode_t type, const nfs4_stateid *stateid,
+				  unsigned long pagemod_limit, u32 deleg_type);
 int nfs4_inode_return_delegation(struct inode *inode);
 void nfs4_inode_return_delegation_on_close(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
@@ -84,6 +87,12 @@ int nfs4_inode_make_writeable(struct inode *inode);
 
 #endif
 
+#define NFS_DELEGATION_FLAG_TIME	BIT(1)
+
+void nfs_update_delegated_atime(struct inode *inode);
+void nfs_update_delegated_mtime(struct inode *inode);
+void nfs_update_delegated_mtime_locked(struct inode *inode);
+
 static inline int nfs_have_read_or_write_delegation(struct inode *inode)
 {
 	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
@@ -99,4 +108,16 @@ static inline int nfs_have_delegated_attributes(struct inode *inode)
 	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
 }
 
+static inline int nfs_have_delegated_atime(struct inode *inode)
+{
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ,
+						 NFS_DELEGATION_FLAG_TIME);
+}
+
+static inline int nfs_have_delegated_mtime(struct inode *inode)
+{
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE,
+						 NFS_DELEGATION_FLAG_TIME);
+}
+
 #endif
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 1363cb082ea0..2aaadcdd6946 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -275,6 +275,8 @@ EXPORT_SYMBOL_GPL(nfs_zap_acl_cache);
 
 void nfs_invalidate_atime(struct inode *inode)
 {
+	if (nfs_have_delegated_atime(inode))
+		return;
 	spin_lock(&inode->i_lock);
 	nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 	spin_unlock(&inode->i_lock);
@@ -604,6 +606,33 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 }
 EXPORT_SYMBOL_GPL(nfs_fhget);
 
+void nfs_update_delegated_atime(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	if (nfs_have_delegated_atime(inode)) {
+		inode_update_timestamps(inode, S_ATIME);
+		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_ATIME;
+	}
+	spin_unlock(&inode->i_lock);
+}
+
+void nfs_update_delegated_mtime_locked(struct inode *inode)
+{
+	if (nfs_have_delegated_mtime(inode)) {
+		inode_update_timestamps(inode, S_CTIME | S_MTIME);
+		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_CTIME |
+						  NFS_INO_INVALID_MTIME);
+	}
+}
+
+void nfs_update_delegated_mtime(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	nfs_update_delegated_mtime_locked(inode);
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_update_delegated_mtime);
+
 #define NFS_VALID_ATTRS (ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_SIZE|ATTR_ATIME|ATTR_ATIME_SET|ATTR_MTIME|ATTR_MTIME_SET|ATTR_FILE|ATTR_OPEN)
 
 int
@@ -631,6 +660,17 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
+	if (nfs_have_delegated_mtime(inode)) {
+		if (attr->ia_valid & ATTR_MTIME) {
+			nfs_update_delegated_mtime(inode);
+			attr->ia_valid &= ~ATTR_MTIME;
+		}
+		if (attr->ia_valid & ATTR_ATIME) {
+			nfs_update_delegated_atime(inode);
+			attr->ia_valid &= ~ATTR_ATIME;
+		}
+	}
+
 	/* Optimization: if the end result is no change, don't RPC */
 	if (((attr->ia_valid & NFS_VALID_ATTRS) & ~(ATTR_FILE|ATTR_OPEN)) == 0)
 		return 0;
@@ -686,6 +726,7 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
 
 	spin_unlock(&inode->i_lock);
 	truncate_pagecache(inode, offset);
+	nfs_update_delegated_mtime_locked(inode);
 	spin_lock(&inode->i_lock);
 out:
 	return err;
@@ -709,8 +750,9 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 	spin_lock(&inode->i_lock);
 	NFS_I(inode)->attr_gencount = fattr->gencount;
 	if ((attr->ia_valid & ATTR_SIZE) != 0) {
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME |
-						     NFS_INO_INVALID_BLOCKS);
+		if (!nfs_have_delegated_mtime(inode))
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
 		nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
 		nfs_vmtruncate(inode, attr->ia_size);
 	}
@@ -856,8 +898,12 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	/* Flush out writes to the server in order to update c/mtime/version.  */
 	if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_CHANGE_COOKIE)) &&
-	    S_ISREG(inode->i_mode))
-		filemap_write_and_wait(inode->i_mapping);
+	    S_ISREG(inode->i_mode)) {
+		if (nfs_have_delegated_mtime(inode))
+			filemap_fdatawrite(inode->i_mapping);
+		else
+			filemap_write_and_wait(inode->i_mapping);
+	}
 
 	/*
 	 * We may force a getattr if the user cares about atime.
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4455ee510c2f..f4215dcf3614 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1245,7 +1245,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
 	struct nfs_inode *nfsi = NFS_I(inode);
 	u64 change_attr = inode_peek_iversion_raw(inode);
 
-	cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
+	if (!nfs_have_delegated_mtime(inode))
+		cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
 	if (S_ISDIR(inode->i_mode))
 		cache_validity |= NFS_INO_INVALID_DATA;
 
@@ -1961,6 +1962,8 @@ nfs4_process_delegation(struct inode *inode, const struct cred *cred,
 	switch (delegation->open_delegation_type) {
 	case NFS4_OPEN_DELEGATE_READ:
 	case NFS4_OPEN_DELEGATE_WRITE:
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
 		break;
 	default:
 		return;
@@ -1974,16 +1977,16 @@ nfs4_process_delegation(struct inode *inode, const struct cred *cred,
 				   NFS_SERVER(inode)->nfs_client->cl_hostname);
 		break;
 	case NFS4_OPEN_CLAIM_PREVIOUS:
-		nfs_inode_reclaim_delegation(inode, cred,
-				delegation->type,
-				&delegation->stateid,
-				delegation->pagemod_limit);
+		nfs_inode_reclaim_delegation(inode, cred, delegation->type,
+					     &delegation->stateid,
+					     delegation->pagemod_limit,
+					     delegation->open_delegation_type);
 		break;
 	default:
-		nfs_inode_set_delegation(inode, cred,
-				delegation->type,
-				&delegation->stateid,
-				delegation->pagemod_limit);
+		nfs_inode_set_delegation(inode, cred, delegation->type,
+					 &delegation->stateid,
+					 delegation->pagemod_limit,
+					 delegation->open_delegation_type);
 	}
 	if (delegation->do_recall)
 		nfs_async_inode_return_delegation(inode, &delegation->stateid);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a142287d86f6..1b0e06c11983 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -28,6 +28,7 @@
 #include "fscache.h"
 #include "pnfs.h"
 #include "nfstrace.h"
+#include "delegation.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
@@ -372,6 +373,7 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 		goto out_put;
 
 	nfs_pageio_complete_read(&pgio);
+	nfs_update_delegated_atime(inode);
 	ret = pgio.pg_error < 0 ? pgio.pg_error : 0;
 	if (!ret) {
 		ret = folio_wait_locked_killable(folio);
@@ -428,6 +430,7 @@ void nfs_readahead(struct readahead_control *ractl)
 	}
 
 	nfs_pageio_complete_read(&pgio);
+	nfs_update_delegated_atime(inode);
 
 	put_nfs_open_context(ctx);
 out:
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index be19ac3110d1..f5414c96381a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -289,6 +289,8 @@ static void nfs_grow_file(struct folio *folio, unsigned int offset,
 	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 out:
+	/* Atomically update timestamps if they are delegated to us. */
+	nfs_update_delegated_mtime_locked(inode);
 	spin_unlock(&inode->i_lock);
 	nfs_fscache_invalidate(inode, 0);
 }
@@ -1514,6 +1516,13 @@ void nfs_writeback_update_inode(struct nfs_pgio_header *hdr)
 	struct nfs_fattr *fattr = &hdr->fattr;
 	struct inode *inode = hdr->inode;
 
+	if (nfs_have_delegated_mtime(inode)) {
+		spin_lock(&inode->i_lock);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
+		spin_unlock(&inode->i_lock);
+		return;
+	}
+
 	spin_lock(&inode->i_lock);
 	nfs_writeback_check_extend(hdr, fattr);
 	nfs_post_op_update_inode_force_wcc_locked(inode, fattr);
-- 
2.45.2


