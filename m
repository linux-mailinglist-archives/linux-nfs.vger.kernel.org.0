Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D00378D242
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbjH3C6u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbjH3C6c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:58:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E0193
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07FB0211E2;
        Wed, 30 Aug 2023 02:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYpBzJ2tgW0L8l/P6jQ0OFleSS3iL0SFlQSCIuezm6Y=;
        b=svCsPu52P7bVnBSL2VrTSJJ5EvJMwLXtM2X1vdBLDEm2LqvHwUFnNkqAv2RKjp8Mh040E5
        U9frutU0yHUuRLymqoI26+EqeH+aq1mP10yQNNB7cD7jMB1ri3XrCDkhGgMLzPL565iCRr
        rm3QQTcebrjKHc2BcCtTeioNSnfOsho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYpBzJ2tgW0L8l/P6jQ0OFleSS3iL0SFlQSCIuezm6Y=;
        b=wDfkscRZLdzetFV0Db9DOTL2+PbLnZMRnvk49KEmqEPnsn3/CNaCdU4LPXpLn8zW0qf2Ek
        yzLAbw4vGNkHKiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC36C13301;
        Wed, 30 Aug 2023 02:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q5+CG1Kw7mTvYwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:26 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/10] SQUASH use new llist interfaces in SUNRPC: change service idle list to be an llist
Date:   Wed, 30 Aug 2023 12:54:46 +1000
Message-ID: <20230830025755.21292-4-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830025755.21292-1-neilb@suse.de>
References: <20230830025755.21292-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use init_llist_node, llist_on_list etc for checking if a node is on a
llist.
Discard svc_thread_set_busy() completely and simplify svc_thread_busy()

This can only be squashed if the patch to llist is moved earlier in the
topic.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h | 17 ++---------------
 net/sunrpc/svc.c           |  5 ++---
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ed20a2ea1f81..ad4572630335 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -266,28 +266,15 @@ enum {
 	RQ_DATA,		/* request has data */
 };
 
-/**
- * svc_thread_set_busy - mark a thread as busy
- * @rqstp: the thread which is now busy
- *
- * By convention a thread is busy if rq_idle.next points to rq_idle.
- * This will never be the case for threads on the idle list.
- */
-static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
-{
-	rqstp->rq_idle.next = &rqstp->rq_idle;
-}
-
 /**
  * svc_thread_busy - check if a thread as busy
  * @rqstp: the thread which might be busy
  *
- * By convention a thread is busy if rq_idle.next points to rq_idle.
- * This will never be the case for threads on the idle list.
+ * A thread is only busy when it is not an the idle list.
  */
 static inline bool svc_thread_busy(const struct svc_rqst *rqstp)
 {
-	return rqstp->rq_idle.next == &rqstp->rq_idle;
+	return !llist_on_list(&rqstp->rq_idle);
 }
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index addbf28ea50a..5673f30db295 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -642,7 +642,7 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	folio_batch_init(&rqstp->rq_fbatch);
 
-	svc_thread_set_busy(rqstp);
+	init_llist_node(&rqstp->rq_idle);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
@@ -705,11 +705,10 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 
 	rcu_read_lock();
 	spin_lock_bh(&pool->sp_lock);
-	ln = llist_del_first(&pool->sp_idle_threads);
+	ln = llist_del_first_init(&pool->sp_idle_threads);
 	spin_unlock_bh(&pool->sp_lock);
 	if (ln) {
 		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
-		svc_thread_set_busy(rqstp);
 
 		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
 		wake_up_process(rqstp->rq_task);
-- 
2.41.0

