Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5074DB57
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjGJQmd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGJQma (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 12:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0213D
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 09:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B21356112A
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 16:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09CBC433C7;
        Mon, 10 Jul 2023 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689007348;
        bh=0UTojvHk3XK1psFQA6O+HJqio8NK7M/LxGZkI05qJUI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fyMH1Ad6GzWeAYEV8qki5VVo9qVDrpazHjO1Yev4KPhzao2qrMemW+po2HlqQS91O
         kfs0wCCBM1F0W6cTjhY/m60fI8l0BcYh6AxcE3m1KlRoMB60f8s1C72dZOsYK1IzXP
         R6YCezuElY5gYjhUtlNt6Gps9VrxoLb6QoBBKBuKz9dvtPvkdm04oFcra9Yn/9vYGZ
         kkDr8enaLyp2/rz2fTD2VssZr1tl0AE6k/jzb/2AxU3Ya/mWsz6vnabaDrLNKYhlnE
         noMXb+b5tKjs95XltGplGH/U+X03pvXsQ9np7cpBBLn2k1ijTxRRaURmHFeNcENN+n
         iSfg65cMnGVEQ==
Subject: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but found
 no work to do
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 10 Jul 2023 12:42:26 -0400
Message-ID: <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>
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

Measure a source of thread scheduling inefficiency -- count threads
that were awoken but found that the transport queue had already been
emptied.

An empty transport queue is possible when threads that run between
the wake_up_process() call and the woken thread returning from the
scheduler have pulled all remaining work off the transport queue
using the first svc_xprt_dequeue() in svc_get_next_xprt().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    1 +
 net/sunrpc/svc.c           |    2 ++
 net/sunrpc/svc_xprt.c      |    7 ++++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 74ea13270679..9dd3b16cc4c2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -43,6 +43,7 @@ struct svc_pool {
 	struct percpu_counter	sp_threads_woken;
 	struct percpu_counter	sp_threads_timedout;
 	struct percpu_counter	sp_threads_starved;
+	struct percpu_counter	sp_threads_no_work;
 
 #define	SP_TASK_PENDING		(0)		/* still work to do even if no
 						 * xprt is queued. */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 88b7b5fb6d75..b7a02309ecb1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -518,6 +518,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_starved, 0, GFP_KERNEL);
+		percpu_counter_init(&pool->sp_threads_no_work, 0, GFP_KERNEL);
 	}
 
 	return serv;
@@ -595,6 +596,7 @@ svc_destroy(struct kref *ref)
 		percpu_counter_destroy(&pool->sp_threads_woken);
 		percpu_counter_destroy(&pool->sp_threads_timedout);
 		percpu_counter_destroy(&pool->sp_threads_starved);
+		percpu_counter_destroy(&pool->sp_threads_no_work);
 	}
 	kfree(serv->sv_pools);
 	kfree(serv);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ecbccf0d89b9..6c2a702aa469 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -776,9 +776,9 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 
 	if (!time_left)
 		percpu_counter_inc(&pool->sp_threads_timedout);
-
 	if (signalled() || kthread_should_stop())
 		return ERR_PTR(-EINTR);
+	percpu_counter_inc(&pool->sp_threads_no_work);
 	return ERR_PTR(-EAGAIN);
 out_found:
 	/* Normally we will wait up to 5 seconds for any required
@@ -1445,13 +1445,14 @@ static int svc_pool_stats_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
-	seq_printf(m, "%u %llu %llu %llu %llu %llu\n",
+	seq_printf(m, "%u %llu %llu %llu %llu %llu %llu\n",
 		pool->sp_id,
 		percpu_counter_sum_positive(&pool->sp_messages_arrived),
 		percpu_counter_sum_positive(&pool->sp_sockets_queued),
 		percpu_counter_sum_positive(&pool->sp_threads_woken),
 		percpu_counter_sum_positive(&pool->sp_threads_timedout),
-		percpu_counter_sum_positive(&pool->sp_threads_starved));
+		percpu_counter_sum_positive(&pool->sp_threads_starved),
+		percpu_counter_sum_positive(&pool->sp_threads_no_work));
 
 	return 0;
 }


