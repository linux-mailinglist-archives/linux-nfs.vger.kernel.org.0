Return-Path: <linux-nfs+bounces-699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F81817D3D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 23:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A80B1C22AD6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D4129EFB;
	Mon, 18 Dec 2023 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNVKXfmC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9D1DFC1;
	Mon, 18 Dec 2023 22:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CDBC433C7;
	Mon, 18 Dec 2023 22:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938702;
	bh=3LgK3enpU/ETsSDkGpEPMOM8mfdkEA5i46IzdazB8QY=;
	h=Subject:From:To:Cc:Date:From;
	b=aNVKXfmCX1jkLQpMlcf1I2pJarQbLxMSINnobFbboKWxn0uykV7rox99tWkCXx2j3
	 /52jYAan1xgYdYZO57JGXYSCNrXY9ACT5IOODN+9IIdRIl0C97SOgqaUqY+SY7dstO
	 5fdH+Gv27KIe3IJnvMuCS97O2jXsK1ljR+E46rbY12Y5LhgMBdP9iUOqzXiH04SugV
	 ZnD4oxCuRPyCZsanNMGs4ahzBN7lRSw5lmKo3K9HZRHTbNlMrUaQ1hd4wr3EHopmya
	 hAPvELy6OpBFwx3yUlcBSWjFjUKCMcG1dalnKkXSPLpHE4/rWB1DL7q2Tbba3IOKVF
	 ofwpXmSZviDAg==
Subject: [PATCH v1 0/4] svcrdma: Go back to multi-staged RDMA Reads
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 18 Dec 2023 17:31:41 -0500
Message-ID: 
 <170293795877.4604.12721267378032407419.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In 2020, commit 7d81ee8722d6 ("svcrdma: Single-stage RDMA Read")
changed svcrdma's Read chunk handler to wait, in nfsd thread
context, for the completion of RDMA Reads from the client. The
thought was that fewer context switches should make for more
efficient Read chunk processing, since RDMA Read completion is
typically very fast.

What I neglected to observe at the time is that if a client should
stop responding to RDMA Read requests or the RDMA transport should
fail to convey them (say, due to congestion), the herd of waiting
nfsd threads could result in a denial-of-service. This is why the
original svcrdma design was multi-staged: the server schedules the
RDMA Reads and then the nfsd thread is released for other work; then
the Read completions wake up another nfsd thread to finish
assembling the incoming RPC.

This series of patches reverts commit 7d81ee8722d6 ("svcrdma:
Single-stage RDMA Read") by replacing the current single-stage Read
mechanism with a reimplementation of the original multi-stage
design.

Throughput and latency tests show a slight improvement with the new
handler.

---

Chuck Lever (4):
      svcrdma: Add back svc_rdma_recv_ctxt::rc_pages
      svcrdma: Add back svcxprt_rdma::sc_read_complete_q
      svcrdma: Copy construction of svc_rqst::rq_arg to rdma_read_complete()
      svcrdma: Implement multi-stage Read completion again


 include/linux/sunrpc/svc_rdma.h          |  11 +-
 include/trace/events/rpcrdma.h           |   1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 167 +++++++++++++++++++++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 149 +++++++-------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   1 +
 5 files changed, 217 insertions(+), 112 deletions(-)

--
Chuck Lever


