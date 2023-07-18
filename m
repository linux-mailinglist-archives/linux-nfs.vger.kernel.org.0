Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0675747A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGRGkE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGRGkB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:40:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E9198
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:40:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 850B21FDBA;
        Tue, 18 Jul 2023 06:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bfJ1VuW+ZT3TDo1UBsHK1TgxY9tHa4ugAu73odV2dQ=;
        b=AmS8CDarNCgUaH6jRl1nFAb052GWHG3JCsd/tsH3Y3J6vz/hx0DZEjQQL4yX+OHVERcSkV
        g76bjLBObtzytJLlKfTgEPiNRAKmtFtWuE1TwHNPrXjtrZcEwIx/vZgIGjszKsRBdTyWEv
        pvscoIRUB3IX4qdXYbg3sGZTCMj9NpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bfJ1VuW+ZT3TDo1UBsHK1TgxY9tHa4ugAu73odV2dQ=;
        b=y7tTnybFywV8lCs+saeqyMUaUry6tQdP9xdEdxsxjgRBK12m5lRsTZv5SrVVkaCUq4mOh+
        qTPTDc8j2wTmSNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D04E13494;
        Tue, 18 Jul 2023 06:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id blUfOL0ztmS/DAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:39:57 +0000
Subject: [PATCH 12/14] SUNRPC: discard SP_CONGESTED
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228867.11075.5024166935997611658.stgit@noble.brown>
In-Reply-To: <168966227838.11075.2974227708495338626.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We can tell if a pool is congested by checking if the idle list is
empty.  We don't need a separate flag.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h    |    1 -
 include/trace/events/sunrpc.h |    1 -
 net/sunrpc/svc.c              |    1 -
 net/sunrpc/svc_xprt.c         |    4 +---
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ec8088d5b57f..f5b69e6da0f8 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -51,7 +51,6 @@ struct svc_pool {
 /* bits for sp_flags */
 enum {
 	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
-	SP_CONGESTED,		/* all threads are busy, none idle */
 	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
 	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
 };
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index dd0323c40ef5..470c5ba07fba 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2040,7 +2040,6 @@ TRACE_EVENT(svc_xprt_enqueue,
 #define show_svc_pool_flags(x)						\
 	__print_flags(x, "|",						\
 		{ BIT(SP_TASK_PENDING),		"TASK_PENDING" },	\
-		{ BIT(SP_CONGESTED),		"CONGESTED" },		\
 		{ BIT(SP_NEED_VICTIM),		"NEED_VICTIM" },	\
 		{ BIT(SP_VICTIM_REMAINS),	"VICTIM_REMAINS" })
 DECLARE_EVENT_CLASS(svc_pool_scheduler_class,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 028de8f662a8..f6da390932cd 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -721,7 +721,6 @@ void svc_pool_wake_idle_thread(struct svc_serv *serv,
 
 	trace_svc_pool_starved(serv, pool);
 	percpu_counter_inc(&pool->sp_threads_starved);
-	set_bit(SP_CONGESTED, &pool->sp_flags);
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 1d134415ae3f..b82a66f68f17 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -734,8 +734,6 @@ static void svc_wait_for_work(struct svc_rqst *rqstp)
 	struct svc_pool		*pool = rqstp->rq_pool;
 
 	set_current_state(TASK_IDLE);
-	smp_mb__before_atomic();
-	clear_bit(SP_CONGESTED, &pool->sp_flags);
 	spin_lock_bh(&pool->sp_lock);
 	list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
 	spin_unlock_bh(&pool->sp_lock);
@@ -787,7 +785,7 @@ static void svc_wait_for_work(struct svc_rqst *rqstp)
 	/* Normally we will wait up to 5 seconds for any required
 	 * cache information to be provided.
 	 */
-	if (!test_bit(SP_CONGESTED, &pool->sp_flags))
+	if (!list_empty(&pool->sp_idle_threads))
 		rqstp->rq_chandle.thread_wait = 5*HZ;
 	else
 		rqstp->rq_chandle.thread_wait = 1*HZ;


