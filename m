Return-Path: <linux-nfs+bounces-13108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF4B076E9
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC947B5B03
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3041ADC97;
	Wed, 16 Jul 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zo2IiM72"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0821A5B96
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672436; cv=none; b=Pyt4YxMXxORvgR5GiTT2IPL2Zcf9PHFmRwZUalvQs6oP3lkdqtZOPMUleRkcqM7fZGf7FuMTPN6FDQIGvcZoP8lC9ad2+5Ib9InJfIuMRE2VArSTJNkRGJw0w1ipnnv3l9ulFDpaiD+eSOQBywDVgAa8VXKZ5ubODsFGzoBeFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672436; c=relaxed/simple;
	bh=uhu1fRNrlk8RVXaA4erJPFp4Um5ySspJ/Be78ylhRfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHJZQmv8rjUc0YcTzQxOurr8oKrmX+xZ35BV+pkMsQ3uCO1Ck6P7msSy1GT0AkjQA5lbcSaX00EB6Tvdzpk5UxytIcbqSHpkQK2RS5DcgPR9YicraRbmt4x3wFR62WjvGTNSZIcRdjzixT1vzrKgDKYVTUfsoJceLAMepBfwcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zo2IiM72; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ERlSXYErquy8IupNXUxxm64+VcIv48a1OG2Qm01EuIg=; b=zo2IiM72DkzSC8uE0PP3NTvjLL
	PHGDpIApyQdfeqRpz5PMHsybkeiQZVHwEHKB/2nCcHMvInFRyJYNNSEoe8k03rLyYVSd6JRjDCt8f
	zkj6vggZwB3WKOmRHN63/udhPR0mQcNOi6MGh0hb34M4BPrraQHKk4+NARyXB/CYloLKvfi5whLrR
	9q7LQmbdQNfyWgd9na8Sd6bdboAMtF7zN0ZR17Bs+sptnmFCrVjZZ1qeXMYSwgm2PKT++5YoK68Nx
	tsktJsw2vmDU7Grf/itkW3fNKzoNhfsxDjKWfhDG+5asIW/OisGcpkKbJoT8f59UrmjXquhdmDBw1
	+fey6UFw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2AE-00000007n98-1CjX;
	Wed, 16 Jul 2025 13:27:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFS: use a hash table for delegation lookup
Date: Wed, 16 Jul 2025 15:26:34 +0200
Message-ID: <20250716132657.2167548-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716132657.2167548-1-hch@lst.de>
References: <20250716132657.2167548-1-hch@lst.de>
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
 fs/nfs/client.c           | 14 +++++++++++---
 fs/nfs/delegation.c       | 28 +++++++++++++++++++++++++++-
 fs/nfs/delegation.h       |  3 +++
 fs/nfs/nfs4client.c       | 10 +++++++++-
 include/linux/nfs_fs_sb.h |  2 ++
 5 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index e13eb429b8b5..5e1a5263e326 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1158,6 +1158,12 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 
 	server->fsid = fattr->fsid;
 
+	if (IS_ENABLED(CONFIG_NFS_V4) && server->delegation_hash_table) {
+		error = nfs4_delegation_hash_alloc(server);
+		if (error)
+			goto out_free_server;
+	}
+
 	nfs_sysfs_add_server(server);
 
 	nfs_sysfs_link_rpc_client(server,
@@ -1167,25 +1173,27 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 			source->client->cl_timeout,
 			flavor);
 	if (error < 0)
-		goto out_free_server;
+		goto out_free_delegation_hash;
 
 	/* probe the filesystem info for this server filesystem */
 	error = nfs_probe_server(server, fh);
 	if (error < 0)
-		goto out_free_server;
+		goto out_free_delegation_hash;
 
 	if (server->namelen == 0 || server->namelen > NFS4_MAXNAMLEN)
 		server->namelen = NFS4_MAXNAMLEN;
 
 	error = nfs_start_lockd(server);
 	if (error < 0)
-		goto out_free_server;
+		goto out_free_delegation_hash;
 
 	nfs_server_insert_lists(server);
 	server->mount_time = jiffies;
 
 	return server;
 
+out_free_delegation_hash:
+	kfree(server->delegation_hash_table);
 out_free_server:
 	nfs_free_server(server);
 	return ERR_PTR(error);
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
index 2e623da1a787..31dc0d40209a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -802,6 +802,7 @@ static void nfs4_destroy_server(struct nfs_server *server)
 	unset_pnfs_layoutdriver(server);
 	nfs4_purge_state_owners(server, &freeme);
 	nfs4_free_state_owners(&freeme);
+	kfree(server->delegation_hash_table);
 }
 
 /*
@@ -1096,9 +1097,14 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 {
 	int error;
 
+	error = nfs4_delegation_hash_alloc(server);
+	if (error)
+		return error;
+
 	/* data servers support only a subset of NFSv4.1 */
+	error = -EPROTONOSUPPORT;
 	if (is_ds_only_client(server->nfs_client))
-		return -EPROTONOSUPPORT;
+		goto out;
 
 	/* We must ensure the session is initialised first */
 	error = nfs4_init_session(server->nfs_client);
@@ -1130,7 +1136,9 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	nfs_server_insert_lists(server);
 	server->mount_time = jiffies;
 	server->destroy = nfs4_destroy_server;
+	return 0;
 out:
+	kfree(server->delegation_hash_table);
 	return error;
 }
 
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


