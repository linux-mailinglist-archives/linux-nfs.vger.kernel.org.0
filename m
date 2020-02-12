Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F96159E37
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 01:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgBLAmp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 19:42:45 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36784 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBLAmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Feb 2020 19:42:44 -0500
Received: by mail-yb1-f195.google.com with SMTP id q190so99573ybg.3
        for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2020 16:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=s7ZoKIt5M5G6I+eouXhh+ix6q3xL/5CpcCybuzaaIGI=;
        b=XYXQx7HzUn/Mu7UE1e8QTH/wKAb8Yvppulk/Jmq9tiChIzHUNXHY2fhIIRKSEzWEx9
         vRrxuFDQ8XhcW5qpNcvYE/x9jelNrIFNsiZVXGBae3Xw6pRgD0dl6MNcT2f8A3ShiwTV
         GrCVi+4WpPYhxB3yvjKZX73WG3lPu8L0SkxwbjrfSsIjUKqbVlhCrmFaxrlS4HRcBq94
         +nVhsWoTbI1iv/uiLofH3NRrZJ+IPCJowioRzTonMyV5fQcAotPYmxSYwRdDEb7rSh+C
         nR3l3iGhRNSOVcd2cJnuUFd2wA5cNGpmBFujiHQ7ZW+rQ0kw+egEiI9zWB7EybCkj2XA
         9EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=s7ZoKIt5M5G6I+eouXhh+ix6q3xL/5CpcCybuzaaIGI=;
        b=d8GLXCieT5HmpPeIP/wQ1W9kbZrJgnUd11O0sAVe/n7NVqULvra2gUXNYNbgnINAVy
         Etmg4irndChWV12EOznI3M+l9vphylKnCoql/q1O+i4J002vWHLWwtFIXfm1Kq8oxUeI
         PK7I77uS+oWkn7uPv7f6JjvzBdgSyWASOrFjl9vdYdjoukfq0mb5a15wKUl1rgUFfq7V
         AJq4azao1pfohZLoHoWapGRNZM8n//Tmufu4cAlVxozkOfxGTnADGRmn12JtMAiIQZhW
         Uin8wEUSwVGRxHF7lUIZ+OmWKf9568W5+QpoSJrSdZDAgvbsE1yCaSeq45IXGdhLHnY/
         URAA==
X-Gm-Message-State: APjAAAWU1COVTYtIMlijYj3WOAZx+tHVxTGKROFxWPTYC7j1REgEyWPf
        zdzjXgs1DNSiJayoah1UHGaSXZIs
X-Google-Smtp-Source: APXvYqyZe9MTmPYBdW2ad5VQkb6hJkEmMhwvGa8jpyNB7TKTZQ4Tf1DChpYgIsH2hjxMcWOtcxaeqA==
X-Received: by 2002:a25:d797:: with SMTP id o145mr450591ybg.276.1581468163060;
        Tue, 11 Feb 2020 16:42:43 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q8sm2730183ywa.79.2020.02.11.16.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:42:42 -0800 (PST)
Subject: [PATCH RFC 2/3] SUNRPC: Refactor xs_sendpages()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 11 Feb 2020 19:42:41 -0500
Message-ID: <20200212004241.2305.68192.stgit@bazille.1015granger.net>
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

