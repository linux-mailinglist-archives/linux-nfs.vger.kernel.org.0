Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E19D4B0
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfHZRMs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 13:12:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33650 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbfHZRMs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 13:12:48 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so39162304iog.0;
        Mon, 26 Aug 2019 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9qf6o1Ch5bun7Gxd3Zkyhy/55x8Q6OkWi63jdiJ+soI=;
        b=nPdwid0bEdS22LnzqNe7rTD+DW5zuqHhlGbTy5OIg35B4Vha3jEVQinop9xk1pz+92
         BcJB1434YAEcIP/LZCRTjbE5CZt3KinAL8IqieBmoy5ESdsIsRwX7agl5LsKrlYgoubh
         rL9pDsg4gip3Poku9T/1SeuXXgcIMnPhwNMp0gUeSc9XM1GWFADldeORa2jlXq22i5Fw
         iWQVa5Oi5UThbHtiMs4SHgZBic0/R1wPGGmIDGOoiU8//kGAPxBUUL2F1uDuuZZga1te
         IBE3dhM5/NGw2PIJgM7E2qN1w5+6Ko+8EWqTH0VKEnt9z4ShWTNKCdcjFoXf3qCaDiLi
         rr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9qf6o1Ch5bun7Gxd3Zkyhy/55x8Q6OkWi63jdiJ+soI=;
        b=O/4p5Xv+g91/EjH/DQeyMfWnjJQXqMuJfhvsv4/fhtF+jvwDhd7qpC6PxRpqz/yQn+
         kWxbuZepuJbvE8I/LUtoicues2924K76UlbSd5z/ucGcxnCeSyRxSbZuUsVQS/nZIRt8
         VTjclq27+tq3hQBGLnvlTSlU4Sq325UWTqRe12K48BZjNUyyP+L7l0CJKzGPaivd8BHM
         wjyEt0UeelpijIdfZ+sq86ejoJ62sfLaVyy6JylS7SCmL0sC5TIFWHu4UOQHYd5BQbxd
         s6ZjUfsecSTQxLWqGhHZujnag5vG88djzep/i+pUN1R+b0NH3AKurH5Hf63au73DbsJB
         Tf5A==
X-Gm-Message-State: APjAAAXWuPlzs7XUeag5xRrsPoCyslb3i8gnrx576Up41ojgre9XIOXI
        hL6WrmQB8w39AHn6zR+mxCQ=
X-Google-Smtp-Source: APXvYqzkw1ttXY+hVEHZH9iY3xhLSXg0AfobWro4Sp504UmfF1CnGTjZa+SuX+SW/OFvjR0rIMkQbw==
X-Received: by 2002:a6b:610d:: with SMTP id v13mr18244683iob.226.1566839567725;
        Mon, 26 Aug 2019 10:12:47 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 199sm16802310iob.44.2019.08.26.10.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 10:12:47 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x7QHCkQ9031320;
        Mon, 26 Aug 2019 17:12:46 GMT
Subject: [PATCH 1/3] xprtrdma: Recycle MRs after disconnect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 26 Aug 2019 13:12:46 -0400
Message-ID: <20190826171246.4841.71393.stgit@manet.1015granger.net>
In-Reply-To: <20190826171107.4841.41733.stgit@manet.1015granger.net>
References: <20190826171107.4841.41733.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The optimization done in "xprtrdma: Simplify rpcrdma_mr_pop" was a
bit too optimistic. MRs left over after a reconnect still need to
be recycled, not added back to the free list, since they could be
in flight or actually fully registered.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   35 +++++++++++++++++++++++++++--------
 net/sunrpc/xprtrdma/rpc_rdma.c  |    2 +-
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 368cdf3..30065a2 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -88,15 +88,8 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 	kfree(mr);
 }
 
-/* MRs are dynamically allocated, so simply clean up and release the MR.
- * A replacement MR will subsequently be allocated on demand.
- */
-static void
-frwr_mr_recycle_worker(struct work_struct *work)
+static void frwr_mr_recycle(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 {
-	struct rpcrdma_mr *mr = container_of(work, struct rpcrdma_mr, mr_recycle);
-	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
-
 	trace_xprtrdma_mr_recycle(mr);
 
 	if (mr->mr_dir != DMA_NONE) {
@@ -114,6 +107,32 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 	frwr_release_mr(mr);
 }
 
+/* MRs are dynamically allocated, so simply clean up and release the MR.
+ * A replacement MR will subsequently be allocated on demand.
+ */
+static void
+frwr_mr_recycle_worker(struct work_struct *work)
+{
+	struct rpcrdma_mr *mr = container_of(work, struct rpcrdma_mr,
+					     mr_recycle);
+
+	frwr_mr_recycle(mr->mr_xprt, mr);
+}
+
+/* frwr_recycle - Discard MRs
+ * @req: request to reset
+ *
+ * Used after a reconnect. These MRs could be in flight, we can't
+ * tell. Safe thing to do is release them.
+ */
+void frwr_recycle(struct rpcrdma_req *req)
+{
+	struct rpcrdma_mr *mr;
+
+	while ((mr = rpcrdma_mr_pop(&req->rl_registered)))
+		frwr_mr_recycle(mr->mr_xprt, mr);
+}
+
 /* frwr_reset - Place MRs back on the free list
  * @req: request to reset
  *
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 67e1684..19dd29a 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -867,7 +867,7 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	 * chunks. Very likely the connection has been replaced,
 	 * so these registrations are invalid and unusable.
 	 */
-	frwr_reset(req);
+	frwr_recycle(req);
 
 	/* This implementation supports the following combinations
 	 * of chunk lists in one RPC-over-RDMA Call message:
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index bd1befa..65e6b0e 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -542,6 +542,7 @@ static inline bool rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 /* Memory registration calls xprtrdma/frwr_ops.c
  */
 bool frwr_is_supported(struct ib_device *device);
+void frwr_recycle(struct rpcrdma_req *req);
 void frwr_reset(struct rpcrdma_req *req);
 int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep);
 int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr);

