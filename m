Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1852159E38
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 01:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgBLAmv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 19:42:51 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33416 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBLAmv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Feb 2020 19:42:51 -0500
Received: by mail-yb1-f195.google.com with SMTP id b6so108017ybr.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2020 16:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d8/KoH4fCVMLaTnRkyr1pHTxCDrPNq3dRhe7mhKYA4U=;
        b=mI08M6EfpUB6XADs5NmxZTuLjZH0PfFrJGoRxaFyBURzBbA1sQFbgbG67ggQuQVS9V
         WM+EbX0HnLRs9XfljsBIIWWKwhnaBYJnxOuWWMhgTB1kPwrqGmA7K2id4j4KrS5pFnIo
         EYFBzNe5JFeXUUa7vNO2EMDcj0eUk7jOT0vBpWV8SkG01+rSz9BFQaFBG6Oqt4W2pUP8
         YA9Elz1W9Ha1cydhzxx9X5hIG+aWJA1V2KluNWXZgzVhJNf7Ng5oQ3Wlal/YQRVD/aDl
         EMB7qTxZIe6+2mcW5CsmK4OZ62MZiCXFboYcXQ7akg6++lzShN2r4GA7CM+S7BLXWTbw
         BQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=d8/KoH4fCVMLaTnRkyr1pHTxCDrPNq3dRhe7mhKYA4U=;
        b=Yir6+50hROxYJJ2stm6czDMLerO78knp6d46UquTjm+IENcTHhb4bnIJFB05rXpWuq
         DEGfmci8qkqXbSxtgMxzeD/Lui9RsB8arz6w1Nt5n2wvp7abzS3fBd/BgtkCokPDINeR
         RfVM+Qrfa89IM/8vh8sERCA9xxa1O8MNetx2HVi80QbTGyxaqHtwE5WEu+e3UUs4iJLk
         7l5U1eE/rxI0z938jEEFmAKCw8sbGAZhp/lvbg/o9GnynjZQoypumk3Pmwt/lTLtI/y0
         5+QC6bczd6/oEHfN91Yv5oI1Puq3okGEXuwNzTfiC2Jg+K5SFqieiUMTuhsEtl8TWt5Q
         fTEg==
X-Gm-Message-State: APjAAAXK3m98hL88qjUSWZ3GlYvZxjEdM4w7m9AknanJFz+oy5njZL8i
        u1Pz9jSRwKTfItFGBBDyOdEVTQrR
X-Google-Smtp-Source: APXvYqyPbKLGa6TQaecE8rV6xOhnLvQzhKUsNnwRJC6VB9TbCdi19bz4iLZK4EdXl7WDF28oxeUYAw==
X-Received: by 2002:a25:b68a:: with SMTP id s10mr8957939ybj.257.1581468169308;
        Tue, 11 Feb 2020 16:42:49 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l74sm2775637ywc.45.2020.02.11.16.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:42:48 -0800 (PST)
Subject: [PATCH RFC 3/3] SUNRPC: Teach server to use xprt_sock_sendmsg for
 socket sends
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 11 Feb 2020 19:42:48 -0500
Message-ID: <20200212004248.2305.98816.stgit@bazille.1015granger.net>
In-Reply-To: <20200212003607.2305.38250.stgit@bazille.1015granger.net>
References: <20200212003607.2305.38250.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

xprt_sock_sendmsg uses the more efficient iov_iter-enabled kernel
socket API, and is a pre-requisite for server send-side support for
TLS.

Note that svc_process no longer needs to reserve a word for the
stream record marker, since the TCP transport now provides the
record marker automatically in a separate buffer.

The dprintk() in svc_send_common is also removed. It didn't seem
crucial for field troubleshooting. If more is needed there, a trace
point could be added in xprt_sock_sendmsg().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/sunrpc.h   |    4 -
 net/sunrpc/svc.c      |    4 -
 net/sunrpc/svcsock.c  |  202 ++++++++++++++++---------------------------------
 net/sunrpc/xprtsock.c |   39 ++-------
 4 files changed, 74 insertions(+), 175 deletions(-)

diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
index c9bacb3c930f..47a756503d11 100644
--- a/net/sunrpc/sunrpc.h
+++ b/net/sunrpc/sunrpc.h
@@ -50,10 +50,6 @@ static inline int sock_is_loopback(struct sock *sk)
 	return loopback;
 }
 
-int svc_send_common(struct socket *sock, struct xdr_buf *xdr,
-		    struct page *headpage, unsigned long headoffset,
-		    struct page *tailpage, unsigned long tailoffset);
-
 int rpc_clients_notifier_register(void);
 void rpc_clients_notifier_unregister(void);
 #endif /* _NET_SUNRPC_SUNRPC_H */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d4a0134f1ca1..73b536cdb818 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1529,10 +1529,6 @@ static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ..
 		goto out_drop;
 	}
 
-	/* Reserve space for the record marker */
-	if (rqstp->rq_prot == IPPROTO_TCP)
-		svc_putnl(resv, 0);
-
 	/* Returns 1 for send, 0 for drop */
 	if (likely(svc_process_common(rqstp, argv, resv)))
 		return svc_send(rqstp);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 47957088d7d3..4d2bdce48b64 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -175,111 +175,6 @@ static void svc_set_cmsg_data(struct svc_rqst *rqstp, struct cmsghdr *cmh)
 	}
 }
 
-/*
- * send routine intended to be shared by the fore- and back-channel
- */
-int svc_send_common(struct socket *sock, struct xdr_buf *xdr,
-		    struct page *headpage, unsigned long headoffset,
-		    struct page *tailpage, unsigned long tailoffset)
-{
-	int		result;
-	int		size;
-	struct page	**ppage = xdr->pages;
-	size_t		base = xdr->page_base;
-	unsigned int	pglen = xdr->page_len;
-	unsigned int	flags = MSG_MORE | MSG_SENDPAGE_NOTLAST;
-	int		slen;
-	int		len = 0;
-
-	slen = xdr->len;
-
-	/* send head */
-	if (slen == xdr->head[0].iov_len)
-		flags = 0;
-	len = kernel_sendpage(sock, headpage, headoffset,
-				  xdr->head[0].iov_len, flags);
-	if (len != xdr->head[0].iov_len)
-		goto out;
-	slen -= xdr->head[0].iov_len;
-	if (slen == 0)
-		goto out;
-
-	/* send page data */
-	size = PAGE_SIZE - base < pglen ? PAGE_SIZE - base : pglen;
-	while (pglen > 0) {
-		if (slen == size)
-			flags = 0;
-		result = kernel_sendpage(sock, *ppage, base, size, flags);
-		if (result > 0)
-			len += result;
-		if (result != size)
-			goto out;
-		slen -= size;
-		pglen -= size;
-		size = PAGE_SIZE < pglen ? PAGE_SIZE : pglen;
-		base = 0;
-		ppage++;
-	}
-
-	/* send tail */
-	if (xdr->tail[0].iov_len) {
-		result = kernel_sendpage(sock, tailpage, tailoffset,
-				   xdr->tail[0].iov_len, 0);
-		if (result > 0)
-			len += result;
-	}
-
-out:
-	return len;
-}
-
-
-/*
- * Generic sendto routine
- */
-static int svc_sendto(struct svc_rqst *rqstp, struct xdr_buf *xdr)
-{
-	struct svc_sock	*svsk =
-		container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
-	struct socket	*sock = svsk->sk_sock;
-	union {
-		struct cmsghdr	hdr;
-		long		all[SVC_PKTINFO_SPACE / sizeof(long)];
-	} buffer;
-	struct cmsghdr *cmh = &buffer.hdr;
-	int		len = 0;
-	unsigned long tailoff;
-	unsigned long headoff;
-	RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
-
-	if (rqstp->rq_prot == IPPROTO_UDP) {
-		struct msghdr msg = {
-			.msg_name	= &rqstp->rq_addr,
-			.msg_namelen	= rqstp->rq_addrlen,
-			.msg_control	= cmh,
-			.msg_controllen	= sizeof(buffer),
-			.msg_flags	= MSG_MORE,
-		};
-
-		svc_set_cmsg_data(rqstp, cmh);
-
-		if (sock_sendmsg(sock, &msg) < 0)
-			goto out;
-	}
-
-	tailoff = ((unsigned long)xdr->tail[0].iov_base) & (PAGE_SIZE-1);
-	headoff = 0;
-	len = svc_send_common(sock, xdr, rqstp->rq_respages[0], headoff,
-			       rqstp->rq_respages[0], tailoff);
-
-out:
-	dprintk("svc: socket %p sendto([%p %zu... ], %d) = %d (addr %s)\n",
-		svsk, xdr->head[0].iov_base, xdr->head[0].iov_len,
-		xdr->len, len, svc_print_addr(rqstp, buf, sizeof(buf)));
-
-	return len;
-}
-
 static void svc_sock_read_payload(struct svc_rqst *rqstp, unsigned int pos,
 				  unsigned long length)
 {
@@ -606,17 +501,45 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	return 0;
 }
 
