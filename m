Return-Path: <linux-nfs+bounces-14911-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA8DBB41D8
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8F43A6EBB
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EAB54758;
	Thu,  2 Oct 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfVhW5LH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64541139E
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413656; cv=none; b=X58mTxo+Qqtp1iU/WDhg0uk7+K0KFp5X38aWR99fttvxFy46kC7nEl8NIfVkOnDBtusZqi/VRJr0lnjFgIYJJIXPbPtgpm2Uc3FOXUrDdz98DEiu67s7LrRogoweb6csPSrOKEs4UXZNt646cxn/z5EwzTiBR8qE2BXVU4b+Myc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413656; c=relaxed/simple;
	bh=KmUzweCAYyNUby8VdecNpjnzwqylOluyh9X9g90eTRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meyTEps5eOQ334dCBhBWmr5YKhsOWQGBeXFYbyAdM4Q5ajCqDnaINxJNL1C4iZy14X1RR9BqR5H6+2N3qUlK421h19AJ4SI8lBECcjzp4Cg9kAsnpFV9I4QlKUGSvx4khREJngX5yslkA56mnW3uAo+tfPgkLsPsoYmDpf/YGE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfVhW5LH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A68C4CEFA;
	Thu,  2 Oct 2025 14:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759413655;
	bh=KmUzweCAYyNUby8VdecNpjnzwqylOluyh9X9g90eTRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfVhW5LH5tsDp10D62aeVNi6kaN3pv1ljUgQ572lEKVss54t8mvc7qxGaIIUbIiuA
	 9UDFtjB71GJzjugQb4tKJtvvhPzF0icliFt7uh9LppsG3oAFSdpndwJV86ncIhsruy
	 mOTWI9WcxGOOkzL/VAl3wqFkq6s0RGO/2tz+3+PIFkMPH3cqLCEhvJPbaZNuGsgpFO
	 hA5AYh+3vanO+kN1pF4lsYQBDoGeyogOUrNrs4pxKXiuT+Lpnmw00OsH2AGhYB5g9p
	 dTzyz55UFanM6B+twwMM7Nyapg95zW4hK+dUBEst3kRB76MQa9Vno5j1nCeo85FY51
	 P50Fjp/9xGucw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2] svcrdma: Increase the server's default RPC/RDMA credit grant
Date: Thu,  2 Oct 2025 10:00:52 -0400
Message-ID: <20251002140052.15502-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002140052.15502-1-cel@kernel.org>
References: <20251002140052.15502-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The range of commits from commit e3274026e2ec ("SUNRPC: move all of
xprt handling into svc_xprt_handle()") to commit 15d39883ee7d
("SUNRPC: change the back-channel queue to lwq") enabled NFSD
performance to scale better as the number of nfsd threads is
increased. These commits were merged in v6.7.

Now that the nfsd thread count can scale to more threads, permit
individual clients to make more use of those threads. Increase the
RPC/RDMA per-connection credit grant from 64 to 128 -- same as the
Linux NFS client.

Simple single client fio-based benchmarking so far shows only
improvement, no regression.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v1:
* Patch description updates

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 22704c2e5b9b..57f4fd94166a 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -131,7 +131,7 @@ static inline struct svcxprt_rdma *svc_rdma_rqst_rdma(struct svc_rqst *rqstp)
  */
 enum {
 	RPCRDMA_LISTEN_BACKLOG	= 10,
-	RPCRDMA_MAX_REQUESTS	= 64,
+	RPCRDMA_MAX_REQUESTS	= 128,
 	RPCRDMA_MAX_BC_REQUESTS	= 2,
 };
 
-- 
2.51.0


