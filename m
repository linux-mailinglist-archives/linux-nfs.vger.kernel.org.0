Return-Path: <linux-nfs+bounces-17870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E938D1F835
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FE6430210EF
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E931AF3D;
	Wed, 14 Jan 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF6PIthD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25192571C7;
	Wed, 14 Jan 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401593; cv=none; b=ZaVumOlmq2kfs42LSanGamNFPjJJWbvWGQoQaR6dF/vlOXIznip2oP4GbaTIvvhqy/wKDdRG8tgQpoLDNA6yGuYjqGBVcrTM+Bn0A188dcyy1XYnnkcGV/Oi6zWwrCXb4ktE6PyBeVamX3w7lJPK70AjGD1BnWCLSJLL/0AJeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401593; c=relaxed/simple;
	bh=Fr5IRW+051WFJhn8wDslJdG3GWzGjOepSHc6BOxE00Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+FCKoeBm8IiQrFIk6vGoYopcs7ecZ5fTtAyIgksfMnD3A8E+44F0pty1PVnbO1L2y+5HeSMhF5Cnmnh1639NaZveDS0396lifV13gg1aF3Dlzt+eyu++JqE0E/JnrY3WCaYF2RYMGP2x9tX3+yem584UdfQcM38wiJcIBWCLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF6PIthD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3E2C19423;
	Wed, 14 Jan 2026 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768401593;
	bh=Fr5IRW+051WFJhn8wDslJdG3GWzGjOepSHc6BOxE00Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sF6PIthDnQGAlBi+D/YTUiZeGDyrJwh6JknNlbaH+cKtP/waI5auIjIVC+rfsINo2
	 0Pvj8XRojpagguTAy4ZywEkZbskg2zTXF/DQkDt6sFZ6FnirxHuDib5XwPtHqR6KhG
	 QUzj0LQxuotVkTBXuV3hYIHMe8gyTfti7VCvHQylNDBzXzkDDjTpcxKX7yZli2Fi9G
	 ivaQMqtEtreaVDCNtEjrt30lfgp7r/qyV8txN0pagSRtP6UmC3xqNgaDXsSEmg6in0
	 t9XRLqJt3EqbIorF40oRcTdvbs9aFWGb2TNCE7kRqbhrhL/pMW/yBldCP1mBkit/+7
	 lCCE+K3o9fkzA==
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
Subject: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Date: Wed, 14 Jan 2026 09:39:45 -0500
Message-ID: <20260114143948.3946615-2-cel@kernel.org>
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

The existing rdma_rw_ctx_init() API requires callers to construct a
scatterlist, which is then DMA-mapped page by page. Callers that
already have data in bio_vec form (such as the NVMe-oF target) must
first convert to scatterlist, adding overhead and complexity.

Introduce rdma_rw_ctx_init_bvec() and rdma_rw_ctx_destroy_bvec() to
accept bio_vec arrays directly. The new helpers use dma_map_phys()
for hardware RDMA devices and virtual addressing for software RDMA
devices (rxe, siw), avoiding intermediate scatterlist construction.

Memory registration (MR) path support is deferred to a follow-up
series; callers requiring MR-based transfers (iWARP devices or
force_mr=1) receive -EOPNOTSUPP and should use the scatterlist API.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c | 194 +++++++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h      |  35 +++++++
 include/rdma/rw.h            |  10 ++
 3 files changed, 239 insertions(+)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 6354ddf2a274..42215c2ff42b 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -274,6 +274,124 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return 1;
 }
 
