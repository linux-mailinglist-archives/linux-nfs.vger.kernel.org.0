Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14B1D00C4
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgELVX6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731308AbgELVX6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF8C061A0C;
        Tue, 12 May 2020 14:23:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l1so8930291qtp.6;
        Tue, 12 May 2020 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SckrKGeb70N9IZUWgmauTBxdU9UMVK6bfHfwmMpZ4q8=;
        b=WJMBDgP/z8519tzkcS5iO2TRmkNNij1a6ZVqEVv/FqcRCQkIAOcHPWH9kKaiCvdE17
         BJY7kXzQAbT75fUy3nBQoxZngjrxdyzYeK/5GPLH0rYSozwUIxM2p6b0Yh5/ml4aA6zK
         dt4BW5sbsqCJ+/2j71Aq78v0KIIX6SzLne/b29FVJITdaWwuaAMjf9BtQt2crnTbbFB/
         6mUqPRgxFNdx7eYWjqXMjoNIdlyAHkmgFYOwpCkOBimx89aJC3nPkpqHFGMKyFAlRyOf
         n4Kc5nGxtvlx5OrhiD6tnFtpXyh+PgzZaonYIa+5xYj/5tbrf63ZNTBCiVrsXElTSPl9
         /8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SckrKGeb70N9IZUWgmauTBxdU9UMVK6bfHfwmMpZ4q8=;
        b=U7nWhn7zO0t5cac4BVX0hjZpSRqqyhDKoLQFXqpINR7ZAT9rtV7zZw5oy8Un+cweb1
         /GcCQAFNTcq4VBNoF18OUUPNaLbwLdfcTsh0t75lUEShybCOBcNoW9ToMnSS7F/xHHs4
         KnixrhqhZ3d2xGD3NZhP+/32oy+Barwq6gYjOwdWDQauhFfnDdLEuK0s5BSPiJEjvW39
         kOf6o5WyV25VtoM4khLVg/ua6mGmJGWdukfARRbbwNOEH3rOlhIEmsTetiax7LgpCLQt
         Mrbz2zaStXSIgWY27S+MJv16tvtMmhEpGtBBh06YxecKTJkDrzQuAPfJhOzvrcJMAXTa
         fx5Q==
X-Gm-Message-State: AOAM5302NDTPNnPS2nrqjLiFy3LmRuUjrQsX1dCtHtqe7J03SdQ4LW8o
        qUTERHM6KI359zi/WOfr/BAV9y5w
X-Google-Smtp-Source: ABdhPJzkHZzShywYEf5YzOahvwdY6Eb37QwPF14tW7RP+Dkbp3og1Lkb6mAaiL9nFEn8KRajkRt7jA==
X-Received: by 2002:ac8:7591:: with SMTP id s17mr884997qtq.17.1589318636492;
        Tue, 12 May 2020 14:23:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d142sm12080372qkg.64.2020.05.12.14.23.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:23:56 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLNt93009939;
        Tue, 12 May 2020 21:23:55 GMT
Subject: [PATCH v2 21/29] SUNRPC: Refactor svc_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:23:55 -0400
Message-ID: <20200512212355.5826.95185.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
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
 include/linux/sunrpc/svc.h    |    1 
 include/trace/events/sunrpc.h |    1 
 net/sunrpc/svcsock.c          |  190 +++++++++++++++++++++--------------------
 3 files changed, 99 insertions(+), 93 deletions(-)

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
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ec4ae34a1f84..bfea554bd91f 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1502,6 +1502,7 @@ DECLARE_EVENT_CLASS(svcsock_class,
 
 DEFINE_SVCSOCK_EVENT(udp_send);
 DEFINE_SVCSOCK_EVENT(tcp_send);
+DEFINE_SVCSOCK_EVENT(tcp_recv);
 DEFINE_SVCSOCK_EVENT(data_ready);
 DEFINE_SVCSOCK_EVENT(write_space);
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 9c1eb13aa9b8..f482cfd0d49d 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -109,19 +109,15 @@ static void svc_reclassify_socket(struct socket *sock)
 }
 #endif
 
-/*
- * Release an skbuff after use
- */
-static void svc_release_skb(struct svc_rqst *rqstp)
+static void svc_tcp_release_rqst(struct svc_rqst *rqstp)
 {
 	struct sk_buff *skb = rqstp->rq_xprt_ctxt;
 
 	if (skb) {
 		struct svc_sock *svsk =
 			container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
-		rqstp->rq_xprt_ctxt = NULL;
 
-		dprintk("svc: service %p, releasing skb %p\n", rqstp, skb);
+		rqstp->rq_xprt_ctxt = NULL;
 		skb_free_datagram_locked(svsk->sk_sk, skb);
 	}
 }
@@ -219,34 +215,60 @@ static int svc_one_sock_name(struct svc_sock *svsk, char *buf, int remaining)
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
 
-	rqstp->rq_xprt_hlen = 0;
+	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE) {
+		bvec[i].bv_page = rqstp->rq_pages[i];
+		bvec[i].bv_len = PAGE_SIZE;
+		bvec[i].bv_offset = 0;
+	}
+	rqstp->rq_respages = &rqstp->rq_pages[i];
+	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
-	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
-	iov_iter_kvec(&msg.msg_iter, READ, iov, nr, buflen);
-	if (base != 0) {
-		iov_iter_advance(&msg.msg_iter, base);
-		buflen -= base;
+	iov_iter_bvec(&msg.msg_iter, READ, bvec, i, buflen);
+	if (seek) {
+		iov_iter_advance(&msg.msg_iter, seek);
+		buflen -= seek;
 	}
 	len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
-	/* If we read a full record, then assume there may be more
-	 * data to read (stream based sockets only!)
-	 */
-	if (len == buflen)
-		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+	if (len < 0)
+		return len;
 
-	dprintk("svc: socket %p recvfrom(%p, %zu) = %zd\n",
-		svsk, iov[0].iov_base, iov[0].iov_len, len);
+	svc_flush_bvec(bvec, len, seek);
+	trace_svcsock_tcp_recv(&svsk->sk_xprt, len);
 	return len;
 }
 
