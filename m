Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050E476C6F8
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 09:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjHBHfp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 03:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjHBHfm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 03:35:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BE2698
        for <linux-nfs@vger.kernel.org>; Wed,  2 Aug 2023 00:35:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A03EB21B17;
        Wed,  2 Aug 2023 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690961708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbgC7MNA075/4cyx2D7jAN28qG0n24uefNfSrAz2ICs=;
        b=16pOA3H1f9WsiMZFjFWr4hvnX6u0PehHxhYCCmWWhOVZYlPs8rQu01JEvqFqMOSBl1jduV
        9FiBvAKACSGxZJtQQkx0YRTr2p41FsVDC8P/riDpJ+xVsP0/p0Rl8PPHgsFNxTAMArZv1o
        0g2kJwdMCOP6v7FjBwXNOg4xrnIaMcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690961708;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbgC7MNA075/4cyx2D7jAN28qG0n24uefNfSrAz2ICs=;
        b=QFYxniN2n0YgG78ftn9PHll8XhLhkMrkYT+04FjuCGPhUFeU/ZJ30NLNzddqg9gJOG33WP
        81iCMiDMO2ijmVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63C9E13909;
        Wed,  2 Aug 2023 07:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UpMkBisHymT8IwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 02 Aug 2023 07:35:07 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/6] SUNRPC: rename and refactor svc_get_next_xprt()
Date:   Wed,  2 Aug 2023 17:34:39 +1000
Message-Id: <20230802073443.17965-3-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802073443.17965-1-neilb@suse.de>
References: <20230802073443.17965-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_get_next_xprt() does a lot more than just get an xprt.  It also
decides if it needs to sleep, depending not only on the availability of
xprts but also on the need to exit or handle external work.

So rename it to svc_rqst_wait_for_work() and only do the testing and
waiting.  Move all the waiting-related code out of svc_recv() into the
new svc_rqst_wait_for_work().

Move the dequeueing code out of svc_get_next_xprt() into svc_recv().

Previously svc_xprt_dequeue() would be called twice, once before waiting
and possibly once after.  Now instead rqst_should_sleep() is called
twice.  Once to decide if waiting is needed, and once to check against
after setting the task state do see if we might have missed a wakeup.

signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 91 ++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 60759647fee4..f1d64ded89fb 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -722,51 +722,33 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
+static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 {
-	struct svc_pool		*pool = rqstp->rq_pool;
-
-	/* rq_xprt should be clear on entry */
-	WARN_ON_ONCE(rqstp->rq_xprt);
+	struct svc_pool *pool = rqstp->rq_pool;
 
-	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt)
-		goto out_found;
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
+	if (rqst_should_sleep(rqstp)) {
+		set_current_state(TASK_IDLE);
+		smp_mb__before_atomic();
+		clear_bit(SP_CONGESTED, &pool->sp_flags);
+		clear_bit(RQ_BUSY, &rqstp->rq_flags);
+		smp_mb__after_atomic();
+
+		/* Need to check should_sleep() again after
+		 * setting task state in case a wakeup happened
+		 * between testing and setting.
+		 */
+		if (rqst_should_sleep(rqstp)) {
+			schedule();
+		} else {
+			__set_current_state(TASK_RUNNING);
+			cond_resched();
+		}
 
+		set_bit(RQ_BUSY, &rqstp->rq_flags);
+		smp_mb__after_atomic();
+	} else
+		cond_resched();
 	try_to_freeze();
-
-	set_bit(RQ_BUSY, &rqstp->rq_flags);
-	smp_mb__after_atomic();
-	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
-	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt)
-		goto out_found;
-
-	if (kthread_should_stop())
-		return NULL;
-	return NULL;
-out_found:
-	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
-	/* Normally we will wait up to 5 seconds for any required
-	 * cache information to be provided.
-	 */
-	if (!test_bit(SP_CONGESTED, &pool->sp_flags))
-		rqstp->rq_chandle.thread_wait = 5*HZ;
-	else
-		rqstp->rq_chandle.thread_wait = 1*HZ;
-	trace_svc_xprt_dequeue(rqstp);
-	return rqstp->rq_xprt;
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
@@ -858,20 +840,33 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
  */
 void svc_recv(struct svc_rqst *rqstp)
 {
-	struct svc_xprt		*xprt = NULL;
+	struct svc_pool *pool = rqstp->rq_pool;
 
 	if (!svc_alloc_arg(rqstp))
 		return;
 
-	try_to_freeze();
-	cond_resched();
+	svc_rqst_wait_for_work(rqstp);
+
+	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
+
 	if (kthread_should_stop())
-		goto out;
+		return;
+
+	rqstp->rq_xprt = svc_xprt_dequeue(pool);
+	if (rqstp->rq_xprt) {
+		struct svc_xprt *xprt = rqstp->rq_xprt;
+
+		/* Normally we will wait up to 5 seconds for any required
+		 * cache information to be provided.
+		 */
+		if (test_bit(SP_CONGESTED, &pool->sp_flags))
+			rqstp->rq_chandle.thread_wait = 5 * HZ;
+		else
+			rqstp->rq_chandle.thread_wait = 1 * HZ;
 
-	xprt = svc_get_next_xprt(rqstp);
-	if (xprt)
+		trace_svc_xprt_dequeue(rqstp);
 		svc_handle_xprt(rqstp, xprt);
-out:
+	}
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
-- 
2.40.1

