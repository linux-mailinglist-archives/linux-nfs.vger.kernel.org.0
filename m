Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6EF40A779
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbhINHe3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbhINHe1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:34:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C42C061762
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:33:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1430649pjh.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+aIm9+GM4emS27x0YwVh2nGeYKtoN9v9qJyVZ5TBac=;
        b=tcVTQvhIix8U0yHs7BLHxZMEPABn2dsISnmA+yZSjfp2ev8MDXF7eDdHAJvKPJ4xkX
         PNr4ylRUrZ34B88F2kvtAUWfVN/EBD5BtpS3HZkEZR7BfQzT4p6Y06tR5/9VG6+Aodei
         kRVGcb0pqYSCsfsEgkErotCWrmEoNZD3PSjBW5Y1YAHYtiI/6gja9Wn4fePBE7onrQvH
         XAJ9td79+7/0McQCwSWs8BQRVLW9G2c19R0KmRwiF3B0GmMMCIdbZo5u6p4o2Eey12cL
         A5JPRu3pkpDV34iUR4H0LYryP9pdO/oldTjF/MRuJrzVq0xtrcya5/P41feW2Vomf4bo
         xiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+aIm9+GM4emS27x0YwVh2nGeYKtoN9v9qJyVZ5TBac=;
        b=tO3s3fh1YE25KTcu4m+rIb94CLWYrB2HLtZ/fAB0x6jHteGxLN5+kic0EXy/EkiR3b
         KAAbqS8+Pc5ZPT0aqRzgRmjVF+A0MDMQ9PYZfiMAlgNM5siQi+duRaJhUu8W9I9f5pAi
         +wUxQVnL/ctXFdBcCbIWyc5m50C59O8ZrhHX3xiL10/zu5Ihyq0t9LSADyig9UUjIviG
         VJGo5FdyeUfP1nhbM0UMmqGuuoMqPNR5j9vK25yxTnfCR+aGbBxTOLKaUTkceMMe/7iX
         VGGepW/BUCBt/+PV7Agtl1AHKr1yo1pU6BnFFQ5cg9vwCMe3ZXHUwuS8ccHlqvqQBvtE
         u8eA==
X-Gm-Message-State: AOAM532LOQLIjyFoGZCkyWVmZBXtf5agtucaHnOXwLjI2eoyvz9SKL5Z
        oo/6Y1bD24uOulggAWAln3mtZQ==
X-Google-Smtp-Source: ABdhPJy5yp11xZApIkE1Vn113OINJsFeyKeaalsWeRxGnUmKvHenQWNNl7bwBD87nXmQEd1XiYqflQ==
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr510983pjl.185.1631604790353;
        Tue, 14 Sep 2021 00:33:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 02/76] mm: memcontrol: remove kmemcg_id reparenting
Date:   Tue, 14 Sep 2021 15:28:24 +0800
Message-Id: <20210914072938.6440-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since slab objects and kmem pages are charged to object cgroup instead
of memory cgroup, memcg_reparent_objcgs() will reparent this cgroup and
all its descendants to its parent cgroup. This already makes further
list_lru_add()'s add elements to the parent's list. So it is unnecessary
to change kmemcg_id of an offline cgroup to its parent's id. It just
wastes CPU cycles. Just to remove those redundant code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 999e626f4111..e0d7ceb0db26 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3635,8 +3635,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
-	struct cgroup_subsys_state *css;
-	struct mem_cgroup *parent, *child;
+	struct mem_cgroup *parent;
 	int kmemcg_id;
 
 	if (memcg->kmem_state != KMEM_ONLINE)
@@ -3653,22 +3652,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
-	/*
-	 * Change kmemcg_id of this cgroup and all its descendants to the
-	 * parent's id, and then move all entries from this cgroup's list_lrus
-	 * to ones of the parent. After we have finished, all list_lrus
-	 * corresponding to this cgroup are guaranteed to remain empty. The
-	 * ordering is imposed by list_lru_node->lock taken by
-	 * memcg_drain_all_list_lrus().
-	 */
-	rcu_read_lock(); /* can be called from css_free w/o cgroup_mutex */
-	css_for_each_descendant_pre(css, &memcg->css) {
-		child = mem_cgroup_from_css(css);
-		BUG_ON(child->kmemcg_id != kmemcg_id);
-		child->kmemcg_id = parent->kmemcg_id;
-	}
-	rcu_read_unlock();
-
+	/* memcg_reparent_objcgs() must be called before this. */
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-- 
2.11.0

