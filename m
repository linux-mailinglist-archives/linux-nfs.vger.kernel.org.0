Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552041E9184
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgE3N2o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N2n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:28:43 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D93AC03E969;
        Sat, 30 May 2020 06:28:43 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v11so5231823ilh.1;
        Sat, 30 May 2020 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lCCExvyODMO0v1Z3g8fcgjDrSeXwtuhz60/Y3Fx4pvQ=;
        b=b8QD738hCkt8rj6L+KX3rDYaAYkhQNgO/YkmQTHyJuz9J/vOr2DyEmEgCUWZ+Ui3Z5
         AQWsCndqp3TJ1LZMtVyAZ7mAVAAasB5DxAeHwuzBBADhrAVn7UB7hsNriTY/DXdWprXw
         danJZ8GKTPX2KNgbZqqpyLTjZywU2yOdgNDFDrIDluFMjy1/BDiigTfiOJFts9RRb1IF
         KiVsaMIj0C6+NniK6+3fuiGscvTxGTvP6Gn2HKZybJMHUtn4iDa0SCs9VR7SxOlcaWOO
         qFBUShBzxZOcMiMdXbSJGvOvyxn+C2SRBxHNn46IJbOWgWj5fhfODXgo1/v2/r8bFprK
         0lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lCCExvyODMO0v1Z3g8fcgjDrSeXwtuhz60/Y3Fx4pvQ=;
        b=VTdNjGFwqEBYICB0Mq9n8v1dlUc6XqpOqPapg72ORSbQCWBjf1FXCndS4xEeKNlLah
         ak44+/iYfbIhkWo45E8Fx8hPLZmr7TLnrtghjrN1KBrIrtYUloBUzUhtiUW4Utksa3RY
         2E+/h90ZIekSkKbqYRPlzls+ddDaHXfv5Uf74LyIAOaMpOUVVqzaHRVFakV+x7SHVDlb
         B385jgP2Tp3OZZuAIirfvGuJ2/bh6NbITkgUoO0t83hrYMF42K2XRh2Pdww2rCr1/n3v
         31q4Wx4HD+Z1mxxi0VOxq9DbpnFQdHOGR3IEBDYeb5mUS+J1NdHup05Nv+67zswAItj2
         MoLg==
X-Gm-Message-State: AOAM531hSgsFjh4ywpUdWQHbC3b6lY0MmjnL6wMWQeQMM8iAAb0zu+8o
        9xMh4mu5KDwf5ZHxucYz/XdhZ4B7
X-Google-Smtp-Source: ABdhPJzwR7nvlR6YK+SXR2B+YOj0+v0wg69paONAr5zIl6l11D3CwI8Y48BUxLvmAKEwMV+eAJrlwQ==
X-Received: by 2002:a92:d1d0:: with SMTP id u16mr11080423ilg.7.1590845322392;
        Sat, 30 May 2020 06:28:42 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l26sm2635138ild.59.2020.05.30.06.28.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:41 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDSf8m001405;
        Sat, 30 May 2020 13:28:41 GMT
Subject: [PATCH v4 07/33] svcrdma: Fix backchannel return code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:41 -0400
Message-ID: <20200530132841.10117.79841.stgit@klimt.1015granger.net>
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

Way back when I was writing the RPC/RDMA server-side backchannel
code, I misread the TCP backchannel reply handler logic. When
svc_tcp_recvfrom() successfully receives a backchannel reply, it
does not return -EAGAIN. It sets XPT_DATA and returns zero.

Update svc_rdma_recvfrom() to return zero. Here, XPT_DATA doesn't
need to be set again: it is set whenever a new message is received,
behind a spin lock in a single threaded context.

Also, if handling the cb reply is not successful, the message is
simply dropped. There's no special message framing to deal with as
there is in the TCP case.

Now that the handle_bc_reply() return value is ignored, I've removed
the dprintk call sites in the error exit of handle_bc_reply() in
favor of trace points in other areas that already report the error
cases.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    5 +---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   38 +++++++---------------------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |   11 ++++----
 3 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index cbcfbd0521e3..8518c3f37e56 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -160,9 +160,8 @@ struct svc_rdma_send_ctxt {
 };
 
 /* svc_rdma_backchannel.c */
