Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2660D780CF0
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349805AbjHRNti (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 09:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377457AbjHRNtU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 09:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884E44B5
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 06:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1958863E1C
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F1BC433C9;
        Fri, 18 Aug 2023 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366498;
        bh=2UqX8FE4tgTcC45kxE/+oKdfdr4aoLZlCKX9kYBjkuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRcDawLSQ5E2GK1EysfVhrXXyU2niV2M0dv31tDIoY5W4scd8GQI00MFQ/HuMjEcv
         qQHP9wT1znILqZmqRnpeV2HMkwHFlogc5qCho0N5AfDgJow7aLsZQ7ZFVq78GHex3q
         CqfdcdFnlcU0n5+sVsjCL594imZF0fxNhUPwakLxTNz2m/oD8cPX7VAkKYPSZ4Xh/V
         5RdKuRq5XD5obMhAIwa85n7U9cp++H7IwfWZRJZCP2o8A9WNo6DHk8qTx/eGZjVyv+
         xGNFhM8QdOltApl76rVbODALO7B55inxEnSwmLbxA6GZvN1iqHfFS2q4rk85igEP+J
         Z+QHWWekJZOtw==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] SUNRPC: Set the TCP_SYNCNT to match the socket timeout
Date:   Fri, 18 Aug 2023 09:41:47 -0400
Message-ID: <20230818134150.23485-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818134150.23485-1-trondmy@kernel.org>
References: <20230818134150.23485-1-trondmy@kernel.org>
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

Set the TCP SYN count so that we abort the connection attempt at around
the expected timeout value.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9f010369100a..ba045187cf65 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2230,9 +2230,13 @@ static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
 		struct socket *sock)
 {
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
+	struct net *net = sock_net(sock->sk);
+	unsigned long connect_timeout;
+	unsigned long syn_retries;
 	unsigned int keepidle;
 	unsigned int keepcnt;
 	unsigned int timeo;
+	unsigned long t;
 
 	spin_lock(&xprt->transport_lock);
 	keepidle = DIV_ROUND_UP(xprt->timeout->to_initval, HZ);
@@ -2250,6 +2254,16 @@ static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
 
 	/* TCP user timeout (see RFC5482) */
 	tcp_sock_set_user_timeout(sock->sk, timeo);
+
+	/* Connect timeout */
+	connect_timeout = max_t(unsigned long,
+				DIV_ROUND_UP(xprt->connect_timeout, HZ), 1);
+	syn_retries = max_t(unsigned long,
+			    READ_ONCE(net->ipv4.sysctl_tcp_syn_retries), 1);
+	for (t = 0; t < syn_retries && (1 << t) < connect_timeout; t++)
+		;
+	if (t <= syn_retries)
+		tcp_sock_set_syncnt(sock->sk, t - 1);
 }
 
 static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
-- 
2.41.0

