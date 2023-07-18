Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9E757467
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGRGjN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGRGjM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:39:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E6134
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:39:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 432D21FDBC;
        Tue, 18 Jul 2023 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SsquPAl8Ukn9SN2QqF6oIY12wkz6s2wKJCZOujxUlQ=;
        b=wVi1HmmXibGjcedeF2rflz6pF/a6dQ1TXsYBv1zkDO4h730ukqg34dYORlyDK3K6hjCOcd
        f4cqZI7cV9MgnjT8R1dwWqiSk1mQC7LfRSL5Yi3uWnaCnKchgKDs34qdpIfUCYha/6bFgb
        hJTUxb5jhuxjhSLS5+FZGRm7oh+65IQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662350;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SsquPAl8Ukn9SN2QqF6oIY12wkz6s2wKJCZOujxUlQ=;
        b=8hQ7bvRHj+toKOVG/Nz4T2m9+1efb3i6hQrRZIRMZnkgSDQAIRfCOF4jay1ha0rw6syUXV
        0s8KxhDWrt+rfZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED7BB13494;
        Tue, 18 Jul 2023 06:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oei8J4wztmQ1DAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:39:08 +0000
Subject: [PATCH 02/14] nfsd: don't allow nfsd threads to be signalled.
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228860.11075.10973222274248478768.stgit@noble.brown>
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

The original implementation of nfsd used signals to stop threads during
shutdown.
In Linux 2.3.46pre5 nfsd gained the ability to shutdown threads
internally it if was asked to run "0" threads.  After this user-space
transitioned to using "rpc.nfsd 0" to stop nfsd and sending signals to
threads was no longer an important part of the API.

In Commit 3ebdbe5203a8 ("SUNRPC: discard svo_setup and rename
svc_set_num_threads_sync()") (v5.17-rc1~75^2~41) we finally removed the
use of signals for stopping threads, using kthread_stop() instead.

This patch makes the "obvious" next step and removes the ability to
signal nfsd threads - or any svc threads.  nfsd stops allowing signals
and we don't check for their delivery any more.

This will allow for some simplification in later patches.

A change worth noting is in nfsd4_ssc_setup_dul().  There was previously
a signal_pending() check which would only succeed when the thread was
being shut down.  It should really have tested kthread_should_stop() as
well.  Now it just does the later, not the former.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/callback.c     |    9 +--------
 fs/nfsd/nfs4proc.c    |    4 ++--
 fs/nfsd/nfssvc.c      |   12 ------------
 net/sunrpc/svc_xprt.c |   16 ++++++----------
 4 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 456af7d230cf..46a0a2d6962e 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -80,9 +80,6 @@ nfs4_callback_svc(void *vrqstp)
 	set_freezable();
 
 	while (!kthread_freezable_should_stop(NULL)) {
-
-		if (signal_pending(current))
-			flush_signals(current);
 		/*
 		 * Listen for a request on the socket
 		 */
@@ -112,11 +109,7 @@ nfs41_callback_svc(void *vrqstp)
 	set_freezable();
 
 	while (!kthread_freezable_should_stop(NULL)) {
-
-		if (signal_pending(current))
-			flush_signals(current);
-
-		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_IDLE);
 		spin_lock_bh(&serv->sv_cb_lock);
 		if (!list_empty(&serv->sv_cb_list)) {
 			req = list_first_entry(&serv->sv_cb_list,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d8e7a533f9d2..157488290676 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1325,11 +1325,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		if (ni->nsui_busy) {
 			/*  wait - and try again */
 			prepare_to_wait(&nn->nfsd_ssc_waitq, &wait,
-				TASK_INTERRUPTIBLE);
+				TASK_IDLE);
 			spin_unlock(&nn->nfsd_ssc_lock);
 
 			/* allow 20secs for mount/unmount for now - revisit */
-			if (signal_pending(current) ||
+			if (kthread_should_stop() ||
 					(schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 97830e28c140..439fca195925 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -965,15 +965,6 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	/*
-	 * thread is spawned with all signals set to SIG_IGN, re-enable
-	 * the ones that will bring down the thread
-	 */
-	allow_signal(SIGKILL);
-	allow_signal(SIGHUP);
-	allow_signal(SIGINT);
-	allow_signal(SIGQUIT);
-
 	atomic_inc(&nfsdstats.th_cnt);
 
 	set_freezable();
@@ -998,9 +989,6 @@ nfsd(void *vrqstp)
 		validate_process_creds();
 	}
 
-	/* Clear signals before calling svc_exit_thread() */
-	flush_signals(current);
-
 	atomic_dec(&nfsdstats.th_cnt);
 
 out:
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 71b19d0ed642..93395606a0ba 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -686,8 +686,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 			/* Made progress, don't sleep yet */
 			continue;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (signalled() || kthread_should_stop()) {
+		set_current_state(TASK_IDLE);
+		if (kthread_should_stop()) {
 			set_current_state(TASK_RUNNING);
 			return -EINTR;
 		}
@@ -725,7 +725,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 		return false;
 
 	/* are we shutting down? */
-	if (signalled() || kthread_should_stop())
+	if (kthread_should_stop())
 		return false;
 
 	/* are we freezing? */
@@ -749,11 +749,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 		goto out_found;
 	}
 
-	/*
-	 * We have to be able to interrupt this wait
-	 * to bring down the daemons ...
-	 */
-	set_current_state(TASK_INTERRUPTIBLE);
+	set_current_state(TASK_IDLE);
 	smp_mb__before_atomic();
 	clear_bit(SP_CONGESTED, &pool->sp_flags);
 	clear_bit(RQ_BUSY, &rqstp->rq_flags);
@@ -776,7 +772,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 
 	if (!time_left)
 		percpu_counter_inc(&pool->sp_threads_timedout);
-	if (signalled() || kthread_should_stop())
+	if (kthread_should_stop())
 		return ERR_PTR(-EINTR);
 	percpu_counter_inc(&pool->sp_threads_no_work);
 	return ERR_PTR(-EAGAIN);
@@ -873,7 +869,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 	try_to_freeze();
 	cond_resched();
 	err = -EINTR;
-	if (signalled() || kthread_should_stop())
+	if (kthread_should_stop())
 		goto out;
 
 	xprt = svc_get_next_xprt(rqstp, timeout);


