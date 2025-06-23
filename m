Return-Path: <linux-nfs+bounces-12621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B1AE33D5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 05:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64097188FC87
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 03:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C611225D7;
	Mon, 23 Jun 2025 03:00:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57E1F941
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647650; cv=none; b=s85d4wtp67f1SPCS03+PnWC8brrF4UeYhOozYugPbTlAOqffCY25nGHS7K/xH8op1Ne7/SfwS2LMprIotM1Sq5srNIL2zC847OM2oxnPzP3xj3w68a74vtczzre7FhoTJKFm+QTTXi4ru+xIQHFjkDsWqNwcoLLKceqQTYVSbjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647650; c=relaxed/simple;
	bh=lxXioyVtX07SHofUWEExDq2F4rWQEamI4ELHXCHIS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAXFDk2Mr/oKXHt87IrAM3hhyhmdOG924hJiTEZaxUTAdTa+BPiWt73wmm7GHnb7JV+hEH4AXTkim5+XC+bemaCoZuu4N0kk1R2Li7qwQuEcig+WKcyImulWMWJ3l9un9s2riOfO4Dwcgc9oDVZiEh8sYCYlItfYypTaQ4RhWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uTXQM-0036ab-Do;
	Mon, 23 Jun 2025 03:00:46 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 2/4] nfsd: use mutex for global config management and clean up on module unload
Date: Mon, 23 Jun 2025 12:47:14 +1000
Message-ID: <20250623030015.2353515-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623030015.2353515-1-neil@brown.name>
References: <20250623030015.2353515-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd_mutex is used for two quite different things:
1/ it prevents races when start/stoping global resources:
   the filecache and the v4 state table
2/ it prevents races for per-netns config, typically
   ensure config changes are synchronised w.r.t. server
   startup/shutdown.

This patch splits out the first used.  A subsequent patch improves the
second.

"nfsd_users" is replaced by a simple bool that records if global
initialisation has completed.  If not a new mutex (nfsd_startup_mutex)
is taken, the check is repeated, and if needed the initialisation is
done.

Cleanup is now left to module unload (nfsd_exit()) so there is no
possibility of races with server shutdown.

This replaces NFSD_FILE_CACHE_UP which is effective just a flag which
says nfsd_users is non-zero.

