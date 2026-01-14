Return-Path: <linux-nfs+bounces-17873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED4D1F850
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E356E3047D96
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C4937F8D5;
	Wed, 14 Jan 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIV4npLW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293722E3E9;
	Wed, 14 Jan 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401597; cv=none; b=SgCae6lGtJKEDyw3gEAJuORv8p/RNBHqP+S0n0LcC0zQdLRXA9nKOUQFKLZVVVyRCkomBJMs7aiSSMl7tg5q/i7MlyzzGYFutwEXKPG8ZSjhkcXK8m6026bi09TJxiwKnULeXvXIs+eYK1AZj2fgeF9Al1m+LsPjOQ4a96y6Bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401597; c=relaxed/simple;
	bh=SxP1Qk5rwNRQnVWiD0IFT1q6SAWqJZACXSx+axpfOjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVtT2CosPuPOBAVaa3tmgiyr/hp93L7K+ztBHRTnUBn/IoCEI8v6wm3lRrb4KctNABzTjTDI0YY/cTEBI7xtXzh3ScNDqOQRvbQZqQkApmy9/wjso8t7GOo2hM6S20JU/ruhid+PBNPykc8RSX8QDKyfSQQuu9LdRsZhLVeURA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIV4npLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D67C4CEF7;
	Wed, 14 Jan 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768401596;
	bh=SxP1Qk5rwNRQnVWiD0IFT1q6SAWqJZACXSx+axpfOjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIV4npLWHURm8xwNe3Xf0JuuWnF+Fl5Nti0Nab0iWPwJqOGUIY5tEAwAoYNsywXN9
	 Eyd9JmmF+bH9nxTVCUtN2AFXdyEn1NPxM2jHU+0p3SsoKdAzY1HvbgsnG6RNneoqpo
	 bCXPTNb1cMgOP0qwv+I97cypUflUVXML8kiIWRef2+G6qmxZfz4NS7+LHmMmqpNrxh
	 HTdW814Pl21xi9TC0+KzJYfWhlADAfZlRX+JwsT7eJOe5FO6+rYA/YugP7fpdcX/ol
	 hXJKZwAIyy8FY2xAo2EVUzXenLLCi6vWUOVglMPFSHVTP6F2P8EFisRpM6GqkTmsUR
	 jWKT63yJYAlYw==
From: Chuck Lever <cel@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 4/4] svcrdma: use bvec-based RDMA read/write API
Date: Wed, 14 Jan 2026 09:39:48 -0500
Message-ID: <20260114143948.3946615-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114143948.3946615-1-cel@kernel.org>
References: <20260114143948.3946615-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Convert svcrdma to the bvec-based RDMA API introduced earlier in
this series.

The bvec-based RDMA API eliminates the intermediate scatterlist
conversion step, allowing direct DMA mapping from bio_vec arrays.
This simplifies the svc_rdma_rw_ctxt structure by removing the
inline scatterlist and chained SG table management.

The structure size reduction is significant: the previous inline
scatterlist array of RPCSVC_MAXPAGES entries (4KB or more) is
replaced with a pointer to a dynamically allocated bvec array,
bringing the fixed structure size down to approximately 100 bytes.

The bvec API handles all device types internally, including iWARP
devices which require memory registration. No explicit fallback
path is needed.

Signed-off-by: cel@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 115 ++++++++++++++----------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 310de7a80be5..fac83a78282b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -5,6 +5,7 @@
  * Use the core R/W API to move RPC-over-RDMA Read and Write chunks.
  */
 
+#include <linux/bvec.h>
 #include <rdma/rw.h>
 
 #include <linux/sunrpc/xdr.h>
@@ -21,29 +22,27 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
  * Write Work Requests.
  *
  * Each WR chain handles a single contiguous server-side buffer,
- * because scatterlist entries after the first have to start on
+ * because bio_vec entries after the first have to start on
  * page alignment. xdr_buf iovecs cannot guarantee alignment.
  *
  * Each WR chain handles only one R_key. Each RPC-over-RDMA segment
  * from a client may contain a unique R_key, so each WR chain moves
  * up to one segment at a time.
  *
- * The scatterlist makes this data structure over 4KB in size. To
- * make it less likely to fail, and to handle the allocation for
- * smaller I/O requests without disabling bottom-halves, these
- * contexts are created on demand, but cached and reused until the
- * controlling svcxprt_rdma is destroyed.
+ * These contexts are created on demand, but cached and reused until
+ * the controlling svcxprt_rdma is destroyed.
  */
 struct svc_rdma_rw_ctxt {
 	struct llist_node	rw_node;
 	struct list_head	rw_list;
 	struct rdma_rw_ctx	rw_ctx;
 	unsigned int		rw_nents;
-	unsigned int		rw_first_sgl_nents;
-	struct sg_table		rw_sg_table;
-	struct scatterlist	rw_first_sgl[];
+	struct bio_vec		*rw_bvec;
 };
 
