Return-Path: <linux-nfs+bounces-11096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45399A84E55
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 22:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002C54C72AE
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 20:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB960290BC0;
	Thu, 10 Apr 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Luztx1ki"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640E290BBE
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317735; cv=none; b=Q4phEVblBZ/yzsQP+7ig3Opv2RcYmcBLwZrBi7acxpyqQr2PFp/mkU2EtRmzed3XaaTv+P6L09uwydLuZ33dtj7h+5D24dcPI3KOS4nzpQHXxJ6abGQxwkMPGLxoJtn+4cTOerGrKeQu32uT26P9OQ3j1pXR2jVt0AcVj2ScILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317735; c=relaxed/simple;
	bh=O2k72Q9bczat3lfMCldhODOLGjr6CVMFFLscJ19SNn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKrnsl+jeJF7AYDA0nrCBbTp83qjmdXAeut/73vnZeqgsi4jgJvGYlXIpKbJAcYth9fvgUZHjugxL/qufWs0O1GPmYAmLepGIsFxWuO2YqFUZJjaAWIRNa6YKX49lyRA3anuxpgwXMIIDHNT+rYJXusy4QiHHNNcXVXWoycgKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Luztx1ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D49C4CEDD;
	Thu, 10 Apr 2025 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744317735;
	bh=O2k72Q9bczat3lfMCldhODOLGjr6CVMFFLscJ19SNn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Luztx1kidKEdIGVzQl1LH4nK9kNjQPBf3VuCXEepPuKOwg7DQ7zZscV/wmNAbNSBD
	 3MOWQuHi2HgNkAMBHljJFlUG0vdIYPPzTis0KJP8HM59UvBjVoT/4Aq2o2fq3YzmA4
	 gGKow2ExeoQeytXFK3DauemAwR/DPC6v2rSQHSzPno8iCS8A/tkPmphgH0oN/veGAY
	 H3vURRns7le7/FxL2o1nUlpopaPPkLZ2SMKOYy6ROs9MZL24peDLg4+4kUhW1LdLo/
	 yqIeHjF/JEYtZmVw/RvxZPIIyDgh9bkVzbx/5bDeSBnlF8tIpZggXhe/WmowNnZbSP
	 78wKqk+xrI5rA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 10 Apr 2025 16:42:04 -0400
Subject: [PATCH v2 2/2] nfs: move the nfs4_data_server_cache into struct
 nfs_net
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-nfs-ds-netns-v2-2-f80b7979ba80@kernel.org>
References: <20250410-nfs-ds-netns-v2-0-f80b7979ba80@kernel.org>
In-Reply-To: <20250410-nfs-ds-netns-v2-0-f80b7979ba80@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Sargun Dillon <sargun@sargun.me>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.keornel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5670; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=O2k72Q9bczat3lfMCldhODOLGjr6CVMFFLscJ19SNn8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn+C0kP0PVEXaohOYdU9pqgxIlHdMKxGjzyq1o5
 Nx9KzI5HQaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/gtJAAKCRAADmhBGVaC
 FU3VD/99gyenhOjuixDelrfSV2WW17Bk5OkQXFnlPUUuEgGRYMmXCZwQRUvOD0/Ed+nFOrHJ4Ej
 DlH4iVjxG1yZCx06UOws0dIp67bh2lX17Z4u6b8UHYSo+7RkUFO9n/dgDJP8vnk4a57pwLxCxi8
 +cyCjlyv7lQvYFdLa8MZALmRYSLG2QWHxk5m/pkIKqCDX2lG5D88VP16QrNAa8AvC7UrzoJvzAs
 kTnBa1ZStVbWWUWGHWgk+yLBy/5A92PFlmzq9z+8RlqwCHZibZ8GWVdZdvL4m4Usnu4A/cvn4dz
 st78wu6gvDvdUrwlm4OhGJrbVFFLXuj0gYUwSmKm4aCm3zGolvPRVHCvvuC4FPn3LMCNT7pC7b7
 Qh8YfMpIwEb+It5pE5gNAbocl6rCB8YQeSjQ7b0LNfCxCeRe7sE2iRahCwnw0MKwXRJwEDrTTp/
 JaOQBbrhyDCynl81gQJ0Y3S5xeAy8VRZHvXt/IPiJ7gh8oRkl1MdsK7ZMjxS2UA42cVfpI4Hc9J
 yWVPtNATGrjfr4MV7kJ8jpeqF/yMTaC+F73QRqs1qkW9Xp/7WQmZAWNMaESizl00QygLhhtEVZ4
 Xuvmt9RgJMkHrZSBU/S+cLmZyD051UckvzZytu+fJMtT7XwVaXn1tJT6jQDjMCcgwj+k1Nj+Prn
 0UsDnTIc5DOOd+g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Since struct nfs4_pnfs_ds should not be shared between net namespaces,
move from a global list of objects to a per-netns list and spinlock.

Tested-by: Sargun Dillon <sargun@sargun.me>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/client.c   |  7 +++++++
 fs/nfs/netns.h    |  6 +++++-
 fs/nfs/pnfs_nfs.c | 31 +++++++++++++++++--------------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 9500b46005b0148a5a9a7d464095ca944de06bb5..d975123530506cd789a55337212a38ee93e84858 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1199,6 +1199,10 @@ void nfs_clients_init(struct net *net)
 	INIT_LIST_HEAD(&nn->nfs_volume_list);
 #if IS_ENABLED(CONFIG_NFS_V4)
 	idr_init(&nn->cb_ident_idr);
+#endif
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+	INIT_LIST_HEAD(&nn->nfs4_data_server_cache);
+	spin_lock_init(&nn->nfs4_data_server_lock);
 #endif
 	spin_lock_init(&nn->nfs_client_lock);
 	nn->boot_time = ktime_get_real();
@@ -1216,6 +1220,9 @@ void nfs_clients_exit(struct net *net)
 	nfs_cleanup_cb_ident_idr(net);
 	WARN_ON_ONCE(!list_empty(&nn->nfs_client_list));
 	WARN_ON_ONCE(!list_empty(&nn->nfs_volume_list));
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+	WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));
+#endif
 }
 
 #ifdef CONFIG_PROC_FS
diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
index a68b21603ea9a867ba513e2a667b08fbc6d80dd8..6ba3ea39e928c066003c6db29dd59afc2cfa9f85 100644
--- a/fs/nfs/netns.h
+++ b/fs/nfs/netns.h
@@ -31,7 +31,11 @@ struct nfs_net {
 	unsigned short nfs_callback_tcpport;
 	unsigned short nfs_callback_tcpport6;
 	int cb_users[NFS4_MAX_MINOR_VERSION + 1];
-#endif
+#endif /* CONFIG_NFS_V4 */
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+	struct list_head nfs4_data_server_cache;
+	spinlock_t nfs4_data_server_lock;
+#endif /* CONFIG_NFS_V4_1 */
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


