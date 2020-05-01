Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10B1C1C17
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgEARk4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARkz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:40:55 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7B2C061A0C;
        Fri,  1 May 2020 10:40:55 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v26so8515005qto.0;
        Fri, 01 May 2020 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lCCExvyODMO0v1Z3g8fcgjDrSeXwtuhz60/Y3Fx4pvQ=;
        b=bHPIDmZJTJ23hGc8AflcZeNTv7Px8ZiYvWekxFSSHpqe0aV1xDqkcxJ28jWddJm8gk
         /qmAJ5muk0lEDeo9ynqVJmAZSEQ05YpXMHezNNVzEQV+uK2+vQE333NXq3WctMnvMObg
         +oVxTDzmaFRb0qlWNoq1YaR6cLOMpDpF/MFq1DvXepd8Tq3RIAdWeb0uyNtAflQGTp3E
         g8lcpGFhzJ44aEYNkGtCFZOeKwa8YkMr7JBV7vtW0uDB4+wuKzYjHAEwFepX6Y2B+sNn
         f+D/VdU0py5E8lb9OYjKjg1xGpgVBCDvWJnN3pHBaWInT8qHKLSXYF8zM0jxXT3HefwS
         e6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lCCExvyODMO0v1Z3g8fcgjDrSeXwtuhz60/Y3Fx4pvQ=;
        b=b2X7dkWrh7MuDRQ2oTzxisb0M6H6tZ550IgReTN9KAGONJXR08M5Sb7QExBm41xyEe
         oW8/Wwng7iDulbqrYkzI314kPAxdLJb+UvHC0r+dHYq+K6YXZjT1jQIIv/WTt/7jSiV+
         YnKm7Ox9oyM7G2QwGvmT3YcimU9Om3mii0HbQwlIKRNe+Vz4cauOSfa5ZJaxVhyWGgM5
         c1pjfeuk2rQ6QuaNY/2g1uk/JFa5rjiOADx7GLGMeqIu/5LN1GxM1nJcLFcnma+8BGgD
         DRdX/jyFebizufNxslPhMBH4nzdUJOADI4oPKBEfoCrJ9Bqw5Re4GxrDXGEtuLiG7JKD
         lUVg==
X-Gm-Message-State: AGi0Puaq2DgaoM+hWooHqqhvO/+5/6I74LGOd6/5Nfa2QbSUg7US1jKB
        IkWFznB1QPpzhVlqGB6JmOjhH9Xi
X-Google-Smtp-Source: APiQypJR+pqO+Vw7UC8fAgSo3MM2c4Nj4ptVlMbQYYuEYCSr42yZkV8MITLUQbjaiKSrmeD9lPCCpA==
X-Received: by 2002:ac8:1ad1:: with SMTP id h17mr5061098qtk.9.1588354854729;
        Fri, 01 May 2020 10:40:54 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m26sm3195717qta.53.2020.05.01.10.40.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:40:54 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041Herci026777;
        Fri, 1 May 2020 17:40:53 GMT
Subject: [PATCH v1 5/7] svcrdma: Fix backchannel return code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:40:53 -0400
Message-ID: <20200501174053.3899.37683.stgit@klimt.1015granger.net>
In-Reply-To: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
References: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
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