+static void svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
+				 struct svc_rdma_rw_ctxt *ctxt);
+
 static inline struct svc_rdma_rw_ctxt *
 svc_rdma_next_ctxt(struct list_head *list)
 {
@@ -52,10 +51,9 @@ svc_rdma_next_ctxt(struct list_head *list)
 }
 
 static struct svc_rdma_rw_ctxt *
-svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
+svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int nr_bvec)
 {
 	struct ib_device *dev = rdma->sc_cm_id->device;
-	unsigned int first_sgl_nents = dev->attrs.max_send_sge;
 	struct svc_rdma_rw_ctxt *ctxt;
 	struct llist_node *node;
 
@@ -65,33 +63,35 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_rw_ctxt, rw_node);
 	} else {
-		ctxt = kmalloc_node(struct_size(ctxt, rw_first_sgl, first_sgl_nents),
-				    GFP_KERNEL, ibdev_to_node(dev));
+		ctxt = kmalloc_node(sizeof(*ctxt), GFP_KERNEL,
+				    ibdev_to_node(dev));
 		if (!ctxt)
 			goto out_noctx;
 
 		INIT_LIST_HEAD(&ctxt->rw_list);
-		ctxt->rw_first_sgl_nents = first_sgl_nents;
 	}
 
-	ctxt->rw_sg_table.sgl = ctxt->rw_first_sgl;
-	if (sg_alloc_table_chained(&ctxt->rw_sg_table, sges,
-				   ctxt->rw_sg_table.sgl,
-				   first_sgl_nents))
+	ctxt->rw_bvec = kmalloc_array_node(nr_bvec, sizeof(*ctxt->rw_bvec),
+					   GFP_KERNEL, ibdev_to_node(dev));
+	if (!ctxt->rw_bvec)
 		goto out_free;
 	return ctxt;
 
 out_free:
-	kfree(ctxt);
+	if (node)
+		svc_rdma_put_rw_ctxt(rdma, ctxt);
+	else
+		kfree(ctxt);
 out_noctx:
-	trace_svcrdma_rwctx_empty(rdma, sges);
+	trace_svcrdma_rwctx_empty(rdma, nr_bvec);
 	return NULL;
 }
 
 static void __svc_rdma_put_rw_ctxt(struct svc_rdma_rw_ctxt *ctxt,
 				   struct llist_head *list)
 {
-	sg_free_table_chained(&ctxt->rw_sg_table, ctxt->rw_first_sgl_nents);
+	kfree(ctxt->rw_bvec);
+	ctxt->rw_bvec = NULL;
 	llist_add(&ctxt->rw_node, list);
 }
 
@@ -105,6 +105,8 @@ static void svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
  * svc_rdma_destroy_rw_ctxts - Free accumulated R/W contexts
  * @rdma: transport about to be destroyed
  *
