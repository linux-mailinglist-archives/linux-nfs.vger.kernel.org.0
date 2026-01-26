Return-Path: <linux-nfs+bounces-18484-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIRcHzqvd2n2kAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18484-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:15:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5BB8BFEA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98473056150
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4934D91E;
	Mon, 26 Jan 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgPZgL7x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56934D910;
	Mon, 26 Jan 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451260; cv=none; b=BDYD/x1NcWhCctkcVButzJtRFK/9PzNyMl5XxvGduu4cEyII8X5zx3Yzu1QOLHPoX6G4gh9k6/OAil5a9nFFFPDXv8dkHhcA7kCSmHTrNayhqeCa3r5ez1uzErwyxfWtv2gM6HOzUNzytKSi74bWhBY8yblSBTBV4Mx/Is6TiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451260; c=relaxed/simple;
	bh=SZ6Mjkrx+XP5v3qpppQGncC0vrIonLTkyO1OvWy6+qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I24czYRZsSoOedmOy8SDHaDVuIrCBlKRz7kQI2Tck9oLuhR+/f2xFa5JT70CGfW5w6TOSRWjueE4BdRgbNtyRlt3TpSRh7H/PKbzvZAvUfSl5kNSH0IEk+p6M/ztKSMKXMFn2GgytrZeLONnSKv+Zly+MQajIg0YVn7/f36xmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgPZgL7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC39C19425;
	Mon, 26 Jan 2026 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769451260;
	bh=SZ6Mjkrx+XP5v3qpppQGncC0vrIonLTkyO1OvWy6+qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgPZgL7xdcY4EGCS/ot6yyfwK2I+NmUr+u3HOgGSYPuQHO67gQz//AT5zOYdOYNFk
	 zwL0qG0pv5ZgpvSKNIz50XLT31DrdY45132xECZ74jqaykr29w2+O8TJcZ2JNGJ1JX
	 Fz3bPYVHPEW+DPfKX2nPh+YwjiPZg/mn+zpTM/qTvjf+Z5QVjP7gITB060vE0gn9vR
	 jZb0KB0mmVUbux7yJat+RO6IxlTcyc7Ggj/zamcslJlMA1SWkKt4DirEmc07jNzKYV
	 h+gGhJQLNKZPuL516wxUSwXDniYRmXOD/9L/WXoZCuKApIfXROtMEvyS/Svk/ePPER
	 5ByjbdbxHtfyw==
From: Chuck Lever <cel@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 3/5] RDMA/core: add MR support for bvec-based RDMA operations
Date: Mon, 26 Jan 2026 13:14:12 -0500
Message-ID: <20260126181414.105062-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126181414.105062-1-cel@kernel.org>
References: <20260126181414.105062-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18484-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E5BB8BFEA
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The bvec-based RDMA API currently returns -EOPNOTSUPP when Memory
Region registration is required. This prevents iWARP devices from
using the bvec path, since iWARP requires MR registration for RDMA
READ operations. The force_mr debug parameter is also unusable with
bvec input.

Add rdma_rw_init_mr_wrs_bvec() to handle MR registration for bvec
arrays. The approach creates a synthetic scatterlist populated with
DMA addresses from the bvecs, then reuses the existing ib_map_mr_sg()
infrastructure. This avoids driver changes while keeping the
implementation small.

The synthetic scatterlist is stored in the rdma_rw_ctx for cleanup.
On destroy, the MRs are returned to the pool and the bvec DMA
mappings are released using the stored addresses.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c            | 262 +++++++++++++++++-------
 drivers/infiniband/ulp/isert/ib_isert.c |   4 +-
 drivers/nvme/target/rdma.c              |   4 +-
 include/rdma/rw.h                       |  17 +-
 4 files changed, 202 insertions(+), 85 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index c2fc8cba972e..f6d3c0b84df1 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -122,6 +122,36 @@ static int rdma_rw_init_one_mr(struct ib_qp *qp, u32 port_num,
 	return count;
 }
 
