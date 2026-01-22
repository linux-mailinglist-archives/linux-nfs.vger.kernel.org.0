Return-Path: <linux-nfs+bounces-18332-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIPiJtyecmm/ngAAu9opvQ
	(envelope-from <linux-nfs+bounces-18332-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 144966E03B
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00296301C137
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 22:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3553D1CC0;
	Thu, 22 Jan 2026 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qETpZR9M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147E32E6BC;
	Thu, 22 Jan 2026 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119447; cv=none; b=oUwnOaFgMI4SzByEAQEZ23Q+27Sh+xXvbioiJITtj2ijn3/vJpBsBgMZF9KOHKTA1JOgO6dR4nLhtWp410Q0GZotI0Y7fW7hELr8DH8ijHD2SUd7GvrTeX+jx38W6NQaaVYtqwbSBo1VG/ScdtVbmHazljnlnv0CjNMftS4A8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119447; c=relaxed/simple;
	bh=S5CaTRm82AqHdc22jFQPYV3Whuk/hhKHiyJKsNuiP4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WujtO8HHWrw5fgP0SkAKxoWZ280F3rI+bp9pA4X4yRHPLCySbsA/dVJEByS+6YQUdJbs1oCWvtN/SrBwpnCUI8ieW982pTRj4XFWn9IdtLaZIffO1uh7RFTtbmQ0yRUkEivRgfCW/Z97bENfFOzkPP/K3vbe87gm+6fA97yEwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qETpZR9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0254C116D0;
	Thu, 22 Jan 2026 22:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119446;
	bh=S5CaTRm82AqHdc22jFQPYV3Whuk/hhKHiyJKsNuiP4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qETpZR9MsuyUQYKfag6pObDJ8wOECIYoy5yWrVQTUuK/qxkcuYEjyr6A/lmXsRp8G
	 QO0k99hyCSP88Jq+zbpGPFDHLzgauDWbWT//IZxl23e1CTMZp8/yNXbof2QPDcVWbO
	 8E83EzLtvFzJh+0RbwvIL3xcElvskWAZ3NHJBGj1efkgEWLkz4NrkzS+vo8kKEcdfJ
	 RgfTvpwCbf11K7RRsbi4p58ZbKuYT8uXxfJTikWm4tc7J129GrM4DP1oeHvyLJ5nsi
	 /5a/32733O2pCyzGpcZiDZmyMO2FiFHRROlSRDAM2X/Tw+yeKnBBA35B3l6VZoyvhF
	 doZEm76ZsXSzA==
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
Subject: [PATCH v3 1/5] RDMA/core: add bio_vec based RDMA read/write API
Date: Thu, 22 Jan 2026 17:03:57 -0500
Message-ID: <20260122220401.1143331-2-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18332-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,lst.de:email]
X-Rspamd-Queue-Id: 144966E03B
X-Rspamd-Action: no action

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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c | 205 +++++++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h      |  42 +++++++
 include/rdma/rw.h            |  11 ++
 3 files changed, 258 insertions(+)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 6354ddf2a274..991006de4a43 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -274,6 +274,123 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return 1;
 }
 
