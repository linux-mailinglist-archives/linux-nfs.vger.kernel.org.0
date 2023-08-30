Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F01178D246
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbjH3C7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbjH3C64 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:58:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23567193
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA559211E2;
        Wed, 30 Aug 2023 02:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=put9AXxrcv+eoyJ+SDrIafBWhaHUsLY7x9zPi5RlRNA=;
        b=yOQCMKKUV9RyGzP5q7mqD+xggwwkj2mcvny5pcjQbDWKUvn7ZP9gB0A+beagYdoxhh6s4L
        rJ5mAEfRmdrmzzJG+b0ZLj0d598ZFtMGM/HZJlsKpMr8eOxYgztP8+uYrRuUrU0NvR8bXr
        wcao79OS8XusrLv0saCPDzoyIqZLQW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=put9AXxrcv+eoyJ+SDrIafBWhaHUsLY7x9zPi5RlRNA=;
        b=YEGyXhh/WsKnr6jI6KWVYtLaQXklSAkkXZwL8MIYHmFVn6TKfmzJI6ZOYJ8CTU0yEHjL6W
        Mj9YxtmlhUYUZ/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B9E013301;
        Wed, 30 Aug 2023 02:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k3qZE2uw7mQfZAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:51 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/10] SUNRPC: change sp_nrthreads to atomic_t
Date:   Wed, 30 Aug 2023 12:54:51 +1000
Message-ID: <20230830025755.21292-9-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830025755.21292-1-neilb@suse.de>
References: <20230830025755.21292-1-neilb@suse.de>
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

Using an atomic_t avoids the need to take a spinlock (which can soon be
removed).

Choosing a thread to kill needs to be careful as we cannot set the "die
now" bit atomically with the test on the count.  Instead we temporarily
increase the count.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c           |  3 ++-
 include/linux/sunrpc/svc.h |  2 +-
 net/sunrpc/svc.c           | 37 ++++++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 062f51fe4dfb..5e455ced0711 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -718,7 +718,8 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 
 	if (nn->nfsd_serv != NULL) {
 		for (i = 0; i < nn->nfsd_serv->sv_nrpools && i < n; i++)
-			nthreads[i] = nn->nfsd_serv->sv_pools[i].sp_nrthreads;
+			nthreads[i] =
+				atomic_read(&nn->nfsd_serv->sv_pools[i].sp_nrthreads);
 	}
 
 	return 0;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 7ff9fe785e49..9d0fcd6148ae 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -36,7 +36,7 @@ struct svc_pool {
 	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
 	spinlock_t		sp_lock;	/* protects all fields */
 	struct lwq		sp_xprts;	/* pending transports */
-	unsigned int		sp_nrthreads;	/* # of threads in pool */
+	atomic_t		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 63cddb8cb08d..9524af33ace9 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -681,8 +681,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	serv->sv_nrthreads += 1;
 	spin_unlock_bh(&serv->sv_lock);
 
+	atomic_inc(&pool->sp_nrthreads);
 	spin_lock_bh(&pool->sp_lock);
-	pool->sp_nrthreads++;
 	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
 	spin_unlock_bh(&pool->sp_lock);
 	return rqstp;
@@ -727,23 +727,24 @@ svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
 }
 
 static struct svc_pool *
-svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
+svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
+		unsigned int *state)
 {
+	struct svc_pool *pool;
 	unsigned int i;
 
+retry:
+	pool = target_pool;
+
 	if (pool != NULL) {
-		spin_lock_bh(&pool->sp_lock);
-		if (pool->sp_nrthreads)
+		if (atomic_inc_not_zero(&pool->sp_nrthreads))
 			goto found_pool;
-		spin_unlock_bh(&pool->sp_lock);
 		return NULL;
 	} else {
 		for (i = 0; i < serv->sv_nrpools; i++) {
 			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
-			spin_lock_bh(&pool->sp_lock);
-			if (pool->sp_nrthreads)
+			if (atomic_inc_not_zero(&pool->sp_nrthreads))
 				goto found_pool;
-			spin_unlock_bh(&pool->sp_lock);
 		}
 		return NULL;
 	}
@@ -751,8 +752,12 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *stat
 found_pool:
 	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
 	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
-	spin_unlock_bh(&pool->sp_lock);
-	return pool;
+	if (!atomic_dec_and_test(&pool->sp_nrthreads))
+		return pool;
+	/* Nothing left in this pool any more */
+	clear_bit(SP_NEED_VICTIM, &pool->sp_flags);
+	clear_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
+	goto retry;
 }
 
 static int
@@ -828,13 +833,10 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 int
 svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
-	if (pool == NULL) {
+	if (!pool)
 		nrservs -= serv->sv_nrthreads;
-	} else {
-		spin_lock_bh(&pool->sp_lock);
-		nrservs -= pool->sp_nrthreads;
-		spin_unlock_bh(&pool->sp_lock);
-	}
+	else
+		nrservs -= atomic_read(&pool->sp_nrthreads);
 
 	if (nrservs > 0)
 		return svc_start_kthreads(serv, pool, nrservs);
@@ -921,10 +923,11 @@ svc_exit_thread(struct svc_rqst *rqstp)
 	struct svc_pool	*pool = rqstp->rq_pool;
 
 	spin_lock_bh(&pool->sp_lock);
-	pool->sp_nrthreads--;
 	list_del_rcu(&rqstp->rq_all);
 	spin_unlock_bh(&pool->sp_lock);
 
+	atomic_dec(&pool->sp_nrthreads);
+
 	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads -= 1;
 	spin_unlock_bh(&serv->sv_lock);
-- 
2.41.0

