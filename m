Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98A9757470
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGRGjZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGRGjX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:39:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4F1A6
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:39:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DCFB2193C;
        Tue, 18 Jul 2023 06:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xg2RgBEO/rX8EeCfAvefOHhgjcQoKsl3XKkN4lPtPJM=;
        b=Oif/wl/htNbnHLV3KASreO6JYFdZkC6UuY2nWMKRnbSXpuQqZCYlVLK7DpWm5J18CF79rw
        y9AraUPccgmPXweLRN+6ou/NoQxUTaVli7tSJKt8RwwkRWtTZeqXQ1b4v37yvg2cpCp8Xr
        JZ9mKv+ElQ9qQpf94GIzq7EJOOxoXQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xg2RgBEO/rX8EeCfAvefOHhgjcQoKsl3XKkN4lPtPJM=;
        b=yM2LKqmaVEkYQBXinx/su0UiRIzmO5D3o7f5m1fWCcmOQXcWGBCNHWir+4UbiMX1jXXdTL
        QG9l3Kl6KAa0swAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D50D913494;
        Tue, 18 Jul 2023 06:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9hXDIZYztmRhDAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:39:18 +0000
Subject: [PATCH 04/14] SUNRPC: change svc_recv() to return void.
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228862.11075.10086063375287695723.stgit@noble.brown>
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

svc_recv() currently returns a 0 on success or one of two errors:
 - -EAGAIN means no message was successfully received
 - -EINTR means the thread has been told to stop

Previously nfsd would stop as the result of a signal as well as
following kthread_stop().  In that case the difference was useful: EINTR
means stop unconditionally.  EAGAIN means stop if kthread_should_stop(),
continue otherwise.

Now threads only exit when kthread_should_stop() so we don't need the
distinction.

So have all threads test kthread_should_stop() (most do), and return
simple success/failure from svc_recv().
Also change some helpers that svc_recv() uses to not bother with an
error code, returning a bool in once case, and NULL for failure in
another.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c                 |    9 +++------
 fs/nfs/callback.c              |    5 +----
 fs/nfsd/nfssvc.c               |    8 ++------
 include/linux/sunrpc/svcsock.h |    2 +-
 net/sunrpc/svc_xprt.c          |   27 +++++++++++----------------
 5 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 91ef139a7757..a43b63e46127 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -116,7 +116,6 @@ static void set_grace_period(struct net *net)
 static int
 lockd(void *vrqstp)
 {
-	int		err = 0;
 	struct svc_rqst *rqstp = vrqstp;
 	struct net *net = &init_net;
 	struct lockd_net *ln = net_generic(net, lockd_net_id);
@@ -139,12 +138,10 @@ lockd(void *vrqstp)
 		timeout = nlmsvc_retry_blocked();
 
 		/*
-		 * Find a socket with data available and call its
-		 * recvfrom routine.
+		 * Find any work to do, such as a socket with data available,
+		 * and do the work.
 		 */
-		err = svc_recv(rqstp, timeout);
-		if (err == -EAGAIN || err == -EINTR)
-			continue;
+		svc_recv(rqstp, timeout);
 	}
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 2d94384bd6a9..914d2402ca98 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -74,7 +74,6 @@ static int nfs4_callback_up_net(struct svc_serv *serv, struct net *net)
 static int
 nfs4_callback_svc(void *vrqstp)
 {
-	int err;
 	struct svc_rqst *rqstp = vrqstp;
 
 	set_freezable();
@@ -83,9 +82,7 @@ nfs4_callback_svc(void *vrqstp)
 		/*
 		 * Listen for a request on the socket
 		 */
-		err = svc_recv(rqstp, MAX_SCHEDULE_TIMEOUT);
-		if (err == -EAGAIN || err == -EINTR)
-			continue;
+		svc_recv(rqstp, MAX_SCHEDULE_TIMEOUT);
 	}
 
 	svc_exit_thread(rqstp);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3e08cc746870..5bf48c33986e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -953,7 +953,6 @@ nfsd(void *vrqstp)
 	struct svc_xprt *perm_sock = list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct svc_xprt), xpt_list);
 	struct net *net = perm_sock->xpt_net;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	int err;
 
 	/* At this point, the thread shares current->fs
 	 * with the init process. We need to create files with the
@@ -972,7 +971,7 @@ nfsd(void *vrqstp)
 	/*
 	 * The main request loop
 	 */
