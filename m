Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48620460E2B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhK2E6N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 23:58:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60086 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhK2E4N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:56:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 529BB21709;
        Mon, 29 Nov 2021 04:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WMZxnJn9vqtBrT6H7ZyMXvwJPRZbifjSSx9SjqAuuE=;
        b=qNxr+ZkygUYbgA/0GcNl0PUQ6VcHTNHJZsNhW7fODKvPrV0BLjUzZe2U5u0MTyiIvNOwyT
        DRb7tK1D559SG1XM+gXdm7dPF3VNu3NeGX54XqOSzeCCbqsZPmpBpWGqC2KTCYLhna7re0
        CKEVnCX9cnNrHGCrEnpe/IriIgkkwZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WMZxnJn9vqtBrT6H7ZyMXvwJPRZbifjSSx9SjqAuuE=;
        b=prF2ISowY0Hfl1U3XYpc1Jm3o9BPA5aokMQ6+S8vm3lajTJ1+fAqE/3mx112FOTAIZ41ys
        xa5W4AP90JdwlzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFB3A133FE;
        Mon, 29 Nov 2021 04:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n4ToJaVcpGHubgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:52:53 +0000
Subject: [PATCH 04/20] SUNRPC: stop using ->sv_nrthreads as a refcount
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148554.32298.8307258870002897708.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The use of sv_nrthreads as a general refcount results in clumsy code, as
is seen by various comments needed to explain the situation.

This patch introduces a 'struct kref' and uses that for reference
counting, leaving sv_nrthreads to be a pure count of threads.  The kref
is managed particularly in svc_get() and svc_put(), and also nfsd_put();

svc_destroy() now takes a pointer to the embedded kref, rather than to
the serv.

nfsd allows the svc_serv to exist with ->sv_nrhtreads being zero.  This
happens when a transport is created before the first thread is started.
To support this, a 'keep_active' flag is introduced which holds a ref on
the svc_serv.  This is set when any listening socket is successfully
added (unless there are running threads), and cleared when the number of
threads is set.  So when the last thread exits, the nfs_serv will be
destroyed.
The use of 'keep_active' replaces previous code which checked if there
were any permanent sockets.

We no longer clear ->rq_server when nfsd() exits.  This was done
to prevent svc_exit_thread() from calling svc_destroy().
Instead we take an extra reference to the svc_serv to prevent
svc_destroy() from being called.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             |    4 ----
 fs/nfs/callback.c          |    2 +-
 fs/nfsd/netns.h            |    7 +++++++
 fs/nfsd/nfsctl.c           |   22 ++++++++++------------
 fs/nfsd/nfssvc.c           |   42 ++++++++++++++++++++++++++----------------
 include/linux/sunrpc/svc.h |   14 ++++----------
 net/sunrpc/svc.c           |   22 +++++++++++-----------
 7 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 135bd86ed3ad..a9669b106dbd 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -486,10 +486,6 @@ int lockd_up(struct net *net, const struct cred *cred)
 		goto err_put;
 	}
 	nlmsvc_users++;
