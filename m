Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B975757471
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGRGjc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGRGjb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:39:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D51A6
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:39:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0004721958;
        Tue, 18 Jul 2023 06:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CF2Clzk7tKgySjNqen1ELNCMJ6JvvWQXIe0cIO8GlYQ=;
        b=Pa6VUi3fpIR0gox7yoG9XVfMjkyhJhX1Q62obRWzRXLq+jOIDoooEZMI26DwqKJIIcGMuz
        3K6yOsdZz8Tun3u25Mb4C+RU03HUmLgKsoLl8r6LPM6eHjdwJXXoj1RnhCbFrWhh4ycVHh
        hCmkrIgwsD5qEYe5IFGASUxOi9aEbqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662365;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CF2Clzk7tKgySjNqen1ELNCMJ6JvvWQXIe0cIO8GlYQ=;
        b=rzlLb4XtpDvcJPYZCum8pDTl41S8TZKTUnld1R88/B0DuAmIzcb7CzA+YYZAwkj4N2gKge
        ZOi3Mj+Nn8myTnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B535F13494;
        Tue, 18 Jul 2023 06:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5HLqGZsztmR9DAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:39:23 +0000
Subject: [PATCH 05/14] SUNRPC: remove timeout arg from svc_recv()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228862.11075.7544295807519851006.stgit@noble.brown>
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

Most svc threads have no interest in a timeout.
nfsd sets it to 1 hour, but this is a wart of no significance.

lockd uses the timeout so that it can call nlmsvc_retry_blocked().
It also sometimes calls svc_wake_up() to ensure this is called.

So change lockd to be consistent and always use svc_wake_up() to trigger
nlmsvc_retry_blocked() - using a timer instead of a timeout to
svc_recv().

And change svc_recv() to not take a timeout arg.

This makes the sp_threads_timedout counter always zero.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c                 |   11 ++++++++---
 fs/lockd/svclock.c             |    5 +++--
 fs/nfs/callback.c              |    2 +-
 fs/nfsd/nfssvc.c               |    2 +-
 include/linux/lockd/lockd.h    |    4 +++-
 include/linux/sunrpc/svc.h     |    1 -
 include/linux/sunrpc/svcsock.h |    2 +-
 net/sunrpc/svc.c               |    2 --
 net/sunrpc/svc_xprt.c          |   27 ++++++++++++---------------
 9 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index a43b63e46127..4f55cd42c2e6 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -55,6 +55,11 @@ static DEFINE_MUTEX(nlmsvc_mutex);
 static unsigned int		nlmsvc_users;
 static struct svc_serv		*nlmsvc_serv;
 unsigned long			nlmsvc_timeout;
+static void nlmsvc_request_retry(struct timer_list *tl)
+{
+	svc_wake_up(nlmsvc_serv);
+}
+DEFINE_TIMER(nlmsvc_retry, nlmsvc_request_retry);
 
 unsigned int lockd_net_id;
 
@@ -130,18 +135,17 @@ lockd(void *vrqstp)
 	 * NFS mount or NFS daemon has gone away.
 	 */
 	while (!kthread_should_stop()) {
-		long timeout = MAX_SCHEDULE_TIMEOUT;
 
 		/* update sv_maxconn if it has changed */
 		rqstp->rq_server->sv_maxconn = nlm_max_connections;
 
-		timeout = nlmsvc_retry_blocked();
+		nlmsvc_retry_blocked();
 
 		/*
 		 * Find any work to do, such as a socket with data available,
 		 * and do the work.
 		 */
-		svc_recv(rqstp, timeout);
+		svc_recv(rqstp);
 	}
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
@@ -375,6 +379,7 @@ static void lockd_put(void)
 #endif
 
 	svc_set_num_threads(nlmsvc_serv, NULL, 0);
+	timer_delete_sync(&nlmsvc_retry);
 	nlmsvc_serv = NULL;
 	dprintk("lockd_down: service destroyed\n");
 }
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c43ccdf28ed9..3d7bd5c04b36 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -1008,7 +1008,7 @@ retry_deferred_block(struct nlm_block *block)
  * picks up locks that can be granted, or grant notifications that must
  * be retransmitted.
  */
-unsigned long
+void
 nlmsvc_retry_blocked(void)
 {
 	unsigned long	timeout = MAX_SCHEDULE_TIMEOUT;
@@ -1038,5 +1038,6 @@ nlmsvc_retry_blocked(void)
 	}
 	spin_unlock(&nlm_blocked_lock);
 
-	return timeout;
+	if (timeout < MAX_SCHEDULE_TIMEOUT)
+		mod_timer(&nlmsvc_retry, jiffies + timeout);
 }
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 914d2402ca98..c47834970224 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -82,7 +82,7 @@ nfs4_callback_svc(void *vrqstp)
 		/*
 		 * Listen for a request on the socket
 		 */
-		svc_recv(rqstp, MAX_SCHEDULE_TIMEOUT);
+		svc_recv(rqstp);
 	}
 
 	svc_exit_thread(rqstp);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 5bf48c33986e..b536b254c59e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -979,7 +979,7 @@ nfsd(void *vrqstp)
 		 * Find a socket with data available and call its
 		 * recvfrom routine.
 		 */
