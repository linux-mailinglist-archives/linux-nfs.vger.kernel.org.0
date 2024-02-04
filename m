Return-Path: <linux-nfs+bounces-1751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA60E849175
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DB01C2098A
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651D51854;
	Sun,  4 Feb 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw/7+YxC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FABE49;
	Sun,  4 Feb 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088593; cv=none; b=KUKLc47ME6IgIDRGAGYSWpO5RGAjS9E/0Zv6ThS5jzkJztZ+zOPsK6o8bYpSLUF3J+twCjwH3CImPFlevXl93V2G1mI1kcD65hsux5k59KgUgHqVe+hKAVcdDlDZWk+nmZhjdyYaNlJNQA0inrQKZz8iRxmC2ZemUFR8G60LGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088593; c=relaxed/simple;
	bh=J0iCyXIUEO1xG/A9Vw8lE1Zj/zs71qQuhF9NxJexeJo=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=lum8BXQtz3ffFTBCTFd0esaodjGTkm2Qanjalw4wCDdUEbeJIcXURms5yEiK4U7XNAvL3a7TaEVunmRlaig9IBLWkVjJxf4JW5cJYBEEkvcqWIUFsSVrrjdd8lx3QclHcSVj3C2sUV02t3OWJxuMQkN1HfdRgqQUrg5O4gCCwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw/7+YxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9A3C433F1;
	Sun,  4 Feb 2024 23:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088592;
	bh=J0iCyXIUEO1xG/A9Vw8lE1Zj/zs71qQuhF9NxJexeJo=;
	h=Subject:From:To:Date:From;
	b=Sw/7+YxCtgu8zlKDIq3gQyy77A5PQluDAmpuhhLWTBQP4acROS3h3Vivi4PJ7mYvU
	 xgBRHxAWW3I6nDYxZsxcfYN2nCuBiduwVBkBMMZtg7gpLQpyKcugTfs4UdEQhWfA2z
	 g4HVc/gasknV7y/GxnOp/4r3DwLZ9JvVb2sT0DUxbRR99BLb6AP2p36Eewyl80cp35
	 VGNcyncqs7ZFWaZBqiCiaEE4gnqr8yB0p59MtU2voUON/qrpw/3y26SufxuW4RuW8M
	 +ikujxrO0nTlFpWzzhNt0Jib+Z8r5POTR2sPaWjjpegUHRFAe5stVmQrw8NFrNmX0N
	 q75SzroaDaKuA==
Subject: [PATCH v2 00/12] NFSD RDMA transport improvements
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:16:31 -0500
Message-ID: 
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

These were left over from the last series (for 6.8).

The idea here is to post all work needed for sending one Reply with
just a single ib_post_send() -- the Send WR and all Write WRs are
chained together.

The purpose of that is to reduce the number of doorbells and
completions per RPC, which will hopefully improve transport
scalability per NIC.

Changes since v1:
- CQ overrun crashes have been addressed

---

Chuck Lever (12):
      svcrdma: Reserve an extra WQE for ib_drain_rq()
      svcrdma: Report CQ depths in debugging output
      svcrdma: Update max_send_sges after QP is created
      svcrdma: Increase the per-transport rw_ctx count
      svcrdma: Fix SQ wake-ups
      svcrdma: Prevent a UAF in svc_rdma_send()
      svcrdma: Fix retry loop in svc_rdma_send()
      svcrdma: Post Send WR chain
      svcrdma: Move write_info for Reply chunks into struct svc_rdma_send_ctxt
      svcrdma: Post the Reply chunk and Send WR together
      svcrdma: Post WRs for Write chunks in svc_rdma_sendto()
      svcrdma: Add Write chunk WRs to the RPC's Send WR chain


 include/linux/sunrpc/svc_rdma.h            |  55 ++++-
 include/trace/events/rpcrdma.h             |   4 +
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c          | 245 ++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 151 ++++++++-----
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  15 +-
 6 files changed, 320 insertions(+), 152 deletions(-)

--
Chuck Lever


