Return-Path: <linux-nfs+bounces-7805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDCB9C2830
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEC81F228F1
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E061EABA2;
	Fri,  8 Nov 2024 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLM1d6Ay"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347A1F26ED
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109222; cv=none; b=PI8iL9Nzr74Ke270O6BAA/qFv9046YKTgr59uTgsiu0ZAOzuGH30KvkcQaD0kyRRNszDhdyKTuoGX/cZimPMQtRSIKHAHxXNbY7OeKPXrExftHTVvxV7/wnx/HWH1HZD3WE8Z7jVGh6Y7NmkNl7HC/BJ+3S1SHGf1lo9pDH7nKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109222; c=relaxed/simple;
	bh=hoQvtBZFVvHGVly2EHdLwGYBy7K7knQB1FARaLwzztQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaQrZh0FbrL1sDRb5Kts5Qm1A01UlCwd0UjZrH+asMXhkddM/uw34ZI9+NBGMtWYyarW2BFCKc72Y0PQCZSIjIv4gJWstVcmOkjVbncQrzIjyi+x6hXyGX8Ei3bfERii4WE0T3VlNeTpOnDehtvTFxefM1aQk42A7tjfT+6WH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLM1d6Ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983FEC4CECE;
	Fri,  8 Nov 2024 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109221;
	bh=hoQvtBZFVvHGVly2EHdLwGYBy7K7knQB1FARaLwzztQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLM1d6AyO/ZppvX7w6LElZTVb74kgPP/Jsx+bxI9rmDXWfafVpqRfw0raAN7zeGdt
	 AYun5hcaoZzXBYCbMzdIE+ISJVNnV4Xw1E++ckcHYDouSopey5yZn7FJ4+MsMkbQ9N
	 S/IbD4XSKLuuvLQyxL9oYT6/TVy42P43m4ilU0YcBOyNKmpX03C6bgeMAoHgTqv2iB
	 A7sHE0z3BuM62YGiDTd4MrSD8STQVtje6HNyeZTzTH0pyMvB1ViblthcXrpDjw51pa
	 EnkcppTNwwkrLHwXRN/15LpsYjWhmAkdEoGpMNHcpM+xa4rktAf/5hkzxFrzV0Q+Ht
	 4XBpdty0nyhlw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 13/19] nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
Date: Fri,  8 Nov 2024 18:39:56 -0500
Message-ID: <20241108234002.16392-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 10 +++++++---
 fs/nfsd/filecache.c        |  2 +-
 fs/nfsd/localio.c          |  4 ++--
 fs/nfsd/netns.h            | 11 ++++++-----
 fs/nfsd/nfssvc.c           | 34 +++++++++++++++++-----------------
 include/linux/nfslocalio.h | 12 ++++++------
 6 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 345f3c55aa9c..0935bdcaa940 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -159,6 +159,10 @@ static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl
 	spin_unlock(&nfs_uuid_lock);
 }
 
+/*
+ * Caller is responsible for calling nfsd_net_put and
+ * nfsd_file_put (via nfs_to_nfsd_file_put_local).
+ */
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
 		   const struct nfs_fh *nfs_fh, struct nfs_file_localio *nfl,
@@ -171,7 +175,7 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
 	 * But the server may already be shutting down, if so disallow new localio.
 	 * uuid->net is NOT a counted reference, but rcu_read_lock() ensures that
-	 * if uuid->net is not NULL, then calling nfsd_serv_try_get() is safe
+	 * if uuid->net is not NULL, then calling nfsd_net_try_get() is safe
 	 * and if it succeeds we will have an implied reference to the net.
 	 *
 	 * Otherwise NFS may not have ref on NFSD and therefore cannot safely
@@ -179,12 +183,12 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	 */
 	rcu_read_lock();
 	net = rcu_dereference(uuid->net);
