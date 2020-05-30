Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918151E917A
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgE3N2R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N2R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:28:17 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24181C03E969;
        Sat, 30 May 2020 06:28:17 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y18so2316909iow.3;
        Sat, 30 May 2020 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pDesEA3tfxXsQkJDUaWvL0PlNOOBnuLN0JNjzIVetf0=;
        b=S8yLWKIc4CKuwVwVEMET/jFfY/CTyU9vLqHgm1gmYjQIZyHt6cD3vSj1MD16G+B4kE
         VnwSJRhVwvWfnLHOWFBJ4zTlCAtZNX0Vq4xiS0qR6l6YD11aNsbYGVLxPZMheQnRcDX2
         DgE0u5me7yyRHJDR35neufvmRMLVShgpji534L+WZBW/xBG7WO7EyPrh5E4qry8Hhza3
         KOMcMGw5pQbWNFY9ezEoFy+EKBiO0DJXMw/BpAp9ufkYKbyB5awYIobiQgJmfKBZgLMC
         j1Ije089l7sVfH2HF/MdnOjNO3mfgbAyt7SNk5nf5W70wpbxIFoUaOg4mcVp/vqarc/K
         kdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=pDesEA3tfxXsQkJDUaWvL0PlNOOBnuLN0JNjzIVetf0=;
        b=Otmqn80F7ogO8kkds0Ty7a+gqZ/gMQVPg/Gi4zTHEsMeDg7eRuaOTSO6cLiWPu3Ra0
         MH/KEeDlzgxHqBty3YY+lSjL6drR8onfAm/GZAHekVs1r2QsELz0wzfu7IgRsdwt8yoo
         1FCOFpPTQ5a1YYvT6IsGXaiWtIeoRGlEA7Lx9NxbYufOx7gQndaquC/edqlCprAI8sSV
         95RsJnOo7ntupuxjKvVc7ms/sfWZLPXQwj1wjd0oH7/T3mUK9wqNLJ9BVgKAE2gl/YXM
         OOWMGEFqaWMiNjIp0Nkxj69ouljPny8i7rBKkfDl3skAHVwtyGBeTqyN1pxiSE8eKAEt
         U2JA==
X-Gm-Message-State: AOAM531RBacmLggwBB1tCRuC93vp/muEvQ3ef+5KOkklSkNYW1mpPjts
        0Tih7bZPl4KUwDyj9fGI4G3tvGaU
X-Google-Smtp-Source: ABdhPJxVpHvng6Tt39fL9y5NvyQpXg6Lity/1fki7v9qraF5K5uXa9/p8GuBpAAncMT3nt9IWrwJog==
X-Received: by 2002:a02:c9c5:: with SMTP id c5mr671789jap.5.1590845296100;
        Sat, 30 May 2020 06:28:16 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x13sm6301160ilq.48.2020.05.30.06.28.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:15 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDSEYv001390;
        Sat, 30 May 2020 13:28:14 GMT
Subject: [PATCH v4 02/33] SUNRPC: Move xpt_mutex into socket xpo_sendto
 methods
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:14 -0400
Message-ID: <20200530132814.10117.11106.stgit@klimt.1015granger.net>
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

It appears that the RPC/RDMA transport does not need serialization
of calls to its xpo_sendto method. Move the mutex into the socket
methods that still need that serialization.

Tail latencies are unambiguously better with this patch applied.
fio randrw 8KB 70/30 on NFSv3, smaller numbers are better:

    clat percentiles (usec):

With xpt_mutex:
r    | 99.99th=[ 8848]
w    | 99.99th=[ 9634]

Without xpt_mutex:
r    | 99.99th=[ 8586]
w    | 99.99th=[ 8979]

Serializing the construction of RPC/RDMA transport headers is not
really necessary at this point, because the Linux NFS server
implementation never changes its credit grant on a connection. If
that should change, then svc_rdma_sendto will need to serialize
access to the transport's credit grant fields.

