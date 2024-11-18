Return-Path: <linux-nfs+bounces-8070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683439D1A6A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D887EB21CA6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0E178395;
	Mon, 18 Nov 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwT75Wc0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CB15D5B7;
	Mon, 18 Nov 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964845; cv=none; b=DmZlgNTH/NTZWv+XwUL7lF3wtxxDGTjZWATLKaFLtbS70s8au81WvvsI4klmLTr175pN4ma7yNiclcTTIj1x8jRZQL90lruLVlMHOnmJQ/DOw6XtOx68zKQ0KBBeEWCKHCznOKGRRLm9thxz5kbkC2fXiwWo3Onpvt6CidW77zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964845; c=relaxed/simple;
	bh=MmNZW2BO6/hZLJY2y2H8eprKc3nS4nEdDPVPe3ok95Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN/dZGiTLMf0ZSQWIif0gi3hq8jC9tAZGyMxo5t5dZLC/HGm/igOQNysHXpJqHX3qD8tj6oniwx4B5rxYveBWvefsdNOXg7MaShKcpck+6sziSTZ19LZxfVrJ7npjNujXNvG0z50H065W0oC/kCqiku1Ak+fzjtAf0c7M+XT3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwT75Wc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B30C4CEDB;
	Mon, 18 Nov 2024 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964844;
	bh=MmNZW2BO6/hZLJY2y2H8eprKc3nS4nEdDPVPe3ok95Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PwT75Wc0HGYh2fTs/ykDG05ui1mSvLVFNqIypM62kMRZfmqSLlaEufSN78kTSOGSX
	 VhHx2R6oO3+mWNtdQL1d7ck0NfG7P/EIzcXwAZuV2/dGbm05iGtwbhLU8zuccx3Ct5
	 KfiC6D1eINYJbLy9CosHKqDncDbEpuc9ZyhRSycsYo9Ulz84C7aTX/4HId0EkKtmNE
	 TZyEg2VXSku3tG4JNBVRJjFUlwmJzpo+6eKHGKkfOMp3OmpLDmoqGYD55FHQeIPp1r
	 R/Anu4oEWv66Qj9StCqvGX2UVP/lPKdCpGevBReOWVIFbMcdwqDOvF+pllds9MPnPR
	 pUbKdnqJ+YiQg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 5.15 5/5] NFSD: Never decrement pending_async_copies on error
Date: Mon, 18 Nov 2024 16:20:21 -0500
Message-ID: <20241118212035.3848-10-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 8286f8b622990194207df9ab852e0f87c60d35e9 ]

The error flow in nfsd4_copy() calls cleanup_async_copy(), which
already decrements nn->pending_async_copies.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6267a41092ae..0b698e25826f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1791,10 +1791,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		refcount_set(&async_copy->refcount, 1);
 		/* Arbitrary cap on number of pending async copy operations */
 		if (atomic_inc_return(&nn->pending_async_copies) >
-				(int)rqstp->rq_pool->sp_nrthreads) {
-			atomic_dec(&nn->pending_async_copies);
+				(int)rqstp->rq_pool->sp_nrthreads)
 			goto out_err;
-		}
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
 			goto out_err;
-- 
2.47.0


