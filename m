Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E383D74DB56
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGJQm0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjGJQmX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 12:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8712A
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 09:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D386112B
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 16:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27298C433C8;
        Mon, 10 Jul 2023 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689007341;
        bh=6l5Jt33f9RO3uwq4Kya+V7DLcbvhb749z5nxtKsxQEc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TbMqvdXeRaFAGGN0tFIU+wZ3rlEFGH5JWr1/6EDHcwKz7SFE3pbN+g/cNTaPzHem8
         zVc/r0tNrk6sJdakV/Jypji7s7n0wI7d1Ovu9oIwsOngy1+X9XCp0UXh+utWYgl8EL
         soZ4sOaarpgFbzs1PXbLQzcu10AlX4dKvbMDVFGUxihp7awy6V+P7TVD8clvpVw4iG
         IWqttMqGMMMZ3Mc1DPggqx3/T5iJ0GncspzpKSpfbreputI9GrvtmsV90H0tkB3JUg
         pjMzPNJWWQKFZd2uQaS/zRFiD6alg7nltne+PszskTSIPG3lRI4iYZDy4Eh57o/jKj
         KV/oPOgoKMB4Q==
Subject: [PATCH v3 4/9] SUNRPC: Count ingress RPC messages per svc_pool
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 10 Jul 2023 12:42:20 -0400
Message-ID: <168900734016.7514.3760096764861612619.stgit@manet.1015granger.net>
In-Reply-To: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

svc_xprt_enqueue() can be costly, since it involves selecting and
waking up a process.

More than one enqueue is done per incoming RPC. For example,
svc_data_ready() enqueues, and so does svc_xprt_receive(). Also, if
an RPC message requires more than one call to ->recvfrom() to
receive it fully, each one of those calls does an enqueue.

To get a sense of the average number of transport enqueue operations
needed to process an incoming RPC message, re-use the "packets" pool
stat. Track the number of complete RPC messages processed by each
thread pool.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    1 +
 net/sunrpc/svc.c           |    2 ++
 net/sunrpc/svc_xprt.c      |    3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index fbfe6ea737c8..74ea13270679 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -38,6 +38,7 @@ struct svc_pool {
 	struct list_head	sp_all_threads;	/* all server threads */
 
 	/* statistics on pool operation */
+	struct percpu_counter	sp_messages_arrived;
 	struct percpu_counter	sp_sockets_queued;
 	struct percpu_counter	sp_threads_woken;
 	struct percpu_counter	sp_threads_timedout;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b79b8b41905d..88b7b5fb6d75 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -513,6 +513,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		INIT_LIST_HEAD(&pool->sp_all_threads);
 		spin_lock_init(&pool->sp_lock);
 
+		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
@@ -589,6 +590,7 @@ svc_destroy(struct kref *ref)
 	for (i = 0; i < serv->sv_nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 
+		percpu_counter_destroy(&pool->sp_messages_arrived);
 		percpu_counter_destroy(&pool->sp_sockets_queued);
 		percpu_counter_destroy(&pool->sp_threads_woken);
 		percpu_counter_destroy(&pool->sp_threads_timedout);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 7ee095d03996..ecbccf0d89b9 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -897,6 +897,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 
 	if (serv->sv_stats)
 		serv->sv_stats->netcnt++;
+	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
 	rqstp->rq_stime = ktime_get();
 	return len;
 out_release:
@@ -1446,7 +1447,7 @@ static int svc_pool_stats_show(struct seq_file *m, void *p)
 
 	seq_printf(m, "%u %llu %llu %llu %llu %llu\n",
 		pool->sp_id,
-		percpu_counter_sum_positive(&pool->sp_sockets_queued),
+		percpu_counter_sum_positive(&pool->sp_messages_arrived),
 		percpu_counter_sum_positive(&pool->sp_sockets_queued),
 		percpu_counter_sum_positive(&pool->sp_threads_woken),
 		percpu_counter_sum_positive(&pool->sp_threads_timedout),


