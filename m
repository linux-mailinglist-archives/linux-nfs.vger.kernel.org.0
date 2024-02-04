Return-Path: <linux-nfs+bounces-1755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262AC849180
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D601E282518
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD85881E;
	Sun,  4 Feb 2024 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc0IUMvV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7ADDB2;
	Sun,  4 Feb 2024 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088618; cv=none; b=B8POd+fUi92Q1F+T5yVcs+BOy5YX2XCESSpducwkzcPwwh20bIPzleS3fWv3JZHZsZTxd+oZ8aGe1XWcYOqmy2B7edWwdVGc2UUUvD2qt+Hsp+Aa1+Gt0iLcwl8ot6llNbInxLqafns5DQrroi0r/zQYDm/S8vtxI1IFnFXEU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088618; c=relaxed/simple;
	bh=+V9dSTnar5Zbg2d9qB3pTwMQy1aH5p5NMLsE+cUSjSw=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dix5Upjb69Tf3a03CfAeQnzf9qoyHV9PJAnJBY38pLHMK4+w34mIV5+vEU/y1+xYmfQYdZpHrq/HU7UK4kR/CLg/uMkvzhR84L8NyfDxODLTuozf2GHdJv0UaEgPJnuf2jsuz99ovVRty+6habm5Inrub8ZzLkumVJiL4DK9sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc0IUMvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C52C433C7;
	Sun,  4 Feb 2024 23:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088618;
	bh=+V9dSTnar5Zbg2d9qB3pTwMQy1aH5p5NMLsE+cUSjSw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Cc0IUMvVz4uDtfTNW7ITk0Im4g2H4o8cwHMHYwy+la43eePM5s4QNhgtdfzLQ66bx
	 wH7sDhiR8yT0gFEUFkS2QrY+Gz5CvM2kTeY2GRR2qG7dWt2SA02zH04ZP+4khLbBAZ
	 7amgAbkAE8X7Y/733KINY4lFLmOWwfY8ITF9zHLtKNc6yQ+1bFUYd0kN2o97lh8FpX
	 ueEb5xD5KmtZPqmBGyn23wWx/58NHh75OlOxAo5CUtJTv786JVdy9p2bMYnJMQODmN
	 /qgiVIogXxV/WHB7BjPoWzkD21ZDp8tA7gX55UmhF0YaeiZcnBrpuyk6h6T4G0iVCG
	 CUigivrIca2pw==
Subject: [PATCH v2 04/12] svcrdma: Increase the per-transport rw_ctx count
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:16:56 -0500
Message-ID: 
 <170708861688.28128.16380294131274226696.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
References: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
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
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 839c0e80e5cd..2b1c16b9547d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -422,8 +422,13 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		newxprt->sc_max_requests = rq_depth - 2;
 		newxprt->sc_max_bc_requests = 2;
 	}
-	ctxts = rdma_rw_mr_factor(dev, newxprt->sc_port_num, RPCSVC_MAXPAGES);
-	ctxts *= newxprt->sc_max_requests;
+
+	/* Arbitrarily estimate the number of rw_ctxs needed for
+	 * this transport. This is enough rw_ctxs to make forward
+	 * progress even if the client is using one rkey per page
+	 * in each Read chunk.
+	 */
+	ctxts = 3 * RPCSVC_MAXPAGES;
 	newxprt->sc_sq_depth = rq_depth + ctxts;
 	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
 		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;



