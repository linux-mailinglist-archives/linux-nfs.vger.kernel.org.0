Return-Path: <linux-nfs+bounces-93-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B17FA677
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8561C20DCF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8BC36B10;
	Mon, 27 Nov 2023 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkW05zXw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802C36AEF;
	Mon, 27 Nov 2023 16:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2DAC433C7;
	Mon, 27 Nov 2023 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102798;
	bh=EOqcCQfZliiS74f+Ycyaitfy8h1UjS95IlstNOSi6U4=;
	h=Subject:From:To:Cc:Date:From;
	b=NkW05zXw/C1ROkovkoH2O7+KtdzEPuFbwdEyXAY9yq+XBEK8ttyxa86v6tzpRvC2t
	 oSKFL2la9M18G+olcic/aUJFWfPpBO4Y6g9m97AF4TptntTNyD0a/9wFOWBper2z+R
	 UEhoE97FtRPXDPuzo5hPHeJ7HHbdiWyetP2cMnOVQgtmwDWsYgdLwfHsjOVwE05UxA
	 G6tL0sM1vRp/1vpzN687vpSZ9I3/lxqsY0eNs+7K9WMSrt9lc2BHAogZflIaydICS9
	 102rpBIZkC+uliDdhx3B1WXCKVs/R+qNFZQe98A0ccm0aZjm1lh41wV3C67r34Jb6U
	 3NKZv1oFsNnPw==
Subject: [PATCH v1 0/5] svcrdma observability improvements
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Mon, 27 Nov 2023 11:33:17 -0500
Message-ID: 
 <170110267835.49524.14512830016966273991.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a little more information to RPC/RDMA transport trace points
to help better tie trace events together.

---

Chuck Lever (5):
      svcrdma: Add lockdep class keys for transport locks
      rpcrdma: Introduce a simple cid tracepoint class
      svcrdma: SQ error tracepoints should report completion IDs
      svcrdma: DMA error tracepoints should report completion IDs
      svcrdma: Update some svcrdma DMA-related tracepoints


 include/trace/events/rpcrdma.h           | 237 ++++++++++-------------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |  17 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |  18 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   6 +
 net/sunrpc/xprtrdma/verbs.c              |   2 +-
 6 files changed, 129 insertions(+), 153 deletions(-)

--
Chuck Lever


