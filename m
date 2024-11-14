Return-Path: <linux-nfs+bounces-7962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4E9C81A0
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D47B23B89
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2241E7C15;
	Thu, 14 Nov 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuynzYqR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F01E22E4
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556808; cv=none; b=JikTF1yiyrIizCz9CbTXV4T8Y2blxjeI5JE9++nQuoKcQC77sRMBTpm6Tdy1hojyj9aTkl142LwnJNZjCN8JeVx+IFO6LF7OwNWW9dzwi3jrX6t0wh/p070xYzKHw1cy7DlnC86cQ2ZHCyguiN4wUNX9RuoJcIMLIX56n6pvZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556808; c=relaxed/simple;
	bh=3ttQBIkjaCQ9n5j/9Os/A3KZl8ziuelaTPtXJdhcUmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdB2Ml7Ep5GHuzbhLTssB5oXej+WJ59vmDPeEQuATNoOepvPhqKiU4Z5/nq9594/Q73/LdvZRrB5rs1m3+mUsleUtO0B0RNHjO17DFkMh9xlH3J4q55VGZy5CkW3Wn3iS8EpE1LPd0hBUrrVlFM1rbjvB4uUusPFYCJE/Wumng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuynzYqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38070C4CED0;
	Thu, 14 Nov 2024 04:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556808;
	bh=3ttQBIkjaCQ9n5j/9Os/A3KZl8ziuelaTPtXJdhcUmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuynzYqRNACQOQDSG61OlI4yZ7brLKNdN86V6v+OZg2CUPKmvr8l5Dx6BMmQlKfOz
	 MojVNNDIzBM9gRtYzBs7c5Zerbp4fLHpvry5yMpAlWmjmqkzUFe015CmLtJF5Qt3TN
	 wWa3sOsmR8TahUFO2RTKcLRUsPDGcl4yr8gg6QgNZiWWiKm1m5shnA9FCw9w+wRdzE
	 /3b13iL+H+rzG+sg1DtDvjlmjZHIAP5ZNi67yzR5SeZtCOaHHjeewxI65pYz/pc/st
	 +SS3Qbdp9dAMVo0rgXB320Rh1+33aKvHxXwvczD3KIa9iVitFF6uXEH/9rF+xlSoNY
	 XoGRGqNytqyYA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 11/15] nfs_common: track all open nfsd_files per LOCALIO nfs_client
Date: Wed, 13 Nov 2024 22:59:48 -0500
Message-ID: <20241114035952.13889-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tracking enables __nfsd_file_cache_purge() to call
nfs_localio_invalidate_clients(), upon shutdown or export change, to
nfs_close_local_fh() all open nfsd_files that are still cached by the
LOCALIO nfs clients associated with nfsd_net that is being shutdown.

Now that the client must track all open nfsd_files there was more work
than necessary being done with the global nfs_uuids_lock contended.
This manifested in various RCU issues, e.g.:
 hrtimer: interrupt took 47969440 ns
 rcu: INFO: rcu_sched detected stalls on CPUs/tasks:

Use nfs_uuid->lock to protect all nfs_uuid_t members, instead of
nfs_uuids_lock, once nfs_uuid_is_local() adds the client to
nn->local_clients.

Also add 'local_clients_lock' to 'struct nfsd_net' to protect
nn->local_clients.  And store a pointer to spinlock in the 'list_lock'
member of nfs_uuid_t so nfs_localio_disable_client() can use it to
avoid taking the global nfs_uuids_lock.

In combination, these split out locks eliminate the use of the single
nfslocalio.c global nfs_uuids_lock in the IO paths (open and close).

Also refactored associated fs/nfs_common/nfslocalio.c methods' locking
to reduce work performed with spinlocks held in general.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 166 +++++++++++++++++++++++++++----------
 fs/nfsd/filecache.c        |   9 ++
 fs/nfsd/localio.c          |   1 +
 fs/nfsd/netns.h            |   1 +
 fs/nfsd/nfsctl.c           |   4 +-
 include/linux/nfslocalio.h |   8 +-
 6 files changed, 143 insertions(+), 46 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 5fa3f47b442e9..e5c0912b9a025 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -23,27 +23,49 @@ static DEFINE_SPINLOCK(nfs_uuids_lock);
  */
 static LIST_HEAD(nfs_uuids);
 
