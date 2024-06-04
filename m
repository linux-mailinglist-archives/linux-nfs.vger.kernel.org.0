Return-Path: <linux-nfs+bounces-3545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 240868FBCBB
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DE8B20D88
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A99B644;
	Tue,  4 Jun 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOPvYei3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF560372
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530353; cv=none; b=OANde70IgEEXFKJtVhablX5BJ7iD7InQgWGg4p1F5n5AOhj+TSGk4YyuaQQl/hNBI2qJgA5MUp4pnDnKsY4qAvjUZu32d6p5FbZHMC5O6dIopQ1CHvKLB+RkBPDpMEH+UuWAnpMJYd+8De7TxdTnGEefGR0wY7PwgccaE+FY6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530353; c=relaxed/simple;
	bh=b8T/KpxbL3c6cIjs0UMpMzudI/Ts5eydQg/dvEh3ucc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CezIpEemYLAPdaKa5pTdd7CaS3Ta45yE3bq72HxTk170oVkoXMbxGo7bFc8RlNWRg48flfPsCN72u7Ia5x9X6bU6GNQmhuZ+omkzWLsVQvEirfJc5VbR6k4Zgny/q+eNSwkmP+e0/LqprhHWuRNFUJFDLLqaEah0bY2zPmLC6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOPvYei3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8FEC32782;
	Tue,  4 Jun 2024 19:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717530353;
	bh=b8T/KpxbL3c6cIjs0UMpMzudI/Ts5eydQg/dvEh3ucc=;
	h=From:To:Cc:Subject:Date:From;
	b=SOPvYei3kf+YrUlV68UJBH8uPjisUpJukqKSmeMvANUXE6899X7Yycd1ptHFrW1BF
	 JFq5dWLnvVDkD1GvUv4JUY9htOlUetuipsJkbW5/RNkWtzHyFgr978RUufDR2TYVbs
	 +UQ7OJHPdtreAsBXnU1UiJlZttYyKZeXOiFjQ9bfCMoAjxuNl1VgBL4nXYnE0fTVCM
	 g9DKEBzjgPB1/CodzcKaxUyAT9yJXwiuibP4eL8/oZyZ1pyQ9tzHKibhfbTrCD0AGP
	 co1GlRh+AroUiyEH8drlgWRB/OU/Bmijyv9ybfNxxHHInq/Jsy3yS4nMO5VP23lmGb
	 YdpuZFuGWHAGQ==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/5] xprtrdma: Fix rpcrdma_reqs_reset()
Date: Tue,  4 Jun 2024 15:45:23 -0400
Message-ID: <20240604194522.10390-6-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2623; i=chuck.lever@oracle.com; h=from:subject; bh=5KP9+eW8QKOVQ2hGYZ+vv0MHZUg2HKk/jOgZl24py5c=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmX27Sm6LFfb+EYI2/m3u+C63CSpXn3vN+Db2Om pB4Rc4PvZaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZl9u0gAKCRAzarMzb2Z/ lwBgEACO1bn/yfRywU0Dnd8NdVPyUJqtTZEcktLo4fKcZoWf6P4ArHw5FOOjPsmssLGEGpvu8A4 WcrE5MccK8Kbe3jzHp4YJz3vDHPxcNLtQfkFLxhJqlBpAkaoDCEo49ilogG7tiiQDsgDErdOzzx EnCXLpCJc+Qm1Qjs5ZHRd7vc+iTThmK1Jgbi171d2Uo559R+3Elroiu33mLv5NJ3YptxVuW4wdz eAETfyGD6u1nkJENwTEXdsAIT4kdeevMca/zm5Zn9rt0vtlNwerMewf6TUiIjA5/3HiZpfNo0V6 asBiVOXzrCMuWx1B+0emGOcaJhOEe4JEWcRvrPfPriqHUuaeiu3VbakDTCKaTSqtg5NohZJREcE 2GpBUAVlGE2JVepL7InIWhFN7ZRlxsl3/Gz50uhm3BH9M02xM3Mqu5YqYG77Oqrw+yr/AOznSLU rIzvyufdpGKTgPcyyTUl0536qOAOJchmOBUN/VRORaeh64QtOh04kTMjquloe/R0ayRlPP81V7b O/ci/UkHt4vVl4zxe+LSI5EfFhGZersq4BwxGrTnxBHw+umLM1nC61Qsk6X4hVufcOgjm24fwQz +xRIx07dm8LED4uLMNuARfMli2BpNClv1ALXZAXp2n9TJacb1UMDZTP+oLyw9SG0zqlB5eqA2m6 SU0Y2p98Nv4QinA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Avoid FastReg operations getting MW_BIND_ERR after a reconnect.

rpcrdma_reqs_reset() is called on transport tear-down to get each
rpcrdma_req back into a clean state.

MRs on req->rl_registered are waiting for a FastReg, are already
registered, or are waiting for invalidation. If the transport is
being torn down when reqs_reset() is called, the matching LocalInv
might never be posted. That leaves these MR registered /and/ on
req->rl_free_mrs, where they can be re-used for the next
connection.

Since xprtrdma does not keep specific track of the MR state, it's
not possible to know what state these MRs are in, so the only safe
thing to do is release them immediately.

Fixes: 5de55ce951a1 ("xprtrdma: Release in-flight MRs on disconnect")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |  3 ++-
 net/sunrpc/xprtrdma/verbs.c    | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index ffbf99894970..47f33bb7bff8 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -92,7 +92,8 @@ static void frwr_mr_put(struct rpcrdma_mr *mr)
 	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
 }
 
-/* frwr_reset - Place MRs back on the free list
+/**
+ * frwr_reset - Place MRs back on @req's free list
  * @req: request to reset
  *
  * Used after a failed marshal. For FRWR, this means the MRs
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 432557a553e7..a0b071089e15 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -897,6 +897,8 @@ static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt)
 
 static void rpcrdma_req_reset(struct rpcrdma_req *req)
 {
+	struct rpcrdma_mr *mr;
+
 	/* Credits are valid for only one connection */
 	req->rl_slot.rq_cong = 0;
 
@@ -906,7 +908,19 @@ static void rpcrdma_req_reset(struct rpcrdma_req *req)
 	rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
 	rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
 
-	frwr_reset(req);
+	/* The verbs consumer can't know the state of an MR on the
+	 * req->rl_registered list unless a successful completion
+	 * has occurred, so they cannot be re-used.
+	 */
+	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
+		struct rpcrdma_buffer *buf = &mr->mr_xprt->rx_buf;
+
+		spin_lock(&buf->rb_lock);
+		list_del(&mr->mr_all);
+		spin_unlock(&buf->rb_lock);
+
+		frwr_mr_release(mr);
+	}
 }
 
 /* ASSUMPTION: the rb_allreqs list is stable for the duration,
-- 
2.45.1


