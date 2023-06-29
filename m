Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D342742C09
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 20:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjF2Sn0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjF2SnY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 14:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A42693
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 11:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76DB3615E7
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76951C433C8;
        Thu, 29 Jun 2023 18:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688064197;
        bh=vtiAWFYHkHtGebTnExQNuYeQk9SYGLwLglMdhcaK9ZM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aQFdffpIsoCrOg5znro2aPU30UMcRoTrYLD4loS3+uKHQEkbO+MqpjQICbHmmEFqv
         2njYhoev6GoHLV/+2f2i9g2KS2VfPBeCQw45PWtvJzfjb3UVE+/GSp+bVdLWVg95LL
         6zeHNuvgtCAbE3hF9z5B9rmOBGtnja5wIQBBGJ8Kdc1czI/GhE9WF8/x/LAPtdyx3E
         E8SFpZrQU1qAbwFNlSZtADWKSwbErKxCfrJ/GRGO7uxPGzIaWlxdRqe3Ft3kgLKZvN
         CRAOlhG6HM5JFSwV13HEN7qDNjihhjD3cPa9OrHAU5jC8k5vJ93OqRjQHjFlWF894K
         alXlnpfcAWNBw==
Subject: [PATCH RFC 8/8] SUNRPC: Don't disable BH's when taking sp_lock
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Thu, 29 Jun 2023 14:43:16 -0400
Message-ID: <168806419648.1034990.7540913098847778540.stgit@morisot.1015granger.net>
In-Reply-To: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
References: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Consumers of sp_lock now all run in process context.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index e22f1432aabb..6a56cd202148 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -472,9 +472,9 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	pool = svc_pool_for_cpu(xprt->xpt_server);
 
 	percpu_counter_inc(&pool->sp_sockets_queued);
-	spin_lock_bh(&pool->sp_lock);
+	spin_lock(&pool->sp_lock);
 	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
-	spin_unlock_bh(&pool->sp_lock);
+	spin_unlock(&pool->sp_lock);
 
 	rqstp = svc_pool_wake_idle_thread(xprt->xpt_server, pool);
 	if (!rqstp) {
@@ -496,14 +496,14 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
 	if (list_empty(&pool->sp_sockets))
 		goto out;
 
-	spin_lock_bh(&pool->sp_lock);
+	spin_lock(&pool->sp_lock);
 	if (likely(!list_empty(&pool->sp_sockets))) {
 		xprt = list_first_entry(&pool->sp_sockets,
 					struct svc_xprt, xpt_ready);
 		list_del_init(&xprt->xpt_ready);
 		svc_xprt_get(xprt);
 	}
-	spin_unlock_bh(&pool->sp_lock);
+	spin_unlock(&pool->sp_lock);
 out:
 	return xprt;
 }
@@ -1129,15 +1129,15 @@ static struct svc_xprt *svc_dequeue_net(struct svc_serv *serv, struct net *net)
 	for (i = 0; i < serv->sv_nrpools; i++) {
 		pool = &serv->sv_pools[i];
 
-		spin_lock_bh(&pool->sp_lock);
+		spin_lock(&pool->sp_lock);
 		list_for_each_entry_safe(xprt, tmp, &pool->sp_sockets, xpt_ready) {
 			if (xprt->xpt_net != net)
 				continue;
 			list_del_init(&xprt->xpt_ready);
-			spin_unlock_bh(&pool->sp_lock);
+			spin_unlock(&pool->sp_lock);
 			return xprt;
 		}
-		spin_unlock_bh(&pool->sp_lock);
+		spin_unlock(&pool->sp_lock);
 	}
 	return NULL;
 }


