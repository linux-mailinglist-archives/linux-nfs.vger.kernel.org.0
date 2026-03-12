Return-Path: <linux-nfs+bounces-20064-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4He5Lz7CsmmvPAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20064-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 14:40:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6260C272BFE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 14:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8AFD30217F7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0683C061F;
	Thu, 12 Mar 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds6PFcrR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C13BF664;
	Thu, 12 Mar 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322813; cv=none; b=uI/pMVHgyOumh1I6bG36mQ3tU0KdF1fMaH4yRDw/u253XQSPC0QZ9CC8dJ2fOZJX1+iemKlp97S8OAl5JqxS4CQpl3x8S5EBrLxJ+6gVhR6e/0Sq/4+g7+0W+rHF4jqsSHgXly3aIwx7qmzLMEFu5Hh54qHFdePCCYi+T6gYeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322813; c=relaxed/simple;
	bh=IZfe1Kqp+6rOspYFaFA1p2cmcsX+TWmzuwzJf9lp8RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEOWxM0cyO5DF9J6tONhcJM6eocDsSg0IiKkfOR1p3aAV5gMvBqzfaZ4HVA1fqzAmfDYZejxFKXN78X9NShSv0uJcWcm5TYPZY3mUZpDpakfUCPHyS+EVpSp6Pldar1RmXsFcaN6O6vCz4fQXApb0FMYOS5wkv0wTd7eisEKkgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds6PFcrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA53C2BC87;
	Thu, 12 Mar 2026 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773322812;
	bh=IZfe1Kqp+6rOspYFaFA1p2cmcsX+TWmzuwzJf9lp8RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ds6PFcrRRgJflauOFxGW9EK1nWInH71R2PbOpe9gr2OjTtAlYA6pMTZ5ixw3KWTxq
	 DtI6wel0KnXZ3362B9Zp4D5JnvSEb6fD4qYLKzR0awODpcJoZImF0FWTOSiavGWE0U
	 PEOGhU4rS5QoLHhRnhT8Ic31mLQBwZd+lNGfiFNuRroXzludgqnMiLsDV0+Tt5GHuq
	 FzUW/5O9vZLDt6vIQFEYjCT3RJX1qAsuiXOJ7wSNYKmKdx9okVqir+0E17sf2aifM9
	 DI9/D7DU3YwoKACSgCOO7nl8FSXle0TwvU4UhHzqHScYU41za+oPrC9VYMHgRChlzR
	 hNJUeoXtrrcpw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/2] RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path
Date: Thu, 12 Mar 2026 09:40:07 -0400
Message-ID: <20260312134008.7387-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312134008.7387-1-cel@kernel.org>
References: <20260312134008.7387-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20064-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,lst.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 6260C272BFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

When IOVA-based DMA mapping is unavailable (e.g., IOMMU
passthrough mode), rdma_rw_ctx_init_bvec() falls back to
checking rdma_rw_io_needs_mr() with the raw bvec count.
Unlike the scatterlist path in rdma_rw_ctx_init(), which
passes a post-DMA-mapping entry count that reflects
coalescing of physically contiguous pages, the bvec path
passes the pre-mapping page count. This overstates the
number of DMA entries, causing every multi-bvec RDMA READ
to consume an MR from the QP's pool.

Under NFS WRITE workloads the server performs RDMA READs
to pull data from the client. With the inflated MR demand,
the pool is rapidly exhausted, ib_mr_pool_get() returns
NULL, and rdma_rw_init_one_mr() returns -EAGAIN. svcrdma
treats this as a DMA mapping failure, closes the connection,
and the client reconnects -- producing a cycle of 71% RPC
retransmissions and ~100 reconnections per test run. RDMA
WRITEs (NFS READ direction) are unaffected because
DMA_TO_DEVICE never triggers the max_sgl_rd check.

Remove the rdma_rw_io_needs_mr() gate from the bvec path
entirely, so that bvec RDMA operations always use the
map_wrs path (direct WR posting without MR allocation).
The bvec caller has no post-DMA-coalescing segment count
available -- xdr_buf and svc_rqst hold pages as individual
pointers, and physical contiguity is discovered only during
DMA mapping -- so the raw page count cannot serve as a
reliable input to rdma_rw_io_needs_mr(). iWARP devices,
which require MRs unconditionally, are handled by an
earlier check in rdma_rw_ctx_init_bvec() and are unaffected.

Fixes: bea28ac14cab ("RDMA/core: add MR support for bvec-based RDMA operations")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index fc45c384833f..1b74293adec1 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -686,14 +686,16 @@ int rdma_rw_ctx_init_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return ret;
 
 	/*
-	 * IOVA mapping not available. Check if MR registration provides
-	 * better performance than multiple SGE entries.
+	 * IOVA not available; fall back to the map_wrs path, which maps
+	 * each bvec as a direct SGE. This is always correct: the MR path
+	 * is a throughput optimization, not a correctness requirement.
+	 * (iWARP, which does require MRs, is handled by the check above.)
+	 *
+	 * The rdma_rw_io_needs_mr() gate is not used here because nr_bvec
+	 * is a raw page count that overstates DMA entry demand -- the bvec
+	 * caller has no post-DMA-coalescing segment count, and feeding the
+	 * inflated count into the MR path exhausts the pool on RDMA READs.
 	 */
-	if (rdma_rw_io_needs_mr(dev, port_num, dir, nr_bvec))
-		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvecs,
-						nr_bvec, &iter, remote_addr,
-						rkey, dir);
-
 	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvecs, nr_bvec, &iter,
 			remote_addr, rkey, dir);
 }
-- 
2.52.0


