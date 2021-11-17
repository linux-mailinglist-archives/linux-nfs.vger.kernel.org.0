Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC6453D4C
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhKQAuj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 19:50:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37164 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhKQAuj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 19:50:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C55832177B;
        Wed, 17 Nov 2021 00:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637110060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqCy0kOsYzhFB29FgVygZCKR96rorJqpPI2t/exLAGA=;
        b=FFotR+S5w1In4sG26PaFhgw1ck1SWyU2hbtJccpNlaFU/B0ZNRrB8ylo/myg4rFqKz69i7
        uX09QRZd0FpmUWOW+quqKOTKvcM81bWmuW2LkDdKl8n1M6+8XEWGXnWuELT9mRPe0JTMzE
        l7eD14gqEHyKneaSxD6/w05NvTr0Oh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637110060;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqCy0kOsYzhFB29FgVygZCKR96rorJqpPI2t/exLAGA=;
        b=ENYDK5F0k55Od8mzBeqvTwAzHb0xA0/oIcHv3QS0+ARXkkGb6hSDoPiDdsw4rdRWD6CHK5
        xjx0IzDS7bhLaqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5B0B13BC1;
        Wed, 17 Nov 2021 00:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A2n9HCtRlGFYWgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 00:47:39 +0000
Subject: [PATCH 06/14] SUNRPC: discard svo_setup and rename
 svc_set_num_threads_sync()
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 17 Nov 2021 11:46:50 +1100
Message-ID: <163711001004.5485.8904325241371303125.stgit@noble.brown>
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The ->svo_setup callback serves no purpose.  It is always called from
within the same module that chooses which callback is needed.  So
discard it and call the relevant function directly.

Now that svc_set_num_threads() is no longer used remove it and rename
svc_set_num_threads_sync() to remove the "_sync" suffix.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/callback.c          |    8 +++----
 fs/nfsd/nfssvc.c           |   11 ++++------
 include/linux/sunrpc/svc.h |    4 ----
 net/sunrpc/svc.c           |   49 ++------------------------------------------
 4 files changed, 10 insertions(+), 62 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index d9d78ffd1d65..6cdc9d18a7dd 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -172,9 +172,9 @@ static int nfs_callback_start_svc(int minorversion, struct rpc_xprt *xprt,
 	if (serv->sv_nrthreads == nrservs)
 		return 0;
 
-	ret = serv->sv_ops->svo_setup(serv, NULL, nrservs);
+	ret = svc_set_num_threads(serv, NULL, nrservs);
 	if (ret) {
-		serv->sv_ops->svo_setup(serv, NULL, 0);
+		svc_set_num_threads(serv, NULL, 0);
 		return ret;
 	}
 	dprintk("nfs_callback_up: service started\n");
@@ -235,14 +235,12 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
 static const struct svc_serv_ops nfs40_cb_sv_ops = {
 	.svo_function		= nfs4_callback_svc,
 	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
-	.svo_setup		= svc_set_num_threads_sync,
 	.svo_module		= THIS_MODULE,
 };
 #if defined(CONFIG_NFS_V4_1)
 static const struct svc_serv_ops nfs41_cb_sv_ops = {
 	.svo_function		= nfs41_callback_svc,
 	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
-	.svo_setup		= svc_set_num_threads_sync,
 	.svo_module		= THIS_MODULE,
 };
 
@@ -357,7 +355,7 @@ void nfs_callback_down(int minorversion, struct net *net)
 	cb_info->users--;
 	if (cb_info->users == 0) {
 		svc_get(serv);
-		serv->sv_ops->svo_setup(serv, NULL, 0);
+		svc_set_num_threads(serv, NULL, 0);
 		svc_put(serv);
 		dprintk("nfs_callback_down: service destroyed\n");
 		cb_info->serv = NULL;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index bf2813ac4443..37408b644607 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -593,7 +593,6 @@ static const struct svc_serv_ops nfsd_thread_sv_ops = {
 	.svo_shutdown		= nfsd_last_thread,
 	.svo_function		= nfsd,
 	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
-	.svo_setup		= svc_set_num_threads_sync,
 	.svo_module		= THIS_MODULE,
 };
 
@@ -611,7 +610,7 @@ void nfsd_shutdown_threads(struct net *net)
 
 	svc_get(serv);
 	/* Kill outstanding nfsd threads */
-	serv->sv_ops->svo_setup(serv, NULL, 0);
+	svc_set_num_threads(serv, NULL, 0);
 	nfsd_put(net);
 	mutex_unlock(&nfsd_mutex);
 }
@@ -751,8 +750,9 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	/* apply the new numbers */
 	svc_get(nn->nfsd_serv);
 	for (i = 0; i < n; i++) {
-		err = nn->nfsd_serv->sv_ops->svo_setup(nn->nfsd_serv,
-				&nn->nfsd_serv->sv_pools[i], nthreads[i]);
+		err = svc_set_num_threads(nn->nfsd_serv,
+					  &nn->nfsd_serv->sv_pools[i],
+					  nthreads[i]);
 		if (err)
 			break;
 	}
@@ -794,8 +794,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	error = nfsd_startup_net(net, cred);
 	if (error)
 		goto out_put;
-	error = nn->nfsd_serv->sv_ops->svo_setup(nn->nfsd_serv,
-			NULL, nrservs);
+	error = svc_set_num_threads(nn->nfsd_serv, NULL, nrservs);
 	if (error)
 		goto out_shutdown;
 	error = nn->nfsd_serv->sv_nrthreads;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dc7bd89f1284..e544444b0259 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -64,9 +64,6 @@ struct svc_serv_ops {
 	/* queue up a transport for servicing */
 	void		(*svo_enqueue_xprt)(struct svc_xprt *);
 
-	/* set up thread (or whatever) execution context */
-	int		(*svo_setup)(struct svc_serv *, struct svc_pool *, int);
-
 	/* optional module to count when adding threads (pooled svcs only) */
 	struct module	*svo_module;
 };
@@ -519,7 +516,6 @@ void		   svc_pool_map_put(void);
 struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 			const struct svc_serv_ops *);
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
-int		   svc_set_num_threads_sync(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
 void		   svc_shutdown_net(struct svc_serv *, struct net *);
 int		   svc_process(struct svc_rqst *);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a099d0145d89..18fc18778a80 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -745,58 +745,13 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	return 0;
 }
 
