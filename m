Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178F64DA025
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350098AbiCOQfr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350096AbiCOQfq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 12:35:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478CB57152
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 09:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1D6EB817C9
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 16:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BEFC340E8
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647362071;
        bh=rcI4//gyqZpaPNsAijYqAv9OYh2/LcrZiCHX90zE9EE=;
        h=From:To:Subject:Date:From;
        b=Dg3hJyymoegauB/98KMGwWW4m045Ti/JwpXhYaOTFp4MW3VRxcZxqj4XSPzsJfk9o
         yEFAGuJlxjNQ3utGIREBCAdq9zxs+zdUpqVuhlzkjnOtr6X65hi1P681rEew4Uibml
         Bw72BzndQI9JVlwEEPCp9uPT/OdValQTJsWLoJz+Ljnlo7VkMcWZTzKQliYtTaRWF9
         FT15YUQnhrM9S3ZcF+wzKSqQ8YeveF01uZ64sET9Xsx+Ln07HLg5m0pDTiE94DCQfK
         BfLmtjWpudvN3CVPGA5D1pJwCQw4fTLN6OvnTHpyxk84tn9rdLa3reimq3jlG+JJ6s
         NLSzJ3d9IfWFg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] SUNRPC: Fix socket waits for write buffer space
Date:   Tue, 15 Mar 2022 12:28:03 -0400
Message-Id: <20220315162805.570850-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The socket layer requires that we use the socket lock to protect changes
to the sock->sk_write_pending field and others.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 54 +++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7e39f87cde2d..786df8c0cda3 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -763,12 +763,12 @@ xs_stream_start_connect(struct sock_xprt *transport)
 /**
  * xs_nospace - handle transmit was incomplete
  * @req: pointer to RPC request
+ * @transport: pointer to struct sock_xprt
  *
  */
-static int xs_nospace(struct rpc_rqst *req)
+static int xs_nospace(struct rpc_rqst *req, struct sock_xprt *transport)
 {
-	struct rpc_xprt *xprt = req->rq_xprt;
-	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
+	struct rpc_xprt *xprt = &transport->xprt;
 	struct sock *sk = transport->inet;
 	int ret = -EAGAIN;
 
@@ -779,25 +779,49 @@ static int xs_nospace(struct rpc_rqst *req)
 
 	/* Don't race with disconnect */
 	if (xprt_connected(xprt)) {
+		struct socket_wq *wq;
+
+		rcu_read_lock();
+		wq = rcu_dereference(sk->sk_wq);
+		set_bit(SOCKWQ_ASYNC_NOSPACE, &wq->flags);
+		rcu_read_unlock();
+
 		/* wait for more buffer space */
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk->sk_write_pending++;
 		xprt_wait_for_buffer_space(xprt);
 	} else
 		ret = -ENOTCONN;
 
 	spin_unlock(&xprt->transport_lock);
+	return ret;
+}
 
-	/* Race breaker in case memory is freed before above code is called */
-	if (ret == -EAGAIN) {
-		struct socket_wq *wq;
+static int xs_sock_nospace(struct rpc_rqst *req)
+{
+	struct sock_xprt *transport =
+		container_of(req->rq_xprt, struct sock_xprt, xprt);
+	struct sock *sk = transport->inet;
+	int ret = -EAGAIN;
 
-		rcu_read_lock();
-		wq = rcu_dereference(sk->sk_wq);
-		set_bit(SOCKWQ_ASYNC_NOSPACE, &wq->flags);
-		rcu_read_unlock();
+	lock_sock(sk);
+	if (!sock_writeable(sk))
+		ret = xs_nospace(req, transport);
+	release_sock(sk);
+	return ret;
+}
 
-		sk->sk_write_space(sk);
-	}
+static int xs_stream_nospace(struct rpc_rqst *req)
+{
+	struct sock_xprt *transport =
+		container_of(req->rq_xprt, struct sock_xprt, xprt);
+	struct sock *sk = transport->inet;
+	int ret = -EAGAIN;
+
+	lock_sock(sk);
+	if (!sk_stream_memory_free(sk))
+		ret = xs_nospace(req, transport);
+	release_sock(sk);
 	return ret;
 }
 
@@ -887,7 +911,7 @@ static int xs_local_send_request(struct rpc_rqst *req)
 	case -ENOBUFS:
 		break;
 	case -EAGAIN:
-		status = xs_nospace(req);
+		status = xs_stream_nospace(req);
 		break;
 	default:
 		dprintk("RPC:       sendmsg returned unrecognized error %d\n",
@@ -963,7 +987,7 @@ static int xs_udp_send_request(struct rpc_rqst *req)
 		/* Should we call xs_close() here? */
 		break;
 	case -EAGAIN:
-		status = xs_nospace(req);
+		status = xs_sock_nospace(req);
 		break;
 	case -ENETUNREACH:
 	case -ENOBUFS:
@@ -1083,7 +1107,7 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 		/* Should we call xs_close() here? */
 		break;
 	case -EAGAIN:
-		status = xs_nospace(req);
+		status = xs_stream_nospace(req);
 		break;
 	case -ECONNRESET:
 	case -ECONNREFUSED:
-- 
2.35.1