Refactor: Re-locate xs_sendpages() so that it can be shared with
server code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |   14 ----
 net/sunrpc/socklib.c       |  136 ++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/socklib.h       |   15 ++++
 net/sunrpc/svcsock.c       |    1 
 net/sunrpc/xprtsock.c      |  148 ++++++--------------------------------------
 5 files changed, 172 insertions(+), 142 deletions(-)
 create mode 100644 net/sunrpc/socklib.h

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b41f34977995..a1264b19b34c 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -188,20 +188,6 @@ static inline void xdr_netobj_dup(struct xdr_netobj *dst,
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 
-/*
- * Helper structure for copying from an sk_buff.
- */
-struct xdr_skb_reader {
-	struct sk_buff	*skb;
-	unsigned int	offset;
-	size_t		count;
-	__wsum		csum;
-};
-
-typedef size_t (*xdr_skb_read_actor)(struct xdr_skb_reader *desc, void *to, size_t len);
-
-extern int csum_partial_copy_to_xdr(struct xdr_buf *, struct sk_buff *);
-
 extern int xdr_encode_word(struct xdr_buf *, unsigned int, u32);
 extern int xdr_decode_word(struct xdr_buf *, unsigned int, u32 *);
 
diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 1a864f1ed119..7ccc83046af5 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -14,9 +14,24 @@
 #include <linux/types.h>
 #include <linux/pagemap.h>
 #include <linux/udp.h>
+#include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/export.h>
 
+#include "socklib.h"
+
+/*
+ * Helper structure for copying from an sk_buff.
+ */
+struct xdr_skb_reader {
+	struct sk_buff	*skb;
+	unsigned int	offset;
+	size_t		count;
+	__wsum		csum;
+};
+
+typedef size_t (*xdr_skb_read_actor)(struct xdr_skb_reader *desc, void *to,
+				     size_t len);
 
 /**
  * xdr_skb_read_bits - copy some data bits from skb to internal buffer
@@ -186,3 +201,124 @@ int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(csum_partial_copy_to_xdr);
+
+static inline int xprt_sendmsg(struct socket *sock, struct msghdr *msg,
+			       size_t seek)
+{
+	if (seek)
+		iov_iter_advance(&msg->msg_iter, seek);
+	return sock_sendmsg(sock, msg);
+}
+
+static int xprt_send_kvec(struct socket *sock, struct msghdr *msg,
+			  struct kvec *vec, size_t seek)
+{
+	iov_iter_kvec(&msg->msg_iter, WRITE, vec, 1, vec->iov_len);
+	return xprt_sendmsg(sock, msg, seek);
+}
+
+static int xprt_send_pagedata(struct socket *sock, struct msghdr *msg,
+			      struct xdr_buf *xdr, size_t base)
+{
+	int err;
+
+	err = xdr_alloc_bvec(xdr, GFP_KERNEL);
+	if (err < 0)
+		return err;
+
+	iov_iter_bvec(&msg->msg_iter, WRITE, xdr->bvec,
+			xdr_buf_pagecount(xdr),
+			xdr->page_len + xdr->page_base);
+	return xprt_sendmsg(sock, msg, base + xdr->page_base);
+}
+
+/* Common case:
+ *  - stream transport
+ *  - sending from byte 0 of the message
+ *  - the message is wholly contained in @xdr's head iovec
+ */
+static int xprt_send_rm_and_kvec(struct socket *sock, struct msghdr *msg,
+				 rpc_fraghdr marker, struct kvec *vec,
+				 size_t base)
+{
+	struct kvec iov[2] = {
+		[0] = {
+			.iov_base	= &marker,
+			.iov_len	= sizeof(marker)
+		},
+		[1] = *vec,
+	};
+	size_t len = iov[0].iov_len + iov[1].iov_len;
+
+	iov_iter_kvec(&msg->msg_iter, WRITE, iov, 2, len);
+	return xprt_sendmsg(sock, msg, base);
+}
+
+/**
+ * xprt_sock_sendmsg - write an xdr_buf directly to a socket
+ * @sock: open socket to send on
+ * @msg: socket message metadata
+ * @xdr: xdr_buf containing this request
+ * @base: starting position in the buffer
+ * @marker: stream record marker field
+ * @sent_p: return the total number of bytes successfully queued for sending
+ *
+ * Return values:
+ *   On success, returns zero and fills in @sent_p.
+ *   %-ENOTSOCK if  @sock is not a struct socket.
+ */
+int xprt_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+		      struct xdr_buf *xdr, unsigned int base,
+		      rpc_fraghdr marker, unsigned int *sent_p)
+{
+	unsigned int rmsize = marker ? sizeof(marker) : 0;
+	unsigned int remainder = rmsize + xdr->len - base;
+	unsigned int want;
+	int err = 0;
+
+	if (unlikely(!sock))
+		return -ENOTSOCK;
+
+	msg->msg_flags |= MSG_MORE;
+	want = xdr->head[0].iov_len + rmsize;
+	if (base < want) {
+		unsigned int len = want - base;
+		remainder -= len;
+		if (remainder == 0)
+			msg->msg_flags &= ~MSG_MORE;
+		if (rmsize)
+			err = xprt_send_rm_and_kvec(sock, msg, marker,
+						    &xdr->head[0], base);
+		else
+			err = xprt_send_kvec(sock, msg, &xdr->head[0], base);
+		if (remainder == 0 || err != len)
+			goto out;
+		*sent_p += err;
+		base = 0;
+	} else
+		base -= want;
+
+	if (base < xdr->page_len) {
+		unsigned int len = xdr->page_len - base;
+		remainder -= len;
+		if (remainder == 0)
+			msg->msg_flags &= ~MSG_MORE;
+		err = xprt_send_pagedata(sock, msg, xdr, base);
+		if (remainder == 0 || err != len)
+			goto out;
+		*sent_p += err;
+		base = 0;
+	} else
+		base -= xdr->page_len;
+
+	if (base >= xdr->tail[0].iov_len)
+		return 0;
+	msg->msg_flags &= ~MSG_MORE;
+	err = xprt_send_kvec(sock, msg, &xdr->tail[0], base);
+out:
+	if (err > 0) {
+		*sent_p += err;
+		err = 0;
+	}
+	return err;
+}
diff --git a/net/sunrpc/socklib.h b/net/sunrpc/socklib.h
new file mode 100644
index 000000000000..c48114ad6f00
--- /dev/null
+++ b/net/sunrpc/socklib.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 1995-1997 Olaf Kirch <okir@monad.swb.de>
+ * Copyright (C) 2020, Oracle.
+ */
+
+#ifndef _NET_SUNRPC_SOCKLIB_H_
+#define _NET_SUNRPC_SOCKLIB_H_
+
+int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb);
+int xprt_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+		      struct xdr_buf *xdr, unsigned int base,
+		      rpc_fraghdr marker, unsigned int *sent_p);
+
+#endif /* _NET_SUNRPC_SOCKLIB_H_ */
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index fe045b3e7e08..47957088d7d3 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -55,6 +55,7 @@
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/xprt.h>
 
