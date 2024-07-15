Return-Path: <linux-nfs+bounces-4906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA62930F24
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3071F20FB7
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA7113AD11;
	Mon, 15 Jul 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vps7pJlU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2cNjGf96";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vps7pJlU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2cNjGf96"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785526AB8
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029772; cv=none; b=kOEK+RKb9hUlu9tJtEECo5y57yiTjeTGx/U+/xwIAQoTHMIz57NiuIVUoFG0e769V9/MwGp1+UJbmd44i0zRqG3iyeTNXfx1s81SnQS2p6rClDT5acLDSJJpqUMjXZRvThJ/OV2saMcM+iNyjiFN5EIOe7j2dApHlp4o3iFivLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029772; c=relaxed/simple;
	bh=Erzkq6D6GxGT67AZuBp5xl3cCK4QWTXJBOik6JiiF8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZN0UL3SC5ZCzIHkGSd31z+Ng/94FvTVTeu9kvdq6T/5W+GE8am3LzEmhj9m7LKxoKMJ9F6AtQ+LhaJg7V/eCYPdA5Jb/sYrIl9dXRn51tGVxZmoQlWja3PE7IU4xXQASE6K0RIvOkDIVHNHsNMRbK6AsZVRA5oj+jObjPxBQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vps7pJlU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2cNjGf96; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vps7pJlU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2cNjGf96; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E31621A03;
	Mon, 15 Jul 2024 07:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiQ27tJ54p1JmOSv2GfocIQv/5T9sX5doNifIBp4E2o=;
	b=vps7pJlUgrX52GJqOp8/hcq9zXYVBIXXxosFP0Op6UO7WyOAMIAKbmQ3B8sgSGKwmk3v+Y
	5TMw8MCkN5QRZmtBEfv2yLsvaM7ZDU7cL+h2bgVgd1/701Xbwd+mmLletWAjG+czQ9t1t1
	YtJoNHazlWeRBo9cHOuaQmMh/P4Y0y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiQ27tJ54p1JmOSv2GfocIQv/5T9sX5doNifIBp4E2o=;
	b=2cNjGf96oaJJaw6GbGiK3BMnhBU1lWEpp7SQzhGjyYlq7zB6fXyWimgnMv+ybKPCIc1Awv
	E0mA4uWFc+S7y7CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vps7pJlU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2cNjGf96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiQ27tJ54p1JmOSv2GfocIQv/5T9sX5doNifIBp4E2o=;
	b=vps7pJlUgrX52GJqOp8/hcq9zXYVBIXXxosFP0Op6UO7WyOAMIAKbmQ3B8sgSGKwmk3v+Y
	5TMw8MCkN5QRZmtBEfv2yLsvaM7ZDU7cL+h2bgVgd1/701Xbwd+mmLletWAjG+czQ9t1t1
	YtJoNHazlWeRBo9cHOuaQmMh/P4Y0y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiQ27tJ54p1JmOSv2GfocIQv/5T9sX5doNifIBp4E2o=;
	b=2cNjGf96oaJJaw6GbGiK3BMnhBU1lWEpp7SQzhGjyYlq7zB6fXyWimgnMv+ybKPCIc1Awv
	E0mA4uWFc+S7y7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34E37137EB;
	Mon, 15 Jul 2024 07:49:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JMjxNoXUlGZjbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:49:25 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 14/14] nfsd: adjust number of running nfsd threads
Date: Mon, 15 Jul 2024 17:14:27 +1000
Message-ID: <20240715074657.18174-15-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E31621A03
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

svc_recv() is changed to return a status.  This can be:
 -ETIMEDOUT - waited for 5 seconds and found nothing to do.  This is
          boring.  Also there are more actual threads than really
          needed.
 -EBUSY - I did something, but there is more stuff to do and no one
          idle who I can wake up to do it.
          BTW I successful set a flag: SP_TASK_STARTING.  You better
          clear it.
 0 - just minding my own business, nothing to see here.

nfsd() is changed to pay attention to this status.
In the case of -ETIMEDOUT, if the service mutex can be taken (trylock),
the thread becomes and RQ_VICTIM so that it will exit.
In the case of -EBUSY, if the actual number of threads is below
the calculated maximum, a new thread is started.  SP_TASK_STARTING
is cleared.

To support the above, some code is split out of svc_start_kthreads()
into svc_new_thread().

I think we want memory pressure to be able to push a thread into
returning -ETIMEDOUT.  That can come later.

