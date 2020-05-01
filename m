Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927DE1C1C1A
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgEARlB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARlB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:41:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3056C061A0C;
        Fri,  1 May 2020 10:41:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb4so5082984qvb.7;
        Fri, 01 May 2020 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RdAX8caYJ0iXy3SCEZHENL/3iYUYiev43YHvBxvtV8I=;
        b=U49FcE/uMEaOm5bS2c3tdknrgPqtk9hz1umngR8R1649u/gMVLNPyJVOvA2Zbge8Hd
         ndFzmlhdfkFijBiqsLVDb3kTx8J9Fqh1bBLKX0IjmGaEfv4+x683Er9Ug5qJzhVNO+V6
         cBlKcYua97vZOZRNgIyEBMEzx5uClzLVRNBBEk/WZ4azo/+TJAogj8SdT29YwqTmooHN
         AWoG9hJtcQXPFrnkPC3Jum1WlbnmbiyAjEQ6dTxG/w02CrKILT1jcZ9fe7vMn2odCEW8
         3+WZnr014MmMfrukmDAxaOtwjjKn4ZaFnKsbdTM3jc/qdBSs9wt9LpkuNdmd4ny3XsV9
         /feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RdAX8caYJ0iXy3SCEZHENL/3iYUYiev43YHvBxvtV8I=;
        b=ngMdJcrS4Yuu38BWEjF6Wabtv2toukCLAXaBsK0V80Tiu1cjGOzkOQVIeG1FttXled
         hCTWugMDbPie+tBOL/CLKcVUl59++KmB4sLVNcQZIRtLSvHUrS8qMYwm+9DnUcoY8qkt
         DSQpjqe6xCUZkgK+KIBOyZMY+SCX2TO5kvzsAkV7e0+obdKVyVmVb4mPwvKaF2yKTELi
         lvc3NNZp8K1KWtfIwj7q/c12mMu+uzOA/lXmVxZ6x/qc+1XTMvyYOIw0rrYYJsdPmRbt
         JVBGJYoSVW7ewvMdc5SM5EBU2MKvJsHiQs0Z9V09jJ7aP5RC3NpchdD2j7QzUpumSt6m
         S5kA==
X-Gm-Message-State: AGi0PuY9o7iwMdd/m3bcgMWPp3iH+xQ1Q5yfFA0sKkro4TPAerCq9I02
        kkBto+8SDomvZpdvLBPEOKvJ1wTZ
X-Google-Smtp-Source: APiQypL/SiUpoKaEr/Q9PHYNBA6A0wZoHp/PGxGp5xLTLINpGYoFF+KvqyDEXmEC9Ybow+ak2vQmig==
X-Received: by 2002:a0c:f84b:: with SMTP id g11mr4770792qvo.155.1588354859981;
        Fri, 01 May 2020 10:40:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t14sm3076446qtj.71.2020.05.01.10.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:40:59 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HewV3026780;
        Fri, 1 May 2020 17:40:58 GMT
Subject: [PATCH v1 6/7] svcrdma: Remove backchannel dprintk call sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:40:58 -0400
Message-ID: <20200501174058.3899.54831.stgit@klimt.1015granger.net>
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

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   48 +++-------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index b174f3b109a5..1ee73f7cf931 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -10,10 +10,6 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#define RPCDBG_FACILITY	RPCDBG_SVCXPRT
-
-#undef SVCRDMA_BACKCHANNEL_DEBUG
-
 /**
  * svc_rdma_handle_bc_reply - Process incoming backchannel Reply
  * @rqstp: resources for handling the Reply
@@ -31,33 +27,17 @@ void svc_rdma_handle_bc_reply(struct svc_rqst *rqstp,
 	__be32 *rdma_resp = rctxt->rc_recv_buf;
 	struct rpc_rqst *req;
 	u32 credits;
-	size_t len;
-	__be32 xid;
-	__be32 *p;
-
-	p = (__be32 *)src->iov_base;
-	len = src->iov_len;
-	xid = *rdma_resp;
-
-#ifdef SVCRDMA_BACKCHANNEL_DEBUG
-	pr_info("%s: xid=%08x, length=%zu\n",
-		__func__, be32_to_cpu(xid), len);
-	pr_info("%s: RPC/RDMA: %*ph\n",
-		__func__, (int)RPCRDMA_HDRLEN_MIN, rdma_resp);
-	pr_info("%s:      RPC: %*ph\n",
-		__func__, (int)len, p);
-#endif
 
 	spin_lock(&xprt->queue_lock);
-	req = xprt_lookup_rqst(xprt, xid);
+	req = xprt_lookup_rqst(xprt, *rdma_resp);
 	if (!req)
 		goto out_unlock;
 
 	dst = &req->rq_private_buf.head[0];
 	memcpy(&req->rq_private_buf, &req->rq_rcv_buf, sizeof(struct xdr_buf));
-	if (dst->iov_len < len)
+	if (dst->iov_len < src->iov_len)
 		goto out_unlock;
-	memcpy(dst->iov_base, p, len);
+	memcpy(dst->iov_base, src->iov_base, src->iov_len);
 	xprt_pin_rqst(req);
 	spin_unlock(&xprt->queue_lock);
 
@@ -66,7 +46,6 @@ void svc_rdma_handle_bc_reply(struct svc_rqst *rqstp,
 		credits = 1;	/* don't deadlock */
 	else if (credits > r_xprt->rx_buf.rb_bc_max_requests)
 		credits = r_xprt->rx_buf.rb_bc_max_requests;
