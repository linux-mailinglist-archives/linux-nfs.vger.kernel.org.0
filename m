Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A922D453D47
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 01:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhKQAuP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 19:50:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37086 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhKQAuO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 19:50:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCBAD2177B;
        Wed, 17 Nov 2021 00:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637110035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XD2LyIkZV8rwEzNV0WluaqqYJRuyG48hp55yU9sEIR8=;
        b=gdAdJEbbplVLK8AbH2TMbh9qDlUI/Oe26gEqOkK2MRNSMpCQBuF70/AyFmhKef4t5hlxKI
        S9PTsAR2lUX6OqnP7yAy1tvdLjvdTLdM78guIjAdVCQOwIR2RTHPMjQGlDtp8tOEEYIHAZ
        gwv7eDos07VRrixGKYoi6+AARRWhy1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637110035;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XD2LyIkZV8rwEzNV0WluaqqYJRuyG48hp55yU9sEIR8=;
        b=hKvCZQkR6CgWtMYhQsdhEYDvHZy+aM45nxrAwm2PZdScg5yr33l+7miOUM5z/L5N4PVrU4
        Diy3oNHhw3P1pkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D6F913BC1;
        Wed, 17 Nov 2021 00:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KOEJDxJRlGEvWgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 00:47:14 +0000
Subject: [PATCH 01/14] SUNRPC: stop using ->sv_nrthreads as a refcount
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 17 Nov 2021 11:46:50 +1100
Message-ID: <163711001000.5485.14419372582880785559.stgit@noble.brown>
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
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
counting, leaving sv_nrthreads to be a pure count of threads.

svc_get() increments the refcount, and now returns the serv as well.
svc_put() decrements and calls svc_destroy() (which is now
unconditional) when count reaches zero.

nfsd doesn't use svc_put() as it needs to perform an action before
svc_destroy().  So it defines nfsd_put() which uses kref_put() directly.

nfsd allows the svc_serv to exist with ->sv_nrhtreads being zero.  This
happens when a transport is created before the first thread is started.
To support this, a 'keep_active' flag is introduced which holds a ref on
the svc_serv.  This is set when any listening socket is successfully
added (unless there are running threads), and cleared when the number of
threads is set.  So when the last thread exits, the nfs_serv will be
destroyed.

We no longer clear ->rq_server when nfsd() exits.  This was done
to prevent svc_exit_thread() from calling svc_destroy().
Instead we take an extra reference to the svc_serv to prevent
svc_destroy() from being called.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             |   16 ++---------
 fs/nfs/callback.c          |   22 +++-----------
 fs/nfsd/netns.h            |    7 +++++
 fs/nfsd/nfsctl.c           |   21 ++++++--------
 fs/nfsd/nfsd.h             |    2 +
 fs/nfsd/nfssvc.c           |   67 ++++++++++++++++++++++++++------------------
 include/linux/sunrpc/svc.h |   19 +++++++-----
 net/sunrpc/svc.c           |   33 +++++++++-------------
 8 files changed, 88 insertions(+), 99 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index b220e1b91726..a9669b106dbd 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -430,14 +430,8 @@ static struct svc_serv *lockd_create_svc(void)
 	/*
 	 * Check whether we're already up and running.
 	 */
-	if (nlmsvc_rqst) {
-		/*
-		 * Note: increase service usage, because later in case of error
-		 * svc_destroy() will be called.
-		 */
-		svc_get(nlmsvc_rqst->rq_server);
-		return nlmsvc_rqst->rq_server;
-	}
+	if (nlmsvc_rqst)
+		return svc_get(nlmsvc_rqst->rq_server);
 
 	/*
 	 * Sanity check: if there's no pid,
@@ -492,12 +486,8 @@ int lockd_up(struct net *net, const struct cred *cred)
 		goto err_put;
 	}
 	nlmsvc_users++;
-	/*
-	 * Note: svc_serv structures have an initial use count of 1,
-	 * so we exit through here on both success and failure.
-	 */
 err_put:
