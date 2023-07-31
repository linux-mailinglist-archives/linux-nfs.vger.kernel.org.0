Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7575768C5B
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGaGwX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjGaGwV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:52:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB29710F7
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:52:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71BBB22427;
        Mon, 31 Jul 2023 06:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJxKCxyoRlOtSGox54wFVEfsKephRNt+FPWCT7Esfm0=;
        b=Ha2qNdwHcceHT9vBPm6wLJeMRyS+KyZTGHBib2B7jpIbjkPkOj80oV1/mDv/JNeqxFmcSv
        0LNVSiTlm4q4rudV3ZcUPquz5xfJw1lO2QUC3CwalLC14tvCpPivapWAQzNFWi1LrvixDy
        Q3+fO1cCROLvV2ra8vO5DaL7msYYnxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786334;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJxKCxyoRlOtSGox54wFVEfsKephRNt+FPWCT7Esfm0=;
        b=+MBLEzHP4bpz/w1Qqqu9Weon29JxRuR2B5hv8MetBcgqSNmI1gcD7XquYYTYyP8xFKuPje
        kOGOZnogao3OoYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 310E31322C;
        Mon, 31 Jul 2023 06:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id shAoNRxax2QRcAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:52:12 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/12] SUNRPC: change how svc threads are asked to exit.
Date:   Mon, 31 Jul 2023 16:48:37 +1000
Message-Id: <20230731064839.7729-11-neilb@suse.de>
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

svc threads are currently stopped using kthread_stop().  This requires
identifying a specific thread.  However we don't care which thread
stops, just as long as one does.

So instead, set a flag in the svc_pool to say that a thread needs to
die, and have each thread check this flag instead of calling
kthread_should_stop().  The first to find it clear the flag and moves
towards shutting down.

This removes an explicit dependency on sp_all_threads which will make a
future patch simpler.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c                |  5 ++--
 fs/lockd/svclock.c            |  5 ++--
 fs/nfs/callback.c             |  2 +-
 fs/nfsd/nfs4proc.c            |  8 ++++---
 fs/nfsd/nfssvc.c              |  2 +-
 include/linux/lockd/lockd.h   |  2 +-
 include/linux/sunrpc/svc.h    | 22 +++++++++++++++++-
 include/trace/events/sunrpc.h |  7 ++++--
 net/sunrpc/svc.c              | 43 +++++++++++++++++------------------
 net/sunrpc/svc_xprt.c         |  7 +++---
 10 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 6579948070a4..b441c706c2b8 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -24,7 +24,6 @@
 #include <linux/uio.h>
 #include <linux/smp.h>
 #include <linux/mutex.h>
-#include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/inetdevice.h>
 
@@ -135,11 +134,11 @@ lockd(void *vrqstp)
 	 * The main request loop. We don't terminate until the last
 	 * NFS mount or NFS daemon has gone away.
 	 */