@@ -773,18 +795,18 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
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
-		return 0;
-	len = svsk->sk_datalen;
+	if (!len)
+		return len;
 	npages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	for (i = 0; i < npages; i++) {
 		if (rqstp->rq_pages[i] != NULL)
 			put_page(rqstp->rq_pages[i]);
-		BUG_ON(svsk->sk_pages[i] == NULL);
 		rqstp->rq_pages[i] = svsk->sk_pages[i];
 		svsk->sk_pages[i] = NULL;
 	}
@@ -915,49 +937,40 @@ static int receive_cb_reply(struct svc_sock *svsk, struct svc_rqst *rqstp)
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
-	dprintk("svc: TCP %s record (%d bytes)\n",
-		svc_sock_final_rec(svsk) ? "final" : "nonfinal",
-		svc_sock_reclen(svsk));
 	svsk->sk_tcplen = 0;
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
-
-	dprintk("svc: tcp_recv %p data %d conn %d close %d\n",
-		svsk, test_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags),
-		test_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags),
-		test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags));
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	len = svc_tcp_read_marker(svsk, rqstp);
@@ -966,38 +979,19 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 
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
 		svsk->sk_tcplen += len;
 		svsk->sk_datalen += len;
 	}
-	if (len != want || !svc_sock_final_rec(svsk)) {
-		svc_tcp_save_pages(svsk, rqstp);
-		if (len < 0 && len != -EAGAIN)
-			goto err_delete;
-		if (len == want)
-			svc_tcp_fragment_received(svsk);
-		else
-			dprintk("svc: incomplete TCP record (%d of %d)\n",
-				(int)(svsk->sk_tcplen - sizeof(rpc_fraghdr)),
-				svc_sock_reclen(svsk));
-		goto err_noclose;
-	}
-
-	if (svsk->sk_datalen < 8) {
-		svsk->sk_datalen = 0;
-		goto err_delete; /* client is nuts. */
-	}
+	if (len != want || !svc_sock_final_rec(svsk))
+		goto err_incomplete;
+	if (svsk->sk_datalen < 8)
+		goto err_nuts;
 
+	/*
+	 * At this point, a full stream RPC record has been read.
+	 */
 	rqstp->rq_arg.len = svsk->sk_datalen;
 	rqstp->rq_arg.page_base = 0;
 	if (rqstp->rq_arg.len <= rqstp->rq_arg.head[0].iov_len) {
@@ -1005,7 +999,6 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		rqstp->rq_arg.page_len = 0;
 	} else
 		rqstp->rq_arg.page_len = rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
-
 	rqstp->rq_xprt_ctxt   = NULL;
 	rqstp->rq_prot	      = IPPROTO_TCP;
 	if (test_bit(XPT_LOCAL, &svsk->sk_xprt.xpt_flags))
@@ -1018,7 +1011,13 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	if (calldir)
 		len = receive_cb_reply(svsk, rqstp);
 
-	/* Reset TCP read info */
+	/*
+	 * Force another call to svc_tcp_recvfrom to check for
+	 * more data waiting on the socket.
+	 */
+	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+
+	/* Reset TCP read info to prepare for the next record */
 	svsk->sk_datalen = 0;
 	svc_tcp_fragment_received(svsk);
 
@@ -1028,20 +1027,25 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	svc_xprt_copy_addrs(rqstp, &svsk->sk_xprt);
 	if (serv->sv_stats)
 		serv->sv_stats->nettcpcnt++;
-
 	return rqstp->rq_arg.len;
 
+err_incomplete:
+	svc_tcp_save_pages(svsk, rqstp);
+	if (len < 0 && len != -EAGAIN)
+		goto err_delete;
+	if (len == want)
+		svc_tcp_fragment_received(svsk);
+	return 0;
 error:
 	if (len != -EAGAIN)
 		goto err_delete;
-	dprintk("RPC: TCP recvfrom got EAGAIN\n");
 	return 0;
+err_nuts:
+	svsk->sk_datalen = 0;
 err_delete:
-	printk(KERN_NOTICE "%s: recvfrom returned errno %d\n",
-	       svsk->sk_xprt.xpt_server->sv_name, -len);
+	pr_notice("%s: recvfrom returns %zd\n", serv->sv_name, len);
 	set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
-err_noclose:
-	return 0;	/* record not complete */
+	return 0;
 }
 
 /**
@@ -1066,7 +1070,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	unsigned int uninitialized_var(sent);
 	int err;
 
-	svc_release_skb(rqstp);
+	svc_tcp_release_rqst(rqstp);
 
 	mutex_lock(&xprt->xpt_mutex);
 	if (svc_xprt_is_dead(xprt))
@@ -1106,7 +1110,7 @@ static const struct svc_xprt_ops svc_tcp_ops = {
 	.xpo_recvfrom = svc_tcp_recvfrom,
 	.xpo_sendto = svc_tcp_sendto,
 	.xpo_read_payload = svc_sock_read_payload,
-	.xpo_release_rqst = svc_release_skb,
+	.xpo_release_rqst = svc_tcp_release_rqst,
 	.xpo_detach = svc_tcp_sock_detach,
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_tcp_has_wspace,

