Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF86A9714
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 13:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjCCMQN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 07:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCCMQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 07:16:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06975F6C8
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 04:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A672EB816AA
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 12:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC1FC433A0;
        Fri,  3 Mar 2023 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845768;
        bh=fJVb2Xj/IYX7J9YYAIEfeYWjwgF+6tCASAHJ7nq33SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcjJyL+Nb0jOBqjR6Nc1CbiCEwgaE/lozR+0c0XB/PiYgwOkITG7eQdzMTitQPsfy
         JRcbtNKsDzdTQgQ+Lvl4fYjgg2zvdLTvxpCeQgpVODoZT5vF8J6cqx2JckOXJFJgGf
         6VrjityWpp3D8H27mlcUGIlInpP1SR/9fsZk91WdG1fpJKma8CChRNGgUdGG3P7mLg
         eftV2NKs8Y0h1/2wPT/Jh/HtYUEvTnyOFRvDwnFCy7YtEadgGvtieLtHv2RDYYKbha
         aYlIpY4hPFYDHCUIfs9OVxNx/hiVoP5Y5HRTrm0+EY1L3YXD99VEduY3L8Zr1IGn38
         Lt6e+1ukR9v2A==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, yoyang@redhat.com
Subject: [PATCH 4/7] lockd: fix races in client GRANTED_MSG wait logic
Date:   Fri,  3 Mar 2023 07:16:00 -0500
Message-Id: <20230303121603.132103-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303121603.132103-1-jlayton@kernel.org>
References: <20230303121603.132103-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After the wait for a grant is done (for whatever reason), nlmclnt_block
updates the status of the nlm_rqst with the status of the block. At the
point it does this, however, the block is still queued its status could
change at any time.

This is particularly a problem when the waiting task is signaled during
the wait. We can end up giving up on the lock just before the GRANTED_MSG
callback comes in, and accept it even though the lock request gets back
an error, leaving a dangling lock on the server.

Since the nlm_wait never lives beyond the end of nlmclnt_lock, put it on
the stack and add functions to allow us to enqueue and dequeue the
block. Enqueue it just before the lock/wait loop, and dequeue it
just after we exit the loop instead of waiting until the end of
the function. Also, scrape the status at the time that we dequeue it to
ensure that it's final.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2063818
Reported-by: Yongcheng Yang <yoyang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/clntlock.c         | 42 ++++++++++++++++++-------------------
 fs/lockd/clntproc.c         | 28 ++++++++++++++++---------
 include/linux/lockd/lockd.h |  8 ++++---
 3 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index 464cb15c1a06..c374ee072db3 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -82,41 +82,42 @@ void nlmclnt_done(struct nlm_host *host)
 }
 EXPORT_SYMBOL_GPL(nlmclnt_done);
 
+void nlmclnt_prepare_block(struct nlm_wait *block, struct nlm_host *host, struct file_lock *fl)
+{
+	block->b_host = host;
+	block->b_lock = fl;
+	init_waitqueue_head(&block->b_wait);
+	block->b_status = nlm_lck_blocked;
+}
+
 /*
  * Queue up a lock for blocking so that the GRANTED request can see it
  */
-struct nlm_wait *nlmclnt_prepare_block(struct nlm_host *host, struct file_lock *fl)
+void nlmclnt_queue_block(struct nlm_wait *block)
 {
-	struct nlm_wait *block;
-
-	block = kmalloc(sizeof(*block), GFP_KERNEL);
-	if (block != NULL) {
-		block->b_host = host;
-		block->b_lock = fl;
-		init_waitqueue_head(&block->b_wait);
-		block->b_status = nlm_lck_blocked;
-
-		spin_lock(&nlm_blocked_lock);
-		list_add(&block->b_list, &nlm_blocked);
-		spin_unlock(&nlm_blocked_lock);
-	}
-	return block;
+	spin_lock(&nlm_blocked_lock);
+	list_add(&block->b_list, &nlm_blocked);
+	spin_unlock(&nlm_blocked_lock);
 }
 
-void nlmclnt_finish_block(struct nlm_wait *block)
+/*
+ * Dequeue the block and return its final status
+ */
+__be32 nlmclnt_dequeue_block(struct nlm_wait *block)
 {
-	if (block == NULL)
-		return;
+	__be32 status;
+
 	spin_lock(&nlm_blocked_lock);
 	list_del(&block->b_list);
+	status = block->b_status;
 	spin_unlock(&nlm_blocked_lock);
-	kfree(block);
+	return status;
 }
 
 /*
  * Block on a lock
  */
