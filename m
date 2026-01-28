Return-Path: <linux-nfs+bounces-18543-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJBtHzZeeWn+wgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18543-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 01:54:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F899BC3A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 01:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB329300B596
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF42021ABAA;
	Wed, 28 Jan 2026 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwjfTUz8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC51FECCD;
	Wed, 28 Jan 2026 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769561645; cv=none; b=kXOg5NIRHwztmfbYpvzbik09X9PWLXaJOzCIzQpA35i86sHg7RYKXPE2upynU0yxIsW3+CY2MQZXLJf3Nn0J5Fb+v8xVdVAI/ngIneEh/usNoVe4pSzQ7uSEZ+f+WAzrQcwIFudAP1dTZRoa5nwISQ+mTZn0DF3UJ9TgcjRU3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769561645; c=relaxed/simple;
	bh=LKbyuRsCAmM8Pp87hNbiQYSV7d7GIzCevZhc6y0pYGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+rmMIuO2z56evpO1yB2GgfuKIKDQBu/QiLuGPsN3p9vqYp+NN9pWG09yPdXrcohm6GrfoSvzq860N7Ab6JCtg5FU/8+r/yVO5Xx/+XBEUNnh4C7QGY9//eb2AkkwGY6Z80wwk5sdT5XOBCnnS6XPA5BzjTq9Wwk5qq8shfBGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwjfTUz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8467C19425;
	Wed, 28 Jan 2026 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769561645;
	bh=LKbyuRsCAmM8Pp87hNbiQYSV7d7GIzCevZhc6y0pYGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FwjfTUz8B47Z2RSp+fOcorR/F63NtTuuZVPO97cH/XqAOlURnKv21yK2OuCNp0RCu
	 TvybXgtBMlZMG0m1HvfT01UGOXzNlBIFum14VedsHAnJ8xxrF5AomiUa24Rro1dQu2
	 WJh7e3KUzluGR7HnQwPD69Yt96ARldw2ST4wzCSpxaP1VubrbZY5OZxV6naUEQHOCi
	 b82lq5INBLNyGEXrEaNhfY9z6xcycTBJToDQLEDq9kuulsq56Sa3hGyt/a8fvRBkD+
	 IUUO465t2hUK9CJ+PJ2GEjS0yRXEeh//dQHGAFAQb/xjzEUUIrx0bx7wLWlV7cgrw9
	 pHP1Z9XF41VUg==
From: Chuck Lever <cel@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 2/5] RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
Date: Tue, 27 Jan 2026 19:53:57 -0500
Message-ID: <20260128005400.25147-3-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18543-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 14F899BC3A
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The bvec RDMA API maps each bvec individually via dma_map_phys(),
requiring an IOTLB sync for each mapping. For large I/O operations
with many bvecs, this overhead becomes significant.

The two-step IOVA API (dma_iova_try_alloc / dma_iova_link /
dma_iova_sync) allocates a contiguous IOVA range upfront, links
all physical pages without IOTLB syncs, then performs a single
sync at the end. This reduces IOTLB flushes from O(n) to O(1).

It also requires only a single output dma_addr_t compared to extra
per-input element storage in struct scatterlist.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c | 106 +++++++++++++++++++++++++++++++++++
 include/rdma/rw.h            |   8 +++
 2 files changed, 114 insertions(+)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 39ca21d18d7b..c2fc8cba972e 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -14,6 +14,7 @@ enum {
 	RDMA_RW_MULTI_WR,
 	RDMA_RW_MR,
 	RDMA_RW_SIG_MR,
+	RDMA_RW_IOVA,
 };
 
 static bool rdma_rw_force_mr;
@@ -383,6 +384,87 @@ static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return -ENOMEM;
 }
 