There are printk's in here.  They can be discarded or turned into trace
points once we are sure about what we want.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c               | 32 ++++++++++++++++-
 fs/nfsd/vfs.c                  |  1 +
 include/linux/sunrpc/svc.h     |  2 ++
 include/linux/sunrpc/svcsock.h |  2 +-
 net/sunrpc/svc.c               | 66 +++++++++++++++++++---------------
 net/sunrpc/svc_xprt.c          | 46 +++++++++++++++++++-----
 6 files changed, 110 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 75d78c17756f..1c8a7dcbfc42 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -931,9 +931,11 @@ static int
 nfsd(void *vrqstp)
 {
 	struct svc_rqst *rqstp = (struct svc_rqst *) vrqstp;
+	struct svc_pool *pool = rqstp->rq_pool;
 	struct svc_xprt *perm_sock = list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct svc_xprt), xpt_list);
 	struct net *net = perm_sock->xpt_net;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	bool have_mutex = false;
 
 	/* At this point, the thread shares current->fs
 	 * with the init process. We need to create files with the
@@ -954,7 +956,33 @@ nfsd(void *vrqstp)
 		/* Update sv_maxconn if it has changed */
 		rqstp->rq_server->sv_maxconn = nn->max_connections;
 
-		svc_recv(rqstp);
+		switch (svc_recv(rqstp)) {
+		case -ETIMEDOUT: /* Nothing to do */
+			if (mutex_trylock(&nfsd_mutex)) {
+				if (pool->sp_nractual > pool->sp_nrthreads) {
+					set_bit(RQ_VICTIM, &rqstp->rq_flags);
+					pool->sp_nractual -= 1;
+					printk("Kill a victim\n");
+					have_mutex = true;
+				} else
+					mutex_unlock(&nfsd_mutex);
+			} else printk("trylock failed\n");
+			break;
+		case -EBUSY: /* Too much to do */
+			if (pool->sp_nractual < nfsd_max_pool_threads(pool, nn) &&
+			    mutex_trylock(&nfsd_mutex)) {
+				// check no idle threads?
+				if (pool->sp_nractual < nfsd_max_pool_threads(pool,nn)) {
+					printk("start new thread\n");
+					svc_new_thread(rqstp->rq_server, pool);
+				}
+				mutex_unlock(&nfsd_mutex);
+			}
+			clear_bit(SP_TASK_STARTING, &pool->sp_flags);
+			break;
+		default:
+			break;
+		}
 
 		nfsd_file_net_dispose(nn);
 	}
@@ -963,6 +991,8 @@ nfsd(void *vrqstp)
 
 	/* Release the thread */
 	svc_exit_thread(rqstp);
+	if (have_mutex)
+		mutex_unlock(&nfsd_mutex);
 	return 0;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29b1f3613800..92bc7c778411 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1203,6 +1203,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
 	}
+	msleep(40);
 	*cnt = host_err;
 	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 363105fc6326..6c9d0e42f5d5 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -53,6 +53,7 @@ enum {
 	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
 	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
 	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
+	SP_TASK_STARTING,	/* Task has started but not added to idle yet */
 };
 
 
@@ -410,6 +411,7 @@ struct svc_serv *svc_create(struct svc_program *, unsigned int,
 bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
+int		   svc_new_thread(struct svc_serv *serv, struct svc_pool *pool);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     struct svc_stat *stats,
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index bf45d9e8492a..11d43600eabb 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -56,7 +56,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
 /*
  * Function prototypes.
  */
-void		svc_recv(struct svc_rqst *rqstp);
+int		svc_recv(struct svc_rqst *rqstp);
 void		svc_send(struct svc_rqst *rqstp);
 int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const int fd, char *name_return, const size_t len,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 33c1a7793f63..26b6e73fc0de 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -796,19 +796,46 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
 	return NULL;
 }
 
