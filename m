Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB247A685
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 10:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhLTJAJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 04:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhLTJAI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 04:00:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E2C06173E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 01:00:08 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id o14so7559091plg.5
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 01:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nj5bpOelDWsvGfc4yM7RxdUM4ftOW0E3SXCCNb4y4Rg=;
        b=JDwBKkfz4DoUozolc1Ofuk3teBl+k3dS71xnwUbbk0If8x1FUhz5+MnsTTD6bu0ZEx
         mX4Um4loCI/1N4PizQ3MIfgHchCZ4SghVgL/r7EH0Gd9jL5NvSscjz+jQ71oWG4knCmI
         BxGbK1s5wltRaxMCjsuTQUDJDfdpoiYvjpC0DxZXuvuX+9WQ4F7REbrs/F34+q6oh4lb
         gfAire8rwlUmwFphmB7BnmcPsH7j8kC4peMgmzcUqOPLsZt6pUL/SMFxy4ZWxqd1qeQD
         WugFuKdNUEfTZmbq5BpHcgcYXf4kH4U3tdy9N8sD7jCBaNOtHLc9rZHahNhgTADiAY6z
         pKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nj5bpOelDWsvGfc4yM7RxdUM4ftOW0E3SXCCNb4y4Rg=;
        b=3yO7o01iEpJjJobI2DBN3MNXg4To4UJ856RSnP9QeZfpXfFNpTL/+R3R6VI40ioGwZ
         Wh5OPl0H7CODAhPN79PmzWtu2zabtsIHGq09JjNf63vD4fde1tvycdXSR7uhpLyS7/j9
         4EMW6rXvkBE9KSoQPBaAgmNfOkdWAc6clSdYgNHZmxO4APXnX1OdktB7+Bajh4XP6j/5
         DGIjnPXDO0g5xblauldGFSbbkK4mqrPV26k9uxI0XWSSsEkIShOP5S+zNb/cv8QMfbxZ
         XGapB/+6x05N/G4GZUPce3e8meXmOUfEqH06zR7ZUKQhyRW3MnhUetUK/CTk1YevfLZj
         rpoA==
X-Gm-Message-State: AOAM5327k36EAhUDCd9PKherSftxHKoPoEYSqhvHflDINce4+VATL2Ag
        nWg1z8C0y2/zhdRleXp9VEmPcw==
X-Google-Smtp-Source: ABdhPJyyhJdQS5rF6GJ72AexnZCsiIgIk33FtW1YNTXCIkJoHk3+KGt6KtK30DfUdxLyN/PdvWmPkw==
X-Received: by 2002:a17:90a:9907:: with SMTP id b7mr27398035pjp.137.1639990807737;
        Mon, 20 Dec 2021 01:00:07 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 01:00:07 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 16/16] mm: memcontrol: rename memcg_cache_id to memcg_kmem_id
Date:   Mon, 20 Dec 2021 16:56:49 +0800
Message-Id: <20211220085649.8196-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The memcg_cache_id() introduced by commit 2633d7a02823 ("slab/slub:
consider a memcg parameter in kmem_create_cache") is used to index
in the kmem_cache->memcg_params->memcg_caches array. Since
kmem_cache->memcg_params.memcg_caches has been removed by commit
9855609bde03 ("mm: memcg/slab: use a single set of kmem_caches for
all accounted allocations"). So the name does not need to reflect
cache related. Just rename it to memcg_kmem_id. And it can reflect
kmem related.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/list_lru.c              | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7b472f805d77..94ed3a124191 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1735,7 +1735,7 @@ static inline void memcg_kmem_uncharge_page(struct page *page, int order)
  * A helper for accessing memcg's kmem_id, used for getting
  * corresponding LRU lists.
  */
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return memcg ? memcg->kmemcg_id : -1;
 }
@@ -1773,7 +1773,7 @@ static inline bool memcg_kmem_enabled(void)
 	return false;
 }
 
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return -1;
 }
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 38f711e9b56e..8b402373e965 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -75,7 +75,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 	if (!memcg)
 		goto out;
 
-	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 out:
 	if (memcg_ptr)
 		*memcg_ptr = memcg;
@@ -182,7 +182,7 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 	long count;
 
 	rcu_read_lock();
-	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 	count = l ? READ_ONCE(l->nr_items) : 0;
 	rcu_read_unlock();
 
@@ -273,7 +273,7 @@ list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock(&nlru->lock);
-	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+	ret = __list_lru_walk_one(lru, nid, memcg_kmem_id(memcg), isolate,
 				  cb_arg, nr_to_walk);
 	spin_unlock(&nlru->lock);
 	return ret;
@@ -289,7 +289,7 @@ list_lru_walk_one_irq(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock_irq(&nlru->lock);
-	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+	ret = __list_lru_walk_one(lru, nid, memcg_kmem_id(memcg), isolate,
 				  cb_arg, nr_to_walk);
 	spin_unlock_irq(&nlru->lock);
 	return ret;
-- 
2.11.0

