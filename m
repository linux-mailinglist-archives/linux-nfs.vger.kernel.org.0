Return-Path: <linux-nfs+bounces-8060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F39D1A55
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151D11F22648
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2AF1E7C21;
	Mon, 18 Nov 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azCnNcSd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26805154BF0;
	Mon, 18 Nov 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964750; cv=none; b=gx81gTMFpJWRFCXuVdwQi2wNyDa83C2zzJN+FeNjppl7EMN2NQOkJ7MMq4wfeZ0ixo6gypLANzBZSMwW28+Gyycyq1WjvhK97Pe+0oRsA09hXpqyPjn10xTUITwnhGqSsbQMbCq8mDeaZY3qisL4JGRY96akX8LIljyTBbew8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964750; c=relaxed/simple;
	bh=orkCVnDzF+xiTY+kNNPi5W+1mEpUW/y9zbnJ6oIcvog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m57tuqRXetDtCYmzsjRAb2M39KgBKlKZ9mXI1QRc23feayLu0MnRsPzqrVoEhtIxvU1vDZF3d/n/n+k1BacTtbSBYpKkRJ61wYRRkAz6LO3GatiALMcHGRu79d75wAIr+qHpZosOKpiXjM36FJoVk6cXbjuP1/gm1pQw4YcJ5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azCnNcSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC6DC4CEDA;
	Mon, 18 Nov 2024 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964749;
	bh=orkCVnDzF+xiTY+kNNPi5W+1mEpUW/y9zbnJ6oIcvog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azCnNcSd9HbuoCNGsk6FrqlbSCAafaa+G9ySCu6bLC5wYb+p5OuQw905gpYWKxIDM
	 AcmBlBeMri4j17d2DPWObjat9Ch9vZj1KfotlBlWF8yqtgq1wpafLkI+pbcrQSwTOX
	 AmafCyMGrvSFz7NPkvQIGtBfwIBIdx5bTP4M/p7akWjYeTdxE8ovvGN+k/3DQID1ID
	 Pxamb26ca6mT/rqbHqq6FOFxhnW0Jw5KpgzDznNg+3o7k6Wjg1JdFTQaXKD6z467T+
	 zgf4J0WNl2/uCaqEYe5L8Iu7ss91QFfvd/rB89t6pYFdVI2QSjIwFmf0tXlheFjc4j
	 nZxAasyuUo8XA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 6.1 5/5] NFSD: Never decrement pending_async_copies on error
Date: Mon, 18 Nov 2024 16:19:00 -0500
Message-ID: <20241118211900.3808-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118211900.3808-1-cel@kernel.org>
References: <20241118211900.3808-1-cel@kernel.org>
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
index c0f13989bd24..0aebb2dc5776 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1790,10 +1790,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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


