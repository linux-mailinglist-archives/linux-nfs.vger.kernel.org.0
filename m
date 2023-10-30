Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D907DB1CC
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 02:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjJ3BNm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Oct 2023 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjJ3BNm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Oct 2023 21:13:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EAFBD
        for <linux-nfs@vger.kernel.org>; Sun, 29 Oct 2023 18:13:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BD5B1FE9E;
        Mon, 30 Oct 2023 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698628418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0K9K5xqDbSP9RfzGMvIkzFN/DG8biBDG/PD+hu6It54=;
        b=CXOZJJ2lpyBD9Gu9KHHOULtnYcRzphAk+oKQd8x9cHn5TFYOEnZFXxMDGzFdpR4iwUcI9U
        TO6dgkN2lTnGz3AudQrOK3lIZrrNILQ7CHRF4hRpzNgSBkhYX+3N7bYb4JNN2u5TczwWa7
        LVEz3yo1/zJGOcl31AfhDlMq5yUG7q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698628418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0K9K5xqDbSP9RfzGMvIkzFN/DG8biBDG/PD+hu6It54=;
        b=68hI3j6wlrLM8CQTH1BWk+jd+6mrubyPkn+X5duG53bpFTVzFnRcl60eJ4lQqTEK7j/9vF
        g6bRzJg2sOOzSgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B814713460;
        Mon, 30 Oct 2023 01:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PD5kGj8DP2WJRwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 30 Oct 2023 01:13:35 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/5] SUNRPC: discard sv_refcnt, and svc_get/svc_put
Date:   Mon, 30 Oct 2023 12:08:37 +1100
Message-ID: <20231030011247.9794-5-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030011247.9794-1-neilb@suse.de>
References: <20231030011247.9794-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

sv_refcnt is no longer useful.
lockd and nfs-cb only ever have the svc active when there are a non-zero
number of threads, so sv_refcnt mirrors sv_nrthreads.

nfsd also keeps the svc active between when a socket is added and when
the first thread is started, but we don't really need a refcount for
that.  We can simple not destory the svc after adding a socket.

So remove sv_refcnt and the get/put functions.
Instead of a final call to svc_put(), call svc_destroy() instead.
This is changed to also store NULL in the passed-in pointer to make it
easier to avoid use-after-free situations.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             | 10 ++++------
 fs/nfs/callback.c          | 13 ++++++-------
 fs/nfsd/netns.h            |  7 -------
 fs/nfsd/nfsctl.c           | 15 ++++-----------
 fs/nfsd/nfsd.h             |  7 -------
 fs/nfsd/nfssvc.c           | 26 ++++----------------------
 include/linux/sunrpc/svc.h | 27 +--------------------------
 net/sunrpc/svc.c           | 13 ++++---------
 8 files changed, 23 insertions(+), 95 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 81be07c1d3d1..0d6cb3fdc0e1 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -345,10 +345,10 @@ static int lockd_get(void)
 
 	serv->sv_maxconn = nlm_max_connections;
 	error = svc_set_num_threads(serv, NULL, 1);
-	/* The thread now holds the only reference */
-	svc_put(serv);
-	if (error < 0)
+	if (error < 0) {
+		svc_destroy(&serv);
 		return error;
+	}
 
 	nlmsvc_serv = serv;
 	register_inetaddr_notifier(&lockd_inetaddr_notifier);
@@ -372,11 +372,9 @@ static void lockd_put(void)
 	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
 
-	svc_get(nlmsvc_serv);
 	svc_set_num_threads(nlmsvc_serv, NULL, 0);
-	svc_put(nlmsvc_serv);
 	timer_delete_sync(&nlmsvc_retry);
-	nlmsvc_serv = NULL;
+	svc_destroy(&nlmsvc_serv);
 	dprintk("lockd_down: service destroyed\n");
 }
 
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 4ffa1f469e90..760d27dd7225 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -187,7 +187,7 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 	 * Check whether we're already up and running.
 	 */
 	if (cb_info->serv)
