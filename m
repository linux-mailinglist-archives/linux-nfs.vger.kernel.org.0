Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7A2313BC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jul 2020 22:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgG1UR3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jul 2020 16:17:29 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:9627 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1UR2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jul 2020 16:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595967448; x=1627503448;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LGpMerhhR9Oh5pTjKf+VTEHC+MPZWiAHydQS8GEgh+g=;
  b=bDesURlYl2NhWsdvmb1y6b0f0rkOJ6AQp4Pw2uoYb2d5Ctj9TrQvIToH
   I63ql0KqqmJ7C1vP6xzawVnp4WN0mC0s+fkHC0Up1oLSV2Vhb3FaFTniB
   zK5EfuPQBJeYWrD3oHzMokqRafgvoxzE4pGTsI5w6MZQGUPOsZ+bPlnvs
   k=;
IronPort-SDR: 5DinhplS68tQP9HSA4vkIx97pBddItnziYhgUfkkgIPoDTMCHYdxL4zD2HzGAJY58XjXbiYMm4
 +MrLYc9PmBYg==
X-IronPort-AV: E=Sophos;i="5.75,407,1589241600"; 
   d="scan'208";a="63718901"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 28 Jul 2020 20:17:24 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 6C7EEA29DF;
        Tue, 28 Jul 2020 20:17:23 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 20:17:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 20:17:22 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 28 Jul 2020 20:17:22 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id C799AC3B09; Tue, 28 Jul 2020 20:17:22 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH] NFSv4.2: xattr cache: get rid of cache discard work queue
Date:   Tue, 28 Jul 2020 20:17:22 +0000
Message-ID: <20200728201722.27405-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Caches should be small enough to discard them inline, so do that
instead of using a work queue.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42xattr.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 23fdab977a2a..86777996cfec 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -75,7 +75,6 @@ struct nfs4_xattr_cache {
 	spinlock_t listxattr_lock;
 	struct inode *inode;
 	struct nfs4_xattr_entry *listxattr;
-	struct work_struct work;
 };
 
 struct nfs4_xattr_entry {
@@ -101,8 +100,6 @@ static struct list_lru nfs4_xattr_large_entry_lru;
 
 static struct kmem_cache *nfs4_xattr_cache_cachep;
 
-static struct workqueue_struct *nfs4_xattr_cache_wq;
-
 /*
  * Hashing helper functions.
  */
@@ -365,9 +362,8 @@ nfs4_xattr_cache_unlink(struct inode *inode)
 }
 
 /*
- * Discard a cache. Usually called by a worker, since walking all
- * the entries can take up some cycles that we don't want to waste
- * in the I/O path. Can also be called from the shrinker callback.
+ * Discard a cache. Called by get_cache() if there was an old,
+ * invalid cache. Can also be called from a shrinker callback.
  *
  * The cache is dead, it has already been unlinked from its inode,
  * and no longer appears on the cache LRU list.
@@ -414,21 +410,6 @@ nfs4_xattr_discard_cache(struct nfs4_xattr_cache *cache)
 	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
 }
 
-static void
-nfs4_xattr_discard_cache_worker(struct work_struct *work)
-{
-	struct nfs4_xattr_cache *cache = container_of(work,
-	    struct nfs4_xattr_cache, work);
-
-	nfs4_xattr_discard_cache(cache);
-}
-
-static void
-nfs4_xattr_reap_cache(struct nfs4_xattr_cache *cache)
-{
-	queue_work(nfs4_xattr_cache_wq, &cache->work);
-}
-
 /*
  * Get a referenced copy of the cache structure. Avoid doing allocs
  * while holding i_lock. Which means that we do some optimistic allocation,
@@ -513,10 +494,10 @@ nfs4_xattr_get_cache(struct inode *inode, int add)
 
 out:
 	/*
-	 * Discarding an old cache is done via a workqueue.
+	 * Discard the now orphaned old cache.
 	 */
 	if (oldcache != NULL)
-		nfs4_xattr_reap_cache(oldcache);
+		nfs4_xattr_discard_cache(oldcache);
 
 	return cache;
 }
@@ -1008,7 +989,6 @@ static void nfs4_xattr_cache_init_once(void *p)
 	atomic_long_set(&cache->nent, 0);
 	nfs4_xattr_hash_init(cache);
 	cache->listxattr = NULL;
-	INIT_WORK(&cache->work, nfs4_xattr_discard_cache_worker);
 	INIT_LIST_HEAD(&cache->lru);
 	INIT_LIST_HEAD(&cache->dispose);
 }
@@ -1039,13 +1019,9 @@ int __init nfs4_xattr_cache_init(void)
 	if (ret)
 		goto out2;
 
-	nfs4_xattr_cache_wq = alloc_workqueue("nfs4_xattr", WQ_MEM_RECLAIM, 0);
-	if (nfs4_xattr_cache_wq == NULL)
-		goto out1;
-
 	ret = register_shrinker(&nfs4_xattr_cache_shrinker);
 	if (ret)
-		goto out0;
+		goto out1;
 
 	ret = register_shrinker(&nfs4_xattr_entry_shrinker);
 	if (ret)
@@ -1058,8 +1034,6 @@ int __init nfs4_xattr_cache_init(void)
 	unregister_shrinker(&nfs4_xattr_entry_shrinker);
 out:
 	unregister_shrinker(&nfs4_xattr_cache_shrinker);
-out0:
-	destroy_workqueue(nfs4_xattr_cache_wq);
 out1:
 	list_lru_destroy(&nfs4_xattr_cache_lru);
 out2:
@@ -1079,5 +1053,4 @@ void nfs4_xattr_cache_exit(void)
 	list_lru_destroy(&nfs4_xattr_entry_lru);
 	list_lru_destroy(&nfs4_xattr_cache_lru);
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
-	destroy_workqueue(nfs4_xattr_cache_wq);
 }
-- 
2.17.2