+#include "socklib.h"
 #include "sunrpc.h"
 
 #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index f940179db510..0380d72d8485 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -54,6 +54,7 @@
 
 #include <trace/events/sunrpc.h>
 
+#include "socklib.h"
 #include "sunrpc.h"
 
 static void xs_close(struct rpc_xprt *xprt);
@@ -749,125 +750,6 @@ static void xs_stream_data_receive_workfn(struct work_struct *work)
 
 #define XS_SENDMSG_FLAGS	(MSG_DONTWAIT | MSG_NOSIGNAL)
 
-static int xs_sendmsg(struct socket *sock, struct msghdr *msg, size_t seek)
-{
-	if (seek)
-		iov_iter_advance(&msg->msg_iter, seek);
-	return sock_sendmsg(sock, msg);
-}
-
-static int xs_send_kvec(struct socket *sock, struct msghdr *msg, struct kvec *vec, size_t seek)
-{
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, 1, vec->iov_len);
-	return xs_sendmsg(sock, msg, seek);
-}
-
-static int xs_send_pagedata(struct socket *sock, struct msghdr *msg, struct xdr_buf *xdr, size_t base)
-{
-	int err;
-
-	err = xdr_alloc_bvec(xdr, GFP_KERNEL);
-	if (err < 0)
-		return err;
-
-	iov_iter_bvec(&msg->msg_iter, WRITE, xdr->bvec,
-			xdr_buf_pagecount(xdr),
-			xdr->page_len + xdr->page_base);
-	return xs_sendmsg(sock, msg, base + xdr->page_base);
-}
-
-#define xs_record_marker_len() sizeof(rpc_fraghdr)
-
-/* Common case:
- *  - stream transport
- *  - sending from byte 0 of the message
- *  - the message is wholly contained in @xdr's head iovec
- */
-static int xs_send_rm_and_kvec(struct socket *sock, struct msghdr *msg,
-		rpc_fraghdr marker, struct kvec *vec, size_t base)
-{
-	struct kvec iov[2] = {
-		[0] = {
-			.iov_base	= &marker,
-			.iov_len	= sizeof(marker)
-		},
-		[1] = *vec,
-	};
-	size_t len = iov[0].iov_len + iov[1].iov_len;
-
-	iov_iter_kvec(&msg->msg_iter, WRITE, iov, 2, len);
-	return xs_sendmsg(sock, msg, base);
-}
-
-/**
- * xs_sendpages - write pages directly to a socket
- * @sock: socket to send on
- * @addr: UDP only -- address of destination
- * @addrlen: UDP only -- length of destination address
- * @xdr: buffer containing this request
- * @base: starting position in the buffer
- * @rm: stream record marker field
- * @sent_p: return the total number of bytes successfully queued for sending
- *
- */
-static int xs_sendpages(struct socket *sock, struct sockaddr *addr, int addrlen, struct xdr_buf *xdr, unsigned int base, rpc_fraghdr rm, int *sent_p)
-{
-	struct msghdr msg = {
-		.msg_name = addr,
-		.msg_namelen = addrlen,
-		.msg_flags = XS_SENDMSG_FLAGS | MSG_MORE,
-	};
-	unsigned int rmsize = rm ? sizeof(rm) : 0;
-	unsigned int remainder = rmsize + xdr->len - base;
-	unsigned int want;
-	int err = 0;
-
-	if (unlikely(!sock))
-		return -ENOTSOCK;
-
-	want = xdr->head[0].iov_len + rmsize;
-	if (base < want) {
-		unsigned int len = want - base;
-		remainder -= len;
-		if (remainder == 0)
-			msg.msg_flags &= ~MSG_MORE;
-		if (rmsize)
-			err = xs_send_rm_and_kvec(sock, &msg, rm,
-					&xdr->head[0], base);
-		else
-			err = xs_send_kvec(sock, &msg, &xdr->head[0], base);
-		if (remainder == 0 || err != len)
-			goto out;
-		*sent_p += err;
-		base = 0;
-	} else
-		base -= want;
-
-	if (base < xdr->page_len) {
-		unsigned int len = xdr->page_len - base;
-		remainder -= len;
-		if (remainder == 0)
-			msg.msg_flags &= ~MSG_MORE;
-		err = xs_send_pagedata(sock, &msg, xdr, base);
-		if (remainder == 0 || err != len)
-			goto out;
-		*sent_p += err;
-		base = 0;
-	} else
-		base -= xdr->page_len;
-
-	if (base >= xdr->tail[0].iov_len)
-		return 0;
-	msg.msg_flags &= ~MSG_MORE;
-	err = xs_send_kvec(sock, &msg, &xdr->tail[0], base);
-out:
-	if (err > 0) {
-		*sent_p += err;
-		err = 0;
-	}
-	return err;
-}
-
 /**
  * xs_nospace - handle transmit was incomplete
  * @req: pointer to RPC request
@@ -948,8 +830,11 @@ static int xs_local_send_request(struct rpc_rqst *req)
 	struct xdr_buf *xdr = &req->rq_snd_buf;
 	rpc_fraghdr rm = rpc_stream_record_marker(xdr->len);
 	unsigned int msglen = rm ? req->rq_slen + sizeof(rm) : req->rq_slen;
+	struct msghdr msg = {
+		.msg_flags	= XS_SENDMSG_FLAGS,
+	};
+	unsigned int sent = 0;
 	int status;
-	int sent = 0;
 
 	/* Close the stream if the previous transmission was incomplete */
 	if (xs_send_request_was_aborted(transport, req)) {
@@ -961,8 +846,8 @@ static int xs_local_send_request(struct rpc_rqst *req)
 			req->rq_svec->iov_base, req->rq_svec->iov_len);
 
 	req->rq_xtime = ktime_get();
