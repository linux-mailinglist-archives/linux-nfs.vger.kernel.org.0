Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B984768C63
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGaGxe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGaGxD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:53:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB1C10E0
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:52:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F6651F460;
        Mon, 31 Jul 2023 06:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6IzzePqWtX5yZcA/DORS1NIzKLAFlCpyh5Vq2x4UBk=;
        b=qZ93JHdYYXZlGrZbmhAnciWH7qqCBSPCei1AO4jh2BABdSy6EXpiN4DMN5EA5/bitdZ9Ve
        6kE979v6e61CwtaF8N6p3FB47zb0AQqhgfEjaxQHUq4yjttQ6QyzSeDCfiIgLX0QzQNpwZ
        IRRp2akykh0pAJPmpIjtarOt+5mTH8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6IzzePqWtX5yZcA/DORS1NIzKLAFlCpyh5Vq2x4UBk=;
        b=nuouJCujZEH7Xiy6TC6lC7aqkAenpG4D6VufdebL7jPQ2jty4i8kpTuVehn4jWByR1Sxu2
        kc6TgZgm1SYDpLCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3ED81322C;
        Mon, 31 Jul 2023 06:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vDIgKShax2QqcAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:52:24 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 12/12] SUNRPC: discard SP_CONGESTED
Date:   Mon, 31 Jul 2023 16:48:39 +1000
Message-Id: <20230731064839.7729-13-neilb@suse.de>
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

We can tell if a pool is congested by checking if the idle list is
empty.  We don't need a separate flag.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h    | 1 -
 include/trace/events/sunrpc.h | 2 --
 net/sunrpc/svc.c              | 1 -
 net/sunrpc/svc_xprt.c         | 4 +---
 4 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index c2111bc8a7a1..b100ca16a25f 100644
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
index d00a1a6b9616..6101c1e38eb0 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2058,14 +2058,12 @@ TRACE_EVENT(svc_xprt_enqueue,
 );
 
 TRACE_DEFINE_ENUM(SP_TASK_PENDING);
-TRACE_DEFINE_ENUM(SP_CONGESTED);
 TRACE_DEFINE_ENUM(SP_NEED_VICTIM);
 TRACE_DEFINE_ENUM(SP_VICTIM_REMAINS);
 
 #define show_svc_pool_flags(x)						\
 	__print_flags(x, "|",						\
 		{ BIT(SP_TASK_PENDING),		"TASK_PENDING" },	\
-		{ BIT(SP_CONGESTED),		"CONGESTED" },		\
 		{ BIT(SP_NEED_VICTIM),		"NEED_VICTIM" },	\
 		{ BIT(SP_VICTIM_REMAINS),	"VICTIM_REMAINS" })
 DECLARE_EVENT_CLASS(svc_pool_scheduler_class,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 44a614d96d8d..9102cbd3976c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -724,7 +724,6 @@ void svc_pool_wake_idle_thread(struct svc_serv *serv, struct svc_pool *pool)
 
 	trace_svc_pool_starved(serv, pool);
 	percpu_counter_inc(&pool->sp_threads_starved);
-	set_bit(SP_CONGESTED, &pool->sp_flags);
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 0ba16cbb998b..f294523595fa 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -736,8 +736,6 @@ static bool svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 
 	if (rqst_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE);
-		smp_mb__before_atomic();
-		clear_bit(SP_CONGESTED, &pool->sp_flags);
 		spin_lock_bh(&pool->sp_lock);
 		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
 		spin_unlock_bh(&pool->sp_lock);
@@ -877,7 +875,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		/* Normally we will wait up to 5 seconds for any required
 		 * cache information to be provided.
 		 */
-		if (test_bit(SP_CONGESTED, &pool->sp_flags))
+		if (list_empty(&pool->sp_idle_threads))
 			rqstp->rq_chandle.thread_wait = 5 * HZ;
 		else
 			rqstp->rq_chandle.thread_wait = 1 * HZ;
-- 
2.40.1

