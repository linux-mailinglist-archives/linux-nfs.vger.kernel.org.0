Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C92746656
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 02:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGDAH7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDAH7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 20:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFFF189
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 17:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C6C6101C
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 00:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF11CC433C7;
        Tue,  4 Jul 2023 00:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688429277;
        bh=Pd5LJz7RnhNldHfozSUpV8hFuK5ZHPY0lcE/FPM6KwU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Cr5RlX82MJv24GfKUU4NjL0fCPlTKdByPRpbD/dgHa5m9WwIde+Axb3ochDD3CLqZ
         Ph7fqftp9NKL5eyzzmbgw+YpTR07wzlkMUSq1hDcEQHdR0Cyvp45JZZ7yojuFE5l8r
         MGRelWobKgASB/oP96eM3TxRrfILV2/pYRRzQ6SUzSFWcF+wK0zWdNEjkmOMCrzJa+
         6AferQOoAMQzkV8d2wUYSWLYSdeYrGFZEM3O/oj9yZIYBFz3d1QkFeWB3JlMnV95rv
         Sv3jdPU89J/dc9p5VnKSSHn0QOJshnWxm7aXRnxtNesGPNBxPW65pOm3FECW8plfHr
         Wc7hFUwkTdfTA==
Subject: [PATCH v2 4/9] SUNRPC: Count ingress RPC messages per svc_pool
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 03 Jul 2023 20:07:55 -0400
Message-ID: <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
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
index 04151e22ec44..ccc7ff3142dd 100644
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


