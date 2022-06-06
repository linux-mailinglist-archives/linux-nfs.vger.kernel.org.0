Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2503653E947
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiFFOvS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiFFOvQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 10:51:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1A16FEE3
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 07:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4E08614B2
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 14:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066C3C34115;
        Mon,  6 Jun 2022 14:51:14 +0000 (UTC)
Subject: [PATCH v2 07/15] SUNRPC: Refactor rpc_call_null_helper()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 06 Jun 2022 10:51:13 -0400
Message-ID: <165452707392.1496.12861225717405665289.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm about to add a use case that does not want RPC_TASK_NULLCREDS.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0ca86c92968f..ade83ee13bac 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2751,8 +2751,7 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		.rpc_op_cred = cred,
 		.callback_ops = ops ?: &rpc_null_ops,
 		.callback_data = data,
-		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
-			 RPC_TASK_NULLCREDS,
+		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
 	};
 
 	return rpc_run_task(&task_setup_data);
@@ -2760,7 +2759,8 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 
 struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *cred, int flags)
 {
-	return rpc_call_null_helper(clnt, NULL, cred, flags, NULL, NULL);
+	return rpc_call_null_helper(clnt, NULL, cred, flags | RPC_TASK_NULLCREDS,
+				    NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(rpc_call_null);
 
@@ -2860,9 +2860,11 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto success;
 	}
 
-	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
-			&rpc_cb_add_xprt_call_ops, data);
+	task = rpc_call_null_helper(clnt, xprt, NULL,
+				    RPC_TASK_ASYNC | RPC_TASK_NULLCREDS,
+				    &rpc_cb_add_xprt_call_ops, data);
 	data->xps->xps_nunique_destaddr_xprts++;
+
 	rpc_put_task(task);
 success:
 	return 1;
@@ -2903,7 +2905,8 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto out_err;
 
 	/* Test the connection */
-	task = rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
+	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_NULLCREDS,
+				    NULL, NULL);
 	if (IS_ERR(task)) {
 		status = PTR_ERR(task);
 		goto out_err;


