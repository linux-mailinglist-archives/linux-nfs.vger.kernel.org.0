Return-Path: <linux-nfs+bounces-17872-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF52D1F847
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97CF2304276D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F4D3557E8;
	Wed, 14 Jan 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv1CKy2q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D324322E3E9;
	Wed, 14 Jan 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401595; cv=none; b=T3M88FbmxHiC3e5vgTXMGFDqywzl/iaVOHyOjcjtwG8Vt+byT1bxuIUkGbIEHL4hCIEz23HnUkqFesrLGoVMT1+m2ZstkFSgpVMDDqQA1Ibx2PnDCPcTmzF2Xm2d3vyZDaAG7mmQVgh4j8wU2jcrlt8iA7EDMRofVu3o2a4WNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401595; c=relaxed/simple;
	bh=p3Y5D+B6vEMejp+prFUEstoVGvONTYcbQemFctvwW6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU/iHc5t3odVQYCe5ijOTdF1jpC4uDVwGH/p2p+XKojruR8Hfm6vHF9FiQxcLvM/Hv6P4mbOzds+1+aw3xQWLvRPpR2GINnMSDJoKzitzJ7WuczMv4SVbqJBUHOiVZP8XhODICQEIUOmK7OpR4SLgJ1u9sgl3wPRBu55H6s3N5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv1CKy2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A5CC19423;
	Wed, 14 Jan 2026 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768401595;
	bh=p3Y5D+B6vEMejp+prFUEstoVGvONTYcbQemFctvwW6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fv1CKy2qXQko1odYIzElkJ6QFfAJgFwVyGoY5xKZ8+PR9fSRt/Z+livZWlzqNnDNp
	 vzyaOwuUG1SRn0UixXCwSt9GVt3eGymU892f26JCWz6ml5SKWWrIG9wSRiYTBbdCGj
	 /1uMFRtIE20MjFS6EK9aRvX6XvqCPu3vlGro6ueNDnQjNVrd38Lc2wiLRMRu+uc1Xg
	 Z9EnxPm26M1Kfdtv+hrOj0lQuKXwnKmNefVCPJ4i7ZKzXi+HUalavIcup/qK+IO/YX
	 R1BhZOC9r0VuY8s38/1U0rqKyvGnYgv73cVjEg7hdkIho6+YIOVx9i9Oi06oaNdVyM
	 Lu8l93RdwQxwA==
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
Subject: [PATCH v1 3/4] RDMA/core: add MR support for bvec-based RDMA operations
Date: Wed, 14 Jan 2026 09:39:47 -0500
Message-ID: <20260114143948.3946615-4-cel@kernel.org>
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
 drivers/infiniband/core/rw.c | 157 +++++++++++++++++++++++++++++++++--
 include/rdma/rw.h            |   8 ++
 2 files changed, 159 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 36038e5f9197..610f5c946567 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -193,6 +193,140 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return ret;
 }
 
