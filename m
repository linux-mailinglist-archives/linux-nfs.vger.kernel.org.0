Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F375747C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjGRGkX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGRGkP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:40:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95EB18B
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:40:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58DD71FDC1;
        Tue, 18 Jul 2023 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjUQYpH35umZqu/ECBB1/OwerONCDdBCFUC3u+CWa48=;
        b=jdRW0I8rNfkw1XauM2GVsfc1zyZ/gocR2DU/nVH2iAHv3K2z7KKpK2P02LWeCf4uyYHLo6
        1JF4vMIGSr+7w7QH0O5MZbJ0Q4qQLh5dLCAy6rSEBhi5+YbWe1FeUNJIxQmpcjj5J7PkXo
        IZSs3aBATfE74E54N3WAZzuaDd8+dMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjUQYpH35umZqu/ECBB1/OwerONCDdBCFUC3u+CWa48=;
        b=BEt/svcqSQUjo+blrgj4S3Yk4Rk6xrLeHAFxIC/sFi7jAFbGiHPXjQP/O3ay7ET400rced
        PkY/uupfxHis8WBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14CC313494;
        Tue, 18 Jul 2023 06:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CtMwLscztmTlDAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:40:07 +0000
Subject: [PATCH 14/14] SUNRPC: only have one thread waking up at a time
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228868.11075.4709327436093326197.stgit@noble.brown>
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

Currently if several items of work become available in quick succession,
that number of threads (if available) will be woken.  By the time some
of them wake up another thread that was already cache-warm might have
come along and completed the work.  Anecdotal evidence suggests as many
as 15% of wakes find nothing to do once they get to the point of
looking.

This patch changes svc_pool_wake_idle_thread() to wake the first thread
on the queue but NOT remove it.  Subsequent calls will wake the same
thread.  Once that thread starts it will dequeue itself and after
dequeuing some work to do, it will wake the next thread if there is more
work ready.  This results in a more orderly increase in the number of
busy threads.

As a bonus, this allows us to reduce locking around the idle queue.
svc_pool_wake_idle_thread() no longer needs to take a lock (beyond
rcu_read_lock()) as it doesn't manipulate the queue, just looks at the
first item.

The thread itself can avoid locking by using the new
llist_del_first_this() interface.  This will safely remove the thread
itself if it is the head.  If it isn't the head, it will do nothing.
If multiple threads call this concurrently only one will succeed.  The
others will do nothing, so no corruption can result.

If a thread wakes up and find that it cannot dequeue itself that mean
either
- that it wasn't woken because it was the head of the queue.  Maybe the
  freezer woke it.  In that case it can go back to sleep (after trying
  to freeze of course).
- some other thread found there was nothing to do very recently, and
  placed itself on the head of the queue in front of this thread.
  It must check again after placing itself there, so it can be deemed to
  be responsible for any pending work, and this thread can go back to
  sleep until woken.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/llist.h |    2 ++
 lib/llist.c           |   27 +++++++++++++++++++++++++++
 net/sunrpc/svc.c      |   12 +++++-------
 net/sunrpc/svc_xprt.c |   39 +++++++++++++++++++++------------------
 4 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65..d8b1b73f3df0 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -248,6 +248,8 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
 }
 
 extern struct llist_node *llist_del_first(struct llist_head *head);
+extern struct llist_node *llist_del_first_this(struct llist_head *head,
+					       struct llist_node *this);
 
 struct llist_node *llist_reverse_order(struct llist_node *head);
 
diff --git a/lib/llist.c b/lib/llist.c
index 6e668fa5a2c6..7e8a13a13586 100644
--- a/lib/llist.c
+++ b/lib/llist.c
@@ -65,6 +65,33 @@ struct llist_node *llist_del_first(struct llist_head *head)
 }
 EXPORT_SYMBOL_GPL(llist_del_first);
 
