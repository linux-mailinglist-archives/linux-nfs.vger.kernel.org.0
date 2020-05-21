Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5269E1DD00B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgEUOfw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgEUOfw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:52 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096ECC061A0F;
        Thu, 21 May 2020 07:35:52 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so7694134ioj.1;
        Thu, 21 May 2020 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zgLa7cSUPaaRWNelfv+DXK2nedeuxmo53QNSVVlQQaY=;
        b=MH9AL0+Hd0i1PdeZjXhEnQNS3WOuE0yLCGOHIrWh9OK7aY3QRBPZmMt6mUXXZucX98
         Gj584xCDVyEO6pbm8ajA6kwo24QB4I/uJIYWNBpSj0p+/s7/dabV3Jwn3kB9CV7TX5Qx
         2CLqgbZ5fDsC9mExdplUGkTC5wKCmFRUUDOLvwhdk54hdCN6bcFLc1I2VStuGSL/j77n
         SKfo5eUKJVPA0EYeG7nv4B8x8DyDYi3ku3EEdoRvadoxqzt5UwsNhE8BefLnvU+rWyvb
         wYlNuGEJKmNieAXJfyAKY+uwT/+HYrX5RQBUgnxaC2QH+yznIgnvFdxQ1acWBceBP9gs
         m25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zgLa7cSUPaaRWNelfv+DXK2nedeuxmo53QNSVVlQQaY=;
        b=DUyk2b3uaeBwHVBXqnL7ustFlEAwxJdvdE7c8b0GM3HMy6mkKw7z/uja2KElm2I1kr
         VXUdJNka7ex1Csio/h2KYrPCtCDeEa083aDMsCot458bbwMYjBIyF3ztCyg20lQhnuTa
         HfRL5MrKXdz60+U3X806Fo7Xh5/H93p5HirknQUS8SzkBgpOw6FRBNhSJE0ZLvh0BiOq
         BQRNTMNLQjeNL823vf3DzuIrV8KxBxkcHqqAULif0r+R+LvUKR3T3t/8JsJe1oIsTNOP
         Ey3GWvYBtkIe9OBx/yWFKsrpkAVOQpUBPOxWSF6xFA8B4E4uM0e7Q+QswjzBrSnqq/lq
         FFYQ==
X-Gm-Message-State: AOAM5336xDgTTNcBG+bUU05tpyobmcus7krDz2OFbwoLHfQgte2aHipo
        6mz5/6M+mwEJHHQEypg9wNqxZFoN
X-Google-Smtp-Source: ABdhPJzf0zSuJ98qD1eOoXCmyWFJIa+wbCFizoxtv1oEglng+bnwhpHMunmsfVyleu/UTqx21kHO2A==
X-Received: by 2002:a6b:3787:: with SMTP id e129mr7707179ioa.83.1590071751089;
        Thu, 21 May 2020 07:35:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u203sm2378288iod.54.2020.05.21.07.35.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:50 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZnal000909;
        Thu, 21 May 2020 14:35:49 GMT
Subject: [PATCH v3 24/32] SUNRPC: Refactor svc_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:49 -0400
Message-ID: <20200521143549.3557.41493.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This function is not currently "generic" so remove the documenting
comment and rename it appropriately. Its internals are converted to
use bio_vecs for reading from the transport socket.

In existing typical sunrpc uses of bio_vecs, the bio_vec array is
allocated dynamically. Here, instead, an array of bio_vecs is added
to svc_rqst. The lifetime of this array can be greater than one call
to xpo_recvfrom():

- Multiple calls to xpo_recvfrom() might be needed to read an RPC
  message completely.

- At some later point, rq_arg.bvecs will point to this array and it
  will carry the received message into svc_process().

I also expect that a future optimization will remove either the
rq_vec or rq_pages array in favor of rq_bvec, thus conserving the
size of struct svc_rqst.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    1 
 net/sunrpc/svcsock.c       |  109 +++++++++++++++++++++++++++-----------------
 2 files changed, 69 insertions(+), 41 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index fd390894a584..05da19a0516d 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -254,6 +254,7 @@ struct svc_rqst {
 	struct page *		*rq_page_end;  /* one past the last page */
 
 	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
+	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 5b2981a0711c..3e25511b800e 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -223,26 +223,62 @@ static int svc_one_sock_name(struct svc_sock *svsk, char *buf, int remaining)
 	return len;
 }
 
+#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
+static void svc_flush_bvec(const struct bio_vec *bvec, size_t size, size_t seek)
+{
+	struct bvec_iter bi = {
+		.bi_size	= size,
+	};
+	struct bio_vec bv;
+
+	bvec_iter_advance(bvec, &bi, seek & PAGE_MASK);
+	for_each_bvec(bv, bvec, bi, bi)
+		flush_dcache_page(bv.bv_page);
+}
+#else
+static inline void svc_flush_bvec(const struct bio_vec *bvec, size_t size,
+				  size_t seek)
+{
+}
+#endif
+
 /*
- * Generic recvfrom routine.
+ * Read from @rqstp's transport socket. The incoming message fills whole
+ * pages in @rqstp's rq_pages array until the last page of the message
+ * has been received into a partial page.
  */