+static int rdma_rw_init_mr_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 port_num, const struct bio_vec *bvec, u32 nr_bvec,
+		u32 offset, u64 remote_addr, u32 rkey,
+		enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	struct rdma_rw_reg_ctx *prev = NULL;
+	u32 pages_per_mr = rdma_rw_fr_page_list_len(dev, qp->integrity_en);
+	struct scatterlist *sgl;
+	int i, j, ret = 0, count = 0;
+	u32 sg_idx = 0;
+
+	ctx->nr_ops = DIV_ROUND_UP(nr_bvec, pages_per_mr);
+	ctx->reg = kcalloc(ctx->nr_ops, sizeof(*ctx->reg), GFP_KERNEL);
+	if (!ctx->reg)
+		return -ENOMEM;
+
+	/*
+	 * Allocate synthetic scatterlist to hold DMA addresses.
+	 * ib_map_mr_sg() extracts sg_dma_address/len, so the page
+	 * pointer is unused.
+	 */
+	sgl = kmalloc_array(nr_bvec, sizeof(*sgl), GFP_KERNEL);
+	if (!sgl) {
+		ret = -ENOMEM;
+		goto out_free_reg;
+	}
+	sg_init_table(sgl, nr_bvec);
+
+	/*
+	 * DMA map all bvecs and populate the synthetic scatterlist.
+	 */
+	for (i = 0; i < nr_bvec; i++) {
+		const struct bio_vec *bv = &bvec[i];
+		struct bio_vec adjusted;
+		u64 dma_addr;
+		u32 len;
+
+		if (i == 0 && offset) {
+			adjusted = *bv;
+			adjusted.bv_offset += offset;
+			adjusted.bv_len -= offset;
+			bv = &adjusted;
+		}
+		len = bv->bv_len;
+
+		dma_addr = ib_dma_map_bvec(dev, bv, dir);
+		if (ib_dma_mapping_error(dev, dma_addr)) {
+			ret = -ENOMEM;
+			goto out_unmap;
+		}
+
+		/*
+		 * Populate sg entry with DMA address. sg_set_page() is
+		 * called to initialize the entry, but the page pointer
+		 * is unused by ib_map_mr_sg().
+		 */
+		sg_set_page(&sgl[i], bv->bv_page, len, bv->bv_offset);
+		sg_dma_address(&sgl[i]) = dma_addr;
+		sg_dma_len(&sgl[i]) = len;
+	}
+
+	/*
+	 * Build MR chain using the synthetic scatterlist.
+	 */
+	for (i = 0; i < ctx->nr_ops; i++) {
+		struct rdma_rw_reg_ctx *reg = &ctx->reg[i];
+		u32 nents = min(nr_bvec - sg_idx, pages_per_mr);
+
+		ret = rdma_rw_init_one_mr(qp, port_num, reg, &sgl[sg_idx],
+					  nents, 0);
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
+		sg_idx += nents;
+		prev = reg;
+	}
+
+	if (prev)
+		prev->wr.wr.next = NULL;
+
+	ctx->type = RDMA_RW_MR;
+	ctx->mr_sgl = sgl;
+	ctx->mr_sg_cnt = nr_bvec;
+	return count;
+
+out_free_mrs:
+	while (--i >= 0)
+		ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
+	/* All bvecs were mapped successfully, unmap them all */
+	for (j = 0; j < nr_bvec; j++)
+		ib_dma_unmap_bvec(dev, sg_dma_address(&sgl[j]),
+				  sg_dma_len(&sgl[j]), dir);
+	kfree(sgl);
+	kfree(ctx->reg);
+	return ret;
+
+out_unmap:
+	/* Unmap bvecs that were successfully mapped (0 through i-1) */
+	for (j = 0; j < i; j++)
+		ib_dma_unmap_bvec(dev, sg_dma_address(&sgl[j]),
+				  sg_dma_len(&sgl[j]), dir);
+	kfree(sgl);
+out_free_reg:
+	kfree(ctx->reg);
+	return ret;
+}
+
 static int rdma_rw_init_map_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		struct scatterlist *sg, u32 sg_cnt, u32 offset,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
@@ -606,9 +740,8 @@ EXPORT_SYMBOL(rdma_rw_ctx_init);
  * @rkey:	remote key to operate on
  * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
  *
- * Maps the bio_vec array directly using dma_map_phys(), avoiding the
- * intermediate scatterlist conversion. Does not support the MR registration
- * path (iWARP devices or force_mr=1).
+ * Maps the bio_vec array directly, avoiding intermediate scatterlist
+ * conversion. Supports MR registration for iWARP devices and force_mr mode.
  *
  * Returns the number of WQEs that will be needed on the workqueue if
  * successful, or a negative error code.
@@ -618,14 +751,16 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		u32 offset, u64 remote_addr, u32 rkey,
 		enum dma_data_direction dir)
 {
+	struct ib_device *dev = qp->pd->device;
 	int ret;
 
 	if (nr_bvec == 0 || offset > bvec[0].bv_len)
 		return -EINVAL;
 
-	/* MR path not supported for bvec - reject iWARP and force_mr */
-	if (rdma_rw_io_needs_mr(qp->device, port_num, dir, nr_bvec))
-		return -EOPNOTSUPP;
+	if (rdma_rw_io_needs_mr(dev, port_num, dir, nr_bvec))
+		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvec,
+						nr_bvec, offset, remote_addr,
+						rkey, dir);
 
 	if (nr_bvec == 1)
 		return rdma_rw_init_single_wr_bvec(ctx, qp, bvec, offset,
@@ -921,6 +1056,16 @@ void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	u32 i;
 
 	switch (ctx->type) {
+	case RDMA_RW_MR:
+		for (i = 0; i < ctx->nr_ops; i++)
+			ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
+		kfree(ctx->reg);
+		/* Unmap bvecs using stored DMA addresses */
+		for (i = 0; i < ctx->mr_sg_cnt; i++)
+			ib_dma_unmap_bvec(dev, sg_dma_address(&ctx->mr_sgl[i]),
+					  sg_dma_len(&ctx->mr_sgl[i]), dir);
+		kfree(ctx->mr_sgl);
+		break;
 	case RDMA_RW_IOVA:
 		dma_iova_destroy(dev->dma_device, &ctx->iova.state,
 				 ctx->iova.mapped_len, dir, 0);
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 8a2012f03667..c73dc6955e07 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -48,6 +48,14 @@ struct rdma_rw_ctx {
 			struct ib_mr		*mr;
 		} *reg;
 	};
+
+	/*
+	 * For bvec MR path: store synthetic scatterlist with DMA addresses
+	 * for cleanup. Only valid when type == RDMA_RW_MR and initialized
+	 * via rdma_rw_ctx_init_bvec().
+	 */
+	struct scatterlist	*mr_sgl;
+	u32			mr_sg_cnt;
 };
 
 int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
-- 
2.52.0