-	while (!kthread_should_stop()) {
+	while (!svc_thread_should_stop(rqstp)) {
 		/* update sv_maxconn if it has changed */
 		rqstp->rq_server->sv_maxconn = nlm_max_connections;
 
-		nlmsvc_retry_blocked();
+		nlmsvc_retry_blocked(rqstp);
 		svc_recv(rqstp);
 	}
 	if (nlmsvc_ops)
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 43aeba9de55c..5fea06555f42 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -30,7 +30,6 @@
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/nlm.h>
 #include <linux/lockd/lockd.h>
-#include <linux/kthread.h>
 #include <linux/exportfs.h>
 
 #define NLMDBG_FACILITY		NLMDBG_SVCLOCK
@@ -1020,13 +1019,13 @@ retry_deferred_block(struct nlm_block *block)
  * be retransmitted.
  */
 void
-nlmsvc_retry_blocked(void)
+nlmsvc_retry_blocked(struct svc_rqst *rqstp)
 {
 	unsigned long	timeout = MAX_SCHEDULE_TIMEOUT;
 	struct nlm_block *block;
 
 	spin_lock(&nlm_blocked_lock);
-	while (!list_empty(&nlm_blocked) && !kthread_should_stop()) {
+	while (!list_empty(&nlm_blocked) && !svc_thread_should_stop(rqstp)) {
 		block = list_entry(nlm_blocked.next, struct nlm_block, b_list);
 
 		if (block->b_when == NLM_NEVER)
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 42a0c2f1e785..4ffa1f469e90 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -78,7 +78,7 @@ nfs4_callback_svc(void *vrqstp)
 
 	set_freezable();
 
-	while (!kthread_should_stop())
+	while (!svc_thread_should_stop(rqstp))
 		svc_recv(rqstp);
 
 	svc_exit_thread(rqstp);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index aa4f21f92deb..669b16348571 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1340,7 +1340,8 @@ extern void nfs_sb_deactive(struct super_block *sb);
  * setup a work entry in the ssc delayed unmount list.
  */
 static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
-				  struct nfsd4_ssc_umount_item **nsui)
+				  struct nfsd4_ssc_umount_item **nsui,
+				  struct svc_rqst *rqstp)
 {
 	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd4_ssc_umount_item *work = NULL;
@@ -1362,7 +1363,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 			spin_unlock(&nn->nfsd_ssc_lock);
 
 			/* allow 20secs for mount/unmount for now - revisit */
-			if (kthread_should_stop() ||
+			if (svc_thread_should_stop(rqstp) ||
 					(schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
@@ -1478,7 +1479,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 		goto out_free_rawdata;
 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
 
-	status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
+	status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui, rqstp);
 	if (status)
 		goto out_free_devname;
 	if ((*nsui)->nsui_vfsmount)
@@ -1653,6 +1654,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
 	if (bytes_total == 0)
 		bytes_total = ULLONG_MAX;
 	do {
+		/* Only async copies can be stopped here */
 		if (kthread_should_stop())
 			break;
 		bytes_copied = nfsd_copy_file_range(src, src_pos, dst, dst_pos,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1582af33e204..062f51fe4dfb 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -957,7 +957,7 @@ nfsd(void *vrqstp)
 	/*
 	 * The main request loop
 	 */
-	while (!kthread_should_stop()) {
+	while (!svc_thread_should_stop(rqstp)) {
 		/* Update sv_maxconn if it has changed */
 		rqstp->rq_server->sv_maxconn = nn->max_connections;
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 0f016d69c996..9f565416d186 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -282,7 +282,7 @@ __be32		  nlmsvc_testlock(struct svc_rqst *, struct nlm_file *,
 			struct nlm_host *, struct nlm_lock *,
 			struct nlm_lock *, struct nlm_cookie *);
 __be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, struct nlm_lock *);
-void		  nlmsvc_retry_blocked(void);
+void		  nlmsvc_retry_blocked(struct svc_rqst *rqstp);
 void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 					nlm_host_match_fn_t match);
 void		  nlmsvc_grant_reply(struct nlm_cookie *, __be32);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index a3f1916937b4..a11b6bb42c17 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -51,6 +51,8 @@ struct svc_pool {
 enum {
 	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
 	SP_CONGESTED,		/* all threads are busy, none idle */
+	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
+	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
 };
 
 
@@ -260,7 +262,7 @@ enum {
 	RQ_DROPME,		/* drop current reply */
 	RQ_SPLICE_OK,		/* turned off in gss privacy to prevent
 				 * encrypting page cache pages */
-	RQ_VICTIM,		/* about to be shut down */
+	RQ_VICTIM,		/* Have agreed to shut down */
 	RQ_BUSY,		/* request is busy */
 	RQ_DATA,		/* request has data */
 };
@@ -300,6 +302,24 @@ static inline struct sockaddr *svc_daddr(const struct svc_rqst *rqst)
 	return (struct sockaddr *) &rqst->rq_daddr;
 }
 
+/**
+ * svc_thread_should_stop - check if this thread should stop
+ * @rqstp: the thread that might need to stop
+ *
+ * To stop an svc thread, the pool flags SP_NEED_VICTIM and SP_VICTIM_REMAINS
+ * are set.  The firs thread which sees SP_NEED_VICTIM clear it becoming
+ * the victim using this function.  It should then promptly call
+ * svc_exit_thread() which completes the process, clearing SP_VICTIM_REMAINS
+ * so the task waiting for a thread to exit can wake and continue.
+ */
+static inline bool svc_thread_should_stop(struct svc_rqst *rqstp)
+{
+	if (test_and_clear_bit(SP_NEED_VICTIM, &rqstp->rq_pool->sp_flags))
+		set_bit(RQ_VICTIM, &rqstp->rq_flags);
+
+	return test_bit(RQ_VICTIM, &rqstp->rq_flags);
+}
+
 struct svc_deferred_req {
 	u32			prot;	/* protocol (UDP or TCP) */
 	struct svc_xprt		*xprt;
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index b6cb93f22720..488c3ccfb6dc 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2060,12 +2060,15 @@ TRACE_EVENT(svc_xprt_enqueue,
 
 TRACE_DEFINE_ENUM(SP_TASK_PENDING);
 TRACE_DEFINE_ENUM(SP_CONGESTED);
+TRACE_DEFINE_ENUM(SP_NEED_VICTIM);
+TRACE_DEFINE_ENUM(SP_VICTIM_REMAINS);
 
 #define show_svc_pool_flags(x)						\
 	__print_flags(x, "|",						\
 		{ BIT(SP_TASK_PENDING),		"TASK_PENDING" },	\
-		{ BIT(SP_CONGESTED),		"CONGESTED" })
-
+		{ BIT(SP_CONGESTED),		"CONGESTED" },		\
+		{ BIT(SP_NEED_VICTIM),		"NEED_VICTIM" },	\
+		{ BIT(SP_VICTIM_REMAINS),	"VICTIM_REMAINS" })
 DECLARE_EVENT_CLASS(svc_pool_scheduler_class,
 	TP_PROTO(
 		const struct svc_rqst *rqstp
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index bdb64651679f..2420d6a09368 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -731,19 +731,22 @@ svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 	return pool ? pool : &serv->sv_pools[(*state)++ % serv->sv_nrpools];
 }
 
-static struct task_struct *
+static struct svc_pool *
 svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 {
 	unsigned int i;
-	struct task_struct *task = NULL;
 
 	if (pool != NULL) {
 		spin_lock_bh(&pool->sp_lock);
+		if (pool->sp_nrthreads)
+			goto found_pool;
+		spin_unlock_bh(&pool->sp_lock);
+		return NULL;
 	} else {
 		for (i = 0; i < serv->sv_nrpools; i++) {
 			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
 			spin_lock_bh(&pool->sp_lock);
-			if (!list_empty(&pool->sp_all_threads))
+			if (pool->sp_nrthreads)
 				goto found_pool;
 			spin_unlock_bh(&pool->sp_lock);
 		}
@@ -751,16 +754,10 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *stat
 	}
 
 found_pool:
-	if (!list_empty(&pool->sp_all_threads)) {
-		struct svc_rqst *rqstp;
-
-		rqstp = list_entry(pool->sp_all_threads.next, struct svc_rqst, rq_all);
-		set_bit(RQ_VICTIM, &rqstp->rq_flags);
-		list_del_rcu(&rqstp->rq_all);
-		task = rqstp->rq_task;
-	}
+	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
+	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
 	spin_unlock_bh(&pool->sp_lock);
-	return task;
+	return pool;
 }
 
 static int
@@ -801,18 +798,16 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 static int
 svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
-	struct svc_rqst	*rqstp;
-	struct task_struct *task;
 	unsigned int state = serv->sv_nrthreads-1;
+	struct svc_pool *victim;
 
 	do {
-		task = svc_pool_victim(serv, pool, &state);
-		if (task == NULL)
+		victim = svc_pool_victim(serv, pool, &state);
+		if (!victim)
 			break;
-		rqstp = kthread_data(task);
-		/* Did we lose a race to svo_function threadfn? */
-		if (kthread_stop(task) == -EINTR)
-			svc_exit_thread(rqstp);
+		svc_pool_wake_idle_thread(serv, victim);
+		wait_on_bit(&victim->sp_flags, SP_VICTIM_REMAINS,
+			    TASK_IDLE);
 		nrservs++;
 	} while (nrservs < 0);
 	return 0;
@@ -932,8 +927,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
 
 	spin_lock_bh(&pool->sp_lock);
 	pool->sp_nrthreads--;
-	if (!test_and_set_bit(RQ_VICTIM, &rqstp->rq_flags))
-		list_del_rcu(&rqstp->rq_all);
+	list_del_rcu(&rqstp->rq_all);
 	spin_unlock_bh(&pool->sp_lock);
 
 	spin_lock_bh(&serv->sv_lock);
@@ -944,6 +938,11 @@ svc_exit_thread(struct svc_rqst *rqstp)
 	svc_rqst_free(rqstp);
 
 	svc_put(serv);
+	/* That svc_put() cannot be the last, because the thread
+	 * waiting for SP_VICTIM_REMAINS to clear must hold
+	 * a reference. So it is still safe to access pool.
+	 */
+	clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
 }
 EXPORT_SYMBOL_GPL(svc_exit_thread);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 6543e7fac264..32469a8c5ba7 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -9,7 +9,6 @@
 #include <linux/sched/mm.h>
 #include <linux/errno.h>
 #include <linux/freezer.h>
-#include <linux/kthread.h>
 #include <linux/slab.h>
 #include <net/sock.h>
 #include <linux/sunrpc/addr.h>
@@ -675,7 +674,7 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
 			continue;
 
 		set_current_state(TASK_IDLE);
-		if (kthread_should_stop()) {
+		if (svc_thread_should_stop(rqstp)) {
 			set_current_state(TASK_RUNNING);
 			return false;
 		}
@@ -713,7 +712,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 		return false;
 
 	/* are we shutting down? */
-	if (kthread_should_stop())
+	if (svc_thread_should_stop(rqstp))
 		return false;
 
 	/* are we freezing? */
@@ -854,7 +853,7 @@ void svc_recv(struct svc_rqst *rqstp)
 
 	slept = svc_rqst_wait_for_work(rqstp);
 
-	if (kthread_should_stop())
+	if (svc_thread_should_stop(rqstp))
 		return;
 
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
-- 
2.40.1

