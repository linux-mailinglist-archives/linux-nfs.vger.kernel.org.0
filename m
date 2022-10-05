Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D975F5AC8
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 22:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJEUE3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJEUE2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 16:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDB27CDF
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 13:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1BAD617AB
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 20:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0013C433D7;
        Wed,  5 Oct 2022 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665000266;
        bh=TCTbkROKxcuP5AbC6z8PIzfDcQY/k38E4qt0CvQilXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqO5aDqVQ9qRXnHcwyY9R+VaKd8BjxAPq1E9y6piHTMYgnKGdaPYT+X1XXI2hRw0U
         PwPo45SNc1X4AUEyU/JoHLuzMF0Db6Uh6y/GJdVWxl4/reTo/mlQ4CG8uD38enJ6xb
         RR4cqnnhRUVKDeZLW4KFrwB2QjicYWylm4W4xjd5ea+ubNin1v/hFyBsm/8H5Fh4zf
         9BVIlM5PJNdsq9dKaRff4T2OOd9wh5muSkshUqTSPOIrm3IPS77MFBn1qYyXxzHIsq
         y4u3Dzpv3e5vpHEZqzgXeabR/O5zZZWxEcbT5VCrfk8IwEtZr9FEmwM9wuIJiSer6r
         lByzIqrPnqJhA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] SUNRPC: Add a helper to allow pNFS drivers to selectively cancel RPC calls
Date:   Wed,  5 Oct 2022 15:57:36 -0400
Message-Id: <20221005195738.4552-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005195738.4552-2-trondmy@kernel.org>
References: <20221005195738.4552-1-trondmy@kernel.org>
 <20221005195738.4552-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add the helper rpc_cancel_tasks(), which uses a caller-defined selection
function to define a set of in-flight RPC calls to cancel. This is
mainly intended for pNFS drivers which are subject to a layout recall,
and which may therefore want to cancel all pending I/O using that layout
in order to redrive it after the layout recall has been satisfied.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/sched.h |  5 +++++
 net/sunrpc/clnt.c            | 37 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/sched.c           | 11 +++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 647247040ef9..cdcf0fe56a6f 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -210,11 +210,16 @@ struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req);
 void		rpc_put_task(struct rpc_task *);
 void		rpc_put_task_async(struct rpc_task *);
 bool		rpc_task_set_rpc_status(struct rpc_task *task, int rpc_status);
+void		rpc_task_try_cancel(struct rpc_task *task, int error);
 void		rpc_signal_task(struct rpc_task *);
 void		rpc_exit_task(struct rpc_task *);
 void		rpc_exit(struct rpc_task *, int);
 void		rpc_release_calldata(const struct rpc_call_ops *, void *);
 void		rpc_killall_tasks(struct rpc_clnt *);
+unsigned long	rpc_cancel_tasks(struct rpc_clnt *clnt, int error,
+				 bool (*fnmatch)(const struct rpc_task *,
+						 const void *),
+				 const void *data);
 void		rpc_execute(struct rpc_task *);
 void		rpc_init_priority_wait_queue(struct rpc_wait_queue *, const char *);
 void		rpc_init_wait_queue(struct rpc_wait_queue *, const char *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 77a44118c0da..3bee30cf8a7d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -873,6 +873,43 @@ void rpc_killall_tasks(struct rpc_clnt *clnt)
 }
 EXPORT_SYMBOL_GPL(rpc_killall_tasks);
 
+/**
+ * rpc_cancel_tasks - try to cancel a set of RPC tasks
+ * @clnt: Pointer to RPC client
+ * @error: RPC task error value to set
+ * @fnmatch: Pointer to selector function
+ * @data: User data
+ *
+ * Uses @fnmatch to define a set of RPC tasks that are to be cancelled.
+ * The argument @error must be a negative error value.
+ */
+unsigned long rpc_cancel_tasks(struct rpc_clnt *clnt, int error,
+			       bool (*fnmatch)(const struct rpc_task *,
+					       const void *),
+			       const void *data)
+{
+	struct rpc_task *task;
+	unsigned long count = 0;
+
+	if (list_empty(&clnt->cl_tasks))
+		return 0;
+	/*
+	 * Spin lock all_tasks to prevent changes...
+	 */
+	spin_lock(&clnt->cl_lock);
+	list_for_each_entry(task, &clnt->cl_tasks, tk_task) {
+		if (!RPC_IS_ACTIVATED(task))
+			continue;
+		if (!fnmatch(task, data))
+			continue;
+		rpc_task_try_cancel(task, error);
+		count++;
+	}
+	spin_unlock(&clnt->cl_lock);
+	return count;
+}
+EXPORT_SYMBOL_GPL(rpc_cancel_tasks);
+
 /*
  * Properly shut down an RPC client, terminating all outstanding
  * requests.
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index f388bfaf6ff0..de912e02371b 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -872,6 +872,17 @@ void rpc_signal_task(struct rpc_task *task)
 		rpc_wake_up_queued_task(queue, task);
 }
 
+void rpc_task_try_cancel(struct rpc_task *task, int error)
+{
+	struct rpc_wait_queue *queue;
+
+	if (!rpc_task_set_rpc_status(task, error))
+		return;
+	queue = READ_ONCE(task->tk_waitqueue);
+	if (queue)
+		rpc_wake_up_queued_task(queue, task);
+}
+
 void rpc_exit(struct rpc_task *task, int status)
 {
 	task->tk_status = status;
-- 
2.37.3