-	for (;;) {
+	while (!kthread_should_stop()) {
 		/* Update sv_maxconn if it has changed */
 		rqstp->rq_server->sv_maxconn = nn->max_connections;
 
@@ -980,10 +979,7 @@ nfsd(void *vrqstp)
 		 * Find a socket with data available and call its
 		 * recvfrom routine.
 		 */
-		while ((err = svc_recv(rqstp, 60*60*HZ)) == -EAGAIN)
-			;
-		if (err == -EINTR)
-			break;
+		svc_recv(rqstp, 60*60*HZ);
 		validate_process_creds();
 	}
 
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 55446136499f..fb5c98069356 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -64,7 +64,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
  * Function prototypes.
  */
 void		svc_close_net(struct svc_serv *, struct net *);
-int		svc_recv(struct svc_rqst *, long);
+void		svc_recv(struct svc_rqst *, long);
 void		svc_send(struct svc_rqst *rqstp);
 void		svc_drop(struct svc_rqst *);
 void		svc_sock_update_bufs(struct svc_serv *serv);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index c808f6d60c99..67825eef8646 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -664,7 +664,7 @@ static void svc_check_conn_limits(struct svc_serv *serv)
 	}
 }
 
-static int svc_alloc_arg(struct svc_rqst *rqstp)
+static bool svc_alloc_arg(struct svc_rqst *rqstp)
 {
 	struct svc_serv *serv = rqstp->rq_server;
 	struct xdr_buf *arg = &rqstp->rq_arg;
@@ -689,7 +689,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 		set_current_state(TASK_IDLE);
 		if (kthread_should_stop()) {
 			set_current_state(TASK_RUNNING);
-			return -EINTR;
+			return false;
 		}
 		trace_svc_alloc_arg_err(pages, ret);
 		memalloc_retry_wait(GFP_KERNEL);
@@ -708,7 +708,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 	arg->tail[0].iov_len = 0;
 
 	rqstp->rq_xid = xdr_zero;
-	return 0;
+	return true;
 }
 
 static bool
@@ -773,9 +773,9 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	if (!time_left)
 		percpu_counter_inc(&pool->sp_threads_timedout);
 	if (kthread_should_stop())
-		return ERR_PTR(-EINTR);
+		return NULL;
 	percpu_counter_inc(&pool->sp_threads_no_work);
-	return ERR_PTR(-EAGAIN);
+	return NULL;
 out_found:
 	/* Normally we will wait up to 5 seconds for any required
 	 * cache information to be provided.
@@ -856,32 +856,27 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
  * organised not to touch any cachelines in the shared svc_serv
  * structure, only cachelines in the local svc_pool.
  */
-int svc_recv(struct svc_rqst *rqstp, long timeout)
+void svc_recv(struct svc_rqst *rqstp, long timeout)
 {
 	struct svc_xprt		*xprt = NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
-	int			len, err;
+	int			len;
 
-	err = svc_alloc_arg(rqstp);
-	if (err)
+	if (!svc_alloc_arg(rqstp))
 		goto out;
 
 	try_to_freeze();
 	cond_resched();
-	err = -EINTR;
 	if (kthread_should_stop())
 		goto out;
 
 	xprt = svc_get_next_xprt(rqstp, timeout);
-	if (IS_ERR(xprt)) {
-		err = PTR_ERR(xprt);
+	if (!xprt)
 		goto out;
-	}
 
 	len = svc_handle_xprt(rqstp, xprt);
 
 	/* No data, incomplete (TCP) read, or accept() */
-	err = -EAGAIN;
 	if (len <= 0)
 		goto out_release;
 
@@ -896,12 +891,12 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
 	rqstp->rq_stime = ktime_get();
 	svc_process(rqstp);
-	return 0;
+	return;
 out_release:
 	rqstp->rq_res.len = 0;
 	svc_xprt_release(rqstp);
 out:
-	return err;
+	return;
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 


