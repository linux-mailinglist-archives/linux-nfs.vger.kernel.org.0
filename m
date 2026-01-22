Return-Path: <linux-nfs+bounces-18336-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMPhC+iecmm/ngAAu9opvQ
	(envelope-from <linux-nfs+bounces-18336-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D944A6E071
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A21C301C10B
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 22:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DB3BC4CF;
	Thu, 22 Jan 2026 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3fQyBkA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797232E6BC;
	Thu, 22 Jan 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119451; cv=none; b=RydvACjqEhXP1HBJgfiaJkh8U4DgkwUbRnJyoWF7qu+Xj3nMMJm2VxZCBJAb+QUP/GzX1kCpBbItkgy62DPq1xwlTS6b/h37W6Xdu0z3UDEewVP+rMxtSMC3ikYpthkIWXRjwIQeRZ8vqnYQT72V6uNz7LwD/lITGkdYx5UCIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119451; c=relaxed/simple;
	bh=GqHoFKlICzAtwkELf/PPKiHVN3AMVmyd0NvMPUhCkWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPmFn38DXLN2PWOMyxADkGc9KPLIb1qoSaj6EWGQ24d98ibqBFaOYKlJA3GGvuQIKdv1l0jYbuLdEFHGzDv13uMpyiEBn7rVxXcu/TosvW4x4dZ03CIHT/nh9zjBz6j3TP6qkxi7dKphYyIR0t+6CLkAsNEf+L1BPx1rj5SnfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3fQyBkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CE9C116C6;
	Thu, 22 Jan 2026 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119450;
	bh=GqHoFKlICzAtwkELf/PPKiHVN3AMVmyd0NvMPUhCkWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3fQyBkAv5aP+J6Ppus/hWNcqcbNJSzkhJyv33BYbmlXBmNNjo/spgzp+LiSLFH7J
	 +2y7CYtM+GhvhP+MYpIF3tz4EVfYulxL7f37z9aig/zkhACkZnzXQTOsuChSPeSVW1
	 fbTq0XSfmxcS+rkyH/VDlGsgYgWSxdjHoScIGXQ2oe63rZo3w+q5P+stfHIyWlsM44
	 ost98yiRh0i1XwgWFr0+FiWzejJR7GcIHtWFbp/3IDomIW6iJ53Dgp8LBlK2SCd5BY
	 cmJu13W5WQI1F7Al152EGERBbrrHDojtcSs52oQPc/AoNF7tLlderSSsRyCzyF3T99
	 0Rvd1B4YkvcEw==
From: Chuck Lever <cel@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 5/5] svcrdma: use bvec-based RDMA read/write API
Date: Thu, 22 Jan 2026 17:04:01 -0500
Message-ID: <20260122220401.1143331-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122220401.1143331-1-cel@kernel.org>
References: <20260122220401.1143331-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18336-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: D944A6E071
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert svcrdma to the bvec-based RDMA API introduced earlier in
this series.

The bvec-based RDMA API eliminates the intermediate scatterlist
conversion step, allowing direct DMA mapping from bio_vec arrays.
This simplifies the svc_rdma_rw_ctxt structure by removing the
chained SG table management.

The structure retains an inline array approach similar to the
previous scatterlist implementation: an inline bvec array sized
to max_send_sge handles most I/O operations without additional
allocation. Larger requests fall back to dynamic allocation.
This preserves the allocation-free fast path for typical NFS
operations while supporting arbitrarily large transfers.

The bvec API handles all device types internally, including iWARP
devices which require memory registration. No explicit fallback
path is needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 155 +++++++++++++++++-------------
 1 file changed, 86 insertions(+), 69 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 310de7a80be5..4ec2f9ae06aa 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -5,6 +5,8 @@
  * Use the core R/W API to move RPC-over-RDMA Read and Write chunks.
  */
 
+#include <linux/bvec.h>
+#include <linux/overflow.h>
 #include <rdma/rw.h>
 
 #include <linux/sunrpc/xdr.h>
