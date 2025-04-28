Return-Path: <linux-nfs+bounces-11316-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F09A9F9A4
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519BA1A80064
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87A2973D1;
	Mon, 28 Apr 2025 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0eI87tU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B62973CF;
	Mon, 28 Apr 2025 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869027; cv=none; b=tIhCxrxPBoxbxqDdCvPVZemDf4cDK/KsBUeGFUvufNJ4j731WHy2VF6d0QuKa7I+wLqtgS3NdHlYLBrN7Tp9p7CY9/FZAwS0toYsEYLOzsD9Em8Ro70hs/JnCCr3pjkbcQ0IlM2tR8haoasqNYC4ruTUgUGcWzAf5caEVBkwZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869027; c=relaxed/simple;
	bh=jgyCFScjKBfc9We116pUE7C0JeJZUAz2Fh0WE2z7tmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptGo+inRqN11kCmqnsZJ8FLTY4lI14bLyBy9XxFEKy71AtgUWO5BI79Jh7BJWCETGgd+TfVjGaztvDxA5jwz+uH7RojAXUCn7EJpcGZfkEwJz+G+naNCdpUF5s2gabwkFxlrOv9S3o8ivVMoNxQJpAmg3S0oR6mmeMZX7iqJ5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0eI87tU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E4EC4CEEE;
	Mon, 28 Apr 2025 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869026;
	bh=jgyCFScjKBfc9We116pUE7C0JeJZUAz2Fh0WE2z7tmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0eI87tUKHryL8ETwhnqT/RDKLPFQ6AMxNndJBlZUD8kYU0Id3lcxAJNYqjThgKlC
	 o/dqRz4vaFHU/jygAs7HtLzTpO8+iNMfVil+cdINIbdye389SmWC7FTL9zsi8K/z/z
	 SPIfLLDSJpJ/5qS8oTu6fC9oIkGtuPvfMFaMAJOdz0+vCQOKhnDm+sNGJ6ETlbvgi8
	 znG1ZfKpRrTG3qTyp3fSNw+w3uVAFSzTLq+PAOEFkPdTGnMemf5trKP1i0Dd9W4JfQ
	 PkKxrNN82vQ0p6CqANxfH9zQVVVM3+f9zcTkbCybu8cbyEDLkl6bHfNIBmSFck2OXK
	 nhnHbq7tozAvg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts per-QP
Date: Mon, 28 Apr 2025 15:36:49 -0400
Message-ID: <20250428193702.5186-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

There is an upper bound on the number of rdma_rw contexts that can
be created per QP.

This invisible upper bound is because rdma_create_qp() adds one or
more additional SQEs for each ctxt that the ULP requests via
qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
the order of the sum of qp_attr.cap.max_send_wr and a factor times
qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
on whether MR operations are required before RDMA Reads.

This limit is not visible to RDMA consumers via dev->attrs. When the
limit is surpassed, QP creation fails with -ENOMEM. For example:

svcrdma's estimate of the number of rdma_rw contexts it needs is
three times the number of pages in RPCSVC_MAXPAGES. When MAXPAGES
is about 260, the internally-computed SQ length should be:

64 credits + 10 backlog + 3 * (3 * 260) = 2414

Which is well below the advertised qp_max_wr of 32768.

If RPCSVC_MAXPAGES is increased to 4MB, that's 1040 pages:

64 credits + 10 backlog + 3 * (3 * 1040) = 9434

However, QP creation fails. Dynamic printk for mlx5 shows:

calc_sq_size:618:(pid 1514): send queue size (9326 * 256 / 64 -> 65536) exceeds limits(32768)

Although 9326 is still far below qp_max_wr, QP creation still
fails.

Because the total SQ length calculation is opaque to RDMA consumers,
there doesn't seem to be much that can be done about this except for
consumers to try to keep the requested rdma_rw ctxt count low.

Fixes: 2da0f610e733 ("svcrdma: Increase the per-transport rw_ctx count")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 5940a56023d1..3d7f1413df02 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -406,12 +406,12 @@ static void svc_rdma_xprt_done(struct rpcrdma_notification *rn)
  */
 static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 {
+	unsigned int ctxts, rq_depth, maxpayload;
 	struct svcxprt_rdma *listen_rdma;
 	struct svcxprt_rdma *newxprt = NULL;
 	struct rdma_conn_param conn_param;
 	struct rpcrdma_connect_private pmsg;
 	struct ib_qp_init_attr qp_attr;
-	unsigned int ctxts, rq_depth;
 	struct ib_device *dev;
 	int ret = 0;
 	RPC_IFDEBUG(struct sockaddr *sap);
@@ -462,12 +462,14 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		newxprt->sc_max_bc_requests = 2;
 	}
 
-	/* Arbitrarily estimate the number of rw_ctxs needed for
-	 * this transport. This is enough rw_ctxs to make forward
-	 * progress even if the client is using one rkey per page
-	 * in each Read chunk.
+	/* Arbitrary estimate of the needed number of rdma_rw contexts.
 	 */
-	ctxts = 3 * RPCSVC_MAXPAGES;
+	maxpayload = min(xprt->xpt_server->sv_max_payload,
+			 RPCSVC_MAXPAYLOAD_RDMA);
+	ctxts = newxprt->sc_max_requests * 3 *
+		rdma_rw_mr_factor(dev, newxprt->sc_port_num,
+				  maxpayload >> PAGE_SHIFT);
+
 	newxprt->sc_sq_depth = rq_depth + ctxts;
 	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
 		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
-- 
2.49.0


