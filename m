Return-Path: <linux-nfs+bounces-11090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7833EA84BE7
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339028A2C65
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13F1EE004;
	Thu, 10 Apr 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+SLyELo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4428D832
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308761; cv=none; b=YxhuuM6WPmfoXUSQo+63rq7Nygt5qVoDXmpe2treXh9E5btzGY3G+AFfbYFnfrlcRh7uaT48g10XPMnzYMYg9XRWmlgRyLBgYgbw6zdRqBv94yY45hbun4usLVqwtsPRdzR8DNDFXq/qUepGsNdAHiQAmpp/X8Qyxoi42Bp/x2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308761; c=relaxed/simple;
	bh=6l8DP+SOX93652N354fYWr9QZ+30Sl2r4SOd3FRM8oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iiMZseqh4vn8oPxlJuqSEhFlncqMDJE3ldTcxdstnXmNQq/xXZ2jpiOoCOgwLpxq6h/VhvOEliwkq5qQIm/YwwCl+eeXdKIjCPPtnUaBGR0M6lBmYQQbzO8lEXE9h+Vu+Sq2a3ajiefU+sWLA7vYhBs0K9CIlX8siLw2fMBmq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+SLyELo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4DBC4CEEE;
	Thu, 10 Apr 2025 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744308761;
	bh=6l8DP+SOX93652N354fYWr9QZ+30Sl2r4SOd3FRM8oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M+SLyELoQXPGAPxazswL37dofyNTcp0rJNNDqVNVisakv03Dl6T7XvPY02l/vAtbk
	 UFGk6Ff+I2QY7sXj+xpoV3RQ+6D0JNkuyAhTkCn1JC5PHvTjcCrFwKXgQA/GSnmotD
	 HdSnbuzSbHY2S3kkcHcuS69j0uQduo6FvLMWqi6/K1ZMfZSHXYIX8Nq/unqkEcNU6K
	 BpAjulTQx1pxbpq/OZaSTmqEKtd2Rb7yu/yWj0xnoDGChY5VI4Xnb4henwKTvudIq7
	 0tWXvYSM7lB0/OleP6RkJked+wT2Yx4YozzZS+jNhmMvv/l+Px7oSean3XsPV8Ebro
	 9A4cxfKHExNXw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 10 Apr 2025 14:12:19 -0400
Subject: [PATCH 2/2] nfs: move the nfs4_data_server_cache into struct
 nfs_net
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-nfs-ds-netns-v1-2-cc6236e84190@kernel.org>
References: <20250410-nfs-ds-netns-v1-0-cc6236e84190@kernel.org>
In-Reply-To: <20250410-nfs-ds-netns-v1-0-cc6236e84190@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Sargun Dillon <sargun@sargun.me>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.keornel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5873; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6l8DP+SOX93652N354fYWr9QZ+30Sl2r4SOd3FRM8oo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn+AoW2HzvKj+UhHh8zWrwBMpQPginx74WLXnCq
 2lmzgotdAKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/gKFgAKCRAADmhBGVaC
 FWRQEACywHABM+lUKAp5hfu9eKEDYxVS/kg7gX9FBx7NGHlp5xk2M844KVrU6GnPdvacFpPntp1
 XwxM8DBC1N3ofo0sERGCjK1KjQZR1pUHUqiw5b3LpiHIH9Vzo7xr1d8QVSPxn0EPcSE6SVuNJEC
 cG8j3d0x4BSfkzEaNrkF6x/9VzjUV5jR5xC5JqdDhsYZXR2Gn/2QGgZrX5r/8jn/y+bVxtOhjK+
 2U+8cAuTiVpoW3K5EPzvj+UD54kjaNMszkPMPaRfVM4wkMK2h5zFaqA6yEuM0LAVRceo0cirvQ8
 zGMB5XJSzUsaJD/X39uzLhbc+bBqiHgQu374QnVj7x4ANNgMFuLEyv/ykX9owiqbsjpWSZOoqt8
 flfzqPRSucIycjSNk2/sv7mshPTcv3E330z+BmI6i3ppovBP6k6a8Qs62fcewoCrXQrT3zgp0d/
 fVF88Yf4TncYSqf5CmXsezA9CTcGoVzG+VHFIUb2bV4P+TcbBv+1mJpyOLDCeLW6UYHsDVrV8FP
 E6RCjGmQqdLkgCuuFJ347ABbXHj3WMC0o3Sv9GysDozkIsvkiVflcKXJc/9DyNI55KYzKBgZicJ
 oQletRDaLsftsa5FiD/sPI1y697C1e5YQmEbwYprtV4tROOC9TF2Vp/dMaUGW2XOFTOL8vnow+P
 BzsW85zMepzdqvQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Since struct nfs4_pnfs_ds should not be shared between net namespaces,
move from a global list of objects to a per-netns list and spinlock.

Tested-by: Sargun Dillon <sargun@sargun.me>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/client.c   |  4 ++++
 fs/nfs/inode.c    |  3 +++
 fs/nfs/netns.h    |  6 +++++-
 fs/nfs/pnfs_nfs.c | 31 +++++++++++++++++--------------
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 9500b46005b0148a5a9a7d464095ca944de06bb5..81c0f780ff82c8a020fafdb3df72552c8e6e535f 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1199,6 +1199,10 @@ void nfs_clients_init(struct net *net)
 	INIT_LIST_HEAD(&nn->nfs_volume_list);
 #if IS_ENABLED(CONFIG_NFS_V4)
 	idr_init(&nn->cb_ident_idr);
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+	INIT_LIST_HEAD(&nn->nfs4_data_server_cache);
+	spin_lock_init(&nn->nfs4_data_server_lock);
+#endif
 #endif
 	spin_lock_init(&nn->nfs_client_lock);
 	nn->boot_time = ktime_get_real();
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b994b34e55e7b28fd4f34fa089e2e1..ee796a726a1e4b0dfbd199cc62176c6802692671 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2559,6 +2559,9 @@ static int nfs_net_init(struct net *net)
 
 static void nfs_net_exit(struct net *net)
 {
+	struct nfs_net *nn = net_generic(net, nfs_net_id);
+
+	WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));
 	rpc_proc_unregister(net, "nfs");
 	nfs_fs_proc_net_exit(net);
 	nfs_clients_exit(net);
diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
index a68b21603ea9a867ba513e2a667b08fbc6d80dd8..557cf822002663b7957194610d103210b159e5c4 100644
--- a/fs/nfs/netns.h
+++ b/fs/nfs/netns.h
@@ -31,7 +31,11 @@ struct nfs_net {
 	unsigned short nfs_callback_tcpport;
 	unsigned short nfs_callback_tcpport6;
 	int cb_users[NFS4_MAX_MINOR_VERSION + 1];
-#endif
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+	struct list_head nfs4_data_server_cache;
+	spinlock_t nfs4_data_server_lock;
+#endif /* CONFIG_NFS_V4_1 */
+#endif /* CONFIG_NFS_V4 */
 	struct nfs_netns_client *nfs_client;
 	spinlock_t nfs_client_lock;
 	ktime_t boot_time;
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 2ee20a0f0b36d3b38e35c4cad966b9d58fa822f4..91ef486f40b943a1dc55164e610378ef73781e55 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -16,6 +16,7 @@
 #include "nfs4session.h"
 #include "internal.h"
 #include "pnfs.h"
+#include "netns.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS
 
@@ -504,14 +505,14 @@ EXPORT_SYMBOL_GPL(pnfs_generic_commit_pagelist);
 /*
  * Data server cache
  *
- * Data servers can be mapped to different device ids.
- * nfs4_pnfs_ds reference counting
+ * Data servers can be mapped to different device ids, but should
+ * never be shared between net namespaces.
+ *
+ * nfs4_pnfs_ds reference counting:
  *   - set to 1 on allocation
  *   - incremented when a device id maps a data server already in the cache.
  *   - decremented when deviceid is removed from the cache.
  */
-static DEFINE_SPINLOCK(nfs4_ds_cache_lock);
-static LIST_HEAD(nfs4_data_server_cache);
 
 /* Debug routines */
 static void
@@ -604,12 +605,12 @@ _same_data_server_addrs_locked(const struct list_head *dsaddrs1,
  * Lookup DS by addresses.  nfs4_ds_cache_lock is held
  */
 static struct nfs4_pnfs_ds *
-_data_server_lookup_locked(const struct net *net, const struct list_head *dsaddrs)
+_data_server_lookup_locked(const struct nfs_net *nn, const struct list_head *dsaddrs)
 {
 	struct nfs4_pnfs_ds *ds;
 
-	list_for_each_entry(ds, &nfs4_data_server_cache, ds_node)
-		if (ds->ds_net == net && _same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
+	list_for_each_entry(ds, &nn->nfs4_data_server_cache, ds_node)
+		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
 			return ds;
 	return NULL;
 }
@@ -653,10 +654,11 @@ static void destroy_ds(struct nfs4_pnfs_ds *ds)
 
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds)
 {
-	if (refcount_dec_and_lock(&ds->ds_count,
-				&nfs4_ds_cache_lock)) {
+	struct nfs_net *nn = net_generic(ds->ds_net, nfs_net_id);
+
+	if (refcount_dec_and_lock(&ds->ds_count, &nn->nfs4_data_server_lock)) {
 		list_del_init(&ds->ds_node);
-		spin_unlock(&nfs4_ds_cache_lock);
+		spin_unlock(&nn->nfs4_data_server_lock);
 		destroy_ds(ds);
 	}
 }
@@ -718,6 +720,7 @@ nfs4_pnfs_remotestr(struct list_head *dsaddrs, gfp_t gfp_flags)
 struct nfs4_pnfs_ds *
 nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_flags)
 {
+	struct nfs_net *nn = net_generic(net, nfs_net_id);
 	struct nfs4_pnfs_ds *tmp_ds, *ds = NULL;
 	char *remotestr;
 
@@ -733,8 +736,8 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_fla
 	/* this is only used for debugging, so it's ok if its NULL */
 	remotestr = nfs4_pnfs_remotestr(dsaddrs, gfp_flags);
 
-	spin_lock(&nfs4_ds_cache_lock);
-	tmp_ds = _data_server_lookup_locked(net, dsaddrs);
+	spin_lock(&nn->nfs4_data_server_lock);
+	tmp_ds = _data_server_lookup_locked(nn, dsaddrs);
 	if (tmp_ds == NULL) {
 		INIT_LIST_HEAD(&ds->ds_addrs);
 		list_splice_init(dsaddrs, &ds->ds_addrs);
@@ -743,7 +746,7 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_fla
 		INIT_LIST_HEAD(&ds->ds_node);
 		ds->ds_net = net;
 		ds->ds_clp = NULL;
-		list_add(&ds->ds_node, &nfs4_data_server_cache);
+		list_add(&ds->ds_node, &nn->nfs4_data_server_cache);
 		dprintk("%s add new data server %s\n", __func__,
 			ds->ds_remotestr);
 	} else {
@@ -755,7 +758,7 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_fla
 			refcount_read(&tmp_ds->ds_count));
 		ds = tmp_ds;
 	}
-	spin_unlock(&nfs4_ds_cache_lock);
+	spin_unlock(&nn->nfs4_data_server_lock);
 out:
 	return ds;
 }

-- 
2.49.0


