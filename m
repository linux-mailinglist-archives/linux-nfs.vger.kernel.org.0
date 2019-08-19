Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A9D95112
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHSWpN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:45:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40147 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfHSWpN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:45:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id h21so2610123oie.7;
        Mon, 19 Aug 2019 15:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zmFja180y9h2DsLU8o+XPO/YzzGcxYC2qni3J+OcF8M=;
        b=AlUal8MHSRx1lnRXcOv8L7WlGoqDJLCO8biAWvoPZr/AcouZgxyCO8OChgEuyo1KhY
         2OID5aZhs96By9b1UOY2xWIpAT9M3QL4jcb6ByY5wZp1QP/KQdxuxggQ0n14AChwAnS8
         EsdOSIRvwrgeSdw3PBSGrsOWvj4MRqkknq2YZpbjiQqkqepVPmF85Sbo5yAHcfRyBQli
         2WsTm6zTu9VmX39EnUffErOTDiWegbM9YdiJicVq7ctqu1MAvNrIAnzACgNhuzc1YDxN
         hluNHz1bF/YaHNUpKq9pfifj7G87vJlSNaaoScjPtnW1nYRLpRirQV3BfW/q9GisjX28
         68Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zmFja180y9h2DsLU8o+XPO/YzzGcxYC2qni3J+OcF8M=;
        b=foX3dynGgcudlLBFHhqpOFmziPa8SSgIZ55p5siUOCaGJHuV/NOkMbNzQq2NZTjqvc
         gWucZC4TxoqpjQx65K/iYRldEZpruIxzZM3fEmI7I4yppc85IIZ5UDUaWRj9ebdzm85G
         fRwty77RZp4N7VnixxlBLu8InUwNG4aQM+4Jlm8bAB0RIhR0RpKRZzMduXVsN0a3QwIk
         d2nYkcFDwphfYH8ScAw14Kipod0WTBcHS/bdD6cfcuZz6JoGD1lWMSH3QytVqXF8FLrh
         3bJV1kv6JJCYKlYMlSTLsVBiJCYbcV9cpwDvA68cYMWl1JcDX/uueblxvmdoqQg71zNe
         2jPA==
X-Gm-Message-State: APjAAAVggEyv2b1hHfv1LF6tZ1hT24CjbtF7MdGd/KY6ESdrnbI46mht
        anisRuuPhbALpToC8HHl36UlLlYs
X-Google-Smtp-Source: APXvYqxYNRkUoIuUtFcE/yGr+MzSUepFqpOfxF/KuZbVriIC2M85dOgm3/6nVJRmQrOW7DR/cBLMcQ==
X-Received: by 2002:aca:5744:: with SMTP id l65mr15446127oib.159.1566254712147;
        Mon, 19 Aug 2019 15:45:12 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id a22sm5867379otr.3.2019.08.19.15.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:45:11 -0700 (PDT)
Subject: [PATCH v2 12/21] xprtrdma: Combine rpcrdma_mr_put and
 rpcrdma_mr_unmap_and_put
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:44:50 -0400
Message-ID: <156625467065.8161.9671734536400171055.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. There is only one remaining rpcrdma_mr_put call site, and
it can be directly replaced with unmap_and_put because mr->mr_dir is
set to DMA_NONE just before the call.

Now all the call sites do a DMA unmap, and we can just rename
mr_unmap_and_put to mr_put, which nicely matches mr_get.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    6 +++---
 net/sunrpc/xprtrdma/verbs.c     |   32 ++++++++------------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 -
 3 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index d7e763fafa04..97e1804139b8 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -129,7 +129,7 @@ void frwr_reset(struct rpcrdma_req *req)
 	struct rpcrdma_mr *mr;
 
 	while ((mr = rpcrdma_mr_pop(&req->rl_registered)))
-		rpcrdma_mr_unmap_and_put(mr);
+		rpcrdma_mr_put(mr);
 }
 
 /**
@@ -453,7 +453,7 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 		if (mr->mr_handle == rep->rr_inv_rkey) {
 			list_del_init(&mr->mr_list);
 			trace_xprtrdma_mr_remoteinv(mr);
-			rpcrdma_mr_unmap_and_put(mr);
+			rpcrdma_mr_put(mr);
 			break;	/* only one invalidated MR per RPC */
 		}
 }
@@ -463,7 +463,7 @@ static void __frwr_release_mr(struct ib_wc *wc, struct rpcrdma_mr *mr)
 	if (wc->status != IB_WC_SUCCESS)
 		rpcrdma_mr_recycle(mr);
 	else
-		rpcrdma_mr_unmap_and_put(mr);
+		rpcrdma_mr_put(mr);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index ee6fcf10425b..5e0b774ed522 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1233,34 +1233,15 @@ rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
 	return NULL;
 }
 
-static void
-__rpcrdma_mr_put(struct rpcrdma_buffer *buf, struct rpcrdma_mr *mr)
-{
-	spin_lock(&buf->rb_mrlock);
-	rpcrdma_mr_push(mr, &buf->rb_mrs);
-	spin_unlock(&buf->rb_mrlock);
-}
-
-/**
- * rpcrdma_mr_put - Release an rpcrdma_mr object
- * @mr: object to release
- *
- */
-void
-rpcrdma_mr_put(struct rpcrdma_mr *mr)
-{
-	__rpcrdma_mr_put(&mr->mr_xprt->rx_buf, mr);
-}
-
 /**
- * rpcrdma_mr_unmap_and_put - DMA unmap an MR and release it
- * @mr: object to release
+ * rpcrdma_mr_put - DMA unmap an MR and release it
+ * @mr: MR to release
  *
  */
-void
-rpcrdma_mr_unmap_and_put(struct rpcrdma_mr *mr)
+void rpcrdma_mr_put(struct rpcrdma_mr *mr)
 {
 	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
@@ -1268,7 +1249,10 @@ rpcrdma_mr_unmap_and_put(struct rpcrdma_mr *mr)
 				mr->mr_sg, mr->mr_nents, mr->mr_dir);
 		mr->mr_dir = DMA_NONE;
 	}
-	__rpcrdma_mr_put(&r_xprt->rx_buf, mr);
+
+	spin_lock(&buf->rb_mrlock);
+	rpcrdma_mr_push(mr, &buf->rb_mrs);
+	spin_unlock(&buf->rb_mrlock);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 9663b8ddd733..3e0839c2cda2 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -485,7 +485,6 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt);
 
 struct rpcrdma_mr *rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_mr_put(struct rpcrdma_mr *mr);
-void rpcrdma_mr_unmap_and_put(struct rpcrdma_mr *mr);
 
 static inline void
 rpcrdma_mr_recycle(struct rpcrdma_mr *mr)