-static int
-svc_udp_sendto(struct svc_rqst *rqstp)
+/**
+ * svc_udp_sendto - Send out a reply on a UDP socket
+ * @rqstp: completed svc_rqst
+ *
+ * Returns the number of bytes sent, or a negative errno.
+ */
+static int svc_udp_sendto(struct svc_rqst *rqstp)
 {
-	int		error;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct svc_sock	*svsk = container_of(xprt, struct svc_sock, sk_xprt);
+	struct xdr_buf *xdr = &rqstp->rq_res;
+	union {
+		struct cmsghdr	hdr;
+		long		all[SVC_PKTINFO_SPACE / sizeof(long)];
+	} buffer;
+	struct cmsghdr *cmh = &buffer.hdr;
+	struct msghdr msg = {
+		.msg_name	= &rqstp->rq_addr,
+		.msg_namelen	= rqstp->rq_addrlen,
+		.msg_control	= cmh,
+		.msg_controllen	= sizeof(buffer),
+	};
+	unsigned int sent;
+	int err;
 
-	error = svc_sendto(rqstp, &rqstp->rq_res);
-	if (error == -ECONNREFUSED)
-		/* ICMP error on earlier request. */
-		error = svc_sendto(rqstp, &rqstp->rq_res);
+	svc_set_cmsg_data(rqstp, cmh);
 
-	return error;
+	sent = 0;
+	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
+	xdr_free_bvec(xdr);
+	if (err == -ECONNREFUSED) {
+		/* ICMP error on earlier request. */
+		sent = 0;
+		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
+		xdr_free_bvec(xdr);
+	}
+	if (err < 0)
+		return err;
+	return sent;
 }
 
 static int svc_udp_has_wspace(struct svc_xprt *xprt)
@@ -1135,35 +1058,40 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	return 0;	/* record not complete */
 }
 