@@ -20,30 +22,33 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
 /* Each R/W context contains state for one chain of RDMA Read or
  * Write Work Requests.
  *
- * Each WR chain handles a single contiguous server-side buffer,
- * because scatterlist entries after the first have to start on
- * page alignment. xdr_buf iovecs cannot guarantee alignment.
+ * Each WR chain handles a single contiguous server-side buffer.
+ * - each xdr_buf iovec is a single contiguous buffer
+ * - the xdr_buf pages array is a single contiguous buffer because the
+ *   second through the last element always start on a page boundary
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
+ * The inline bvec array is sized to handle most I/O requests without
+ * additional allocation. Larger requests fall back to dynamic allocation.
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
+	unsigned int		rw_first_bvec_nents;
+	struct bio_vec		*rw_bvec;
+	struct bio_vec		rw_first_bvec[];
 };
 
+static void svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
+				 struct svc_rdma_rw_ctxt *ctxt);
+
 static inline struct svc_rdma_rw_ctxt *
 svc_rdma_next_ctxt(struct list_head *list)
 {
@@ -52,10 +57,10 @@ svc_rdma_next_ctxt(struct list_head *list)
 }
 
 static struct svc_rdma_rw_ctxt *
-svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
+svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int nr_bvec)
 {
 	struct ib_device *dev = rdma->sc_cm_id->device;
-	unsigned int first_sgl_nents = dev->attrs.max_send_sge;
+	unsigned int first_bvec_nents = dev->attrs.max_send_sge;
 	struct svc_rdma_rw_ctxt *ctxt;
 	struct llist_node *node;
 
@@ -65,33 +70,44 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_rw_ctxt, rw_node);
 	} else {
-		ctxt = kmalloc_node(struct_size(ctxt, rw_first_sgl, first_sgl_nents),
+		ctxt = kmalloc_node(struct_size(ctxt, rw_first_bvec,
+						first_bvec_nents),
 				    GFP_KERNEL, ibdev_to_node(dev));
 		if (!ctxt)
 			goto out_noctx;
 
 		INIT_LIST_HEAD(&ctxt->rw_list);
-		ctxt->rw_first_sgl_nents = first_sgl_nents;
+		ctxt->rw_first_bvec_nents = first_bvec_nents;
 	}
 
-	ctxt->rw_sg_table.sgl = ctxt->rw_first_sgl;
-	if (sg_alloc_table_chained(&ctxt->rw_sg_table, sges,
-				   ctxt->rw_sg_table.sgl,
-				   first_sgl_nents))
-		goto out_free;
+	if (nr_bvec <= ctxt->rw_first_bvec_nents) {
+		ctxt->rw_bvec = ctxt->rw_first_bvec;
+	} else {
+		ctxt->rw_bvec = kmalloc_array_node(nr_bvec,
+						   sizeof(*ctxt->rw_bvec),
+						   GFP_KERNEL,
+						   ibdev_to_node(dev));
+		if (!ctxt->rw_bvec)
+			goto out_free;
+	}
 	return ctxt;
 
 out_free:
-	kfree(ctxt);
+	/* Return cached contexts to cache; free freshly allocated ones */
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
+	if (ctxt->rw_bvec != ctxt->rw_first_bvec)
+		kfree(ctxt->rw_bvec);
 	llist_add(&ctxt->rw_node, list);
 }
 
@@ -123,6 +139,7 @@ void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma)
  * @ctxt: R/W context to prepare
  * @offset: RDMA offset
  * @handle: RDMA tag/handle
+ * @length: total number of bytes in the bvec array
  * @direction: I/O direction
  *
  * Returns on success, the number of WQEs that will be needed
@@ -130,14 +147,18 @@ void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma)
  */
 static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
 				struct svc_rdma_rw_ctxt *ctxt,