-		svc_recv(rqstp, 60*60*HZ);
+		svc_recv(rqstp);
 		validate_process_creds();
 	}
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index f42594a9efe0..0f016d69c996 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -204,6 +204,8 @@ extern unsigned long		nlmsvc_timeout;
 extern bool			nsm_use_hostnames;
 extern u32			nsm_local_state;
 
+extern struct timer_list	nlmsvc_retry;
+
 /*
  * Lockd client functions
  */
@@ -280,7 +282,7 @@ __be32		  nlmsvc_testlock(struct svc_rqst *, struct nlm_file *,
 			struct nlm_host *, struct nlm_lock *,
 			struct nlm_lock *, struct nlm_cookie *);
 __be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, struct nlm_lock *);
-unsigned long	  nlmsvc_retry_blocked(void);
+void		  nlmsvc_retry_blocked(void);
 void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 					nlm_host_match_fn_t match);
 void		  nlmsvc_grant_reply(struct nlm_cookie *, __be32);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index d51ae1e109b6..f3df7f963653 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -41,7 +41,6 @@ struct svc_pool {
 	struct percpu_counter	sp_messages_arrived;
 	struct percpu_counter	sp_sockets_queued;
 	struct percpu_counter	sp_threads_woken;
-	struct percpu_counter	sp_threads_timedout;
 	struct percpu_counter	sp_threads_starved;
 	struct percpu_counter	sp_threads_no_work;
 
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index fb5c98069356..8da31799affe 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -64,7 +64,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
  * Function prototypes.
  */
 void		svc_close_net(struct svc_serv *, struct net *);
-void		svc_recv(struct svc_rqst *, long);
+void		svc_recv(struct svc_rqst *);
 void		svc_send(struct svc_rqst *rqstp);
 void		svc_drop(struct svc_rqst *);
 void		svc_sock_update_bufs(struct svc_serv *serv);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f09b0cce041c..170eabc03988 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -513,7 +513,6 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
-		percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_starved, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_no_work, 0, GFP_KERNEL);
 
@@ -593,7 +592,6 @@ svc_destroy(struct kref *ref)
 		percpu_counter_destroy(&pool->sp_messages_arrived);
 		percpu_counter_destroy(&pool->sp_sockets_queued);
 		percpu_counter_destroy(&pool->sp_threads_woken);
-		percpu_counter_destroy(&pool->sp_threads_timedout);
 		percpu_counter_destroy(&pool->sp_threads_starved);
 		percpu_counter_destroy(&pool->sp_threads_no_work);
 	}
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 67825eef8646..44a33b1f542f 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -735,10 +735,9 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
+static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
 {
 	struct svc_pool		*pool = rqstp->rq_pool;
-	long			time_left = 0;
 
 	/* rq_xprt should be clear on entry */
 	WARN_ON_ONCE(rqstp->rq_xprt);
@@ -756,7 +755,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	smp_mb__after_atomic();
 
 	if (likely(rqst_should_sleep(rqstp)))
-		time_left = schedule_timeout(timeout);
+		schedule();
 	else
 		__set_current_state(TASK_RUNNING);
 
@@ -770,8 +769,6 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 		goto out_found;
 	}
 
-	if (!time_left)
-		percpu_counter_inc(&pool->sp_threads_timedout);
 	if (kthread_should_stop())
 		return NULL;
 	percpu_counter_inc(&pool->sp_threads_no_work);
@@ -856,7 +853,7 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
  * organised not to touch any cachelines in the shared svc_serv
  * structure, only cachelines in the local svc_pool.
  */
-void svc_recv(struct svc_rqst *rqstp, long timeout)
+void svc_recv(struct svc_rqst *rqstp)
 {
 	struct svc_xprt		*xprt = NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
@@ -870,7 +867,7 @@ void svc_recv(struct svc_rqst *rqstp, long timeout)
 	if (kthread_should_stop())
 		goto out;
 
-	xprt = svc_get_next_xprt(rqstp, timeout);
+	xprt = svc_get_next_xprt(rqstp);
 	if (!xprt)
 		goto out;
 
@@ -1437,14 +1434,14 @@ static int svc_pool_stats_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
-	seq_printf(m, "%u %llu %llu %llu %llu %llu %llu\n",
-		pool->sp_id,
-		percpu_counter_sum_positive(&pool->sp_messages_arrived),
-		percpu_counter_sum_positive(&pool->sp_sockets_queued),
-		percpu_counter_sum_positive(&pool->sp_threads_woken),
-		percpu_counter_sum_positive(&pool->sp_threads_timedout),
-		percpu_counter_sum_positive(&pool->sp_threads_starved),
-		percpu_counter_sum_positive(&pool->sp_threads_no_work));
+	seq_printf(m, "%u %llu %llu %llu 0 %llu %llu\n",
+		   pool->sp_id,
+		   percpu_counter_sum_positive(&pool->sp_messages_arrived),
+		   percpu_counter_sum_positive(&pool->sp_sockets_queued),
+		   percpu_counter_sum_positive(&pool->sp_threads_woken),
+		   /* prevously pool->sp_threads_timedout */
+		   percpu_counter_sum_positive(&pool->sp_threads_starved),
+		   percpu_counter_sum_positive(&pool->sp_threads_no_work));
 
 	return 0;
 }