+static int rdma_rw_init_reg_wr(struct rdma_rw_reg_ctx *reg,
+		struct rdma_rw_reg_ctx *prev, struct ib_qp *qp, u32 port_num,
+		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
+{
+	if (prev) {
+		if (reg->mr->need_inval)
+			prev->wr.wr.next = &reg->inv_wr;
+		else
+			prev->wr.wr.next = &reg->reg_wr.wr;
+	}
+
+	reg->reg_wr.wr.next = &reg->wr.wr;
+
+	reg->wr.wr.sg_list = &reg->sge;
+	reg->wr.wr.num_sge = 1;
+	reg->wr.remote_addr = remote_addr;
+	reg->wr.rkey = rkey;
+
+	if (dir == DMA_TO_DEVICE) {
+		reg->wr.wr.opcode = IB_WR_RDMA_WRITE;
+	} else if (!rdma_cap_read_inv(qp->device, port_num)) {
+		reg->wr.wr.opcode = IB_WR_RDMA_READ;
+	} else {
+		reg->wr.wr.opcode = IB_WR_RDMA_READ_WITH_INV;
+		reg->wr.wr.ex.invalidate_rkey = reg->mr->lkey;
+	}
+
+	return 1;
+}
+
 static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		u32 port_num, struct scatterlist *sg, u32 sg_cnt, u32 offset,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
@@ -132,14 +162,14 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	int i, j, ret = 0, count = 0;
 
 	ctx->nr_ops = DIV_ROUND_UP(sg_cnt, pages_per_mr);
-	ctx->reg = kcalloc(ctx->nr_ops, sizeof(*ctx->reg), GFP_KERNEL);
-	if (!ctx->reg) {
+	ctx->reg.ctx = kcalloc(ctx->nr_ops, sizeof(*ctx->reg.ctx), GFP_KERNEL);
+	if (!ctx->reg.ctx) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	for (i = 0; i < ctx->nr_ops; i++) {
-		struct rdma_rw_reg_ctx *reg = &ctx->reg[i];
+		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];
 		u32 nents = min(sg_cnt, pages_per_mr);
 
 		ret = rdma_rw_init_one_mr(qp, port_num, reg, sg, sg_cnt,
@@ -147,30 +177,8 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		if (ret < 0)
 			goto out_free;
 		count += ret;
-
-		if (prev) {
-			if (reg->mr->need_inval)
-				prev->wr.wr.next = &reg->inv_wr;
-			else
-				prev->wr.wr.next = &reg->reg_wr.wr;
-		}
-
-		reg->reg_wr.wr.next = &reg->wr.wr;
-
-		reg->wr.wr.sg_list = &reg->sge;
-		reg->wr.wr.num_sge = 1;
-		reg->wr.remote_addr = remote_addr;
-		reg->wr.rkey = rkey;
-		if (dir == DMA_TO_DEVICE) {
-			reg->wr.wr.opcode = IB_WR_RDMA_WRITE;
-		} else if (!rdma_cap_read_inv(qp->device, port_num)) {
-			reg->wr.wr.opcode = IB_WR_RDMA_READ;
-		} else {
-			reg->wr.wr.opcode = IB_WR_RDMA_READ_WITH_INV;
-			reg->wr.wr.ex.invalidate_rkey = reg->mr->lkey;
-		}
-		count++;
-
+		count += rdma_rw_init_reg_wr(reg, prev, qp, port_num,
+				remote_addr, rkey, dir);
 		remote_addr += reg->sge.length;
 		sg_cnt -= nents;
 		for (j = 0; j < nents; j++)
@@ -187,12 +195,95 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 out_free:
 	while (--i >= 0)
-		ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
-	kfree(ctx->reg);
+		ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg.ctx[i].mr);
+	kfree(ctx->reg.ctx);
 out:
 	return ret;
 }
 
+static int rdma_rw_init_mr_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 port_num, const struct bio_vec *bvecs, u32 nr_bvec,
+		struct bvec_iter *iter, u64 remote_addr, u32 rkey,
+		enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	struct rdma_rw_reg_ctx *prev = NULL;
+	u32 pages_per_mr = rdma_rw_fr_page_list_len(dev, qp->integrity_en);
+	struct scatterlist *sg;
+	int i, ret, count = 0;
+	u32 nents = 0;
+
+	/*
+	 * Build scatterlist from bvecs using the iterator. This follows
+	 * the pattern from __blk_rq_map_sg.
+	 */
+	ctx->reg.sgt.sgl = kmalloc_array(nr_bvec, sizeof(*ctx->reg.sgt.sgl),
+					 GFP_KERNEL);
+	if (!ctx->reg.sgt.sgl)
+		return -ENOMEM;
+	sg_init_table(ctx->reg.sgt.sgl, nr_bvec);
+
+	for (sg = ctx->reg.sgt.sgl; iter->bi_size; sg = sg_next(sg)) {
+		struct bio_vec bv = mp_bvec_iter_bvec(bvecs, *iter);
+
+		if (nents >= nr_bvec) {
+			ret = -EINVAL;
+			goto out_free_sgl;
+		}
+		sg_set_page(sg, bv.bv_page, bv.bv_len, bv.bv_offset);
+		bvec_iter_advance(bvecs, iter, bv.bv_len);
+		nents++;
+	}
+	sg_mark_end(sg_last(ctx->reg.sgt.sgl, nents));
+	ctx->reg.sgt.orig_nents = nents;
+
+	/* DMA map the scatterlist */
+	ret = ib_dma_map_sgtable_attrs(dev, &ctx->reg.sgt, dir, 0);
+	if (ret)
+		goto out_free_sgl;
+
+	ctx->nr_ops = DIV_ROUND_UP(ctx->reg.sgt.nents, pages_per_mr);
+	ctx->reg.ctx = kcalloc(ctx->nr_ops, sizeof(*ctx->reg.ctx), GFP_KERNEL);
+	if (!ctx->reg.ctx) {
+		ret = -ENOMEM;
+		goto out_unmap_sgt;
+	}
+
+	sg = ctx->reg.sgt.sgl;
+	nents = ctx->reg.sgt.nents;
+	for (i = 0; i < ctx->nr_ops; i++) {
+		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];
+		u32 sge_cnt = min(nents, pages_per_mr);
+
+		ret = rdma_rw_init_one_mr(qp, port_num, reg, sg, sge_cnt, 0);
+		if (ret < 0)
+			goto out_free_mrs;
+		count += ret;
+		count += rdma_rw_init_reg_wr(reg, prev, qp, port_num,
+				remote_addr, rkey, dir);
+		remote_addr += reg->sge.length;
+		nents -= sge_cnt;
+		sg += sge_cnt;
+		prev = reg;
+	}
+
+	if (prev)
+		prev->wr.wr.next = NULL;
+
+	ctx->type = RDMA_RW_MR;
+	return count;
+
+out_free_mrs:
+	while (--i >= 0)
+		ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg.ctx[i].mr);
+	kfree(ctx->reg.ctx);
+out_unmap_sgt:
+	ib_dma_unmap_sgtable_attrs(dev, &ctx->reg.sgt, dir, 0);
+out_free_sgl:
+	kfree(ctx->reg.sgt.sgl);
+	return ret;
+}
+
 static int rdma_rw_init_map_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		struct scatterlist *sg, u32 sg_cnt, u32 offset,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
