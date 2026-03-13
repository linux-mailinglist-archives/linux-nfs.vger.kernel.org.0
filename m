Return-Path: <linux-nfs+bounces-20160-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L7EBZNotGnxnQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20160-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 20:42:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0F2895FB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 20:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5685D300517F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35A3DD52E;
	Fri, 13 Mar 2026 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlRRp2Wv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30626CE05;
	Fri, 13 Mar 2026 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430926; cv=none; b=T4qYVcAvl3A39+sKwnGOvkJXeSZJJ4bs5YVpbmTw6z3Oz8OZQUzLb3NwjRVo1j6YrkAEs3S5QlOpSwedmh8Yrr+TiTyH3s3B5KiLcTx0bGY1dMQ3iRh9LBznSViTLBdcP8aSsBlPh3SrIalCyULc8hwsh0BMq+wEgR3ogeeM/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430926; c=relaxed/simple;
	bh=0q5tDSARrYo9Z2umnbstHN8sjWz60yobEEAV24PQ2BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQdvCIpleLkaMm2iu+B8INQgrxTrPrvYwZoL1jer+O2k3veQmnX1taNJzDaHud7TL6rvt/T/p9xCbu/IJZl/cQzMDuZJwRBuS2l1VXUWz1+QLutnzwmQGmdG+m3XzxkZgnhluaTuTMj7vFi5LxAElYel2Y2O/ItCcOkGjdfThtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlRRp2Wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB00AC19423;
	Fri, 13 Mar 2026 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773430925;
	bh=0q5tDSARrYo9Z2umnbstHN8sjWz60yobEEAV24PQ2BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlRRp2WvFofdZvslBiUwlK/gCxxmB3v9tvk17D2FeAV8VmZCpS/0Wy4ic6JOB8HcH
	 fI7LmRyH6mRAiSHO/u+B9MzHv7lBmJNnTIzh1hXi53gadOBe8dqhIT99JFQT2E2ZDB
	 ScGgZWnDdTbrBLhyPB9ZJtdupoHlo9WxUYKI5mzCe5PxQXXAE32n9JPw5v4VULUQAH
	 CsluOPNEeJiWylQm5AlzJplxsSuCSfAJxlJuAIpcyzZZwIorgHM0lvHZOPVE+ZT30j
	 O/cvB2KliVoBEVO3sSJ3cb5xH1CLGcCN3WiTTH1LwgViVc28nldQDiIkdG4Hscrw91
	 RpADdE89HfQWA==
From: Chuck Lever <cel@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 1/4] RDMA/rw: Fall back to direct SGE on MR pool exhaustion
Date: Fri, 13 Mar 2026 15:41:58 -0400
Message-ID: <20260313194201.5818-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313194201.5818-1-cel@kernel.org>
References: <20260313194201.5818-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20160-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,lst.de,ownmail.net,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21A0F2895FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

When IOMMU passthrough mode is active, ib_dma_map_sgtable_attrs()
produces no coalescing: each scatterlist page maps 1:1 to a DMA
entry, so sgt.nents equals the raw page count. A 1 MB transfer
yields 256 DMA entries. If that count exceeds the device's
max_sgl_rd threshold (an optimization hint from mlx5 firmware),
rdma_rw_io_needs_mr() steers the operation into the MR
registration path. Each such operation consumes one or more MRs
from a pool sized at max_rdma_ctxs -- roughly one MR per
concurrent context. Under write-intensive workloads that issue
many concurrent RDMA READs, the pool is rapidly exhausted,
ib_mr_pool_get() returns NULL, and rdma_rw_init_one_mr() returns
-EAGAIN. Upper layer protocols treat this as a fatal DMA mapping
failure and tear down the connection.

The max_sgl_rd check is a performance optimization, not a
correctness requirement: the device can handle large SGE counts
via direct posting, just less efficiently than with MR
registration. When the MR pool cannot satisfy a request, falling
back to the direct SGE (map_wrs) path avoids the connection
reset while preserving the MR optimization for the common case
where pool resources are available.

Add a fallback in rdma_rw_ctx_init() so that -EAGAIN from
rdma_rw_init_mr_wrs() triggers direct SGE posting instead of
propagating the error. iWARP devices, which mandate MR
registration for RDMA READs, and force_mr debug mode continue
to treat -EAGAIN as terminal.

Fixes: 00bd1439f464 ("RDMA/rw: Support threshold for registration vs scattering to local pages")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index fc45c384833f..c01d5e605053 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -608,14 +608,29 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	if (rdma_rw_io_needs_mr(qp->device, port_num, dir, sg_cnt)) {
 		ret = rdma_rw_init_mr_wrs(ctx, qp, port_num, sg, sg_cnt,
 				sg_offset, remote_addr, rkey, dir);
-	} else if (sg_cnt > 1) {
-		ret = rdma_rw_init_map_wrs(ctx, qp, sg, sg_cnt, sg_offset,
-				remote_addr, rkey, dir);
-	} else {
-		ret = rdma_rw_init_single_wr(ctx, qp, sg, sg_offset,
-				remote_addr, rkey, dir);
+		/*
+		 * If MR init succeeded or failed for a reason other
+		 * than pool exhaustion, that result is final.
+		 *
+		 * Pool exhaustion (-EAGAIN) from the max_sgl_rd
+		 * optimization is recoverable: fall back to
+		 * direct SGE posting. iWARP and force_mr require
+		 * MRs unconditionally, so -EAGAIN is terminal.
+		 */
+		if (ret != -EAGAIN ||
+		    rdma_protocol_iwarp(qp->device, port_num) ||
+		    unlikely(rdma_rw_force_mr))
+			goto out;
 	}
 
+	if (sg_cnt > 1)
+		ret = rdma_rw_init_map_wrs(ctx, qp, sg, sg_cnt, sg_offset,
+				remote_addr, rkey, dir);
+	else
+		ret = rdma_rw_init_single_wr(ctx, qp, sg, sg_offset,
+				remote_addr, rkey, dir);
+
+out:
 	if (ret < 0)
 		goto out_unmap_sg;
 	return ret;
-- 
2.53.0


