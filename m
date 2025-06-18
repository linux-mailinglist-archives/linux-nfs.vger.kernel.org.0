Return-Path: <linux-nfs+bounces-12569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE18ADF8CC
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 23:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEB33A6CBD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 21:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8AC27A909;
	Wed, 18 Jun 2025 21:34:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3721ABDA
	for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282450; cv=none; b=DTCSXEgltyyb5Xk4tz0Bo0aeqwhANdPAmsgsD6+v/Y3bqx0y51QJdOsRsLSBX5LzO91KuF0KHHbsuLNn8weEXOcGjXj1A0Fe+QG4tozInX9So8lMXC7slSC1h/lW0H7a15Xop6pmNXO/76Hx4WAjQfXYQ+RTxtRmHCQpUds0TX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282450; c=relaxed/simple;
	bh=JPm11RZJNxdpm6E48UAVB0bDRHkBny4Ezltg97axLqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiS96DsPKkVY6O4dPW06n9OX7a2GB2Vqu1gX8VpOw2qr7ThMt9GRQECfX0+v+7U6K8FOYnBzmtk8WhIsDZxMV+57JP34UnXgSVp+wrHM8GslGbyp4AcyJkIh6swpzS1mjn8cPqYE/oI/0VQKCk1Zxd9816PJN+dv67eNN+nveyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uS0Pt-000Yqs-NG;
	Wed, 18 Jun 2025 21:33:57 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 2/3] nfsd: use kref and new mutex for global config management
Date: Thu, 19 Jun 2025 07:31:52 +1000
Message-ID: <20250618213347.425503-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618213347.425503-1-neil@brown.name>
References: <20250618213347.425503-1-neil@brown.name>
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

"nfsd_users" is changed to a kref which is can be taken to delay
the shutdown of global services.  nfsd_startup_get(), it is succeeds,
ensure the global services will remain until nfsd_startup_put().

The new mutex, nfsd_startup_mutex, is only take for startup and
shutdown.  It is not needed to protect the kref.

The locking needed by nfsd_file_cache_purge() is now provided internally
by that function so calls don't need to be concerned.

This replaces NFSD_FILE_CACHE_UP which is effective just a flag which
says nfsd_users is non-zero.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/export.c    |  6 ------
 fs/nfsd/filecache.c | 31 +++++++++++--------------------
 fs/nfsd/nfsd.h      |  3 +++
 fs/nfsd/nfssvc.c    | 41 +++++++++++++++++++++++++++--------------
 4 files changed, 41 insertions(+), 40 deletions(-)

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
index e108b6c705b4..0a9116b7530c 100644
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
@@ -112,9 +109,12 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
 static void
 nfsd_file_schedule_laundrette(void)
 {
-	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
+	if (nfsd_startup_get()) {
+		queue_delayed_work(system_unbound_wq,
+				   &nfsd_filecache_laundrette,
 				   NFSD_LAUNDRETTE_DELAY);
+		nfsd_startup_put();
+	}
 }
 
 static void
@@ -795,10 +795,6 @@ nfsd_file_cache_init(void)
 {
 	int ret;
 
-	lockdep_assert_held(&nfsd_mutex);
-	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
-		return 0;
-
 	ret = rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
 	if (ret)
 		goto out;
@@ -853,8 +849,6 @@ nfsd_file_cache_init(void)
 
 	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
 out:
-	if (ret)
-		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
 	return ret;
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
@@ -958,9 +952,10 @@ nfsd_file_cache_start_net(struct net *net)
 void
 nfsd_file_cache_purge(struct net *net)
 {
-	lockdep_assert_held(&nfsd_mutex);
-	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
+	if (nfsd_startup_get()) {
 		__nfsd_file_cache_purge(net);
+		nfsd_startup_put();
+	}
 }
 
 void
@@ -975,10 +970,6 @@ nfsd_file_cache_shutdown(void)
 {
 	int i;
 
-	lockdep_assert_held(&nfsd_mutex);
-	if (test_and_clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0)
-		return;
-
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 	shrinker_free(nfsd_file_shrinker);
 	/*
@@ -1347,8 +1338,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 	unsigned long lru = 0, total_age = 0;
 
 	/* Serialize with server shutdown */
-	mutex_lock(&nfsd_mutex);
-	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1) {
+	if (nfsd_startup_get()) {
 		struct bucket_table *tbl;
 		struct rhashtable *ht;
 
@@ -1360,8 +1350,9 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		tbl = rht_dereference_rcu(ht->tbl, ht);
 		buckets = tbl->size;
 		rcu_read_unlock();
+
+		nfsd_startup_put();
 	}
-	mutex_unlock(&nfsd_mutex);
 
 	for_each_possible_cpu(i) {
 		hits += per_cpu(nfsd_file_cache_hits, i);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1bfd0b4e9af7..8ad9fcc23789 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -80,6 +80,9 @@ extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
 extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
+bool nfsd_startup_get(void);
+void nfsd_startup_put(void);
+
 extern const struct seq_operations nfs_exports_op;
 
 /*
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 82b0111ac469..b2080e5a71e6 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -270,38 +270,51 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
 	return 0;
 }
 
-static int nfsd_users = 0;
+static struct kref nfsd_users = KREF_INIT(0);
+static DEFINE_MUTEX(nfsd_startup_mutex);
 
 static int nfsd_startup_generic(void)
 {
-	int ret;
+	int ret = 0;
 
-	if (nfsd_users++)
+	if (kref_get_unless_zero(&nfsd_users))
 		return 0;
+	mutex_lock(&nfsd_startup_mutex);
+	if (kref_get_unless_zero(&nfsd_users))
+		goto out_unlock;
 
 	ret = nfsd_file_cache_init();
 	if (ret)
-		goto dec_users;
+		goto out_unlock;
 
 	ret = nfs4_state_start();
 	if (ret)
 		goto out_file_cache;
-	return 0;
+	kref_init(&nfsd_users);
+out_unlock:
+	mutex_unlock(&nfsd_startup_mutex);
+	return ret;
 
 out_file_cache:
 	nfsd_file_cache_shutdown();
-dec_users:
-	nfsd_users--;
-	return ret;
+	goto out_unlock;
 }
 
-static void nfsd_shutdown_generic(void)
+static void nfsd_shutdown_cb(struct kref *kref)
 {
-	if (--nfsd_users)
-		return;
-
 	nfs4_state_shutdown();
 	nfsd_file_cache_shutdown();
+	mutex_unlock(&nfsd_startup_mutex);
+}
+
+bool nfsd_startup_get(void)
+{
+	return kref_get_unless_zero(&nfsd_users);
+}
+
+void nfsd_startup_put(void)
+{
+	kref_put_mutex(&nfsd_users, nfsd_shutdown_cb, &nfsd_startup_mutex);
 }
 
 static bool nfsd_needs_lockd(struct nfsd_net *nn)
@@ -416,7 +429,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 		nn->lockd_up = false;
 	}
 out_socks:
-	nfsd_shutdown_generic();
+	nfsd_startup_put();
 	return ret;
 }
 
@@ -443,7 +456,7 @@ static void nfsd_shutdown_net(struct net *net)
 	percpu_ref_exit(&nn->nfsd_net_ref);
 
 	nn->nfsd_net_up = false;
-	nfsd_shutdown_generic();
+	nfsd_startup_put();
 }
 
 static DEFINE_SPINLOCK(nfsd_notifier_lock);
-- 
2.49.0