-	svc_destroy(serv);
+	svc_put(serv);
 err_create:
 	mutex_unlock(&nlmsvc_mutex);
 	return error;
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 86d856de1389..d9d78ffd1d65 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -169,7 +169,7 @@ static int nfs_callback_start_svc(int minorversion, struct rpc_xprt *xprt,
 	if (nrservs < NFS4_MIN_NR_CALLBACK_THREADS)
 		nrservs = NFS4_MIN_NR_CALLBACK_THREADS;
 
-	if (serv->sv_nrthreads-1 == nrservs)
+	if (serv->sv_nrthreads == nrservs)
 		return 0;
 
 	ret = serv->sv_ops->svo_setup(serv, NULL, nrservs);
@@ -266,14 +266,8 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 	/*
 	 * Check whether we're already up and running.
 	 */
-	if (cb_info->serv) {
-		/*
-		 * Note: increase service usage, because later in case of error
-		 * svc_destroy() will be called.
-		 */
-		svc_get(cb_info->serv);
-		return cb_info->serv;
-	}
+	if (cb_info->serv)
+		return svc_get(cb_info->serv);
 
 	switch (minorversion) {
 	case 0:
@@ -335,16 +329,10 @@ int nfs_callback_up(u32 minorversion, struct rpc_xprt *xprt)
 		goto err_start;
 
 	cb_info->users++;
-	/*
-	 * svc_create creates the svc_serv with sv_nrthreads == 1, and then
-	 * svc_prepare_thread increments that. So we need to call svc_destroy
-	 * on both success and failure so that the refcount is 1 when the
-	 * thread exits.
-	 */
 err_net:
 	if (!cb_info->users)
 		cb_info->serv = NULL;
-	svc_destroy(serv);
+	svc_put(serv);
 err_create:
 	mutex_unlock(&nfs_callback_mutex);
 	return ret;
@@ -370,7 +358,7 @@ void nfs_callback_down(int minorversion, struct net *net)
 	if (cb_info->users == 0) {
 		svc_get(serv);
 		serv->sv_ops->svo_setup(serv, NULL, 0);
-		svc_destroy(serv);
+		svc_put(serv);
 		dprintk("nfs_callback_down: service destroyed\n");
 		cb_info->serv = NULL;
 	}
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
index af8531c3854a..22dbd638f6c8 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -742,13 +742,11 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 		return err;
 
 	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
-	if (err < 0) {
-		nfsd_destroy(net);
-		return err;
-	}
 
-	/* Decrease the count, but don't shut down the service */
-	nn->nfsd_serv->sv_nrthreads--;
+	if (!err && !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(nn->nfsd_serv);
+
+	nfsd_put(net);
 	return err;
 }
 
@@ -783,8 +781,10 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
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
@@ -793,10 +793,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
-	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
-		nn->nfsd_serv->sv_nrthreads--;
-	 else
-		nfsd_destroy(net);
+	nfsd_put(net);
 	return err;
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 498e5a489826..3e5008b475ff 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -97,7 +97,7 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-void		nfsd_destroy(struct net *net);
+void		nfsd_put(struct net *net);
 
 bool		i_am_nfsd(void);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 80431921e5d7..1c9505ee4f89 100644
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
@@ -623,7 +623,7 @@ void nfsd_shutdown_threads(struct net *net)
 	svc_get(serv);
 	/* Kill outstanding nfsd threads */
 	serv->sv_ops->svo_setup(serv, NULL, 0);
-	nfsd_destroy(net);
+	nfsd_put(net);
 	mutex_unlock(&nfsd_mutex);
 	/* Wait for shutdown of nfsd_serv to complete */
 	wait_for_completion(&nn->nfsd_shutdown_complete);
@@ -656,7 +656,10 @@ int nfsd_create_serv(struct net *net)
 	nn->nfsd_serv->sv_maxconn = nn->max_connections;
 	error = svc_bind(nn->nfsd_serv, net);
 	if (error < 0) {
-		svc_destroy(nn->nfsd_serv);
+		/* NOT nfsd_put() as notifiers (see below) haven't
+		 * been set up yet.
+		 */
+		svc_put(nn->nfsd_serv);
 		nfsd_complete_shutdown(net);
 		return error;
 	}
@@ -671,6 +674,7 @@ int nfsd_create_serv(struct net *net)
 	}
 	atomic_inc(&nn->ntf_refcnt);
 	nfsd_reset_boot_verifier(nn);
+	svc_get(nn->nfsd_serv);
 	return 0;
 }
 
@@ -697,16 +701,24 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 	return 0;
 }
 
-void nfsd_destroy(struct net *net)
+/* This is the callback for kref_put() below.
+ * There is no code here as the first thing to be done is
+ * call svc_shutdown_net(), but we cannot get the 'net' from
+ * the kref.  So do all the work when kref_put returns true.
+ */
+static void nfsd_noop(struct kref *ref)
+{
+}
+
+void nfsd_put(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	int destroy = (nn->nfsd_serv->sv_nrthreads == 1);
 
-	if (destroy)
+	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
 		svc_shutdown_net(nn->nfsd_serv, net);
-	svc_destroy(nn->nfsd_serv);
-	if (destroy)
+		svc_destroy(&nn->nfsd_serv->sv_refcnt);
 		nfsd_complete_shutdown(net);
+	}
 }
 
 int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
@@ -758,7 +770,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		if (err)
 			break;
 	}
-	nfsd_destroy(net);
+	nfsd_put(net);
 	return err;
 }
 
@@ -795,21 +807,20 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 
 	error = nfsd_startup_net(net, cred);
 	if (error)
-		goto out_destroy;
+		goto out_put;
 	error = nn->nfsd_serv->sv_ops->svo_setup(nn->nfsd_serv,
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
-out_destroy:
-	nfsd_destroy(net);		/* Release server */
+out_put:
+	/* Threads now hold service active */
+	if (xchg(&nn->keep_active, 0))
+		nfsd_put(net);
+	nfsd_put(net);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
@@ -977,12 +988,16 @@ nfsd(void *vrqstp)
 	nfsdstats.th_cnt --;
 
 out:
-	rqstp->rq_server = NULL;
+	/* Take an extra ref so that the svc_put in svc_exit_thread()
+	 * doesn't call svc_destroy()
+	 */
+	svc_get(nn->nfsd_serv);
 
 	/* Release the thread */
 	svc_exit_thread(rqstp);
 
-	nfsd_destroy(net);
+	/* Now if needed we call svc_destroy in appropriate context */
+	nfsd_put(net);
 
 	/* Release module */
 	mutex_unlock(&nfsd_mutex);
@@ -1096,7 +1111,6 @@ int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 		mutex_unlock(&nfsd_mutex);
 		return -ENODEV;
 	}
