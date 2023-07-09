Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFE74C7F7
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 22:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGIUFD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIUFC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 16:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F47CFE
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 13:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D87AF60C20
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 20:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1228CC433C7;
        Sun,  9 Jul 2023 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688933100;
        bh=ZXO4VBboXz6nwlfOObYIiSKQYzW7iklyQb04SlyKTsU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P33eoAx7wzlz5LAh3FNKJ0NmB8Zb4ZxxDaMwHoN6yQFhM8frKbr/b4+hmKJjJD9aL
         wOCGicAbYLOCg6LpTG1KVJt2QaPsj/ELZx+LL9DmRbL96iT17aHvoh73eeyZC4Ol5x
         9u0813/AGyYY+jzgs+0ZprV/6dXiRvwf8w60NwV2mzua3nKJ7xhvAbtVhWp4UvGUav
         0K2r8QzeZ3EeUowpYGVWEuKuGtDTVcrX6PG4DWZeS13zg36MUaLEx+N1SBPZgfTgHa
         aIviv5PoHoRUCS5bCQyX2wpbPQxPhKiIUyJ8mfzxjFQqP0oGWKxlreK8MNrG9TUlbG
         Rs3QFpLvbWlRg==
Subject: [PATCH RFC 1/4] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs
 directly
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Sun, 09 Jul 2023 16:04:59 -0400
Message-ID: <168893309913.1949.840437707678733371.stgit@manet.1015granger.net>
In-Reply-To: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
References: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Add a helper to convert a whole xdr_buf directly into an array of
bio_vecs, then send this array instead of iterating piecemeal over
the xdr_buf containing the outbound RPC message.

Note that the rules of the RPC protocol mean there can be only one
outstanding send at a time on a transport socket. The kernel's
SunRPC server enforces this via the transport's xpt_mutex. Thus we
can use a per-transport shared array for the xdr_buf conversion
rather than allocate one every time or use one that is part of
struct svc_rqst.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |    3 +
 net/sunrpc/svcsock.c           |   93 +++++++++++++++++++++++-----------------
 2 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index a7116048a4d4..a9bfeadf4cbe 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -40,6 +40,9 @@ struct svc_sock {
 
 	struct completion	sk_handshake_done;
 
+	struct bio_vec		sk_send_bvec[RPCSVC_MAXPAGES]
+						____cacheline_aligned;
+
 	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
 };
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e43f26382411..d3c5f1a07979 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -188,6 +188,42 @@ static int svc_sock_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 	return 0;
 }
 
+static unsigned int svc_sock_xdr_to_bvecs(struct bio_vec *bvec,
+					  struct xdr_buf *xdr)
+{
+	const struct kvec *head = xdr->head;
+	const struct kvec *tail = xdr->tail;
+	unsigned int count = 0;
+
+	if (head->iov_len) {
+		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
+		count++;
+	}
+
+	if (xdr->page_len) {
+		unsigned int offset, len, remaining;
+		struct page **pages = xdr->pages;
+
+		offset = offset_in_page(xdr->page_base);
+		remaining = xdr->page_len;
+		while (remaining > 0) {
+			len = min_t(unsigned int, remaining,
+				    PAGE_SIZE - offset);
+			bvec_set_page(bvec++, *pages++, len, offset);
+			remaining -= len;
+			offset = 0;
+			count++;
+		}
+	}
+
+	if (tail->iov_len) {
+		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
+		count++;
+	}
+
+	return count;
+}
+
 /*
  * Report socket names for nfsdfs
  */
@@ -1194,72 +1230,50 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	return 0;	/* record not complete */
 }
 
-static int svc_tcp_send_kvec(struct socket *sock, const struct kvec *vec,
-			      int flags)
-{
-	struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES | flags, };
-
-	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 1, vec->iov_len);
-	return sock_sendmsg(sock, &msg);
-}
-
 /*
  * MSG_SPLICE_PAGES is used exclusively to reduce the number of
  * copy operations in this path. Therefore the caller must ensure
  * that the pages backing @xdr are unchanging.
  *
- * In addition, the logic assumes that * .bv_len is never larger
- * than PAGE_SIZE.
+ * Note that the send is non-blocking. The caller has incremented
+ * the reference count on each page backing the RPC message, and
+ * the network layer will "put" these pages when transmission is
+ * complete.
+ *
+ * This is safe for our RPC services because the memory backing
+ * the head and tail components is never kmalloc'd. These always
+ * come from pages in the svc_rqst::rq_pages array.
  */
-static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
+static int svc_tcp_sendmsg(struct svc_sock *svsk, struct xdr_buf *xdr,
 			   rpc_fraghdr marker, unsigned int *sentp)
 {
-	const struct kvec *head = xdr->head;
-	const struct kvec *tail = xdr->tail;
 	struct kvec rm = {
 		.iov_base	= &marker,
 		.iov_len	= sizeof(marker),
 	};
 	struct msghdr msg = {
-		.msg_flags	= 0,
+		.msg_flags	= MSG_MORE,
 	};
+	unsigned int count;
 	int ret;
 
 	*sentp = 0;
-	ret = xdr_alloc_bvec(xdr, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
 
-	ret = kernel_sendmsg(sock, &msg, &rm, 1, rm.iov_len);
+	ret = kernel_sendmsg(svsk->sk_sock, &msg, &rm, 1, rm.iov_len);
 	if (ret < 0)
 		return ret;
 	*sentp += ret;
 	if (ret != rm.iov_len)
 		return -EAGAIN;
 
-	ret = svc_tcp_send_kvec(sock, head, 0);
-	if (ret < 0)
-		return ret;
-	*sentp += ret;
-	if (ret != head->iov_len)
-		goto out;
-
+	count = svc_sock_xdr_to_bvecs(svsk->sk_send_bvec, xdr);
 	msg.msg_flags = MSG_SPLICE_PAGES;
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
-		      xdr_buf_pagecount(xdr), xdr->page_len);
-	ret = sock_sendmsg(sock, &msg);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
+		      count, xdr->len);
+	ret = sock_sendmsg(svsk->sk_sock, &msg);
 	if (ret < 0)
 		return ret;
 	*sentp += ret;
-
-	if (tail->iov_len) {
-		ret = svc_tcp_send_kvec(sock, tail, 0);
-		if (ret < 0)
-			return ret;
-		*sentp += ret;
-	}
-
-out:
 	return 0;
 }
 
@@ -1290,8 +1304,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 	tcp_sock_set_cork(svsk->sk_sk, true);
-	err = svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
-	xdr_free_bvec(xdr);
+	err = svc_tcp_sendmsg(svsk, xdr, marker, &sent);
 	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))
 		goto out_close;


