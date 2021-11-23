Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671504599BC
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhKWBeI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:34:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57786 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBeI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:34:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4D68E218B2;
        Tue, 23 Nov 2021 01:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SixIWCbkNt2wko5LpfnhUePKFO3mkjl+Pjz/Oq/HzzQ=;
        b=DiSIIONuPh2VxsVP8LPO+kbgqy/7+G7M2QqyoppMTlkijMhTNfWKk4RRNnKWtSS5jJy2qZ
        dx7l/Sdc/IToGI3NUnEqulUTST0Ry+ltAxNrreqpDh7lyEKSyO83UQgbB6wFxj9jmnGm3L
        G4LmX4Ffs2Yf2Lvrpt+NiU3NFdecFT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631060;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SixIWCbkNt2wko5LpfnhUePKFO3mkjl+Pjz/Oq/HzzQ=;
        b=bxzB/J11jYQAA4uyqoeM43qzqc/70PZGDsPQb+AWV0l/ptwSXw3uBzFXSVJCrvSmxmlTTS
        jSGmnrzpJIuJe4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDAAB13BD4;
        Tue, 23 Nov 2021 01:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fha8JVJEnGGocwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:30:58 +0000
Subject: [PATCH 01/19] SUNRPC/NFSD: clean up get/put functions.
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097540.7284.6343105121634986097.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_destroy() is poorly named - it doesn't necessarily destroy the svc,
it might just reduce the ref count.
nfsd_destroy() is poorly named for the same reason.

This patch:
 - removes the refcount functionality from svc_destroy(), moving it to
   a new svc_put().  Almost all previous callers of svc_destroy() now
   call svc_put().
 - renames nfsd_destroy() to nfsd_put() and improves the code, using
   the new svc_destroy() rather than svc_put()
 - also changes svc_get() to return the serv, which simplifies
   some code a little.

The only non-trivial part of this is that svc_destroy() would call
svc_sock_update() on a non-final decrement.  It can no longer do that,
and svc_put() isn't really a good place of it.  This call is now made
from svc_exit_thread() which seems like a good place.  This makes the
call *before* sv_nrthreads is decremented rather than after.  This
is not particularly important as the call just sets a flag which
causes sv_nrthreads set be checked later.  A subsequent patch will
improve the ordering.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             |   12 +++---------
 fs/nfs/callback.c          |   20 ++++----------------
 fs/nfsd/nfsctl.c           |    4 ++--
 fs/nfsd/nfsd.h             |    2 +-
 fs/nfsd/nfssvc.c           |   30 ++++++++++++++++--------------
 include/linux/sunrpc/svc.h |   29 +++++++++++++++++++++++++----
 net/sunrpc/svc.c           |   19 +++++--------------
 7 files changed, 56 insertions(+), 60 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index b220e1b91726..135bd86ed3ad 100644
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
@@ -497,7 +491,7 @@ int lockd_up(struct net *net, const struct cred *cred)
 	 * so we exit through here on both success and failure.
 	 */
 err_put:
-	svc_destroy(serv);
+	svc_put(serv);
 err_create:
 	mutex_unlock(&nlmsvc_mutex);
 	return error;
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 86d856de1389..edbc7579b4aa 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
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
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index af8531c3854a..5eb564e58a9b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -743,7 +743,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 	if (err < 0) {
-		nfsd_destroy(net);
+		nfsd_put(net);
 		return err;
 	}
 
@@ -796,7 +796,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
 		nn->nfsd_serv->sv_nrthreads--;
 	 else
-		nfsd_destroy(net);
+		nfsd_put(net);
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
index 80431921e5d7..2ab0e650a0e2 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
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
@@ -697,16 +700,16 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 	return 0;
 }
 
-void nfsd_destroy(struct net *net)
+void nfsd_put(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	int destroy = (nn->nfsd_serv->sv_nrthreads == 1);
 
-	if (destroy)
+	nn->nfsd_serv->sv_nrthreads --;
+	if (nn->nfsd_serv->sv_nrthreads == 0) {
 		svc_shutdown_net(nn->nfsd_serv, net);
-	svc_destroy(nn->nfsd_serv);
-	if (destroy)
+		svc_destroy(nn->nfsd_serv);
 		nfsd_complete_shutdown(net);
+	}
 }
 
 int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
