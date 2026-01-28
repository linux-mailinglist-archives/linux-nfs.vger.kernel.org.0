Return-Path: <linux-nfs+bounces-18541-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /GF4BDFeeWn+wgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18541-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 01:54:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 873859BC2C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 01:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9A013008272
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 00:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9799619309C;
	Wed, 28 Jan 2026 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/oby3Wa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A837A13A;
	Wed, 28 Jan 2026 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769561644; cv=none; b=M4XM+eBrQA0H25z/0joK8XY2mcz9DEPnGPVHfdm+8lmmapeVKyw7prSVY0FeVHvjslKxye/sG30DdEiJqSjacRznlNBr7+i1Nsy779ES9TaJ24yc30d0gEU/ReGRmW4NE+nu0Bh4MMcoipLycRZRQLrimN9111VQJEifG3VNuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769561644; c=relaxed/simple;
	bh=+krboppBsLTFk3zRHe9ldWyamLfY9PsIu3CD1UkdQkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JH03t6IxRUjrBx6FQL5/7LtTmuxdx1LbqaoNyVZlPQyYOQg1UyZNWVcw28EEQd5+Bi22McmXXLncNaUQjYBm3OEvpJ7dpeHZmFBjuAN2oVJp5dO7DQwHjGI1S5/tXpwb76UDIPVcy2+Cj+QAt0CdMRy/wB7fzQWAccEPcFur0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/oby3Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5BEC116C6;
	Wed, 28 Jan 2026 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769561644;
	bh=+krboppBsLTFk3zRHe9ldWyamLfY9PsIu3CD1UkdQkg=;
	h=From:To:Cc:Subject:Date:From;
	b=P/oby3WaX0S8+13T61xhnh3gMB6WJ8pGJrVW2D3xF7PDXddTvWc6OrkZ9nw7fc/7R
	 RE1OEixGsZf9vi9oWREsHa3FZwktO4pCLJKeWXGLr0BmQQyqe/7f5Z9gc6fVHWzK65
	 6FBvlMDlQv7oplG8rLoEosjq+aqJZhM5I+FaCkj1SSMrgqJgjfJfiOl3ng8V/bNa+l
	 oE1jGR7hoS8JWZQIAchQjo30tiAEMTuzeELp+h/qWkriDzzXxnJDazce9RwCouLIMS
	 Vy47HsewTJd6hR6QzRg2jqGn6MynpBTXTC6bOCe0l/zeLktUg6ACRy9ApayIv1vmw2
	 tGaOiHeLM5DPA==
From: Chuck Lever <cel@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 0/5] Add a bio_vec based API to core/rw.c
Date: Tue, 27 Jan 2026 19:53:55 -0500
Message-ID: <20260128005400.25147-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
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
	TAGGED_FROM(0.00)[bounces-18541-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 873859BC2C
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

This series introduces a bio_vec based API for RDMA read and write
operations in the RDMA core, eliminating unnecessary scatterlist
conversions for callers that already work with bvecs.

Current users of rdma_rw_ctx_init() must convert their native data
structures into scatterlists. For subsystems like svcrdma that
maintain data in bvec format, this conversion adds overhead both in
CPU cycles and memory footprint. The new API accepts bvec arrays
directly.

For hardware RDMA devices, the implementation uses the IOVA-based
DMA mapping API to reduce IOTLB synchronization overhead from O(n)
per-page syncs to a single O(1) sync after all mappings complete.
Software RDMA devices (rxe, siw) continue using virtual addressing.

The series includes MR registration support for bvec arrays,
enabling iWARP devices and the force_mr debug parameter. The MR
path reuses existing ib_map_mr_sg() infrastructure by constructing
a synthetic scatterlist from the bvec DMA addresses.

The final patch adds the first consumer for the new API: svcrdma.

Based on v6.19-rc7.

---

Changes since v4:
- Move the synthetic SGL into struct rdma_rw_reg_ctx

Changes since v3:
- Remove the local iter from rdma_rw_init_iova_wrs_bvec()
- Refactor common per-MR handling into a helper

Changes since v2:
- Add bvec iter arguments to the new API
- Add a synthetic SGL in the MR mapping function
- Try IOVA coalescing before max_sgl_rd triggers MR in bvec path
- Attempt once again to address SQ/CQ/max_rdma_ctxs sizing issues

Changes since v1:
- Simplify rw.c by using bvec iters internally
- IOVA mapping produces a contiguous DMA address range
- Clarify the comment that documents struct svc_rdma_rw_ctxt
- svcrdma now uses pre-allocated bio_vec arrays

Chuck Lever (5):
  RDMA/core: add bio_vec based RDMA read/write API
  RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
  RDMA/core: add MR support for bvec-based RDMA operations
  RDMA/core: add rdma_rw_max_sge() helper for SQ sizing
  svcrdma: use bvec-based RDMA read/write API

 drivers/infiniband/core/rw.c             | 521 +++++++++++++++++++++--
 include/rdma/ib_verbs.h                  |  42 ++
 include/rdma/rw.h                        |  22 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 155 ++++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   8 +-
 5 files changed, 638 insertions(+), 110 deletions(-)

-- 
2.49.0


