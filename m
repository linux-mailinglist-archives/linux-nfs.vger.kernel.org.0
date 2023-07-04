Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C66374665A
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 02:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGDAIT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 20:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDAIS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 20:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC618C
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 17:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2186108B
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 00:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92349C433CA;
        Tue,  4 Jul 2023 00:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688429297;
        bh=zm+oq/ewIClG2atqKpuw+/NWExTCCv7xUTwq6hZ6ZMM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OErcOVWqOqiwM6WW/MKxqPi5kn5bGcorbWnQFNJpfWiUK+W6k93zYkExkq3d48OJS
         esxmU9Y3B3NhKttmJv1K54+JzMKZOgsS4QGfqW+Q14qcyfxLOH2ou6GwSOM2dkLQRn
         VHLfi83zC/mLcwzp3T/u3qu4V7/Xtes7mPg44VeDAkSoK44P2eEJ4xI/AbCJ/DOXsY
         JAYUPyiQkO198HrYuXn71FeG6HMfq3yjcK4t1y/b5cQzzMHWxQ1GuPgawChxx8My/z
         YtM60+1JIs7b1XW3TvB0xwhm2awtMR2A9Gm2smfmx4blQijEuqNciaUfxC7uNhWO/u
         GIkaMFaxjKNKw==
Subject: [PATCH v2 7/9] SUNRPC: Don't disable BH's when taking sp_lock
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 03 Jul 2023 20:08:15 -0400
Message-ID: <168842929557.139194.4420161035549339648.stgit@manet.1015granger.net>
In-Reply-To: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
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

Consumers of sp_lock now all run in process context. We can avoid
the overhead of disabling bottom halves when taking this lock.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ecbccf0d89b9..8ced7591ce07 100644
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
@@ -1116,15 +1116,15 @@ static struct svc_xprt *svc_dequeue_net(struct svc_serv *serv, struct net *net)
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


