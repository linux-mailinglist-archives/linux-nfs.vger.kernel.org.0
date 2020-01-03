Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFDB12FAEA
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgACQ46 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:56:58 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43636 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQ46 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:56:58 -0500
Received: by mail-yb1-f196.google.com with SMTP id v24so18838477ybd.10;
        Fri, 03 Jan 2020 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xs/OIZCaFg0QyQKRLKX5a5ofmuLVOt9cgDTAZQ1kDVU=;
        b=XHEG8rgI2fn+QGylKblgWuazG75l+JycMXKhLohCeCva15mY/k2YcMnC0YIK/o88he
         Mti1wnvbBuZA6sDee2SmFPMgbcEghQsUNSRFbn+rKG67sm7gBGTOH3/GVdF2YlNFAUtX
         Fctv1XcVxsV1EaQ901Vppt0cS/0stDbHNQIuPF8XDPhwyfnG3VjdzmG3IyPDNRAbjZSo
         UWD/RNtVL8ILC65XXDUE3Twgw86HMXrN2IlFK7TfLcMXV7vlWPLtLmsM5K8tYvPiTCeM
         m0ixcs8D6H1Y9NOXbtRfE46VaZWbl4VPWy1qWPeqLvvnLOZ5oEVVXOsI1PsOmjYGDxbn
         uw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=xs/OIZCaFg0QyQKRLKX5a5ofmuLVOt9cgDTAZQ1kDVU=;
        b=SGLDEHs+daRJzPhZViAemcW0ywuuoivhM2ObgejUAua0NaHHkfpiVbpseDbjhVLtfn
         sn9htkdk30fEe28d1UTepfsMdij7U40SsQzi1qIamUwo8AsWrDCanwFzxdjmkl2coXGc
         JqxSQCQAW4fWTUfCwp0QoF2LWpV3iuOr1idqrSG5R4KJ5nWTV63Nj6WdaRL1K3fJpii/
         nZqjvD1c7DNphVuNXZrNE351GNMRbcVReiRglTwdrp78DNQ3OGBBUwMKdJTvBj1Ib7rR
         RcyqOCLqi/0O86y2ZZKXj5jt5YYNI9cdGXMylSiLO205RwbvpIXKWJ9xPXzQVZ7ZmjlU
         7gQA==
X-Gm-Message-State: APjAAAWWHRqK1GKikInNjwT4qaKiyQYXwq5dIdAZS9R3gU/YWJle6+kQ
        zVh92ug/5uqdW7vg/BEd0zQvvmYW
X-Google-Smtp-Source: APXvYqwr6nviD2ppveahVUt6RI2VuWk2jlDz0Z/LMsBGnb28f6gOPCkhYXoE2ogyfvSEgr3WyDThPg==
X-Received: by 2002:a25:846:: with SMTP id 67mr24636369ybi.460.1578070614859;
        Fri, 03 Jan 2020 08:56:54 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d10sm23973286ywd.107.2020.01.03.08.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:56:54 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003Gur0Q016398;
        Fri, 3 Jan 2020 16:56:53 GMT
Subject: [PATCH v1 6/9] xprtrdma: Allocate and map transport header buffers at
 connect time
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:56:53 -0500
Message-ID: <157807061371.4606.808542074244029453.stgit@morisot.1015granger.net>
In-Reply-To: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
References: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the underlying RDMA device is chosen at transport set-up
time. But it will soon be at connect time instead.

The maximum size of a transport header is based on device
capabilities. Thus transport header buffers have to be allocated
_after_ the underlying device has been chosen (via address and route
resolution); ie, in the connect worker.

Thus, move the allocation of transport header buffers to the connect
worker, after the point at which the underlying RDMA device has been
chosen.

This also means the RDMA device is available to do a DMA mapping of
these buffers at connect time, instead of in the hot I/O path. Make
that optimization as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |    4 +
 net/sunrpc/xprtrdma/rpc_rdma.c    |   10 +--
 net/sunrpc/xprtrdma/verbs.c       |  106 +++++++++++++++++++++++++++----------
 net/sunrpc/xprtrdma/xprt_rdma.h   |    1 
 4 files changed, 84 insertions(+), 37 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 9d02eae353c6..1a0ae0c61353 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -194,6 +194,10 @@ static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
 	req = rpcrdma_req_create(r_xprt, size, GFP_KERNEL);
 	if (!req)
 		return NULL;
