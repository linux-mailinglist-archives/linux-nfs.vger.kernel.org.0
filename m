Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397C9460E37
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhK2FAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 00:00:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60238 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbhK2E6E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:58:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5393F2171F;
        Mon, 29 Nov 2021 04:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8inyWQ84PUwlEePiVG5QKBJsDPEmshWmX9nr05yctc=;
        b=QBlO3NEbFEK2A9ByJlD+abr/K0qcjZuvGlj2y1OEn/y3HzvrOaKi6wtjfDsiSvh2qL9b7Y
        5ZuRoGJy19fpnNP6Wunv3InnTQZP+a2CqC6NeUtbcF/VgGZFyq5Z5PRM91dkcfEIEi0/pB
        bBpUWUc/0L9yVEiMejelBb1epK8iOBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8inyWQ84PUwlEePiVG5QKBJsDPEmshWmX9nr05yctc=;
        b=tsIpB3b8nF6ENxLlj/7s0TiB3JWhV5njhL1K43g9yA7T90i23HSeYC8j2TBXfCdhSAMxJj
        SjGgpmc+/pd1vIDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34E4C133FE;
        Mon, 29 Nov 2021 04:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1ZcrOPNcpGFlbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:54:11 +0000
Subject: [PATCH 19/20] lockd: use svc_set_num_threads() for thread start and
 stop
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148564.32298.15399372682473640783.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_set_num_threads() does everything that lockd_start_svc() does, except
set sv_maxconn.  It also (when passed 0) finds the threads and
stops them with kthread_stop().

So move the setting for sv_maxconn, and use svc_set_num_thread()

We now don't need nlmsvc_task.

Now that we use svc_set_num_threads() it makes sense to set svo_module.
This request that the thread exists with module_put_and_exit().
Also fix the documentation for svo_module to make this explicit.

svc_prepare_thread is now only used where it is defined, so it can be
made static.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             |   58 ++++++--------------------------------------
 include/linux/sunrpc/svc.h |    6 ++---
 net/sunrpc/svc.c           |    3 +-
 3 files changed, 12 insertions(+), 55 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 1a7c11118b32..4defefd89cbf 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -55,7 +55,6 @@ EXPORT_SYMBOL_GPL(nlmsvc_ops);
 static DEFINE_MUTEX(nlmsvc_mutex);
 static unsigned int		nlmsvc_users;
 static struct svc_serv		*nlmsvc_serv;
-static struct task_struct	*nlmsvc_task;
 unsigned long			nlmsvc_timeout;
 
 unsigned int lockd_net_id;
@@ -186,7 +185,7 @@ lockd(void *vrqstp)
 
 	svc_exit_thread(rqstp);
 
-	return 0;
+	module_put_and_exit(0);
 }
 
 static int create_lockd_listener(struct svc_serv *serv, const char *name,
@@ -292,8 +291,8 @@ static void lockd_down_net(struct svc_serv *serv, struct net *net)
 				__func__, net->ns.inum);
 		}
 	} else {
-		pr_err("%s: no users! task=%p, net=%x\n",
-			__func__, nlmsvc_task, net->ns.inum);
+		pr_err("%s: no users! net=%x\n",
+			__func__, net->ns.inum);
 		BUG();
 	}
 }
@@ -351,49 +350,11 @@ static struct notifier_block lockd_inet6addr_notifier = {
 };
 #endif
 
-static int lockd_start_svc(struct svc_serv *serv)
-{
-	int error;
-	struct svc_rqst *rqst;
-
-	/*
-	 * Create the kernel thread and wait for it to start.
-	 */
-	rqst = svc_prepare_thread(serv, &serv->sv_pools[0], NUMA_NO_NODE);
-	if (IS_ERR(rqst)) {
-		error = PTR_ERR(rqst);
-		printk(KERN_WARNING
-			"lockd_up: svc_rqst allocation failed, error=%d\n",
-			error);
-		goto out_rqst;
-	}
-
-	svc_sock_update_bufs(serv);
-	serv->sv_maxconn = nlm_max_connections;
-
-	nlmsvc_task = kthread_create(lockd, rqst, "%s", serv->sv_name);
-	if (IS_ERR(nlmsvc_task)) {
-		error = PTR_ERR(nlmsvc_task);
-		printk(KERN_WARNING
-			"lockd_up: kthread_run failed, error=%d\n", error);
-		goto out_task;
-	}
-	rqst->rq_task = nlmsvc_task;
-	wake_up_process(nlmsvc_task);
-
-	dprintk("lockd_up: service started\n");
-	return 0;
-
-out_task:
-	svc_exit_thread(rqst);
-	nlmsvc_task = NULL;
-out_rqst:
-	return error;
-}
-
 static const struct svc_serv_ops lockd_sv_ops = {
 	.svo_shutdown		= svc_rpcb_cleanup,
+	.svo_function		= lockd,
 	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
+	.svo_module		= THIS_MODULE,
 };
 
 static int lockd_get(void)
@@ -425,7 +386,8 @@ static int lockd_get(void)
 		return -ENOMEM;
 	}
 
-	error = lockd_start_svc(serv);
+	serv->sv_maxconn = nlm_max_connections;
+	error = svc_set_num_threads(serv, NULL, 1);
 	/* The thread now holds the only reference */
 	svc_put(serv);
 	if (error < 0)
@@ -453,11 +415,7 @@ static void lockd_put(void)
 	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
 
-	if (nlmsvc_task) {
-		kthread_stop(nlmsvc_task);
-		dprintk("lockd_down: service stopped\n");
-		nlmsvc_task = NULL;
-	}
+	svc_set_num_threads(nlmsvc_serv, NULL, 0);
 	nlmsvc_serv = NULL;
 	dprintk("lockd_down: service destroyed\n");
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index d69e6108cb83..cf175d47c6b7 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -64,7 +64,9 @@ struct svc_serv_ops {
 	/* queue up a transport for servicing */
 	void		(*svo_enqueue_xprt)(struct svc_xprt *);
 
-	/* optional module to count when adding threads (pooled svcs only) */
+	/* optional module to count when adding threads.
+	 * Thread function must call module_put_and_exit() to exit.
+	 */
 	struct module	*svo_module;
 };
 
@@ -504,8 +506,6 @@ struct svc_serv *svc_create(struct svc_program *, unsigned int,
 			    const struct svc_serv_ops *);
 struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
-struct svc_rqst *svc_prepare_thread(struct svc_serv *serv,
-					struct svc_pool *pool, int node);
 void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 5fbe7f55289e..2aabec2b4bec 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -652,7 +652,7 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 }
 EXPORT_SYMBOL_GPL(svc_rqst_alloc);
 
-struct svc_rqst *
+static struct svc_rqst *
 svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 {
 	struct svc_rqst	*rqstp;
@@ -672,7 +672,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	spin_unlock_bh(&pool->sp_lock);
 	return rqstp;
 }
-EXPORT_SYMBOL_GPL(svc_prepare_thread);
 
 /*
  * Choose a pool in which to create a new thread, for svc_set_num_threads


