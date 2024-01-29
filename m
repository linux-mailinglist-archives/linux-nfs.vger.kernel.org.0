Return-Path: <linux-nfs+bounces-1554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE38408F4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFC1F279F8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83C151CF1;
	Mon, 29 Jan 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTxTJDMk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9376B5A7B3;
	Mon, 29 Jan 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539851; cv=none; b=nRj3Xb1tDcYXHTArO/ZFTzIvBsJpFLxjU8P1ekPFknyFI+HjXEG/cJLPjtwpQWmFS+xaDyFnEgqQLfwzXvCEj/AEDXZKXGLm0SW04YwiOO7etv4yj8uWPSGi/5s8dUVNS26pWNP1d4Z9ZYqEC5/sxYUOjZ+GQ56vzE3wdbhoqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539851; c=relaxed/simple;
	bh=gVzsndViawjI3Z7+06pFsOgnjbx9+SjTnMQiUA6UHdg=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOWm/rqAxobgF12aFAr6dYsMLNLLp17m7lI4bo+TepuPHbOR9eyRQ5qJfkVu0mLYZpi9s4y1N9ZSx0XiOl1MnXKai8F6IdJBy4e44148yOrWRukFqoMCChNEqd+t+0cETs9v3OGWv+RbS0IwqZjCok6o9P+SQiyR9VLFKpAzNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTxTJDMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AF8C43390;
	Mon, 29 Jan 2024 14:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539851;
	bh=gVzsndViawjI3Z7+06pFsOgnjbx9+SjTnMQiUA6UHdg=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=RTxTJDMk2xPUrx8WNqo+FHG9lqo4CEbXuPxSWJYN9dFHHIdvWNk09CdP1djuJSC8a
	 VIjNzJRZSk0SPrfGD3iHwvq5eYUpsFU6LxHF/oMe9tc3psBQ3zch4jpTE4fyJdst7h
	 pZU7I7i6UG6FxRDFKlcQr9ZievsllsADvY4F0zDS2qQFZFAjHn9tqBfahI0MVRzooL
	 jm57YKdIh7fj+Ebf98but3U97JCRi4tpO4gtSeCctWw1WnQ2vzMLRxcyABlg/3yzG9
	 ru4baB4XYVpi50mi/+Tz4+3dJAs5U0AicARRKoQJo8G/+kG7eVOl6tx22vCokkw3w5
	 a+cghO+ZyV6AQ==
Subject: [PATCH v1 03/11] svcrdma: Increase the per-transport rw_ctx count
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:50:50 -0500
Message-ID: 
 <170653985002.24162.17277374573743602302.stgit@manet.1015granger.net>
In-Reply-To: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
References: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
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
index 75f1481fbca0..57316afe62bf 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -424,8 +424,12 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	}
 	sq_depth = rq_depth;
 
-	ctxts = rdma_rw_mr_factor(dev, newxprt->sc_port_num, RPCSVC_MAXPAGES);
-	ctxts *= newxprt->sc_max_requests;
+	/* Arbitrarily estimate the number of rw_ctxs needed for
+	 * this transport. This is enough rw_ctxs to make forward
+	 * progress even if the client is using one rkey per page
+	 * in each Read chunk.
+	 */
+	ctxts = 3 * RPCSVC_MAXPAGES;
 
 	newxprt->sc_pd = ib_alloc_pd(dev, 0);
 	if (IS_ERR(newxprt->sc_pd)) {