-		return svc_get(cb_info->serv);
+		return cb_info->serv;
 
 	/*
 	 * Sanity check: if there's no task,
@@ -245,9 +245,10 @@ int nfs_callback_up(u32 minorversion, struct rpc_xprt *xprt)
 
 	cb_info->users++;
 err_net:
-	if (!cb_info->users)
-		cb_info->serv = NULL;
-	svc_put(serv);
+	if (!cb_info->users) {
+		svc_set_num_threads(cb_info->serv, NULL, 0);
+		svc_destroy(&cb_info->serv);
+	}
 err_create:
 	mutex_unlock(&nfs_callback_mutex);
 	return ret;
@@ -271,11 +272,9 @@ void nfs_callback_down(int minorversion, struct net *net)
 	nfs_callback_down_net(minorversion, serv, net);
 	cb_info->users--;
 	if (cb_info->users == 0) {
-		svc_get(serv);
 		svc_set_num_threads(serv, NULL, 0);
-		svc_put(serv);
 		dprintk("nfs_callback_down: service destroyed\n");
-		cb_info->serv = NULL;
+		svc_destroy(&cb_info->serv);
 	}
 	mutex_unlock(&nfs_callback_mutex);
 }
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ec49b200b797..7fc39aca5363 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -124,13 +124,6 @@ struct nfsd_net {
 	u32 clverifier_counter;
 
 	struct svc_serv *nfsd_serv;
-	/* When a listening socket is added to nfsd, keep_active is set
-	 * and this justifies a reference on nfsd_serv.  This stops
-	 * nfsd_serv from being freed.  When the number of threads is
-	 * set, keep_active is cleared and the reference is dropped.  So
-	 * when the last thread exits, the service will be destroyed.
-	 */
-	int keep_active;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8f644f1d157c..86cab5281fd2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -705,13 +705,10 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+	if (!nn->nfsd_serv->sv_nrthreads &&
+	    list_empty(&nn->nfsd_serv->sv_permsocks))
 		nfsd_last_thread(net);
-	else if (err >= 0 &&
-		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
 
-	nfsd_put(net);
 	return err;
 }
 
@@ -747,10 +744,6 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
-	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
-
-	nfsd_put(net);
 	return 0;
 out_close:
 	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
@@ -759,10 +752,10 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
-	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+	if (!nn->nfsd_serv->sv_nrthreads &&
+	    list_empty(&nn->nfsd_serv->sv_permsocks))
 		nfsd_last_thread(net);
 
-	nfsd_put(net);
 	return err;
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 3286ffacbc56..9ed0e08d16c2 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -113,13 +113,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-static inline void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	svc_put(nn->nfsd_serv);
-}
-
 bool		i_am_nfsd(void);
 
 struct nfsdfs_client {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 203e1cfc1cad..61a1d966ca48 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -59,15 +59,6 @@ static __be32			nfsd_init_request(struct svc_rqst *,
  * nfsd_mutex protects nn->nfsd_serv -- both the pointer itself and some members
  * of the svc_serv struct such as ->sv_temp_socks and ->sv_permsocks.
  *
- * If (out side the lock) nn->nfsd_serv is non-NULL, then it must point to a
- * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (unless
- * nn->keep_active is set).  That number of nfsd threads must
- * exist and each must be listed in ->sp_all_threads in some entry of
- * ->sv_pools[].
- *
- * Each active thread holds a counted reference on nn->nfsd_serv, as does
- * the nn->keep_active flag and various transient calls to svc_get().
- *
  * Finally, the nfsd_mutex also protects some of the global variables that are
  * accessed when nfsd starts and that are settable via the write_* routines in
  * nfsctl.c. In particular:
@@ -573,6 +564,7 @@ void nfsd_last_thread(struct net *net)
 
 	nfsd_shutdown_net(net);
 	nfsd_export_flush(net);
+	svc_destroy(&serv);
 }
 
 void nfsd_reset_versions(struct nfsd_net *nn)
@@ -647,11 +639,9 @@ void nfsd_shutdown_threads(struct net *net)
 		return;
 	}
 
-	svc_get(serv);
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
 	nfsd_last_thread(net);
-	svc_put(serv);
 	mutex_unlock(&nfsd_mutex);
 }
 
@@ -667,10 +657,9 @@ int nfsd_create_serv(struct net *net)
 	struct svc_serv *serv;
 
 	WARN_ON(!mutex_is_locked(&nfsd_mutex));