+static int rdma_rw_init_single_wr_bvec(struct rdma_rw_ctx *ctx,
+		struct ib_qp *qp, const struct bio_vec *bvec, u32 offset,
+		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	struct ib_rdma_wr *rdma_wr = &ctx->single.wr;
+	struct bio_vec adjusted = *bvec;
+	u64 dma_addr;
+
+	ctx->nr_ops = 1;
+
+	if (offset) {
+		adjusted.bv_offset += offset;
+		adjusted.bv_len -= offset;
+	}
+
+	dma_addr = ib_dma_map_bvec(dev, &adjusted, dir);
+	if (ib_dma_mapping_error(dev, dma_addr))
+		return -ENOMEM;
+
+	ctx->single.sge.lkey = qp->pd->local_dma_lkey;
+	ctx->single.sge.addr = dma_addr;
+	ctx->single.sge.length = adjusted.bv_len;
+
+	memset(rdma_wr, 0, sizeof(*rdma_wr));
+	if (dir == DMA_TO_DEVICE)
+		rdma_wr->wr.opcode = IB_WR_RDMA_WRITE;
+	else
+		rdma_wr->wr.opcode = IB_WR_RDMA_READ;
+	rdma_wr->wr.sg_list = &ctx->single.sge;
+	rdma_wr->wr.num_sge = 1;
+	rdma_wr->remote_addr = remote_addr;
+	rdma_wr->rkey = rkey;
+
+	ctx->type = RDMA_RW_SINGLE_WR;
+	return 1;
+}
+
+static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		const struct bio_vec *bvec, u32 nr_bvec, u32 offset,
+		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	u32 max_sge = dir == DMA_TO_DEVICE ? qp->max_write_sge :
+		      qp->max_read_sge;
+	struct ib_sge *sge;
+	u32 total_len = 0, i, j, bvec_idx = 0;
+	u32 mapped_bvecs = 0;
+	u64 dma_addr;
+
+	ctx->nr_ops = DIV_ROUND_UP(nr_bvec, max_sge);
+
+	ctx->map.sges = sge = kcalloc(nr_bvec, sizeof(*sge), GFP_KERNEL);
+	if (!ctx->map.sges)
+		return -ENOMEM;
+
+	ctx->map.wrs = kcalloc(ctx->nr_ops, sizeof(*ctx->map.wrs), GFP_KERNEL);
+	if (!ctx->map.wrs)
+		goto out_free_sges;
+
+	for (i = 0; i < ctx->nr_ops; i++) {
+		struct ib_rdma_wr *rdma_wr = &ctx->map.wrs[i];
+		u32 nr_sge = min(nr_bvec - bvec_idx, max_sge);
+
+		if (dir == DMA_TO_DEVICE)
+			rdma_wr->wr.opcode = IB_WR_RDMA_WRITE;
+		else
+			rdma_wr->wr.opcode = IB_WR_RDMA_READ;
+		rdma_wr->remote_addr = remote_addr + total_len;
+		rdma_wr->rkey = rkey;
+		rdma_wr->wr.num_sge = nr_sge;
+		rdma_wr->wr.sg_list = sge;
+
+		for (j = 0; j < nr_sge; j++, bvec_idx++) {
+			const struct bio_vec *bv = &bvec[bvec_idx];
+			u32 len = bv->bv_len;
+
+			/* Handle offset into first bvec */
+			if (bvec_idx == 0 && offset) {
+				struct bio_vec adjusted = *bv;
+
+				adjusted.bv_offset += offset;
+				adjusted.bv_len -= offset;
+				dma_addr = ib_dma_map_bvec(dev, &adjusted, dir);
+				len = adjusted.bv_len;
+			} else {
+				dma_addr = ib_dma_map_bvec(dev, bv, dir);
+			}
+
+			if (ib_dma_mapping_error(dev, dma_addr))
+				goto out_unmap;
+
+			mapped_bvecs++;
+			sge->addr = dma_addr;
+			sge->length = len;
+			sge->lkey = qp->pd->local_dma_lkey;
+
+			total_len += len;
+			sge++;
+		}
+
+		rdma_wr->wr.next = i + 1 < ctx->nr_ops ?
+			&ctx->map.wrs[i + 1].wr : NULL;
+	}
+
+	ctx->type = RDMA_RW_MULTI_WR;
+	return ctx->nr_ops;
+
+out_unmap:
+	for (i = 0; i < mapped_bvecs; i++)
+		ib_dma_unmap_bvec(dev, ctx->map.sges[i].addr,
+				  ctx->map.sges[i].length, dir);
+	kfree(ctx->map.wrs);
+out_free_sges:
+	kfree(ctx->map.sges);
+	return -ENOMEM;
+}
+
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -344,6 +462,46 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
 