@@ -758,7 +761,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		if (err)
 			break;
 	}
-	nfsd_destroy(net);
+	nfsd_put(net);
 	return err;
 }
 
@@ -795,7 +798,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 
 	error = nfsd_startup_net(net, cred);
 	if (error)
-		goto out_destroy;
+		goto out_put;
 	error = nn->nfsd_serv->sv_ops->svo_setup(nn->nfsd_serv,
 			NULL, nrservs);
 	if (error)
@@ -808,8 +811,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 out_shutdown:
 	if (error < 0 && !nfsd_up_before)
 		nfsd_shutdown_net(net);
-out_destroy:
-	nfsd_destroy(net);		/* Release server */
+out_put:
+	nfsd_put(net);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
@@ -982,7 +985,7 @@ nfsd(void *vrqstp)
 	/* Release the thread */
 	svc_exit_thread(rqstp);
 
-	nfsd_destroy(net);
+	nfsd_put(net);
 
 	/* Release module */
 	mutex_unlock(&nfsd_mutex);
@@ -1109,8 +1112,7 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
 	struct net *net = inode->i_sb->s_fs_info;
 
 	mutex_lock(&nfsd_mutex);
-	/* this function really, really should have been called svc_put() */
-	nfsd_destroy(net);
+	nfsd_put(net);
 	mutex_unlock(&nfsd_mutex);
 	return ret;
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 0ae28ae6caf2..d87c3392a1e9 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -114,15 +114,37 @@ struct svc_serv {
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 };
 
-/*
- * We use sv_nrthreads as a reference count.  svc_destroy() drops
+/**
+ * svc_get() - increment reference count on a SUNRPC serv
+ * @serv:  the svc_serv to have count incremented
+ *
+ * Returns: the svc_serv that was passed in.
+ *
+ * We use sv_nrthreads as a reference count.  svc_put() drops
  * this refcount, so we need to bump it up around operations that
  * change the number of threads.  Horrible, but there it is.
  * Should be called with the "service mutex" held.
  */
-static inline void svc_get(struct svc_serv *serv)
+static inline struct svc_serv *svc_get(struct svc_serv *serv)
 {
 	serv->sv_nrthreads++;
+	return serv;
+}
+
+void svc_destroy(struct svc_serv *serv);
+
+/**
+ * svc_put - decrement reference count on a SUNRPC serv
+ * @serv:  the svc_serv to have count decremented
+ *
+ * When the reference count reaches zero, svc_destroy()
+ * is called to clean up and free the serv.
+ */
+static inline void svc_put(struct svc_serv *serv)
+{
+	serv->sv_nrthreads --;
+	if (serv->sv_nrthreads == 0)
+		svc_destroy(serv);
 }
 
 /*
@@ -514,7 +536,6 @@ struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_set_num_threads_sync(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
-void		   svc_destroy(struct svc_serv *);
 void		   svc_shutdown_net(struct svc_serv *, struct net *);
 int		   svc_process(struct svc_rqst *);
 int		   bc_svc_process(struct svc_serv *, struct rpc_rqst *,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4292278a9552..55a1bf0d129f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -528,17 +528,7 @@ EXPORT_SYMBOL_GPL(svc_shutdown_net);
 void
 svc_destroy(struct svc_serv *serv)
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
+	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
 
 	del_timer_sync(&serv->sv_temptimer);
 
@@ -892,9 +882,10 @@ svc_exit_thread(struct svc_rqst *rqstp)
 
 	svc_rqst_free(rqstp);
 
-	/* Release the server */
-	if (serv)
-		svc_destroy(serv);
+	if (!serv)
+		return;
+	svc_sock_update_bufs(serv);
+	svc_destroy(serv);
 }
 EXPORT_SYMBOL_GPL(svc_exit_thread);
 


