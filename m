Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2314C6C4A
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 13:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiB1MZH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 07:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiB1MYk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 07:24:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45775629
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 04:23:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso11211434pjb.2
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 04:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L18k1O4fFtjGd/n9qxx+Uv18sX+SI8eOaMzIeceQpJ0=;
        b=PmFMDGtfDLfoL0LYcB+wwlGmX5lNFPAWEUcyKAA3TBBWTyfSMKsewRAH6DHEH5oNwv
         unnGYp2Q9ZxjgMKNhLxjZXRojT2/Nfgz7TTxcZqK5oOcORPluVooyG/7e9XT+tP+QX+t
         n4c6USEjWXsjWCK4vbV6+30WN7lTTlDGR/jFMcbF8uDf/fppUYQ3vIQtbyGNV+ZbAsBN
         lZ2QPNzQJ8Z4AZlYwYnJ1O4Sl2p3CJUE/aqHZIDzfbMoL3auURjakiGtLdAZTNBbqM+O
         RYkaKJVmvCVeZ8kgCiN3q5nn5ZLdau97E16oPngfZRfx7quFDjH8C7LYWPywYfztdKZo
         hsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L18k1O4fFtjGd/n9qxx+Uv18sX+SI8eOaMzIeceQpJ0=;
        b=mh3XkiXVJ7nQ6rr4YAFJfkU+qjpIYZE+Fk9wRQP6KeLmQAt4ubXtybH91iJBDegG2p
         6/hDrSvmgl3Ym5CXeVF7XXR+G5wuxHnGUnvKt6RV5E+xUkIDeFFcPqA7f5YFHs9egP1z
         HoWJTJiypdIzLQciNWPytgpV4iUXIMPnegKYVIjmf46oPVfsUiZZO8KUx4VAcSDcX2tu
         LHtWQTqbOCAiWxkIeq2OyszJgBy6fZdJK8qDerkVS4C3b1H6660iSEJ/koaL9RmSDxk+
         T/BvdXz3P62iNd2dRydHcQ25zZSehVDHN65QHA+ubwDlBq+/AgZ/pcFRQVpxNkTodDiw
         J2sA==
X-Gm-Message-State: AOAM531/YicLIg72zDoU2AA0H5ooA7DN3PhEFUMerRItDJWz1IRVqHG7
        B7rL0c0sW7+1uIcQDd/2rxF00g==
X-Google-Smtp-Source: ABdhPJwcPPC9tUJoAsYpjtdzRM0Sfy7A/YlLh58B/PmALOKFZQvLipupQ6B7GMgD7E6hVaMZuAiNcA==
X-Received: by 2002:a17:903:2c7:b0:14f:fc47:5a2f with SMTP id s7-20020a17090302c700b0014ffc475a2fmr20228267plk.112.1646051031022;
        Mon, 28 Feb 2022 04:23:51 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:23:50 -0800 (PST)
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
Subject: [PATCH v6 11/16] mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus
Date:   Mon, 28 Feb 2022 20:21:21 +0800
Message-Id: <20220228122126.37293-12-songmuchun@bytedance.com>
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

The purpose of the memcg_drain_all_list_lrus() is list_lrus reparenting.
It is very similar to memcg_reparent_objcgs(). Rename it to
memcg_reparent_list_lrus() so that the name can more consistent with
memcg_reparent_objcgs().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  2 +-
 mm/list_lru.c            | 24 ++++++++++++------------
 mm/memcontrol.c          |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index c36db6dc2a65..4b00fd8cb373 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -78,7 +78,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			 gfp_t gfp);
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst);
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index fc938d8ff48f..488dacd1f8ff 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -457,8 +457,8 @@ int memcg_update_all_list_lrus(int new_size)
 	return ret;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
-				      int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
+					 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
@@ -486,22 +486,22 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	spin_unlock_irq(&nlru->lock);
 }
 
-static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru(struct list_lru *lru,
+				    int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+		memcg_reparent_list_lru_node(lru, i, src_idx, dst_memcg);
 
 	memcg_list_lru_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst)
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	struct cgroup_subsys_state *css;
 	struct list_lru *lru;
-	int src_idx = src->kmemcg_id;
+	int src_idx = memcg->kmemcg_id;
 
 	/*
 	 * Change kmemcg_id of this cgroup and all its descendants to the
@@ -517,17 +517,17 @@ void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst)
 	 * call.
 	 */
 	rcu_read_lock();
-	css_for_each_descendant_pre(css, &src->css) {
-		struct mem_cgroup *memcg;
+	css_for_each_descendant_pre(css, &memcg->css) {
+		struct mem_cgroup *child;
 
-		memcg = mem_cgroup_from_css(css);
-		memcg->kmemcg_id = dst->kmemcg_id;
+		child = mem_cgroup_from_css(css);
+		child->kmemcg_id = parent->kmemcg_id;
 	}
 	rcu_read_unlock();
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &memcg_list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst);
+		memcg_reparent_list_lru(lru, src_idx, parent);
 	mutex_unlock(&list_lrus_mutex);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c8d39d7fc2e5..87ee5b431c05 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3656,7 +3656,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	/*
-	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
 	 * Cache it to local @kmemcg_id.
 	 */
 	kmemcg_id = memcg->kmemcg_id;
@@ -3665,9 +3665,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	 * After we have finished memcg_reparent_objcgs(), all list_lrus
 	 * corresponding to this cgroup are guaranteed to remain empty.
 	 * The ordering is imposed by list_lru_node->lock taken by
-	 * memcg_drain_all_list_lrus().
+	 * memcg_reparent_list_lrus().
 	 */
-	memcg_drain_all_list_lrus(memcg, parent);
+	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