@@ -547,19 +638,13 @@ EXPORT_SYMBOL(rdma_rw_ctx_init);
  * @rkey:	remote key to operate on
  * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
  *
- * Accepts bio_vec arrays directly, avoiding scatterlist conversion for
- * callers that already have data in bio_vec form. Prefer this over
- * rdma_rw_ctx_init() when the source data is a bio_vec array.
- *
- * This function does not support devices requiring memory registration.
- * iWARP devices and configurations with force_mr=1 should use
- * rdma_rw_ctx_init() with a scatterlist instead.
+ * Maps the bio_vec array directly, avoiding intermediate scatterlist
+ * conversion. Supports MR registration for iWARP devices and force_mr mode.
  *
  * Returns the number of WQEs that will be needed on the workqueue if
  * successful, or a negative error code:
  *
  *   * -EINVAL  - @nr_bvec is zero or @iter.bi_size is zero
- *   * -EOPNOTSUPP - device requires MR path (iWARP or force_mr=1)
  *   * -ENOMEM - DMA mapping or memory allocation failed
  */
 int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
@@ -567,14 +652,24 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		struct bvec_iter iter, u64 remote_addr, u32 rkey,
 		enum dma_data_direction dir)
 {
+	struct ib_device *dev = qp->pd->device;
 	int ret;
 
 	if (nr_bvec == 0 || iter.bi_size == 0)
 		return -EINVAL;
 
-	/* MR path not supported for bvec - reject iWARP and force_mr */
-	if (rdma_rw_io_needs_mr(qp->device, port_num, dir, nr_bvec))
-		return -EOPNOTSUPP;
+	/*
+	 * iWARP requires MR registration for all RDMA READs. The force_mr
+	 * debug option also mandates MR usage.
+	 */
+	if (dir == DMA_FROM_DEVICE && rdma_protocol_iwarp(dev, port_num))
+		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvecs,
+						nr_bvec, &iter, remote_addr,
+						rkey, dir);
+	if (unlikely(rdma_rw_force_mr))
+		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvecs,
+						nr_bvec, &iter, remote_addr,
+						rkey, dir);
 
 	if (nr_bvec == 1)
 		return rdma_rw_init_single_wr_bvec(ctx, qp, bvecs, &iter,
@@ -582,13 +677,23 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	/*
 	 * Try IOVA-based mapping first for multi-bvec transfers.
-	 * This reduces IOTLB sync overhead by batching all mappings.
+	 * IOVA coalesces bvecs into a single DMA-contiguous region,
+	 * reducing the number of WRs needed and avoiding MR overhead.
 	 */
 	ret = rdma_rw_init_iova_wrs_bvec(ctx, qp, bvecs, &iter, remote_addr,
 			rkey, dir);
 	if (ret != -EOPNOTSUPP)
 		return ret;
 
+	/*
+	 * IOVA mapping not available. Check if MR registration provides
+	 * better performance than multiple SGE entries.
+	 */
+	if (rdma_rw_io_needs_mr(dev, port_num, dir, nr_bvec))
+		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvecs,
+						nr_bvec, &iter, remote_addr,
+						rkey, dir);
+
 	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvecs, nr_bvec, &iter,
 			remote_addr, rkey, dir);
 }