-
 	spin_lock(&xprt->transport_lock);
 	xprt->cwnd = credits << RPC_CWNDSHIFT;
 	spin_unlock(&xprt->transport_lock);
@@ -174,10 +153,6 @@ rpcrdma_bc_send_request(struct svcxprt_rdma *rdma, struct rpc_rqst *rqst)
 	*p++ = xdr_zero;
 	*p   = xdr_zero;
 
-#ifdef SVCRDMA_BACKCHANNEL_DEBUG
-	pr_info("%s: %*ph\n", __func__, 64, rqst->rq_buffer);
-#endif
-
 	rqst->rq_xtime = ktime_get();
 	rc = svc_rdma_bc_sendto(rdma, rqst, ctxt);
 	if (rc)
@@ -188,7 +163,6 @@ rpcrdma_bc_send_request(struct svcxprt_rdma *rdma, struct rpc_rqst *rqst)
 	svc_rdma_send_ctxt_put(rdma, ctxt);
 
 drop_connection:
-	dprintk("svcrdma: failed to send bc call\n");
 	return -ENOTCONN;
 }
 
@@ -207,9 +181,6 @@ static int xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
 		container_of(sxprt, struct svcxprt_rdma, sc_xprt);
 	int ret;
 
-	dprintk("svcrdma: sending bc call with xid: %08x\n",
-		be32_to_cpu(rqst->rq_xid));
-
 	if (test_bit(XPT_DEAD, &sxprt->xpt_flags))
 		return -ENOTCONN;
 
@@ -222,8 +193,6 @@ static int xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
 static void
 xprt_rdma_bc_close(struct rpc_xprt *xprt)
 {
-	dprintk("svcrdma: %s: xprt %p\n", __func__, xprt);
-
 	xprt_disconnect_done(xprt);
 	xprt->cwnd = RPC_CWNDSHIFT;
 }
@@ -231,8 +200,6 @@ xprt_rdma_bc_close(struct rpc_xprt *xprt)
 static void
 xprt_rdma_bc_put(struct rpc_xprt *xprt)
 {
-	dprintk("svcrdma: %s: xprt %p\n", __func__, xprt);
-
 	xprt_rdma_free_addresses(xprt);
 	xprt_free(xprt);
 }
@@ -267,19 +234,14 @@ xprt_setup_rdma_bc(struct xprt_create *args)
 	struct rpc_xprt *xprt;
 	struct rpcrdma_xprt *new_xprt;
 
-	if (args->addrlen > sizeof(xprt->addr)) {
-		dprintk("RPC:       %s: address too large\n", __func__);
+	if (args->addrlen > sizeof(xprt->addr))
 		return ERR_PTR(-EBADF);
-	}
 
 	xprt = xprt_alloc(args->net, sizeof(*new_xprt),
 			  RPCRDMA_MAX_BC_REQUESTS,
 			  RPCRDMA_MAX_BC_REQUESTS);
-	if (!xprt) {
-		dprintk("RPC:       %s: couldn't allocate rpc_xprt\n",
-			__func__);
+	if (!xprt)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	xprt->timeout = &xprt_rdma_bc_timeout;
 	xprt_set_bound(xprt);

