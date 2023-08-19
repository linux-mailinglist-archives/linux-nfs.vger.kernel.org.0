Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A34781BAA
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Aug 2023 02:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHTAWQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Aug 2023 20:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjHTAVk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Aug 2023 20:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96847E28CA
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 14:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3169461901
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 21:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9B8C433C8;
        Sat, 19 Aug 2023 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692481153;
        bh=8eHIRLLWEITf8NqTQbRpZXk03/aWt1++l3diAXcUgP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5nWhf2eNIMAmpHjSupxxBuXK1jZvCo9TNw1XNjEsOzQ5YRWqpW5uZuiseDwzJC2t
         132MY/tx+NH9iA/KCHYvnRMN+eiyUuGds/9vUVjGjtb9z0OmV0wzQxAV0gh3Is1hU2
         4ADl5xZ+iqbaV/2MBRXAE9m7RDPrPOK/KJd8BdtZEVY3LQgx38tRnI5oUXkK7myH6W
         USIIu6X0GUh6bz7D7wXVC2a8WTqFHXnewZeNMxNR4hstC6eZU80S1dRvm63DBFOgi3
         oTIwxxefu0UJP1pB+il++HCJqbyc8ShCafjjXvdWhhYa3k3j2vjsO4IThDq0Jk02//
         0KdsCyttjWGhA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/5] SUNRPC: Set the TCP_SYNCNT to match the socket timeout
Date:   Sat, 19 Aug 2023 17:32:21 -0400
Message-ID: <20230819213225.731214-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230819213225.731214-1-trondmy@kernel.org>
References: <20230819213225.731214-1-trondmy@kernel.org>
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
index 9f010369100a..47d0b6a8c32e 100644
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
+	for (t = 0; t <= syn_retries && (1UL << t) < connect_timeout; t++)
+		;
+	if (t <= syn_retries)
+		tcp_sock_set_syncnt(sock->sk, t - 1);
 }
 
 static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
-- 
2.41.0