-	if (!net || !nfs_to->nfsd_serv_try_get(net)) {
+	if (!net || !nfs_to->nfsd_net_try_get(net)) {
 		rcu_read_unlock();
 		return ERR_PTR(-ENXIO);
 	}
 	rcu_read_unlock();
-	/* We have an implied reference to net thanks to nfsd_serv_try_get */
+	/* We have an implied reference to net thanks to nfsd_net_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
 					     cred, nfs_fh, fmode);
 	if (IS_ERR(localio))
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9a62b4da89bb..fac98b2cb463 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -391,7 +391,7 @@ nfsd_file_put(struct nfsd_file *nf)
 }
 
 /**
- * nfsd_file_put_local - put nfsd_file reference and arm nfsd_serv_put in caller
+ * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_put in caller
  * @nf: nfsd_file of which to put the reference
  *
  * First save the associated net to return to caller, then put
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 8beda4c85111..f9a91cd3b5ec 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -25,8 +25,8 @@
 #include "cache.h"
 
 static const struct nfsd_localio_operations nfsd_localio_ops = {
-	.nfsd_serv_try_get  = nfsd_serv_try_get,
-	.nfsd_serv_put  = nfsd_serv_put,
+	.nfsd_net_try_get  = nfsd_net_try_get,
+	.nfsd_net_put  = nfsd_net_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
 	.nfsd_file_get = nfsd_file_get,
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 26f7b34d1a03..8faef59d7122 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -140,9 +140,10 @@ struct nfsd_net {
 
 	struct svc_info nfsd_info;
 #define nfsd_serv nfsd_info.serv
-	struct percpu_ref nfsd_serv_ref;
-	struct completion nfsd_serv_confirm_done;
-	struct completion nfsd_serv_free_done;
+
+	struct percpu_ref nfsd_net_ref;
+	struct completion nfsd_net_confirm_done;
+	struct completion nfsd_net_free_done;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
@@ -229,8 +230,8 @@ struct nfsd_net {
 extern bool nfsd_support_version(int vers);
 extern unsigned int nfsd_net_id;
 
-bool nfsd_serv_try_get(struct net *net);
-void nfsd_serv_put(struct net *net);
+bool nfsd_net_try_get(struct net *net);
+void nfsd_net_put(struct net *net);
 
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
 void nfsd_reset_write_verifier(struct nfsd_net *nn);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6ca554042426..e937e2d0ce62 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -214,32 +214,32 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
-bool nfsd_serv_try_get(struct net *net) __must_hold(rcu)
+bool nfsd_net_try_get(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	return (nn && percpu_ref_tryget_live(&nn->nfsd_serv_ref));
+	return (nn && percpu_ref_tryget_live(&nn->nfsd_net_ref));
 }
 
-void nfsd_serv_put(struct net *net) __must_hold(rcu)
+void nfsd_net_put(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	percpu_ref_put(&nn->nfsd_serv_ref);
+	percpu_ref_put(&nn->nfsd_net_ref);
 }
 
-static void nfsd_serv_done(struct percpu_ref *ref)
+static void nfsd_net_done(struct percpu_ref *ref)
 {
-	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_net_ref);
 
-	complete(&nn->nfsd_serv_confirm_done);
+	complete(&nn->nfsd_net_confirm_done);
 }
 
-static void nfsd_serv_free(struct percpu_ref *ref)
+static void nfsd_net_free(struct percpu_ref *ref)
 {
-	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_net_ref);
 
-	complete(&nn->nfsd_serv_free_done);
+	complete(&nn->nfsd_net_free_done);
 }
 
 /*
@@ -437,8 +437,8 @@ static void nfsd_shutdown_net(struct net *net)
 	if (!nn->nfsd_net_up)
 		return;
 
-	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
-	wait_for_completion(&nn->nfsd_serv_confirm_done);
+	percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
+	wait_for_completion(&nn->nfsd_net_confirm_done);
 
 	nfsd_export_flush(net);
 	nfs4_state_shutdown_net(net);
@@ -449,8 +449,8 @@ static void nfsd_shutdown_net(struct net *net)
 		nn->lockd_up = false;
 	}
 
-	wait_for_completion(&nn->nfsd_serv_free_done);
-	percpu_ref_exit(&nn->nfsd_serv_ref);
+	wait_for_completion(&nn->nfsd_net_free_done);
+	percpu_ref_exit(&nn->nfsd_net_ref);
 
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
@@ -654,12 +654,12 @@ int nfsd_create_serv(struct net *net)
 	if (nn->nfsd_serv)
 		return 0;
 
-	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
+	error = percpu_ref_init(&nn->nfsd_net_ref, nfsd_net_free,
 				0, GFP_KERNEL);
 	if (error)
 		return error;
-	init_completion(&nn->nfsd_serv_free_done);
-	init_completion(&nn->nfsd_serv_confirm_done);
+	init_completion(&nn->nfsd_net_free_done);
+	init_completion(&nn->nfsd_net_confirm_done);
 
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 7cfc6720ed26..aa2b5c6561ab 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -52,8 +52,8 @@ nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
 void nfs_close_local_fh(struct nfs_file_localio *);
 
 struct nfsd_localio_operations {
-	bool (*nfsd_serv_try_get)(struct net *);
-	void (*nfsd_serv_put)(struct net *);
+	bool (*nfsd_net_try_get)(struct net *);
+	void (*nfsd_net_put)(struct net *);
 	struct nfsd_file *(*nfsd_open_local_fh)(struct net *,
 						struct auth_domain *,
 						struct rpc_clnt *,
@@ -77,12 +77,12 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 static inline void nfs_to_nfsd_net_put(struct net *net)
 {
 	/*
-	 * Once reference to nfsd_serv is dropped, NFSD could be
-	 * unloaded, so ensure safe return from nfsd_file_put_local()
-	 * by always taking RCU.
+	 * Once reference to net (and associated nfsd_serv) is dropped, NFSD
+	 * could be unloaded, so ensure safe return from nfsd_net_put() by
+	 * always taking RCU.
 	 */
 	rcu_read_lock();
-	nfs_to->nfsd_serv_put(net);
+	nfs_to->nfsd_net_put(net);
 	rcu_read_unlock();
 }
 
-- 
2.44.0


