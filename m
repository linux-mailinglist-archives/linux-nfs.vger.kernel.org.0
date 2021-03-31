Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2DE34DCEA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC3ATQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhC3ASs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4E0C61920
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063527;
        bh=C28wxpWcli6CGNYwtPzdkw6zKL33/qQWJn7HCiEd58w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L+39lWpcf89z/Tj5Y04vP2Nhok+mb8rOfW8XsLqhLOOcqmKS/mUOk2wxbxuuZvqpN
         anoA/JWuxHq6bDqkIKu9KOD4F6Bkgk0RwkUtc8XZOK+TK8Q6b03GLYfAsh24v1+dbd
         g1zEbtB4jWDpKTKZjQonMWQKNldj3Fq45BMgVGlp1Ny79mWi39+36MQLdZOXq0LUUE
         RhqxEp0wWYGqyTAUmSiMdanJs6wpfD4F4/3GraXLqnAb2SHUWh/VG6Z//Z8XFBlEPE
         5hw1o5A4IDDmL0/m/20Xo++KQYrznzz6gB/OJR/CDgPA/1Vp3JNygHUoXVoJ5W36UD
         rVspuRxKBnahg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 17/17] NFS: Use information about the change attribute to optimise updates
Date:   Mon, 29 Mar 2021 20:18:35 -0400
Message-Id: <20210330001835.41914-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-17-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
 <20210330001835.41914-3-trondmy@kernel.org>
 <20210330001835.41914-4-trondmy@kernel.org>
 <20210330001835.41914-5-trondmy@kernel.org>
 <20210330001835.41914-6-trondmy@kernel.org>
 <20210330001835.41914-7-trondmy@kernel.org>
 <20210330001835.41914-8-trondmy@kernel.org>
 <20210330001835.41914-9-trondmy@kernel.org>
 <20210330001835.41914-10-trondmy@kernel.org>
 <20210330001835.41914-11-trondmy@kernel.org>
 <20210330001835.41914-12-trondmy@kernel.org>
 <20210330001835.41914-13-trondmy@kernel.org>
 <20210330001835.41914-14-trondmy@kernel.org>
 <20210330001835.41914-15-trondmy@kernel.org>
 <20210330001835.41914-16-trondmy@kernel.org>
 <20210330001835.41914-17-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the NFSv4.2 server supports the 'change_attr_type' attribute, then
allow the client to optimise its attribute cache update strategy.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c    | 111 ++++++++++++++++++++++++++++++++++++++--------
 fs/nfs/nfs4proc.c |  20 +++++++--
 2 files changed, 110 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e1a1322599b8..4b05cc1d0ecb 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1663,25 +1663,20 @@ EXPORT_SYMBOL_GPL(_nfs_display_fhandle);
 #endif
 
 /**
- * nfs_inode_attrs_need_update - check if the inode attributes need updating
- * @inode: pointer to inode
+ * nfs_inode_attrs_cmp_generic - compare attributes
  * @fattr: attributes
+ * @inode: pointer to inode
  *
  * Attempt to divine whether or not an RPC call reply carrying stale
  * attributes got scheduled after another call carrying updated ones.
- *
- * To do so, the function first assumes that a more recent ctime means
- * that the attributes in fattr are newer, however it also attempt to
- * catch the case where ctime either didn't change, or went backwards
- * (if someone reset the clock on the server) by looking at whether
- * or not this RPC call was started after the inode was last updated.
  * Note also the check for wraparound of 'attr_gencount'
  *
- * The function returns 'true' if it thinks the attributes in 'fattr' are
- * more recent than the ones cached in the inode.
- *
+ * The function returns '1' if it thinks the attributes in @fattr are
+ * more recent than the ones cached in @inode. Otherwise it returns
+ * the value '0'.
  */