-int nlmclnt_block(struct nlm_wait *block, struct nlm_rqst *req, long timeout)
+int nlmclnt_wait(struct nlm_wait *block, struct nlm_rqst *req, long timeout)
 {
 	long ret;
 
@@ -142,7 +143,6 @@ int nlmclnt_block(struct nlm_wait *block, struct nlm_rqst *req, long timeout)
 	/* Reset the lock status after a server reboot so we resend */
 	if (block->b_status == nlm_lck_denied_grace_period)
 		block->b_status = nlm_lck_blocked;
-	req->a_res.status = block->b_status;
 	return 0;
 }
 
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 16b4de868cd2..a14c9110719c 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -516,9 +516,10 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	const struct cred *cred = nfs_file_cred(fl->fl_file);
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
-	struct nlm_wait *block = NULL;
+	struct nlm_wait block;
 	unsigned char fl_flags = fl->fl_flags;
 	unsigned char fl_type;
+	__be32 b_status;
 	int status = -ENOLCK;
 
 	if (nsm_monitor(host) < 0)
@@ -531,31 +532,41 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	if (status < 0)
 		goto out;
 
-	block = nlmclnt_prepare_block(host, fl);
+	nlmclnt_prepare_block(&block, host, fl);
 again:
 	/*
 	 * Initialise resp->status to a valid non-zero value,
 	 * since 0 == nlm_lck_granted
 	 */
 	resp->status = nlm_lck_blocked;
-	for(;;) {
+
+	/*
+	 * A GRANTED callback can come at any time -- even before the reply
+	 * to the LOCK request arrives, so we queue the wait before
+	 * requesting the lock.
+	 */
+	nlmclnt_queue_block(&block);
+	for (;;) {
 		/* Reboot protection */
 		fl->fl_u.nfs_fl.state = host->h_state;
 		status = nlmclnt_call(cred, req, NLMPROC_LOCK);
 		if (status < 0)
 			break;
 		/* Did a reclaimer thread notify us of a server reboot? */
-		if (resp->status ==  nlm_lck_denied_grace_period)
+		if (resp->status == nlm_lck_denied_grace_period)
 			continue;
 		if (resp->status != nlm_lck_blocked)
 			break;
 		/* Wait on an NLM blocking lock */
-		status = nlmclnt_block(block, req, NLMCLNT_POLL_TIMEOUT);
+		status = nlmclnt_wait(&block, req, NLMCLNT_POLL_TIMEOUT);
 		if (status < 0)
 			break;
-		if (resp->status != nlm_lck_blocked)
+		if (block.b_status != nlm_lck_blocked)
 			break;
 	}
+	b_status = nlmclnt_dequeue_block(&block);
+	if (resp->status == nlm_lck_blocked)
+		resp->status = b_status;
 
 	/* if we were interrupted while blocking, then cancel the lock request
 	 * and exit
@@ -564,7 +575,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 		if (!req->a_args.block)
 			goto out_unlock;
 		if (nlmclnt_cancel(host, req->a_args.block, fl) == 0)
-			goto out_unblock;
+			goto out;
 	}
 
 	if (resp->status == nlm_granted) {
@@ -593,8 +604,6 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 		status = -ENOLCK;
 	else
 		status = nlm_stat_to_errno(resp->status);
-out_unblock:
-	nlmclnt_finish_block(block);
 out:
 	nlmclnt_release_call(req);
 	return status;
@@ -602,7 +611,6 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	/* Fatal error: ensure that we remove the lock altogether */
 	dprintk("lockd: lock attempt ended in fatal error.\n"
 		"       Attempting to unlock.\n");
-	nlmclnt_finish_block(block);
 	fl_type = fl->fl_type;
 	fl->fl_type = F_UNLCK;
 	down_read(&host->h_rwsem);
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 0eec760fcc05..7452fb88ecd4 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -211,9 +211,11 @@ struct nlm_rqst * nlm_alloc_call(struct nlm_host *host);
 int		  nlm_async_call(struct nlm_rqst *, u32, const struct rpc_call_ops *);
 int		  nlm_async_reply(struct nlm_rqst *, u32, const struct rpc_call_ops *);
 void		  nlmclnt_release_call(struct nlm_rqst *);
-struct nlm_wait * nlmclnt_prepare_block(struct nlm_host *host, struct file_lock *fl);
-void		  nlmclnt_finish_block(struct nlm_wait *block);
-int		  nlmclnt_block(struct nlm_wait *block, struct nlm_rqst *req, long timeout);
+void		  nlmclnt_prepare_block(struct nlm_wait *block, struct nlm_host *host,
+					struct file_lock *fl);
+void		  nlmclnt_queue_block(struct nlm_wait *block);
+__be32		  nlmclnt_dequeue_block(struct nlm_wait *block);
+int		  nlmclnt_wait(struct nlm_wait *block, struct nlm_rqst *req, long timeout);
 __be32		  nlmclnt_grant(const struct sockaddr *addr,
 				const struct nlm_lock *lock);
 void		  nlmclnt_recovery(struct nlm_host *);
-- 
2.39.2

