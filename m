Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687F94599CE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhKWBfv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:35:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBfv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:35:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 624331FD33;
        Tue, 23 Nov 2021 01:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrvwhZvvBfRFfFycU8y9ucEnUoyec2Q+jA8SwAPxI2w=;
        b=eee6SChB3hCmX9vfkYV+snZnqgIPqy5sII+q/IlJ6Gvc9Sffw7eSo+hli8FD7CXVMBuSjl
        e3Uu4VGPE0uS6LV05pEeVfESLaWnvhFf4P/an6SWBm/fU9j1NTkcUKDxrvnDeMVT0oMFz0
        rJ9u6uBCky/zUblh/6PqgcP3+3d4SGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrvwhZvvBfRFfFycU8y9ucEnUoyec2Q+jA8SwAPxI2w=;
        b=gijZEjS5CEvsYE5T4o2p+FfojrV6lrP0nAPgiC86egwJBX5P4KlTEUCoIQbBMUNQAmNYte
        +x5sfRQThQ+96UDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D8F813BD4;
        Tue, 23 Nov 2021 01:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2y0wA7pEnGEzdAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:32:42 +0000
Subject: [PATCH 18/19] lockd: use svc_set_num_threads() for thread start and
 stop
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097551.7284.17962677949356020078.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
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

Also set svc_module - just for consistency.

svc_prepare_thread is now only used where it is defined, so it can be
made static.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             |   56 ++++++--------------------------------------
 include/linux/sunrpc/svc.h |    2 --
 net/sunrpc/svc.c           |    3 +-
 3 files changed, 8 insertions(+), 53 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 1a7c11118b32..93f5a4f262f9 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -55,7 +55,6 @@ EXPORT_SYMBOL_GPL(nlmsvc_ops);
 static DEFINE_MUTEX(nlmsvc_mutex);
 static unsigned int		nlmsvc_users;
 static struct svc_serv		*nlmsvc_serv;
-static struct task_struct	*nlmsvc_task;
 unsigned long			nlmsvc_timeout;
 
 unsigned int lockd_net_id;
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
index d69e6108cb83..313dd3d1ef16 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -504,8 +504,6 @@ struct svc_serv *svc_create(struct svc_program *, unsigned int,
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