+static int rdma_rw_init_single_wr_bvec(struct rdma_rw_ctx *ctx,
+		struct ib_qp *qp, const struct bio_vec *bvecs,
+		struct bvec_iter *iter, u64 remote_addr, u32 rkey,
+		enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	struct ib_rdma_wr *rdma_wr = &ctx->single.wr;
+	struct bio_vec bv = mp_bvec_iter_bvec(bvecs, *iter);
+	u64 dma_addr;
+
+	ctx->nr_ops = 1;
+
+	dma_addr = ib_dma_map_bvec(dev, &bv, dir);
+	if (ib_dma_mapping_error(dev, dma_addr))
+		return -ENOMEM;
+
+	ctx->single.sge.lkey = qp->pd->local_dma_lkey;
+	ctx->single.sge.addr = dma_addr;
+	ctx->single.sge.length = bv.bv_len;
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
+		const struct bio_vec *bvecs, u32 nr_bvec, struct bvec_iter *iter,
+		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
+{
+	struct ib_device *dev = qp->pd->device;
+	u32 max_sge = dir == DMA_TO_DEVICE ? qp->max_write_sge :
+		      qp->max_read_sge;
+	struct ib_sge *sge;
+	u32 total_len = 0, i, j;
+	u32 mapped_bvecs = 0;
+	u32 nr_ops = DIV_ROUND_UP(nr_bvec, max_sge);
+	size_t sges_size = array_size(nr_bvec, sizeof(*ctx->map.sges));
+	size_t wrs_offset = ALIGN(sges_size, __alignof__(*ctx->map.wrs));
+	size_t wrs_size = array_size(nr_ops, sizeof(*ctx->map.wrs));
+	void *mem;
+
+	if (sges_size == SIZE_MAX || wrs_size == SIZE_MAX ||
+	    check_add_overflow(wrs_offset, wrs_size, &wrs_size))
+		return -ENOMEM;
+
+	mem = kzalloc(wrs_size, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	ctx->map.sges = sge = mem;
+	ctx->map.wrs = mem + wrs_offset;
+
+	for (i = 0; i < nr_ops; i++) {
+		struct ib_rdma_wr *rdma_wr = &ctx->map.wrs[i];
+		u32 nr_sge = min(nr_bvec - mapped_bvecs, max_sge);
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
+		for (j = 0; j < nr_sge; j++) {
+			const struct bio_vec *base = __bvec_iter_bvec(bvecs, *iter);
+			unsigned int offset = iter->bi_bvec_done;
+			unsigned int len = min(iter->bi_size,
+					       base->bv_len - offset);
+			struct bio_vec bv = {
+				.bv_page = base->bv_page,
+				.bv_len = len,
+				.bv_offset = base->bv_offset + offset,
+			};
+			u64 dma_addr;
+
+			dma_addr = ib_dma_map_bvec(dev, &bv, dir);
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
+
+			bvec_iter_advance_single(bvecs, iter, len);
+		}
+
+		rdma_wr->wr.next = i + 1 < nr_ops ?
+			&ctx->map.wrs[i + 1].wr : NULL;
+	}
+
+	ctx->nr_ops = nr_ops;
+	ctx->type = RDMA_RW_MULTI_WR;
+	return nr_ops;
+
+out_unmap:
+	for (i = 0; i < mapped_bvecs; i++)
+		ib_dma_unmap_bvec(dev, ctx->map.sges[i].addr,
+				  ctx->map.sges[i].length, dir);
+	kfree(ctx->map.sges);
+	return -ENOMEM;
+}
+
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -344,6 +461,53 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
 
+/**
+ * rdma_rw_ctx_init_bvec - initialize a RDMA READ/WRITE context from bio_vec
+ * @ctx:	context to initialize
+ * @qp:		queue pair to operate on
+ * @port_num:	port num to which the connection is bound
+ * @bvecs:	bio_vec array to READ/WRITE from/to
+ * @nr_bvec:	number of entries in @bvecs
+ * @iter:	bvec iterator describing offset and length
+ * @remote_addr: remote address to read/write (relative to @rkey)
+ * @rkey:	remote key to operate on
+ * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
+ *
+ * Accepts bio_vec arrays directly, avoiding scatterlist conversion for
+ * callers that already have data in bio_vec form. Prefer this over
+ * rdma_rw_ctx_init() when the source data is a bio_vec array.
+ *
+ * This function does not support devices requiring memory registration.
+ * iWARP devices and configurations with force_mr=1 should use
+ * rdma_rw_ctx_init() with a scatterlist instead.
+ *
+ * Returns the number of WQEs that will be needed on the workqueue if
+ * successful, or a negative error code:
+ *
+ *   * -EINVAL  - @nr_bvec is zero or @iter.bi_size is zero
+ *   * -EOPNOTSUPP - device requires MR path (iWARP or force_mr=1)
+ *   * -ENOMEM - DMA mapping or memory allocation failed
+ */
+int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 port_num, const struct bio_vec *bvecs, u32 nr_bvec,
+		struct bvec_iter iter, u64 remote_addr, u32 rkey,
+		enum dma_data_direction dir)
+{
+	if (nr_bvec == 0 || iter.bi_size == 0)
+		return -EINVAL;
+
+	/* MR path not supported for bvec - reject iWARP and force_mr */
+	if (rdma_rw_io_needs_mr(qp->device, port_num, dir, nr_bvec))
+		return -EOPNOTSUPP;
+
+	if (nr_bvec == 1)
+		return rdma_rw_init_single_wr_bvec(ctx, qp, bvecs, &iter,
+				remote_addr, rkey, dir);
+	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvecs, nr_bvec, &iter,
+			remote_addr, rkey, dir);
+}
+EXPORT_SYMBOL(rdma_rw_ctx_init_bvec);
+
 /**
  * rdma_rw_ctx_signature_init - initialize a RW context with signature offload
  * @ctx:	context to initialize
@@ -598,6 +762,47 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
+/**
+ * rdma_rw_ctx_destroy_bvec - release resources from rdma_rw_ctx_init_bvec
+ * @ctx:	context to release
+ * @qp:		queue pair to operate on
+ * @port_num:	port num to which the connection is bound (unused)
+ * @bvecs:	bio_vec array that was used for the READ/WRITE (unused)
+ * @nr_bvec:	number of entries in @bvecs
+ * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
+ *
+ * Releases all resources allocated by a successful rdma_rw_ctx_init_bvec()
+ * call. Must not be called if rdma_rw_ctx_init_bvec() returned an error.
+ *
+ * The @port_num and @bvecs parameters are unused but present for API
+ * symmetry with rdma_rw_ctx_destroy().
+ */
+void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 __maybe_unused port_num,
+		const struct bio_vec __maybe_unused *bvecs,
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
index 6aad66bc5dd7..82958f5117c3 100644
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
@@ -4249,6 +4250,47 @@ static inline void ib_dma_unmap_page(struct ib_device *dev,
 		dma_unmap_page(dev->dma_device, addr, size, direction);
 }
 
