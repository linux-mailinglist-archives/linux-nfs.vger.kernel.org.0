Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4DC392798
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhE0G2m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 02:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbhE0G2Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 02:28:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C13C061351
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 23:26:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k5so2158908pjj.1
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93dDqyeWkKnQFRCldXYX+fDzer/GYrGyPOg9jpoyqVw=;
        b=Nk9bXw59X2fysUcGQbiJMRbXMwzRloCfTMmf3h085vLvhUOQeTEj2ksEGX73TEk4bK
         Kz08lppd8dGTEaRfD8bBIiUOOK66s4TnKXwycowV3NGBegFdDfHQrPGDzdG+Coqgbgwq
         lRd+c+DWMv6Y8nEwvBB+32DzLORgDxngetMIIjI0HnbSpPzlVs1plFXdOKSCZj/wvx+h
         xXNth7QnMMfQgMkd3Te6l1EaPrWTDQmxAQn90dqYPGiocbYkCkS9rco3A3K+7iPQd/Eo
         1s9b+z8z7cY/PdTna6AhelSJ9qtnpNHvhvFJD+L9PQxlrFFzKzoz0ICM0wEQ3D+Uk2dM
         yc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93dDqyeWkKnQFRCldXYX+fDzer/GYrGyPOg9jpoyqVw=;
        b=MZjUu9bOX3OjjzlemKzlDIM2zZXpUrPiK0xT7NvbM+in4Xdw+PfR+YRK36+6rwF8hX
         8E0oZ66gE2S7oc0a+EsLuf6jwiBDT5yBp5gQ2YtRJbIuBQRGFJRXyGIGb/VhTD7ULPBe
         +qQWu0DHkCcoEbSvti0ObC6UwoHmvnHO+wA/C9ZoTwnjY/YMUKD+DpzN3GUW42uRnm7N
         o1+W9KXNXKBpQ4P8dAJvuywbYT1zeyreHWU4grPWcEBzFAB14iuy1D7KkD3aASYQVvuH
         0URBPTDvoDv0wLvVNfSSOJRYhw6QusteYdvXmhLpA7TEUFYbQTg3sKFgJkbl9F4SIDgY
         TDDw==
X-Gm-Message-State: AOAM531hJ6xSNX9B74Jr1wN5Y7F0hDR1mzhq3KDfMgasVbGXKp7oOyZZ
        EuO06WVdoOa8XpimrcR85kGCaQ==
X-Google-Smtp-Source: ABdhPJw5QU0YZIs70xkXlCIuCRFp/pljdG9zXUyMmIfOzkQiMS+SEzkpZQ4ufkNhu7bF4YXppazbQQ==
X-Received: by 2002:a17:903:1cd:b029:f0:c1c2:9e75 with SMTP id e13-20020a17090301cdb02900f0c1c29e75mr1808657plh.54.1622096802991;
        Wed, 26 May 2021 23:26:42 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.26.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 20/21] mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
Date:   Thu, 27 May 2021 14:21:47 +0800
Message-Id: <20210527062148.9361-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Before now, the name of list_lru_memcg was occupied. Since previous
patch, the name is free. So rename list_lru_per_memcg to list_lru_memcg,
it is more brief.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  2 +-
 mm/list_lru.c            | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index d7c9bd29e836..7497719ec71c 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,7 +32,7 @@ struct list_lru_one {
 	long			nr_items;
 };
 
-struct list_lru_per_memcg {
+struct list_lru_memcg {
 	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
 	struct list_lru_one	nodes[];
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 37052864bf78..77efdd0c8b24 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -52,7 +52,7 @@ static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	if (list_lru_memcg_aware(lru) && idx >= 0) {
-		struct list_lru_per_memcg *mlru = xa_load(lru->xa, idx);
+		struct list_lru_memcg *mlru = xa_load(lru->xa, idx);
 
 		return mlru ? &mlru->nodes[nid] : NULL;
 	}
@@ -304,7 +304,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
 				      nr_to_walk);
 	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		unsigned long index;
 
 		xa_for_each(lru->xa, index, mlru) {
@@ -331,10 +331,10 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
+static struct list_lru_memcg *memcg_list_lru_alloc(gfp_t gfp)
 {
 	int nid;
-	struct list_lru_per_memcg *lru;
+	struct list_lru_memcg *lru;
 
 	lru = kmalloc(struct_size(lru, nodes, nr_node_ids), gfp);
 	if (!lru)
@@ -348,7 +348,7 @@ static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
 
 static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	struct list_lru_per_memcg *mlru = xa_erase_irq(lru->xa, src_idx);
+	struct list_lru_memcg *mlru = xa_erase_irq(lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -378,7 +378,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 	XA_STATE(xas, lru->xa, 0);
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	if (!list_lru_memcg_aware(lru))
 		return;
@@ -483,7 +483,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	int i, ret = 0;
 
 	struct list_lru_memcg_table {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
 
@@ -494,7 +494,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 		return 0;
 
 	/*
-	 * The allocated list_lru_per_memcg array is not accounted directly.
+	 * The allocated list_lru_memcg array is not accounted directly.
 	 * Moreover, it should not come from DMA buffer and is not readily
 	 * reclaimable. So those GFP bits should be masked off.
 	 */
@@ -506,7 +506,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	/*
 	 * Because the list_lru can be reparented to the parent cgroup's
 	 * list_lru, we should make sure that this cgroup and all its
-	 * ancestors have allocated list_lru_per_memcg.
+	 * ancestors have allocated list_lru_memcg.
 	 */
 	for (i = 0; memcg; memcg = parent_mem_cgroup(memcg), i++) {
 		if (memcg_list_lru_skip_alloc(lru, memcg))
@@ -525,7 +525,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	xas_lock_irqsave(&xas, flags);
 	while (i--) {
 		int index = memcg_cache_id(table[i].memcg);
-		struct list_lru_per_memcg *mlru = table[i].mlru;
+		struct list_lru_memcg *mlru = table[i].mlru;
 
 		xas_set(&xas, index);
 retry:
-- 
2.11.0