Reported-by: kbuild test robot <lkp@intel.com>
[ cel: fix uninitialized variable warning ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_xprt.h            |    6 +++++
 net/sunrpc/svc_xprt.c                      |   11 ++-------
 net/sunrpc/svcsock.c                       |   25 ++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   35 +++++++++++++---------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   10 +++-----
 net/sunrpc/xprtsock.c                      |   12 ++++++++--
 6 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 9e1e046de176..aca35ab5cff2 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -117,6 +117,12 @@ static inline int register_xpt_user(struct svc_xprt *xpt, struct svc_xpt_user *u
 	return 0;
 }
 
+static inline bool svc_xprt_is_dead(const struct svc_xprt *xprt)
+{
+	return (test_bit(XPT_DEAD, &xprt->xpt_flags) != 0) ||
+		(test_bit(XPT_CLOSE, &xprt->xpt_flags) != 0);
+}
+
 int	svc_reg_xprt_class(struct svc_xprt_class *);
 void	svc_unreg_xprt_class(struct svc_xprt_class *);
 void	svc_xprt_init(struct net *, struct svc_xprt_class *, struct svc_xprt *,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 8ef44275c255..7ad37ff56ff7 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -915,15 +915,10 @@ int svc_send(struct svc_rqst *rqstp)
 		xb->tail[0].iov_len;
 	trace_svc_xdr_sendto(rqstp, xb);
 
-	/* Grab mutex to serialize outgoing data. */
-	mutex_lock(&xprt->xpt_mutex);
 	trace_svc_stats_latency(rqstp);
-	if (test_bit(XPT_DEAD, &xprt->xpt_flags)
-			|| test_bit(XPT_CLOSE, &xprt->xpt_flags))
-		len = -ENOTCONN;
-	else
-		len = xprt->xpt_ops->xpo_sendto(rqstp);
-	mutex_unlock(&xprt->xpt_mutex);
+
+	len = xprt->xpt_ops->xpo_sendto(rqstp);
+
 	trace_svc_send(rqstp, len);
 	svc_xprt_release(rqstp);
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 023514e392b3..3e7b6445e317 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -506,6 +506,9 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
  * svc_udp_sendto - Send out a reply on a UDP socket
  * @rqstp: completed svc_rqst
  *
+ * xpt_mutex ensures @rqstp's whole message is written to the socket
+ * without interruption.
+ *
  * Returns the number of bytes sent, or a negative errno.
  */
 static int svc_udp_sendto(struct svc_rqst *rqstp)
@@ -531,6 +534,11 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 
 	svc_set_cmsg_data(rqstp, cmh);
 
+	mutex_lock(&xprt->xpt_mutex);
+
+	if (svc_xprt_is_dead(xprt))
+		goto out_notconn;
+
 	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
 	xdr_free_bvec(xdr);
 	if (err == -ECONNREFUSED) {
@@ -538,9 +546,15 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
 		xdr_free_bvec(xdr);
 	}
+
+	mutex_unlock(&xprt->xpt_mutex);
 	if (err < 0)
 		return err;
 	return sent;
+
+out_notconn:
+	mutex_unlock(&xprt->xpt_mutex);
+	return -ENOTCONN;
 }
 
 static int svc_udp_has_wspace(struct svc_xprt *xprt)
@@ -1063,6 +1077,9 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
  * svc_tcp_sendto - Send out a reply on a TCP socket
  * @rqstp: completed svc_rqst
  *
+ * xpt_mutex ensures @rqstp's whole message is written to the socket
+ * without interruption.
+ *
  * Returns the number of bytes sent, or a negative errno.
  */
 static int svc_tcp_sendto(struct svc_rqst *rqstp)
@@ -1080,12 +1097,19 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 
 	svc_release_skb(rqstp);
 
+	mutex_lock(&xprt->xpt_mutex);
+	if (svc_xprt_is_dead(xprt))
+		goto out_notconn;
 	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, marker, &sent);
 	xdr_free_bvec(xdr);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))
 		goto out_close;
