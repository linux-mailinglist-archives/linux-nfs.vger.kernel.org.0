Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B0175F255
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGXKMi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 06:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjGXKMT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 06:12:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253547A99
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 03:05:03 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-576db978e8aso5190227b3.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193083; x=1690797883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdB9rRMLZCcd9e2nqCLYXDwhc2GYqBzgLTOCktFYsxc=;
        b=UMQMVCDljnPQtNX3yBU/OqDjs8trWjYVYejWIDZCorg+Nhq9WOQA6WUd5lRUHtb6T6
         yVke1f//TwSzO6gWfQl3hc1K+22S/m4wWjyMhPpqcKI7y6x8Q6Cu6fvWc15iv1lx2x0d
         N+xEPU6/ciji3E6JPYlUHb8sj+xJftO2jreCpnxm+oMvYS0A0OMlo81YvnlA7nw5DslS
         wcNMQq/C/N55lcxwsdfugaN4jUaw4jddHAim56i3/3gFGWbXMsDjl8GqAht5oYwrdWdD
         Xk1g9Z6gxsjYMZH1caJfne6OREtJzDqehvGtLKPwJDWnsOfI3yVWxTkoY7fJvFO+UfPo
         UPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193083; x=1690797883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdB9rRMLZCcd9e2nqCLYXDwhc2GYqBzgLTOCktFYsxc=;
        b=Gqg9F+t0AQ33TThatNQdc6rixF3pbJ4ntAPXqeA5+2aLIUcfESXsv+1cuCiinT7fHX
         dNIBdejh+3zlUZ1atdwgSgq4sjE9qiYMK+B4X+AwO57FRz1uLCkl/khoXNl6q5BpixdR
         w1kuBViUM9kX+kF3tAVo5POhtQhlI8NH1Cg8CfTzlbmO/W+9982NGPNzhl1/MBqopQ5D
         bjUgadeoBerHLMzkAW3KVVcjiRadUZSTmrc02r+x/+0I100nSmabXmFUyyn9dgaOOqWt
         vzgsKVUTUP37mObBQF0wgc2iltJGbrcO3Vf+eb2d2Qxi+wXKCsULt8lz+AtStILaLMy8
         XRTg==
X-Gm-Message-State: ABy/qLZ+BG6zz0G7A1Sroc1eFmQ82uvb0H7+fEMPG/eaMKj2FUUmColN
        YOJvclF5MoMuLZDKVLxM/AnAIHqnF1fJb9qdZSo=
X-Google-Smtp-Source: APBJJlGv61W8KGqFtJwXjT0bM91VjHnubPgHDdaymusYtIYliDl3QXXildbsEKZFPobYebqub0cGDA==
X-Received: by 2002:a17:902:f681:b0:1b8:17e8:5472 with SMTP id l1-20020a170902f68100b001b817e85472mr12096259plg.1.1690192338295;
        Mon, 24 Jul 2023 02:52:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:52:17 -0700 (PDT)
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
Subject: [PATCH v2 36/47] xfs: dynamically allocate the xfs-buf shrinker
Date:   Mon, 24 Jul 2023 17:43:43 +0800
Message-Id: <20230724094354.90817-37-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the xfs-buf shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct xfs_buftarg.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/xfs/xfs_buf.c | 25 ++++++++++++++-----------
 fs/xfs/xfs_buf.h |  2 +-
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 15d1e5a7c2d3..19a0bf6ce115 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1906,8 +1906,7 @@ xfs_buftarg_shrink_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_buftarg	*btp = container_of(shrink,
-					struct xfs_buftarg, bt_shrinker);
+	struct xfs_buftarg	*btp = shrink->private_data;
 	LIST_HEAD(dispose);
 	unsigned long		freed;
 
@@ -1929,8 +1928,7 @@ xfs_buftarg_shrink_count(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_buftarg	*btp = container_of(shrink,
-					struct xfs_buftarg, bt_shrinker);
+	struct xfs_buftarg	*btp = shrink->private_data;
 	return list_lru_shrink_count(&btp->bt_lru, sc);
 }
 
@@ -1938,7 +1936,7 @@ void
 xfs_free_buftarg(
 	struct xfs_buftarg	*btp)
 {
-	unregister_shrinker(&btp->bt_shrinker);
+	shrinker_unregister(btp->bt_shrinker);
 	ASSERT(percpu_counter_sum(&btp->bt_io_count) == 0);
 	percpu_counter_destroy(&btp->bt_io_count);
 	list_lru_destroy(&btp->bt_lru);
@@ -2021,13 +2019,18 @@ xfs_alloc_buftarg(
 	if (percpu_counter_init(&btp->bt_io_count, 0, GFP_KERNEL))
 		goto error_lru;
 
-	btp->bt_shrinker.count_objects = xfs_buftarg_shrink_count;
-	btp->bt_shrinker.scan_objects = xfs_buftarg_shrink_scan;
-	btp->bt_shrinker.seeks = DEFAULT_SEEKS;
-	btp->bt_shrinker.flags = SHRINKER_NUMA_AWARE;
-	if (register_shrinker(&btp->bt_shrinker, "xfs-buf:%s",
-			      mp->m_super->s_id))
+	btp->bt_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "xfs-buf:%s",
+					  mp->m_super->s_id);
+	if (!btp->bt_shrinker)
 		goto error_pcpu;
+
+	btp->bt_shrinker->count_objects = xfs_buftarg_shrink_count;
+	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
+	btp->bt_shrinker->seeks = DEFAULT_SEEKS;
+	btp->bt_shrinker->private_data = btp;
+
+	shrinker_register(btp->bt_shrinker);
+
 	return btp;
 
 error_pcpu:
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 549c60942208..4e6969a675f7 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -102,7 +102,7 @@ typedef struct xfs_buftarg {
 	size_t			bt_logical_sectormask;
 
 	/* LRU control structures */
-	struct shrinker		bt_shrinker;
+	struct shrinker		*bt_shrinker;
 	struct list_lru		bt_lru;
 
 	struct percpu_counter	bt_io_count;
-- 
2.30.2