+/**
+ * rdma_rw_ctx_init_bvec - initialize a RDMA READ/WRITE context from bio_vec
+ * @ctx:	context to initialize
+ * @qp:		queue pair to operate on
+ * @port_num:	port num to which the connection is bound
+ * @bvec:	bio_vec array to READ/WRITE from/to
+ * @nr_bvec:	number of entries in @bvec
+ * @offset:	byte offset into first bvec
+ * @remote_addr:remote address to read/write (relative to @rkey)
+ * @rkey:	remote key to operate on
+ * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
+ *
+ * Maps the bio_vec array directly using dma_map_phys(), avoiding the
+ * intermediate scatterlist conversion. Does not support the MR registration
+ * path (iWARP devices or force_mr=1).
+ *
+ * Returns the number of WQEs that will be needed on the workqueue if
+ * successful, or a negative error code.
+ */
+int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 port_num, const struct bio_vec *bvec, u32 nr_bvec,
+		u32 offset, u64 remote_addr, u32 rkey,
+		enum dma_data_direction dir)
+{
+	if (nr_bvec == 0 || offset > bvec[0].bv_len)
+		return -EINVAL;
+
+	/* MR path not supported for bvec - reject iWARP and force_mr */
+	if (rdma_rw_io_needs_mr(qp->device, port_num, dir, nr_bvec))
+		return -EOPNOTSUPP;
+
+	if (nr_bvec == 1)
+		return rdma_rw_init_single_wr_bvec(ctx, qp, bvec, offset,
+				remote_addr, rkey, dir);
+
+	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvec, nr_bvec, offset,
+			remote_addr, rkey, dir);
+}
+EXPORT_SYMBOL(rdma_rw_ctx_init_bvec);
+
 /**
  * rdma_rw_ctx_signature_init - initialize a RW context with signature offload
  * @ctx:	context to initialize
@@ -598,6 +756,42 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
+/**
+ * rdma_rw_ctx_destroy_bvec - release resources from rdma_rw_ctx_init_bvec
+ * @ctx:	context to release
+ * @qp:		queue pair to operate on
+ * @port_num:	port num to which the connection is bound
+ * @bvec:	bio_vec array that was used for the READ/WRITE
+ * @nr_bvec:	number of entries in @bvec
+ * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
+ */
+void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 __maybe_unused port_num,
+		const struct bio_vec __maybe_unused *bvec,
+		u32 nr_bvec, enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	u32 i;
+
+	switch (ctx->type) {
+	case RDMA_RW_MULTI_WR:
+		for (i = 0; i < nr_bvec; i++)
+			ib_dma_unmap_bvec(dev, ctx->map.sges[i].addr,
+					  ctx->map.sges[i].length, dir);
+		kfree(ctx->map.wrs);
+		kfree(ctx->map.sges);
+		break;
+	case RDMA_RW_SINGLE_WR:
+		ib_dma_unmap_bvec(dev, ctx->single.sge.addr,
+				  ctx->single.sge.length, dir);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+}
+EXPORT_SYMBOL(rdma_rw_ctx_destroy_bvec);
+
 /**
  * rdma_rw_ctx_destroy_signature - release all resources allocated by
  *	rdma_rw_ctx_signature_init
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6aad66bc5dd7..035593b2692d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -15,6 +15,7 @@
 #include <linux/ethtool.h>
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/bvec.h>
 #include <linux/dma-mapping.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -4249,6 +4250,40 @@ static inline void ib_dma_unmap_page(struct ib_device *dev,
 		dma_unmap_page(dev->dma_device, addr, size, direction);
 }
 
+/**
+ * ib_dma_map_bvec - Map a bio_vec to DMA address
+ * @dev: The device for which the dma_addr is to be created
+ * @bvec: The bio_vec to map
+ * @direction: The direction of the DMA
+ *
+ * Uses dma_map_phys() for real hardware devices and virtual
+ * address for software RDMA devices (rxe, siw).
+ */
+static inline u64 ib_dma_map_bvec(struct ib_device *dev,
+				  const struct bio_vec *bvec,
+				  enum dma_data_direction direction)
+{
+	if (ib_uses_virt_dma(dev))
+		return (uintptr_t)(page_address(bvec->bv_page) + bvec->bv_offset);
+	return dma_map_phys(dev->dma_device, bvec_phys(bvec),
+			    bvec->bv_len, direction, 0);
+}
+
+/**
+ * ib_dma_unmap_bvec - Unmap a bio_vec DMA mapping
+ * @dev: The device for which the DMA address was created
+ * @addr: The DMA address
+ * @size: The size of the region in bytes
+ * @direction: The direction of the DMA
+ */
+static inline void ib_dma_unmap_bvec(struct ib_device *dev,
+				     u64 addr, size_t size,
+				     enum dma_data_direction direction)
+{
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_phys(dev->dma_device, addr, size, direction, 0);
+}
+
 int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents);
 static inline int ib_dma_map_sg_attrs(struct ib_device *dev,
 				      struct scatterlist *sg, int nents,
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index d606cac48233..046a8eb57125 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -49,6 +49,16 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 			 u32 port_num, struct scatterlist *sg, u32 sg_cnt,
 			 enum dma_data_direction dir);
 
+struct bio_vec;
+
+int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 port_num, const struct bio_vec *bvec, u32 nr_bvec,
+		u32 offset, u64 remote_addr, u32 rkey,
+		enum dma_data_direction dir);
+void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 port_num, const struct bio_vec *bvec, u32 nr_bvec,
+		enum dma_data_direction dir);
+
 int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		u32 port_num, struct scatterlist *sg, u32 sg_cnt,
 		struct scatterlist *prot_sg, u32 prot_sg_cnt,
-- 
2.52.0


