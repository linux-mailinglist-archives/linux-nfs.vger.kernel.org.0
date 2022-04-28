Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691BB51387D
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiD1Pj0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiD1PjY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 11:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D306496BB
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 08:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59A961FB1
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 15:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6526C385A0;
        Thu, 28 Apr 2022 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651160169;
        bh=CWMNOjybVKoVyuQMJdUrwvTlJYDc2t0EVuicZ/5TiZU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CrkPT7v1A3rppUVdTlzsX4oaVVg34B02usOKIAXw5DXVS5UWyKSBnZ/0xJRExJLUF
         b56E8BS9r4PwkPFRzcxbhe3iZ0pYZXp5EVJPvYhQAvBt2L5vRiUg5PJQQ+T9MbX6ZC
         plHZMwzVloYll3grpk05guBO5COIHRqVtR8hciRv7svs42c2pORXHytBdcUQstyXBN
         dZwE0/Y7PmD/p3lShzLZfxd6g0S/jsfwwnyn/PkR21qWE0Ds9W/SY4F6i14CDINPcB
         YZAuM9dxcmbvcGk+qjPi9rnyPxoEu6TAPRq/9zgX/ZCIRZgcrJjBp0tUgJhTNHLWsz
         nXiJyIA4cedQw==
From:   trondmy@kernel.org
To:     wanghai <wanghai38@huawei.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: Ensure timely close of disconnected AF_LOCAL sockets
Date:   Thu, 28 Apr 2022 11:30:01 -0400
Message-Id: <20220428153001.9545-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428153001.9545-1-trondmy@kernel.org>
References: <20220428153001.9545-1-trondmy@kernel.org>
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
 net/sunrpc/xprtsock.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index f9849b297ea3..cf91f7c4bdf9 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1418,6 +1418,25 @@ static size_t xs_tcp_bc_maxpayload(struct rpc_xprt *xprt)
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
@@ -1866,6 +1885,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 		sk->sk_user_data = xprt;
 		sk->sk_data_ready = xs_data_ready;
 		sk->sk_write_space = xs_udp_write_space;
+		sk->sk_state_change = xs_local_state_change;
 		sk->sk_error_report = xs_error_report;
 
 		xprt_clear_connected(xprt);
-- 
2.35.1