+/*
+ * Lock ordering:
+ * 1: nfs_uuid->lock
+ * 2: nfs_uuids_lock
+ * 3: nfs_uuid->list_lock (aka nn->local_clients_lock)
+ *
+ * May skip locks in select cases, but never hold multiple
+ * locks out of order.
+ */
+
 void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
 {
 	nfs_uuid->net = NULL;
 	nfs_uuid->dom = NULL;
+	nfs_uuid->list_lock = NULL;
 	INIT_LIST_HEAD(&nfs_uuid->list);
+	INIT_LIST_HEAD(&nfs_uuid->files);
 	spin_lock_init(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_init);
 
 bool nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
 {
+	spin_lock(&nfs_uuid->lock);
+	if (nfs_uuid->net) {
+		/* This nfs_uuid is already in use */
+		spin_unlock(&nfs_uuid->lock);
+		return false;
+	}
+
 	spin_lock(&nfs_uuids_lock);
-	/* Is this nfs_uuid already in use? */
 	if (!list_empty(&nfs_uuid->list)) {
+		/* This nfs_uuid is already in use */
 		spin_unlock(&nfs_uuids_lock);
+		spin_unlock(&nfs_uuid->lock);
 		return false;
 	}
-	uuid_gen(&nfs_uuid->uuid);
 	list_add_tail(&nfs_uuid->list, &nfs_uuids);
 	spin_unlock(&nfs_uuids_lock);
 
+	uuid_gen(&nfs_uuid->uuid);
+	spin_unlock(&nfs_uuid->lock);
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_begin);
@@ -51,11 +73,15 @@ EXPORT_SYMBOL_GPL(nfs_uuid_begin);
 void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
 {
 	if (nfs_uuid->net == NULL) {
-		spin_lock(&nfs_uuids_lock);
-		if (nfs_uuid->net == NULL)
+		spin_lock(&nfs_uuid->lock);
+		if (nfs_uuid->net == NULL) {
+			/* Not local, remove from nfs_uuids */
+			spin_lock(&nfs_uuids_lock);
 			list_del_init(&nfs_uuid->list);
-		spin_unlock(&nfs_uuids_lock);
-	}
+			spin_unlock(&nfs_uuids_lock);
+		}
+		spin_unlock(&nfs_uuid->lock);
+        }
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_end);
 
@@ -73,28 +99,39 @@ static nfs_uuid_t * nfs_uuid_lookup_locked(const uuid_t *uuid)
 static struct module *nfsd_mod;
 
 void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
