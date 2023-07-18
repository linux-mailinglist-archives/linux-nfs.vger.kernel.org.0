Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECC2757473
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGRGjs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGRGjq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:39:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290EB1722
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:39:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF5D81FDBF;
        Tue, 18 Jul 2023 06:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+oQs4XlArrHxV/X0+QOfyQHqu7jXMUGddWKRRlBwWc=;
        b=vuC9NmdXWSdXDP8CPf74TOTiVa2C0i2DPezZv1pjy5zEQKz6j6BlKzr4ziEk0DdyJr9U5M
        FdZ4LLDKMt0kfCj/8ooo8dHc4qvkHbv5nAgMkYvUFaEVW5ktEuDfYOAzQ944Up52M8TrYT
        AFk0YBxDUkx1rKePkLRcCRSvkAvoi+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662374;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+oQs4XlArrHxV/X0+QOfyQHqu7jXMUGddWKRRlBwWc=;
        b=IeuVzqF7Oew2jUxO1+pXOhKRWesZnU5f7pMwK0X6+EKP1PVPVC8IN6dxd9YO42bdpl6Qfi
        3cZco4PpnLw//5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E84213494;
        Tue, 18 Jul 2023 06:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YEJeFKUztmSTDAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:39:33 +0000
Subject: [PATCH 07/14] SUNRPC: refactor svc_recv()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228864.11075.17318657609206358910.stgit@noble.brown>
In-Reply-To: <168966227838.11075.2974227708495338626.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_get_next_xprt() does a lot more than get an xprt.  It mostly waits.

So rename to svc_wait_for_work() and don't bother returning a value.
The xprt can be found in ->rq_xprt.

Also move all the code to handle ->rq_xprt into a single if branch, so
that other handlers can be added there if other work is found.

Remove the call to svc_xprt_dequeue() that is before we set TASK_IDLE.
If there is still something to dequeue will still get it after a few
more checks - no sleeping.  This was an unnecessary optimisation which
muddles the code.

Drop a call to kthread_should_stop().  There are enough of those in
svc_wait_for_work().

(This patch is best viewed with "-b")

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c |   70 +++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 44a33b1f542f..c7095ff7d5fd 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -735,19 +735,10 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
+static void svc_wait_for_work(struct svc_rqst *rqstp)
 {
 	struct svc_pool		*pool = rqstp->rq_pool;
 
-	/* rq_xprt should be clear on entry */
-	WARN_ON_ONCE(rqstp->rq_xprt);
-
-	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt) {
-		trace_svc_pool_polled(rqstp);
-		goto out_found;
-	}
-
 	set_current_state(TASK_IDLE);
 	smp_mb__before_atomic();
 	clear_bit(SP_CONGESTED, &pool->sp_flags);
@@ -769,10 +760,9 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
 		goto out_found;
 	}
 
-	if (kthread_should_stop())
-		return NULL;
-	percpu_counter_inc(&pool->sp_threads_no_work);
-	return NULL;
+	if (!kthread_should_stop())
+		percpu_counter_inc(&pool->sp_threads_no_work);
+	return;
 out_found:
 	/* Normally we will wait up to 5 seconds for any required
 	 * cache information to be provided.
@@ -781,7 +771,6 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
 		rqstp->rq_chandle.thread_wait = 5*HZ;
 	else
 		rqstp->rq_chandle.thread_wait = 1*HZ;
-	return rqstp->rq_xprt;
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
@@ -855,45 +844,40 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
  */
 void svc_recv(struct svc_rqst *rqstp)
 {
-	struct svc_xprt		*xprt = NULL;
-	struct svc_serv		*serv = rqstp->rq_server;
-	int			len;
-
 	if (!svc_alloc_arg(rqstp))
-		goto out;
+		return;
 
 	try_to_freeze();
 	cond_resched();
-	if (kthread_should_stop())
-		goto out;
 
-	xprt = svc_get_next_xprt(rqstp);
-	if (!xprt)
-		goto out;
+	svc_wait_for_work(rqstp);
 
-	len = svc_handle_xprt(rqstp, xprt);
+	if (rqstp->rq_xprt) {
+		struct svc_serv	*serv = rqstp->rq_server;
+		struct svc_xprt *xprt = rqstp->rq_xprt;
+		int len;
 
-	/* No data, incomplete (TCP) read, or accept() */
-	if (len <= 0)
-		goto out_release;
+		len = svc_handle_xprt(rqstp, xprt);
 
-	trace_svc_xdr_recvfrom(&rqstp->rq_arg);
+		/* No data, incomplete (TCP) read, or accept() */
+		if (len <= 0) {
+			rqstp->rq_res.len = 0;
+			svc_xprt_release(rqstp);
+		} else {
 
-	clear_bit(XPT_OLD, &xprt->xpt_flags);
+			trace_svc_xdr_recvfrom(&rqstp->rq_arg);
 
-	rqstp->rq_chandle.defer = svc_defer;
+			clear_bit(XPT_OLD, &xprt->xpt_flags);
 
-	if (serv->sv_stats)
-		serv->sv_stats->netcnt++;
-	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
-	rqstp->rq_stime = ktime_get();
-	svc_process(rqstp);
-	return;
-out_release:
-	rqstp->rq_res.len = 0;
-	svc_xprt_release(rqstp);
-out:
-	return;
+			rqstp->rq_chandle.defer = svc_defer;
+
+			if (serv->sv_stats)
+				serv->sv_stats->netcnt++;
+			percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
+			rqstp->rq_stime = ktime_get();
+			svc_process(rqstp);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 


