Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9390B757477
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGRGj6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGRGj5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:39:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007818D
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:39:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B652921958;
        Tue, 18 Jul 2023 06:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3rS0Fzh/IEriQML3zezsBkppTenxYtL7izNLfLsUoU=;
        b=VsaW3rkHRdew68WLttKkwR9KYrg0NKakZOUmWvBXMHFhU2SeuzFg2d6iPzgKRRFXd34VPl
        +Db+zIRTgzmSICoU5LRz7ggtFht7Hy4oUAstkRBL3gd3rf83glbRPm7JZG7ML/iwPvTe/u
        Nx7zVKFU3vLlryDQs95qlTBLnPoju94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3rS0Fzh/IEriQML3zezsBkppTenxYtL7izNLfLsUoU=;
        b=YRBQvNYGF7m08sJfdZtyGxQfSPyPPESgV+YE78JcNMNNocbMtlLT/6SCRSVTHMZDnskxw6
        rP68GzVl8CN+jhBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7759D13494;
        Tue, 18 Jul 2023 06:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YBDPCrQztmSsDAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:39:48 +0000
Subject: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to return
 nothing.
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228866.11075.18415964365983945832.stgit@noble.brown>
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

No callers of svc_pool_wake_idle_thread() care which thread was woken -
except one that wants to trace the wakeup.  For now we drop that
tracepoint.

One caller wants to know if anything was woken to set SP_CONGESTED, so
set that inside the function instead.

Now svc_pool_wake_idle_thread() can "return" void.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h |    2 +-
 net/sunrpc/svc.c           |   13 +++++--------
 net/sunrpc/svc_xprt.c      |   18 +++---------------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ea3ce1315416..b39c613fbe06 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -454,7 +454,7 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
 
 void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
-struct svc_rqst	  *svc_pool_wake_idle_thread(struct svc_serv *serv,
+void		   svc_pool_wake_idle_thread(struct svc_serv *serv,
 					     struct svc_pool *pool);
 struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b18175ef74ec..fd49e7b12c94 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -696,13 +696,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
  * @serv: RPC service
  * @pool: service thread pool
  *
- * Returns an idle service thread (now marked BUSY), or NULL
- * if no service threads are available. Finding an idle service
- * thread and marking it BUSY is atomic with respect to other
- * calls to svc_pool_wake_idle_thread().
+ * Wake an idle thread if there is one, else mark the pool as congested.
  */
-struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
-					   struct svc_pool *pool)
+void svc_pool_wake_idle_thread(struct svc_serv *serv,
+			       struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
 
@@ -715,13 +712,13 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
 		wake_up_process(rqstp->rq_task);
 		rcu_read_unlock();
 		percpu_counter_inc(&pool->sp_threads_woken);
-		return rqstp;
+		return;
 	}
 	rcu_read_unlock();
 
 	trace_svc_pool_starved(serv, pool);
 	percpu_counter_inc(&pool->sp_threads_starved);
-	return NULL;
+	set_bit(SP_CONGESTED, &pool->sp_flags);
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 948605e7043b..964c97dbb36c 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -456,7 +456,6 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
  */
 void svc_xprt_enqueue(struct svc_xprt *xprt)
 {
-	struct svc_rqst *rqstp;
 	struct svc_pool *pool;
 
 	if (!svc_xprt_ready(xprt))
@@ -477,13 +476,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
 	spin_unlock_bh(&pool->sp_lock);
 
-	rqstp = svc_pool_wake_idle_thread(xprt->xpt_server, pool);
-	if (!rqstp) {
-		set_bit(SP_CONGESTED, &pool->sp_flags);
-		return;
-	}
-
-	trace_svc_xprt_enqueue(xprt, rqstp);
+	svc_pool_wake_idle_thread(xprt->xpt_server, pool);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
 
@@ -587,14 +580,9 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
 void svc_wake_up(struct svc_serv *serv)
 {
 	struct svc_pool *pool = &serv->sv_pools[0];
-	struct svc_rqst *rqstp;
 
-	rqstp = svc_pool_wake_idle_thread(serv, pool);
-	if (!rqstp) {
-		set_bit(SP_TASK_PENDING, &pool->sp_flags);
-		smp_wmb();
-		return;
-	}
+	set_bit(SP_TASK_PENDING, &pool->sp_flags);
+	svc_pool_wake_idle_thread(serv, pool);
 }
 EXPORT_SYMBOL_GPL(svc_wake_up);
 


