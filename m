Return-Path: <linux-nfs+bounces-11095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F18A84E54
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 22:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E267ADAC7
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 20:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE86290BBA;
	Thu, 10 Apr 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2zuZNqD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C21FAC4A
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317734; cv=none; b=cczt7IpW76HNYwadl0dqf8sdXH8V+7box3HMo9a0lOFYJnqkrP3vSqV35ynHxRZAxGaEpAlKJDiB1aaPpSEzbcY7lPj+1WRIbY5tILtbTJIBtFC2UYERzs/7wvkQhfjqLnmXrvhzMzgMuYscVXbMfwtCmalOaOXa6d36P1x4ATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317734; c=relaxed/simple;
	bh=TjAvg0Gx691DvXokj8nGJ6MnDRpAvnlzN+qjhz7J0Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMh0MtcNESgnzL+nl2aXu1YvSk1Hf7FAVnlbXDjXzMGtkJPScG2+Whl+dCUhpnG4DjJmLPGkf0GR175kQ7PKw8M6pJajZy5kS36DykMqFlpGEU3l536jqdfDJ27S+ZiEYEIDu50NFLVBU/G76XCFItzIU1ISEjafirzgX25jRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2zuZNqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA712C4CEE9;
	Thu, 10 Apr 2025 20:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744317734;
	bh=TjAvg0Gx691DvXokj8nGJ6MnDRpAvnlzN+qjhz7J0Gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g2zuZNqD2N+UJNtih2JKqkoz6zGYZsXTqi/heDpkl9b+zra7Fy5HsT9nF4x0D/vRM
	 zyqKZ8t9DscKKhPP6eZQGse8LtR/+EyWg0v5eD2d0PfzZFsg0SXy7RDju6aVG8Rdle
	 Hr4v7xAMo7HgbZKHgud4ZW1f2FCDdKdQsYYhIcgTd5EBnXJt1AgrAy6swyJjjqZdiE
	 gLz/iTe4jtNPe7508YphyIMiGt3MhweViS3bUE/J84coZGjnYfSw/xGvbsGrOdue+s
	 eI0cZUuMYvL0Bg/mu1iZxZH7uc+/0ZOa9Jm50tej1hDfEjdJ0XD4OGxkjwMj3dIV7P
	 kcAyDulw8JgYA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 10 Apr 2025 16:42:03 -0400
Subject: [PATCH v2 1/2] nfs: don't share pNFS DS connections between net
 namespaces
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-nfs-ds-netns-v2-1-f80b7979ba80@kernel.org>
References: <20250410-nfs-ds-netns-v2-0-f80b7979ba80@kernel.org>
In-Reply-To: <20250410-nfs-ds-netns-v2-0-f80b7979ba80@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Sargun Dillon <sargun@sargun.me>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.keornel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6721; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TjAvg0Gx691DvXokj8nGJ6MnDRpAvnlzN+qjhz7J0Gc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn+C0k1OipS36IzHUf+2g7FRvTmgzts0wL8yZSZ
 mtN3+cNFACJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/gtJAAKCRAADmhBGVaC
 Fd5zD/9v4V/8gpkJNQxtsVkIzuJzefJIqhyfcgaHXTxnzKtfQ5S+vDJzkTO9F42msBdpSIQIz/h
 Q98Xjqw5GPtzSwo59p/Si0xuKuX7fkdyt98w5p+w7UcLRY2ajRNK7PJ6gfapSSmAvuq7KGIsIup
 qUmuBpXqLCCB+iE1KNkDdRWZiJFUADJaPrSr31iGy+cXhpw2qs/NIYOdZbzGa+PtrXBW8OiUU+d
 GU86CK13TtfhxlU3UmG8FTqlBp/eGXpthZrqahIUcxju8afA2hE3IuI9Hc4/iw96242yH1hSlWl
 KbuoV8vWI3O2IyPUxDZ1TZD2HEZBFdl81ogSDzwnp8OAvTIuUzVTES67uHYgsMWuzHnmi9VK3s7
 VR+ClezC0BpobYN16ysvrN0Sf0athjLSLC2tKz1M+PxDXYYRfooCuMMbFhjvPP7eyqEM1t9dEN+
 4xpLnNFs4Jz3iskqj1xo5Skhp2KdkC53Rk+gs0ZifAYlS0V87cncE68IyfYpH3hXlmgsZELZQyc
 2n+swb7O//kS/WMLW/KfkeG1s6nDaUqTzApWtcHR5D/k8MOG7IUkwSVhXUU8855alC3WiX4hL2C
 bxLTONmB4H24KxnCr1Wp4ZATdahCBUatv6UPNND4qICujIZQeBFA/akMEMJh3TjY6WLnwFL7bYK
 zk8UsrXB3ct8ygA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, different NFS clients can share the same DS connections, even
when they are in different net namespaces. If a containerized client
creates a DS connection, another container can find and use it. When the
first client exits, the connection will which can lead to stalls in
other clients.

Add a net namespace pointer to struct nfs4_pnfs_ds, and compare those
value to the caller's netns in _data_server_lookup_locked() when
searching for a nfs4_pnfs_ds to match.

