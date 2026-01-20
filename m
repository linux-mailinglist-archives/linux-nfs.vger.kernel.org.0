Return-Path: <linux-nfs+bounces-18197-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MUxKhG5b2kOMQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18197-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 18:19:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A85486E5
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 019AD78208F
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7144A72E;
	Tue, 20 Jan 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJFVNDC7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9744A730;
	Tue, 20 Jan 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919492; cv=none; b=erOfoYMw6e5r4tuNO2+xHCSjEKH34X0DowyHNIC+Ieca9riC+TxadrYAMGN3v8pBmlJA09uyrf8PO6jg1efIv97FiZB475S62hpO/H3+ND1lCORUq/MumU6kS83a93uD0Cf2yC/YlklLVCXW3d6wVjAop0nRkwKfBopizJfVv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919492; c=relaxed/simple;
	bh=5DyxGraXGwegOPKCAySnzbvXrDZ8neD5NC+AwY4Ykz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/+9vdIf91GRKmrUr40552S9bokTi5V04Z0v3AnO9bzSuPcxcuz/MtWXnAyNZ33+Ol2seunpG7I1/Y468AJfmHfqHU3M0rWxC5zcMP4sgn3Hq5nfiVSY4paEOXFPnM38QZU54wYnod7LsA51x4nUUcEflch15AxXs6Fs0X3Fp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJFVNDC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E97C16AAE;
	Tue, 20 Jan 2026 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919492;
	bh=5DyxGraXGwegOPKCAySnzbvXrDZ8neD5NC+AwY4Ykz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJFVNDC7nOuU27x4K+4+Iq6k6XGGCZvtQRBuVAhc771NsdcyTQyUsSRSgO/yLcdUB
	 S6tpCmFsicRD1hjwFaZYSPreGx/VoCYkJvsxzJVUovjQr4FWRKbUfyM7Zo7A6cCNfq
	 xJRedu24OLTErpOVSBFHX7pUuKH1oisERQCfjt+W7zLVrkahZBIFRwaAAvdXBB+8Ab
	 d3YEU4bJBVCXQhVgY+IZYtDOlZoh6rmQGaVFjhBiDe6pwHgkOHsuCFV08Ax+q38rou
	 MGLrJUNTNPIPI9jghd7fc+MCcH0sMZ2GuaCchKU2kl0ZTlQVwUe2lmVhnWclnIYvGp
	 jpxc0AQfvyu7Q==
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
Subject: [PATCH v2 3/4] RDMA/core: add MR support for bvec-based RDMA operations
Date: Tue, 20 Jan 2026 09:31:23 -0500
Message-ID: <20260120143124.1822121-4-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18197-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 53A85486E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/infiniband/core/rw.c | 159 ++++++++++++++++++++++++++++++++---
 include/rdma/rw.h            |   8 ++
 2 files changed, 156 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 51f650c4fa8c..9181fca8ff3f 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -194,6 +194,135 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
+	for (i = 0; i < nr_bvec; i++) {
+		const struct bio_vec *bv = &bvec[i];
+		struct bio_vec adjusted;
+		u64 dma_addr;
+		u32 len;
+
+		/*
+		 * The offset parameter applies only to the first bvec,
+		 * allowing callers to start partway into the array.
+		 */
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
+		/* sg_set_page() initializes the entry; ib_map_mr_sg() uses
+		 * only sg_dma_address/len, ignoring the page pointer.
+		 */
+		sg_set_page(&sgl[i], bv->bv_page, len, bv->bv_offset);
+		sg_dma_address(&sgl[i]) = dma_addr;
+		sg_dma_len(&sgl[i]) = len;
+	}
+
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
@@ -550,19 +679,13 @@ EXPORT_SYMBOL(rdma_rw_ctx_init);
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
  *   * -EINVAL  - @nr_bvec is zero, @offset exceeds first bvec, or overflow
- *   * -EOPNOTSUPP - device requires MR path (iWARP or force_mr=1)
  *   * -ENOMEM - DMA mapping or memory allocation failed
  */
 int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
@@ -570,6 +693,7 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		u32 offset, u64 remote_addr, u32 rkey,
 		enum dma_data_direction dir)
 {
+	struct ib_device *dev = qp->pd->device;
 	struct bvec_iter iter;
 	u32 i, total_len = 0;
 	int ret;
@@ -577,9 +701,10 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	if (nr_bvec == 0 || offset >= bvec[0].bv_len)
 		return -EINVAL;
 
-	/* MR path not supported for bvec - reject iWARP and force_mr */
-	if (rdma_rw_io_needs_mr(qp->device, port_num, dir, nr_bvec))
-		return -EOPNOTSUPP;
+	if (rdma_rw_io_needs_mr(dev, port_num, dir, nr_bvec))
+		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvec,
+						nr_bvec, offset, remote_addr,
+						rkey, dir);
 
 	for (i = 0; i < nr_bvec; i++) {
 		if (check_add_overflow(total_len, bvec[i].bv_len, &total_len))
@@ -855,6 +980,8 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	switch (ctx->type) {
 	case RDMA_RW_MR:
+		/* Bvec MR contexts must use rdma_rw_ctx_destroy_bvec() */
+		WARN_ON_ONCE(ctx->mr_sgl);
 		for (i = 0; i < ctx->nr_ops; i++)
 			ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
 		kfree(ctx->reg);
@@ -902,6 +1029,16 @@ void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	u32 i;
 
 	switch (ctx->type) {
+	case RDMA_RW_MR:
+		for (i = 0; i < ctx->nr_ops; i++)
+			ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->reg[i].mr);
+		kfree(ctx->reg);
+		/* DMA addresses were stored in mr_sgl during init */
+		for (i = 0; i < ctx->mr_sg_cnt; i++)
+			ib_dma_unmap_bvec(dev, sg_dma_address(&ctx->mr_sgl[i]),
+					  sg_dma_len(&ctx->mr_sgl[i]), dir);
+		kfree(ctx->mr_sgl);
+		break;
 	case RDMA_RW_IOVA:
 		dma_iova_destroy(dev->dma_device, &ctx->iova.state,
 				 ctx->iova.mapped_len, dir, 0);
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 2a5f33665d52..01177fd09eae 100644
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