+	mutex_unlock(&xprt->xpt_mutex);
 	return sent;
 
+out_notconn:
+	mutex_unlock(&xprt->xpt_mutex);
+	return -ENOTCONN;
 out_close:
 	pr_notice("rpc-srv/tcp: %s: %s %d when sending %d bytes - shutting down socket\n",
 		  xprt->xpt_server->sv_name,
@@ -1093,6 +1117,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 		  (err < 0) ? err : sent, xdr->len);
 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
 	svc_xprt_enqueue(xprt);
+	mutex_unlock(&xprt->xpt_mutex);
 	return -EAGAIN;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index af7eb8d202ae..d9aab4504f2c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -210,34 +210,31 @@ rpcrdma_bc_send_request(struct svcxprt_rdma *rdma, struct rpc_rqst *rqst)
 	return -ENOTCONN;
 }
 
-/* Send an RPC call on the passive end of a transport
- * connection.
+/**
+ * xprt_rdma_bc_send_request - Send a reverse-direction Call
+ * @rqst: rpc_rqst containing Call message to be sent
+ *
+ * Return values:
+ *   %0 if the message was sent successfully
+ *   %ENOTCONN if the message was not sent
  */
-static int
-xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
+static int xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
 {
 	struct svc_xprt *sxprt = rqst->rq_xprt->bc_xprt;
-	struct svcxprt_rdma *rdma;
+	struct svcxprt_rdma *rdma =
+		container_of(sxprt, struct svcxprt_rdma, sc_xprt);
 	int ret;
 
 	dprintk("svcrdma: sending bc call with xid: %08x\n",
 		be32_to_cpu(rqst->rq_xid));
 
-	mutex_lock(&sxprt->xpt_mutex);
-
-	ret = -ENOTCONN;
-	rdma = container_of(sxprt, struct svcxprt_rdma, sc_xprt);
-	if (!test_bit(XPT_DEAD, &sxprt->xpt_flags)) {
-		ret = rpcrdma_bc_send_request(rdma, rqst);
-		if (ret == -ENOTCONN)
-			svc_close_xprt(sxprt);
-	}
+	if (test_bit(XPT_DEAD, &sxprt->xpt_flags))
+		return -ENOTCONN;
 
-	mutex_unlock(&sxprt->xpt_mutex);
-
-	if (ret < 0)
-		return ret;
-	return 0;
+	ret = rpcrdma_bc_send_request(rdma, rqst);
+	if (ret == -ENOTCONN)
+		svc_close_xprt(sxprt);
+	return ret;
 }
 
 static void
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index b6c8643867f2..38e7c3c8c4a9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -868,12 +868,10 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	__be32 *p;
 	int ret;
 
-	/* Create the RDMA response header. xprt->xpt_mutex,
-	 * acquired in svc_send(), serializes RPC replies. The
-	 * code path below that inserts the credit grant value
-	 * into each transport header runs only inside this
-	 * critical section.
-	 */
+	ret = -ENOTCONN;
+	if (svc_xprt_is_dead(xprt))
+		goto err0;
+
 	ret = -ENOMEM;
 	sctxt = svc_rdma_send_ctxt_get(rdma);
 	if (!sctxt)
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 845d0be805ec..839c49330785 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2548,8 +2548,16 @@ static int bc_sendto(struct rpc_rqst *req)
 	return sent;
 }
 
-/*
- * The send routine. Borrows from svc_send
+/**
+ * bc_send_request - Send a backchannel Call on a TCP socket
+ * @req: rpc_rqst containing Call message to be sent
+ *
+ * xpt_mutex ensures @rqstp's whole message is written to the socket
+ * without interruption.
+ *
+ * Return values:
+ *   %0 if the message was sent successfully
+ *   %ENOTCONN if the message was not sent
  */
 static int bc_send_request(struct rpc_rqst *req)
 {

