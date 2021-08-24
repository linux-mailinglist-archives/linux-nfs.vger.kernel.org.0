Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D53F61D0
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbhHXPjF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 11:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234546AbhHXPjE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Aug 2021 11:39:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3081F60F21;
        Tue, 24 Aug 2021 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629819500;
        bh=SBAfLUjaYPT3+w+gakgXifkv2GwqKpwectilx5Pu7fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNZDD1bQtS7dAzsvQXIMKkgXWBE0khJ4MT4nUjYtv/+gXwnw5VgBZuWlzVW1jX9MY
         3l/X0p/ueZ1S6HuZt92Lfdj0fLwg9OcR7RV/S3WAsOt2NAKiTQDzM2LU5CF6z6ywzb
         FGErgzTXIBc+mthlwWmg7+XJrVHrUTWFI70p133eyv+zprqsaN8ltnu5lyxvj6JuI2
         yBBxF0JTRa1V3i6Hxol/8RM+Z4/Tixe4H2tSqKc6Ct3bhqmPYOq257TDNitFNOVeFa
         19FJiTYTwJe2ve4zVwklUc3H/CNSrM6lnqoyivX5qi3V40kwMDloBVM3Bc7QxNXfmC
         x+Au31SfNoXrQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: Tweak TCP socket shutdown in the RPC client
Date:   Tue, 24 Aug 2021 11:38:18 -0400
Message-Id: <20210824153818.322833-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824153818.322833-1-trondmy@kernel.org>
References: <20210824153818.322833-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We only really need to call shutdown() if we're in the ESTABLISHED TCP
state, since that is the only case where the client is initiating a
close of an established connection.

If the socket is in FIN_WAIT1 or FIN_WAIT2, then we've already initiated
socket shutdown and are waiting for the server's reply, so do nothing.

In all other cases where we've already received a FIN from the server,
we should be able to just close the socket.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7e94f1d17edb..b91027d140df 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2104,12 +2104,15 @@ static void xs_tcp_shutdown(struct rpc_xprt *xprt)
 		return;
 	}
 	switch (skst) {
-	default:
+	case TCP_FIN_WAIT1:
+	case TCP_FIN_WAIT2:
+		break;
+	case TCP_ESTABLISHED:
+	case TCP_CLOSE_WAIT:
 		kernel_sock_shutdown(sock, SHUT_RDWR);
 		trace_rpc_socket_shutdown(xprt, sock);
 		break;
-	case TCP_CLOSE:
-	case TCP_TIME_WAIT:
+	default:
 		xs_reset_transport(transport);
 	}
 }
-- 
2.31.1

