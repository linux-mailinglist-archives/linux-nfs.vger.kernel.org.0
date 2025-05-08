Return-Path: <linux-nfs+bounces-11609-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCBAB018D
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215343ABCE4
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7681328153C;
	Thu,  8 May 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEd2OohM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D0214234
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725868; cv=none; b=B4tpplxy8l7gzCWo6wn49OuuIWpIfnuJgrgag89c6tS+GQ02WQ/kt56MOniQrI8I9pL2Y7foSoXWRF5b8PDSzIaGv6edYTnCuNtEcczqrmeuCvX3/NyPnwZ70OLD5/gMCqpBKoWBKNa/VnCDrz8xhn/q+eI++mAnKGJv6mG49jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725868; c=relaxed/simple;
	bh=K3/g2iwRGJX3xkUR5858CkNzHUfivOTrWG/f7d+pYCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q37u66/7+iBl7SvscgnauDWRHarTZg7qDEK59fa4o6S7YKBBOnW8ETNUfUsuwVE7EiiT2HsSDe0BlCGwqLjZXAMDpWliLTy30yChtH9ZwTKLY1q/C3rVREiIVHBBa2Dv3PfvFP9g3nQQ7V3TcO4IDdo6vnnen5x1LEo2/8WurdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEd2OohM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A25C4CEF0;
	Thu,  8 May 2025 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725867;
	bh=K3/g2iwRGJX3xkUR5858CkNzHUfivOTrWG/f7d+pYCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEd2OohMyONVwFvnfHXZIkT2blDPr9s5mB9Nomw+qESdTfu4BreYJSZSShCnZhree
	 E4Ryt9Jy7Wbw28g8krU4VC7mhr8PhAbjYGxOSnvK9f1/D06EYdrf8ZnMt9Vx13upCz
	 2KCv9IEAMpHr/jEiFYt9RupjkQWsHv9ecGoqciAQ/ND7Q/BVufKtp1pRwopZCERprL
	 Xn9rFPBuRSeYeN6xHRBlmL2ZLjXkpSbzi5e/r1s2P/wmWYsZHXl7rTLMFVfSCtAag0
	 zWaV+BudiCnWR1lJ1i5vWVh8/Xcg/RASyCMpqkhT6Kq6gKxEi8TtV3C5VjvELIuS49
	 OcLJDEdkVh6QQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 6/6] SUNRPC: Remove svc_rqst :: rq_vec
Date: Thu,  8 May 2025 13:37:40 -0400
Message-ID: <20250508173740.5475-7-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508173740.5475-1-cel@kernel.org>
References: <20250508173740.5475-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: This array is no longer used.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 1 -
 net/sunrpc/svc.c           | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index a1b48ad1d464..48666b83fe68 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -205,7 +205,6 @@ struct svc_rqst {
 	struct page *		*rq_page_end;  /* one past the last page */
 
 	struct folio_batch	rq_fbatch;
-	struct kvec		*rq_vec;
 	struct bio_vec		*rq_bvec;
 
 	__be32			rq_xid;		/* transmission id */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index c086f46265f6..939b6239df8a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -673,7 +673,6 @@ svc_rqst_free(struct svc_rqst *rqstp)
 {
 	folio_batch_release(&rqstp->rq_fbatch);
 	kfree(rqstp->rq_bvec);
-	kfree(rqstp->rq_vec);
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
@@ -712,11 +711,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv, node))
 		goto out_enomem;
 
-	rqstp->rq_vec = kcalloc_node(rqstp->rq_maxpages, sizeof(struct kvec),
-				      GFP_KERNEL, node);
-	if (!rqstp->rq_vec)
-		goto out_enomem;
-
 	rqstp->rq_bvec = kcalloc_node(rqstp->rq_maxpages,
 				      sizeof(struct bio_vec),
 				      GFP_KERNEL, node);
-- 
2.49.0