+/**
+ * ib_dma_map_bvec - Map a bio_vec to DMA address
+ * @dev: The device for which the dma_addr is to be created
+ * @bvec: The bio_vec to map
+ * @direction: The direction of the DMA
+ *
+ * Returns a DMA address for the bio_vec. The caller must check the
+ * result with ib_dma_mapping_error() before use; a failed mapping
+ * must not be passed to ib_dma_unmap_bvec().
+ *
+ * For software RDMA devices (rxe, siw), returns a virtual address
+ * and no actual DMA mapping occurs.
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
+ * @addr: The DMA address returned by ib_dma_map_bvec()
+ * @size: The size of the region in bytes
+ * @direction: The direction of the DMA
+ *
+ * Releases a DMA mapping created by ib_dma_map_bvec(). For software
+ * RDMA devices this is a no-op since no actual mapping occurred.
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
index d606cac48233..b2fc3e2373d7 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -5,6 +5,7 @@
 #ifndef _RDMA_RW_H
 #define _RDMA_RW_H
 
+#include <linux/bvec.h>
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 #include <rdma/ib_verbs.h>
@@ -49,6 +50,16 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 			 u32 port_num, struct scatterlist *sg, u32 sg_cnt,
 			 enum dma_data_direction dir);
 
+struct bio_vec;
+
+int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 port_num, const struct bio_vec *bvecs, u32 nr_bvec,
+		struct bvec_iter iter, u64 remote_addr, u32 rkey,
+		enum dma_data_direction dir);
+void rdma_rw_ctx_destroy_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
+		u32 port_num, const struct bio_vec *bvecs, u32 nr_bvec,
+		enum dma_data_direction dir);
+
 int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		u32 port_num, struct scatterlist *sg, u32 sg_cnt,
 		struct scatterlist *prot_sg, u32 prot_sg_cnt,
-- 
2.52.0


