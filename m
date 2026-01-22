Return-Path: <linux-nfs+bounces-18334-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPc+B+aecmm/ngAAu9opvQ
	(envelope-from <linux-nfs+bounces-18334-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB46E062
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E298301DEDD
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 22:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0C53A89A2;
	Thu, 22 Jan 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMaBYUeD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C634D3A5;
	Thu, 22 Jan 2026 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119450; cv=none; b=l7EVAEcLaV4t18I0qjb682hddNVmGFwI+H7G9nRGAiYl/BZaaiuSpGFCUlz7P8DwsegKH0DkpgpH/lJYo+iwPqq6KTSztcqgxu10EUgNpw42nFaTnwnau2B5KFLwm0PqC3DvNwJMTh0RKitdq9biSLQSps+2GM55F7ds0HsJkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119450; c=relaxed/simple;
	bh=yGf3Jbx6yuMu3mSuP/qIQwV3uLYqDC0yXg5sAG+zQNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpFVFL/cNeN9a9gLx/qEeTjMy4dvptRsUixA3X9E1s7Gh2BSHtkAQoI37QunlAeEk0p8b58i0N8mnfeZVti2iMbEy4ts1cLeMuSETz4uZ0yNQd4liD598ba5/ZPxz6YDmbyXZeJ6kHbX9YTq4i2wJWYzjZis9jOJo+C+CYsdn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMaBYUeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CFFC19424;
	Thu, 22 Jan 2026 22:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119448;
	bh=yGf3Jbx6yuMu3mSuP/qIQwV3uLYqDC0yXg5sAG+zQNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMaBYUeD6RuoGoS3JQaL06HTQ+RsZGvMgQtEQKOULxvK3ly32MsK+iJfimZUxLB3e
	 XvQRaOV3cRyL1oGt1UXTO7hV+oKkuONIEM3NxkDlvWTjNyUmN6ykEpKgltvkEh/Hge
	 tLF0sNsm6k5MLugAwu5YXsqffacGFaaoh/SKIFPdhkKbBctMp4t0UjWUplaTYEqDOd
	 Pss8mj1r8fpGkf1YKwauai/34F26BNlOSkvwbhY6V1sX0K3FMddsxR4bPRPBcfaFwB
	 kGRu+wRheNDWyuCVfrKaEoWAPOxXkmzD0jUiRBuUPN0WEsa68LFwI1Ai+MsE58rITg
	 4yb2eSSEjKyaQ==
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
Subject: [PATCH v3 3/5] RDMA/core: add MR support for bvec-based RDMA operations
Date: Thu, 22 Jan 2026 17:03:59 -0500
Message-ID: <20260122220401.1143331-4-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18334-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 89FB46E062
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
 drivers/infiniband/core/rw.c            | 250 ++++++++++++++++++------
 drivers/infiniband/ulp/isert/ib_isert.c |   4 +-
 drivers/nvme/target/rdma.c              |   4 +-
 include/rdma/rw.h                       |  17 +-
 4 files changed, 206 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 393a9a4d551c..3a00b788417d 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -38,6 +38,20 @@ static inline bool rdma_rw_can_use_mr(struct ib_device *dev, u32 port_num)
 	return false;
 }
 
+/*
+ * Check if the device requires memory registration for RDMA READs.
+ * iWARP always requires MR for RDMA READ due to protocol limitations.
+ */
+static inline bool rdma_rw_io_requires_mr(struct ib_device *dev, u32 port_num,
+		enum dma_data_direction dir)
+{
+	if (dir == DMA_FROM_DEVICE && rdma_protocol_iwarp(dev, port_num))
+		return true;
+	if (unlikely(rdma_rw_force_mr))
+		return true;
+	return false;
+}
+
 /*
  * Check if the device will use memory registration for this RW operation.
  * For RDMA READs we must use MRs on iWarp and can optionally use them as an
@@ -47,13 +61,10 @@ static inline bool rdma_rw_can_use_mr(struct ib_device *dev, u32 port_num)
 static inline bool rdma_rw_io_needs_mr(struct ib_device *dev, u32 port_num,
 		enum dma_data_direction dir, int dma_nents)
 {
-	if (dir == DMA_FROM_DEVICE) {
-		if (rdma_protocol_iwarp(dev, port_num))
-			return true;
-		if (dev->attrs.max_sgl_rd && dma_nents > dev->attrs.max_sgl_rd)
-			return true;
-	}
-	if (unlikely(rdma_rw_force_mr))
+	if (rdma_rw_io_requires_mr(dev, port_num, dir))
+		return true;
+	if (dir == DMA_FROM_DEVICE &&
+	    dev->attrs.max_sgl_rd && dma_nents > dev->attrs.max_sgl_rd)
 		return true;
 	return false;
 }
@@ -132,14 +143,14 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -187,12 +198,118 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
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
+
+		if (prev) {
+			if (reg->mr->need_inval)
+				prev->wr.wr.next = &reg->inv_wr;
+			else
+				prev->wr.wr.next = &reg->reg_wr.wr;
+		}
+
+		reg->reg_wr.wr.next = &reg->wr.wr;
+
+		reg->wr.wr.sg_list = &reg->sge;
+		reg->wr.wr.num_sge = 1;
+		reg->wr.remote_addr = remote_addr;
+		reg->wr.rkey = rkey;
+
+		if (dir == DMA_TO_DEVICE) {
+			reg->wr.wr.opcode = IB_WR_RDMA_WRITE;
+		} else if (!rdma_cap_read_inv(qp->device, port_num)) {
+			reg->wr.wr.opcode = IB_WR_RDMA_READ;
+		} else {
+			reg->wr.wr.opcode = IB_WR_RDMA_READ_WITH_INV;
+			reg->wr.wr.ex.invalidate_rkey = reg->mr->lkey;
+		}
+		count++;
+
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
@@ -557,19 +674,13 @@ EXPORT_SYMBOL(rdma_rw_ctx_init);
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
@@ -577,14 +688,19 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
+	 * iWARP requires MR registration for all RDMA READs.
+	 */
+	if (rdma_rw_io_requires_mr(dev, port_num, dir))
+		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvecs,
+						nr_bvec, &iter, remote_addr,
+						rkey, dir);
 
 	if (nr_bvec == 1)
 		return rdma_rw_init_single_wr_bvec(ctx, qp, bvecs, &iter,
@@ -592,14 +708,23 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	/*
 	 * Try IOVA-based mapping first for multi-bvec transfers.
-	 * This reduces IOTLB sync overhead by batching all mappings.
-	 * rdma_rw_init_iova_wrs_bvec() does not modify iter on -EOPNOTSUPP.
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
@@ -660,23 +785,23 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
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
@@ -684,24 +809,24 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -709,15 +834,15 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -765,16 +890,16 @@ struct ib_send_wr *rdma_rw_ctx_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -844,9 +969,11 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
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
@@ -891,6 +1018,13 @@ void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -932,8 +1066,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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