-	if (nn->nfsd_serv) {
-		svc_get(nn->nfsd_serv);
+	if (nn->nfsd_serv)
 		return 0;
-	}
+
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
@@ -681,7 +670,7 @@ int nfsd_create_serv(struct net *net)
 	serv->sv_maxconn = nn->max_connections;
 	error = svc_bind(serv, net);
 	if (error < 0) {
-		svc_put(serv);
+		svc_destroy(&serv);
 		return error;
 	}
 	spin_lock(&nfsd_notifier_lock);
@@ -764,7 +753,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		nthreads[0] = 1;
 
 	/* apply the new numbers */
-	svc_get(nn->nfsd_serv);
 	for (i = 0; i < n; i++) {
 		err = svc_set_num_threads(nn->nfsd_serv,
 					  &nn->nfsd_serv->sv_pools[i],
@@ -772,7 +760,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		if (err)
 			break;
 	}
-	svc_put(nn->nfsd_serv);
 	return err;
 }
 
@@ -814,13 +801,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 		goto out_put;
 	error = serv->sv_nrthreads;
 out_put:
-	/* Threads now hold service active */
-	if (xchg(&nn->keep_active, 0))
-		svc_put(serv);
-
 	if (serv->sv_nrthreads == 0)
 		nfsd_last_thread(net);
-	svc_put(serv);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 11acad6988a2..e50e12ed4d12 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -69,7 +69,6 @@ struct svc_serv {
 	struct svc_program *	sv_program;	/* RPC program */
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
-	struct kref		sv_refcnt;
 	unsigned int		sv_nrthreads;	/* # of server threads */
 	unsigned int		sv_maxconn;	/* max connections allowed or
 						 * '0' causing max to be based
@@ -97,31 +96,7 @@ struct svc_serv {
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 };
 
-/**
- * svc_get() - increment reference count on a SUNRPC serv
- * @serv:  the svc_serv to have count incremented
- *
- * Returns: the svc_serv that was passed in.
- */
-static inline struct svc_serv *svc_get(struct svc_serv *serv)
-{
-	kref_get(&serv->sv_refcnt);
-	return serv;
-}
-
-void svc_destroy(struct kref *);
-
-/**
- * svc_put - decrement reference count on a SUNRPC serv
- * @serv:  the svc_serv to have count decremented
- *
- * When the reference count reaches zero, svc_destroy()
- * is called to clean up and free the serv.
- */
-static inline void svc_put(struct svc_serv *serv)
-{
-	kref_put(&serv->sv_refcnt, svc_destroy);
-}
+void svc_destroy(struct svc_serv **svcp);
 
 /*
  * Maximum payload size supported by a kernel RPC server.
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3f2ea7a0496f..0b5889e058c5 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -463,7 +463,6 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		return NULL;
 	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
-	kref_init(&serv->sv_refcnt);
 	serv->sv_stats     = prog->pg_stats;
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
@@ -564,11 +563,13 @@ EXPORT_SYMBOL_GPL(svc_create_pooled);
  * protect sv_permsocks and sv_tempsocks.
  */
 void
-svc_destroy(struct kref *ref)
+svc_destroy(struct svc_serv **servp)
 {
-	struct svc_serv *serv = container_of(ref, struct svc_serv, sv_refcnt);
+	struct svc_serv *serv = *servp;
 	unsigned int i;
 
+	*servp = NULL;
+
 	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
 	timer_shutdown_sync(&serv->sv_temptimer);
 
@@ -675,7 +676,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp)
 		return ERR_PTR(-ENOMEM);
 
-	svc_get(serv);
 	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads += 1;
 	spin_unlock_bh(&serv->sv_lock);
@@ -935,11 +935,6 @@ svc_exit_thread(struct svc_rqst *rqstp)
 
 	svc_rqst_free(rqstp);
 
-	svc_put(serv);
-	/* That svc_put() cannot be the last, because the thread
-	 * waiting for SP_VICTIM_REMAINS to clear must hold
-	 * a reference. So it is still safe to access pool.
-	 */
 	clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
 }
 EXPORT_SYMBOL_GPL(svc_exit_thread);
-- 
2.42.0

