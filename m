Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01291E91A9
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgE3NaT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3NaT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:19 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0260CC03E969;
        Sat, 30 May 2020 06:30:18 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so5237932ilg.0;
        Sat, 30 May 2020 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zgLa7cSUPaaRWNelfv+DXK2nedeuxmo53QNSVVlQQaY=;
        b=dJ/oVMReugodZVeGxnmvlUEoUcI9fzN1DU4hF5/rVOu0n1eXkJKRBeIydB5Zq3eyrD
         FD03T8Pm4pejbQP1qc/IPLF/nvGEfksCbkEEZFUrSB+JhGetCbp9b+18wOsPlkf3mmim
         KzwIy4iuxH41xuVX6UdTYiQU0XNulto/0cZZk58haFnPJT8fyVGl8MofCsHNXU6m9YPI
         7+dWxU9h9CuUUIMLQ7nzIWaw6q1UOwzrIQR1Xg32xLTly9wG14sn7PUgANi9X24WH1Gl
         vg60E1asEqGuWz+cT7fPmXZDKQ6b69j9yzP2LxfwmA7zKZ6XqzTtOafQwsB/td6/aTYc
         7I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zgLa7cSUPaaRWNelfv+DXK2nedeuxmo53QNSVVlQQaY=;
        b=uRIiGnOcCxQdUK/ybO9hPUHRWt39FzYvJ+u1lL78ta4F/vxzb8wBvXAVXSgj5EFbU9
         9jnovgCZWPrrk5K5AQWpqS0VQy1TePv1aWvOmkwTLEcm57s5JIkTy4GTKSIPuMec6zvC
         /MwmjDo5tbhxeKyuU05M7z8XNdi2fneyiPxo0dRCNUsDuT0e+XUrv752+QuEjyoQPHXw
         qi/qIkcgp9s4+87Eu9Jz8rb6P+Yn3+pLMKNAhuvJj4sHLb0G6gNENKfKdKZ/m/R9H4us
         rPUwVj15EweAJb8zNWZRH7NE0av3nmAvObPokLfJgGWeEm+gmmgQpdiGHGyyVf/PEf2R
         zNHw==
X-Gm-Message-State: AOAM53036NKg+PdFzeBgMMlZJ4hCeCxA+3Q4jxFA0FvYfc6pQXHItwoF
        fjwIFGmfC9ceBNfCogM32j97h23+
X-Google-Smtp-Source: ABdhPJyF4Jo/pqwiovqSgUOaCeJdTxEowuEMvF1p6d0IkE0y6jqUCrTNICVYIZRvmCfRPHwnKKN9CA==
X-Received: by 2002:a92:8b43:: with SMTP id i64mr12791389ild.171.1590845417046;
        Sat, 30 May 2020 06:30:17 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p22sm6379770ill.52.2020.05.30.06.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:16 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDUFsq001468;
        Sat, 30 May 2020 13:30:15 GMT
Subject: [PATCH v4 25/33] SUNRPC: Refactor svc_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:15 -0400
Message-ID: <20200530133015.10117.6203.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
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

