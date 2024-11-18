Return-Path: <linux-nfs+bounces-8085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435929D1A8D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE238B232E9
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7C1E7C26;
	Mon, 18 Nov 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFG9dEM8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA0155C94;
	Mon, 18 Nov 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965029; cv=none; b=nkcMTjYxxeV5yZWsYb9R88yGExGTHrEn7y3AXhcctPuKMf+3YlwkNZOZL2M4SmQ38zPwsLprE4iS4fwOnfFrxD7+p82rA4IV8ENNTsDAmGwTXxB0Sx/knZPB5P1ZrqEiQ2J/u2k3+hk7yk6dialrZKZfc+a4oE3ite2YrYk1V0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965029; c=relaxed/simple;
	bh=L/5WbSn0Hcf4WWyoyklgYacsCyDIHh4RMBF1geAQ6hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKC/oIzC2QtUygD2uLJnSQ7sLTdID9/nRXrCjh9C5EEmu43fkBut33GRORbH2vHI3UDOYA5uUgSmJdNPRkLimo77w5cDHvxMZG62fa5NNqHjj/xFPeseFDiWZC9Aq0zfIY4dC89igm59FAHR3gRAyl2jlGloF2aIfb8uBMo46IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFG9dEM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECB8C4CEDB;
	Mon, 18 Nov 2024 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731965029;
	bh=L/5WbSn0Hcf4WWyoyklgYacsCyDIHh4RMBF1geAQ6hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFG9dEM8I5f5nL7aEdgzMEQzAHCJJtDvomGrLk2w8xdtQbfHVSx187l7gyKPnJmaW
	 sZkbSmofYBv/pbGf+UKgiTiOZ5VOzkufCIjbhH0IR8uDoD/S3BMsgnwCniU8N+2wIK
	 ReyAZ7N+aPRX03xxqPumuhxdWyFeJ8DuIKb6yxxgE3j+sZc8yQ0P7UKFA25OHnE+75
	 exHiMH7hiSvao/2rzvHBAy/Wv9wg37M9ldTl43gefo1xVSQ6rhOETl4/QoPqIFER6Z
	 lm7fYCi8W0fid8guwyyUcn2+JXrTA202/AFewjvbNvzS5Ny+679NdVLMfgARaHZXus
	 86q8t1vLwIp+Q==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 5.15 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Mon, 18 Nov 2024 16:23:42 -0500
Message-ID: <20241118212343.3935-5-cel@kernel.org>
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

[ Upstream commit 63fab04cbd0f96191b6e5beedc3b643b01c15889 ]

Ensure the refcount and async_copies fields are initialized early.
cleanup_async_copy() will reference these fields if an error occurs
in nfsd4_copy(). If they are not correctly initialized, at the very
least, a refcount underflow occurs.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 54f43501fed9..6267a41092ae 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1787,14 +1787,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!async_copy)
 			goto out_err;
 		async_copy->cp_nn = nn;
+		INIT_LIST_HEAD(&async_copy->copies);
+		refcount_set(&async_copy->refcount, 1);
 		/* Arbitrary cap on number of pending async copy operations */
 		if (atomic_inc_return(&nn->pending_async_copies) >
 				(int)rqstp->rq_pool->sp_nrthreads) {
 			atomic_dec(&nn->pending_async_copies);
 			goto out_err;
 		}
-		INIT_LIST_HEAD(&async_copy->copies);
-		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
 			goto out_err;
-- 
2.47.0