-static int nfs_inode_attrs_need_update(const struct inode *inode, const struct nfs_fattr *fattr)
+static int nfs_inode_attrs_cmp_generic(const struct nfs_fattr *fattr,
+				       const struct inode *inode)
 {
 	unsigned long attr_gencount = NFS_I(inode)->attr_gencount;
 
@@ -1689,15 +1684,93 @@ static int nfs_inode_attrs_need_update(const struct inode *inode, const struct n
 	       (long)(attr_gencount - nfs_read_attr_generation_counter()) > 0;
 }
 
-static int nfs_refresh_inode_locked(struct inode *inode, struct nfs_fattr *fattr)
+/**
+ * nfs_inode_attrs_cmp_monotonic - compare attributes
+ * @fattr: attributes
+ * @inode: pointer to inode
+ *
+ * Attempt to divine whether or not an RPC call reply carrying stale
+ * attributes got scheduled after another call carrying updated ones.
+ *
+ * We assume that the server observes monotonic semantics for
+ * the change attribute, so a larger value means that the attributes in
+ * @fattr are more recent, in which case the function returns the
+ * value '1'.
+ * A return value of '0' indicates no measurable change
+ * A return value of '-1' means that the attributes in @inode are
+ * more recent.
+ */
+static int nfs_inode_attrs_cmp_monotonic(const struct nfs_fattr *fattr,
+					 const struct inode *inode)
 {
-	int ret;
+	s64 diff = fattr->change_attr - inode_peek_iversion_raw(inode);
+	if (diff > 0)
+		return 1;
+	return diff == 0 ? 0 : -1;
+}
+
+/**
+ * nfs_inode_attrs_cmp_strict_monotonic - compare attributes
+ * @fattr: attributes
+ * @inode: pointer to inode
+ *
+ * Attempt to divine whether or not an RPC call reply carrying stale
+ * attributes got scheduled after another call carrying updated ones.
+ *
+ * We assume that the server observes strictly monotonic semantics for
+ * the change attribute, so a larger value means that the attributes in
+ * @fattr are more recent, in which case the function returns the
+ * value '1'.
+ * A return value of '-1' means that the attributes in @inode are
+ * more recent or unchanged.
+ */
+static int nfs_inode_attrs_cmp_strict_monotonic(const struct nfs_fattr *fattr,
+						const struct inode *inode)
+{
+	return  nfs_inode_attrs_cmp_monotonic(fattr, inode) > 0 ? 1 : -1;
+}
+
+/**
+ * nfs_inode_attrs_cmp - compare attributes
+ * @fattr: attributes
+ * @inode: pointer to inode
+ *
+ * This function returns '1' if it thinks the attributes in @fattr are
+ * more recent than the ones cached in @inode. It returns '-1' if
+ * the attributes in @inode are more recent than the ones in @fattr,
+ * and it returns 0 if not sure.
+ */
+static int nfs_inode_attrs_cmp(const struct nfs_fattr *fattr,
+			       const struct inode *inode)
+{
+	if (nfs_inode_attrs_cmp_generic(fattr, inode) > 0)
+		return 1;
+	switch (NFS_SERVER(inode)->change_attr_type) {
+	case NFS4_CHANGE_TYPE_IS_UNDEFINED:
+		break;
+	case NFS4_CHANGE_TYPE_IS_TIME_METADATA:
+		if (!(fattr->valid & NFS_ATTR_FATTR_CHANGE))
+			break;
+		return nfs_inode_attrs_cmp_monotonic(fattr, inode);
+	default:
+		if (!(fattr->valid & NFS_ATTR_FATTR_CHANGE))
+			break;
+		return nfs_inode_attrs_cmp_strict_monotonic(fattr, inode);
+	}
+	return 0;
+}
+
+static int nfs_refresh_inode_locked(struct inode *inode,
+				    struct nfs_fattr *fattr)
+{
+	int attr_cmp = nfs_inode_attrs_cmp(fattr, inode);
+	int ret = 0;
 
 	trace_nfs_refresh_inode_enter(inode);
 
-	if (nfs_inode_attrs_need_update(inode, fattr))
+	if (attr_cmp > 0)
 		ret = nfs_update_inode(inode, fattr);
-	else
+	else if (attr_cmp == 0)
 		ret = nfs_check_inode_attributes(inode, fattr);
 
 	trace_nfs_refresh_inode_exit(inode, ret);
@@ -1782,11 +1855,13 @@ EXPORT_SYMBOL_GPL(nfs_post_op_update_inode);
  */
 int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fattr *fattr)
 {
+	int attr_cmp = nfs_inode_attrs_cmp(fattr, inode);
 	int status;
 
 	/* Don't do a WCC update if these attributes are already stale */
-	if ((fattr->valid & NFS_ATTR_FATTR) == 0 ||
-			!nfs_inode_attrs_need_update(inode, fattr)) {
+	if (attr_cmp < 0)
+		return 0;
+	if ((fattr->valid & NFS_ATTR_FATTR) == 0 || !attr_cmp) {
 		fattr->valid &= ~(NFS_ATTR_FATTR_PRECHANGE
 				| NFS_ATTR_FATTR_PRESIZE
 				| NFS_ATTR_FATTR_PREMTIME
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a1322f0bebac..884b8e56b3d5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1188,10 +1188,23 @@ nfs4_update_changeattr_locked(struct inode *inode,
 		unsigned long timestamp, unsigned long cache_validity)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	u64 change_attr = inode_peek_iversion_raw(inode);
 
 	cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
 
-	if (cinfo->atomic && cinfo->before == inode_peek_iversion_raw(inode)) {
+	switch (NFS_SERVER(inode)->change_attr_type) {
+	case NFS4_CHANGE_TYPE_IS_UNDEFINED:
+		break;
+	case NFS4_CHANGE_TYPE_IS_TIME_METADATA:
+		if (cinfo->after < change_attr)
+			goto out;
+		break;
+	default:
+		if (cinfo->after <= change_attr)
+			goto out;
+	}
+
+	if (cinfo->atomic && cinfo->before == change_attr) {
 		nfsi->attrtimeo_timestamp = jiffies;
 	} else {
 		if (S_ISDIR(inode->i_mode)) {
@@ -1203,7 +1216,7 @@ nfs4_update_changeattr_locked(struct inode *inode,
 				cache_validity |= NFS_INO_REVAL_PAGECACHE;
 		}
 
-		if (cinfo->before != inode_peek_iversion_raw(inode))
+		if (cinfo->before != change_attr)
 			cache_validity |= NFS_INO_INVALID_ACCESS |
 					  NFS_INO_INVALID_ACL |
 					  NFS_INO_INVALID_XATTR;
@@ -1211,8 +1224,9 @@ nfs4_update_changeattr_locked(struct inode *inode,
 	inode_set_iversion_raw(inode, cinfo->after);
 	nfsi->read_cache_jiffies = timestamp;
 	nfsi->attr_gencount = nfs_inc_attr_generation_counter();
-	nfs_set_cache_invalid(inode, cache_validity);
 	nfsi->cache_validity &= ~NFS_INO_INVALID_CHANGE;
+out:
+	nfs_set_cache_invalid(inode, cache_validity);
 }
 
 void
-- 
2.30.2

