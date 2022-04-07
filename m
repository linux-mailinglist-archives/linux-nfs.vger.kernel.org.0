Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96A4F83E5
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbiDGPq5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbiDGPqh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 11:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89281C6EE8
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 08:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDB8761EC1
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A94C385A9
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346273;
        bh=BjRUl9xvDLy47XQuB0DZe/W57Oa4+dauIzR16hGbzfc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HhOib/X3kHKzYQExPiWMCycdjhRV24omFy65rADXtDTk+tc9T3xe57qjJ4l8JwOXK
         VMQfcmvqD5LHP/lkJHowaJIU9Qsvx76zBLaDeNEPSadkyWCAkJa9SfUeEbLBpxkH+k
         rKM0Ru8x8irTgT6+7DwN8aOWNsQ0uJN07lcOUTUtWrzzvRTnCyRJuzWtSj0PqZtKaB
         /Qchby9aCySMd+qW2cHy1cbrDETtYoQ6OspW+Ih4FyStnuSfjysmGVjiC3okSDJdWP
         w25QQY9YCBqQ23kMhkCfc0h8zo63Z1Pu6IzghvGenKsFkbAH54dFXLVjHMQ/uWtA0y
         8pQwZoMngzOfg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] SUNRPC: Handle allocation failure in rpc_new_task()
Date:   Thu,  7 Apr 2022 11:38:08 -0400
Message-Id: <20220407153809.1053261-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407153809.1053261-5-trondmy@kernel.org>
References: <20220407153809.1053261-1-trondmy@kernel.org>
 <20220407153809.1053261-2-trondmy@kernel.org>
 <20220407153809.1053261-3-trondmy@kernel.org>
 <20220407153809.1053261-4-trondmy@kernel.org>
 <20220407153809.1053261-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the call to rpc_alloc_task() fails, then ensure that the calldata is
released, and that rpc_run_task() and rpc_run_bc_task() bail out early.

Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c  | 7 +++++++
 net/sunrpc/sched.c | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6757b0fa5367..af0174d7ce5a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1127,6 +1127,8 @@ struct rpc_task *rpc_run_task(const struct rpc_task_setup *task_setup_data)
 	struct rpc_task *task;
 
 	task = rpc_new_task(task_setup_data);
+	if (IS_ERR(task))
+		return task;
 
 	if (!RPC_IS_ASYNC(task))
 		task->tk_flags |= RPC_TASK_CRED_NOREF;
@@ -1227,6 +1229,11 @@ struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req)
 	 * Create an rpc_task to send the data
 	 */
 	task = rpc_new_task(&task_setup_data);
+	if (IS_ERR(task)) {
+		xprt_free_bc_request(req);
+		return task;
+	}
+
 	xprt_init_bc_request(req, task);
 
 	task->tk_action = call_bc_encode;
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index b258b87a3ec2..7f70c1e608b7 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1128,6 +1128,11 @@ struct rpc_task *rpc_new_task(const struct rpc_task_setup *setup_data)
 
 	if (task == NULL) {
 		task = rpc_alloc_task();
+		if (task == NULL) {
+			rpc_release_calldata(setup_data->callback_ops,
+					     setup_data->callback_data);
+			return ERR_PTR(-ENOMEM);
+		}
 		flags = RPC_TASK_DYNAMIC;
 	}
 
-- 
2.35.1