We no longer need to clear the filecache stats because all nfsd-local
memory is effectively cleared on unload.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/export.c    |  6 ----
 fs/nfsd/filecache.c | 75 ++++++++++-----------------------------------
 fs/nfsd/nfsctl.c    |  5 +++
 fs/nfsd/nfsd.h      |  2 ++
 fs/nfsd/nfssvc.c    | 34 ++++++++++----------
 5 files changed, 40 insertions(+), 82 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index cadfc2bae60e..1ea3d72ef5c9 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -243,13 +243,7 @@ static struct cache_head *expkey_alloc(void)
 
 static void expkey_flush(void)
 {
-	/*
-	 * Take the nfsd_mutex here to ensure that the file cache is not
-	 * destroyed while we're in the middle of flushing.
-	 */
-	mutex_lock(&nfsd_mutex);
 	nfsd_file_cache_purge(current->nsproxy->net_ns);
-	mutex_unlock(&nfsd_mutex);
 }
 
 static const struct cache_detail svc_expkey_cache_template = {
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e108b6c705b4..bd636d0bc05a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -50,8 +50,6 @@
 
 #define NFSD_LAUNDRETTE_DELAY		     (2 * HZ)
 
-#define NFSD_FILE_CACHE_UP		     (0)
-
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
 #define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
 
@@ -70,7 +68,6 @@ struct nfsd_fcache_disposal {
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
-static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
 static struct delayed_work		nfsd_filecache_laundrette;
 static struct rhltable			nfsd_file_rhltable
@@ -112,9 +109,9 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
 static void
 nfsd_file_schedule_laundrette(void)
 {
-	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
-				   NFSD_LAUNDRETTE_DELAY);
+	queue_delayed_work(system_unbound_wq,
+			   &nfsd_filecache_laundrette,
+			   NFSD_LAUNDRETTE_DELAY);
 }
 
 static void
@@ -795,10 +792,6 @@ nfsd_file_cache_init(void)
 {
 	int ret;
 
-	lockdep_assert_held(&nfsd_mutex);
-	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
-		return 0;
-
 	ret = rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
 	if (ret)
 		goto out;
@@ -853,8 +846,6 @@ nfsd_file_cache_init(void)
 
 	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
 out:
-	if (ret)
-		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
 	return ret;
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
@@ -872,15 +863,15 @@ nfsd_file_cache_init(void)
 }
 
 /**
- * __nfsd_file_cache_purge: clean out the cache for shutdown
+ * nfsd_file_cache_purge: clean out the cache for shutdown
  * @net: net-namespace to shut down the cache (may be NULL)
  *
  * Walk the nfsd_file cache and close out any that match @net. If @net is NULL,
  * then close out everything. Called when an nfsd instance is being shut down,
  * and when the exports table is flushed.
  */
-static void
-__nfsd_file_cache_purge(struct net *net)
+void
+nfsd_file_cache_purge(struct net *net)
 {
 	struct rhashtable_iter iter;
 	struct nfsd_file *nf;
@@ -950,19 +941,6 @@ nfsd_file_cache_start_net(struct net *net)
 	return nn->fcache_disposal ? 0 : -ENOMEM;
 }
 
-/**
- * nfsd_file_cache_purge - Remove all cache items associated with @net
- * @net: target net namespace
- *
- */
-void
-nfsd_file_cache_purge(struct net *net)
-{
-	lockdep_assert_held(&nfsd_mutex);
-	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
-		__nfsd_file_cache_purge(net);
-}
-
 void
 nfsd_file_cache_shutdown_net(struct net *net)
 {
@@ -973,12 +951,6 @@ nfsd_file_cache_shutdown_net(struct net *net)
 void
 nfsd_file_cache_shutdown(void)
 {
-	int i;
-
-	lockdep_assert_held(&nfsd_mutex);
-	if (test_and_clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0)
-		return;
-
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 	shrinker_free(nfsd_file_shrinker);
 	/*
@@ -986,7 +958,7 @@ nfsd_file_cache_shutdown(void)
 	 * calling nfsd_file_cache_purge
 	 */
 	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
-	__nfsd_file_cache_purge(NULL);
+	nfsd_file_cache_purge(NULL);
 	list_lru_destroy(&nfsd_file_lru);
 	rcu_barrier();
 	fsnotify_put_group(nfsd_file_fsnotify_group);
@@ -997,15 +969,6 @@ nfsd_file_cache_shutdown(void)
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
 	rhltable_destroy(&nfsd_file_rhltable);
-
-	for_each_possible_cpu(i) {
-		per_cpu(nfsd_file_cache_hits, i) = 0;
-		per_cpu(nfsd_file_acquisitions, i) = 0;
-		per_cpu(nfsd_file_allocations, i) = 0;
-		per_cpu(nfsd_file_releases, i) = 0;
-		per_cpu(nfsd_file_total_age, i) = 0;
-		per_cpu(nfsd_file_evictions, i) = 0;
-	}
 }
 
 static struct nfsd_file *
@@ -1345,23 +1308,17 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 	unsigned long hits = 0, acquisitions = 0;
 	unsigned int i, count = 0, buckets = 0;
 	unsigned long lru = 0, total_age = 0;
+	struct bucket_table *tbl;
+	struct rhashtable *ht;
 
-	/* Serialize with server shutdown */
-	mutex_lock(&nfsd_mutex);
-	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1) {
-		struct bucket_table *tbl;
-		struct rhashtable *ht;
-
-		lru = list_lru_count(&nfsd_file_lru);
+	lru = list_lru_count(&nfsd_file_lru);
 
-		rcu_read_lock();
-		ht = &nfsd_file_rhltable.ht;
-		count = atomic_read(&ht->nelems);
-		tbl = rht_dereference_rcu(ht->tbl, ht);
-		buckets = tbl->size;
-		rcu_read_unlock();
-	}
-	mutex_unlock(&nfsd_mutex);
+	rcu_read_lock();
+	ht = &nfsd_file_rhltable.ht;
+	count = atomic_read(&ht->nelems);
+	tbl = rht_dereference_rcu(ht->tbl, ht);
+	buckets = tbl->size;
+	rcu_read_unlock();
 
 	for_each_possible_cpu(i) {
 		hits += per_cpu(nfsd_file_cache_hits, i);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6b0cad81b5fa..2a1e54af89e5 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2371,6 +2371,11 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	if (nfsd_is_started()) {
+		nfs4_state_shutdown();
+		nfsd_file_cache_shutdown();
+	}
+
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
 	genl_unregister_family(&nfsd_nl_family);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1bfd0b4e9af7..6c432133608f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -80,6 +80,8 @@ extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
 extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
+bool nfsd_is_started(void);
+
 extern const struct seq_operations nfs_exports_op;
 
 /*
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 82b0111ac469..0eb144426e95 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -270,40 +270,42 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
 	return 0;
 }
 
-static int nfsd_users = 0;
+static bool nfsd_started;
+static DEFINE_MUTEX(nfsd_startup_mutex);
+
+bool nfsd_is_started(void)
+{
+	return smp_load_acquire(&nfsd_started);
+}
 
 static int nfsd_startup_generic(void)
 {
-	int ret;
+	int ret = 0;
 
-	if (nfsd_users++)
+	if (nfsd_is_started())
 		return 0;
+	mutex_lock(&nfsd_startup_mutex);
+	if (nfsd_is_started())
+		goto out_unlock;
 
 	ret = nfsd_file_cache_init();
 	if (ret)
-		goto dec_users;
+		goto out_unlock;
 
 	ret = nfs4_state_start();
 	if (ret)
 		goto out_file_cache;
+	smp_store_release(&nfsd_started, true);
+	mutex_unlock(&nfsd_startup_mutex);
 	return 0;
 
 out_file_cache:
 	nfsd_file_cache_shutdown();
-dec_users:
-	nfsd_users--;
+out_unlock:
+	mutex_unlock(&nfsd_startup_mutex);
 	return ret;
 }
 
-static void nfsd_shutdown_generic(void)
-{
-	if (--nfsd_users)
-		return;
-
-	nfs4_state_shutdown();
-	nfsd_file_cache_shutdown();
-}
-
 static bool nfsd_needs_lockd(struct nfsd_net *nn)
 {
 	return nfsd_vers(nn, 2, NFSD_TEST) || nfsd_vers(nn, 3, NFSD_TEST);
@@ -416,7 +418,6 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 		nn->lockd_up = false;
 	}
 out_socks:
-	nfsd_shutdown_generic();
 	return ret;
 }
 
@@ -443,7 +444,6 @@ static void nfsd_shutdown_net(struct net *net)
 	percpu_ref_exit(&nn->nfsd_net_ref);
 
 	nn->nfsd_net_up = false;
-	nfsd_shutdown_generic();
 }
 
 static DEFINE_SPINLOCK(nfsd_notifier_lock);
-- 
2.49.0


