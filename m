Return-Path: <linux-nfs+bounces-482-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D680CF5E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3984B21018
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FF84AF78;
	Mon, 11 Dec 2023 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIUvV22K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76303B184;
	Mon, 11 Dec 2023 15:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E249C433C7;
	Mon, 11 Dec 2023 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308243;
	bh=l/lZQDrBjfmqVGnHnbpv7lJzJFSf5AE1xC6CokFuDL0=;
	h=Subject:From:To:Cc:Date:From;
	b=vIUvV22KEG/OgyxxdHcv8QyBowKyvQW4kgwB9s6o0gVQU7kB3FVMJCvMC4HWQGRpH
	 zN3UVsK78BH4T1gDmQFp3npYM093XI6Er/ykGGnxXEOEDS4iYD3U+xL+ROj1fkil2m
	 GZfsJh6yJVsGOG3gMcBtCen2R0ZcJ92p34j3hWvLCRuS5XV4SHKx6tnj3tkrnhsB0i
	 i5cWU7bmGX0LeEsy3+1hu/oi17iKmLXpXbrPOdDC/QpmBUWPxyy8XCEw8LpJZYzyW3
	 OMx7vDS/f1YCW5ivpXQUlIejOQ5ZRnmHNRxtbLyCXgbgUrw9+F8JlTB1KnMiObTjNf
	 KgrimwRAQyEvA==
Subject: [PATCH v1 0/8] More svcrdma improvements
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:02 -0500
Message-ID: 
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

Here are some clean-ups and minor optimizations for svcrdma, in
addition to two patches that reduce the likelihood of connection
loss on heavy workloads (the final two patches in the series).

svcrdma appears to under-allocate Send Queue resources, which will
cause NFSD to drop the connection occasionally. This results in a
burp in the Send pipeline and a loss of throughput.

The series (including these patches) is in the svcrdma-next branch
of:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

---

Chuck Lever (8):
      svcrdma: De-duplicate completion ID initialization helpers
      svcrdma: Optimize svc_rdma_cc_init()
      svcrdma: Remove pointer addresses shown in dprintk()
      svcrdma: Remove queue-shortening warnings
      svcrdma: Clean up comment in svc_rdma_accept()
      svcrdma: Reserve an extra WQE for ib_drain_rq()
      svcrdma: Use all allocated Send Queue entries
      svcrdma: Increase the per-transport rw_ctx count


 include/linux/sunrpc/svc_rdma.h          | 24 ++++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  9 +--
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 16 ++---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |  9 +--
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 75 ++++++++++++++----------
 5 files changed, 74 insertions(+), 59 deletions(-)

--
Chuck Lever


