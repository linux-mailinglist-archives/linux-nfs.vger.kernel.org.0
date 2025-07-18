Return-Path: <linux-nfs+bounces-13151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D58B09D8C
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 10:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430EE7BD491
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40FA19E975;
	Fri, 18 Jul 2025 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rpi9HumW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64720B7F4
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826530; cv=none; b=Tcoq4FgWBW/WmyR4ukvSPl2Aa1pduBufDgukH1qSrfF88NDXjRcpIjsrNydMETDNj3cwcz8EyYNuTQ8qe+DN80fcwjiQIetERXeuK8zWUs6f+qikszBDQZ4PHgylCpRZic22sMY2XTMTJYyHvIQk/I8wf8RzrcTv1djqRvlj4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826530; c=relaxed/simple;
	bh=xNtvvW1RCtIpangMtlwNiSqPl9w9LvLP+Q4fBls4OMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2w1Y1fct+JRhag9FLUDRxh2wuUMu/5Cy6AtMaOo+Y8kH4QvrG6spv+iahA/QV7pdvM+XpMGevJ/5xysMVCKc6/XvwcRs1n1r5pHBsC8JP78ahxBaFWZmqGOUSu8vzJ0kHPRfOMGUyZ33/St1puuUeuWRdhVQUGZII/Dn2nUQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rpi9HumW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/oGkK8iH20TpMsl5LX1va8TEjaixBwCax/MbF+A4dIs=; b=rpi9HumW6fyIDxiPvtemv607rg
	d/yNTbywdhexGyTXSVDIfYP89Xgelnm5/EDGT6747UHSyggVWAWt5eSU2XNt5Omf0Cq3ytvoDOhtq
	Qzp1TMRpMOJ9G1pWfdSM+NKETYe5GQ9sBp9yKlXzOBXfhB189YBNXmP3Xos5Hyp+kaBbxC9bwCxXG
	6IqMKMFdhsCJpa7Bxrk5+CAgjBB0QN9/44M9n73VHHCt8hFvJgPAWHTr3Kz4xGGsDdCoi5D646S6A
	wa/oVGWmVGVAVkWfKYXhdspg8oGZQd8rrdyVbEUqAhRtESmNUZgbFM/h+aRLu+4rBhFrmmVnmJS9p
	t3s3VQCg==;
