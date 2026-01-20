Return-Path: <linux-nfs+bounces-18194-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCcILTodcWmodQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18194-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 19:38:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 770055B606
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 19:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44A6C781BF5
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E444449EAE;
	Tue, 20 Jan 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0kjyW6g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADC4418EB;
	Tue, 20 Jan 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919489; cv=none; b=l1Z/Jo/jo8USVZ3tRoKwoY6Wze1Q4lvPYY3VhNyVt6QDQ0EnJrnT/KqkMfO+R6g2hwwLqVaMXnBS77UamYRAsMC8ashgkLzUQsSdAMIvH4IysTXbf2iNxOLMQr1HSoVmhVcuECpgc1K9ykEKLfkItnUOiaPHnzpHdfh0PDmYpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919489; c=relaxed/simple;
	bh=yWe2BiAKmz1nnP+ELvTTO/qvhoUwBLk1saPmV7jBgmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGI389qSRVmKQWivJdeBmqHFPUOQnKamI4i1D21GPDbdvP1N41sfEe+UnmExfnVSkkv2hICDhjogcLz1ZSB6jnP7POlsCRYcl+cM8n88M9im56xMgbzcmkk55YRE5e60ctL1d2gyPssomWFBIs7mndV+Jvppi9uZRTw1VOKwQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0kjyW6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5447C16AAE;
	Tue, 20 Jan 2026 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919488;
	bh=yWe2BiAKmz1nnP+ELvTTO/qvhoUwBLk1saPmV7jBgmA=;
	h=From:To:Cc:Subject:Date:From;
	b=m0kjyW6gRdBJr8dpzKP3BqDIOSmIP15IkWuwG0z8y6UHtdmeuXQSn8n+C01uUcrMx
	 L6CpFzRy8taZXwhkn6AHML9BqZka+Pm+lnnc6ciZ/m48gK1+Y6GKMUne6aOQi1tr94
	 iisX44WCrzHz3LAuJ98ds/JUfRDu2mtkdxXG8m1tLVMmyNHF9mS7fxi8xw8NSprGVH
	 eqZH/23TyIgihjHic5TVW9tHneUHO2ofL85CHS//amj+TwOByCk89s4jG4DJrU5Jfm
	 5VPRkL9VzQnlU9XQKlud54iikf9akMSX3UOTfl/Z6SvYJ6Smk/LxMxIJNprKK271bR
	 XONU/ouAW5C+g==
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
Subject: [PATCH v2 0/4] Add a bio_vec based API to core/rw.c
Date: Tue, 20 Jan 2026 09:31:20 -0500
Message-ID: <20260120143124.1822121-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[28];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18194-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 770055B606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Changes since v1:
- Simplify rw.c by using bvec iters internally
- IOVA mapping produces a contiguous DMA address range
- Clarify the comment that documents struct svc_rdma_rw_ctxt
- svcrdma now uses pre-allocated bio_vec arrays

Chuck Lever (4):
  RDMA/core: add bio_vec based RDMA read/write API
  RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
  RDMA/core: add MR support for bvec-based RDMA operations
  svcrdma: use bvec-based RDMA read/write API

 drivers/infiniband/core/rw.c      | 463 ++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h           |  42 +++
 include/rdma/rw.h                 |  26 ++
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 136 +++++----
 4 files changed, 605 insertions(+), 62 deletions(-)

-- 
2.52.0


