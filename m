Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2C51EDFD
	for <lists+linux-nfs@lfdr.de>; Sun,  8 May 2022 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiEHOVT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 May 2022 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiEHOVT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 May 2022 10:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7BAE5E
        for <linux-nfs@vger.kernel.org>; Sun,  8 May 2022 07:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB5A361182
        for <linux-nfs@vger.kernel.org>; Sun,  8 May 2022 14:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DAAC385A4
        for <linux-nfs@vger.kernel.org>; Sun,  8 May 2022 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652019448;
        bh=+3KpI6+Xzy09htS/spgchGReeCB9iP3XfD06rtxZr1o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b13lF3Kh4vXMerIZhVfB8QVBOfF0VWmQl6mYtxjvKoxpNdc48Bm/25WzsVWRpB89u
         RrRclnut1Qe4WoFBn3uJNjjQ9GgRccHqBg6KfdwMoTdOPg9zgfvEphbg3o1th42MO0
         mAdpYDNcR/Zpne2qzzbQgI3iEDWOY3r5QQ47v0r6V7REuFlevuB/PfKQWaq4K3jgg6
         uRTx1zTpho+egNYz9qXT9zQFb2O5wdjmk4FJawPT60AVEQdDPa6jmxwcVfFBgbidOf
         tk2q/2V2NGbAnx6K0v/Yr2R6ylcX4tRYngMGDeGRasZk3tlHlFdTKTV6GguSoY03+C
         EdnnIAwbsZBNQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: Ensure that the gssproxy client can start in a connected state
Date:   Sun,  8 May 2022 10:11:21 -0400
Message-Id: <20220508141121.12274-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220508141121.12274-1-trondmy@kernel.org>
References: <20220508141121.12274-1-trondmy@kernel.org>
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

Ensure that the gssproxy client connects to the server from the gssproxy
daemon process context so that the AF_LOCAL socket connection is done
using the correct path and namespaces.

Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for RPCGSS auth")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/clnt.h          |  1 +
 net/sunrpc/auth_gss/gss_rpc_upcall.c |  1 +
 net/sunrpc/clnt.c                    | 33 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 267b7aeaf1a6..90501404fa49 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -160,6 +160,7 @@ struct rpc_add_xprt_test {
 #define RPC_CLNT_CREATE_NO_RETRANS_TIMEOUT	(1UL << 9)
 #define RPC_CLNT_CREATE_SOFTERR		(1UL << 10)
 #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
+#define RPC_CLNT_CREATE_CONNECTED	(1UL << 12)
 
 struct rpc_clnt *rpc_create(struct rpc_create_args *args);
 struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.c b/net/sunrpc/auth_gss/gss_rpc_upcall.c
index 61c276bddaf2..f549e4c05def 100644
--- a/net/sunrpc/auth_gss/gss_rpc_upcall.c
+++ b/net/sunrpc/auth_gss/gss_rpc_upcall.c
@@ -98,6 +98,7 @@ static int gssp_rpc_create(struct net *net, struct rpc_clnt **_clnt)
 		 * done without the correct namespace:
 		 */
 		.flags		= RPC_CLNT_CREATE_NOPING |
+				  RPC_CLNT_CREATE_CONNECTED |
 				  RPC_CLNT_CREATE_NO_IDLE_TIMEOUT
 	};
 	struct rpc_clnt *clnt;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 98133aa54f19..e2c6eca0271b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -76,6 +76,7 @@ static int	rpc_encode_header(struct rpc_task *task,
 static int	rpc_decode_header(struct rpc_task *task,
 				  struct xdr_stream *xdr);
 static int	rpc_ping(struct rpc_clnt *clnt);
+static int	rpc_ping_noreply(struct rpc_clnt *clnt);
 static void	rpc_check_timeout(struct rpc_task *task);
 
 static void rpc_register_client(struct rpc_clnt *clnt)
@@ -483,6 +484,12 @@ static struct rpc_clnt *rpc_create_xprt(struct rpc_create_args *args,
 			rpc_shutdown_client(clnt);
 			return ERR_PTR(err);
 		}
+	} else if (args->flags & RPC_CLNT_CREATE_CONNECTED) {
+		int err = rpc_ping_noreply(clnt);
+		if (err != 0) {
+			rpc_shutdown_client(clnt);
+			return ERR_PTR(err);
+		}
 	}
 
 	clnt->cl_softrtry = 1;
@@ -2709,6 +2716,10 @@ static const struct rpc_procinfo rpcproc_null = {
 	.p_decode = rpcproc_decode_null,
 };
 
+static const struct rpc_procinfo rpcproc_null_noreply = {
+	.p_encode = rpcproc_encode_null,
+};
+
 static void
 rpc_null_call_prepare(struct rpc_task *task, void *data)
 {
@@ -2762,6 +2773,28 @@ static int rpc_ping(struct rpc_clnt *clnt)
 	return status;
 }
 
+static int rpc_ping_noreply(struct rpc_clnt *clnt)
+{
+	struct rpc_message msg = {
+		.rpc_proc = &rpcproc_null_noreply,
+	};
+	struct rpc_task_setup task_setup_data = {
+		.rpc_client = clnt,
+		.rpc_message = &msg,
+		.callback_ops = &rpc_null_ops,
+		.flags = RPC_TASK_SOFT | RPC_TASK_SOFTCONN | RPC_TASK_NULLCREDS,
+	};
+	struct rpc_task	*task;
+	int status;
+
+	task = rpc_run_task(&task_setup_data);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+	status = task->tk_status;
+	rpc_put_task(task);
+	return status;
+}
+
 struct rpc_cb_add_xprt_calldata {
 	struct rpc_xprt_switch *xps;
 	struct rpc_xprt *xprt;
-- 
2.35.3

