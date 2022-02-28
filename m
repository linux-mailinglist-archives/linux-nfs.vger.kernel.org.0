Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A704C6C60
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 13:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiB1MZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 07:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiB1MZd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 07:25:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE674DFE
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 04:24:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id bd1so10535596plb.13
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 04:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7Mg/f9nLeyIWPXNcJvDRJ+Jd7WL7Il017lo2NLhARI=;
        b=zQqTIdjmACn7NJG/xUqkQVbl/A95M9oSKtKPYb/DBJQlkAxgYKLJqDA9F8M0aj4l+6
         VnlLKjVnqZiljGgdeEC+7n+hF2KidK1suVJKwvh06Jx9uUWB1GdJu25MZQZ1IcSQ/U2o
         20l2rAW3YSQtjG4wwTMRkqRwOi3twUpOU7kX5R/olhknVmxHSvS9V/TYz+WnvyqNwpYr
         eB6A27IFxZ4wBia+1dqzVxrkJ8J5Fyo0tStyCMJEkpEIqoYXm6bH5g3vTIwZHjB7IxVx
         SHIiG5CLMzY3rtYTRBxhE7Eb2jYc3mdtrmgWMLMppC8/juFanpDHY18swAyUbpf2l13Q
         6DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7Mg/f9nLeyIWPXNcJvDRJ+Jd7WL7Il017lo2NLhARI=;
        b=un9B8aLVdbEcJaYx+9Q6aP0iXlH7mc7fyxEEhhIj8csHcLgbiR/6jva5UY/jOFm9TE
         /BEkA/yMxHylqe2Zs4T9lLeyi0zA+tDvLbzV6ruHuaAx/I39wcvFLLKYU5+ZAhC8fOGL
         EnsSiKMwq3pWW2unxLFz8oWCuhxE3U0MNy6U79E/kqDEeEJ5czLnNa7nAktuUtCLsOkt
         xPsaHL9V4Z33BZ6wlQ7UG4Lmr/x8l2bE0lqUU0po50vu+O8RNUE6PzrbowgQUQoO0MrY
         95kiih+lDUda+irSZ9RVoOiZpQZvCdg/7A6QFbXii3FTBNykultiiGI2kfTBNQIds6xD
         IcUw==
X-Gm-Message-State: AOAM5316RvmF5GiKgZA1SmibNKyjFaxnMfDmObsSxjQUfpYDDdvDSgVY
        Qvm7x0UGfxFFbLQEX8ePO6xLCA==
X-Google-Smtp-Source: ABdhPJxrUroSeg9tuGjy2OtYyATly8LKBMC1zKeFNANYJ0uq6OHfCXB8xDMI2/gap6AVSkeFE7BBdQ==
X-Received: by 2002:a17:90a:b88a:b0:1bc:62eb:49c with SMTP id o10-20020a17090ab88a00b001bc62eb049cmr16659583pjr.228.1646051066270;
        Mon, 28 Feb 2022 04:24:26 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:24:26 -0800 (PST)
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
Subject: [PATCH v6 15/16] mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
Date:   Mon, 28 Feb 2022 20:21:25 +0800
Message-Id: <20220228122126.37293-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The name of list_lru_memcg was occupied before and became free since last
commit. Rename list_lru_per_memcg to list_lru_memcg since the name is brief.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  2 +-
 mm/list_lru.c            | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 572c263561ac..b35968ee9fb5 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,7 +32,7 @@ struct list_lru_one {
 	long			nr_items;
 };
 
-struct list_lru_per_memcg {
+struct list_lru_memcg {
 	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
 	struct list_lru_one	node[];
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 8dc1dabb9f05..38f711e9b56e 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -53,7 +53,7 @@ static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	if (list_lru_memcg_aware(lru) && idx >= 0) {
-		struct list_lru_per_memcg *mlru = xa_load(&lru->xa, idx);
+		struct list_lru_memcg *mlru = xa_load(&lru->xa, idx);
 
 		return mlru ? &mlru->node[nid] : NULL;
 	}
@@ -306,7 +306,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 
 #ifdef CONFIG_MEMCG_KMEM
 	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		unsigned long index;
 
 		xa_for_each(&lru->xa, index, mlru) {
@@ -335,10 +335,10 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
+static struct list_lru_memcg *memcg_init_list_lru_one(gfp_t gfp)
 {
 	int nid;
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	mlru = kmalloc(struct_size(mlru, node, nr_node_ids), gfp);
 	if (!mlru)
@@ -352,7 +352,7 @@ static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
 
 static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	struct list_lru_per_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
+	struct list_lru_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -374,7 +374,7 @@ static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 	XA_STATE(xas, &lru->xa, 0);
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	if (!list_lru_memcg_aware(lru))
 		return;
@@ -476,7 +476,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	unsigned long flags;
 	struct list_lru_memcg *mlrus;
 	struct list_lru_memcg_table {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
 	XA_STATE(xas, &lru->xa, 0);
@@ -492,7 +492,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	/*
 	 * Because the list_lru can be reparented to the parent cgroup's
 	 * list_lru, we should make sure that this cgroup and all its
-	 * ancestors have allocated list_lru_per_memcg.
+	 * ancestors have allocated list_lru_memcg.
 	 */
 	for (i = 0; memcg; memcg = parent_mem_cgroup(memcg), i++) {
 		if (memcg_list_lru_allocated(memcg, lru))
@@ -511,7 +511,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	xas_lock_irqsave(&xas, flags);
 	while (i--) {
 		int index = READ_ONCE(table[i].memcg->kmemcg_id);
-		struct list_lru_per_memcg *mlru = table[i].mlru;
+		struct list_lru_memcg *mlru = table[i].mlru;
 
 		xas_set(&xas, index);
 retry:
-- 
2.11.0