-static int
-svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+int svc_new_thread(struct svc_serv *serv, struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
 	struct task_struct *task;
-	struct svc_pool *chosen_pool;
-	unsigned int state = serv->sv_nrthreads-1;
 	int node;
 
-	do {
-		nrservs--;
-		chosen_pool = svc_pool_next(serv, pool, &state);
-		node = svc_pool_map_get_node(chosen_pool->sp_id);
+	node = svc_pool_map_get_node(pool->sp_id);
+
+	rqstp = svc_prepare_thread(serv, pool, node);
+	if (IS_ERR(rqstp))
+		return PTR_ERR(rqstp);
+	set_bit(SP_TASK_STARTING, &pool->sp_flags);
+	task = kthread_create_on_node(serv->sv_threadfn, rqstp,
+				      node, "%s", serv->sv_name);
+	if (IS_ERR(task)) {
+		clear_bit(SP_TASK_STARTING, &pool->sp_flags);
+		svc_exit_thread(rqstp);
+		return PTR_ERR(task);
+	}
+	serv->sv_nractual += 1;
+	pool->sp_nractual += 1;
+
+	rqstp->rq_task = task;
+	if (serv->sv_nrpools > 1)
+		svc_pool_map_set_cpumask(task, pool->sp_id);
+
+	svc_sock_update_bufs(serv);
+	wake_up_process(task);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(svc_new_thread);
+
+static int
+svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+{
+	unsigned int state = serv->sv_nrthreads-1;
+	int err = 0;
+
+	while (!err && nrservs--) {
+		struct svc_pool *chosen_pool = svc_pool_next(serv, pool, &state);
 
 		serv->sv_nrthreads += 1;
 		chosen_pool->sp_nrthreads += 1;
@@ -816,27 +843,10 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		if (chosen_pool->sp_nrthreads <= chosen_pool->sp_nractual)
 			continue;
 
-		rqstp = svc_prepare_thread(serv, chosen_pool, node);
-		if (IS_ERR(rqstp))
-			return PTR_ERR(rqstp);
-		task = kthread_create_on_node(serv->sv_threadfn, rqstp,
-					      node, "%s", serv->sv_name);
-		if (IS_ERR(task)) {
-			svc_exit_thread(rqstp);
-			return PTR_ERR(task);
-		}
-		serv->sv_nractual += 1;
-		chosen_pool->sp_nractual += 1;
-
-		rqstp->rq_task = task;
-		if (serv->sv_nrpools > 1)
-			svc_pool_map_set_cpumask(task, chosen_pool->sp_id);
-
-		svc_sock_update_bufs(serv);
-		wake_up_process(task);
-	} while (nrservs > 0);
+		err = svc_new_thread(serv, chosen_pool);
+	}
 
-	return 0;
+	return err;
 }
 
 static int
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index a9215e1a2f38..b382bc690670 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -729,15 +729,19 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
+static bool svc_thread_wait_for_work(struct svc_rqst *rqstp)
 {
 	struct svc_pool *pool = rqstp->rq_pool;
+	bool did_wait = false;
 
 	if (svc_thread_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
-		if (likely(svc_thread_should_sleep(rqstp)))
-			schedule();
+		clear_bit(SP_TASK_STARTING, &pool->sp_flags);
+		if (likely(svc_thread_should_sleep(rqstp))) {
+			schedule_timeout(5*HZ);
+			did_wait = true;
+		}
 
 		while (!llist_del_first_this(&pool->sp_idle_threads,
 					     &rqstp->rq_idle)) {
@@ -749,7 +753,12 @@ static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 			 * for this new work.  This thread can safely sleep
 			 * until woken again.
 			 */
-			schedule();
+			if (did_wait) {
+				schedule_timeout(HZ);
+			} else {
+				schedule_timeout(5*HZ);
+				did_wait = true;
+			}
 			set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		}
 		__set_current_state(TASK_RUNNING);
@@ -757,6 +766,7 @@ static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 		cond_resched();
 	}
 	try_to_freeze();
+	return did_wait;
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
@@ -840,6 +850,8 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 
 static void svc_thread_wake_next(struct svc_rqst *rqstp)
 {
+	clear_bit(SP_TASK_STARTING, &rqstp->rq_pool->sp_flags);
+
 	if (!svc_thread_should_sleep(rqstp))
 		/* More work pending after I dequeued some,
 		 * wake another worker
@@ -854,21 +866,31 @@ static void svc_thread_wake_next(struct svc_rqst *rqstp)
  * This code is carefully organised not to touch any cachelines in
  * the shared svc_serv structure, only cachelines in the local
  * svc_pool.
+ *
+ * Returns -ETIMEDOUT if idle for an extended period
+ *         -EBUSY is there is more work to do than available threads
+ *         0 otherwise.
  */
-void svc_recv(struct svc_rqst *rqstp)
+int svc_recv(struct svc_rqst *rqstp)
 {
 	struct svc_pool *pool = rqstp->rq_pool;
+	bool did_wait;
+	int ret = 0;
 
 	if (!svc_alloc_arg(rqstp))
-		return;
+		return ret;
 
-	svc_thread_wait_for_work(rqstp);
+	did_wait = svc_thread_wait_for_work(rqstp);
+
+	if (did_wait && svc_thread_should_sleep(rqstp) &&
+	    pool->sp_nractual > pool->sp_nrthreads)
+		ret = -ETIMEDOUT;
 
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 
 	if (svc_thread_should_stop(rqstp)) {
 		svc_thread_wake_next(rqstp);
-		return;
+		return ret;
 	}
 
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
@@ -882,8 +904,13 @@ void svc_recv(struct svc_rqst *rqstp)
 		 */
 		if (pool->sp_idle_threads.first)
 			rqstp->rq_chandle.thread_wait = 5 * HZ;
-		else
+		else {
 			rqstp->rq_chandle.thread_wait = 1 * HZ;
+			if (!did_wait &&
+			    !test_and_set_bit(SP_TASK_STARTING,
+					      &pool->sp_flags))
+				ret = -EBUSY;
+		}
 
 		trace_svc_xprt_dequeue(rqstp);
 		svc_handle_xprt(rqstp, xprt);
@@ -902,6 +929,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		}
 	}
 #endif
+	return ret;
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
-- 
2.44.0


