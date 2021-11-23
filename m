Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C354599C4
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKWBev (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:34:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37120 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBeu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:34:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E4A01FD39;
        Tue, 23 Nov 2021 01:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDmTbPDwa5E0x4TGMnc+iOuJ54NJ5XIf5V3R6S6BAIs=;
        b=G44XSsFGT1aM7Ocn6mT8L7rn8AuoE48cxUmDb/OFw3z/QeLtRuBx1nTp5SnC2XBbMz6T8n
        o2UnCW9Hueuub4b+Q1qpj/Hz7I1m0jkoPcjRKxkTVtA/VEGuZBnstOwExn2yM+5ax4v7WF
        3+0h5HrrTVgNYjyI4Y6RgADwQNSXxls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631102;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDmTbPDwa5E0x4TGMnc+iOuJ54NJ5XIf5V3R6S6BAIs=;
        b=MUscU5ma62S/qEOysHW+19TH2wVXLRplQn9I1Wnyc9Uh7CU3TSNuNEQzppZw7Q50+II0tR
        tMk9Vd3y+oSYr0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6410C13BD4;
        Tue, 23 Nov 2021 01:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6tEMCX1EnGHkcwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:31:41 +0000
Subject: [PATCH 08/19] SUNRPC: discard svo_setup and rename
 svc_set_num_threads_sync()
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097546.7284.17574156274358076119.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
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
index d0d9107a1b93..020156e96bdb 100644
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
@@ -750,8 +749,9 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
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
@@ -793,8 +793,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
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
index 36bfc0281988..0b38c6eaf985 100644
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
@@ -541,7 +538,6 @@ void		   svc_pool_map_put(void);
 struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 			const struct svc_serv_ops *);
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
-int		   svc_set_num_threads_sync(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
 void		   svc_shutdown_net(struct svc_serv *, struct net *);
 int		   svc_process(struct svc_rqst *);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 2b2042234e4b..5513f8c9a8d6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -743,58 +743,13 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
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
@@ -815,7 +770,7 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 }
 
 int
-svc_set_num_threads_sync(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
 	if (pool == NULL) {
 		nrservs -= serv->sv_nrthreads;
@@ -831,7 +786,7 @@ svc_set_num_threads_sync(struct svc_serv *serv, struct svc_pool *pool, int nrser
 		return svc_stop_kthreads(serv, pool, nrservs);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(svc_set_num_threads_sync);
+EXPORT_SYMBOL_GPL(svc_set_num_threads);
 
 /**
  * svc_rqst_replace_page - Replace one page in rq_pages[]


