Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4278A515281
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351647AbiD2RqD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379774AbiD2Rp6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 13:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E9CFE70
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 10:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C6F16241E
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 17:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CE5C385B2;
        Fri, 29 Apr 2022 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254156;
        bh=2ZzLX/nSMo3VhPl7kFlY98cwt8OokcpFyhsV9jwdx+U=;
        h=From:To:Cc:Subject:Date:From;
        b=eNc5a+1k36A/4Ip8W6MGCNa+OLAfC5wDam75QNcSwnw7kCINjMQh3FVwEGx/+dXyP
         nqNx7Wli1GdmBsboKLfqoDr8NZ+V3o+Y89aRO+SLdV2LejRs5RRF7oscM0aZ5V5lXD
         TNnUfSKRApEQcEUZSqB08kNHYhBzee8E2xb34P1N/beHAirrUCwKNN2xgLz97tHXEb
         xSbzy5yqR+bTQlgwAdJxG/DGvW4+E2I1qFcoxZTQjabRt3V6Q2k+F4kWGObcZym1BB
         bvos4OYLMu9Uptlx8Hr9SXn74WTyxp9laiCULs+F30v88fwUnQ6wBPa6Bkl2BCsazL
         +OPcl2RbOVq2w==
From:   trondmy@kernel.org
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/4] SUNRPC: Don't leak sockets in xs_local_connect()
Date:   Fri, 29 Apr 2022 13:36:26 -0400
Message-Id: <20220429173629.621418-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If there is still a closed socket associated with the transport, then we
need to trigger an autoclose before we can set up a new connection.

Reported-by: wanghai (M) <wanghai38@huawei.com>
Fixes: f00432063db1 ("SUNRPC: Ensure we flush any closed sockets before xs_xprt_free()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 8ab64ea46870..f9849b297ea3 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1950,6 +1950,9 @@ static void xs_local_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	int ret;
 
+	if (transport->file)
+		goto force_disconnect;
+
 	if (RPC_IS_ASYNC(task)) {
 		/*
 		 * We want the AF_LOCAL connect to be resolved in the
@@ -1962,11 +1965,17 @@ static void xs_local_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		 */
 		task->tk_rpc_status = -ENOTCONN;
 		rpc_exit(task, -ENOTCONN);
-		return;
+		goto out_wake;
 	}
 	ret = xs_local_setup_socket(transport);
 	if (ret && !RPC_IS_SOFTCONN(task))
 		msleep_interruptible(15000);
+	return;
+force_disconnect:
+	xprt_force_disconnect(xprt);
+out_wake:
+	xprt_clear_connecting(xprt);
+	xprt_wake_pending_tasks(xprt, -ENOTCONN);
 }
 
 #if IS_ENABLED(CONFIG_SUNRPC_SWAP)
-- 
2.35.1

