Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767BA759D4C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjGSSbN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGSSbN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 14:31:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093010CB
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 11:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797BC617D5
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 18:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998F2C433C7;
        Wed, 19 Jul 2023 18:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689791470;
        bh=qPL1XmQINNAE+Qi03ydyBs8JMJCLspAjkFez1BvTBzk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZKO7qQJ2T50a5CCfwHoxnC0/pT48MPI1oNf7nGTso5ju1rnfT8yYEvu5lHezU2+64
         H7bF9d2EHD818tCqfUhgLELQDZVgR4VykY0fp/hzIOHUswm3IMe6S6nJ8rsAUbFnxf
         vRSKXs1knNXakS2hV9PeVQx1l/wg9AHpSwyUGuWneEH21j+kDYMyFZcX+eQeJ555zV
         iU/zY443jdiruqPJyM65oWHRlEacJTOZhlKRl0SzUO6v+P3gN69INLnQT6k5gTbMiy
         o9fkTeGSgbVgKNW0jird0sC+pX9aeXDrmQ2g/cK0mu0tHhOBnAZ1yL44czOKMrKWRH
         JXqR9AxR/vCSA==
Subject: [PATCH v3 2/5] SUNRPC: Send RPC message on TCP with a single
 sock_sendmsg() call
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Wed, 19 Jul 2023 14:31:09 -0400
Message-ID: <168979146971.1905271.4709699930756258041.stgit@morisot.1015granger.net>
In-Reply-To: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
References: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
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
message on TCP. The whole message can be more efficiently sent with
a single call to sock_sendmsg() using a bio_vec iterator.

Note that this also helps with RPC-with-TLS: the TLS implementation
can now clearly see where the upper layer message boundaries are.
Before, it would send each component of the xdr_buf (record marker,
head, page payload, tail) in separate TLS records.

Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |    2 ++
 net/sunrpc/svcsock.c           |   33 ++++++++++++++++++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index a7116048a4d4..caf3308f1f07 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -38,6 +38,8 @@ struct svc_sock {
 	/* Number of queued send requests */
 	atomic_t		sk_sendqlen;
 
+	struct page_frag_cache  sk_frag_cache;
+
 	struct completion	sk_handshake_done;
 
 	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 90b1ab95c223..d4d816036c04 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1213,31 +1213,30 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
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
+	void *buf;
 	int ret;
 
 	*sentp = 0;
 
-	ret = kernel_sendmsg(svsk->sk_sock, &msg, &rm, 1, rm.iov_len);
-	if (ret < 0)
-		return ret;
-	*sentp += ret;
-	if (ret != rm.iov_len)
-		return -EAGAIN;
+	/* The stream record marker is copied into a temporary page
+	 * fragment buffer so that it can be included in rq_bvec.
+	 */
+	buf = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
+			      GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	memcpy(buf, &marker, sizeof(marker));
+	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec, ARRAY_SIZE(rqstp->rq_bvec),
-				&rqstp->rq_res);
+	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1,
+				ARRAY_SIZE(rqstp->rq_bvec) - 1, &rqstp->rq_res);
 
-	msg.msg_flags = MSG_SPLICE_PAGES;
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
-		      count, rqstp->rq_res.len);
+		      1 + count, sizeof(marker) + rqstp->rq_res.len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
 	if (ret < 0)
 		return ret;
@@ -1616,6 +1615,7 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
+	struct page_frag_cache *pfc = &svsk->sk_frag_cache;
 	struct socket *sock = svsk->sk_sock;
 
 	trace_svcsock_free(svsk, sock);
@@ -1625,5 +1625,8 @@ static void svc_sock_free(struct svc_xprt *xprt)
 		sockfd_put(sock);
 	else
 		sock_release(sock);
+	if (pfc->va)
+		__page_frag_cache_drain(virt_to_head_page(pfc->va),
+					pfc->pagecnt_bias);
 	kfree(svsk);
 }


