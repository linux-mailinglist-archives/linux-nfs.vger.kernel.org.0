Return-Path: <linux-nfs+bounces-18544-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIb1ND9eeWn+wgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18544-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 01:54:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E669BC6C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 01:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 401CE30095C3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 00:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75FC21D5AF;
	Wed, 28 Jan 2026 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaOL8BbR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53951FECCD;
	Wed, 28 Jan 2026 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769561646; cv=none; b=T6ocFOzRUpto0FmbKUbqbR0dw7S/5GQOhv9H3qMqHijxBAuLrlweEr0N7pomTV3gBdZVZKL9a/ZUmaRQRrMFgK/ecTaSWgsEpcE9rY3mG9gr140R3QjRr4UBna10hlnD1Sc0q07aymPMzeHkfNkAlXG20T2Gwkxl5ZiNdqp3c74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769561646; c=relaxed/simple;
	bh=P6BWSy5B1emluoa2Q8PyFunu+KfrkTt9lNO65WKdz8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brMNTx2UIp8zPCVDRPVTnDCzelhC4uwTELOXFV3JrnYXMiXzLRjGFnx+KcQVYHO1AjO3MLmF6YjTQFpjxxrtO292VH/ugyFwW7pxcjpyx+MX+pOlbeG44XswC/HQzA8gHVPz1F1pGX9uBh/bC2ojRaK5DArRX3pOoV+GatzSGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaOL8BbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CF8C116D0;
	Wed, 28 Jan 2026 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769561646;
	bh=P6BWSy5B1emluoa2Q8PyFunu+KfrkTt9lNO65WKdz8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaOL8BbR2ImM/fNAdVT6Rdlw57PcHHkxP4SI77lp/gU1v9VVJN1GzPWw4RLwqKNUh
	 eNAYX7y25uBPM0XPLibJIjYBw2mgA8Fb/UTu7EKtenFBMgfnBHZ4Ov+T6fLmCbFjIl
	 sbH1xCJfoGMSoqARkdwyJINELHAoS9bcSh1FSTPkbXwfeP+41F+pS9ntCoRebi8tTu
	 c61/MclLQL1lJ71+GnQIHFKoW5m+m6xU5Ltg0bNep4IJP2RFTv1bKyeXKRVixDsy0B
	 7Dvp43BGk1NU4veN0UndXXWLEnfAzlrY09NRE4VciPTUWAsUv/j6peUL/dA+Ew+1lW
	 5rd1WxTO9YZPA==
From: Chuck Lever <cel@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 3/5] RDMA/core: add MR support for bvec-based RDMA operations
Date: Tue, 27 Jan 2026 19:53:58 -0500
Message-ID: <20260128005400.25147-4-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128005400.25147-1-cel@kernel.org>
References: <20260128005400.25147-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18544-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0E669BC6C
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
 drivers/infiniband/core/rw.c | 189 ++++++++++++++++++++++++++++-------
 include/rdma/rw.h            |   1 +
 2 files changed, 154 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index c2fc8cba972e..2c148457b589 100644
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
@@ -193,6 +201,92 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
+	ctx->reg = kcalloc(DIV_ROUND_UP(nr_bvec, pages_per_mr),
+			   sizeof(*ctx->reg), GFP_KERNEL);
+	if (!ctx->reg)
+		return -ENOMEM;
+
+	/*
+	 * Build scatterlist from bvecs using the iterator. This follows
+	 * the pattern from __blk_rq_map_sg.
+	 */
+	ctx->reg[0].sgt.sgl = kmalloc_array(nr_bvec,
+					    sizeof(*ctx->reg[0].sgt.sgl),
+					    GFP_KERNEL);
+	if (!ctx->reg[0].sgt.sgl) {
+		ret = -ENOMEM;
+		goto out_free_reg;
+	}
+	sg_init_table(ctx->reg[0].sgt.sgl, nr_bvec);
+
+	for (sg = ctx->reg[0].sgt.sgl; iter->bi_size; sg = sg_next(sg)) {
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
+	sg_mark_end(sg_last(ctx->reg[0].sgt.sgl, nents));
+	ctx->reg[0].sgt.orig_nents = nents;
+
+	/* DMA map the scatterlist */
+	ret = ib_dma_map_sgtable_attrs(dev, &ctx->reg[0].sgt, dir, 0);
+	if (ret)
+		goto out_free_sgl;
+
+	ctx->nr_ops = DIV_ROUND_UP(ctx->reg[0].sgt.nents, pages_per_mr);
+
+	sg = ctx->reg[0].sgt.sgl;
+	nents = ctx->reg[0].sgt.nents;
+	for (i = 0; i < ctx->nr_ops; i++) {
+		struct rdma_rw_reg_ctx *reg = &ctx->reg[i];
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
+		ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
+	ib_dma_unmap_sgtable_attrs(dev, &ctx->reg[0].sgt, dir, 0);
+out_free_sgl:
+	kfree(ctx->reg[0].sgt.sgl);
+out_free_reg:
+	kfree(ctx->reg);
+	return ret;
+}
+
 static int rdma_rw_init_map_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		struct scatterlist *sg, u32 sg_cnt, u32 offset,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
@@ -547,19 +641,13 @@ EXPORT_SYMBOL(rdma_rw_ctx_init);
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
@@ -567,14 +655,24 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -582,13 +680,23 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
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
@@ -833,6 +941,8 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	switch (ctx->type) {
 	case RDMA_RW_MR:
+		/* Bvec MR contexts must use rdma_rw_ctx_destroy_bvec() */
+		WARN_ON_ONCE(ctx->reg[0].sgt.sgl);
 		for (i = 0; i < ctx->nr_ops; i++)
 			ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
 		kfree(ctx->reg);
@@ -880,6 +990,13 @@ void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	u32 i;
 
 	switch (ctx->type) {
+	case RDMA_RW_MR:
+		for (i = 0; i < ctx->nr_ops; i++)
+			ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
+		ib_dma_unmap_sgtable_attrs(dev, &ctx->reg[0].sgt, dir, 0);
+		kfree(ctx->reg[0].sgt.sgl);
+		kfree(ctx->reg);
+		break;
 	case RDMA_RW_IOVA:
 		dma_iova_destroy(dev->dma_device, &ctx->iova.state,
 				 ctx->iova.mapped_len, dir, 0);
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 205e16ed6cd8..3400c017bfb6 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -47,6 +47,7 @@ struct rdma_rw_ctx {
 			struct ib_reg_wr	reg_wr;
 			struct ib_send_wr	inv_wr;
 			struct ib_mr		*mr;
+			struct sg_table		sgt;
 		} *reg;
 	};
 };
-- 
2.49.0


