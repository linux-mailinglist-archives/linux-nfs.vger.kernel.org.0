Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C922CE78
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfE1SVY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:21:24 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53963 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfE1SVY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:21:24 -0400
Received: by mail-it1-f195.google.com with SMTP id m141so5955079ita.3;
        Tue, 28 May 2019 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uHzjr5ujV1e5HRY2u+3bqiCffUkZMSbWoK0OLOu3dko=;
        b=M1TTPT1viKY1QUhCeYxzWZ6zXgLU8aoobmfsoA7JwCGaNcrdCD+DwAOASUPZR3ay9R
         FPyN7hBM1lZYx2/qvqRdC/uYbORg14nEL16MNqRXJd2OQp40pXWCZoH5xXEAUCGoDo59
         2v5fSlaG3zcBm8Wmq6K5AzeSBWAgLmZAiFf2MvR/Q0cqxowpPMU2311+56QncZTEesJi
         i6a0/akkyIY+vOCaiw+rDVPsSJ0HfjPcithS4wZyDNFdKJlZFnmPZyrd//Ip4jzMusag
         zLZQSsxnT3XvuCBLy9++/tfmg761HWliX986IrbnipdgWvEGdqUuviGZZKHzFwvs9qZ4
         s7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=uHzjr5ujV1e5HRY2u+3bqiCffUkZMSbWoK0OLOu3dko=;
        b=KgeO64YDVcH+uea8vNtS2GF2w/qvT5vyl24Uaq5WMLq81wn/pc8S6UqTEZhBr1KTiK
         wjd2IzcUXKKdK/qw9NGt9+x+rR7mkr9hXxlsDGskRVOmm/ZiPPdJBPoJBItz7etAWs2U
         gMsANYPIiBQW6Szv4VTq3XKN79zIw2se+4Ph40FIkwHYRFX6r6DWGXfswZhjFhYJ4o23
         JvA1ldJuVBVdm1DQC4Ua28aV+jAYuHehjqqUUMEbC9TgO7oUnmveng4DqL8abc1QNvTJ
         ytl2Qo6D8uXDow5rAIGRyTMiEDNIro8macQxnJQJ2GiIXPDOZwAdynRZTPSL4aJKSRyb
         LKnw==
X-Gm-Message-State: APjAAAUolrPXTKFt5dvjLuVp5S6Uaq1GZ1E8rvO454/le6Yx8mV0kUr5
        QtajHWA7SPobl73cVc2aQf4+5L6N
X-Google-Smtp-Source: APXvYqxrlowuNZmnRx8qre1b220q0FuO1wS/rmckX++Y3znHA9ujNxlpYGrskA2IEm/mCvsoN4L3RA==
X-Received: by 2002:a24:dcc5:: with SMTP id q188mr4214915itg.64.1559067683419;
        Tue, 28 May 2019 11:21:23 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i25sm4684349ioi.42.2019.05.28.11.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:21:23 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SILM5Z014531;
        Tue, 28 May 2019 18:21:22 GMT
Subject: [PATCH RFC 06/12] xprtrdma: Add mechanism to place MRs back on the
 free list
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:21:22 -0400
Message-ID: <20190528182122.19012.54699.stgit@manet.1015granger.net>
In-Reply-To: <20190528181018.19012.61210.stgit@manet.1015granger.net>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A marshal operation can fail if there are not enough MRs or if
the sendctx queue is empty. In this case, any MRs that were already
set up for that request are recycled. Recycling releases MRs and
creates new ones, which is expensive.

Since commit f2877623082b ("xprtrdma: Chain Send to FastReg WRs")
was merged, recycling FRWRs is unnecessary. This is because before
that commit, frwr_map had already posted FAST_REG Work Requests,
so the MRs were owned by the NIC and dealing with them had to be
delayed.

Since that commit, the FAST_REG WRs are posted at the same time as
the Send WR.  This means that if marshaling fails, we are certain
the MRs are safe to simply unmap and place back on the free list
because neither the Send nor the FAST_REG WRs have been posted yet.

This reduces the total number of MRs that the xprt has to create
under heavy workloads and makes the logic a bit less brittle.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   24 ++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c  |    1 +
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 26 insertions(+)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 99871fbf..ae97119 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -144,6 +144,30 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 	frwr_release_mr(mr);
 }
 
+/* frwr_reset - Place MRs back on the free list
+ * @req: request to reset
+ *
+ * Used after a failed marshal. For FRWR, this means the MRs
+ * don't have to be fully released and recreated.
+ *
+ * NB: This is safe only as long as none of @req's MRs are
+ * involved with an ongoing asynchronous FAST_REG or LOCAL_INV
+ * Work Request.
+ */
+void frwr_reset(struct rpcrdma_req *req)
+{
+	/* If this is a retransmit, discard previously registered
+	 * chunks. Very likely the connection has been replaced,
+	 * so these registrations are invalid and unusable.
+	 */
+	while (!list_empty(&req->rl_registered)) {
+		struct rpcrdma_mr *mr;
+
+		mr = rpcrdma_mr_pop(&req->rl_registered);
+		rpcrdma_mr_unmap_and_put(mr);
+	}
+}
+
 /**
  * frwr_init_mr - Initialize one MR
  * @ia: interface adapter
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 6c049fd..f211f81 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -884,6 +884,7 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 out_err:
 	trace_xprtrdma_marshal_failed(rqst, ret);
 	r_xprt->rx_stats.failed_marshal_count++;
+	frwr_reset(req);
 	return ret;
 }
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index a9de116..a396528 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -549,6 +549,7 @@ static inline bool rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 /* Memory registration calls xprtrdma/frwr_ops.c
  */
 bool frwr_is_supported(struct ib_device *device);
+void frwr_reset(struct rpcrdma_req *req);
 int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep);
 int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr);
 void frwr_release_mr(struct rpcrdma_mr *mr);