-static ssize_t svc_recvfrom(struct svc_rqst *rqstp, struct kvec *iov,
-			    unsigned int nr, size_t buflen, unsigned int base)
+static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
+				size_t seek)
 {
 	struct svc_sock *svsk =
 		container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
+	struct bio_vec *bvec = rqstp->rq_bvec;
 	struct msghdr msg = { NULL };
+	unsigned int i;
 	ssize_t len;
+	size_t t;
 
 	rqstp->rq_xprt_hlen = 0;
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
-	iov_iter_kvec(&msg.msg_iter, READ, iov, nr, buflen);
-	if (base != 0) {
-		iov_iter_advance(&msg.msg_iter, base);
-		buflen -= base;
+
+	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE) {
+		bvec[i].bv_page = rqstp->rq_pages[i];
+		bvec[i].bv_len = PAGE_SIZE;
+		bvec[i].bv_offset = 0;
+	}
+	rqstp->rq_respages = &rqstp->rq_pages[i];
+	rqstp->rq_next_page = rqstp->rq_respages + 1;
+
+	iov_iter_bvec(&msg.msg_iter, READ, bvec, i, buflen);
+	if (seek) {
+		iov_iter_advance(&msg.msg_iter, seek);
+		buflen -= seek;
 	}
 	len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
+	if (len > 0)
+		svc_flush_bvec(bvec, len, seek);
+
 	/* If we read a full record, then assume there may be more
 	 * data to read (stream based sockets only!)
 	 */
@@ -775,13 +811,14 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	return NULL;
 }
 
-static unsigned int svc_tcp_restore_pages(struct svc_sock *svsk, struct svc_rqst *rqstp)
+static size_t svc_tcp_restore_pages(struct svc_sock *svsk,
+				    struct svc_rqst *rqstp)
 {
-	unsigned int i, len, npages;
+	size_t len = svsk->sk_datalen;
+	unsigned int i, npages;
 
-	if (svsk->sk_datalen == 0)
+	if (!len)
 		return 0;
-	len = svsk->sk_datalen;
 	npages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	for (i = 0; i < npages; i++) {
 		if (rqstp->rq_pages[i] != NULL)
@@ -917,20 +954,6 @@ static int receive_cb_reply(struct svc_sock *svsk, struct svc_rqst *rqstp)
 	return -EAGAIN;
 }
 
-static int copy_pages_to_kvecs(struct kvec *vec, struct page **pages, int len)
-{
-	int i = 0;
-	int t = 0;
-
-	while (t < len) {
-		vec[i].iov_base = page_address(pages[i]);
-		vec[i].iov_len = PAGE_SIZE;
-		i++;
-		t += PAGE_SIZE;
-	}
-	return i;
-}
-
 static void svc_tcp_fragment_received(struct svc_sock *svsk)
 {
 	/* If we have more data, signal svc_xprt_enqueue() to try again */
@@ -938,20 +961,33 @@ static void svc_tcp_fragment_received(struct svc_sock *svsk)
 	svsk->sk_marker = xdr_zero;
 }
 
-/*
- * Receive data from a TCP socket.
+/**
+ * svc_tcp_recvfrom - Receive data from a TCP socket
+ * @rqstp: request structure into which to receive an RPC Call
+ *
+ * Called in a loop when XPT_DATA has been set.
+ *
+ * Read the 4-byte stream record marker, then use the record length
+ * in that marker to set up exactly the resources needed to receive
+ * the next RPC message into @rqstp.
+ *
+ * Returns:
+ *   On success, the number of bytes in a received RPC Call, or
+ *   %0 if a complete RPC Call message was not ready to return
+ *
+ * The zero return case handles partial receives and callback Replies.
+ * The state of a partial receive is preserved in the svc_sock for
+ * the next call to svc_tcp_recvfrom.
  */
 static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 {
 	struct svc_sock	*svsk =
 		container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
 	struct svc_serv	*serv = svsk->sk_xprt.xpt_server;
-	int		len;
-	struct kvec *vec;
-	unsigned int want, base;
+	size_t want, base;
+	ssize_t len;
 	__be32 *p;
 	__be32 calldir;
-	int pnum;
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	len = svc_tcp_read_marker(svsk, rqstp);
@@ -960,16 +996,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 
 	base = svc_tcp_restore_pages(svsk, rqstp);
 	want = len - (svsk->sk_tcplen - sizeof(rpc_fraghdr));
-
-	vec = rqstp->rq_vec;
-
-	pnum = copy_pages_to_kvecs(&vec[0], &rqstp->rq_pages[0], base + want);
-
-	rqstp->rq_respages = &rqstp->rq_pages[pnum];
-	rqstp->rq_next_page = rqstp->rq_respages + 1;
-
-	/* Now receive data */
-	len = svc_recvfrom(rqstp, vec, pnum, base + want, base);
+	len = svc_tcp_read_msg(rqstp, base + want, base);
 	if (len >= 0) {
 		trace_svcsock_tcp_recv(&svsk->sk_xprt, len);
 		svsk->sk_tcplen += len;

