Return-Path: <linux-nfs+bounces-17871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E47D1F841
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F338300EDD6
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557A37B40B;
	Wed, 14 Jan 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E46WjAi5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDC2571C7;
	Wed, 14 Jan 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401594; cv=none; b=kxUkXOXjyG8um5OXyrJH+6aY/5wWXzGyKyCIE7zm3rgy6BceXsR2vudz2KyXZFIgkfwaxeqwJurmkZyDOr4j2a6pBXjPUsKFpta7P0VNopQVfOkXnQ2MUVSasc2BIzg9AYjNY/gxIQSo6rWi9u7M6WkUnWLQwWEjmg9ZLGWNiLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401594; c=relaxed/simple;
	bh=sO+xeSpzmZGpEG2MctaerlU2Ip70FWrZq0muFXKJ450=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXb7RumCcEnNE1cfINr8sokb3Cs+jW1oY6gDhCba2jSdOmfT8MMEOtm+uv+U6dAP0iwLJrnNvWWnDZr/mmjoB/Cv87crAz29Tom1txCel5DR+HFeFHF+WykpRZyQMRhY8jcin5XhNYGMSI3LuFH/aLOKwZtOCqgM4LV8CwoLezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E46WjAi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB80EC4CEF7;
	Wed, 14 Jan 2026 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768401594;
	bh=sO+xeSpzmZGpEG2MctaerlU2Ip70FWrZq0muFXKJ450=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E46WjAi5nGPnHHdzOafv7VCU8KP/ytyUx0DZkpKXMNi3GSfEr3zrGMYJoW3vM3Tqu
	 H7IJBr+6u8073dPDh95Atxi86ueW4h6d92Xncwrw8ERbREOfk9/3r1kCG/R6r6Ow/E
	 6dVd8POhWZm4UBaJjuQXwIJXQ5f1/SkU+2xQDpzMIxjziTauCrncbtIGwa0agolF/P
	 befLX19KIs3FQj9+1Omn/oyYzn7pfDjzlFkoJSw1aO4+2R/8Y5vL4v0qlHq3EE12+M
	 0SIAwaXeTNjyLMjj2QAF1JO3aV2MECNIMhflFugT1S6pRJ7WM0l+JG+qIZxeuIZeGU
	 grTloQIcG/cRw==
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
Subject: [PATCH v1 2/4] RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
Date: Wed, 14 Jan 2026 09:39:46 -0500
Message-ID: <20260114143948.3946615-3-cel@kernel.org>
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

The bvec RDMA API maps each bvec individually via dma_map_phys(),
requiring an IOTLB sync for each mapping. For large I/O operations
with many bvecs, this overhead becomes significant.

The two-step IOVA API (dma_iova_try_alloc/dma_iova_link/
dma_iova_sync) allocates a contiguous IOVA range upfront, links
all physical pages without IOTLB syncs, then performs a single
sync at the end. This reduces IOTLB flushes from O(n) to O(1).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c | 153 +++++++++++++++++++++++++++++++++++
 include/rdma/rw.h            |   8 ++
 2 files changed, 161 insertions(+)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 42215c2ff42b..36038e5f9197 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -14,6 +14,7 @@ enum {
 	RDMA_RW_MULTI_WR,
 	RDMA_RW_MR,
 	RDMA_RW_SIG_MR,
+	RDMA_RW_IOVA,
 };
 
 static bool rdma_rw_force_mr;
@@ -392,6 +393,137 @@ static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return -ENOMEM;
 }
 
