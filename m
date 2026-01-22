Return-Path: <linux-nfs+bounces-18331-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PS4Ntuecmm/ngAAu9opvQ
	(envelope-from <linux-nfs+bounces-18331-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4752F6E034
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6CDE3014C2E
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 22:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20E3C23B2;
	Thu, 22 Jan 2026 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIbVT8VY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072E34D3AC;
	Thu, 22 Jan 2026 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119446; cv=none; b=d8isuZWY8TgJyMfCCW+ml8FzxD1F9VCLxsubESkf7qO0jbV03RPZhfYlIbZ6wK7d1R37YWrM06ibuVOf1E3ecIHcyCVH4bBq3R8WrjW77gBDqTfSzxq/me0VOv5EfGp870X3rsuK2tt2ViDSIcQjF2LyRNepVuExJwkBJPfFgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119446; c=relaxed/simple;
	bh=La/utEg2+SlsH0nglhZtrlUVcEjYN6fiQtrD7kayTZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVA/oZqOBO/41elyHBUYbrZ+rHirLTkDTgrJp10yojLS9HVtchD3BZslF8GLFfNRcYb2RpqFhgJGiqQCfhx5apd44lIlIxuUpmVHixFaOSsknU+ZlsujTxCEZq+kV2irYTUYoXuflVJDukEgfeSNX8GI8UG3GBXRlHvw6CO4gzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIbVT8VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18D6C116C6;
	Thu, 22 Jan 2026 22:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119445;
	bh=La/utEg2+SlsH0nglhZtrlUVcEjYN6fiQtrD7kayTZE=;
	h=From:To:Cc:Subject:Date:From;
	b=aIbVT8VYOQh7fjMRI83odMIMlzLqM6OUHohyYoyObD66JF62Fztjeuqd8/mMaSn6z
	 5cuvvlOiIDbHKXVnLJglrAFLjanRhbD0NETBnnYAdFGZnhKiwazyJDHGaPaRywF4qy
	 3Xg7slNQ1lCSURSBxGpugmHhyKmo4n9vsELhoUjj72evD5IsYjl0msklxCszZQt/kA
	 Doc7PMf9zoAfpSqvbqOrEE/ffCE4H3swA8imRQXy4rXuUHm9zFwa/lLkzp7LwQbRaK
	 tzI/wVtjbXx8lvJKv62ytr6hOt/H+gkxYQHU1rVpVKq0b9h1v807CoupLeZaeBGVtq
	 zvLaXNAjTlnHg==
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
Subject: [PATCH v3 0/5] Add a bio_vec based API to core/rw.c
Date: Thu, 22 Jan 2026 17:03:56 -0500
Message-ID: <20260122220401.1143331-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18331-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4752F6E034
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

Based on v6.19-rc6.

---

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

 drivers/infiniband/core/rw.c             | 591 ++++++++++++++++++++---
 drivers/infiniband/ulp/isert/ib_isert.c  |   4 +-
 drivers/nvme/target/rdma.c               |   4 +-
 include/rdma/ib_verbs.h                  |  42 ++
 include/rdma/rw.h                        |  36 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 155 +++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   8 +-
 7 files changed, 699 insertions(+), 141 deletions(-)

-- 
2.52.0


