Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59A751387C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiD1Pj0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiD1PjY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 11:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FB7496A3
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 08:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2618E61EA4
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 15:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C24BC385A9;
        Thu, 28 Apr 2022 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651160168;
        bh=2ZzLX/nSMo3VhPl7kFlY98cwt8OokcpFyhsV9jwdx+U=;
        h=From:To:Subject:Date:From;
        b=sqKLQYrsClZpzqzDM9d73/JGFuqP03+6f8PK//i5VTPjdKsaBFgmtLR4xeeReRxXC
         Ba/Rm7ZK7EdZ5yWfTBBgSIt8wRsxxtT8Inm8YRse4oKOTgXzv0XuS3Txp0+uAxvujf
         IEChhGAnr2IPwR6yn3PhUnOVHJTvwk+8tebRvAKdEylVPVQOynbul3scIP/BnAKWaS
         +B77rH1B8AA+1NBT0wwmQS8rUtB5jdIydW6CQtpUwaSjNqii2ZFKMGxLmMn7Ec7upQ
         /J31EPazz9uSj5naA7kccLDbKzkSWlttmJqVDEWS4Ef3V5UP7lZAySgfrhkw29di6B
         z+1bTv6ZCVbUA==
From:   trondmy@kernel.org
To:     wanghai <wanghai38@huawei.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: Don't leak sockets in xs_local_connect()
Date:   Thu, 28 Apr 2022 11:30:00 -0400
Message-Id: <20220428153001.9545-1-trondmy@kernel.org>
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

