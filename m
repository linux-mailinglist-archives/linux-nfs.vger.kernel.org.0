Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6FC768C56
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGaGwG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGaGwB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:52:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8DE7D
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:51:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98AC022427;
        Mon, 31 Jul 2023 06:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGYTwMnBniBM8J+hJQvYA5X597a/aspEMqpPLwlLxCc=;
        b=pKmcRPgluvgSa6ncSFVT8NA6NtN2S0HzfySXPfV4nECtusavVqlYXut4puIalfQl6ILo4z
        w/E7xmuj42/uvvUMVIdONV/UfxRjrMT+b9NYbiN5pG00MA5NVQlrottu/mTcautUO//Eq/
        jp4uQzUiLq1CoA3bQCFbWaxlWyq90Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGYTwMnBniBM8J+hJQvYA5X597a/aspEMqpPLwlLxCc=;
        b=ihJiNAOwIdZpQqTCqSgUOX8zd8nRJGbPdrZAU1nWSr25bnQUwfjJzW7O3iyUiMbM6ULPrB
        vPOqfJSODPH22QAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B3391322C;
        Mon, 31 Jul 2023 06:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jDQcBARax2TFbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:48 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/12] SUNRPC: rename and refactor svc_get_next_xprt().
Date:   Mon, 31 Jul 2023 16:48:33 +1000
Message-Id: <20230731064839.7729-7-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731064839.7729-1-neilb@suse.de>
References: <20230731064839.7729-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_get_next_xprt() does a lot more than just get an xprt.  It also
decides if it needs to sleep, depending not only on the availability of
xprts, but also on the need to exit or handle external work
(SP_TASK_PENDING).

So rename it to svc_rqst_wait_and_dequeue_work(), don't return the xprt
(which can easily be found in rqstp->rq_xprt), and restructure to make a
clear separation between waiting and dequeueing.

All the scheduling-related code like try_to_freeze() and
kthread_should_stop() is moved into svc_rqst_wait_and_dequeue_work().

Rather than calling svc_xprt_dequeue() twice (before and after deciding
to wait), it now calls rqst_should_sleep() twice.  If the first fails,
we skip all the waiting code completely.  In the waiting code we call
again after setting the task state in case we missed a wake-up.

We now only have one call to try_to_freeze() and one call to
svc_xprt_dequeue().  We still have two calls to kthread_should_stop() -
one in rqst_should_sleep() to avoid sleeping, and one afterwards to
avoid dequeueing any work (it previously came after dequeueing which
doesn't seem right).

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 62 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 380fb3caea4c..67f2b34cb8e4 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -722,47 +722,51 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
+static void svc_rqst_wait_and_dequeue_work(struct svc_rqst *rqstp)
 {
 	struct svc_pool		*pool = rqstp->rq_pool;
+	bool slept = false;
 
 	/* rq_xprt should be clear on entry */
 	WARN_ON_ONCE(rqstp->rq_xprt);
 
-	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt) {
-		trace_svc_pool_polled(rqstp);
-		goto out_found;
+	if (rqst_should_sleep(rqstp)) {
+		set_current_state(TASK_IDLE);
+		smp_mb__before_atomic();
+		clear_bit(SP_CONGESTED, &pool->sp_flags);
+		clear_bit(RQ_BUSY, &rqstp->rq_flags);
+		smp_mb__after_atomic();
+
+		/* Need to test again after setting task state */
+		if (likely(rqst_should_sleep(rqstp))) {
+			schedule();
+			slept = true;
+		} else {
+			__set_current_state(TASK_RUNNING);
+			cond_resched();
+		}
+		set_bit(RQ_BUSY, &rqstp->rq_flags);
+		smp_mb__after_atomic();
 	}
-
-	set_current_state(TASK_IDLE);
-	smp_mb__before_atomic();
-	clear_bit(SP_CONGESTED, &pool->sp_flags);
-	clear_bit(RQ_BUSY, &rqstp->rq_flags);
-	smp_mb__after_atomic();
-
-	if (likely(rqst_should_sleep(rqstp)))
-		schedule();
-	else
-		__set_current_state(TASK_RUNNING);
-
 	try_to_freeze();
 
-	set_bit(RQ_BUSY, &rqstp->rq_flags);
-	smp_mb__after_atomic();
+	if (kthread_should_stop())
+		return;
+
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
 	if (rqstp->rq_xprt) {
-		trace_svc_pool_awoken(rqstp);
+		if (slept)
+			trace_svc_pool_awoken(rqstp);
+		else
+			trace_svc_pool_polled(rqstp);
 		goto out_found;
 	}
 
-	if (kthread_should_stop())
-		return NULL;
-	percpu_counter_inc(&pool->sp_threads_no_work);
-	return NULL;
+	if (slept)
+		percpu_counter_inc(&pool->sp_threads_no_work);
+	return;
 out_found:
-	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 	/* Normally we will wait up to 5 seconds for any required
 	 * cache information to be provided.
 	 */
@@ -770,7 +774,6 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
 		rqstp->rq_chandle.thread_wait = 5*HZ;
 	else
 		rqstp->rq_chandle.thread_wait = 1*HZ;
-	return rqstp->rq_xprt;
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
@@ -854,12 +857,9 @@ void svc_recv(struct svc_rqst *rqstp)
 	if (!svc_alloc_arg(rqstp))
 		goto out;
 
-	try_to_freeze();
-	cond_resched();
-	if (kthread_should_stop())
-		goto out;
+	svc_rqst_wait_and_dequeue_work(rqstp);
 
-	xprt = svc_get_next_xprt(rqstp);
+	xprt = rqstp->rq_xprt;
 	if (!xprt)
 		goto out;
 
-- 
2.40.1

