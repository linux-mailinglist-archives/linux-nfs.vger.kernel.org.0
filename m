Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC45377C57A
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 03:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjHOBzK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjHOByz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 21:54:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3918CB0
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 18:54:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF6441F37C;
        Tue, 15 Aug 2023 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692064492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Julz7Bg3DlAp++bp9unav/SPEmEe4GL6W4jHD5hnZVk=;
        b=qcF1/mC+g+pMYudLZYCe68d4vvBaaEbok3maO9wFKW4mCR6wC2twiGrw9jikzsk1mopuYa
        GNBYqnxt46GUWPaZP26v2vYX2EIsip6CSsgy4aojAJ4zI2Q0eyG80JBmzRq3La3oRqCHNp
        DegMGvMruu0atWZhnmMGvQ5h4t9giL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692064492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Julz7Bg3DlAp++bp9unav/SPEmEe4GL6W4jHD5hnZVk=;
        b=QcRszyy2h2z9o2t9/sn4ebL4JbWAEt9+p6RtSu06/97pN3nUVrThhck6zbYgVFVgo7NAOa
        DZJZHRPU/6rFtvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4D331353E;
        Tue, 15 Aug 2023 01:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GAbsGeva2mSwCgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Aug 2023 01:54:51 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/10] SUNRPC: add list of idle threads
Date:   Tue, 15 Aug 2023 11:54:18 +1000
Message-Id: <20230815015426.5091-3-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230815015426.5091-1-neilb@suse.de>
References: <20230815015426.5091-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rather than searching a list of threads to find an idle one, having a
list of idle threads allows an idle thread to be found immediately.

This adds some spin_lock calls which is not ideal, but as the hold-time
is tiny it is still faster than searching a list.  A future patch will
remove them using llist.h.  This involves some subtlety and so is left
to a separate patch.

This removes the need for the RQ_BUSY flag.  The rqst is "busy"
precisely when it is not on the "idle" list.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h    | 25 ++++++++++++++++++++++++-
 include/trace/events/sunrpc.h |  1 -
 net/sunrpc/svc.c              | 14 +++++++++-----
 net/sunrpc/svc_xprt.c         | 15 +++++++++++----
 4 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 0ec691070e27..e9c34e99bc88 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -37,6 +37,7 @@ struct svc_pool {
 	struct list_head	sp_sockets;	/* pending sockets */
 	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
+	struct list_head	sp_idle_threads; /* idle server threads */
 
 	/* statistics on pool operation */
 	struct percpu_counter	sp_messages_arrived;
@@ -186,6 +187,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  */
 struct svc_rqst {
 	struct list_head	rq_all;		/* all threads list */
+	struct list_head	rq_idle;	/* On the idle list */
 	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
 	struct svc_xprt *	rq_xprt;	/* transport ptr */
 
@@ -262,10 +264,31 @@ enum {
 	RQ_SPLICE_OK,		/* turned off in gss privacy to prevent
 				 * encrypting page cache pages */
 	RQ_VICTIM,		/* Have agreed to shut down */
-	RQ_BUSY,		/* request is busy */
 	RQ_DATA,		/* request has data */
 };
 
+/**
+ * svc_thread_set_busy - mark a thread as busy
+ * @rqstp: the thread which is now busy
+ *
+ * If rq_idle is "empty", the thread must be busy.
+ */
+static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
+{
+	INIT_LIST_HEAD(&rqstp->rq_idle);
+}
+
+/**
+ * svc_thread_busy - check if a thread as busy
+ * @rqstp: the thread which might be busy
+ *
+ * If rq_idle is "empty", the thread must be busy.
+ */
+static inline bool svc_thread_busy(struct svc_rqst *rqstp)
+{
+	return list_empty(&rqstp->rq_idle);
+}
+
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
 
 /*
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 6beb38c1dcb5..337c90787fb1 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1677,7 +1677,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
 	svc_rqst_flag(DROPME)						\
 	svc_rqst_flag(SPLICE_OK)					\
 	svc_rqst_flag(VICTIM)						\
-	svc_rqst_flag(BUSY)						\
 	svc_rqst_flag_end(DATA)
 
 #undef svc_rqst_flag
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3033eaf4e0ee..ffcc5371527c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -510,6 +510,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		pool->sp_id = i;
 		INIT_LIST_HEAD(&pool->sp_sockets);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
+		INIT_LIST_HEAD(&pool->sp_idle_threads);
 		spin_lock_init(&pool->sp_lock);
 
 		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
@@ -641,7 +642,7 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	folio_batch_init(&rqstp->rq_fbatch);
 
-	__set_bit(RQ_BUSY, &rqstp->rq_flags);
+	svc_thread_set_busy(rqstp);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
@@ -702,10 +703,13 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 	struct svc_rqst	*rqstp;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
-		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
-			continue;
-
+	spin_lock_bh(&pool->sp_lock);
+	rqstp = list_first_entry_or_null(&pool->sp_idle_threads,
+					 struct svc_rqst, rq_idle);
+	if (rqstp)
+		list_del_init(&rqstp->rq_idle);
+	spin_unlock_bh(&pool->sp_lock);
+	if (rqstp) {
 		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
 		wake_up_process(rqstp->rq_task);
 		rcu_read_unlock();
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b8539545fefd..ebfeeb504a79 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -737,8 +737,9 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 		set_current_state(TASK_IDLE);
 		smp_mb__before_atomic();
 		clear_bit(SP_CONGESTED, &pool->sp_flags);
-		clear_bit(RQ_BUSY, &rqstp->rq_flags);
-		smp_mb__after_atomic();
+		spin_lock_bh(&pool->sp_lock);
+		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
+		spin_unlock_bh(&pool->sp_lock);
 
 		/* Need to check should_sleep() again after
 		 * setting task state in case a wakeup happened
@@ -751,8 +752,14 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 			cond_resched();
 		}
 
-		set_bit(RQ_BUSY, &rqstp->rq_flags);
-		smp_mb__after_atomic();
+		/* We *must* be removed from the list before we can continue.
+		 * If we were woken, this is already done
+		 */
+		if (!svc_thread_busy(rqstp)) {
+			spin_lock_bh(&pool->sp_lock);
+			list_del_init(&rqstp->rq_idle);
+			spin_unlock_bh(&pool->sp_lock);
+		}
 	} else {
 		cond_resched();
 	}
-- 
2.40.1

