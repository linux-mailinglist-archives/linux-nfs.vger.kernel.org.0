Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A27B0C87
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 21:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjI0TdA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 15:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0TdA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 15:33:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C11CC
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 12:32:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E75DC433C8
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695843179;
        bh=/AzHoaphmmitQd4Rx4tvk528BJh1T1MnaCxmDYju/84=;
        h=From:To:Subject:Date:From;
        b=NLX/djhXPuTjBosmZLv43Nhj0jG/cydViM0Rs71hSerYBNf20HpT/y1O1AxZ+eQUd
         agS7DnM43eNAvocdwqjG9eqivHuWQbNiOSjDQooGhoBv/ckl1KjrHSmxChCLg2PK3T
         vmwGQcC4kXvDoHrqMxQzmQkQCLCzkKqOjylW5kfXEqd/W1+8ZE8JZzsMyVAa2kCXDp
         oeRKj4HXG59M3PLX/mOAGlCuQ5AJDyhwZ3/xjfwfDy6ctSnlEtJzAFhkwuAedjTVVR
         SUN5fYcM8QOLttPsgmbYbJ9hYUT9Ue/rn4eS2iOFzaDmnjJVPgVN5ty+e+XWQyI/vb
         U4EdvObxYGVzQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Don't retry using the same source port if connection failed
Date:   Wed, 27 Sep 2023 15:27:12 -0400
Message-ID: <20230927192712.317799-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
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

If the TCP connection attempt fails without ever establishing a
connection, then assume the problem may be the server is rejecting us
due to port reuse.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 71848ab90d13..1a96777f0ed5 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -62,6 +62,7 @@
 #include "sunrpc.h"
 
 static void xs_close(struct rpc_xprt *xprt);
+static void xs_reset_srcport(struct sock_xprt *transport);
 static void xs_set_srcport(struct sock_xprt *transport, struct socket *sock);
 static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
 		struct socket *sock);
@@ -1565,8 +1566,10 @@ static void xs_tcp_state_change(struct sock *sk)
 		break;
 	case TCP_CLOSE:
 		if (test_and_clear_bit(XPRT_SOCK_CONNECTING,
-					&transport->sock_state))
+				       &transport->sock_state)) {
+			xs_reset_srcport(transport);
 			xprt_clear_connecting(xprt);
+		}
 		clear_bit(XPRT_CLOSING, &xprt->state);
 		/* Trigger the socket release */
 		xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
@@ -1722,6 +1725,11 @@ static void xs_set_port(struct rpc_xprt *xprt, unsigned short port)
 	xs_update_peer_port(xprt);
 }
 
+static void xs_reset_srcport(struct sock_xprt *transport)
+{
+	transport->srcport = 0;
+}
+
 static void xs_set_srcport(struct sock_xprt *transport, struct socket *sock)
 {
 	if (transport->srcport == 0 && transport->xprt.reuseport)
-- 
2.41.0

