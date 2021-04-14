Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC6835F53E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351581AbhDNNok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351615AbhDNNoZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4591C6121E
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407844;
        bh=GSfdlos9Mu+uhIQ1mM9RuTHhoy5S5oCf16GT30nKuxM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Pc5NGnNATUQguXtDjB5GD3QcbJwv6ZdiyUb9+692D8ypw8VGeAPxAsTTYSLpSzaUl
         WvWjYOKXi4Sqtj36h2zD2zc4j3JWicaaOjixlPSGLeIkqNrMLzRizye+xCA1X3h9VJ
         PV2g8fZUaGx2Rjz2Y86S7Nzf++gAwE1O4SGr1pEybZjMjoO9KjBR6+lx5Tt0+j8/sk
         ZHr9CSgjG/J39cR/FFfx+BndqWJjJ5KPOqSKncxK+8cTp4AlRjCw+ng9uBbrtxmGbX
         5QZ37/uoXMMfttbfh/tIJzu4PrOyRJC0UpuWYbQPORh127jpO6yrHxMCAk9pGaHW35
         aDp7dzlE4sUhg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 21/26] NFS: Use information about the change attribute to optimise updates
Date:   Wed, 14 Apr 2021 09:43:48 -0400
Message-Id: <20210414134353.11860-22-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-21-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
 <20210414134353.11860-13-trondmy@kernel.org>
 <20210414134353.11860-14-trondmy@kernel.org>
 <20210414134353.11860-15-trondmy@kernel.org>
 <20210414134353.11860-16-trondmy@kernel.org>
 <20210414134353.11860-17-trondmy@kernel.org>
 <20210414134353.11860-18-trondmy@kernel.org>
 <20210414134353.11860-19-trondmy@kernel.org>
 <20210414134353.11860-20-trondmy@kernel.org>
 <20210414134353.11860-21-trondmy@kernel.org>
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
index fc8e92794636..d218d164414f 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1657,25 +1657,20 @@ EXPORT_SYMBOL_GPL(_nfs_display_fhandle);
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
 
@@ -1683,15 +1678,93 @@ static int nfs_inode_attrs_need_update(const struct inode *inode, const struct n
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
@@ -1776,11 +1849,13 @@ EXPORT_SYMBOL_GPL(nfs_post_op_update_inode);
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
index 6992c88a25e7..0b0a48d78299 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1186,10 +1186,23 @@ nfs4_update_changeattr_locked(struct inode *inode,
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
+		if ((s64)(change_attr - cinfo->after) > 0)
+			goto out;
+		break;
+	default:
+		if ((s64)(change_attr - cinfo->after) >= 0)
+			goto out;
+	}
+
+	if (cinfo->atomic && cinfo->before == change_attr) {
 		nfsi->attrtimeo_timestamp = jiffies;
 	} else {
 		if (S_ISDIR(inode->i_mode)) {
@@ -1201,7 +1214,7 @@ nfs4_update_changeattr_locked(struct inode *inode,
 				cache_validity |= NFS_INO_REVAL_PAGECACHE;
 		}
 
-		if (cinfo->before != inode_peek_iversion_raw(inode))
+		if (cinfo->before != change_attr)
 			cache_validity |= NFS_INO_INVALID_ACCESS |
 					  NFS_INO_INVALID_ACL |
 					  NFS_INO_INVALID_XATTR;
@@ -1209,8 +1222,9 @@ nfs4_update_changeattr_locked(struct inode *inode,
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

