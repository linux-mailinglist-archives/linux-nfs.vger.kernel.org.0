Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41AD3C8800
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jul 2021 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbhGNPx2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jul 2021 11:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239554AbhGNPx2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Jul 2021 11:53:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45662613C5
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jul 2021 15:50:36 +0000 (UTC)
Subject: [PATCH RFC 4/4] SUNRPC: Unset RPC_TASK_NO_RETRANS_TIMEOUT for NULL
 RPCs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 14 Jul 2021 11:50:35 -0400
Message-ID: <162627783556.1294.4875890480589342085.stgit@manet.1015granger.net>
In-Reply-To: <162627611661.1294.9189768423517916152.stgit@manet.1015granger.net>
References: <162627611661.1294.9189768423517916152.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In some rare failure modes, the server is actually reading the
transport, but then just dropping the requests on the floor.
TCP_USER_TIMEOUT cannot detect that case.

Prevent such a stuck server from pinning client resources
indefinitely by ensuring that certain idempotent requests
(such as NULL) can time out even if the connection is still
operational.

Otherwise rpc_bind_new_program(), gss_destroy_cred(), or
rpc_clnt_test_and_add_xprt() can wait forever.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ca2000d8cf64..d34737a8a68a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2694,6 +2694,18 @@ static const struct rpc_procinfo rpcproc_null = {
 	.p_decode = rpcproc_decode_null,
 };
 
+static void
+rpc_null_call_prepare(struct rpc_task *task, void *data)
+{
+	task->tk_flags &= ~RPC_TASK_NO_RETRANS_TIMEOUT;
+	rpc_call_start(task);
+}
+
+static const struct rpc_call_ops rpc_null_ops = {
+	.rpc_call_prepare = rpc_null_call_prepare,
+	.rpc_call_done = rpc_default_callback,
+};
+
 static
 struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		struct rpc_xprt *xprt, struct rpc_cred *cred, int flags,
@@ -2707,7 +2719,7 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		.rpc_xprt = xprt,
 		.rpc_message = &msg,
 		.rpc_op_cred = cred,
-		.callback_ops = (ops != NULL) ? ops : &rpc_default_ops,
+		.callback_ops = ops ?: &rpc_null_ops,
 		.callback_data = data,
 		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
 			 RPC_TASK_NULLCREDS,
@@ -2758,6 +2770,7 @@ static void rpc_cb_add_xprt_release(void *calldata)
 }
 
 static const struct rpc_call_ops rpc_cb_add_xprt_call_ops = {
+	.rpc_call_prepare = rpc_null_call_prepare,
 	.rpc_call_done = rpc_cb_add_xprt_done,
 	.rpc_release = rpc_cb_add_xprt_release,
 };


