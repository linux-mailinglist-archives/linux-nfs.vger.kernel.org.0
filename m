Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3221978D249
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjH3C7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbjH3C7B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:59:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DE3185
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDE21211E2;
        Wed, 30 Aug 2023 02:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7u/9LoXbnHKQTbn+5IfntA6WpU7iCnvel9gZ/zvF8aY=;
        b=P35rDTIIMYHLQuJ6gZGLsbhL/GkSQLpMPRNkLpyOIYVDcXsAxGyKdSxXggKI1ArM+RwvYc
        iDczgsIIwyoFDTFWe+t7HdEEDHWiWIl3q50hMP9LvJeJbMLVRt0ZcZJrQM5gJKIwnui403
        DksC9PqcGTmPbkCdL4O/s/mNqMFAm+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7u/9LoXbnHKQTbn+5IfntA6WpU7iCnvel9gZ/zvF8aY=;
        b=bMqh0yIUP1rcyGFrtL6IxZrB9kJEb91GcFEoJTBc6f0dQg+9OHapGm0DL14lqKqNhRs/ie
        h2KdyOtXTpTSQMCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81FAD13301;
        Wed, 30 Aug 2023 02:58:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +4KKDXCw7mQnZAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:56 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/10] SUNRPC: discard sp_lock
Date:   Wed, 30 Aug 2023 12:54:52 +1000
Message-ID: <20230830025755.21292-10-neilb@suse.de>
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

sp_lock is now only used to protect sp_all_threads.  This isn't needed
as sp_all_threads is only manipulated through svc_set_num_threads(),
which must be locked.  Read-acccess only requires rcu_read_lock().  So
no more locking is needed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h |  1 -
 net/sunrpc/svc.c           | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 9d0fcd6148ae..8ce1392c1a35 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -34,7 +34,6 @@
  */
 struct svc_pool {
 	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
-	spinlock_t		sp_lock;	/* protects all fields */
 	struct lwq		sp_xprts;	/* pending transports */
 	atomic_t		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9524af33ace9..61ea8ce7975f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -511,7 +511,6 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		lwq_init(&pool->sp_xprts);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
 		init_llist_head(&pool->sp_idle_threads);
-		spin_lock_init(&pool->sp_lock);
 
 		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
@@ -682,9 +681,12 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	spin_unlock_bh(&serv->sv_lock);
 
 	atomic_inc(&pool->sp_nrthreads);
-	spin_lock_bh(&pool->sp_lock);
+
+	/* Protected by whatever lock the service uses when calling
+	 * svc_set_num_threads()
+	 */
 	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
-	spin_unlock_bh(&pool->sp_lock);
+
 	return rqstp;
 }
 
@@ -922,9 +924,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
 	struct svc_serv	*serv = rqstp->rq_server;
 	struct svc_pool	*pool = rqstp->rq_pool;
 
-	spin_lock_bh(&pool->sp_lock);
 	list_del_rcu(&rqstp->rq_all);
-	spin_unlock_bh(&pool->sp_lock);
 
 	atomic_dec(&pool->sp_nrthreads);
 
-- 
2.41.0