-		       struct net *net, struct auth_domain *dom,
-		       struct module *mod)
+		       spinlock_t *list_lock, struct net *net,
+		       struct auth_domain *dom, struct module *mod)
 {
 	nfs_uuid_t *nfs_uuid;
 
 	spin_lock(&nfs_uuids_lock);
 	nfs_uuid = nfs_uuid_lookup_locked(uuid);
-	if (nfs_uuid) {
-		kref_get(&dom->ref);
-		nfs_uuid->dom = dom;
-		/*
-		 * We don't hold a ref on the net, but instead put
-		 * ourselves on a list so the net pointer can be
-		 * invalidated.
-		 */
-		list_move(&nfs_uuid->list, list);
-		rcu_assign_pointer(nfs_uuid->net, net);
-
-		__module_get(mod);
-		nfsd_mod = mod;
+	if (!nfs_uuid) {
+		spin_unlock(&nfs_uuids_lock);
+		return;
 	}
+
+	/*
+	 * We don't hold a ref on the net, but instead put
+	 * ourselves on @list (nn->local_clients) so the net
+	 * pointer can be invalidated.
+	 */
+	spin_lock(list_lock); /* list_lock is nn->local_clients_lock */
+	list_move(&nfs_uuid->list, list);
+	spin_unlock(list_lock);
+
 	spin_unlock(&nfs_uuids_lock);
+	/* Once nfs_uuid is parented to @list, avoid global nfs_uuids_lock */
+	spin_lock(&nfs_uuid->lock);
+
+	__module_get(mod);
+	nfsd_mod = mod;
+
+	nfs_uuid->list_lock = list_lock;
+	kref_get(&dom->ref);
+	nfs_uuid->dom = dom;
+	rcu_assign_pointer(nfs_uuid->net, net);
+	spin_unlock(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
 
@@ -108,55 +145,96 @@ void nfs_localio_enable_client(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
 
-static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
+/*
+ * Cleanup the nfs_uuid_t embedded in an nfs_client.
+ * This is the long-form of nfs_uuid_init().
+ */
+static void nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 {
-	if (!nfs_uuid->net)
+	LIST_HEAD(local_files);
+	struct nfs_file_localio *nfl, *tmp;
+
+	spin_lock(&nfs_uuid->lock);
+	if (unlikely(!nfs_uuid->net)) {
+		spin_unlock(&nfs_uuid->lock);
 		return;
-	module_put(nfsd_mod);
+	}
 	RCU_INIT_POINTER(nfs_uuid->net, NULL);
 
 	if (nfs_uuid->dom) {
 		auth_domain_put(nfs_uuid->dom);
 		nfs_uuid->dom = NULL;
 	}
-	list_del_init(&nfs_uuid->list);
+
+	list_splice_init(&nfs_uuid->files, &local_files);
+	spin_unlock(&nfs_uuid->lock);
+
+	/* Walk list of files and ensure their last references dropped */
+	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
+		nfs_close_local_fh(nfl);
+		cond_resched();
+	}
+
+	spin_lock(&nfs_uuid->lock);
+	BUG_ON(!list_empty(&nfs_uuid->files));
+
+	/* Remove client from nn->local_clients */
+	if (nfs_uuid->list_lock) {
+		spin_lock(nfs_uuid->list_lock);
+		BUG_ON(list_empty(&nfs_uuid->list));
+		list_del_init(&nfs_uuid->list);
+		spin_unlock(nfs_uuid->list_lock);
+		nfs_uuid->list_lock = NULL;
+	}
+
+	module_put(nfsd_mod);
+	spin_unlock(&nfs_uuid->lock);
 }
 
 void nfs_localio_disable_client(struct nfs_client *clp)
 {
-	nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
+	nfs_uuid_t *nfs_uuid = NULL;
 
-	spin_lock(&nfs_uuid->lock);
+	spin_lock(&clp->cl_uuid.lock); /* aka &nfs_uuid->lock */
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
-		spin_lock(&nfs_uuids_lock);
-		nfs_uuid_put_locked(nfs_uuid);
-		spin_unlock(&nfs_uuids_lock);
+		/* &clp->cl_uuid is always not NULL, using as bool here */
+		nfs_uuid = &clp->cl_uuid;
 	}
-	spin_unlock(&nfs_uuid->lock);
+	spin_unlock(&clp->cl_uuid.lock);
+
+	if (nfs_uuid)
+		nfs_uuid_put(nfs_uuid);
 }
 EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
 
-void nfs_localio_invalidate_clients(struct list_head *cl_uuid_list)
+void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
+				    spinlock_t *nn_local_clients_lock)
 {
+	LIST_HEAD(local_clients);
 	nfs_uuid_t *nfs_uuid, *tmp;
+	struct nfs_client *clp;
 
-	spin_lock(&nfs_uuids_lock);
-	list_for_each_entry_safe(nfs_uuid, tmp, cl_uuid_list, list) {
-		struct nfs_client *clp =
-			container_of(nfs_uuid, struct nfs_client, cl_uuid);
-
+	spin_lock(nn_local_clients_lock);
+	list_splice_init(nn_local_clients, &local_clients);
+	spin_unlock(nn_local_clients_lock);
+	list_for_each_entry_safe(nfs_uuid, tmp, &local_clients, list) {
+		if (WARN_ON(nfs_uuid->list_lock != nn_local_clients_lock))
+			break;
+		clp = container_of(nfs_uuid, struct nfs_client, cl_uuid);
 		nfs_localio_disable_client(clp);
 	}
-	spin_unlock(&nfs_uuids_lock);
 }
 EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
 
 static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl)
 {
-	spin_lock(&nfs_uuids_lock);
-	if (!nfl->nfs_uuid)
+	/* Add nfl to nfs_uuid->files if it isn't already */
+	spin_lock(&nfs_uuid->lock);
+	if (list_empty(&nfl->list)) {
 		rcu_assign_pointer(nfl->nfs_uuid, nfs_uuid);
-	spin_unlock(&nfs_uuids_lock);
+		list_add_tail(&nfl->list, &nfs_uuid->files);
+	}
+	spin_unlock(&nfs_uuid->lock);
 }
 
 /*
@@ -217,14 +295,16 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	ro_nf = rcu_access_pointer(nfl->ro_file);
 	rw_nf = rcu_access_pointer(nfl->rw_file);
 	if (ro_nf || rw_nf) {
-		spin_lock(&nfs_uuids_lock);
+		spin_lock(&nfs_uuid->lock);
 		if (ro_nf)
 			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
 		if (rw_nf)
 			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
 
+		/* Remove nfl from nfs_uuid->files list */
 		rcu_assign_pointer(nfl->nfs_uuid, NULL);
-		spin_unlock(&nfs_uuids_lock);
+		list_del_init(&nfl->list);
+		spin_unlock(&nfs_uuid->lock);
 		rcu_read_unlock();
 
 		if (ro_nf)
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ab9942e420543..c9ab64e3732ce 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -39,6 +39,7 @@
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
 #include <linux/rhashtable.h>
+#include <linux/nfslocalio.h>
 
 #include "vfs.h"
 #include "nfsd.h"
@@ -836,6 +837,14 @@ __nfsd_file_cache_purge(struct net *net)
 	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	if (net) {
+		struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+		nfs_localio_invalidate_clients(&nn->local_clients,
+					       &nn->local_clients_lock);
+	}
+#endif
+
 	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
 	do {
 		rhashtable_walk_start(&iter);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 2ae07161b9195..238647fa379e3 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -116,6 +116,7 @@ static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfs_uuid_is_local(&argp->uuid, &nn->local_clients,
+			  &nn->local_clients_lock,
 			  net, rqstp->rq_client, THIS_MODULE);
 
 	return rpc_success;
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 8faef59d71229..187c4140b1913 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -220,6 +220,7 @@ struct nfsd_net {
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	/* Local clients to be invalidated when net is shut down */
+	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
 };
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 727904d8a4d01..70347b0ecdc43 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2259,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	seqlock_init(&nn->writeverf_lock);
 	nfsd_proc_stat_init(net);
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	spin_lock_init(&nn->local_clients_lock);
 	INIT_LIST_HEAD(&nn->local_clients);
 #endif
 	return 0;
@@ -2283,7 +2284,8 @@ static __net_exit void nfsd_net_pre_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nfs_localio_invalidate_clients(&nn->local_clients);
+	nfs_localio_invalidate_clients(&nn->local_clients,
+				       &nn->local_clients_lock);
 }
 #endif
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index aa2b5c6561ab0..c68a529230c14 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -30,19 +30,23 @@ typedef struct {
 	/* sadly this struct is just over a cacheline, avoid bouncing */
 	spinlock_t ____cacheline_aligned lock;
 	struct list_head list;
+	spinlock_t *list_lock; /* nn->local_clients_lock */
 	struct net __rcu *net; /* nfsd's network namespace */
 	struct auth_domain *dom; /* auth_domain for localio */
+	/* Local files to close when net is shut down or exports change */
+	struct list_head files;
 } nfs_uuid_t;
 
 void nfs_uuid_init(nfs_uuid_t *);
 bool nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
-void nfs_uuid_is_local(const uuid_t *, struct list_head *,
+void nfs_uuid_is_local(const uuid_t *, struct list_head *, spinlock_t *,
 		       struct net *, struct auth_domain *, struct module *);
 
 void nfs_localio_enable_client(struct nfs_client *clp);
 void nfs_localio_disable_client(struct nfs_client *clp);
-void nfs_localio_invalidate_clients(struct list_head *list);
+void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
+				    spinlock_t *nn_local_clients_lock);
 
 /* localio needs to map filehandle -> struct nfsd_file */
 extern struct nfsd_file *
-- 
2.44.0


