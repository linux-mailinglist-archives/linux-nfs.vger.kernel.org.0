Return-Path: <linux-nfs+bounces-8054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266439D1A3E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E160C28226B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF91E7C3A;
	Mon, 18 Nov 2024 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZB7+L6g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE617BA3;
	Mon, 18 Nov 2024 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964460; cv=none; b=D7o6n6L7QvylmI476NHPaDp8Y1HAjBtRC8eiyBVRLJOuCTRfm/y0LPE89z8W7O2JIpo3Cg+84v51a7gk7JVXF8a04th+UmcnIZMPYpNZBOXbUXMFjjO53r5VIZV/FLqPPSZ45Ne2F3h3pqNUVZdS2FFKiAT3zP8lDEhsevQ844I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964460; c=relaxed/simple;
	bh=ZWZJ0ABGP0mdbLIUchEG7glZC0kVTlkhV5EGD/OI6mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyG8mq2jt3TB/EhtHDHBtVrvFGp4PjeKbBE5kf2ezWUUp0AAvpqUs7ESPd1FgrNsIuILma4SS5sCgSKiI0/864Lx7ImPV3eq4CPKCXWWzgeFRrOqTj/AWtkRap/oOBsfd6qi39thmJGYRbBVpxonDKM7Qo4uNcCRiXXHnbeYjtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZB7+L6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6D8C4CED6;
	Mon, 18 Nov 2024 21:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964460;
	bh=ZWZJ0ABGP0mdbLIUchEG7glZC0kVTlkhV5EGD/OI6mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZB7+L6gWFUzgpfNfNAsr3rlM9Z7SHp5a+SHQ4vnoB+Z33smoZtyLfn+DjKnssWoE
	 KhQ5dUrIKqPkuNN8dUm4Uc3q3R9aCVCcXj0g4jxkR4LIXNOvz0kw8HC8RxUd+E5tV9
	 mOvvWhbH3Glq7tK0GNcLQGboVjAaVUrug4k3Ar9p8T5SkwEWl9XiBSWjw3mZUYWD5B
	 dS/nmyrDwScKSn6m8aeo0q18OHNo59B8ppP/fSapQd2C6bC9arqxcg+9nk2784/POG
	 /0fI+HNk2i+IwnwqgvCVscMmUo+c5XtEyUTzMGANIFHoq0kFH8EomEGXuezILvPeqk
	 FAXJXey3+/L/g==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 6.6 5/5] NFSD: Never decrement pending_async_copies on error
Date: Mon, 18 Nov 2024 16:14:13 -0500
Message-ID: <20241118211413.3756-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118211413.3756-1-cel@kernel.org>
References: <20241118211413.3756-1-cel@kernel.org>
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
index 444f68ade80c..d64f792964e1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1820,10 +1820,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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


