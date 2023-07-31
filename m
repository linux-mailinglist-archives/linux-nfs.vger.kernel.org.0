Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D28B768C59
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGaGwQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGaGwF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:52:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB7110DD
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:52:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0ED531F460;
        Mon, 31 Jul 2023 06:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AEIwizLgjmYYBuYyjus/ttgE+eZRibUsijD5P7lW1k=;
        b=IOpJXcNnLbSD8IY5jv+bOUCVzhzHld37pgyDi6kN7Kx6BAu8EXUANl7ZIakxB4WkpAY3KD
        EqS0J+N6di3JtzNDrd006bPeUSLljg82DSvWYKi2wJKzv4JR9OZpkxVW/re+S+gwBW2r0P
        bPKU6/Rq5MSAf6vVtrcVBkHB3dkQwE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AEIwizLgjmYYBuYyjus/ttgE+eZRibUsijD5P7lW1k=;
        b=SVDVkFI2ETfKQ4fgeB2XPQ8iR2SjVxaxqTZGZhqjG/tpynmw52pl80R9bgzDm4waqGg4k7
        0wNO4ZX7UoZa3aDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C17F61322C;
        Mon, 31 Jul 2023 06:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id irEkHA9ax2ThbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:59 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/12] SUNRPC: move task-dequeueing code into svc_recv()
Date:   Mon, 31 Jul 2023 16:48:35 +1000
Message-Id: <20230731064839.7729-9-neilb@suse.de>
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

svc_recv() has become rather small, and svc_rqst_wait_and_dequeue_work()
performs two different tasks.

So move the "dequeue" part out of svc_rqst_wait_and_dequeue_work()
into svc_recv().  This balances code between the two.

svc_rqst_wait_and_dequeue_work() is now svc_rqst_wait_for_work() and
returns bool if it actually waited.  This is used to guide tracing and
some statistics gathering.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 67 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 604c486c8576..45a76313b7e1 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -722,14 +722,11 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static void svc_rqst_wait_and_dequeue_work(struct svc_rqst *rqstp)
+static bool svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 {
-	struct svc_pool		*pool = rqstp->rq_pool;
+	struct svc_pool *pool = rqstp->rq_pool;
 	bool slept = false;
 
-	/* rq_xprt should be clear on entry */
-	WARN_ON_ONCE(rqstp->rq_xprt);
-
 	if (rqst_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE);
 		smp_mb__before_atomic();
@@ -749,31 +746,7 @@ static void svc_rqst_wait_and_dequeue_work(struct svc_rqst *rqstp)
 		smp_mb__after_atomic();
 	}
 	try_to_freeze();
-
-	if (kthread_should_stop())
-		return;
-
-	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
-	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt) {
-		if (slept)
-			trace_svc_pool_awoken(rqstp);
-		else
-			trace_svc_pool_polled(rqstp);
-		goto out_found;
-	}
-
-	if (slept)
-		percpu_counter_inc(&pool->sp_threads_no_work);
-	return;
-out_found:
-	/* Normally we will wait up to 5 seconds for any required
-	 * cache information to be provided.
-	 */
-	if (!test_bit(SP_CONGESTED, &pool->sp_flags))
-		rqstp->rq_chandle.thread_wait = 5*HZ;
-	else
-		rqstp->rq_chandle.thread_wait = 1*HZ;
+	return slept;
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
@@ -865,17 +838,41 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
  */
 void svc_recv(struct svc_rqst *rqstp)
 {
-	struct svc_xprt		*xprt = NULL;
+	struct svc_pool *pool = rqstp->rq_pool;
+	bool slept;
 
 	if (!svc_alloc_arg(rqstp))
 		return;
 
-	svc_rqst_wait_and_dequeue_work(rqstp);
+	slept = svc_rqst_wait_for_work(rqstp);
 
-	xprt = rqstp->rq_xprt;
-	if (xprt)
+	if (kthread_should_stop())
+		return;
+
+	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
+
+	rqstp->rq_xprt = svc_xprt_dequeue(pool);
+	if (rqstp->rq_xprt) {
+		struct svc_xprt *xprt = rqstp->rq_xprt;
+
+		if (slept)
+			trace_svc_pool_awoken(rqstp);
+		else
+			trace_svc_pool_polled(rqstp);
+
+		/* Normally we will wait up to 5 seconds for any required
+		 * cache information to be provided.
+		 */
+		if (test_bit(SP_CONGESTED, &pool->sp_flags))
+			rqstp->rq_chandle.thread_wait = 5 * HZ;
+		else
+			rqstp->rq_chandle.thread_wait = 1 * HZ;
 		svc_handle_xprt(rqstp, xprt);
-out:
+		return;
+	}
+
+	if (slept)
+		percpu_counter_inc(&pool->sp_threads_no_work);
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
-- 
2.40.1