-	status = xs_sendpages(transport->sock, NULL, 0, xdr,
-			      transport->xmit.offset, rm, &sent);
+	status = xprt_sock_sendmsg(transport->sock, &msg, xdr,
+				   transport->xmit.offset, rm, &sent);
 	dprintk("RPC:       %s(%u) = %d\n",
 			__func__, xdr->len - transport->xmit.offset, status);
 
@@ -1014,7 +899,12 @@ static int xs_udp_send_request(struct rpc_rqst *req)
 	struct rpc_xprt *xprt = req->rq_xprt;
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	struct xdr_buf *xdr = &req->rq_snd_buf;
-	int sent = 0;
+	struct msghdr msg = {
+		.msg_name	= xs_addr(xprt),
+		.msg_namelen	= xprt->addrlen,
+		.msg_flags	= XS_SENDMSG_FLAGS,
+	};
+	unsigned int sent = 0;
 	int status;
 
 	xs_pktdump("packet data:",
@@ -1028,8 +918,7 @@ static int xs_udp_send_request(struct rpc_rqst *req)
 		return -EBADSLT;
 
 	req->rq_xtime = ktime_get();
-	status = xs_sendpages(transport->sock, xs_addr(xprt), xprt->addrlen,
-			      xdr, 0, 0, &sent);
+	status = xprt_sock_sendmsg(transport->sock, &msg, xdr, 0, 0, &sent);
 
 	dprintk("RPC:       xs_udp_send_request(%u) = %d\n",
 			xdr->len, status);
@@ -1095,9 +984,12 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 	struct xdr_buf *xdr = &req->rq_snd_buf;
 	rpc_fraghdr rm = rpc_stream_record_marker(xdr->len);
 	unsigned int msglen = rm ? req->rq_slen + sizeof(rm) : req->rq_slen;
+	struct msghdr msg = {
+		.msg_flags	= XS_SENDMSG_FLAGS,
+	};
 	bool vm_wait = false;
+	unsigned int sent;
 	int status;
-	int sent;
 
 	/* Close the stream if the previous transmission was incomplete */
 	if (xs_send_request_was_aborted(transport, req)) {
@@ -1119,8 +1011,8 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 	req->rq_xtime = ktime_get();
 	while (1) {
 		sent = 0;
-		status = xs_sendpages(transport->sock, NULL, 0, xdr,
-				      transport->xmit.offset, rm, &sent);
+		status = xprt_sock_sendmsg(transport->sock, &msg, xdr,
+					   transport->xmit.offset, rm, &sent);
 
 		dprintk("RPC:       xs_tcp_send_request(%u) = %d\n",
 				xdr->len - transport->xmit.offset, status);

