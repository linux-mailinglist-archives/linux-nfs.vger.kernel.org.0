Return-Path: <linux-nfs+bounces-18196-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAgtNivAb2kOMQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18196-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 18:49:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD9E48D91
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 18:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E129A5CBBED
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426244A727;
	Tue, 20 Jan 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llllnD3z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D131441057;
	Tue, 20 Jan 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919491; cv=none; b=HNgOnsmNp1ZCdTepe9yMO9mYNo/9/cRWKKwYQhaCsQ0KNPReEsyJi4rXy7F6i+VtcouGXN+cf3+aNxlm+Ck7SR+zCURKovlzyew7jQSRWyPvqVmaAqpbRPs61QQbWDob6SjEnfgSPlZzPmiIDth+MlYV03MvEZh/5JthIz3vti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919491; c=relaxed/simple;
	bh=+vqvoeBO+4EjI01MVIAsPksV5XV2mpHEwHBlfLV+LXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OV8X9G0ZA9tLcwUqGq/lpLTRCvBKBXVCln+dNcoHZT8Nx46Svh7cfgLsYVN+WrGcQ8wQcSnZMzU70wHmrQvr439cdePLBJEQZX/3qQ8VdTNT3PMnSaJPF1irZzX4jKgJ+BOAyTclCZMQ9E2hGnTkQ3GBrPTtwXWfMYvf1MsEjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llllnD3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22682C4AF09;
	Tue, 20 Jan 2026 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919491;
	bh=+vqvoeBO+4EjI01MVIAsPksV5XV2mpHEwHBlfLV+LXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llllnD3zxv9HdCeq950xlnU7da/jZxGnXbUIsG+JiYiln8nOqvHOG7VLkXXrFxfbh
	 g9Bo6+ha1eGBlELvK2GIhbzlQ6cI6AauMv8rMOLoUqavC0AnrhEzgOI+JY7A0/E+Nj
	 RX9aeL9cL5AbcfFcODcx455cHnoowPbf0xq62MaFepp1vfy195elZx3mG/U+Xf0YLZ
	 PcwyuTEtq9LUFg/AOT6B/Thz5TRNa5Fs0/cQZMjemB4/h46MipK/hrbtjECFD1rtIM
	 9PUNLcbA5tMtATuckp7tLaFaeGhCVap2AhSKyTaPiKx0Fq3hVf3MWUeBDCzTAFEiB6
	 uZZN01DLzWv7Q==
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
Subject: [PATCH v2 2/4] RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
Date: Tue, 20 Jan 2026 09:31:22 -0500
Message-ID: <20260120143124.1822121-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120143124.1822121-1-cel@kernel.org>
References: <20260120143124.1822121-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18196-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7CD9E48D91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The bvec RDMA API maps each bvec individually via dma_map_phys(),
requiring an IOTLB sync for each mapping. For large I/O operations
with many bvecs, this overhead becomes significant.

The two-step IOVA API (dma_iova_try_alloc / dma_iova_link /
dma_iova_sync) allocates a contiguous IOVA range upfront, links
all physical pages without IOTLB syncs, then performs a single
sync at the end. This reduces IOTLB flushes from O(n) to O(1).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c | 116 +++++++++++++++++++++++++++++++++++
 include/rdma/rw.h            |   8 +++
 2 files changed, 124 insertions(+)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 59f32fecf3df..51f650c4fa8c 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -15,6 +15,7 @@ enum {
 	RDMA_RW_MULTI_WR,
 	RDMA_RW_MR,
 	RDMA_RW_SIG_MR,
+	RDMA_RW_IOVA,
 };
 
 static bool rdma_rw_force_mr;
@@ -380,6 +381,93 @@ static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
+static int rdma_rw_init_iova_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		const struct bio_vec *bvec, u32 nr_bvec,
+		struct bvec_iter *iter,
+		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	struct device *dma_dev = dev->dma_device;
+	struct bvec_iter link_iter;
+	struct bio_vec first_bv;
+	size_t total_len, mapped_len = 0;
+	int ret;
+
+	/* Virtual DMA devices lack IOVA allocators */
+	if (ib_uses_virt_dma(dev))
+		return -EOPNOTSUPP;
+
+	total_len = iter->bi_size;
+
+	/* Get the first (possibly offset-adjusted) bvec for starting phys addr */
+	first_bv = mp_bvec_iter_bvec(bvec, *iter);
+
+	/* Try to allocate contiguous IOVA space */
+	if (!dma_iova_try_alloc(dma_dev, &ctx->iova.state,
+				bvec_phys(&first_bv), total_len))
+		return -EOPNOTSUPP;
+
+	/* Link all bvecs into the IOVA space */
+	link_iter = *iter;
+	while (link_iter.bi_size) {
+		struct bio_vec bv = mp_bvec_iter_bvec(bvec, link_iter);
+
+		ret = dma_iova_link(dma_dev, &ctx->iova.state, bvec_phys(&bv),
+				    mapped_len, bv.bv_len, dir, 0);
+		if (ret)
+			goto out_destroy;
+
+		if (check_add_overflow(mapped_len, bv.bv_len, &mapped_len)) {
+			ret = -EOVERFLOW;
+			goto out_destroy;
+		}
+		bvec_iter_advance(bvec, &link_iter, bv.bv_len);
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
+	ctx->iova.wr.wr.opcode = dir == DMA_TO_DEVICE ?
+		IB_WR_RDMA_WRITE : IB_WR_RDMA_READ;
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
@@ -484,6 +572,7 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 {
 	struct bvec_iter iter;
 	u32 i, total_len = 0;
+	int ret;
 
 	if (nr_bvec == 0 || offset >= bvec[0].bv_len)
 		return -EINVAL;
@@ -507,6 +596,21 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return rdma_rw_init_single_wr_bvec(ctx, qp, bvec, &iter,
 				remote_addr, rkey, dir);
 
+	/*
+	 * Try IOVA-based mapping first for multi-bvec transfers.
+	 * This reduces IOTLB sync overhead by batching all mappings.
+	 */
+	ret = rdma_rw_init_iova_wrs_bvec(ctx, qp, bvec, nr_bvec, &iter,
+			remote_addr, rkey, dir);
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
+	/* Fallback path requires iterator at initial state */
+	iter.bi_sector = 0;
+	iter.bi_size = total_len;
+	iter.bi_idx = 0;
+	iter.bi_bvec_done = offset;
+
 	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvec, nr_bvec, &iter,
 			remote_addr, rkey, dir);
 }
@@ -683,6 +787,10 @@ struct ib_send_wr *rdma_rw_ctx_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -757,6 +865,10 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		break;
 	case RDMA_RW_SINGLE_WR:
 		break;
+	case RDMA_RW_IOVA:
+		/* IOVA contexts must use rdma_rw_ctx_destroy_bvec() */
+		WARN_ON_ONCE(1);
+		break;
 	default:
 		BUG();
 		break;
@@ -790,6 +902,10 @@ void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
index 046a8eb57125..2a5f33665d52 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -31,6 +31,14 @@ struct rdma_rw_ctx {
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
2.52.0


