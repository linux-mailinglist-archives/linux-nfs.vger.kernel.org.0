Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CF0DB62B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404464AbfJQSbN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 14:31:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45994 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSbM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 14:31:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so2784068qkb.12;
        Thu, 17 Oct 2019 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Pz4rG8h6xekipFWcDb/qNVz1ZYjqPG2oa7RN9sxsHR4=;
        b=dHZRb88N/fvG+1roIUxqVOcpOWKb4YuDzo5ObbEjRxbRWUKHne2/TIJDQpNxYaLcJq
         G9BWgJF5wklcDe03MK/XJfJt7u0aBmyBg053vaKkxAVPf9QoAjTuEOjwCaW6gKvTohEP
         cjMovt4rdUKMJIBeIB29gc4CgacoTCw1J8uwEmB0XxOEp61QreoVV4TXx3yOX1jX9wcq
         vZs3cDFlrBkRPXRl3ZJg5EG7SLuYk76w64bxgquQ5DRyQmwcMfOPDcICYzI3yezqvukw
         QsaXmgzF8YK7/uHcj1GpATmldmk0j3ZAaOgixigzP3G5BEXuyxQT0v6Ura2JIdnlaiNi
         SMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Pz4rG8h6xekipFWcDb/qNVz1ZYjqPG2oa7RN9sxsHR4=;
        b=QDWBhdheamc31EF6kmHieJ2VH3ljlpwb/uYgxKv/HFdtQ1CPI1ExbbD4vWqyjQQb2V
         7GwwaJMyH1Cg/A28ebfHOeKi4+yrT4OUStXclR9RKWA7RnJkAmJsOtixKZRdcDKwJb8j
         Agb2nF/k/+m+QT1FpHSmfRRdbTEt30P+JMvQr7j2gPvjH4u6uJ16apJA+o+aSA+mw/Vy
         ZIVzKb+TPUaShM/YgnpxT4SwFnsSimDYjMVc6Xs+Ks9lK7L2jfSC6KNsg9RXW/MxnBDT
         a3UiHwQOlG0Brx221+lZE1wbwwKar7OnFkCjPYDsiZw9+rkqM178sD6eJTLbWMprzN4C
         8hFA==
X-Gm-Message-State: APjAAAVlVugSzWpMuJjsQepLfQNm+nNDtkFaTBQ+I3MlkMSW3EnEGBZU
        nfc7uKpvsVzV8KtbSWurTskaaKzZ
X-Google-Smtp-Source: APXvYqyYu9M3IDKFFS9TdUH90kAGUotlYXp4FZfHlJ047PlU7GcNZKPBtYHr34k8znerISUnSRQlIw==
X-Received: by 2002:a05:620a:20d5:: with SMTP id f21mr4642324qka.209.1571337070882;
        Thu, 17 Oct 2019 11:31:10 -0700 (PDT)
Received: from oracle-102.nfsv4bat.org ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id t40sm1863363qta.36.2019.10.17.11.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:31:10 -0700 (PDT)
Subject: [PATCH v1 1/6] xprtrdma: Ensure ri_id is stable during MR recycling
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Thu, 17 Oct 2019 14:31:09 -0400
Message-ID: <20191017183109.2517.8846.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ia->ri_id is replaced during a reconnect. The connect_worker runs
with the transport send lock held to prevent ri_id from being
dereferenced by the send_request path during this process.

Currently, however, there is no guarantee that ia->ri_id is stable
in the MR recycling worker, which operates in the background and is
not serialized with the connect_worker in any way.

But now that Local_Inv completions are being done in process
context, we can handle the recycling operation there instead of
deferring the recycling work to another process. Because the
disconnect path drains all work before allowing tear down to
proceed, it is guaranteed that Local Invalidations complete only
while the ri_id pointer is stable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   23 ++++++-----------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    7 -------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 37ba82d..5cd8715 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -88,8 +88,10 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 	kfree(mr);
 }
 
-static void frwr_mr_recycle(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
+static void frwr_mr_recycle(struct rpcrdma_mr *mr)
 {
+	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
+
 	trace_xprtrdma_mr_recycle(mr);
 
 	if (mr->mr_dir != DMA_NONE) {
@@ -107,18 +109,6 @@ static void frwr_mr_recycle(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	frwr_release_mr(mr);
 }
 
-/* MRs are dynamically allocated, so simply clean up and release the MR.
- * A replacement MR will subsequently be allocated on demand.
- */
-static void
-frwr_mr_recycle_worker(struct work_struct *work)
-{
-	struct rpcrdma_mr *mr = container_of(work, struct rpcrdma_mr,
-					     mr_recycle);
-
-	frwr_mr_recycle(mr->mr_xprt, mr);
-}
-
 /* frwr_reset - Place MRs back on the free list
  * @req: request to reset
  *
@@ -163,7 +153,6 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
 	mr->frwr.fr_mr = frmr;
 	mr->mr_dir = DMA_NONE;
 	INIT_LIST_HEAD(&mr->mr_list);
-	INIT_WORK(&mr->mr_recycle, frwr_mr_recycle_worker);
 	init_completion(&mr->frwr.fr_linv_done);
 
 	sg_init_table(sg, depth);
@@ -448,7 +437,7 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 static void __frwr_release_mr(struct ib_wc *wc, struct rpcrdma_mr *mr)
 {
 	if (wc->status != IB_WC_SUCCESS)
-		rpcrdma_mr_recycle(mr);
+		frwr_mr_recycle(mr);
 	else
 		rpcrdma_mr_put(mr);
 }
@@ -570,7 +559,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		bad_wr = bad_wr->next;
 
 		list_del_init(&mr->mr_list);
-		rpcrdma_mr_recycle(mr);
+		frwr_mr_recycle(mr);
 	}
 }
 
@@ -664,7 +653,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		mr = container_of(frwr, struct rpcrdma_mr, frwr);
 		bad_wr = bad_wr->next;
 
-		rpcrdma_mr_recycle(mr);
+		frwr_mr_recycle(mr);
 	}
 
 	/* The final LOCAL_INV WR in the chain is supposed to
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index a7ef965..b8e768d 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -257,7 +257,6 @@ struct rpcrdma_mr {
 	u32			mr_handle;
 	u32			mr_length;
 	u64			mr_offset;
-	struct work_struct	mr_recycle;
 	struct list_head	mr_all;
 };
 
@@ -490,12 +489,6 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 void rpcrdma_mr_put(struct rpcrdma_mr *mr);
 void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt);
 
-static inline void
-rpcrdma_mr_recycle(struct rpcrdma_mr *mr)
-{
-	schedule_work(&mr->mr_recycle);
-}
-
 struct rpcrdma_req *rpcrdma_buffer_get(struct rpcrdma_buffer *);
 void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers,
 			struct rpcrdma_req *req);

