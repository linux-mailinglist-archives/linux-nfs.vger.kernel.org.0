Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783534E3641
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiCVB4F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiCVB4C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:56:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12CD44A02
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 551C0B81B2D
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFC3C340F2;
        Tue, 22 Mar 2022 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647914074;
        bh=DrZNvoTWRqfjg6xxjhNfSiAQdezk+5CXJVWZ5lfbe1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9FGcM2h8saccDKPgPJuGcb+BTl5k0PjuhPEt0a9+s0chdhlmlBYiGLlIZnZ9Ga8y
         8z570cfR4rljp45pMGbIY0qFYSBsUp5MCwdUxvrrU+bd/REt97wtgHCE6z+qUxbLnW
         ZXZ5HzEiOPw+s6rOCBrSdibJFeTlO2k72DZd1GXKGTiY4V3kty9nU/LHB8aCTmJWBZ
         9C9QxehdnWggq/UyMBPi4Ca/88SyxmN3xO1+one1uX1EIwXAoky/UtUhbRPpf8fJzw
         qzRmq2O4mgWR61no/cFS0SpK3p+06Op1OFQhCovvxa4QsGRPsm43DXpN8NKZnXnv0q
         faoznvIjLbZxQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH v2 2/9] NFS: Fix memory allocation in rpc_alloc_task()
Date:   Mon, 21 Mar 2022 21:47:39 -0400
Message-Id: <20220322014746.1052984-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322014746.1052984-2-trondmy@kernel.org>
References: <20220322014746.1052984-1-trondmy@kernel.org>
 <20220322014746.1052984-2-trondmy@kernel.org>
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