+/*
+ * Try to use the two-step IOVA API to map bvecs into a contiguous DMA range.
+ * This reduces IOTLB sync overhead by doing one sync at the end instead of
+ * one per bvec, and produces a contiguous DMA address range.
+ *
+ * Returns the number of WQEs on success, -EOPNOTSUPP if IOVA mapping is not
+ * available, or another negative error code on failure.
+ */
+static int rdma_rw_init_iova_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		const struct bio_vec *bvec, u32 nr_bvec, u32 offset,
+		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	struct device *dma_dev = dev->dma_device;
+	u32 max_sge = dir == DMA_TO_DEVICE ? qp->max_write_sge :
+		      qp->max_read_sge;
+	struct ib_sge *sge;
+	size_t total_len = 0, mapped_len = 0;
+	u32 i, j, bvec_idx = 0;
+	int ret;
+
+	/* Virtual DMA devices don't support IOVA mapping */
+	if (ib_uses_virt_dma(dev))
+		return -EOPNOTSUPP;
+
+	if (!max_sge)
+		return -EINVAL;
+
+	/* Calculate total transfer length */
+	for (i = 0; i < nr_bvec; i++) {
+		size_t len = (i == 0 && offset) ?
+			     bvec[i].bv_len - offset : bvec[i].bv_len;
+
+		if (check_add_overflow(total_len, len, &total_len))
+			return -EINVAL;
+	}
+
+	/* Try to allocate contiguous IOVA space */
+	if (!dma_iova_try_alloc(dma_dev, &ctx->iova.state,
+				bvec_phys(&bvec[0]) + offset, total_len))
+		return -EOPNOTSUPP;
+
+	ctx->nr_ops = DIV_ROUND_UP(nr_bvec, max_sge);
+
+	ctx->iova.sges = sge = kcalloc(nr_bvec, sizeof(*sge), GFP_KERNEL);
+	if (!ctx->iova.sges) {
+		ret = -ENOMEM;
+		goto out_free_iova;
+	}
+
+	ctx->iova.wrs = kcalloc(ctx->nr_ops, sizeof(*ctx->iova.wrs), GFP_KERNEL);
+	if (!ctx->iova.wrs) {
+		ret = -ENOMEM;
+		goto out_free_sges;
+	}
+
+	/* Link all bvecs into the IOVA space */
+	for (i = 0; i < nr_bvec; i++) {
+		const struct bio_vec *bv = &bvec[i];
+		phys_addr_t phys = bvec_phys(bv);
+		size_t len = bv->bv_len;
+
+		if (i == 0 && offset) {
+			phys += offset;
+			len -= offset;
+		}
+
+		ret = dma_iova_link(dma_dev, &ctx->iova.state, phys,
+				    mapped_len, len, dir, 0);
+		if (ret)
+			goto out_destroy;
+
+		mapped_len += len;
+	}
+
+	/* Sync the IOTLB once for all linked pages */
+	ret = dma_iova_sync(dma_dev, &ctx->iova.state, 0, mapped_len);
+	if (ret)
+		goto out_destroy;
+
+	ctx->iova.mapped_len = mapped_len;
+
+	/* Build SGEs using offsets into the contiguous IOVA range */
+	mapped_len = 0;
+	for (i = 0; i < ctx->nr_ops; i++) {
+		struct ib_rdma_wr *rdma_wr = &ctx->iova.wrs[i];
+		u32 nr_sge = min(nr_bvec - bvec_idx, max_sge);
+
+		if (dir == DMA_TO_DEVICE)
+			rdma_wr->wr.opcode = IB_WR_RDMA_WRITE;
+		else
+			rdma_wr->wr.opcode = IB_WR_RDMA_READ;
+		rdma_wr->remote_addr = remote_addr + mapped_len;
+		rdma_wr->rkey = rkey;
+		rdma_wr->wr.num_sge = nr_sge;
+		rdma_wr->wr.sg_list = sge;
+
+		for (j = 0; j < nr_sge; j++, bvec_idx++) {
+			const struct bio_vec *bv = &bvec[bvec_idx];
+			size_t len = bv->bv_len;
+
+			if (bvec_idx == 0 && offset)
+				len -= offset;
+
+			sge->addr = ctx->iova.state.addr + mapped_len;
+			sge->length = len;
+			sge->lkey = qp->pd->local_dma_lkey;
+
+			mapped_len += len;
+			sge++;
+		}
+
+		rdma_wr->wr.next = i + 1 < ctx->nr_ops ?
+			&ctx->iova.wrs[i + 1].wr : NULL;
+	}
+
+	ctx->type = RDMA_RW_IOVA;
+	return ctx->nr_ops;
+
+out_destroy:
+	dma_iova_destroy(dma_dev, &ctx->iova.state, mapped_len, dir, 0);
+	kfree(ctx->iova.wrs);
+	kfree(ctx->iova.sges);
+	return ret;
+out_free_sges:
+	kfree(ctx->iova.sges);
+out_free_iova:
+	dma_iova_free(dma_dev, &ctx->iova.state);
+	return ret;
+}
+
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -486,6 +618,8 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		u32 offset, u64 remote_addr, u32 rkey,
 		enum dma_data_direction dir)
 {
+	int ret;
+
 	if (nr_bvec == 0 || offset > bvec[0].bv_len)
 		return -EINVAL;
 
@@ -497,6 +631,15 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return rdma_rw_init_single_wr_bvec(ctx, qp, bvec, offset,
 				remote_addr, rkey, dir);
 
+	/*
+	 * Try IOVA-based mapping first for multi-bvec transfers.
+	 * This reduces IOTLB sync overhead by batching all mappings.
+	 */
+	ret = rdma_rw_init_iova_wrs_bvec(ctx, qp, bvec, nr_bvec, offset,
+			remote_addr, rkey, dir);
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
 	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvec, nr_bvec, offset,
 			remote_addr, rkey, dir);
 }
@@ -673,6 +816,10 @@ struct ib_send_wr *rdma_rw_ctx_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 			first_wr = &ctx->reg[0].reg_wr.wr;
 		last_wr = &ctx->reg[ctx->nr_ops - 1].wr.wr;
 		break;
+	case RDMA_RW_IOVA:
+		first_wr = &ctx->iova.wrs[0].wr;
+		last_wr = &ctx->iova.wrs[ctx->nr_ops - 1].wr;
+		break;
 	case RDMA_RW_MULTI_WR:
 		first_wr = &ctx->map.wrs[0].wr;
 		last_wr = &ctx->map.wrs[ctx->nr_ops - 1].wr;
@@ -774,6 +921,12 @@ void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	u32 i;
 
 	switch (ctx->type) {
+	case RDMA_RW_IOVA:
+		dma_iova_destroy(dev->dma_device, &ctx->iova.state,
+				 ctx->iova.mapped_len, dir, 0);
+		kfree(ctx->iova.wrs);
+		kfree(ctx->iova.sges);
+		break;
 	case RDMA_RW_MULTI_WR:
 		for (i = 0; i < nr_bvec; i++)
 			ib_dma_unmap_bvec(dev, ctx->map.sges[i].addr,
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 046a8eb57125..8a2012f03667 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -31,6 +31,14 @@ struct rdma_rw_ctx {
 			struct ib_rdma_wr	*wrs;
 		} map;
 
+		/* for IOVA-based mapping of multiple bvecs: */
+		struct {
+			struct dma_iova_state	state;
+			struct ib_sge		*sges;
+			struct ib_rdma_wr	*wrs;
+			size_t			mapped_len;
+		} iova;
+
 		/* for registering multiple WRs: */
 		struct rdma_rw_reg_ctx {
 			struct ib_sge		sge;
-- 
2.52.0


