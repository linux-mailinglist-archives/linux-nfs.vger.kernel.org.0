Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778FC4E35F3
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiCVBX4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiCVBXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:23:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3A2A257
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3476B81B03
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445B5C340EE;
        Tue, 22 Mar 2022 01:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647912145;
        bh=TpFozSPyg7PH9QSv7+9Ca1GGRZqck54LuncQ6km/yVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oP2NU2Qwcx6sa1DRHaWzC0RQjJoWHWUGf1IRWViV+j6F2hzARzFtNuMBkTuLGEtqO
         +cXT9QMOHG2tWG/uCOiESFJLNwbrRARg0U7ZfxPfqio1B5a2YFGPjW2KRlkXMBOFzC
         +FfrnB8EY083PG0D9iv4ToBajCXyxSc1GvB5JaK5dmoGaR62lWBozCHabOUfNATUge
         th2GBVNPP66vGeNWfp0fl9iDhJyBXCb//Yw7drvtxMKw8i1pKorXNY0dpa6AYIVhJ1
         e+eeC9FqmA1JVO/0s8F/MrlZTAtuuIRjsod6FmjJ0sCxrHFq6LyQzBDE+0OQERmvoB
         W+TxT9+cnYZBA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>
Subject: [PATCH v2 1/9] NFS: Fix memory allocation in rpc_malloc()
Date:   Mon, 21 Mar 2022 21:16:10 -0400
Message-Id: <20220322011618.1052288-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322011618.1052288-1-trondmy@kernel.org>
References: <20220322011618.1052288-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When in a low memory situation, we do want rpciod to kick off direct
reclaim in the case where that helps, however we don't want it looping
forever in mempool_alloc().
So first try allocating from the slab using GFP_KERNEL | __GFP_NORETRY,
and then fall back to a GFP_NOWAIT allocation from the mempool.

Ditto for rpc_alloc_task()

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/sched.h |  1 +
 net/sunrpc/sched.c           | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 56710f8056d3..1d7a3e51b795 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -262,6 +262,7 @@ void		rpc_destroy_mempool(void);
 extern struct workqueue_struct *rpciod_workqueue;
 extern struct workqueue_struct *xprtiod_workqueue;
 void		rpc_prepare_task(struct rpc_task *task);
+gfp_t		rpc_task_gfp_mask(void);
 
 static inline int rpc_wait_for_completion_task(struct rpc_task *task)
 {
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 7c8f87ebdbc0..d59a033820be 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -57,6 +57,13 @@ struct workqueue_struct *rpciod_workqueue __read_mostly;
 struct workqueue_struct *xprtiod_workqueue __read_mostly;
 EXPORT_SYMBOL_GPL(xprtiod_workqueue);
 
+gfp_t rpc_task_gfp_mask(void)
+{
+	if (current->flags & PF_WQ_WORKER)
+		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
+	return GFP_KERNEL;
+}
+
 unsigned long
 rpc_task_timeout(const struct rpc_task *task)
 {
@@ -1030,15 +1037,15 @@ int rpc_malloc(struct rpc_task *task)
 	struct rpc_rqst *rqst = task->tk_rqstp;
 	size_t size = rqst->rq_callsize + rqst->rq_rcvsize;
 	struct rpc_buffer *buf;
-	gfp_t gfp = GFP_KERNEL;
-
-	if (RPC_IS_ASYNC(task))
-		gfp = GFP_NOWAIT | __GFP_NOWARN;
+	gfp_t gfp = rpc_task_gfp_mask();
 
 	size += sizeof(struct rpc_buffer);
-	if (size <= RPC_BUFFER_MAXSIZE)
-		buf = mempool_alloc(rpc_buffer_mempool, gfp);
-	else
+	if (size <= RPC_BUFFER_MAXSIZE) {
+		buf = kmem_cache_alloc(rpc_buffer_slabp, gfp);
+		/* Reach for the mempool if dynamic allocation fails */
+		if (!buf && RPC_IS_ASYNC(task))
+			buf = mempool_alloc(rpc_buffer_mempool, GFP_NOWAIT);
+	} else
 		buf = kmalloc(size, gfp);
 
 	if (!buf)
-- 
2.35.1