+/**
+ * llist_del_first_this - delete given entry of lock-less list if it is first
+ * @head:	the head for your lock-less list
+ * @this:	a list entry.
+ *
+ * If head of the list is given entry, delete and return it, else
+ * return %NULL.
+ *
+ * Providing the caller has exclusive access to @this, multiple callers can
+ * safely call this concurrently with multiple llist_add() callers.
+ */
+struct llist_node *llist_del_first_this(struct llist_head *head,
+					struct llist_node *this)
+{
+	struct llist_node *entry, *next;
+
+	entry = smp_load_acquire(&head->first);
+	do {
+		if (entry != this)
+			return NULL;
+		next = READ_ONCE(entry->next);
+	} while (!try_cmpxchg(&head->first, &entry, next));
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(llist_del_first_this);
+
 /**
  * llist_reverse_order - reverse order of a llist chain
  * @head:	first item of the list to be reversed
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9287a08250b2..43f29f7380db 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -705,17 +705,15 @@ void svc_pool_wake_idle_thread(struct svc_serv *serv,
 	struct llist_node *ln;
 
 	rcu_read_lock();
-	spin_lock_bh(&pool->sp_lock);
-	ln = llist_del_first(&pool->sp_idle_threads);
-	spin_unlock_bh(&pool->sp_lock);
+	ln = READ_ONCE(pool->sp_idle_threads.first);
 	if (ln) {
 		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
-		svc_thread_set_busy(rqstp);
-
 		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
-		wake_up_process(rqstp->rq_task);
+		if (!task_is_running(rqstp->rq_task)) {
+			wake_up_process(rqstp->rq_task);
+			percpu_counter_inc(&pool->sp_threads_woken);
+		}
 		rcu_read_unlock();
-		percpu_counter_inc(&pool->sp_threads_woken);
 		return;
 	}
 	rcu_read_unlock();
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index eb8d345641b2..fa945cbf174a 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -732,31 +732,29 @@ static void svc_wait_for_work(struct svc_rqst *rqstp)
 	if (rqst_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
+		/* maybe there were no idle threads when some work
+		 * became ready and so nothing was woken.  We've just
+		 * become idle so someone can do the work - maybe us.
+		 * So check again for work to do.
+		 */
+		if (likely(rqst_should_sleep(rqstp))) {
+			try_to_freeze();
+			schedule();
+		}
 
-		if (unlikely(!rqst_should_sleep(rqstp)))
-			/* maybe there were no idle threads when some work
-			 * became ready and so nothing was woken.  We've just
-			 * become idle so someone can to the work - maybe us.
-			 * But we cannot reliably remove ourselves from the
-			 * idle list - we can only remove the first task which
-			 * might be us, and might not.
-			 * So remove and wake it, then schedule().  If it was
-			 * us, we won't sleep.  If it is some other thread, they
-			 * will do the work.
+		while (llist_del_first_this(&pool->sp_idle_threads,
+					    &rqstp->rq_idle) == NULL) {
+			/* Cannot remove myself, some other thread
+			 * must have queued themselves after finding
+			 * no work to do, so they have taken reponsibility
+			 * for any outstanding work.
 			 */
-			svc_pool_wake_idle_thread(rqstp->rq_server, pool);
-
-		/* We mustn't continue while on the idle list, and we
-		 * cannot remove outselves reliably.  The only "work"
-		 * we can do while on the idle list is to freeze.
-		 * So loop until someone removes us
-		 */
-		while (!svc_thread_busy(rqstp)) {
 			try_to_freeze();
 			schedule();
 			set_current_state(TASK_IDLE);
 		}
 		__set_current_state(TASK_RUNNING);
+		svc_thread_set_busy(rqstp);
 	}
 
 	try_to_freeze();
@@ -798,6 +796,11 @@ static void svc_wait_for_work(struct svc_rqst *rqstp)
 		rqstp->rq_chandle.thread_wait = 5*HZ;
 	else
 		rqstp->rq_chandle.thread_wait = 1*HZ;
+
+	if (!rqst_should_sleep(rqstp))
+		/* More work pending after I dequeued some,
+		 * wake another worker */
+		svc_pool_wake_idle_thread(rqstp->rq_server, pool);
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)


