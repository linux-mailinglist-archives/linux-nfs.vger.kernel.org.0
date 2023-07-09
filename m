Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF9974C7FA
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 22:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGIUFW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 16:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIUFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 16:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F466FE
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 13:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F22F760C20
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 20:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA5CC433C8;
        Sun,  9 Jul 2023 20:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688933119;
        bh=f6izZdO3VuQUntLxWUjulGDu7AYVq4c1pjyxSeg2vZU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oyY8eUPF/0med4CPeMC5FGwDSUh0l1qGh+uXCOXlkojZOP4KfzNSX/WKWCheRkWXR
         1otknn1YBf74GKmgUFKHeq8SyXHScONivQP5kdTbA40CP+XmyoO6IuJz7Y0ap3m57W
         rNgWC0Bk8oHwbGLt1ukY9BHySqLUn+QG0MwFAOh/lm3pGAaRoLcqPUU3IzRogUmDUS
         lAQuQv8ED8YU7Ul3qASqiS9Kall+F+tJqjXCRs3AK4GPl7GwHdr7ghC03oV5GxwmPY
         J9oRyuNzAZESLzwu/Kn2WJ/b3+iSD3UHXb15iizPyb6jH6s4+3JvUZikuMFV47DRG0
         /H4qJhsoiLuyA==
Subject: [PATCH RFC 4/4] SUNRPC: Send RPC message on TCP with a single
 sock_sendmsg() call
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Sun, 09 Jul 2023 16:05:18 -0400
Message-ID: <168893311819.1949.12216126239653940727.stgit@manet.1015granger.net>
In-Reply-To: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
References: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

There is now enough infrastructure in place to combine the stream
record marker into the biovec array used to send each outgoing RPC
message. The whole message can be more efficiently sent with a
single call to sock_sendmsg() using a bio_vec iterator.

Note that this also helps with RPC-with-TLS: the TLS implementation
can now clearly see where the upper layer message boundaries are.
Before, it would send each component of the xdr_buf in a separate
TLS record.

Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |    2 ++
 net/sunrpc/svcsock.c           |   33 ++++++++++++++++++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 4efae760f3cb..55446136499f 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -38,6 +38,8 @@ struct svc_sock {
 	/* Number of queued send requests */
 	atomic_t		sk_sendqlen;
 
+	struct page_frag_cache  sk_frag_cache;
+
 	struct completion	sk_handshake_done;
 
 	struct bio_vec		sk_recv_bvec[RPCSVC_MAXPAGES]
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6f672cb0b0b3..19cab73229e4 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1247,29 +1247,28 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 static int svc_tcp_sendmsg(struct svc_sock *svsk, struct xdr_buf *xdr,
 			   rpc_fraghdr marker, unsigned int *sentp)
 {
-	struct kvec rm = {
-		.iov_base	= &marker,
-		.iov_len	= sizeof(marker),
-	};
 	struct msghdr msg = {
-		.msg_flags	= MSG_MORE,
+		.msg_flags	= MSG_SPLICE_PAGES,
 	};
 	unsigned int count;
+	void *tmp;
 	int ret;
 
 	*sentp = 0;
 
-	ret = kernel_sendmsg(svsk->sk_sock, &msg, &rm, 1, rm.iov_len);
-	if (ret < 0)
-		return ret;
-	*sentp += ret;
-	if (ret != rm.iov_len)
-		return -EAGAIN;
-
-	count = svc_sock_xdr_to_bvecs(svsk->sk_send_bvec, xdr);
-	msg.msg_flags = MSG_SPLICE_PAGES;
+	/* The stream record marker is copied into a temporary page
+	 * buffer so that it can be included in sk_send_bvec.
+	 */
+	tmp = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
+			      GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+	memcpy(tmp, &marker, sizeof(marker));
+	bvec_set_virt(svsk->sk_send_bvec, tmp, sizeof(marker));
+
+	count = svc_sock_xdr_to_bvecs(svsk->sk_send_bvec + 1, xdr);
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
-		      count, xdr->len);
+		      1 + count, sizeof(marker) + xdr->len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
 	if (ret < 0)
 		return ret;
@@ -1648,6 +1647,7 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
+	struct page_frag_cache *pfc = &svsk->sk_frag_cache;
 	struct socket *sock = svsk->sk_sock;
 
 	trace_svcsock_free(svsk, sock);
@@ -1657,5 +1657,8 @@ static void svc_sock_free(struct svc_xprt *xprt)
 		sockfd_put(sock);
 	else
 		sock_release(sock);
+	if (pfc->va)
+		__page_frag_cache_drain(virt_to_head_page(pfc->va),
+					pfc->pagecnt_bias);
 	kfree(svsk);
 }


