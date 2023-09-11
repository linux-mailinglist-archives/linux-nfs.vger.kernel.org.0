Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C470279B4FD
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjIKWAg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240189AbjIKOiv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:38:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AADF2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:38:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FA8C433CD;
        Mon, 11 Sep 2023 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443126;
        bh=+uisxfuuF7ga+B7PwXgHQRUGSYQxX+FLxmcFeyesSpE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u+zfBkaPCMDsdOhv75UzB4dFvbYUL4VYZFE9ZdP8USUNmqsgnDtj5uUAqAJidTxSJ
         zqvU0pI5jSf/qI2TUcngpXmRMHWExx3H6/b0Asgo7Gtuns3FRgVZvNvsXeAGnhD29y
         ISxnFSsWMFPp7baSF+ehNLkjs2xYbx+hjINOiUKCFF2i09UtFlgVCtjZgzixePwYqG
         FcQeqWxnQfNcB2LghxtnhyawhvBpsDTrAmCQ1UTSZ0XE3tmBuZgk7HIA+CbnlrPHyC
         AW6q+ik4l27uaDChytGtBs1dwpBReBTIdOH4N4AjE99pWN2tvCxmxibV+DMGvibpqq
         jTHiic3/h6YVg==
Subject: [PATCH v1 02/17] SUNRPC: rename and refactor svc_get_next_xprt()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:38:45 -0400
Message-ID: <169444312549.4327.13852685907274221747.stgit@bazille.1015granger.net>
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

svc_get_next_xprt() does a lot more than just get an xprt.  It also
decides if it needs to sleep, depending not only on the availability of
xprts but also on the need to exit or handle external work.

So rename it to svc_rqst_wait_for_work() and only do the testing and
waiting.  Move all the waiting-related code out of svc_recv() into the
new svc_rqst_wait_for_work().

Move the dequeueing code out of svc_get_next_xprt() into svc_recv().

Previously svc_xprt_dequeue() would be called twice, once before waiting
and possibly once after.  Now instead rqst_should_sleep() is called
twice.  Once to decide if waiting is needed, and once to check against
after setting the task state do see if we might have missed a wakeup.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |   92 +++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 48 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 60759647fee4..835160da3ad4 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -722,51 +722,34 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
+static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 {
-	struct svc_pool		*pool = rqstp->rq_pool;
-
-	/* rq_xprt should be clear on entry */
-	WARN_ON_ONCE(rqstp->rq_xprt);
+	struct svc_pool *pool = rqstp->rq_pool;
 
-	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt)
-		goto out_found;
-
-	set_current_state(TASK_IDLE);
-	smp_mb__before_atomic();
-	clear_bit(SP_CONGESTED, &pool->sp_flags);
-	clear_bit(RQ_BUSY, &rqstp->rq_flags);
-	smp_mb__after_atomic();
-
-	if (likely(rqst_should_sleep(rqstp)))
-		schedule();
-	else
-		__set_current_state(TASK_RUNNING);
+	if (rqst_should_sleep(rqstp)) {
+		set_current_state(TASK_IDLE);
+		smp_mb__before_atomic();
+		clear_bit(SP_CONGESTED, &pool->sp_flags);
+		clear_bit(RQ_BUSY, &rqstp->rq_flags);
+		smp_mb__after_atomic();
+
+		/* Need to check should_sleep() again after
+		 * setting task state in case a wakeup happened
+		 * between testing and setting.
+		 */
+		if (rqst_should_sleep(rqstp)) {
+			schedule();
+		} else {
+			__set_current_state(TASK_RUNNING);
+			cond_resched();
+		}
 
+		set_bit(RQ_BUSY, &rqstp->rq_flags);
+		smp_mb__after_atomic();
+	} else {
+		cond_resched();
+	}
 	try_to_freeze();
-
-	set_bit(RQ_BUSY, &rqstp->rq_flags);
-	smp_mb__after_atomic();
-	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
-	rqstp->rq_xprt = svc_xprt_dequeue(pool);
-	if (rqstp->rq_xprt)
-		goto out_found;
-
-	if (kthread_should_stop())
-		return NULL;
-	return NULL;
-out_found:
-	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
-	/* Normally we will wait up to 5 seconds for any required
-	 * cache information to be provided.
-	 */
-	if (!test_bit(SP_CONGESTED, &pool->sp_flags))
-		rqstp->rq_chandle.thread_wait = 5*HZ;
-	else
-		rqstp->rq_chandle.thread_wait = 1*HZ;
-	trace_svc_xprt_dequeue(rqstp);
-	return rqstp->rq_xprt;
 }
 
 static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
@@ -858,20 +841,33 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
  */
 void svc_recv(struct svc_rqst *rqstp)
 {
-	struct svc_xprt		*xprt = NULL;
+	struct svc_pool *pool = rqstp->rq_pool;
 
 	if (!svc_alloc_arg(rqstp))
 		return;
 
-	try_to_freeze();
-	cond_resched();
+	svc_rqst_wait_for_work(rqstp);
+
+	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
+
 	if (kthread_should_stop())
-		goto out;
+		return;
+
+	rqstp->rq_xprt = svc_xprt_dequeue(pool);
+	if (rqstp->rq_xprt) {
+		struct svc_xprt *xprt = rqstp->rq_xprt;
+
+		/* Normally we will wait up to 5 seconds for any required
+		 * cache information to be provided.
+		 */
+		if (!test_bit(SP_CONGESTED, &pool->sp_flags))
+			rqstp->rq_chandle.thread_wait = 5 * HZ;
+		else
+			rqstp->rq_chandle.thread_wait = 1 * HZ;
 
-	xprt = svc_get_next_xprt(rqstp);
-	if (xprt)
+		trace_svc_xprt_dequeue(rqstp);
 		svc_handle_xprt(rqstp, xprt);
-out:
+	}
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 