+ * Cached contexts have rw_bvec set to NULL because
+ * __svc_rdma_put_rw_ctxt() frees the bvec array before caching.
  */
 void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma)
 {
@@ -135,9 +137,10 @@ static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
 {
 	int ret;
 
-	ret = rdma_rw_ctx_init(&ctxt->rw_ctx, rdma->sc_qp, rdma->sc_port_num,
-			       ctxt->rw_sg_table.sgl, ctxt->rw_nents,
-			       0, offset, handle, direction);
+	ret = rdma_rw_ctx_init_bvec(&ctxt->rw_ctx, rdma->sc_qp,
+				    rdma->sc_port_num,
+				    ctxt->rw_bvec, ctxt->rw_nents,
+				    0, offset, handle, direction);
 	if (unlikely(ret < 0)) {
 		trace_svcrdma_dma_map_rw_err(rdma, offset, handle,
 					     ctxt->rw_nents, ret);
@@ -183,9 +186,9 @@ void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 	while ((ctxt = svc_rdma_next_ctxt(&cc->cc_rwctxts)) != NULL) {
 		list_del(&ctxt->rw_list);
 
-		rdma_rw_ctx_destroy(&ctxt->rw_ctx, rdma->sc_qp,
-				    rdma->sc_port_num, ctxt->rw_sg_table.sgl,
-				    ctxt->rw_nents, dir);
+		rdma_rw_ctx_destroy_bvec(&ctxt->rw_ctx, rdma->sc_qp,
+					 rdma->sc_port_num,
+					 ctxt->rw_bvec, ctxt->rw_nents, dir);
 		__svc_rdma_put_rw_ctxt(ctxt, &free);
 
 		ctxt->rw_node.next = first;
@@ -414,29 +417,25 @@ static int svc_rdma_post_chunk_ctxt(struct svcxprt_rdma *rdma,
 	return -ENOTCONN;
 }
 
-/* Build and DMA-map an SGL that covers one kvec in an xdr_buf
+/* Build a bvec that covers one kvec in an xdr_buf.
  */
-static void svc_rdma_vec_to_sg(struct svc_rdma_write_info *info,
-			       unsigned int len,
-			       struct svc_rdma_rw_ctxt *ctxt)
+static void svc_rdma_vec_to_bvec(struct svc_rdma_write_info *info,
+				 unsigned int len,
+				 struct svc_rdma_rw_ctxt *ctxt)
 {
-	struct scatterlist *sg = ctxt->rw_sg_table.sgl;
-
-	sg_set_buf(&sg[0], info->wi_base, len);
+	bvec_set_virt(&ctxt->rw_bvec[0], info->wi_base, len);
 	info->wi_base += len;
-
 	ctxt->rw_nents = 1;
 }
 
-/* Build and DMA-map an SGL that covers part of an xdr_buf's pagelist.
+/* Build a bvec array that covers part of an xdr_buf's pagelist.
  */
-static void svc_rdma_pagelist_to_sg(struct svc_rdma_write_info *info,
-				    unsigned int remaining,
-				    struct svc_rdma_rw_ctxt *ctxt)
+static void svc_rdma_pagelist_to_bvec(struct svc_rdma_write_info *info,
+				      unsigned int remaining,
+				      struct svc_rdma_rw_ctxt *ctxt)
 {
-	unsigned int sge_no, sge_bytes, page_off, page_no;
+	unsigned int bvec_idx, sge_bytes, page_off, page_no;
 	const struct xdr_buf *xdr = info->wi_xdr;
-	struct scatterlist *sg;
 	struct page **page;
 
 	page_off = info->wi_next_off + xdr->page_base;
@@ -444,21 +443,19 @@ static void svc_rdma_pagelist_to_sg(struct svc_rdma_write_info *info,
 	page_off = offset_in_page(page_off);
 	page = xdr->pages + page_no;
 	info->wi_next_off += remaining;
-	sg = ctxt->rw_sg_table.sgl;
-	sge_no = 0;
+	bvec_idx = 0;
 	do {
 		sge_bytes = min_t(unsigned int, remaining,
 				  PAGE_SIZE - page_off);
-		sg_set_page(sg, *page, sge_bytes, page_off);
-
+		bvec_set_page(&ctxt->rw_bvec[bvec_idx], *page, sge_bytes,
+			      page_off);
 		remaining -= sge_bytes;
-		sg = sg_next(sg);
 		page_off = 0;
-		sge_no++;
+		bvec_idx++;
 		page++;
 	} while (remaining);
 
-	ctxt->rw_nents = sge_no;
+	ctxt->rw_nents = bvec_idx;
 }
 
 /* Construct RDMA Write WRs to send a portion of an xdr_buf containing
@@ -535,7 +532,7 @@ static int svc_rdma_iov_write(struct svc_rdma_write_info *info,
 			      const struct kvec *iov)
 {
 	info->wi_base = iov->iov_base;
-	return svc_rdma_build_writes(info, svc_rdma_vec_to_sg,
+	return svc_rdma_build_writes(info, svc_rdma_vec_to_bvec,
 				     iov->iov_len);
 }
 
@@ -559,7 +556,7 @@ static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
 {
 	info->wi_xdr = xdr;
 	info->wi_next_off = offset - xdr->head[0].iov_len;
-	return svc_rdma_build_writes(info, svc_rdma_pagelist_to_sg,
+	return svc_rdma_build_writes(info, svc_rdma_pagelist_to_bvec,
 				     length);
 }
 
@@ -734,29 +731,27 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 {
 	struct svcxprt_rdma *rdma = svc_rdma_rqst_rdma(rqstp);
 	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
-	unsigned int sge_no, seg_len, len;
+	unsigned int bvec_idx, nr_bvec, seg_len, len;
 	struct svc_rdma_rw_ctxt *ctxt;
-	struct scatterlist *sg;
 	int ret;
 
 	len = segment->rs_length;
-	sge_no = PAGE_ALIGN(head->rc_pageoff + len) >> PAGE_SHIFT;
-	ctxt = svc_rdma_get_rw_ctxt(rdma, sge_no);
+	nr_bvec = PAGE_ALIGN(head->rc_pageoff + len) >> PAGE_SHIFT;
+	ctxt = svc_rdma_get_rw_ctxt(rdma, nr_bvec);
 	if (!ctxt)
 		return -ENOMEM;
-	ctxt->rw_nents = sge_no;
+	ctxt->rw_nents = nr_bvec;
 
-	sg = ctxt->rw_sg_table.sgl;
-	for (sge_no = 0; sge_no < ctxt->rw_nents; sge_no++) {
+	for (bvec_idx = 0; bvec_idx < ctxt->rw_nents; bvec_idx++) {
 		seg_len = min_t(unsigned int, len,
 				PAGE_SIZE - head->rc_pageoff);
 
 		if (!head->rc_pageoff)
 			head->rc_page_count++;
 
-		sg_set_page(sg, rqstp->rq_pages[head->rc_curpage],
-			    seg_len, head->rc_pageoff);
-		sg = sg_next(sg);
+		bvec_set_page(&ctxt->rw_bvec[bvec_idx],
+			      rqstp->rq_pages[head->rc_curpage],
+			      seg_len, head->rc_pageoff);
 
 		head->rc_pageoff += seg_len;
 		if (head->rc_pageoff == PAGE_SIZE) {
-- 
2.52.0