@@ -649,23 +754,23 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	ctx->type = RDMA_RW_SIG_MR;
 	ctx->nr_ops = 1;
-	ctx->reg = kzalloc(sizeof(*ctx->reg), GFP_KERNEL);
-	if (!ctx->reg) {
+	ctx->reg.ctx = kzalloc(sizeof(*ctx->reg.ctx), GFP_KERNEL);
+	if (!ctx->reg.ctx) {
 		ret = -ENOMEM;
 		goto out_unmap_prot_sg;
 	}
 
-	ctx->reg->mr = ib_mr_pool_get(qp, &qp->sig_mrs);
-	if (!ctx->reg->mr) {
+	ctx->reg.ctx->mr = ib_mr_pool_get(qp, &qp->sig_mrs);
+	if (!ctx->reg.ctx->mr) {
 		ret = -EAGAIN;
 		goto out_free_ctx;
 	}
 
-	count += rdma_rw_inv_key(ctx->reg);
+	count += rdma_rw_inv_key(ctx->reg.ctx);
 
-	memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));
+	memcpy(ctx->reg.ctx->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));
 
-	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sgt.nents, NULL, prot_sg,
+	ret = ib_map_mr_sg_pi(ctx->reg.ctx->mr, sg, sgt.nents, NULL, prot_sg,
 			      prot_sgt.nents, NULL, SZ_4K);
 	if (unlikely(ret)) {
 		pr_err("failed to map PI sg (%u)\n",
@@ -673,24 +778,24 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		goto out_destroy_sig_mr;
 	}
 
-	ctx->reg->reg_wr.wr.opcode = IB_WR_REG_MR_INTEGRITY;
-	ctx->reg->reg_wr.wr.wr_cqe = NULL;
-	ctx->reg->reg_wr.wr.num_sge = 0;
-	ctx->reg->reg_wr.wr.send_flags = 0;
-	ctx->reg->reg_wr.access = IB_ACCESS_LOCAL_WRITE;
+	ctx->reg.ctx->reg_wr.wr.opcode = IB_WR_REG_MR_INTEGRITY;
+	ctx->reg.ctx->reg_wr.wr.wr_cqe = NULL;
+	ctx->reg.ctx->reg_wr.wr.num_sge = 0;
+	ctx->reg.ctx->reg_wr.wr.send_flags = 0;
+	ctx->reg.ctx->reg_wr.access = IB_ACCESS_LOCAL_WRITE;
 	if (rdma_protocol_iwarp(qp->device, port_num))
-		ctx->reg->reg_wr.access |= IB_ACCESS_REMOTE_WRITE;
-	ctx->reg->reg_wr.mr = ctx->reg->mr;
-	ctx->reg->reg_wr.key = ctx->reg->mr->lkey;
+		ctx->reg.ctx->reg_wr.access |= IB_ACCESS_REMOTE_WRITE;
+	ctx->reg.ctx->reg_wr.mr = ctx->reg.ctx->mr;
+	ctx->reg.ctx->reg_wr.key = ctx->reg.ctx->mr->lkey;
 	count++;
 
-	ctx->reg->sge.addr = ctx->reg->mr->iova;
-	ctx->reg->sge.length = ctx->reg->mr->length;
+	ctx->reg.ctx->sge.addr = ctx->reg.ctx->mr->iova;
+	ctx->reg.ctx->sge.length = ctx->reg.ctx->mr->length;
 	if (sig_attrs->wire.sig_type == IB_SIG_TYPE_NONE)
-		ctx->reg->sge.length -= ctx->reg->mr->sig_attrs->meta_length;
+		ctx->reg.ctx->sge.length -= ctx->reg.ctx->mr->sig_attrs->meta_length;
 
-	rdma_wr = &ctx->reg->wr;
-	rdma_wr->wr.sg_list = &ctx->reg->sge;
+	rdma_wr = &ctx->reg.ctx->wr;
+	rdma_wr->wr.sg_list = &ctx->reg.ctx->sge;
 	rdma_wr->wr.num_sge = 1;
 	rdma_wr->remote_addr = remote_addr;
 	rdma_wr->rkey = rkey;
@@ -698,15 +803,15 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		rdma_wr->wr.opcode = IB_WR_RDMA_WRITE;
 	else
 		rdma_wr->wr.opcode = IB_WR_RDMA_READ;
-	ctx->reg->reg_wr.wr.next = &rdma_wr->wr;
+	ctx->reg.ctx->reg_wr.wr.next = &rdma_wr->wr;
 	count++;
 
 	return count;
 
 out_destroy_sig_mr:
-	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg->mr);
+	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg.ctx->mr);
 out_free_ctx:
-	kfree(ctx->reg);
+	kfree(ctx->reg.ctx);
 out_unmap_prot_sg:
 	if (prot_sgt.nents)
 		ib_dma_unmap_sgtable_attrs(dev, &prot_sgt, dir, 0);
@@ -754,16 +859,16 @@ struct ib_send_wr *rdma_rw_ctx_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	case RDMA_RW_SIG_MR:
 	case RDMA_RW_MR:
 		for (i = 0; i < ctx->nr_ops; i++) {
-			rdma_rw_update_lkey(&ctx->reg[i],
-				ctx->reg[i].wr.wr.opcode !=
+			rdma_rw_update_lkey(&ctx->reg.ctx[i],
+				ctx->reg.ctx[i].wr.wr.opcode !=
 					IB_WR_RDMA_READ_WITH_INV);
 		}
 
-		if (ctx->reg[0].inv_wr.next)
-			first_wr = &ctx->reg[0].inv_wr;
+		if (ctx->reg.ctx[0].inv_wr.next)
+			first_wr = &ctx->reg.ctx[0].inv_wr;
 		else
-			first_wr = &ctx->reg[0].reg_wr.wr;
-		last_wr = &ctx->reg[ctx->nr_ops - 1].wr.wr;
+			first_wr = &ctx->reg.ctx[0].reg_wr.wr;
+		last_wr = &ctx->reg.ctx[ctx->nr_ops - 1].wr.wr;
 		break;
 	case RDMA_RW_IOVA:
 		first_wr = &ctx->iova.wr.wr;
@@ -833,9 +938,11 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	switch (ctx->type) {
 	case RDMA_RW_MR:
+		/* Bvec MR contexts must use rdma_rw_ctx_destroy_bvec() */
+		WARN_ON_ONCE(ctx->reg.sgt.sgl);
 		for (i = 0; i < ctx->nr_ops; i++)
-			ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
-		kfree(ctx->reg);
+			ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg.ctx[i].mr);
+		kfree(ctx->reg.ctx);
 		break;
 	case RDMA_RW_MULTI_WR:
 		kfree(ctx->map.wrs);
@@ -880,6 +987,13 @@ void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	u32 i;
 
 	switch (ctx->type) {
+	case RDMA_RW_MR:
+		for (i = 0; i < ctx->nr_ops; i++)
+			ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg.ctx[i].mr);
+		kfree(ctx->reg.ctx);
+		ib_dma_unmap_sgtable_attrs(dev, &ctx->reg.sgt, dir, 0);
+		kfree(ctx->reg.sgt.sgl);
+		break;
 	case RDMA_RW_IOVA:
 		dma_iova_destroy(dev->dma_device, &ctx->iova.state,
 				 ctx->iova.mapped_len, dir, 0);
@@ -921,8 +1035,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	if (WARN_ON_ONCE(ctx->type != RDMA_RW_SIG_MR))
 		return;
 
-	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg->mr);
-	kfree(ctx->reg);
+	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg.ctx->mr);
+	kfree(ctx->reg.ctx);
 
 	if (prot_sg_cnt)
 		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index af811d060cc8..0c6152b7660e 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1589,7 +1589,7 @@ isert_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	isert_dbg("Cmd %p\n", isert_cmd);
 
