Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1433275F10C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjGXJyh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjGXJyA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 05:54:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86804C29
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 02:50:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2659b1113c2so535954a91.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192158; x=1690796958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVIFplaZ76DyAQXZ2ZJxr5973JfmLiF6XogxT7JwM8U=;
        b=g/oklpIKNGh+0wS+n9EMTX7klc8jS620o9fzwPGIqpCBu8mbiUf3GVaJFWI9cq4kyt
         IcHzy4DXpXrqHW9rKUwTo/qnz3ci8+g869gbq1SHjojy2v6sITGFJ6jCBwntHLmpVCFL
         BxlLRGgDhGT5pteYElzIqAQYNjUlDrhrzHvMMVeuk6mD5iB/3/39xp+zm1XNO6yWMu+0
         nnfy+u33I9S+Zpuf8vfrp2IBvebCHcozlkxEMdcu6inA/NJIaH4grbbwn36wCiHGJxl9
         XjhaC2ZZMe6xC4wfMSYebjh3I/a6dIvPCN3tI9BZtHhq23lIbjcutVI19WQEcGj42Ona
         01KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192158; x=1690796958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVIFplaZ76DyAQXZ2ZJxr5973JfmLiF6XogxT7JwM8U=;
        b=gKLqAi7A5P76blkuwXTmBEY1SmIcQ4DfsPAGc3Ww0oRKB0koW/TqzqVJjyKUudmbbG
         //Z1jC70Q1sWfDQC+zTl2IT/r5AhYJ7Gidq/x7Sypc5n9dLSNeFFtR7utJlrjkeniFfH
         f2I7brQePyZzhbni3kTFG75/mRJkeUmEjbGxyyNio3mTqErZdnk5QmsPD1KyREo9E03W
         0zp7x6RNcGelJaXL0tpteMywJzhfhMIQexn8rbuDWwg72we2wqqpdsnnjRdqEJSADpz2
         q9zSvYoNL4MERFzTvxm9JluFNd5AxiyYq1t2OZut6B4rtlI8UI5X4WPOIGg2ICC2Tudz
         pmuA==
X-Gm-Message-State: ABy/qLbZT/J9l46QIJbwrA7M9Hgj/s0mieqjroJXFbx1s6m5CXLW++w0
        cZow71BrFk0JDP90W5JtwAVhVQ==
X-Google-Smtp-Source: APBJJlFR9Ju5Vfb3AHUJ7jWuLYrfbcu6xuKCy8KktQCx0EpABVN8oHS8r350MQ/TdmOpiBIOkTrovA==
X-Received: by 2002:a17:902:d484:b0:1b8:a27d:f591 with SMTP id c4-20020a170902d48400b001b8a27df591mr12261184plg.5.1690192158548;
        Mon, 24 Jul 2023 02:49:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:49:18 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 21/47] mm: workingset: dynamically allocate the mm-shadow shrinker
Date:   Mon, 24 Jul 2023 17:43:28 +0800
Message-Id: <20230724094354.90817-22-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use new APIs to dynamically allocate the mm-shadow shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/workingset.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 4686ae363000..4bc85f739b13 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -762,12 +762,7 @@ static unsigned long scan_shadow_nodes(struct shrinker *shrinker,
 					NULL);
 }
 
-static struct shrinker workingset_shadow_shrinker = {
-	.count_objects = count_shadow_nodes,
-	.scan_objects = scan_shadow_nodes,
-	.seeks = 0, /* ->count reports only fully expendable nodes */
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
-};
+static struct shrinker *workingset_shadow_shrinker;
 
 /*
  * Our list_lru->lock is IRQ-safe as it nests inside the IRQ-safe
@@ -779,7 +774,7 @@ static int __init workingset_init(void)
 {
 	unsigned int timestamp_bits;
 	unsigned int max_order;
-	int ret;
+	int ret = -ENOMEM;
 
 	BUILD_BUG_ON(BITS_PER_LONG < EVICTION_SHIFT);
 	/*
@@ -796,17 +791,24 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
-	if (ret)
+	workingset_shadow_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
+						    SHRINKER_MEMCG_AWARE,
+						    "mm-shadow");
+	if (!workingset_shadow_shrinker)
 		goto err;
+
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
-			      &workingset_shadow_shrinker);
+			      workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
-	register_shrinker_prepared(&workingset_shadow_shrinker);
+
+	workingset_shadow_shrinker->count_objects = count_shadow_nodes;
+	workingset_shadow_shrinker->scan_objects = scan_shadow_nodes;
+
+	shrinker_register(workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	free_prealloced_shrinker(&workingset_shadow_shrinker);
+	shrinker_free_non_registered(workingset_shadow_shrinker);
 err:
 	return ret;
 }
-- 
2.30.2

