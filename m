Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB35051EDFE
	for <lists+linux-nfs@lfdr.de>; Sun,  8 May 2022 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiEHOVV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 May 2022 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiEHOVU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 May 2022 10:21:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7269DAE5E
        for <linux-nfs@vger.kernel.org>; Sun,  8 May 2022 07:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26AB1B80D3A
        for <linux-nfs@vger.kernel.org>; Sun,  8 May 2022 14:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722A6C385AC
        for <linux-nfs@vger.kernel.org>; Sun,  8 May 2022 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652019447;
        bh=OeAJVczyaAnbX/tU0M6kyvaHhJKbzBqK3FerhvaVUy0=;
        h=From:To:Subject:Date:From;
        b=A+TBxbW5xjm2Y020+/81PUla6WsJO3oGkKFthxixxawl9DKAmBo9OibtTWswjJgTF
         ZgJgjB98mOPtYBM9JzGDpFmS0H+NsUIqf7DeqZIIhksJrT3D8D0PxakatrCJ4e65Sv
         lntbdGxJrPLiPxoCgP2VVoHSIbg4+c3JqHcMh3x013UG6hkHjPiHEaJAcuA8N7QIvM
         d9GSb0dizAiT5tqpDtDN23ZDlPcC0+2uUcvs5moEs6u0XOPrib+caILUeDm9484icz
         yjj14M5X4qs/fvlqXvwvwQcbeWUhHbvOUmnnSoqAjv2w6wSenL36udym7mXLl1Mn48
         JhZswkENZKoaA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] Revert "SUNRPC: Ensure gss-proxy connects on setup"
Date:   Sun,  8 May 2022 10:11:20 -0400
Message-Id: <20220508141121.12274-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This reverts commit 892de36fd4a98fab3298d417c051d9099af5448d.

The gssproxy server is unresponsive when it calls into the kernel to
start the upcall service, so it will not reply to our RPC ping at all.

Reported-by: "J.Bruce Fields" <bfields@fieldses.org>
Fixes: 892de36fd4a9 ("SUNRPC: Ensure gss-proxy connects on setup")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/clnt.h          | 1 -
 net/sunrpc/auth_gss/gss_rpc_upcall.c | 2 +-
 net/sunrpc/clnt.c                    | 3 ---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index db5149567305..267b7aeaf1a6 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -160,7 +160,6 @@ struct rpc_add_xprt_test {
 #define RPC_CLNT_CREATE_NO_RETRANS_TIMEOUT	(1UL << 9)
 #define RPC_CLNT_CREATE_SOFTERR		(1UL << 10)
 #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
-#define RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL (1UL << 12)
 
 struct rpc_clnt *rpc_create(struct rpc_create_args *args);
 struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.c b/net/sunrpc/auth_gss/gss_rpc_upcall.c
index 8ca1d809b78d..61c276bddaf2 100644
--- a/net/sunrpc/auth_gss/gss_rpc_upcall.c
+++ b/net/sunrpc/auth_gss/gss_rpc_upcall.c
@@ -97,7 +97,7 @@ static int gssp_rpc_create(struct net *net, struct rpc_clnt **_clnt)
 		 * timeout, which would result in reconnections being
 		 * done without the correct namespace:
 		 */
-		.flags		= RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL |
+		.flags		= RPC_CLNT_CREATE_NOPING |
 				  RPC_CLNT_CREATE_NO_IDLE_TIMEOUT
 	};
 	struct rpc_clnt *clnt;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 22c28cf43eba..98133aa54f19 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -479,9 +479,6 @@ static struct rpc_clnt *rpc_create_xprt(struct rpc_create_args *args,
 
 	if (!(args->flags & RPC_CLNT_CREATE_NOPING)) {
 		int err = rpc_ping(clnt);
-		if ((args->flags & RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL) &&
-		    err == -EOPNOTSUPP)
-			err = 0;
 		if (err != 0) {
 			rpc_shutdown_client(clnt);
 			return ERR_PTR(err);
-- 
2.35.3

