Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F00A781BAB
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Aug 2023 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHTAWP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Aug 2023 20:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjHTAVk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Aug 2023 20:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE0E28F5
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 14:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93C4619E0
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 21:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE240C433C7;
        Sat, 19 Aug 2023 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692481154;
        bh=s8z4CSMnk0bp6fS9JenTXfCYBKPawhJCOW+NdDsvPYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPzu6sDvg7zf7QFkGtrAyOma8OW8YpU/WLSxfrglIyaV0DAZw7/e+qwXYeJOqzrHF
         mMKL/OylobQmjJ2xdNI2VbVHSNZagjUupRRzS7VQBQzrvsiHHjx0Qyn07iyA8yXkZX
         49s4Hqr/SDPIO1Os16rg38nHiRsQO/YFB+RplWSlmX6TDnLTV8HbPddRP6ZSQpbJ0f
         o2oOree8NYkrqyoAvFO4NaSZLjjLqxX+kA9v4tymeW7me68MS3iCYtF1ln22qSZz3z
         hL/7evAKAhs2vd/e4Q/mPXAIzAQQqqjRkT4UKPsGGF74l6U5+n7610TbL2oQky4NK4
         cKC1INVi7oW0g==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/5] SUNRPC: Refactor and simplify connect timeout
Date:   Sat, 19 Aug 2023 17:32:22 -0400
Message-ID: <20230819213225.731214-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230819213225.731214-2-trondmy@kernel.org>
References: <20230819213225.731214-1-trondmy@kernel.org>
 <20230819213225.731214-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 net/sunrpc/xprtsock.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 47d0b6a8c32e..e558f0024fe5 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2266,6 +2266,25 @@ static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
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
+	initval = max_t(unsigned long, connect_timeout, XS_TCP_INIT_REEST_TO);
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
@@ -2277,19 +2296,8 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
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

