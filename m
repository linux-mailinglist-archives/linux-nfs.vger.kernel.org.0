Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67BE299601
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781570AbgJZSyu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44483 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781411AbgJZSyt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id s14so9383199qkg.11;
        Mon, 26 Oct 2020 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YmDGVD1h9UeAesVa6tAnE/M/BMcF/UUcrSwGwabb9zU=;
        b=J6qk6gJUOV7/DNdkZOqLA8DEfZXO1/LEr81Q1OSeBXKYdFOuQ9fKn8TGg3Y3XiN+SH
         eGJL8NC/x6IwLwZmNhw8gAoFXmXEx9lkg2oCQ/3LLiQ+ZQr+KU/Y4rwqXIGTBnB5UmOu
         ZMb0jzSevmRfULnTT3sjdsoKTk/hOuP5/FD8usfNPmf5Su8vumKc8Qnts9CpVpijG9vt
         ozz/FnXaIrGHZI8deNoct3N/yQKX5Yep7p1pliNUoc96epsQVwlVLnHK+RN2Z5dKFQ82
         fTGOhYjZhMlyDGsMQfrnY4DGg2B6sDp2TYKPD7IkB8G1pO/GvsRtKCYPBWw3fbKG2Iin
         b3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YmDGVD1h9UeAesVa6tAnE/M/BMcF/UUcrSwGwabb9zU=;
        b=dQrxtO935HFt2+WjSMJKm8Bm5+6Gd5yOqARFddoeEIiZtILx5xny49HJA+mEb+Hq59
         MJ+Xah2xbtjZBsJfyPDG/CLAA+45GflBwafUwE3p4L5qCQa9XGMZwiyMw6Jz+fkl+8mI
         iRDUSeeZi4Pq9/K2xmgvthrPlJpIwjnJ03bJqXNB2e1qEeiv63N1PLSYPUga1Fz2w+gO
         uVj7c8cPNRcsh4/+oLgGMyljOTPlf2pvfxD3BGi1VgKKiZPEKRI8VYuZywV1s4+VlWWk
         k0Bdr1FVsH1tsm4Rs+GPT4lHANmUkfTwgDtMGTpB0Kt0qi/cbq6+uOxbr+r4D+J8tkaK
         mDLA==
X-Gm-Message-State: AOAM530F+buctYpi8+B+dxogeaDuzEN9gyZNzqLwYkHIh8++3s2G9PB6
        L1sNbWY3ZCOwh4F3xZsnuf7hslZdXwQ=
X-Google-Smtp-Source: ABdhPJw/qToBnwVZQ8rzZ6jvs0OOFqcNEfFiqHS+CZApYR3d/yeP7/EVXRKyOv55suGHXi7Zp3CMIg==
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr17818897qkj.211.1603738488169;
        Mon, 26 Oct 2020 11:54:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p38sm7462909qtb.20.2020.10.26.11.54.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:47 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIsk6F013643;
        Mon, 26 Oct 2020 18:54:46 GMT
Subject: [PATCH 10/20] svcrdma: Use parsed chunk lists to detect reverse
 direction replies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:46 -0400
Message-ID: <160373848616.1886.3476213491131167397.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Don't duplicate header decoding smarts here. Instead, use
the new parsed chunk lists.

Note that the XID sanity test is also removed. The XID is already
looked up by the cb handler, and is rejected if it's not recognized.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   29 ++++++++++++++---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index a89d4209fe2a..74247a33b6c6 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -144,6 +144,7 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
+	__be32			rc_msgtype;
 
 	struct svc_rdma_pcl	rc_call_pcl;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 2755ca178b09..72b07e8aa3c9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -668,7 +668,8 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
 	if (*p != rpcrdma_version)
 		goto out_version;
 	p += 2;
-	switch (*p) {
+	rctxt->rc_msgtype = *p;
+	switch (rctxt->rc_msgtype) {
 	case rdma_msg:
 		break;
 	case rdma_nomsg:
@@ -762,30 +763,28 @@ static void svc_rdma_send_error(struct svcxprt_rdma *rdma,
  * the RPC/RDMA header small and fixed in size, so it is
  * straightforward to check the RPC header's direction field.
  */
-static bool svc_rdma_is_backchannel_reply(struct svc_xprt *xprt,
-					  __be32 *rdma_resp)
+static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
+						struct svc_rdma_recv_ctxt *rctxt)
 {
-	__be32 *p;
+	__be32 *p = rctxt->rc_recv_buf;
 
 	if (!xprt->xpt_bc_xprt)
 		return false;
 
-	p = rdma_resp + 3;
-	if (*p++ != rdma_msg)
+	if (rctxt->rc_msgtype != rdma_msg)
 		return false;
 
-	if (*p++ != xdr_zero)
+	if (!pcl_is_empty(&rctxt->rc_call_pcl))
+		return false;
+	if (!pcl_is_empty(&rctxt->rc_read_pcl))
 		return false;
-	if (*p++ != xdr_zero)
+	if (!pcl_is_empty(&rctxt->rc_write_pcl))
 		return false;
-	if (*p++ != xdr_zero)
+	if (!pcl_is_empty(&rctxt->rc_reply_pcl))
 		return false;
 
-	/* XID sanity */
-	if (*p++ != *rdma_resp)
-		return false;
-	/* call direction */
-	if (*p == cpu_to_be32(RPC_CALL))
+	/* RPC call direction */
+	if (*(p + 8) == cpu_to_be32(RPC_CALL))
 		return false;
 
 	return true;
@@ -868,7 +867,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		goto out_drop;
 	rqstp->rq_xprt_hlen = ret;
 
-	if (svc_rdma_is_backchannel_reply(xprt, p))
+	if (svc_rdma_is_reverse_direction_reply(xprt, ctxt))
 		goto out_backchannel;
 
 	svc_rdma_get_inv_rkey(rdma_xprt, ctxt);


