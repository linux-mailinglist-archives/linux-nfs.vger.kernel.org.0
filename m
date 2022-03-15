Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FED4DA026
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350097AbiCOQfr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350103AbiCOQfp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 12:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D6A506C7
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 09:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D2DA614A0
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 16:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2B2C340EE
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647362071;
        bh=MvfmD2iZlw1bl+V53u2scs6Uj9onrM6h2zMsfrP90xk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KLVPchhojpl4jshBELGyDjcDx6tVw+hWjT6Yt7ba3jWmwSG7UVQzAzijA2Upt9Ys2
         i5S+C/zycx/yClFoI5PMR3CakUEzLzw3yqITCaxaIn3Uv6JN2d/LcfnuOIReVAMAwC
         2CWT2ksrsI/w+ZgUR+AIWxsR4E70SMTI+Pa+/ZTGcVDOVppr3Xt0LAE0rwAe+utUH7
         RXN/+0Z+wlSBWllE8sn/a7n34R9X6evt0JkTrg7hqTOnM+mzyjzXoLPfmgekem3W7r
         7JA1FAfosdOnTa3enPQnyRQx5fwlo5L5qjG5weoSTcGP+jC7UfIlPwbC8bc7RCfoVK
         w+VN3aXwoGRfw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] SUNRPC: Replace internal use of SOCKWQ_ASYNC_NOSPACE
Date:   Tue, 15 Mar 2022 12:28:04 -0400
Message-Id: <20220315162805.570850-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315162805.570850-1-trondmy@kernel.org>
References: <20220315162805.570850-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The socket's SOCKWQ_ASYNC_NOSPACE can be cleared by various actors in
the socket layer, so replace it with our own flag in the transport
sock_state field.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xprtsock.h |  1 +
 net/sunrpc/xprtsock.c           | 22 ++++------------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 8c2a712cb242..121162a95863 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -89,5 +89,6 @@ struct sock_xprt {
 #define XPRT_SOCK_WAKE_WRITE	(5)
 #define XPRT_SOCK_WAKE_PENDING	(6)
 #define XPRT_SOCK_WAKE_DISCONNECT	(7)
+#define XPRT_SOCK_NOSPACE	(8)
 
 #endif /* _LINUX_SUNRPC_XPRTSOCK_H */
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 786df8c0cda3..23cdb841f056 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -779,14 +779,8 @@ static int xs_nospace(struct rpc_rqst *req, struct sock_xprt *transport)
 
 	/* Don't race with disconnect */
 	if (xprt_connected(xprt)) {
-		struct socket_wq *wq;
-
-		rcu_read_lock();
-		wq = rcu_dereference(sk->sk_wq);
-		set_bit(SOCKWQ_ASYNC_NOSPACE, &wq->flags);
-		rcu_read_unlock();
-
 		/* wait for more buffer space */
+		set_bit(XPRT_SOCK_NOSPACE, &transport->sock_state);
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk->sk_write_pending++;
 		xprt_wait_for_buffer_space(xprt);
@@ -1148,6 +1142,7 @@ static void xs_sock_reset_state_flags(struct rpc_xprt *xprt)
 	clear_bit(XPRT_SOCK_WAKE_ERROR, &transport->sock_state);
 	clear_bit(XPRT_SOCK_WAKE_WRITE, &transport->sock_state);
 	clear_bit(XPRT_SOCK_WAKE_DISCONNECT, &transport->sock_state);
+	clear_bit(XPRT_SOCK_NOSPACE, &transport->sock_state);
 }
 
 static void xs_run_error_worker(struct sock_xprt *transport, unsigned int nr)
@@ -1494,7 +1489,6 @@ static void xs_tcp_state_change(struct sock *sk)
 
 static void xs_write_space(struct sock *sk)
 {
-	struct socket_wq *wq;
 	struct sock_xprt *transport;
 	struct rpc_xprt *xprt;
 
@@ -1505,15 +1499,10 @@ static void xs_write_space(struct sock *sk)
 	if (unlikely(!(xprt = xprt_from_sock(sk))))
 		return;
 	transport = container_of(xprt, struct sock_xprt, xprt);
-	rcu_read_lock();
-	wq = rcu_dereference(sk->sk_wq);
-	if (!wq || test_and_clear_bit(SOCKWQ_ASYNC_NOSPACE, &wq->flags) == 0)
-		goto out;
-
+	if (!test_and_clear_bit(XPRT_SOCK_NOSPACE, &transport->sock_state))
+		return;
 	xs_run_error_worker(transport, XPRT_SOCK_WAKE_WRITE);
 	sk->sk_write_pending--;
-out:
-	rcu_read_unlock();
 }
 
 /**
@@ -1854,7 +1843,6 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 		sk->sk_user_data = xprt;
 		sk->sk_data_ready = xs_data_ready;
 		sk->sk_write_space = xs_udp_write_space;
-		sock_set_flag(sk, SOCK_FASYNC);
 		sk->sk_error_report = xs_error_report;
 
 		xprt_clear_connected(xprt);
@@ -2048,7 +2036,6 @@ static void xs_udp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		sk->sk_user_data = xprt;
 		sk->sk_data_ready = xs_data_ready;
 		sk->sk_write_space = xs_udp_write_space;
-		sock_set_flag(sk, SOCK_FASYNC);
 
 		xprt_set_connected(xprt);
 
@@ -2215,7 +2202,6 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		sk->sk_data_ready = xs_data_ready;
 		sk->sk_state_change = xs_tcp_state_change;
 		sk->sk_write_space = xs_tcp_write_space;
-		sock_set_flag(sk, SOCK_FASYNC);
 		sk->sk_error_report = xs_error_report;
 
 		/* socket options */
-- 
2.35.1

