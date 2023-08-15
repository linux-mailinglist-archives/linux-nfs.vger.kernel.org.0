Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DBB77C579
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 03:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjHOBzL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 21:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjHOBy7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 21:54:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC3DD
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 18:54:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BAF2D2190B;
        Tue, 15 Aug 2023 01:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692064497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAeK2Emtzs2wegTouX+XwAhhjFi3WHvYkRok37VTcNI=;
        b=wxcYHXdee5Kv8HMTbqGlY1jxRLKVoE7STCwMqBjGgINI+w+IImt5Zy73oC3BAQwBxAmT1M
        LkngzIrj6klG4OpMLenDkByfM7dWBve+cgBP6TSasuXMUbmJ7JOdSIvlRjQ9kNrwjUJJLM
        +pnTqrSDq7KGY+Qsmf0M1aPEaStBqDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692064497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAeK2Emtzs2wegTouX+XwAhhjFi3WHvYkRok37VTcNI=;
        b=2fpUbX7sNN3HZY8YY3Xw0EQ/zOpLpYbFz+xt0M2ij64swRfF0BWoGoDyQMPwQGu1YZz4b8
        GdvHPRYlQyOU+RDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81CC51353E;
        Tue, 15 Aug 2023 01:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s5a2DfDa2mS9CgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Aug 2023 01:54:56 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/10] SUNRPC: discard SP_CONGESTED
Date:   Tue, 15 Aug 2023 11:54:19 +1000
Message-Id: <20230815015426.5091-4-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230815015426.5091-1-neilb@suse.de>
References: <20230815015426.5091-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We can tell if a pool is congested by checking if the idle list is
empty.  We don't need a separate flag.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h | 1 -
 net/sunrpc/svc.c           | 1 -
 net/sunrpc/svc_xprt.c      | 4 +---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e9c34e99bc88..22b3018ebf62 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -50,7 +50,6 @@ struct svc_pool {
 /* bits for sp_flags */
 enum {
 	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
-	SP_CONGESTED,		/* all threads are busy, none idle */
 	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
 	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
 };
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ffcc5371527c..051f08c48418 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -719,7 +719,6 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 	}
 	rcu_read_unlock();
 
-	set_bit(SP_CONGESTED, &pool->sp_flags);
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ebfeeb504a79..fa0d854a5596 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -735,8 +735,6 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 
 	if (rqst_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE);
-		smp_mb__before_atomic();
-		clear_bit(SP_CONGESTED, &pool->sp_flags);
 		spin_lock_bh(&pool->sp_lock);
 		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
 		spin_unlock_bh(&pool->sp_lock);
@@ -874,7 +872,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		/* Normally we will wait up to 5 seconds for any required
 		 * cache information to be provided.
 		 */
-		if (!test_bit(SP_CONGESTED, &pool->sp_flags))
+		if (!list_empty(&pool->sp_idle_threads))
 			rqstp->rq_chandle.thread_wait = 5 * HZ;
 		else
 			rqstp->rq_chandle.thread_wait = 1 * HZ;
-- 
2.40.1

