Return-Path: <linux-nfs+bounces-18481-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN49OVqvd2n2kAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18481-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:15:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB298C035
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05E8130095E1
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2334D912;
	Mon, 26 Jan 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnmNp3Ml"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A634D902;
	Mon, 26 Jan 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451258; cv=none; b=sddxC4No5jsO5dEI4iiGm/RvCKfcuaqmsqMOqbtD4g29gmj/Mt4UCexCuLjcRyj19Xhws1NwFkEw5RZqZNwv836Nd5z+R37dsYuwPoX0/OCwenAROXX4ax7k5ZQora2utbeJSag5Y1QsWIIk8UDKwNWBAmVjGjss/utrFajwKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451258; c=relaxed/simple;
	bh=rWf6tqPqWjreG0BCXURfCy/EfbbRFBi9s3cqFS1qkIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwrW6QwIohlL0QqjcQWE6hg3Gd1qdGfziBhri/yYIW5AsCxPOMu6Shm+XEEZSS1j5MohqFapuK3u51I+oU+83X6wMNCpDoTAOX7SQJ58eO8WTOlLIySj6lA78kCzCdk9/yaiWyu49WH6mfuuZGyObX5nYaoTZJNS5ESsg9Dp4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnmNp3Ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FFEC116C6;
	Mon, 26 Jan 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769451258;
	bh=rWf6tqPqWjreG0BCXURfCy/EfbbRFBi9s3cqFS1qkIc=;
	h=From:To:Cc:Subject:Date:From;
	b=dnmNp3MlnI7YbZuImPnJbZK0kuTYzyZk2uUINoWONdyI7ESDdttfsIvrveN8uzyaJ
	 d8Ssfjuti0JvaWQS0FIjrh69AhF+Ox0woz9lYxSr/K50qhas12nuT4NzxlWKpc0vdh
	 zb7GdodncTc0jf6SuSja/4kH0hIJPWeV/kigfNB7/UuuGrJCyB+RBzs2HdMmtRyw4B
	 tIk3uV9X6hdwFEuT17w1rsBsSvQDvR6N4LGITvykAm0XXvLhgHvDSh7iEUP3lGWMQj
	 8AoED6zoA3Leni2LKi4iNPtRNMIChbB38npnTf5LB4cYKaRzaSSVdlJ7mqbkfVv84U
	 N6TkSMFITBQog==
From: Chuck Lever <cel@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 0/5] Add a bio_vec based API to core/rw.c
Date: Mon, 26 Jan 2026 13:14:09 -0500
Message-ID: <20260126181414.105062-1-cel@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18481-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DB298C035
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

 drivers/infiniband/core/rw.c             | 594 ++++++++++++++++++++---
 drivers/infiniband/ulp/isert/ib_isert.c  |   4 +-
 drivers/nvme/target/rdma.c               |   4 +-
 include/rdma/ib_verbs.h                  |  42 ++
 include/rdma/rw.h                        |  36 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 155 +++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   8 +-
 7 files changed, 685 insertions(+), 158 deletions(-)

-- 
2.52.0