Reported-by: Omar Sandoval <osandov@osandov.com>
Reported-by: Sargun Dillon <sargun@sargun.me>
Closes: https://lore.kernel.org/linux-nfs/Z_ArpQC_vREh_hEA@telecaster/
Tested-by: Sargun Dillon <sargun@sargun.me>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/filelayout/filelayoutdev.c         | 6 +++---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 6 +++---
 fs/nfs/pnfs.h                             | 4 +++-
 fs/nfs/pnfs_nfs.c                         | 9 +++++----
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 4fa304fa5bc4b2346458877c39a558936a49317a..29d9234d5c085f3feda9abf6a98cd5e272f22613 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -76,6 +76,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct page *scratch;
 	struct list_head dsaddrs;
 	struct nfs4_pnfs_ds_addr *da;
+	struct net *net = server->nfs_client->cl_net;
 
 	/* set up xdr stream */
 	scratch = alloc_page(gfp_flags);
@@ -159,8 +160,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 		mp_count = be32_to_cpup(p); /* multipath count */
 		for (j = 0; j < mp_count; j++) {
-			da = nfs4_decode_mp_ds_addr(server->nfs_client->cl_net,
-						    &stream, gfp_flags);
+			da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
 			if (da)
 				list_add_tail(&da->da_node, &dsaddrs);
 		}
@@ -170,7 +170,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			goto out_err_free_deviceid;
 		}
 
-		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
+		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
 		if (!dsaddr->ds_list[i])
 			goto out_err_drain_dsaddrs;
 		trace_fl_getdevinfo(server, &pdev->dev_id, dsaddr->ds_list[i]->ds_remotestr);
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index e58bedfb1dcc14307e0cb3bc7011ed3f199eecc6..4a304cf17c4b07a07b9e25e48af9d83c345d2ac1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -49,6 +49,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct nfs4_pnfs_ds_addr *da;
 	struct nfs4_ff_layout_ds *new_ds = NULL;
 	struct nfs4_ff_ds_version *ds_versions = NULL;
+	struct net *net = server->nfs_client->cl_net;
 	u32 mp_count;
 	u32 version_count;
 	__be32 *p;
@@ -80,8 +81,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 	for (i = 0; i < mp_count; i++) {
 		/* multipath ds */
-		da = nfs4_decode_mp_ds_addr(server->nfs_client->cl_net,
-					    &stream, gfp_flags);
+		da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
 		if (da)
 			list_add_tail(&da->da_node, &dsaddrs);
 	}
@@ -149,7 +149,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	new_ds->ds_versions = ds_versions;
 	new_ds->ds_versions_cnt = version_count;
 
-	new_ds->ds = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
+	new_ds->ds = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
 	if (!new_ds->ds)
 		goto out_err_drain_dsaddrs;
 
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 30d2613e912b8804c994fc19e25b767f360ce51a..91ff877185c8afe462eb81f6571afd3ade14ffb4 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -60,6 +60,7 @@ struct nfs4_pnfs_ds {
 	struct list_head	ds_node;  /* nfs4_pnfs_dev_hlist dev_dslist */
 	char			*ds_remotestr;	/* comma sep list of addrs */
 	struct list_head	ds_addrs;
+	const struct net	*ds_net;
 	struct nfs_client	*ds_clp;
 	refcount_t		ds_count;
 	unsigned long		ds_state;
@@ -415,7 +416,8 @@ int pnfs_generic_commit_pagelist(struct inode *inode,
 int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max);
 void pnfs_generic_write_commit_done(struct rpc_task *task, void *data);
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds);
-struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(struct list_head *dsaddrs,
+struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(const struct net *net,
+				      struct list_head *dsaddrs,
 				      gfp_t gfp_flags);
 void nfs4_pnfs_v3_ds_connect_unload(void);
 int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index dbef837e871ad44e401461c39f04b159ec43f2f6..2ee20a0f0b36d3b38e35c4cad966b9d58fa822f4 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -604,12 +604,12 @@ _same_data_server_addrs_locked(const struct list_head *dsaddrs1,
  * Lookup DS by addresses.  nfs4_ds_cache_lock is held
  */
 static struct nfs4_pnfs_ds *
-_data_server_lookup_locked(const struct list_head *dsaddrs)
+_data_server_lookup_locked(const struct net *net, const struct list_head *dsaddrs)
 {
 	struct nfs4_pnfs_ds *ds;
 
 	list_for_each_entry(ds, &nfs4_data_server_cache, ds_node)
-		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
+		if (ds->ds_net == net && _same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
 			return ds;
 	return NULL;
 }
@@ -716,7 +716,7 @@ nfs4_pnfs_remotestr(struct list_head *dsaddrs, gfp_t gfp_flags)
  * uncached and return cached struct nfs4_pnfs_ds.
  */
 struct nfs4_pnfs_ds *
-nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
+nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_flags)
 {
 	struct nfs4_pnfs_ds *tmp_ds, *ds = NULL;
 	char *remotestr;
@@ -734,13 +734,14 @@ nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
 	remotestr = nfs4_pnfs_remotestr(dsaddrs, gfp_flags);
 
 	spin_lock(&nfs4_ds_cache_lock);
-	tmp_ds = _data_server_lookup_locked(dsaddrs);
+	tmp_ds = _data_server_lookup_locked(net, dsaddrs);
 	if (tmp_ds == NULL) {
 		INIT_LIST_HEAD(&ds->ds_addrs);
 		list_splice_init(dsaddrs, &ds->ds_addrs);
 		ds->ds_remotestr = remotestr;
 		refcount_set(&ds->ds_count, 1);
 		INIT_LIST_HEAD(&ds->ds_node);
+		ds->ds_net = net;
 		ds->ds_clp = NULL;
 		list_add(&ds->ds_node, &nfs4_data_server_cache);
 		dprintk("%s add new data server %s\n", __func__,

-- 
2.49.0


