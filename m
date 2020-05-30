Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0961E91A0
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgE3N36 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3N35 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:29:57 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1406C03E969;
        Sat, 30 May 2020 06:29:56 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so2252066iog.13;
        Sat, 30 May 2020 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UGeCaNUw1baTFMr8aLsMT+oTuq7LBd3E1BvlXLd5tK8=;
        b=q9IplURafcGZI580amAp65DnUoExuQTlALNrWzcvjRqUWRg6gAPwrXtz/QL2+0h1wz
         ohh9pq81BZxDkAnBBFwD6QNOs2SW7pega5HSiA6dw6VsZrVhUVDOgW7t+wi3pxhSj+Qd
         fB04qelpioZJ3xkcGOoR5/KRWjFYrR9AxjU4295+4O5/Z9XRwkYfqjhbUTsnl8y6H8Kw
         WKaHBmXLMNMVZP4eNpztNfDA+0+lzmdJs1fVLva/BP/ruMgl46EnsJ37i8GQsrdHdhAN
         1QqsZekEM00J1OjUg2bzehQOXxY40qZHMry8ohK7THOde6fiQIHBju1y86rs4KHLcfU+
         fzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UGeCaNUw1baTFMr8aLsMT+oTuq7LBd3E1BvlXLd5tK8=;
        b=XFIjGF/QSsXJAp2L8cVdb2BJuK8Eon2UIr3V0EhDl0XfnJMpeF+wVUHSJU9Xz4b42N
         IBP5fMrQnVtnjz4T1CO2+GStrq7pqfo8TISFN5B5VIIzVK3YRyJchb3R7L/fy8U8cEVg
         DZ2NCZ8I68+hySsqfr8/azS2/UTJVD4uPF3bc4KqtL4As2b92iyfNLfc31EBV6RN4auw
         n3X28qUj4bGRplg6zqW+ud8nY68fXAMKtSLNEhd6VY2NEXfX2/IOe6TkOl34DYCtsqqP
         cWtxg0TrZia961lUmP/4x5YonCNr1Okg3sc3jIUvNzZyUpFyiLiZQM4RHsX/EGPU4y8H
         hFNg==
X-Gm-Message-State: AOAM533OyRVa+BdOvbT8Ip893r6kkQgFWSWKdXfh6+dtGSjLBqepQdWg
        PKSIFPZ3vCQ/oTyyvBWtAHj8teDS
X-Google-Smtp-Source: ABdhPJw0R3ThdzVcYbBPSjN8uCX9ygcUMuDDhNseL65fJ8y57JhozrKwCZD4R0hqIzF2SKKjfcc2LQ==
X-Received: by 2002:a6b:5f06:: with SMTP id t6mr10692832iob.88.1590845395893;
        Sat, 30 May 2020 06:29:55 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u2sm4940267ion.50.2020.05.30.06.29.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:29:55 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDTsSu001447;
        Sat, 30 May 2020 13:29:54 GMT
Subject: [PATCH v4 21/33] SUNRPC: Restructure svc_tcp_recv_record()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:29:54 -0400
Message-ID: <20200530132954.10117.24715.stgit@klimt.1015granger.net>
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

Refactor: svc_recvfrom() is going to be converted to read into
bio_vecs in a moment. Unhook the only other caller,
svc_tcp_recv_record(), which just wants to read the 4-byte stream
record marker into a kvec.

While we're in the area, streamline this helper by straight-lining
the hot path, replace dprintk call sites with tracepoints, and
reduce the number of atomic bit operations in this path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   24 +++++++++++++++++++
 net/sunrpc/svcsock.c          |   51 ++++++++++++++++++++---------------------
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index a2e197c0d2f9..794974378be6 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1462,6 +1462,30 @@ TRACE_EVENT(svcsock_new_socket,
 	)
 );
 
+TRACE_EVENT(svcsock_marker,
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		__be32 marker
+	),
+
+	TP_ARGS(xprt, marker),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, length)
+		__field(bool, last)
+		__string(addr, xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->length = be32_to_cpu(marker) & RPC_FRAGMENT_SIZE_MASK;
+		__entry->last = be32_to_cpu(marker) & RPC_LAST_STREAM_FRAGMENT;
+		__assign_str(addr, xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s length=%u%s", __get_str(addr),
+		__entry->length, __entry->last ? " (last)" : "")
+);
+
 DECLARE_EVENT_CLASS(svcsock_class,
 	TP_PROTO(
 		const struct svc_xprt *xprt,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d63b21f3f207..9c1eb13aa9b8 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -828,47 +828,45 @@ static void svc_tcp_clear_pages(struct svc_sock *svsk)
 }
 
 /*
- * Receive fragment record header.
- * If we haven't gotten the record length yet, get the next four bytes.
+ * Receive fragment record header into sk_marker.
  */
-static int svc_tcp_recv_record(struct svc_sock *svsk, struct svc_rqst *rqstp)
+static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
+				   struct svc_rqst *rqstp)
 {
-	struct svc_serv	*serv = svsk->sk_xprt.xpt_server;
-	unsigned int want;
-	int len;
+	ssize_t want, len;
 
+	/* If we haven't gotten the record length yet,
+	 * get the next four bytes.
+	 */
 	if (svsk->sk_tcplen < sizeof(rpc_fraghdr)) {
+		struct msghdr	msg = { NULL };
 		struct kvec	iov;
 
 		want = sizeof(rpc_fraghdr) - svsk->sk_tcplen;
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
-		len = svc_recvfrom(rqstp, &iov, 1, want, 0);
+		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, want);
+		len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
 		if (len < 0)
-			goto error;
+			return len;
 		svsk->sk_tcplen += len;
-
 		if (len < want) {
-			dprintk("svc: short recvfrom while reading record "
-				"length (%d of %d)\n", len, want);
-			return -EAGAIN;
+			/* call again to read the remaining bytes */
+			goto err_short;
 		}
-
-		dprintk("svc: TCP record, %d bytes\n", svc_sock_reclen(svsk));
+		trace_svcsock_marker(&svsk->sk_xprt, svsk->sk_marker);
 		if (svc_sock_reclen(svsk) + svsk->sk_datalen >
-							serv->sv_max_mesg) {
-			net_notice_ratelimited("RPC: fragment too large: %d\n",
-					svc_sock_reclen(svsk));
-			goto err_delete;
-		}
+		    svsk->sk_xprt.xpt_server->sv_max_mesg)
+			goto err_too_large;
 	}
-
 	return svc_sock_reclen(svsk);
-error:
-	dprintk("RPC: TCP recv_record got %d\n", len);
-	return len;
-err_delete:
+
+err_too_large:
+	net_notice_ratelimited("svc: %s %s RPC fragment too large: %d\n",
+			       __func__, svsk->sk_xprt.xpt_server->sv_name,
+			       svc_sock_reclen(svsk));
 	set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
+err_short:
 	return -EAGAIN;
 }
 
@@ -961,12 +959,13 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		test_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags),
 		test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags));
 
-	len = svc_tcp_recv_record(svsk, rqstp);
+	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+	len = svc_tcp_read_marker(svsk, rqstp);
 	if (len < 0)
 		goto error;
 
 	base = svc_tcp_restore_pages(svsk, rqstp);
-	want = svc_sock_reclen(svsk) - (svsk->sk_tcplen - sizeof(rpc_fraghdr));
+	want = len - (svsk->sk_tcplen - sizeof(rpc_fraghdr));
 
 	vec = rqstp->rq_vec;
 