-	ret = isert_check_pi_status(cmd, isert_cmd->rw.reg->mr);
+	ret = isert_check_pi_status(cmd, isert_cmd->rw.reg.ctx->mr);
 	isert_rdma_rw_ctx_destroy(isert_cmd, isert_conn);
 
 	if (ret) {
@@ -1635,7 +1635,7 @@ isert_rdma_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	iscsit_stop_dataout_timer(cmd);
 
 	if (isert_prot_cmd(isert_conn, se_cmd))
-		ret = isert_check_pi_status(se_cmd, isert_cmd->rw.reg->mr);
+		ret = isert_check_pi_status(se_cmd, isert_cmd->rw.reg.ctx->mr);
 	isert_rdma_rw_ctx_destroy(isert_cmd, isert_conn);
 	cmd->write_data_done = 0;
 
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9c12b2361a6d..a4aa6719a86e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -767,7 +767,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	}
 
 	if (rsp->req.metadata_len)
-		status = nvmet_rdma_check_pi_status(rsp->rw.reg->mr);
+		status = nvmet_rdma_check_pi_status(rsp->rw.reg.ctx->mr);
 	nvmet_rdma_rw_ctx_destroy(rsp);
 
 	if (unlikely(status))
@@ -808,7 +808,7 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	 * - if succeeded send good NVMe response
 	 * - if failed send bad NVMe response with appropriate error
 	 */
-	status = nvmet_rdma_check_pi_status(rsp->rw.reg->mr);
+	status = nvmet_rdma_check_pi_status(rsp->rw.reg.ctx->mr);
 	if (unlikely(status))
 		rsp->req.cqe->status = cpu_to_le16(status << 1);
 	nvmet_rdma_rw_ctx_destroy(rsp);
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 205e16ed6cd8..53ed0f05fa25 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -41,13 +41,16 @@ struct rdma_rw_ctx {
 		} iova;
 
 		/* for registering multiple WRs: */
-		struct rdma_rw_reg_ctx {
-			struct ib_sge		sge;
-			struct ib_rdma_wr	wr;
-			struct ib_reg_wr	reg_wr;
-			struct ib_send_wr	inv_wr;
-			struct ib_mr		*mr;
-		} *reg;
+		struct {
+			struct rdma_rw_reg_ctx {
+				struct ib_sge		sge;
+				struct ib_rdma_wr	wr;
+				struct ib_reg_wr	reg_wr;
+				struct ib_send_wr	inv_wr;
+				struct ib_mr		*mr;
+			}			*ctx;
+			struct sg_table		sgt;
+		} reg;
 	};
 };
 
-- 
2.52.0


