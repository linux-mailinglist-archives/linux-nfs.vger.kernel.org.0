Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A248780379
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 03:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357109AbjHRBqM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 21:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357104AbjHRBpw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 21:45:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933972723
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 18:45:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 550D421874;
        Fri, 18 Aug 2023 01:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692323146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wenzKYKy4l5SwtDmWkKmRPquhXdm1pp9r577v34WdIE=;
        b=QqTgmWiUPpy7TJMAe9Rbn4+0vuoutZvuo+6TptezRdocozIzm4gSkPtgFfkzYsHEbT1q1x
        36O259JaPTWW9f3nT7Ce2QEt29PHDqtrRCbOUQ9020V8XsvQcCgvK2nYaQH9rnwNQG5iE8
        e0DGBudy1yy/eFzC6Ax9BMFT+emvDxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692323146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wenzKYKy4l5SwtDmWkKmRPquhXdm1pp9r577v34WdIE=;
        b=E7xsNjCrvTZGarLBJ34nCwYhaSTbqWh+uKV8YOQLq23FN2OnTZD2GRJtPyEf0x/Ap2VemF
        8M3oAHNHvrloChDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13B691353E;
        Fri, 18 Aug 2023 01:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XbkHLkjN3mSKZAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 18 Aug 2023 01:45:44 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/7] SUNRPC: use lwq for sp_sockets - renamed to sp_xprts
Date:   Fri, 18 Aug 2023 11:45:09 +1000
Message-Id: <20230818014512.26880-5-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818014512.26880-1-neilb@suse.de>
References: <20230818014512.26880-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

lwq avoids using back pointers in lists, and uses less locking.
This introduces a new spinlock, but the other one will be removed in a
future patch.

For svc_clean_up_xprts(), we now dequeue the entire queue, walk it to
remove and process the xprts that need cleaning up, then re-enqueue the
remaining queue.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h      |  3 +-
 include/linux/sunrpc/svc_xprt.h |  2 +-
 net/sunrpc/svc.c                |  2 +-
 net/sunrpc/svc_xprt.c           | 57 ++++++++++-----------------------
 4 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dafa362b4fdd..8b2bd034a760 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -17,6 +17,7 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/svcauth.h>
+#include <linux/sunrpc/svc_lwq.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/pagevec.h>
@@ -34,7 +35,7 @@
 struct svc_pool {
 	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
 	spinlock_t		sp_lock;	/* protects all fields */
-	struct list_head	sp_sockets;	/* pending sockets */
+	struct lwq		sp_xprts;	/* pending transports */
 	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index fa55d12dc765..8e20cd60e2e7 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -54,7 +54,7 @@ struct svc_xprt {
 	const struct svc_xprt_ops *xpt_ops;
 	struct kref		xpt_ref;
 	struct list_head	xpt_list;
-	struct list_head	xpt_ready;
+	struct lwq_node		xpt_ready;
 	unsigned long		xpt_flags;
 
 	struct svc_serv		*xpt_server;	/* service for transport */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3267d740235e..63cddb8cb08d 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -508,7 +508,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 				i, serv->sv_name);
 
 		pool->sp_id = i;
-		INIT_LIST_HEAD(&pool->sp_sockets);
+		lwq_init(&pool->sp_xprts);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
 		init_llist_head(&pool->sp_idle_threads);
 		spin_lock_init(&pool->sp_lock);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 397ca12299a2..39843c064361 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -201,7 +201,6 @@ void svc_xprt_init(struct net *net, struct svc_xprt_class *xcl,
 	kref_init(&xprt->xpt_ref);
 	xprt->xpt_server = serv;
 	INIT_LIST_HEAD(&xprt->xpt_list);
-	INIT_LIST_HEAD(&xprt->xpt_ready);
 	INIT_LIST_HEAD(&xprt->xpt_deferred);
 	INIT_LIST_HEAD(&xprt->xpt_users);
 	mutex_init(&xprt->xpt_mutex);
@@ -472,9 +471,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	pool = svc_pool_for_cpu(xprt->xpt_server);
 
 	percpu_counter_inc(&pool->sp_sockets_queued);
-	spin_lock_bh(&pool->sp_lock);
-	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
-	spin_unlock_bh(&pool->sp_lock);
+	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
 
 	svc_pool_wake_idle_thread(pool);
 }
@@ -487,18 +484,9 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
 {
 	struct svc_xprt	*xprt = NULL;
 
-	if (list_empty(&pool->sp_sockets))
-		goto out;
-
-	spin_lock_bh(&pool->sp_lock);
-	if (likely(!list_empty(&pool->sp_sockets))) {
-		xprt = list_first_entry(&pool->sp_sockets,
-					struct svc_xprt, xpt_ready);
-		list_del_init(&xprt->xpt_ready);
+	xprt = lwq_dequeue(&pool->sp_xprts, struct svc_xprt, xpt_ready);
+	if (xprt)
 		svc_xprt_get(xprt);
-	}
-	spin_unlock_bh(&pool->sp_lock);
-out:
 	return xprt;
 }
 
@@ -708,7 +696,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 		return false;
 
 	/* was a socket queued? */
-	if (!list_empty(&pool->sp_sockets))
+	if (!lwq_empty(&pool->sp_xprts))
 		return false;
 
 	/* are we shutting down? */
@@ -1052,7 +1040,6 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 
 	spin_lock_bh(&serv->sv_lock);
 	list_del_init(&xprt->xpt_list);
-	WARN_ON_ONCE(!list_empty(&xprt->xpt_ready));
 	if (test_bit(XPT_TEMP, &xprt->xpt_flags))
 		serv->sv_tmpcnt--;
 	spin_unlock_bh(&serv->sv_lock);
@@ -1103,36 +1090,26 @@ static int svc_close_list(struct svc_serv *serv, struct list_head *xprt_list, st
 	return ret;
 }
 
-static struct svc_xprt *svc_dequeue_net(struct svc_serv *serv, struct net *net)
+static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
 {
-	struct svc_pool *pool;
 	struct svc_xprt *xprt;
-	struct svc_xprt *tmp;
 	int i;
 
 	for (i = 0; i < serv->sv_nrpools; i++) {
-		pool = &serv->sv_pools[i];
-
-		spin_lock_bh(&pool->sp_lock);
-		list_for_each_entry_safe(xprt, tmp, &pool->sp_sockets, xpt_ready) {
-			if (xprt->xpt_net != net)
-				continue;
-			list_del_init(&xprt->xpt_ready);
-			spin_unlock_bh(&pool->sp_lock);
-			return xprt;
+		struct svc_pool *pool = &serv->sv_pools[i];
+		struct llist_node *q, **t1, *t2;
+
+		q = lwq_dequeue_all(&pool->sp_xprts);
+		lwq_for_each_safe(xprt, t1, t2, &q, xpt_ready) {
+			if (xprt->xpt_net == net) {
+				set_bit(XPT_CLOSE, &xprt->xpt_flags);
+				svc_delete_xprt(xprt);
+				xprt = NULL;
+			}
 		}
-		spin_unlock_bh(&pool->sp_lock);
-	}
-	return NULL;
-}
 
-static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
-{
-	struct svc_xprt *xprt;
-
-	while ((xprt = svc_dequeue_net(serv, net))) {
-		set_bit(XPT_CLOSE, &xprt->xpt_flags);
-		svc_delete_xprt(xprt);
+		if (q)
+			lwq_enqueue_batch(q, &pool->sp_xprts);
 	}
 }
 
-- 
2.40.1