-extern int svc_rdma_handle_bc_reply(struct rpc_xprt *xprt,
-				    __be32 *rdma_resp,
-				    struct xdr_buf *rcvbuf);
+extern void svc_rdma_handle_bc_reply(struct svc_rqst *rqstp,
+				     struct svc_rdma_recv_ctxt *rctxt);
 
 /* svc_rdma_recvfrom.c */
 extern void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index d9aab4504f2c..b174f3b109a5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -15,26 +15,25 @@
 #undef SVCRDMA_BACKCHANNEL_DEBUG
 
 /**
- * svc_rdma_handle_bc_reply - Process incoming backchannel reply
- * @xprt: controlling backchannel transport
- * @rdma_resp: pointer to incoming transport header
- * @rcvbuf: XDR buffer into which to decode the reply
+ * svc_rdma_handle_bc_reply - Process incoming backchannel Reply
+ * @rqstp: resources for handling the Reply
+ * @rctxt: Received message
  *
- * Returns:
- *	%0 if @rcvbuf is filled in, xprt_complete_rqst called,
- *	%-EAGAIN if server should call ->recvfrom again.
  */
-int svc_rdma_handle_bc_reply(struct rpc_xprt *xprt, __be32 *rdma_resp,
-			     struct xdr_buf *rcvbuf)
+void svc_rdma_handle_bc_reply(struct svc_rqst *rqstp,
+			      struct svc_rdma_recv_ctxt *rctxt)
 {
+	struct svc_xprt *sxprt = rqstp->rq_xprt;
+	struct rpc_xprt *xprt = sxprt->xpt_bc_xprt;
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+	struct xdr_buf *rcvbuf = &rqstp->rq_arg;
 	struct kvec *dst, *src = &rcvbuf->head[0];
+	__be32 *rdma_resp = rctxt->rc_recv_buf;
 	struct rpc_rqst *req;
 	u32 credits;
 	size_t len;
 	__be32 xid;
 	__be32 *p;
-	int ret;
 
 	p = (__be32 *)src->iov_base;
 	len = src->iov_len;
@@ -49,14 +48,10 @@ int svc_rdma_handle_bc_reply(struct rpc_xprt *xprt, __be32 *rdma_resp,
 		__func__, (int)len, p);
 #endif
 
-	ret = -EAGAIN;
-	if (src->iov_len < 24)
-		goto out_shortreply;
-
 	spin_lock(&xprt->queue_lock);
 	req = xprt_lookup_rqst(xprt, xid);
 	if (!req)
-		goto out_notfound;
+		goto out_unlock;
 
 	dst = &req->rq_private_buf.head[0];
 	memcpy(&req->rq_private_buf, &req->rq_rcv_buf, sizeof(struct xdr_buf));
@@ -77,25 +72,12 @@ int svc_rdma_handle_bc_reply(struct rpc_xprt *xprt, __be32 *rdma_resp,
 	spin_unlock(&xprt->transport_lock);
 
 	spin_lock(&xprt->queue_lock);
-	ret = 0;
 	xprt_complete_rqst(req->rq_task, rcvbuf->len);
 	xprt_unpin_rqst(req);
 	rcvbuf->len = 0;
 
 out_unlock:
 	spin_unlock(&xprt->queue_lock);
-out:
-	return ret;
-
-out_shortreply:
-	dprintk("svcrdma: short bc reply: xprt=%p, len=%zu\n",
-		xprt, src->iov_len);
-	goto out;
-
-out_notfound:
-	dprintk("svcrdma: unrecognized bc reply: xprt=%p, xid=%08x\n",
-		xprt, be32_to_cpu(xid));
-	goto out_unlock;
 }
 
 /* Send a backwards direction RPC call.
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index efa5fcb5793f..eee7c6478b30 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -878,12 +878,9 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		goto out_drop;
 	rqstp->rq_xprt_hlen = ret;
 
-	if (svc_rdma_is_backchannel_reply(xprt, p)) {
-		ret = svc_rdma_handle_bc_reply(xprt->xpt_bc_xprt, p,
-					       &rqstp->rq_arg);
-		svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
-		return ret;
-	}
+	if (svc_rdma_is_backchannel_reply(xprt, p))
+		goto out_backchannel;
+
 	svc_rdma_get_inv_rkey(rdma_xprt, ctxt);
 
 	p += rpcrdma_fixed_maxsz;
@@ -913,6 +910,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
 	return ret;
 
+out_backchannel:
+	svc_rdma_handle_bc_reply(rqstp, ctxt);
 out_drop:
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
 	return 0;