-	/* bump up the psudo refcount while traversing */
 	svc_get(nn->nfsd_serv);
 	ret = svc_pool_stats_open(nn->nfsd_serv, file);
 	mutex_unlock(&nfsd_mutex);
@@ -1109,8 +1123,7 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
 	struct net *net = inode->i_sb->s_fs_info;
 
 	mutex_lock(&nfsd_mutex);
-	/* this function really, really should have been called svc_put() */
-	nfsd_destroy(net);
+	nfsd_put(net);
 	mutex_unlock(&nfsd_mutex);
 	return ret;
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 0ae28ae6caf2..94c14c61a5f9 100644
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
@@ -114,15 +115,16 @@ struct svc_serv {
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 };
 
-/*
- * We use sv_nrthreads as a reference count.  svc_destroy() drops
- * this refcount, so we need to bump it up around operations that
- * change the number of threads.  Horrible, but there it is.
- * Should be called with the "service mutex" held.
- */
-static inline void svc_get(struct svc_serv *serv)
+static inline struct svc_serv *svc_get(struct svc_serv *serv)
+{
+	kref_get(&serv->sv_refcnt);
+	return serv;
+}
+
+void svc_destroy(struct kref *);
+static inline int svc_put(struct svc_serv *serv)
 {
-	serv->sv_nrthreads++;
+	return kref_put(&serv->sv_refcnt, svc_destroy);
 }
 
 /*
@@ -514,7 +516,6 @@ struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_set_num_threads_sync(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
-void		   svc_destroy(struct svc_serv *);
 void		   svc_shutdown_net(struct svc_serv *, struct net *);
 int		   svc_process(struct svc_rqst *);
 int		   bc_svc_process(struct svc_serv *, struct rpc_rqst *,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4292278a9552..bd610709e88c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -435,8 +435,8 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		return NULL;
 	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
-	serv->sv_nrthreads = 1;
 	serv->sv_stats     = prog->pg_stats;
+	kref_init(&serv->sv_refcnt);
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
 	serv->sv_max_payload = bufsize? bufsize : 4096;
@@ -526,19 +526,12 @@ EXPORT_SYMBOL_GPL(svc_shutdown_net);
  * protect the sv_nrthreads, sv_permsocks and sv_tempsocks.
  */
 void
-svc_destroy(struct svc_serv *serv)
+svc_destroy(struct kref *ref)
 {
-	dprintk("svc: svc_destroy(%s, %d)\n",
-				serv->sv_program->pg_name,
-				serv->sv_nrthreads);
-
-	if (serv->sv_nrthreads) {
-		if (--(serv->sv_nrthreads) != 0) {
-			svc_sock_update_bufs(serv);
-			return;
-		}
-	} else
-		printk("svc_destroy: no threads for serv=%p!\n", serv);
+	struct svc_serv *serv = container_of(ref, struct svc_serv, sv_refcnt);
+
+	dprintk("svc: svc_destroy(%s)\n",
+		serv->sv_program->pg_name);
 
 	del_timer_sync(&serv->sv_temptimer);
 
@@ -647,6 +640,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp)
 		return ERR_PTR(-ENOMEM);
 
+	svc_get(serv);
 	serv->sv_nrthreads++;
 	spin_lock_bh(&pool->sp_lock);
 	pool->sp_nrthreads++;
@@ -786,8 +780,7 @@ int
 svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
 	if (pool == NULL) {
-		/* The -1 assumes caller has done a svc_get() */
-		nrservs -= (serv->sv_nrthreads-1);
+		nrservs -= serv->sv_nrthreads;
 	} else {
 		spin_lock_bh(&pool->sp_lock);
 		nrservs -= pool->sp_nrthreads;
@@ -824,8 +817,7 @@ int
 svc_set_num_threads_sync(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
 	if (pool == NULL) {
-		/* The -1 assumes caller has done a svc_get() */
-		nrservs -= (serv->sv_nrthreads-1);
+		nrservs -= serv->sv_nrthreads;
 	} else {
 		spin_lock_bh(&pool->sp_lock);
 		nrservs -= pool->sp_nrthreads;
@@ -890,11 +882,12 @@ svc_exit_thread(struct svc_rqst *rqstp)
 		list_del_rcu(&rqstp->rq_all);
 	spin_unlock_bh(&pool->sp_lock);
 
+	serv->sv_nrthreads -= 1;
+	svc_sock_update_bufs(serv);
+
 	svc_rqst_free(rqstp);
 
-	/* Release the server */
-	if (serv)
-		svc_destroy(serv);
+	svc_put(serv);
 }
 EXPORT_SYMBOL_GPL(svc_exit_thread);
 