-	/*
-	 * Note: svc_serv structures have an initial use count of 1,
-	 * so we exit through here on both success and failure.
-	 */
 err_put:
 	svc_put(serv);
 err_create:
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index edbc7579b4aa..d9d78ffd1d65 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -169,7 +169,7 @@ static int nfs_callback_start_svc(int minorversion, struct rpc_xprt *xprt,
 	if (nrservs < NFS4_MIN_NR_CALLBACK_THREADS)
 		nrservs = NFS4_MIN_NR_CALLBACK_THREADS;
 
-	if (serv->sv_nrthreads-1 == nrservs)
+	if (serv->sv_nrthreads == nrservs)
 		return 0;
 
 	ret = serv->sv_ops->svo_setup(serv, NULL, nrservs);
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 935c1028c217..08bcd8f23b01 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -123,6 +123,13 @@ struct nfsd_net {
 	u32 clverifier_counter;
 
 	struct svc_serv *nfsd_serv;
+	/* When a listening socket is added to nfsd, keep_active is set
+	 * and this justifies a reference on nfsd_serv.  This stops
+	 * nfsd_serv from being freed.  When the number of threads is
+	 * set, keep_active is cleared and the reference is dropped.  So
+	 * when the last thread exits, the service will be destroyed.
+	 */
+	int keep_active;
 
 	wait_queue_head_t ntf_wq;
 	atomic_t ntf_refcnt;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 93d417871302..2bbc26fbdae8 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -742,13 +742,12 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 		return err;
 
 	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
-	if (err < 0 && list_empty(&nn->nfsd_serv->sv_permsocks)) {
-		nfsd_put(net);
-		return err;
-	}
 
-	/* Decrease the count, but don't shut down the service */
-	nn->nfsd_serv->sv_nrthreads--;
+	if (err >= 0 &&
+	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(nn->nfsd_serv);
+
+	nfsd_put(net);
 	return err;
 }
 
@@ -783,8 +782,10 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
-	/* Decrease the count, but don't shut down the service */
-	nn->nfsd_serv->sv_nrthreads--;
+	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(nn->nfsd_serv);
+
+	nfsd_put(net);
 	return 0;
 out_close:
 	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
@@ -793,10 +794,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
-	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
-		nn->nfsd_serv->sv_nrthreads--;
-	 else
-		nfsd_put(net);
+	nfsd_put(net);
 	return err;
 }
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a0a7564e6c73..5f605e7e8091 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -60,13 +60,13 @@ static __be32			nfsd_init_request(struct svc_rqst *,
  * extent ->sv_temp_socks and ->sv_permsocks. It also protects nfsdstats.th_cnt
  *
  * If (out side the lock) nn->nfsd_serv is non-NULL, then it must point to a
- * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0. That number
- * of nfsd threads must exist and each must listed in ->sp_all_threads in each
- * entry of ->sv_pools[].
+ * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (unless
+ * nn->keep_active is set).  That number of nfsd threads must
+ * exist and each must be listed in ->sp_all_threads in some entry of
+ * ->sv_pools[].
  *
- * Transitions of the thread count between zero and non-zero are of particular
- * interest since the svc_serv needs to be created and initialized at that
- * point, or freed.
+ * Each active thread holds a counted reference on nn->nfsd_serv, as does
+ * the nn->keep_active flag and various transient calls to svc_get().
  *
  * Finally, the nfsd_mutex also protects some of the global variables that are
  * accessed when nfsd starts and that are settable via the write_* routines in
@@ -700,14 +700,22 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 	return 0;
 }
 
+/* This is the callback for kref_put() below.
+ * There is no code here as the first thing to be done is
+ * call svc_shutdown_net(), but we cannot get the 'net' from
+ * the kref.  So do all the work when kref_put returns true.
+ */
+static void nfsd_noop(struct kref *ref)
+{
+}
+
 void nfsd_put(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nn->nfsd_serv->sv_nrthreads -= 1;
-	if (nn->nfsd_serv->sv_nrthreads == 0) {
+	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
 		svc_shutdown_net(nn->nfsd_serv, net);
-		svc_destroy(nn->nfsd_serv);
+		svc_destroy(&nn->nfsd_serv->sv_refcnt);
 		nfsd_complete_shutdown(net);
 	}
 }
@@ -803,15 +811,14 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 			NULL, nrservs);
 	if (error)
 		goto out_shutdown;
-	/* We are holding a reference to nn->nfsd_serv which
-	 * we don't want to count in the return value,
-	 * so subtract 1
-	 */
-	error = nn->nfsd_serv->sv_nrthreads - 1;
+	error = nn->nfsd_serv->sv_nrthreads;
 out_shutdown:
 	if (error < 0 && !nfsd_up_before)
 		nfsd_shutdown_net(net);
 out_put:
+	/* Threads now hold service active */
+	if (xchg(&nn->keep_active, 0))
+		nfsd_put(net);
 	nfsd_put(net);
 out:
 	mutex_unlock(&nfsd_mutex);
@@ -980,11 +987,15 @@ nfsd(void *vrqstp)
 	nfsdstats.th_cnt --;
 
 out:
-	rqstp->rq_server = NULL;
+	/* Take an extra ref so that the svc_put in svc_exit_thread()
+	 * doesn't call svc_destroy()
+	 */
+	svc_get(nn->nfsd_serv);
 
 	/* Release the thread */
 	svc_exit_thread(rqstp);
 
+	/* Now if needed we call svc_destroy in appropriate context */
 	nfsd_put(net);
 
 	/* Release module */
