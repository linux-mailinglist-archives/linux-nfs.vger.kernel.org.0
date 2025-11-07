Return-Path: <linux-nfs+bounces-16176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF1C408BC
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15EE565051
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCFC32B993;
	Fri,  7 Nov 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR0srvfo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48352DFA46;
	Fri,  7 Nov 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528194; cv=none; b=lcAmTgFyJb30v8Oue4octHmsGYMAXL+y3hZj9S0I0G+BjVYiZJ79Ln94f3zKAloP48p3QaMGL49SrLgaq2ywM2RxLSlWpn3qE0IxPmDr5GbKpuDNk5JZDRzAwC0xN9yFY9BL6aNpGFk6ZcZ3BDcO7p/exf/Y3KHLzcWrXU8LKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528194; c=relaxed/simple;
	bh=xL7B0BSUN6mHT9AN8poxu8dlAZx5mx0OPi/a+IeTqT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQ9HSsdkL/eSvUp2PLfTIfRdWwZuRSP3vhoWvXLT0MtlgkORABOB65Zc0HFiS4oGs6ZntC7MWhRbreJ6Hc/7gQRLzTbnUtjeVxdRfEmTvIQ7OfK33LkzLllfunzulu09sWBQaGrb7UjHSunZaKCoNzU7+EGzGIdVr2mI0LsAW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR0srvfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E7CC4CEF8;
	Fri,  7 Nov 2025 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762528194;
	bh=xL7B0BSUN6mHT9AN8poxu8dlAZx5mx0OPi/a+IeTqT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QR0srvfo2liatRzyYfqY4ZrIgwMZVZq8CtfgVOg0JTZZjJr3nSazUeR5u29na1ZZm
	 tQ6/jgChANMcvGu5bulmUkfYn7P2QC3dqDH1Pnpl8nc8S7khwlrVuktigAEzBhlx9K
	 aHJa6H5yE5Ny64ygn6q4v8U5ksi2d5Gw36xvOcuz+Hol2OZjBlC7A/F6+HQxUFqMLj
	 jOeM+P5Pspb6+pAZF6xHXv7aCPVz3uuvjFps04ujRPwYB2++ItAbb6F+ES8pCfTV+m
	 k4HxS5zka4NLXLe9ymtWlwuMgfB/MIjVTX3iWP0/nMt65Jw/nfqFDPK5ZuwS5G2HyL
	 mxwmtn32hOZfw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joshua Rogers <linux@joshua.hu>
Subject: [PATCH 3/3] svcrdma: bound check rq_pages index in inline path
Date: Fri,  7 Nov 2025 10:09:49 -0500
Message-ID: <20251107150949.3808-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107150949.3808-1-cel@kernel.org>
References: <20251107150949.3808-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Rogers <linux@joshua.hu>

svc_rdma_copy_inline_range indexed rqstp->rq_pages[rc_curpage] without
verifying rc_curpage stays within the allocated page array. Add guards
before the first use and after advancing to a new page.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
X-Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index e813e5463352..310de7a80be5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -841,6 +841,9 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
+		if (head->rc_curpage >= rqstp->rq_maxpages)
+			return -EINVAL;
+
 		page_len = min_t(unsigned int, remaining,
 				 PAGE_SIZE - head->rc_pageoff);
 
-- 
2.51.0


