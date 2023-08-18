Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF6780CE8
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 15:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjHRNtG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377397AbjHRNsw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 09:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2526D468A
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 06:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2BF967634
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C535CC433C8;
        Fri, 18 Aug 2023 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366499;
        bh=+vC5Bipq5XqUprz8LB19QV+e2TYlIyys1769WduKZMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6WGatmJ7UCKbssD00OGx2DWeJ2rAi4B9ix4CHb19e1wqWHJm9g6/NtmvNmswy2Nd
         z9j3tL/juwHmv3HVXHdJqTkW7+mtzG0pnbhFWMrLWcj0xfCp+HTp1kPd3bgDezFzT0
         v/x51ojw7rI3zNlVem9CSHodYEuF8f9/c2nCZHQESFKkHkxR3r7eTO8Ih/nbg0bBkD
         Jwu8Qwjya2C0PDYGQ5LEkpbyujrpALhcTkfb4vTUIF0RLgpBulKFXWp1lsr4JVj9mw
         nMU6CWWJ6RRJjJFixuRT9vfAPXKlyzSiA0QaVUViOufkKrPIJYKNEHzlIa+9AfmEl+
         r0QDhqNi8cH4Q==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] SUNRPC: Refactor and simplify connect timeout
Date:   Fri, 18 Aug 2023 09:41:48 -0400
Message-ID: <20230818134150.23485-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818134150.23485-2-trondmy@kernel.org>
References: <20230818134150.23485-1-trondmy@kernel.org>
 <20230818134150.23485-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of requiring the requests to redrive the connection several
times, just let the TCP connect code manage it now that we've adjusted
the TCP_SYNCNT value.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index ba045187cf65..f1909c22cea3 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2266,6 +2266,26 @@ static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
 		tcp_sock_set_syncnt(sock->sk, t - 1);
 }
 
+static void xs_tcp_do_set_connect_timeout(struct rpc_xprt *xprt,
+					  unsigned long connect_timeout)
+{
+	struct sock_xprt *transport =
+		container_of(xprt, struct sock_xprt, xprt);
+	struct rpc_timeout to;
+	unsigned long initval;
+
+	memcpy(&to, xprt->timeout, sizeof(to));
+	/* Arbitrary lower limit */
+	initval = max_t(unsigned long, connect_timeout,
+			XS_TCP_INIT_REEST_TO << 1);
+	to.to_initval = initval;
+	to.to_maxval = initval;
+	to.to_retries = 0;
+	memcpy(&transport->tcp_timeout, &to, sizeof(transport->tcp_timeout));
+	xprt->timeout = &transport->tcp_timeout;
+	xprt->connect_timeout = connect_timeout;
+}
+
 static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 		unsigned long connect_timeout,
 		unsigned long reconnect_timeout)
@@ -2277,19 +2297,8 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 	spin_lock(&xprt->transport_lock);
 	if (reconnect_timeout < xprt->max_reconnect_timeout)
 		xprt->max_reconnect_timeout = reconnect_timeout;
-	if (connect_timeout < xprt->connect_timeout) {
-		memcpy(&to, xprt->timeout, sizeof(to));
-		initval = DIV_ROUND_UP(connect_timeout, to.to_retries + 1);
-		/* Arbitrary lower limit */
-		if (initval <  XS_TCP_INIT_REEST_TO << 1)
-			initval = XS_TCP_INIT_REEST_TO << 1;
-		to.to_initval = initval;
-		to.to_maxval = initval;
-		memcpy(&transport->tcp_timeout, &to,
-				sizeof(transport->tcp_timeout));
-		xprt->timeout = &transport->tcp_timeout;
-		xprt->connect_timeout = connect_timeout;
-	}
+	if (connect_timeout < xprt->connect_timeout)
+		xs_tcp_do_set_connect_timeout(xprt, connect_timeout);
 	set_bit(XPRT_SOCK_UPD_TIMEOUT, &transport->sock_state);
 	spin_unlock(&xprt->transport_lock);
 }
-- 
2.41.0

