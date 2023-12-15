Return-Path: <linux-nfs+bounces-615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB860813EED
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 02:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847A2283D7A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 01:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58F923CA;
	Fri, 15 Dec 2023 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MlIai/db";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MmP7J6wa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MlIai/db";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MmP7J6wa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C41FD2
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F33FF220DB;
	Fri, 15 Dec 2023 01:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=li2dHh5oO8woVvZUhPJbftMg8tLixsP83CYVqDQeTD4=;
	b=MlIai/dbcXfG32bKzAcGctTdNecea6pKUjFjwiYA5Od5BHyQTLec1J4bJ0uris2I6eqtyy
	8TnAhktvywEV9va9UMUI//kZWHs0mAnpITdsRiKvMc7JOXP4451T5pqF+LsDFiRRe7Z3dV
	orrRqJKtnmcQPklvZjOlNMKtIhhljtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=li2dHh5oO8woVvZUhPJbftMg8tLixsP83CYVqDQeTD4=;
	b=MmP7J6way1p9rCMKR/lTLAb4ZUlfqvKSw5rveWfQ/b5/12IuLGrOB9AmjaEWzBQ5h3D1D6
	HtBSy3oiSDr/TaAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=li2dHh5oO8woVvZUhPJbftMg8tLixsP83CYVqDQeTD4=;
	b=MlIai/dbcXfG32bKzAcGctTdNecea6pKUjFjwiYA5Od5BHyQTLec1J4bJ0uris2I6eqtyy
	8TnAhktvywEV9va9UMUI//kZWHs0mAnpITdsRiKvMc7JOXP4451T5pqF+LsDFiRRe7Z3dV
	orrRqJKtnmcQPklvZjOlNMKtIhhljtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=li2dHh5oO8woVvZUhPJbftMg8tLixsP83CYVqDQeTD4=;
	b=MmP7J6way1p9rCMKR/lTLAb4ZUlfqvKSw5rveWfQ/b5/12IuLGrOB9AmjaEWzBQ5h3D1D6
	HtBSy3oiSDr/TaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9B10137E8;
	Fri, 15 Dec 2023 01:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d2zXJ1ele2XQTwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 01:01:11 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/5] SUNRPC: discard sv_refcnt, and svc_get/svc_put
Date: Fri, 15 Dec 2023 11:56:34 +1100
Message-ID: <20231215010030.7580-5-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215010030.7580-1-neilb@suse.de>
References: <20231215010030.7580-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *******
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F33FF220DB
X-Spam-Score: 0.69
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="MlIai/db";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MmP7J6wa
X-Spamd-Bar: /

sv_refcnt is no longer useful.
lockd and nfs-cb only ever have the svc active when there are a non-zero
number of threads, so sv_refcnt mirrors sv_nrthreads.

nfsd also keeps the svc active between when a socket is added and when
the first thread is started, but we don't really need a refcount for
that.  We can simply not destroy the svc while there are any permanent
sockets attached.

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
index 16dbef245dbb..74b4360779a1 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -126,13 +126,6 @@ struct nfsd_net {
 	struct svc_info nfsd_info;
 #define nfsd_serv nfsd_info.serv
 
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
index 3368eb5342dc..d0089cc5dc4c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -709,13 +709,10 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
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
 
@@ -751,10 +748,6 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
-	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
-
-	nfsd_put(net);
 	return 0;
 out_close:
 	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
@@ -763,10 +756,10 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
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
index 6927edf932e9..d670adfbc15b 100644
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
@@ -572,6 +563,7 @@ void nfsd_last_thread(struct net *net)
 
 	nfsd_shutdown_net(net);
 	nfsd_export_flush(net);
+	svc_destroy(&serv);
 }
 
 void nfsd_reset_versions(struct nfsd_net *nn)
@@ -646,11 +638,9 @@ void nfsd_shutdown_threads(struct net *net)
 		return;
 	}
 
-	svc_get(serv);
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
 	nfsd_last_thread(net);
-	svc_put(serv);
 	mutex_unlock(&nfsd_mutex);
 }
 
@@ -666,10 +656,9 @@ int nfsd_create_serv(struct net *net)
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
@@ -680,7 +669,7 @@ int nfsd_create_serv(struct net *net)
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
index 3bea2840272d..8d7888234e9e 100644
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
@@ -103,31 +102,7 @@ struct svc_info {
 	struct mutex		*mutex;
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
index fa4e23fa0e09..eb5856e1351d 100644
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
2.43.0


