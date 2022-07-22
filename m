Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3CE57E581
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiGVRZx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 13:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiGVRZr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 13:25:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC67BE04
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 10:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27F0DB8296E
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 17:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AE4C341C6;
        Fri, 22 Jul 2022 17:25:43 +0000 (UTC)
Subject: [PATCH 3/4] SUNRPC: Replace dprintk() call site in xs_data_ready
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 13:25:42 -0400
Message-ID: <165851074247.361126.17205394769981595871.stgit@morisot.1015granger.net>
In-Reply-To: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   18 ++++++++++++++++++
 net/sunrpc/xprtsock.c         |    6 ++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index b61d9c90fa26..04b6903b6c0c 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1266,6 +1266,24 @@ TRACE_EVENT(xprt_reserve,
 	)
 );
 
+TRACE_EVENT(xs_data_ready,
+	TP_PROTO(
+		const struct rpc_xprt *xprt
+	),
+
+	TP_ARGS(xprt),
+
+	TP_STRUCT__entry(
+		__sockaddr(addr, xprt->addrlen)
+	),
+
+	TP_fast_assign(
+		__assign_sockaddr(addr, &xprt->addr, xprt->addrlen);
+	),
+
+	TP_printk("peer=%pISpc", __get_sockaddr(addr))
+);
+
 TRACE_EVENT(xs_stream_read_data,
 	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index fcdd0fca408e..eba1be9984f8 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1378,7 +1378,7 @@ static void xs_udp_data_receive_workfn(struct work_struct *work)
 }
 
 /**
- * xs_data_ready - "data ready" callback for UDP sockets
+ * xs_data_ready - "data ready" callback for sockets
  * @sk: socket with data to read
  *
  */
@@ -1386,11 +1386,13 @@ static void xs_data_ready(struct sock *sk)
 {
 	struct rpc_xprt *xprt;
 
-	dprintk("RPC:       xs_data_ready...\n");
 	xprt = xprt_from_sock(sk);
 	if (xprt != NULL) {
 		struct sock_xprt *transport = container_of(xprt,
 				struct sock_xprt, xprt);
+
+		trace_xs_data_ready(xprt);
+
 		transport->old_data_ready(sk);
 		/* Any data means we had a useful conversation, so
 		 * then we don't need to delay the next reconnect


