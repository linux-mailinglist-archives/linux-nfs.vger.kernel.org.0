Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD8515280
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379753AbiD2RqD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351647AbiD2Rp6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 13:45:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488EBD39B4
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 10:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5B8BB8376A
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 17:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4585BC385AF;
        Fri, 29 Apr 2022 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254156;
        bh=dyTDr9QFVRB6I7vXOXvD7YfHhn+ihB2g1HE55P0kzcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpDXd8TngG9LDBOQWEWyHpxyKZtUsoIaJLJsm9u25+HW3p7DSQr5rmmzUkLzciU+f
         kiYuwdFUSlSlw1g283u5odIeQCb4OHQC4lRZuSaq/SuteySqXEYOhiOp12cUW6G6PP
         Lb1/PDhceLa3SJ7KvwbmnW5j3EOdyLhb3+iEvJe18l70I+pnNAlh6whGh2x2i48rbX
         Kqgo8DlxeUucqRKeqyg5HfUPODU2FnkI04+2QuEQ6QsN+kRBIwz3uFkG/7ZfLfJBn7
         Acq0FsM5tsT+SglKdkHCiSva+8szZgrSbvrvbKMS1GeGrgNSEZjLYorLJvk2q9j6w0
         UwYsvdZS6FVVQ==
From:   trondmy@kernel.org
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/4] SUNRPC: Ensure timely close of disconnected AF_LOCAL sockets
Date:   Fri, 29 Apr 2022 13:36:27 -0400
Message-Id: <20220429173629.621418-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429173629.621418-1-trondmy@kernel.org>
References: <20220429173629.621418-1-trondmy@kernel.org>
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

When the rpcbind server closes the socket, we need to ensure that the
socket is closed by the kernel as soon as feasible, so add a
sk_state_change callback to trigger this close.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index f9849b297ea3..25b8a8ead56b 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1418,6 +1418,26 @@ static size_t xs_tcp_bc_maxpayload(struct rpc_xprt *xprt)
 }
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 
+/**
+ * xs_local_state_change - callback to handle AF_LOCAL socket state changes
+ * @sk: socket whose state has changed
+ *
+ */
+static void xs_local_state_change(struct sock *sk)
+{
+	struct rpc_xprt *xprt;
+	struct sock_xprt *transport;
+
+	if (!(xprt = xprt_from_sock(sk)))
+		return;
+	transport = container_of(xprt, struct sock_xprt, xprt);
+	if (sk->sk_shutdown & SHUTDOWN_MASK) {
+		clear_bit(XPRT_CONNECTED, &xprt->state);
+		/* Trigger the socket release */
+		xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
+	}
+}
+
 /**
  * xs_tcp_state_change - callback to handle TCP socket state changes
  * @sk: socket whose state has changed
@@ -1866,6 +1886,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 		sk->sk_user_data = xprt;
 		sk->sk_data_ready = xs_data_ready;
 		sk->sk_write_space = xs_udp_write_space;
+		sk->sk_state_change = xs_local_state_change;
 		sk->sk_error_report = xs_error_report;
 
 		xprt_clear_connected(xprt);
-- 
2.35.1

