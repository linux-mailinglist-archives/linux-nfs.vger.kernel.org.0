Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A81DCFD5
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgEUOeW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgEUOeW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F79DC061A0E;
        Thu, 21 May 2020 07:34:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w18so7224646ilm.13;
        Thu, 21 May 2020 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RdAX8caYJ0iXy3SCEZHENL/3iYUYiev43YHvBxvtV8I=;
        b=O5cSj2EfpYWIBL3ZYTvSvRLCOSunqA6Qt3EfgDOAl3us6AkAOBWVOkl/V10/uk+vWJ
         fkZyWhvT1/F0bBD6jGODUp4l3VaJJ9cgMCwWkMvNZ6OJDr3tnDhWbrU2Dbv9EETX9P8c
         UGMjh3KegPo54XxVRnaRkJVLbZWhACgUOdALXNizhyfaVl/ODypvPibov3cC0xKfS/yQ
         DFHd7faMSODH0WQA58nuMoLX/cY3+y/angiq2GqjHoVYMUiujztJIP2mubPJQoMbFzcE
         iuThJO4kraLmD/jHTrE+1yjRMFpZjb45Am+VhtGPLHafL2fm+HGcG0S+yTqB0OTCrD+r
         JV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RdAX8caYJ0iXy3SCEZHENL/3iYUYiev43YHvBxvtV8I=;
        b=GNDCE1PDbk2UYKgldypx7PWQVChMzB5gti/MBfOx912QHeQCaidcbTBEW0NNJWQVG9
         t/muLTxU25hsZA/0I54OMb4vg6MbMJz1NlPltFmiR1fp6cKDE4Wy4yD+wRYsOdQ4XHX+
         bRhA7TZWzI7nRaexMM9NBYcJUVV8vIhUy5UOhe3DS6YKveBJlgpJQLoKhbcfiFYSkkdH
         Oh5ETJDqHRsdGNIBYn5GDbXi5mb8hNSUCVWu3YbQCNwK6WSWZtWotiQRMoSkNB0a1lVR
         CQFqUHEPGyOD/rqBxHThxZY2jShjWEUkWjp6Pb5ejPmUN6H2+YFPXYKy9nmezEcTYU5V
         Mcmg==
X-Gm-Message-State: AOAM530KRRapw0gU0TjvrCMRhD0Ki5nsJRMqjuHBzueiY29VejRRyZDM
        OpQBMmHXm07G4ws1lzMXZZHzhnwv
X-Google-Smtp-Source: ABdhPJy8L0DEqjW2k+4XTnTY9CKpBnMvKLKPumYtD1XDlkae9atvDzej65BXStOMCX4nGD8wFtvmnQ==
X-Received: by 2002:a92:c609:: with SMTP id p9mr8949056ilm.243.1590071661272;
        Thu, 21 May 2020 07:34:21 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y12sm3177404ilk.16.2020.05.21.07.34.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:20 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEYKI2000824;
        Thu, 21 May 2020 14:34:20 GMT
Subject: [PATCH v3 07/32] svcrdma: Remove backchannel dprintk call sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:20 -0400
Message-ID: <20200521143420.3557.75882.stgit@klimt.1015granger.net>
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