-/*
- * Send out data on TCP socket.
+/**
+ * svc_tcp_sendto - Send out a reply on a TCP socket
+ * @rqstp: completed svc_rqst
+ *
+ * Returns the number of bytes sent, or a negative errno.
  */
 static int svc_tcp_sendto(struct svc_rqst *rqstp)
 {
-	struct xdr_buf	*xbufp = &rqstp->rq_res;
-	int sent;
-	__be32 reclen;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct svc_sock	*svsk = container_of(xprt, struct svc_sock, sk_xprt);
+	struct xdr_buf *xdr = &rqstp->rq_res;
+	rpc_fraghdr marker = rpc_stream_record_marker(xdr->len);
+	struct msghdr msg = {
+		.msg_flags	= 0,
+	};
+	unsigned int sent;
+	int err;
 
-	/* Set up the first element of the reply kvec.
-	 * Any other kvecs that may be in use have been taken
-	 * care of by the server implementation itself.
-	 */
-	reclen = htonl(0x80000000|((xbufp->len ) - 4));
-	memcpy(xbufp->head[0].iov_base, &reclen, 4);
-
-	sent = svc_sendto(rqstp, &rqstp->rq_res);
-	if (sent != xbufp->len) {
-		printk(KERN_NOTICE
-		       "rpc-srv/tcp: %s: %s %d when sending %d bytes "
-		       "- shutting down socket\n",
-		       rqstp->rq_xprt->xpt_server->sv_name,
-		       (sent<0)?"got error":"sent only",
-		       sent, xbufp->len);
-		set_bit(XPT_CLOSE, &rqstp->rq_xprt->xpt_flags);
-		svc_xprt_enqueue(rqstp->rq_xprt);
-		sent = -EAGAIN;
-	}
+	sent = 0;
+	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, marker, &sent);
+	xdr_free_bvec(xdr);
+	if (err < 0 || sent != (xdr->len + sizeof(marker)))
+		goto out_close;
 	return sent;
+
+out_close:
+	pr_notice("rpc-srv/tcp: %s: %s %d when sending %d bytes "
+		  "- shutting down socket\n",
+		  xprt->xpt_server->sv_name,
+		  (err < 0) ? "got error" : "sent",
+		  (err < 0) ? err : sent, xdr->len);
+	set_bit(XPT_CLOSE, &xprt->xpt_flags);
+	svc_xprt_enqueue(xprt);
+	return -EAGAIN;
 }
 
 static struct svc_xprt *svc_tcp_create(struct svc_serv *serv,
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 0380d72d8485..4fc38bd2f41e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2517,45 +2517,24 @@ static void bc_free(struct rpc_task *task)
 	free_page((unsigned long)buf);
 }
 
-/*
- * Use the svc_sock to send the callback. Must be called with svsk->sk_mutex
- * held. Borrows heavily from svc_tcp_sendto and xs_tcp_send_request.
- */
 static int bc_sendto(struct rpc_rqst *req)
 {
-	int len;
-	struct xdr_buf *xbufp = &req->rq_snd_buf;
+	struct xdr_buf *xdr = &req->rq_snd_buf;
 	struct sock_xprt *transport =
 			container_of(req->rq_xprt, struct sock_xprt, xprt);
-	unsigned long headoff;
-	unsigned long tailoff;
-	struct page *tailpage;
 	struct msghdr msg = {
-		.msg_flags	= MSG_MORE
-	};
-	rpc_fraghdr marker = rpc_stream_record_marker(xbufp->len);
-	struct kvec iov = {
-		.iov_base	= &marker,
-		.iov_len	= sizeof(marker),
+		.msg_flags	= 0,
 	};
+	rpc_fraghdr marker = rpc_stream_record_marker(xdr->len);
+	unsigned int sent = 0;
+	int err;
 
 	req->rq_xtime = ktime_get();
-
-	len = kernel_sendmsg(transport->sock, &msg, &iov, 1, iov.iov_len);
-	if (len != iov.iov_len)
+	err = xprt_sock_sendmsg(transport->sock, &msg, xdr, 0, marker, &sent);
+	xdr_free_bvec(xdr);
+	if (err < 0 || sent != (xdr->len + sizeof(marker)))
 		return -EAGAIN;
-
-	tailpage = NULL;
-	if (xbufp->tail[0].iov_len)
-		tailpage = virt_to_page(xbufp->tail[0].iov_base);
-	tailoff = (unsigned long)xbufp->tail[0].iov_base & ~PAGE_MASK;
-	headoff = (unsigned long)xbufp->head[0].iov_base & ~PAGE_MASK;
-	len = svc_send_common(transport->sock, xbufp,
-			      virt_to_page(xbufp->head[0].iov_base), headoff,
-			      tailpage, tailoff);
-	if (len != xbufp->len)
-		return -EAGAIN;
-	return len;
+	return sent;
 }
 
 /*

