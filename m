Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7A4BB9D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfFSOdG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:33:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39574 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOdG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:33:06 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so32668058iod.6;
        Wed, 19 Jun 2019 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cxBloHZEz0uIXbMYiiGPCt/fgo8r6q+kOG8HVdhmkmY=;
        b=WGnNvbsTmSd9yYibvpZ1E6IK7mkHVWAber+dmsmA+eZ9/gcL7ziZNm0bd40kPV3Awz
         88Vr2LnEEc7YRzLxgd0jscf/INFki+QvCe4/a6uDBeaVSJPFuhgAU28ukbsx649AG2J3
         RTsxpQZoSp3MBsf3SB/l8Z6DSH+camZ4siNlnYj33YeoSOV1/a9ydI4jn0nu94o79TXj
         chwG7Wt4m8wBiBidC/wTc0L/w0PuSJ5hIINAeBMYgqGVyyLpXB5ni2Ygr8iR01YQaGVw
         AJ40Kg4ykTfdwkW54F9IrJGbeJpfH6TG7/JLRCAysuPgYhz6NH5i5qTyHCWybzgbofeQ
         re4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=cxBloHZEz0uIXbMYiiGPCt/fgo8r6q+kOG8HVdhmkmY=;
        b=a/EbFuao/L5RdQreTUolid02VXGKFM3h7n09UPL99wt+mzD8oogeisAnwCWHuHqqLB
         ZzCv+3BlyGER1qDF8vJo2NKPc+UsuX//FITrYGxTEYSVv5nXuX/qTK8HDmHxYpp8aK8p
         McJe6v7KBi5ZOLsaBvniECEyCHLj6g1TpPj7PR7r357Q1kwCWQ+RXJ4kQfHwbLvfvfdH
         nWeNNUfW5cWk89Kvnz9mIFK2BtWJ+EBAjfEbSKre9IbvJhw7KcfBKh0c+bU0/h9o3U9N
         P1A0+6IK0D6DB+/Qwa7D38i/5aXq8oExX5Z8hXpRFXdvnIhjn9CKU1T31PjhzUHCWSq+
         OpOA==
X-Gm-Message-State: APjAAAUSO6NZjlZg/FxlwUiXUVyKHitrI8KYvFg9ZsKr2exKWGt055dL
        1eSUodjP3DDBn7YGbvQcOdd7Iq+I
X-Google-Smtp-Source: APXvYqxLQHCWDv4Kli4HLvsePKalPgZf0B7cMk0iZ9D7MA2bDVyCtpQDXN+hO6EYe4IwKGNT/6k40w==
X-Received: by 2002:a02:16c5:: with SMTP id a188mr97606018jaa.86.1560954785829;
        Wed, 19 Jun 2019 07:33:05 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s2sm13076970ioj.8.2019.06.19.07.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:05 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEX4Wn004512;
        Wed, 19 Jun 2019 14:33:04 GMT
Subject: [PATCH v4 07/19] xprtrdma: Add mechanism to place MRs back on the
 free list
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:33:04 -0400
Message-ID: <20190619143304.3826.15050.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a marshal operation fails, any MRs that were already set up for
that request are recycled. Recycling releases MRs and creates new
ones, which is expensive.

Since commit f2877623082b ("xprtrdma: Chain Send to FastReg WRs")
was merged, recycling FRWRs is unnecessary. This is because before
that commit, frwr_map had already posted FAST_REG Work Requests,
so ownership of the MRs had already been passed to the NIC and thus
dealing with them had to be delayed until they completed.

Since that commit, however, FAST_REG WRs are posted at the same time
as the Send WR. This means that if marshaling fails, we are certain
the MRs are safe to simply unmap and place back on the free list
because neither the Send nor the FAST_REG WRs have been posted yet.
The kernel still has ownership of the MRs at this point.

This reduces the total number of MRs that the xprt has to create
under heavy workloads and makes the marshaling logic less brittle.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   20 ++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c  |    1 +
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 22 insertions(+)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 5c480bc..524cac0 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -144,6 +144,26 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
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
index f23450b..67d72d6 100644
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

