Return-Path: <linux-nfs+bounces-1551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD98408EF
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A146B22291
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C011487DA;
	Mon, 29 Jan 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFRmNkMd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F4657DB;
	Mon, 29 Jan 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539832; cv=none; b=AJ73yaaeGwpdz6ARlu85oUcuGOUB6yY3d5rAnR1XEwpiMInBOHUmtlHjL+Ot/+f1K3/pJMWS7Lr8iIKT1jaTWSTDXyHVnEdeLvCAblLVUt01K+vNgXQK9iacj1B1bwMdKMQbD9dTVVtao5eXFJipsSv3vGQSO7FcnjEDb1j3PVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539832; c=relaxed/simple;
	bh=WR7CaSkWa+MpjiMPr9rAAIPRit8J5SbzTCIEV1+UMZs=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=grjRAtGNEU/H9slG3BrAfJz7ujujpgxUvq5CrH/x9o4P/QHUJId9T4Bw5RpNHTgiwfLtMUHCr/nId2CwVObGW9KyZBnRKYPoxfvJZbHKAYlPPF8ZYsfEXaMdcpRjgUKsEi9Jodbna/FvQug2/6RbQ7M7S/5PrE/Eh07p3mEasTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFRmNkMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6142C433C7;
	Mon, 29 Jan 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539832;
	bh=WR7CaSkWa+MpjiMPr9rAAIPRit8J5SbzTCIEV1+UMZs=;
	h=Subject:From:To:Date:From;
	b=YFRmNkMd26rAlCknJmrhcwXi7HP0cgPUkgQ+yumV4QQOZzNv6nS96hTVRuejN/Ak/
	 4F1EBKZXO5iHSBzz/DQ3kDEn+tO5FqWNukcOfrLucqUZqPkn7+uwF1o1JPdQk0iBV+
	 +/x4OVaaz+dcBeHIfVDld2EUoYnMiiYgKig/OVpu6leeRZ8vVy+IyaZVuGtbwXM0BC
	 OvJiM/oK4rIqEPjaUs8H0k0noI4BC/attOyAPnWj8irGS5+46FXJFs6/qKqAcnam9e
	 88i5gpf0988hbuYYf2CS/OvPZc7RyBJ7HxZ91WMW06ais1ch6dz3YY6eLiuPTf6bGt
	 Wg1Mu6cddUecw==
Subject: [PATCH v1 00/11] NFSD RDMA transport improvements
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:50:30 -0500
Message-ID: 
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

These were left over from the last series (for 6.8).

The idea here is to post all work needed for sending one Reply with
just a single ib_post_send() -- the Send WR and all Write WRs are
chained together.

The purpose of that is to reduce the number of doorbells and
completions per RPC, which will hopefully improve transport
scalability.

---

Chuck Lever (11):
      svcrdma: Reserve an extra WQE for ib_drain_rq()
      svcrdma: Use all allocated Send Queue entries
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
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  46 ++--
 6 files changed, 338 insertions(+), 165 deletions(-)

--
Chuck Lever


