Return-Path: <linux-nfs+bounces-490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F780CF71
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A941C2130F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898014AF87;
	Mon, 11 Dec 2023 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMVQ+r4P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BD3B184;
	Mon, 11 Dec 2023 15:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BFCC433C7;
	Mon, 11 Dec 2023 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308294;
	bh=jdchVgDmsZtECwiFg6aF5OPF0Qz+GiqmuHEdpGSnXtE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LMVQ+r4PcRjJfACop+BPqRzcPR4AiDY7LSQeZNUzqHVZs0sFie/08jBpstRqYFJPz
	 rWYLIByCaMe6gUKdjkjkmBW4mFUngugfrVMf+ckcTcyzzojtikcVcFgWSYew4tZQd7
	 LbK9zq/fMoXi8vvC89qQ93w5IyQ9vK4VXmgec9Td8FBU5EDdtjdZ+fNt5rbFtQpWn9
	 LTWLH+xqQSC5+2WgJJzH8pDvGvS8ve+gNTVb0mk/K0yz2KL5IuRlbIJ3ER6Pk8Lk6C
	 y92m3icsxa3m57RHuELpCvRiRfriTdE7n67i/zg8O9Z/qPcl9rfYtyqvDbmRtRwSvM
	 sfOiDgNGKSuew==
Subject: [PATCH v1 8/8] svcrdma: Increase the per-transport rw_ctx count
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:53 -0500
Message-ID: 
 <170230829373.90242.11114271955743181616.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
References: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

rdma_rw_mr_factor() returns the smallest number of MRs needed to
move a particular number of pages. svcrdma currently asks for the
number of MRs needed to move RPCSVC_MAXPAGES (a little over one
megabyte), as that is the number of pages in the largest r/wsize
the server supports.

This call assumes that the client's NIC can bundle a full one
megabyte payload in a single rdma_segment. In fact, most NICs cannot
handle a full megabyte with a single rkey / rdma_segment. Clients
will typically split even a single Read chunk into many segments.

The server needs one MR to read each rdma_segment in a Read chunk,
and thus each one needs an rw_ctx.

svcrdma has been vastly underestimating the number of rw_ctxs needed
to handle 64 RPC requests with large Read chunks using small
rdma_segments.

Unfortunately there doesn't seem to be a good way to estimate this
number without knowing the client NIC's capabilities. Even then,
the client RPC/RDMA implementation is still free to split a chunk
into smaller segments (for example, it might be using physical
registration, which needs an rdma_segment per page).

The best we can do for now is choose a number that will guarantee
forward progress in the worst case (one page per segment).

At some later point, we could add some mechanisms to make this
much less of a problem:
- Add a core API to add more rw_ctxs to an already-established QP
- svcrdma could treat rw_ctx exhaustion as a temporary error and
  try again
- Limit the number of Reads in flight

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 790841864153..0ceb2817ca4d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -422,8 +422,12 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		newxprt->sc_max_bc_requests = 2;
 	}
 
-	ctxts = rdma_rw_mr_factor(dev, newxprt->sc_port_num, RPCSVC_MAXPAGES);
-	ctxts *= newxprt->sc_max_requests;
+	/* Arbitrarily estimate the number of rw_ctxs needed for
+	 * this transport. This is enough rw_ctxs to make forward
+	 * progress even if the client is using one rkey per page
+	 * in each Read chunk.
+	 */
+	ctxts = 3 * RPCSVC_MAXPAGES;
 
 	sq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests + 1;
 	if (sq_depth > dev->attrs.max_qp_wr)