Received: from [2001:4bb8:2dd:a44:6557:72e7:fc8:56bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucgFc-0000000BzwG-1qDR;
	Fri, 18 Jul 2025 08:15:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFS: use a hash table for delegation lookup
Date: Fri, 18 Jul 2025 10:14:50 +0200
Message-ID: <20250718081509.2607553-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718081509.2607553-1-hch@lst.de>
References: <20250718081509.2607553-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

nfs_delegation_find_inode currently has to walk the entire list of
delegations per inode, which can become pretty large, and can become even
larger when increasing the delegation watermark.

Add a hash table to speed up the delegation lookup, sized as a fraction
of the delegation watermark.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c       | 28 +++++++++++++++++++++++++++-
 fs/nfs/delegation.h       |  3 +++
 fs/nfs/nfs4client.c       |  5 +++++
 fs/nfs/nfs4proc.c         | 22 +++++++++++++++++++++-
 include/linux/nfs_fs_sb.h |  2 ++
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index ea96f77e38c2..9d3a5f29f17f 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -30,6 +30,13 @@
 static unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
 module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
 
+static struct hlist_head *nfs_delegation_hash(struct nfs_server *server,
+		const struct nfs_fh *fhandle)
+{
+	return server->delegation_hash_table +
+		(nfs_fhandle_hash(fhandle) & server->delegation_hash_mask);
+}
+
 static void __nfs_free_delegation(struct nfs_delegation *delegation)
 {
 	put_cred(delegation->cred);
@@ -367,6 +374,7 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		spin_unlock(&delegation->lock);
 		return NULL;
 	}
+	hlist_del_init_rcu(&delegation->hash);
 	list_del_rcu(&delegation->super_list);
 	delegation->inode = NULL;
 	rcu_assign_pointer(nfsi->delegation, NULL);
@@ -529,6 +537,8 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	spin_unlock(&inode->i_lock);
 
 	list_add_tail_rcu(&delegation->super_list, &server->delegations);
+	hlist_add_head_rcu(&delegation->hash,
+			nfs_delegation_hash(server, &NFS_I(inode)->fh));
 	rcu_assign_pointer(nfsi->delegation, delegation);
 	delegation = NULL;
 
@@ -1166,11 +1176,12 @@ static struct inode *
 nfs_delegation_find_inode_server(struct nfs_server *server,
 				 const struct nfs_fh *fhandle)
 {
+	struct hlist_head *head = nfs_delegation_hash(server, fhandle);
 	struct nfs_delegation *delegation;
 	struct super_block *freeme = NULL;
 	struct inode *res = NULL;
 
-	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
+	hlist_for_each_entry_rcu(delegation, head, hash) {
 		spin_lock(&delegation->lock);
 		if (delegation->inode != NULL &&
 		    !test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) &&
@@ -1577,3 +1588,18 @@ bool nfs4_delegation_flush_on_close(const struct inode *inode)
 	rcu_read_unlock();
 	return ret;
 }
+
+int nfs4_delegation_hash_alloc(struct nfs_server *server)
+{
+	int delegation_buckets, i;
+
+	delegation_buckets = roundup_pow_of_two(nfs_delegation_watermark / 16);
+	server->delegation_hash_mask = delegation_buckets - 1;
+	server->delegation_hash_table = kmalloc_array(delegation_buckets,
+			sizeof(*server->delegation_hash_table), GFP_KERNEL);
+	if (!server->delegation_hash_table)
+		return -ENOMEM;
+	for (i = 0; i < delegation_buckets; i++)
+		INIT_HLIST_HEAD(&server->delegation_hash_table[i]);
+	return 0;
+}
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 8ff5ab9c5c25..08ec2e9c68a4 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -14,6 +14,7 @@
  * NFSv4 delegation
  */
 struct nfs_delegation {
+	struct hlist_node hash;
 	struct list_head super_list;
 	const struct cred *cred;
 	struct inode *inode;
@@ -123,4 +124,6 @@ static inline int nfs_have_delegated_mtime(struct inode *inode)
 						 NFS_DELEGATION_FLAG_TIME);
 }
 
+int nfs4_delegation_hash_alloc(struct nfs_server *server);
+
 #endif
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 5943a192f36b..2ea98f1f116f 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -802,6 +802,7 @@ static void nfs4_destroy_server(struct nfs_server *server)
 	unset_pnfs_layoutdriver(server);
 	nfs4_purge_state_owners(server, &freeme);
 	nfs4_free_state_owners(&freeme);
+	kfree(server->delegation_hash_table);
 }
 
 /*
@@ -1096,6 +1097,10 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 {
 	int error;
 
+	error = nfs4_delegation_hash_alloc(server);
+	if (error)
+		return error;
+
 	/* data servers support only a subset of NFSv4.1 */
 	if (is_ds_only_client(server->nfs_client))
 		return -EPROTONOSUPPORT;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ef2077e185b6..d8bebd757af3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10967,6 +10967,26 @@ static const struct inode_operations nfs4_file_inode_operations = {
 	.listxattr	= nfs4_listxattr,
 };
 
+static struct nfs_server *nfs4_clone_server(struct nfs_server *source,
+		struct nfs_fh *fh, struct nfs_fattr *fattr,
+		rpc_authflavor_t flavor)
+{
+	struct nfs_server *server;
+	int error;
+
+	server = nfs_clone_server(source, fh, fattr, flavor);
+	if (IS_ERR(server))
+		return server;
+
+	error = nfs4_delegation_hash_alloc(server);
+	if (error) {
+		nfs_free_server(server);
+		return ERR_PTR(error);
+	}
+
+	return server;
+}
+
 const struct nfs_rpc_ops nfs_v4_clientops = {
 	.version	= 4,			/* protocol version */
 	.dentry_ops	= &nfs4_dentry_operations,
@@ -11019,7 +11039,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.init_client	= nfs4_init_client,
 	.free_client	= nfs4_free_client,
 	.create_server	= nfs4_create_server,
-	.clone_server	= nfs_clone_server,
+	.clone_server	= nfs4_clone_server,
 	.discover_trunking = nfs4_discover_trunking,
 	.enable_swap	= nfs4_enable_swap,
 	.disable_swap	= nfs4_disable_swap,
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index a9b44f12623f..d30c0245031c 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -255,6 +255,8 @@ struct nfs_server {
 	struct list_head	layouts;
 	struct list_head	delegations;
 	atomic_long_t		nr_active_delegations;
+	unsigned int		delegation_hash_mask;
+	struct hlist_head	*delegation_hash_table;
 	struct list_head	ss_copies;
 	struct list_head	ss_src_copies;
 
-- 
2.47.2


