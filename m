Return-Path: <linux-nfs+bounces-17869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16598D1F82F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D9953009F60
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EBB2D9EC5;
	Wed, 14 Jan 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxuUmLiK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627B281370;
	Wed, 14 Jan 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401592; cv=none; b=i2YZMcteB7ZQMj374N4xHVxuypv+6JSBPa+/EIvDi/qlBV09QLLQwLPeWd+JilcbPuHzoj6rIqQXX8vjQKZzkJUTX9NHvSjX50kFP8J4nv776zt44SoCod7NVIy2k2HLa571uNPg0P4deew2Wx1AGxx1xTLoQdWzn7IPOuZzWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401592; c=relaxed/simple;
	bh=xISc6GTe42eREw7iKp8xKdCYkdpIagRgDsqjCQjppKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMcq1EkiWW876+PiwFcKQ/B+L/Mma6aDbgLPI+CZZZJ/1TSw8jyJH9LPgAR+7TrW+Y/enPHHBOyx9Ylt8VEpNMcDoGaHWxIDwIRr+cfxlUcGHkKm8weKEI43pCWIotA6HRED1pcN2LZUhAkRPAKsb7nUKkrRhqrKPfE9Xl66BXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxuUmLiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80400C4CEF7;
	Wed, 14 Jan 2026 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768401592;
	bh=xISc6GTe42eREw7iKp8xKdCYkdpIagRgDsqjCQjppKo=;
	h=From:To:Cc:Subject:Date:From;
	b=oxuUmLiKPuM76hPci3qm7Gi0gnA7Kq1i3rfgYcU08T2hYGuXTeGyP5S0bM9ckh5Dl
	 hsW10zxg9BST1MbKV2pDQf/SUvlyDAybdfWqKWn40ffdSivu7p0aEpZZd0cRz2CXUg
	 w50zVyxiGbccXz6Yb+3PImJnMHjJ4nKSlnaIelhPSwszYxaJ5KC4yYcJjdq++P8ilO
	 PCxHoaaMPY3rTviuSDzz16I9NWo8Z8WtmJF4KR10r98z1tnsZKlkyn29Zh2JDVrUQ2
	 ucPyRFqMlx7qlIE+r5HjJBooORPoMnUsy1DE/hlDdSIkpMeixE6XcGjq/KUa3eOyKD
	 L9wpmCfGHSfKg==
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
Subject: [PATCH v1 0/4] Add a bio_vec based API to core/rw.c
Date: Wed, 14 Jan 2026 09:39:44 -0500
Message-ID: <20260114143948.3946615-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
It replaces its scatterlist conversion code, significantly reducing
the svc_rdma_rw_ctxt structure size. The previous implementation
embedded a scatterlist array of RPCSVC_MAXPAGES entries (4KB or
more per context); the new implementation uses a pointer to a
dynamically allocated bvec array.

Based on v6.19-rc5.

Chuck Lever (4):
  RDMA/core: add bio_vec based RDMA read/write API
  RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
  RDMA/core: add MR support for bvec-based RDMA operations
  svcrdma: use bvec-based RDMA read/write API

 drivers/infiniband/core/rw.c      | 492 ++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h           |  35 +++
 include/rdma/rw.h                 |  26 ++
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 115 ++++---
 4 files changed, 608 insertions(+), 60 deletions(-)

-- 
2.52.0


