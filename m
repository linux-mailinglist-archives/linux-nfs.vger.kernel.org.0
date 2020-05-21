Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE51DCFD3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgEUOeT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgEUOeT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6945C061A0E;
        Thu, 21 May 2020 07:34:17 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id x5so7656758ioh.6;
        Thu, 21 May 2020 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lCCExvyODMO0v1Z3g8fcgjDrSeXwtuhz60/Y3Fx4pvQ=;
        b=ElI61aP+pnjEVcfgqwQl5Tcl7SsrvMqscpMVUvbtIuMkhWo8f8PNb6UcD0YMaECok7
         t4rbDha/DPsUknh5jPWD7TGpzxE6KRmQFKbVtuigo4CO8guVAE56gWnlMv0KCVZnyNmS
         MqOIpKnpJiqi/Ylx6Rxnicacj2hH37/Xv6k8aBRShrT8KGWnYW6YtUwLLG15f49dOlWL
         juaGudN6Vrxyr66zCpx1Kd+2GpBkmQcyYhtZ8VOMWxMMLDFC+b0An3iykjH3PPDwkUTi
         Rh7CuQExV96/BFfIE0rvSO3kr521d1Au/kpa0i5nJUHcBifWrUbNIyeFTGkSCWbcZhS9
         w8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lCCExvyODMO0v1Z3g8fcgjDrSeXwtuhz60/Y3Fx4pvQ=;
        b=hn36SQgOoYhKOUYwAjucXLnx4mvOvrHtiqNiENl37tk8k1nIHgLIsStOFuP79nbE5y
         LRoBJujMI2AGhVrFwPsThnVuzbdo/iZydPlyYiQxy5nNICg7gmstZVO28ogHyTrvvdam
         vGikdWaw7q1WRITSlK65fESaTwR+57ISRc9HLSb+ZEFDO9mnVwnn40AF9Y9WMbQrRBKA
         SBHPRVpEITAXS/2wWNAxwX0mQsHXJ70F4USJN1HS+esCwLZcA3M5wwf8zPVe9u/+c2Yx
         Sch5t9epeZ9p2pdxPc3p4MvRm5+KrwI8ZsZkZ3CRFfiBlNqunajni/1O+FrBuXPtfQZK
         VZmw==
X-Gm-Message-State: AOAM531VQkNsLfprSB4u6EftOu55l5qlkrxqf4OJ8Z+NU/KMCIS/zTxy
        5G4pYHkDWT4TmOItc1/qSLNS5+2X
X-Google-Smtp-Source: ABdhPJzGfu+HRiUV/gCDQ0jIbijeSt+bCr06Yzz90cOa1DgEGcIOVfIxvF9/9iQOGmMoo2zCQHRZgg==
X-Received: by 2002:a02:58c3:: with SMTP id f186mr4126768jab.120.1590071656693;
        Thu, 21 May 2020 07:34:16 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r8sm2441055iob.15.2020.05.21.07.34.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:15 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEYFmJ000821;
        Thu, 21 May 2020 14:34:15 GMT
Subject: [PATCH v3 06/32] svcrdma: Fix backchannel return code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:15 -0400
Message-ID: <20200521143415.3557.79764.stgit@klimt.1015granger.net>
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

