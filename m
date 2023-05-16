Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212DF70579C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjEPTlm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEPTli (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DFEA24D
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 746896384D
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 19:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693FBC433D2;
        Tue, 16 May 2023 19:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266024;
        bh=Em+RUhQS64qOMbbxIjjKT8mDD8wE96EFptksd2uLtn0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k3bYkOzx9+8K1L1JZ+g2R40iMmU5s6vvqmhNeahV6UAPG+plor5Bx2iHw/zGExLuG
         xhxnhArO5NhjOshdlUSfrNn4koRv0FclYLoXgCfr9unEk1AU7JN1DGfV+ZxaRLBC89
         zchh0pdBHPY+gEZszQ+iwyMUsU2KmfbRFmadam8vDjCBQ+WDgBJPsd/8hR8HdouxMY
         xxqVWX2m6qCPuvChbwKktBxX1yeMsHykQSSLhRkdDmgUVnEG36LujkMWqdd7bH3igB
         7I7Lyy1ozpjuhR1wh0mngctVzOzIWGX/QuMoFXqJIS7Xzbrmpt7fwgcrZPHdhcPB/Y
         BRu598AkdDGXA==
Subject: [PATCH RFC 04/12] SUNRPC: Refactor rpc_call_null_helper()
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 16 May 2023 15:40:13 -0400
Message-ID: <168426600329.74246.10545150506762914826.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to add a use case that does not want RPC_TASK_NULLCREDS.
Refactor rpc_call_null_helper() so that callers provide NULLCREDS
when they need it.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 4cdb539b5854..2dca0ae489ec 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2811,8 +2811,7 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		.rpc_op_cred = cred,
 		.callback_ops = ops ?: &rpc_null_ops,
 		.callback_data = data,
-		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
-			 RPC_TASK_NULLCREDS,
+		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
 	};
 
 	return rpc_run_task(&task_setup_data);
@@ -2820,7 +2819,8 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 
 struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *cred, int flags)
 {
-	return rpc_call_null_helper(clnt, NULL, cred, flags, NULL, NULL);
+	return rpc_call_null_helper(clnt, NULL, cred, flags | RPC_TASK_NULLCREDS,
+				    NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(rpc_call_null);
 
@@ -2920,12 +2920,13 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto success;
 	}
 
-	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
-			&rpc_cb_add_xprt_call_ops, data);
+	task = rpc_call_null_helper(clnt, xprt, NULL,
+				    RPC_TASK_ASYNC | RPC_TASK_NULLCREDS,
+				    &rpc_cb_add_xprt_call_ops, data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
-
 	data->xps->xps_nunique_destaddr_xprts++;
+
 	rpc_put_task(task);
 success:
 	return 1;
@@ -2940,7 +2941,8 @@ static int rpc_clnt_add_xprt_helper(struct rpc_clnt *clnt,
 	int status = -EADDRINUSE;
 
 	/* Test the connection */
-	task = rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
+	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_NULLCREDS,
+				    NULL, NULL);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 


