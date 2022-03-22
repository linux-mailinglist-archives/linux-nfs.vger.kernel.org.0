Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37F64E35EE
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiCVBX4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiCVBXz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:23:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98E71D0D4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73135B81B01
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA15C340F0;
        Tue, 22 Mar 2022 01:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647912146;
        bh=DrZNvoTWRqfjg6xxjhNfSiAQdezk+5CXJVWZ5lfbe1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2aggUlHIhfgQsKsqwFhfvqqkWLvsaBBGwVqAlTil+IsTGZlqBlLVO3Wt62YE2A+D
         sKjHMcerIBASOdIEa7oZKfzNreczk+sGDH7DEYn5Tdl48z3E5p49fLvBiMLGb92Qpc
         54BArMtBVAaAuIGDOiRbMoqSliMgmsCeuNPg3NU5Pf/ZY6Ipx/7rCYoFRws05g1dg3
         0g907fjQ0MXcj+XkhWHtqpVm+LVuVkcLZA8CwgBzxiFYVdnrVIhbDX5fMtZrTin0Rv
         lA4cPXq6Wsz+L/NUDwciujoDAXH5GihOv2hEXF9/6qHFX0HDPl2KebVggqvybAItFM
         13pWZQ8RLYGtA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>
Subject: [PATCH v2 2/9] NFS: Fix memory allocation in rpc_alloc_task()
Date:   Mon, 21 Mar 2022 21:16:11 -0400
Message-Id: <20220322011618.1052288-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322011618.1052288-2-trondmy@kernel.org>
References: <20220322011618.1052288-1-trondmy@kernel.org>
 <20220322011618.1052288-2-trondmy@kernel.org>
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

As for rpc_malloc(), we first try allocating from the slab, then fall
back to a non-waiting allocation from the mempool.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sched.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index d59a033820be..b258b87a3ec2 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1108,10 +1108,14 @@ static void rpc_init_task(struct rpc_task *task, const struct rpc_task_setup *ta
 	rpc_init_task_statistics(task);
 }
 
-static struct rpc_task *
-rpc_alloc_task(void)
+static struct rpc_task *rpc_alloc_task(void)
 {
-	return (struct rpc_task *)mempool_alloc(rpc_task_mempool, GFP_KERNEL);
+	struct rpc_task *task;
+
+	task = kmem_cache_alloc(rpc_task_slabp, rpc_task_gfp_mask());
+	if (task)
+		return task;
+	return mempool_alloc(rpc_task_mempool, GFP_NOWAIT);
 }
 
 /*
-- 
2.35.1