+/*
+ * Try to use the two-step IOVA API to map bvecs into a contiguous DMA range.
+ * This reduces IOTLB sync overhead by doing one sync at the end instead of
+ * one per bvec, and produces a contiguous DMA address range that can be
+ * described by a single SGE.
+ *
+ * Returns the number of WQEs (always 1) on success, -EOPNOTSUPP if IOVA
+ * mapping is not available, or another negative error code on failure.
+ */
+static int rdma_rw_init_iova_wrs_bvec(struct rdma_rw_ctx *ctx,
+		struct ib_qp *qp, const struct bio_vec *bvec,
+		struct bvec_iter *iter, u64 remote_addr, u32 rkey,
+		enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	struct device *dma_dev = dev->dma_device;
+	size_t total_len = iter->bi_size;
+	struct bio_vec first_bv;
+	size_t mapped_len = 0;
+	int ret;
+
+	/* Virtual DMA devices cannot support IOVA allocators */
+	if (ib_uses_virt_dma(dev))
+		return -EOPNOTSUPP;
+
+	/* Try to allocate contiguous IOVA space */
+	first_bv = mp_bvec_iter_bvec(bvec, *iter);
+	if (!dma_iova_try_alloc(dma_dev, &ctx->iova.state,
+				bvec_phys(&first_bv), total_len))
+		return -EOPNOTSUPP;
+
+	/* Link all bvecs into the IOVA space */
+	while (iter->bi_size) {
+		struct bio_vec bv = mp_bvec_iter_bvec(bvec, *iter);
+
+		ret = dma_iova_link(dma_dev, &ctx->iova.state, bvec_phys(&bv),
+				    mapped_len, bv.bv_len, dir, 0);
+		if (ret)
+			goto out_destroy;
+
+		mapped_len += bv.bv_len;
+		bvec_iter_advance(bvec, iter, bv.bv_len);
+	}
+
+	/* Sync the IOTLB once for all linked pages */
+	ret = dma_iova_sync(dma_dev, &ctx->iova.state, 0, mapped_len);
+	if (ret)
+		goto out_destroy;
+
+	ctx->iova.mapped_len = mapped_len;
+
+	/* Single SGE covers the entire contiguous IOVA range */
+	ctx->iova.sge.addr = ctx->iova.state.addr;
+	ctx->iova.sge.length = mapped_len;
+	ctx->iova.sge.lkey = qp->pd->local_dma_lkey;
+
+	/* Single WR for the whole transfer */
+	memset(&ctx->iova.wr, 0, sizeof(ctx->iova.wr));
+	if (dir == DMA_TO_DEVICE)
+		ctx->iova.wr.wr.opcode = IB_WR_RDMA_WRITE;
+	else
+		ctx->iova.wr.wr.opcode = IB_WR_RDMA_READ;
+	ctx->iova.wr.wr.num_sge = 1;
+	ctx->iova.wr.wr.sg_list = &ctx->iova.sge;
+	ctx->iova.wr.remote_addr = remote_addr;
+	ctx->iova.wr.rkey = rkey;
+
+	ctx->type = RDMA_RW_IOVA;
+	ctx->nr_ops = 1;
+	return 1;
+
+out_destroy:
+	/*
+	 * dma_iova_destroy() expects the actual mapped length, not the
+	 * total allocation size. It unlinks only the successfully linked
+	 * range and frees the entire IOVA allocation.
+	 */
+	dma_iova_destroy(dma_dev, &ctx->iova.state, mapped_len, dir, 0);
+	return ret;
+}
+
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -485,6 +567,8 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		struct bvec_iter iter, u64 remote_addr, u32 rkey,
 		enum dma_data_direction dir)
 {
+	int ret;
+
 	if (nr_bvec == 0 || iter.bi_size == 0)
 		return -EINVAL;
 
@@ -495,6 +579,16 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	if (nr_bvec == 1)
 		return rdma_rw_init_single_wr_bvec(ctx, qp, bvecs, &iter,
 				remote_addr, rkey, dir);
+
+	/*
+	 * Try IOVA-based mapping first for multi-bvec transfers.
+	 * This reduces IOTLB sync overhead by batching all mappings.
+	 */
+	ret = rdma_rw_init_iova_wrs_bvec(ctx, qp, bvecs, &iter, remote_addr,
+			rkey, dir);
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
 	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvecs, nr_bvec, &iter,
 			remote_addr, rkey, dir);
 }
@@ -671,6 +765,10 @@ struct ib_send_wr *rdma_rw_ctx_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 			first_wr = &ctx->reg[0].reg_wr.wr;
 		last_wr = &ctx->reg[ctx->nr_ops - 1].wr.wr;
 		break;
+	case RDMA_RW_IOVA:
+		first_wr = &ctx->iova.wr.wr;
+		last_wr = &ctx->iova.wr.wr;
+		break;
 	case RDMA_RW_MULTI_WR:
 		first_wr = &ctx->map.wrs[0].wr;
 		last_wr = &ctx->map.wrs[ctx->nr_ops - 1].wr;
@@ -745,6 +843,10 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		break;
 	case RDMA_RW_SINGLE_WR:
 		break;
+	case RDMA_RW_IOVA:
+		/* IOVA contexts must use rdma_rw_ctx_destroy_bvec() */
+		WARN_ON_ONCE(1);
+		return;
 	default:
 		BUG();
 		break;
@@ -778,6 +880,10 @@ void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	u32 i;
 
 	switch (ctx->type) {
+	case RDMA_RW_IOVA:
+		dma_iova_destroy(dev->dma_device, &ctx->iova.state,
+				 ctx->iova.mapped_len, dir, 0);
+		break;
 	case RDMA_RW_MULTI_WR:
 		for (i = 0; i < nr_bvec; i++)
 			ib_dma_unmap_bvec(dev, ctx->map.sges[i].addr,
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index b2fc3e2373d7..205e16ed6cd8 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -32,6 +32,14 @@ struct rdma_rw_ctx {
 			struct ib_rdma_wr	*wrs;
 		} map;
 
+		/* for IOVA-based mapping of bvecs into contiguous DMA range: */
+		struct {
+			struct dma_iova_state	state;
+			struct ib_sge		sge;
+			struct ib_rdma_wr	wr;
+			size_t			mapped_len;
+		} iova;
+
 		/* for registering multiple WRs: */
 		struct rdma_rw_reg_ctx {
 			struct ib_sge		sge;
-- 
2.49.0