+	if (rpcrdma_req_setup(r_xprt, req)) {
+		rpcrdma_req_destroy(req);
+		return NULL;
+	}
 
 	xprt->bc_alloc_count++;
 	rqst = &req->rl_slot;
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index c6dcea06c754..28020ec104d4 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -580,22 +580,19 @@ void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
 
 /* Prepare an SGE for the RPC-over-RDMA transport header.
  */
-static bool rpcrdma_prepare_hdr_sge(struct rpcrdma_xprt *r_xprt,
+static void rpcrdma_prepare_hdr_sge(struct rpcrdma_xprt *r_xprt,
 				    struct rpcrdma_req *req, u32 len)
 {
 	struct rpcrdma_sendctx *sc = req->rl_sendctx;
 	struct rpcrdma_regbuf *rb = req->rl_rdmabuf;
 	struct ib_sge *sge = &sc->sc_sges[req->rl_wr.num_sge++];
 
-	if (!rpcrdma_regbuf_dma_map(r_xprt, rb))
-		return false;
 	sge->addr = rdmab_addr(rb);
 	sge->length = len;
 	sge->lkey = rdmab_lkey(rb);
 
 	ib_dma_sync_single_for_device(rdmab_device(rb), sge->addr, sge->length,
 				      DMA_TO_DEVICE);
-	return true;
 }
 
 /* The head iovec is straightforward, as it is usually already
@@ -836,10 +833,9 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 	req->rl_wr.num_sge = 0;
 	req->rl_wr.opcode = IB_WR_SEND;
 
-	ret = -EIO;
-	if (!rpcrdma_prepare_hdr_sge(r_xprt, req, hdrlen))
-		goto out_unmap;
+	rpcrdma_prepare_hdr_sge(r_xprt, req, hdrlen);
 
+	ret = -EIO;
 	switch (rtype) {
 	case rpcrdma_noch_pullup:
 		if (!rpcrdma_prepare_noch_pullup(r_xprt, req, xdr))
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 92a52934b622..7d06c6cd3d26 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -78,6 +78,7 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_sendctxs_destroy(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 				       struct rpcrdma_sendctx *sc);
+static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
@@ -380,6 +381,8 @@ rpcrdma_ia_open(struct rpcrdma_xprt *xprt)
  *
  * Divest transport H/W resources associated with this adapter,
  * but allow it to be restored later.
+ *
+ * Caller must hold the transport send lock.
  */
 void
 rpcrdma_ia_remove(struct rpcrdma_ia *ia)
@@ -387,8 +390,6 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 	struct rpcrdma_xprt *r_xprt = container_of(ia, struct rpcrdma_xprt,
 						   rx_ia);
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
-	struct rpcrdma_req *req;
 
 	/* This is similar to rpcrdma_ep_destroy, but:
 	 * - Don't cancel the connect worker.
@@ -411,11 +412,7 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 	 * mappings and MRs are gone.
 	 */
 	rpcrdma_reps_unmap(r_xprt);
-	list_for_each_entry(req, &buf->rb_allreqs, rl_all) {
-		rpcrdma_regbuf_dma_unmap(req->rl_rdmabuf);
-		rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
-		rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
-	}
+	rpcrdma_reqs_reset(r_xprt);
 	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
 	ib_dealloc_pd(ia->ri_pd);
@@ -714,6 +711,11 @@ rpcrdma_ep_connect(struct rpcrdma_ep *ep, struct rpcrdma_ia *ia)
 		goto out;
 	}
 
+	rc = rpcrdma_reqs_setup(r_xprt);
+	if (rc) {
+		rpcrdma_ep_disconnect(ep, ia);
+		goto out;
+	}
 	rpcrdma_mrs_create(r_xprt);
 
 out:
@@ -995,32 +997,19 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 				       gfp_t flags)
 {
 	struct rpcrdma_buffer *buffer = &r_xprt->rx_buf;
-	struct rpcrdma_regbuf *rb;
 	struct rpcrdma_req *req;
-	size_t maxhdrsize;
 
 	req = kzalloc(sizeof(*req), flags);
 	if (req == NULL)
 		goto out1;
 
-	/* Compute maximum header buffer size in bytes */
-	maxhdrsize = rpcrdma_fixed_maxsz + 3 +
-		     r_xprt->rx_ia.ri_max_rdma_segs * rpcrdma_readchunk_maxsz;
-	maxhdrsize *= sizeof(__be32);
-	rb = rpcrdma_regbuf_alloc(__roundup_pow_of_two(maxhdrsize),
-				  DMA_TO_DEVICE, flags);
-	if (!rb)
-		goto out2;
-	req->rl_rdmabuf = rb;
-	xdr_buf_init(&req->rl_hdrbuf, rdmab_data(rb), rdmab_length(rb));
-
 	req->rl_sendbuf = rpcrdma_regbuf_alloc(size, DMA_TO_DEVICE, flags);
 	if (!req->rl_sendbuf)
-		goto out3;
+		goto out2;
 
 	req->rl_recvbuf = rpcrdma_regbuf_alloc(size, DMA_NONE, flags);
 	if (!req->rl_recvbuf)
-		goto out4;
+		goto out3;
 
 	INIT_LIST_HEAD(&req->rl_free_mrs);
 	INIT_LIST_HEAD(&req->rl_registered);
@@ -1029,10 +1018,8 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	spin_unlock(&buffer->rb_lock);
 	return req;
 
-out4:
-	kfree(req->rl_sendbuf);
 out3:
-	kfree(req->rl_rdmabuf);
+	kfree(req->rl_sendbuf);
 out2:
 	kfree(req);
 out1:
@@ -1040,23 +1027,82 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 }
 
 /**
- * rpcrdma_reqs_reset - Reset all reqs owned by a transport
+ * rpcrdma_req_setup - Per-connection instance setup of an rpcrdma_req object
  * @r_xprt: controlling transport instance
+ * @req: rpcrdma_req object to set up
  *
- * ASSUMPTION: the rb_allreqs list is stable for the duration,
+ * Returns zero on success, and a negative errno on failure.
+ */
+int rpcrdma_req_setup(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
+{
+	struct rpcrdma_regbuf *rb;
+	size_t maxhdrsize;
+
+	/* Compute maximum header buffer size in bytes */
+	maxhdrsize = rpcrdma_fixed_maxsz + 3 +
+		     r_xprt->rx_ia.ri_max_rdma_segs * rpcrdma_readchunk_maxsz;
+	maxhdrsize *= sizeof(__be32);
+	rb = rpcrdma_regbuf_alloc(__roundup_pow_of_two(maxhdrsize),
+				  DMA_TO_DEVICE, GFP_KERNEL);
+	if (!rb)
+		goto out;
+
+	if (!__rpcrdma_regbuf_dma_map(r_xprt, rb))
+		goto out_free;
+
+	req->rl_rdmabuf = rb;
+	xdr_buf_init(&req->rl_hdrbuf, rdmab_data(rb), rdmab_length(rb));
+	return 0;
+
+out_free:
+	rpcrdma_regbuf_free(rb);
+out:
+	return -ENOMEM;
+}
+
+/* ASSUMPTION: the rb_allreqs list is stable for the duration,
  * and thus can be walked without holding rb_lock. Eg. the
  * caller is holding the transport send lock to exclude
  * device removal or disconnection.
  */
-static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt)
+static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_req *req;
+	int rc;
 
 	list_for_each_entry(req, &buf->rb_allreqs, rl_all) {
-		/* Credits are valid only for one connection */
-		req->rl_slot.rq_cong = 0;
+		rc = rpcrdma_req_setup(r_xprt, req);
+		if (rc)
+			return rc;
 	}
+	return 0;
+}
+
+static void rpcrdma_req_reset(struct rpcrdma_req *req)
+{
+	/* Credits are valid for only one connection */
+	req->rl_slot.rq_cong = 0;
+
+	rpcrdma_regbuf_free(req->rl_rdmabuf);
+	req->rl_rdmabuf = NULL;
+
+	rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
+	rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
+}
+
+/* ASSUMPTION: the rb_allreqs list is stable for the duration,
+ * and thus can be walked without holding rb_lock. Eg. the
+ * caller is holding the transport send lock to exclude
+ * device removal or disconnection.
+ */
+static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt)
+{
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+	struct rpcrdma_req *req;
+
+	list_for_each_entry(req, &buf->rb_allreqs, rl_all)
+		rpcrdma_req_reset(req);
 }
 
 static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 0aed1e98f2bf..37d5080c250b 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -478,6 +478,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp);
  */
 struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 				       gfp_t flags);
+int rpcrdma_req_setup(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void rpcrdma_req_destroy(struct rpcrdma_req *req);
 int rpcrdma_buffer_create(struct rpcrdma_xprt *);
 void rpcrdma_buffer_destroy(struct rpcrdma_buffer *);