@@ -1099,7 +1110,6 @@ int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 		mutex_unlock(&nfsd_mutex);
 		return -ENODEV;
 	}
-	/* bump up the psudo refcount while traversing */
 	svc_get(nn->nfsd_serv);
 	ret = svc_pool_stats_open(nn->nfsd_serv, file);
 	mutex_unlock(&nfsd_mutex);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 73d56d33a36d..3903b4ae8ac5 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -85,6 +85,7 @@ struct svc_serv {
 	struct svc_program *	sv_program;	/* RPC program */
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
+	struct kref		sv_refcnt;
 	unsigned int		sv_nrthreads;	/* # of server threads */
 	unsigned int		sv_maxconn;	/* max connections allowed or
 						 * '0' causing max to be based
@@ -119,19 +120,14 @@ struct svc_serv {
  * @serv:  the svc_serv to have count incremented
  *
  * Returns: the svc_serv that was passed in.
- *
- * We use sv_nrthreads as a reference count.  svc_put() drops
- * this refcount, so we need to bump it up around operations that
- * change the number of threads.  Horrible, but there it is.
- * Should be called with the "service mutex" held.
  */
 static inline struct svc_serv *svc_get(struct svc_serv *serv)
 {
-	serv->sv_nrthreads++;
+	kref_get(&serv->sv_refcnt);
 	return serv;
 }
 
-void svc_destroy(struct svc_serv *serv);
+void svc_destroy(struct kref *);
 
 /**
  * svc_put - decrement reference count on a SUNRPC serv
@@ -142,9 +138,7 @@ void svc_destroy(struct svc_serv *serv);
  */
 static inline void svc_put(struct svc_serv *serv)
 {
-	serv->sv_nrthreads -= 1;
-	if (serv->sv_nrthreads == 0)
-		svc_destroy(serv);
+	kref_put(&serv->sv_refcnt, svc_destroy);
 }
 
 /*
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 55a1bf0d129f..acddc6e12e9e 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -435,7 +435,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		return NULL;
 	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
-	serv->sv_nrthreads = 1;
+	kref_init(&serv->sv_refcnt);
 	serv->sv_stats     = prog->pg_stats;
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
@@ -526,10 +526,11 @@ EXPORT_SYMBOL_GPL(svc_shutdown_net);
  * protect the sv_nrthreads, sv_permsocks and sv_tempsocks.
  */
 void
-svc_destroy(struct svc_serv *serv)
+svc_destroy(struct kref *ref)
 {
-	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
+	struct svc_serv *serv = container_of(ref, struct svc_serv, sv_refcnt);
 
+	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
 	del_timer_sync(&serv->sv_temptimer);
 
 	/*
@@ -637,6 +638,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp)
 		return ERR_PTR(-ENOMEM);
 
+	svc_get(serv);
 	serv->sv_nrthreads++;
 	spin_lock_bh(&pool->sp_lock);
 	pool->sp_nrthreads++;
@@ -776,8 +778,7 @@ int
 svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
 	if (pool == NULL) {
-		/* The -1 assumes caller has done a svc_get() */
-		nrservs -= (serv->sv_nrthreads-1);
+		nrservs -= serv->sv_nrthreads;
 	} else {
 		spin_lock_bh(&pool->sp_lock);
 		nrservs -= pool->sp_nrthreads;
@@ -814,8 +815,7 @@ int
 svc_set_num_threads_sync(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
 	if (pool == NULL) {
-		/* The -1 assumes caller has done a svc_get() */
-		nrservs -= (serv->sv_nrthreads-1);
+		nrservs -= serv->sv_nrthreads;
 	} else {
 		spin_lock_bh(&pool->sp_lock);
 		nrservs -= pool->sp_nrthreads;
@@ -880,12 +880,12 @@ svc_exit_thread(struct svc_rqst *rqstp)
 		list_del_rcu(&rqstp->rq_all);
 	spin_unlock_bh(&pool->sp_lock);
 
+	serv->sv_nrthreads -= 1;
+	svc_sock_update_bufs(serv);
+
 	svc_rqst_free(rqstp);
 
-	if (!serv)
-		return;
-	svc_sock_update_bufs(serv);
-	svc_destroy(serv);
+	svc_put(serv);
 }
 EXPORT_SYMBOL_GPL(svc_exit_thread);
 


