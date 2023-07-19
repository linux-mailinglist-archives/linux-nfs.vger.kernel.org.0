Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888F759D4B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 20:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGSSbH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 14:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGSSbG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 14:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D908B6
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 11:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AAF8617CB
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 18:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F0BC433C7;
        Wed, 19 Jul 2023 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689791464;
        bh=KrJj4+pL0evET4lNB4XmU8HTBeucyH/G6HXyAGz3KOc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mGZrVzGjOJCcatVdlbT5QfdJTYblP/mYuxItTfbjWQSDnii+nStm2mcT9ag62v0kD
         jZraYgOYxUbjY1S/ZHXPgBDinyi2RyHj83rktPbsL+hxQ0kaAj3z9MlaAgvVyw6b6n
         FD6dAxUguGkzhB1l+3ZCcrk3/G7XUKd2Ymx7D5YgsYNDxWvS79mG+4M4aem9z5fo04
         mtisYdCOwYjuZCsMNuLuw1nmiw8pDz3hDExt9XyvEsUhjLfp8ewR9lPzNF30shvEGA
         BUB+0W1NxVfHxJIjDGgJjJ9ObyL7PkkLvzxAPviuyUG+2e3CfzSxKLRJINW8WB5PR4
         jWdLU0WAfCn5w==
Subject: [PATCH v3 1/5] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs
 directly
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Wed, 19 Jul 2023 14:31:03 -0400
Message-ID: <168979146324.1905271.11000616800905663660.stgit@morisot.1015granger.net>
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

Add a helper to convert a whole xdr_buf directly into an array of
bio_vecs, then send this array instead of iterating piecemeal over
the xdr_buf containing the outbound RPC message.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |    2 +
 net/sunrpc/svcsock.c       |   59 +++++++++++++++-----------------------------
 net/sunrpc/xdr.c           |   50 +++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 39 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f89ec4b5ea16..42f9d7eb9a1a 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -139,6 +139,8 @@ void	xdr_terminate_string(const struct xdr_buf *, const u32);
 size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
 int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
 void	xdr_free_bvec(struct xdr_buf *buf);
+unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
+			     const struct xdr_buf *xdr);
 
 static inline __be32 *xdr_encode_array(__be32 *p, const void *s, unsigned int len)
 {
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e43f26382411..90b1ab95c223 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -36,6 +36,8 @@
 #include <linux/skbuff.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
+#include <linux/bvec.h>
+
 #include <net/sock.h>
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -1194,72 +1196,52 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
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
+static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
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
+	count = xdr_buf_to_bvec(rqstp->rq_bvec, ARRAY_SIZE(rqstp->rq_bvec),
+				&rqstp->rq_res);
 
 	msg.msg_flags = MSG_SPLICE_PAGES;
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
-		      xdr_buf_pagecount(xdr), xdr->page_len);
-	ret = sock_sendmsg(sock, &msg);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+		      count, rqstp->rq_res.len);
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
 
@@ -1290,8 +1272,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 	tcp_sock_set_cork(svsk->sk_sk, true);
-	err = svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
-	xdr_free_bvec(xdr);
+	err = svc_tcp_sendmsg(svsk, rqstp, marker, &sent);
 	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))
 		goto out_close;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 2a22e78af116..358e6de91775 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -164,6 +164,56 @@ xdr_free_bvec(struct xdr_buf *buf)
 	buf->bvec = NULL;
 }
 
+/**
+ * xdr_buf_to_bvec - Copy components of an xdr_buf into a bio_vec array
+ * @bvec: bio_vec array to populate
+ * @bvec_size: element count of @bio_vec
+ * @xdr: xdr_buf to be copied
+ *
+ * Returns the number of entries consumed in @bvec.
+ */
+unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
+			     const struct xdr_buf *xdr)
+{
+	const struct kvec *head = xdr->head;
+	const struct kvec *tail = xdr->tail;
+	unsigned int count = 0;
+
+	if (head->iov_len) {
+		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
+		++count;
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
+			if (unlikely(++count > bvec_size))
+				goto bvec_overflow;
+		}
+	}
+
+	if (tail->iov_len) {
+		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
+		if (unlikely(++count > bvec_size))
+			goto bvec_overflow;
+	}
+
+	return count;
+
+bvec_overflow:
+	pr_warn_once("%s: bio_vec array overflow\n", __func__);
+	return count - 1;
+}
+
 /**
  * xdr_inline_pages - Prepare receive buffer for a large reply
  * @xdr: xdr_buf into which reply will be placed


