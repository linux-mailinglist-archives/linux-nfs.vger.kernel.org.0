Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B24C6C65
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 13:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiB1M0P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 07:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiB1MZg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 07:25:36 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3860375631
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 04:24:35 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 27so11212754pgk.10
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 04:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NevpP32QQ8SJ3jDpfuGxxyXaFtCuF+EJTDzyFWscs5o=;
        b=ihucVeQ4jgnzm85wwJYDwQ+pBJzqK/MKwHcmdBv9j/RHbv3a1ZtU6Ux8lEzIF95Ex6
         3lZewDApJuoKqkNiWQKFMHmfJMXbTq0vwQ9RClH0ndB8UJrqXY2ulzd8icYrClgdXqhe
         Ra7U/pHY64X2k5ZCc4nNUh8KVGVtvo4zVwfTNo91F19Rcka/x2NatjgcwGgT+XHXTYF6
         5uim+MWZ5ByjtbBIuAC4IyPHvYlW0iA677nEK9WjdDEd/t4Hm4CucamxAkwt2UkFjQmY
         nTmEhw972lZUkTw2rvYOpWuDH5fLx5DiKrBqe0fLSHLL0Z3EOgl0yJESz9RaIl4tuMGa
         bZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NevpP32QQ8SJ3jDpfuGxxyXaFtCuF+EJTDzyFWscs5o=;
        b=7Yn8g8F9aIAZas0z5VhPXTN6r/1OTb66+XTTwoOgeSS4/tFPF6s4EwV7/PcEgwcLJx
         hnw7GmaC9WLRHx6R9cm2d+gNE4A/9CpuqU3Zkm3TzmsRoIR8CpQsfpsoZmuOibE7aAxc
         gSbu4QRhdIBOiAGkvRCGPjHH/DPVMxBbblLLPZq9LuVZhXcrYk929HskaSCzFcNfNi8/
         E3nHaZ0XeZrPWG2yvEYfcytXp2gtihJNyIA+cYgxd6Xm5aVHzBCrgCfVClLUJbaJVczB
         2XULnbip0nfuzEVbQNivnDP/+14Wtmpu1ISd5lUMOByFGJ5cuzPeeESekvqBybcwqCW3
         pc8A==
X-Gm-Message-State: AOAM532ZRe65eWOXpIwXGuKqKLPJ7H6zXQA39bxc6T+13HTTuRYC4KTM
        SySDLkkwkmpvF+jk97jwFEm5FA==
X-Google-Smtp-Source: ABdhPJzBHt0LSbQDQn3rid6vU7ULCI5I4vMu3BCDn4hLIJ8Ym2Tkr9hIKLBIhVrgEacU7E7T7cAL2g==
X-Received: by 2002:a63:4a63:0:b0:373:a03a:8a1d with SMTP id j35-20020a634a63000000b00373a03a8a1dmr16703240pgl.460.1646051074724;
        Mon, 28 Feb 2022 04:24:34 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:24:34 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 16/16] mm: memcontrol: rename memcg_cache_id to memcg_kmem_id
Date:   Mon, 28 Feb 2022 20:21:26 +0800
Message-Id: <20220228122126.37293-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 1fe44ec5aa03..fe44e4d36bd7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1709,7 +1709,7 @@ static inline void memcg_kmem_uncharge_page(struct page *page, int order)
  * A helper for accessing memcg's kmem_id, used for getting
  * corresponding LRU lists.
  */
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return memcg ? memcg->kmemcg_id : -1;
 }
@@ -1747,7 +1747,7 @@ static inline bool memcg_kmem_enabled(void)
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