-				u64 offset, u32 handle,
+				u64 offset, u32 handle, unsigned int length,
 				enum dma_data_direction direction)
 {
+	struct bvec_iter iter = {
+		.bi_size = length,
+	};
 	int ret;
 
-	ret = rdma_rw_ctx_init(&ctxt->rw_ctx, rdma->sc_qp, rdma->sc_port_num,
-			       ctxt->rw_sg_table.sgl, ctxt->rw_nents,
-			       0, offset, handle, direction);
+	ret = rdma_rw_ctx_init_bvec(&ctxt->rw_ctx, rdma->sc_qp,
+				    rdma->sc_port_num,
+				    ctxt->rw_bvec, ctxt->rw_nents,
+				    iter, offset, handle, direction);
 	if (unlikely(ret < 0)) {
 		trace_svcrdma_dma_map_rw_err(rdma, offset, handle,
 					     ctxt->rw_nents, ret);
@@ -175,7 +196,6 @@ void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 {
 	struct llist_node *first, *last;
 	struct svc_rdma_rw_ctxt *ctxt;
-	LLIST_HEAD(free);
 
 	trace_svcrdma_cc_release(&cc->cc_cid, cc->cc_sqecount);
 
@@ -183,10 +203,11 @@ void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 	while ((ctxt = svc_rdma_next_ctxt(&cc->cc_rwctxts)) != NULL) {
 		list_del(&ctxt->rw_list);
 
-		rdma_rw_ctx_destroy(&ctxt->rw_ctx, rdma->sc_qp,
-				    rdma->sc_port_num, ctxt->rw_sg_table.sgl,
-				    ctxt->rw_nents, dir);
-		__svc_rdma_put_rw_ctxt(ctxt, &free);
+		rdma_rw_ctx_destroy_bvec(&ctxt->rw_ctx, rdma->sc_qp,
+					 rdma->sc_port_num,
+					 ctxt->rw_bvec, ctxt->rw_nents, dir);
+		if (ctxt->rw_bvec != ctxt->rw_first_bvec)
+			kfree(ctxt->rw_bvec);
 
 		ctxt->rw_node.next = first;
 		first = &ctxt->rw_node;
@@ -414,29 +435,26 @@ static int svc_rdma_post_chunk_ctxt(struct svcxprt_rdma *rdma,
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
+	unsigned int bvec_idx, bvec_len, page_off, page_no;
 	const struct xdr_buf *xdr = info->wi_xdr;
-	struct scatterlist *sg;
 	struct page **page;
 
 	page_off = info->wi_next_off + xdr->page_base;
@@ -444,21 +462,19 @@ static void svc_rdma_pagelist_to_sg(struct svc_rdma_write_info *info,
 	page_off = offset_in_page(page_off);
 	page = xdr->pages + page_no;
 	info->wi_next_off += remaining;
-	sg = ctxt->rw_sg_table.sgl;
-	sge_no = 0;
+	bvec_idx = 0;
 	do {
-		sge_bytes = min_t(unsigned int, remaining,
-				  PAGE_SIZE - page_off);
-		sg_set_page(sg, *page, sge_bytes, page_off);
-
-		remaining -= sge_bytes;
-		sg = sg_next(sg);
+		bvec_len = min_t(unsigned int, remaining,
+				 PAGE_SIZE - page_off);
+		bvec_set_page(&ctxt->rw_bvec[bvec_idx], *page, bvec_len,
+			      page_off);
+		remaining -= bvec_len;
 		page_off = 0;
-		sge_no++;
+		bvec_idx++;
 		page++;
 	} while (remaining);
 
-	ctxt->rw_nents = sge_no;
+	ctxt->rw_nents = bvec_idx;
 }
 
 /* Construct RDMA Write WRs to send a portion of an xdr_buf containing
@@ -496,7 +512,7 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 		constructor(info, write_len, ctxt);
 		offset = seg->rs_offset + info->wi_seg_off;
 		ret = svc_rdma_rw_ctx_init(rdma, ctxt, offset, seg->rs_handle,
-					   DMA_TO_DEVICE);
+					   write_len, DMA_TO_DEVICE);
 		if (ret < 0)
 			return -EIO;
 		percpu_counter_inc(&svcrdma_stat_write);
@@ -535,7 +551,7 @@ static int svc_rdma_iov_write(struct svc_rdma_write_info *info,
 			      const struct kvec *iov)
 {
 	info->wi_base = iov->iov_base;
-	return svc_rdma_build_writes(info, svc_rdma_vec_to_sg,
+	return svc_rdma_build_writes(info, svc_rdma_vec_to_bvec,
 				     iov->iov_len);
 }
 
@@ -559,7 +575,7 @@ static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
 {
 	info->wi_xdr = xdr;
 	info->wi_next_off = offset - xdr->head[0].iov_len;
-	return svc_rdma_build_writes(info, svc_rdma_pagelist_to_sg,
+	return svc_rdma_build_writes(info, svc_rdma_pagelist_to_bvec,
 				     length);
 }
 
@@ -734,29 +750,29 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 {
 	struct svcxprt_rdma *rdma = svc_rdma_rqst_rdma(rqstp);
 	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
-	unsigned int sge_no, seg_len, len;
+	unsigned int bvec_idx, nr_bvec, seg_len, len, total;
 	struct svc_rdma_rw_ctxt *ctxt;
-	struct scatterlist *sg;
 	int ret;
 
 	len = segment->rs_length;
-	sge_no = PAGE_ALIGN(head->rc_pageoff + len) >> PAGE_SHIFT;
-	ctxt = svc_rdma_get_rw_ctxt(rdma, sge_no);
+	if (check_add_overflow(head->rc_pageoff, len, &total))
+		return -EINVAL;
+	nr_bvec = PAGE_ALIGN(total) >> PAGE_SHIFT;
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
@@ -770,7 +786,8 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 	}
 
 	ret = svc_rdma_rw_ctx_init(rdma, ctxt, segment->rs_offset,
-				   segment->rs_handle, DMA_FROM_DEVICE);
+				   segment->rs_handle, segment->rs_length,
+				   DMA_FROM_DEVICE);
 	if (ret < 0)
 		return -EIO;
 	percpu_counter_inc(&svcrdma_stat_read);
-- 
2.52.0