-
-/* destroy old threads */
-static int
-svc_signal_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
-{
-	struct task_struct *task;
-	unsigned int state = serv->sv_nrthreads-1;
-
-	/* destroy old threads */
-	do {
-		task = choose_victim(serv, pool, &state);
-		if (task == NULL)
-			break;
-		send_sig(SIGINT, task, 1);
-		nrservs++;
-	} while (nrservs < 0);
-
-	return 0;
-}
-
 /*
  * Create or destroy enough new threads to make the number
  * of threads the given number.  If `pool' is non-NULL, applies
  * only to threads in that pool, otherwise round-robins between
  * all pools.  Caller must ensure that mutual exclusion between this and
  * server startup or shutdown.
- *
- * Destroying threads relies on the service threads filling in
- * rqstp->rq_task, which only the nfs ones do.  Assumes the serv
- * has been created using svc_create_pooled().
- *
- * Based on code that used to be in nfsd_svc() but tweaked
- * to be pool-aware.
  */
-int
-svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
-{
-	if (pool == NULL) {
-		nrservs -= serv->sv_nrthreads;
-	} else {
-		spin_lock_bh(&pool->sp_lock);
-		nrservs -= pool->sp_nrthreads;
-		spin_unlock_bh(&pool->sp_lock);
-	}
-
-	if (nrservs > 0)
-		return svc_start_kthreads(serv, pool, nrservs);
-	if (nrservs < 0)
-		return svc_signal_kthreads(serv, pool, nrservs);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(svc_set_num_threads);
 
 /* destroy old threads */
 static int
@@ -817,7 +772,7 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 }
 
 int
-svc_set_num_threads_sync(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
 	if (pool == NULL) {
 		nrservs -= serv->sv_nrthreads;
@@ -833,7 +788,7 @@ svc_set_num_threads_sync(struct svc_serv *serv, struct svc_pool *pool, int nrser
 		return svc_stop_kthreads(serv, pool, nrservs);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(svc_set_num_threads_sync);
+EXPORT_SYMBOL_GPL(svc_set_num_threads);
 
 /**
  * svc_rqst_replace_page - Replace one page in rq_pages[]


