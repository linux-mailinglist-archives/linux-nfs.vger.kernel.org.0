Return-Path: <linux-nfs+bounces-13038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 895C8B03D24
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACF07ACDDD
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58824678C;
	Mon, 14 Jul 2025 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vufA9Fh0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3141246781
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491834; cv=none; b=lT4LNApQbAps6MzBZv/EFpDpU/5o+8iKGum6hEk25KKuttUP5yP7N6vcA0TUi1CliPKNzFbioDKBWPinXHRJCjOa3nF+7ECiOfkNoAEW9hS+d/Ltc3KqgGuQz6CUKdgAuUSZWQlHDKNr24BcCW/WV8eZRTFSjkkWx37c02+i7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491834; c=relaxed/simple;
	bh=PjEEXQzsdkl29/D89t1WnRV2Q8Jk4/OFIoOktMOsJdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQlEPGNIynleoBuMGbOieAhIp+lcq+Xoat74yxkmyKh5/MFRQDYU9imnMINzIT4Za/ykaFQrYbHZ0ZbS65Z/C8ks58WkgGiGf+rrES39iV6ITsLEMkBjDi+nfl3RSIxWeNCtd+9lO9/Q38LAkaox2Ovb5+EsdGe1MIVD1A3mqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vufA9Fh0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kbiSWM4z4v01eSRE6Yp+4odvYtrTStoM/kbxRs+V5y0=; b=vufA9Fh02Kjho+cjwV6hyBGBru
	rb2kcxWemWENYmoTrzHphfvTKKRN/mzzkpU0HEs8un3RzFJnC+MAUfDbwu4P5HF1C/IAxYLDo1Abs
	Ep4AB1m+V7957MdVoN/BaO+yNiDFs5oTKo7AHHB8V0PdoqLPbsB5+pZLRNYPoCnrvYj6Ae2977RUJ
	ed91YJIN47pDiO76efFY6JDBhIE03i8xjqUXsWsK59hRv3N//tHgaghShLiySlvj7miJK9hXPXo5i
	XZpzi5bDIYy3XjxdLPeeURD5J0tBuV/+Ha5u3oGAV4vyyGDPGYvxAHB8Yq5aXeTkTAgPVphAKxzYW
	EXT7XT5Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHBH-000000020uX-22ah;
	Mon, 14 Jul 2025 11:17:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFS: use a hash table for delegation lookup
Date: Mon, 14 Jul 2025 13:16:31 +0200
Message-ID: <20250714111651.1565055-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714111651.1565055-1-hch@lst.de>
References: <20250714111651.1565055-1-hch@lst.de>
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
 fs/nfs/client.c           | 23 +++++++++++++++++++----
 fs/nfs/delegation.c       | 15 +++++++++++++--
 fs/nfs/delegation.h       |  3 +++
 include/linux/nfs_fs_sb.h |  2 ++
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f55188928f67..94684a476dd8 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -994,6 +994,7 @@ static DEFINE_IDA(s_sysfs_ids);
 struct nfs_server *nfs_alloc_server(void)
 {
 	struct nfs_server *server;
+	int delegation_buckets, i;
 
 	server = kzalloc(sizeof(struct nfs_server), GFP_KERNEL);
 	if (!server)
@@ -1019,11 +1020,18 @@ struct nfs_server *nfs_alloc_server(void)
 	atomic_set(&server->active, 0);
 	atomic_long_set(&server->nr_active_delegations, 0);
 
+	delegation_buckets = roundup_pow_of_two(nfs_delegation_watermark / 16);
+	server->delegation_hash_mask = delegation_buckets - 1;
+	server->delegation_hash_table = kmalloc_array(delegation_buckets,
+			sizeof(*server->delegation_hash_table), GFP_KERNEL);
+	if (!server->delegation_hash_table)
+		goto out_free_server;
+	for (i = 0; i < delegation_buckets; i++)
+		INIT_HLIST_HEAD(&server->delegation_hash_table[i]);
+
 	server->io_stats = nfs_alloc_iostats();
-	if (!server->io_stats) {
-		kfree(server);
-		return NULL;
-	}
+	if (!server->io_stats)
+		goto out_free_delegation_hash;
 
 	server->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
 
@@ -1036,6 +1044,12 @@ struct nfs_server *nfs_alloc_server(void)
 	rpc_init_wait_queue(&server->uoc_rpcwaitq, "NFS UOC");
 
 	return server;
+
+out_free_delegation_hash:
+	kfree(server->delegation_hash_table);
+out_free_server:
+	kfree(server);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(nfs_alloc_server);
 
@@ -1044,6 +1058,7 @@ static void delayed_free(struct rcu_head *p)
 	struct nfs_server *server = container_of(p, struct nfs_server, rcu);
 
 	nfs_free_iostats(server->io_stats);
+	kfree(server->delegation_hash_table);
 	kfree(server);
 }
 
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 621b635d1c56..ca830ceb466e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -27,9 +27,16 @@
 
 #define NFS_DEFAULT_DELEGATION_WATERMARK (15000U)
 
-static unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
+unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
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
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 8ff5ab9c5c25..9f1fb9b39c43 100644
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
 
+extern unsigned nfs_delegation_watermark;
+
 #endif
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index fe930d685780..88212306fd87 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -256,6 +256,8 @@ struct nfs_server {
 	struct list_head	layouts;
 	struct list_head	delegations;
 	atomic_long_t		nr_active_delegations;
+	unsigned int		delegation_hash_mask;
+	struct hlist_head	*delegation_hash_table;
 	struct list_head	ss_copies;
 	struct list_head	ss_src_copies;
 
-- 
2.47.2


