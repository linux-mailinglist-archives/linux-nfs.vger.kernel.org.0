Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C6579B34E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbjIKV7I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbjIKOjX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:39:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C2E40
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:39:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C5EC433CA;
        Mon, 11 Sep 2023 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443158;
        bh=7n8JxgnZwqTBpwt8URGd10ecBDcAmWgn8cXyhU14N4A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Of90ynH+ScqIKYoGYShFerTX7yxZJLo0tkDui57+Ti0UhC9+mC4TPX5uOVtteBErB
         RZgV6lFs7M1wkScQHg43ZW28kl5GmSHscBv8ULdX2Cb+FpQn4UvA372+h62apCRQXV
         Y6CDj0XMrKsJbP5VaEEOtHPbNAixZUx/R1bGEjKxgOwpxULXVXWG0wBpquoUzS0BcR
         CLs13ccvWuYrrgPZsD8aMBYGj9SgO+BYMpRxP7dBxUANF47UCJ6qgC58VBL8efYOkZ
         6SDs5FxT/WiRo2q2xd1B3Pb8GEjokIZjgjTv68i7UDUjmL2cVvd7nEmAL2nZdSTW/T
         U7Podp2y8mSaw==
Subject: [PATCH v1 07/17] SUNRPC: discard SP_CONGESTED
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:39:17 -0400
Message-ID: <169444315770.4327.17155064072194396832.stgit@bazille.1015granger.net>
In-Reply-To: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neilb@suse.de>

We can tell if a pool is congested by checking if the idle list is
empty.  We don't need a separate flag.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    1 -
 net/sunrpc/svc.c           |    1 -
 net/sunrpc/svc_xprt.c      |    4 +---
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
index 9d080fe2dcdf..db4674211f36 100644
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


