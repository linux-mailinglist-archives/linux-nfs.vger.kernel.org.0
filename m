Return-Path: <linux-nfs+bounces-8086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2286C9D1A8E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD28D280EFF
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D31E7C3A;
	Mon, 18 Nov 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VarhFoo+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F61E5722;
	Mon, 18 Nov 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965030; cv=none; b=FypkAYIQ1cCFXq6afbNTmoj9uDAwrQff7timhxXvwqR14x8yI4O+f/i0QWod0p6Z5r4Iv9nfIcHSRrnpDvUwDn1s/6M7qT1z4hiE92wvvCY6GgtDccjdvg77PbSQLFLrUTEatmHEScm4KrmwAOBH2ZuaUURWrNvvyOrNaHRnhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965030; c=relaxed/simple;
	bh=MmNZW2BO6/hZLJY2y2H8eprKc3nS4nEdDPVPe3ok95Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUCuWITOZX+K4PB7LazHlBDY2sifRXuz+XML5SOoc/TXDDDFom0GFvNv9N6Je1D1b0GbqC4aAnmVHvmi0MB+TciApERxSIam0w5r+9HgCX1I/zdvMIsyKIvL9VFmrHvW+oR0Y8J5O5Hdb73WcqEBRkHPTqHfJGys505sgxfOYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VarhFoo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FAEC4CECF;
	Mon, 18 Nov 2024 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731965029;
	bh=MmNZW2BO6/hZLJY2y2H8eprKc3nS4nEdDPVPe3ok95Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VarhFoo+bD8EV4vtfjsTHb0hnuw4tCK+DmR3lb9c/HeiGKg6BWpsdPbFJtWY94LOP
	 F5z6NYHv7PtcxG2QcP7Dw3C/eK9thRLNkmGC3TR+V1IpjmL6czqFU3xaNcESMVLk8z
	 V8OIrSheu4sAvxM+yJjhsx4laFjvwZFwo04Y5yVbEKwmHaxrTtyfE1LyqnFToGUzqs
	 O5dtXpFO8mnOljyQegW4eZvIfBMWDoLAtXvwAMc/Psp7T/O6AaTHFF/bn8ovakHfE1
	 JragYNmIxGHKhVlFW35C0G1nnlfguHYQHyimhVMuwin4o8y/YyEHNtNZB3DVdGIfQP
	 BFVpIA/VWyhZA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 5.15 5/5] NFSD: Never decrement pending_async_copies on error
Date: Mon, 18 Nov 2024 16:23:43 -0500
Message-ID: <20241118212343.3935-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212343.3935-1-cel@kernel.org>
References: <20241118212343.3935-1-cel@kernel.org>
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


