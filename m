Return-Path: <linux-nfs+bounces-11573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB016AAE254
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75668B28270
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992028D8CE;
	Wed,  7 May 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reFAmdxl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1A28D8CB
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626855; cv=none; b=ahF7w3dL/9GmeWQ9Gu1Fgv7YEe1vjbvkySmAI/B7mKZ8itvGFZGGRiaHBzvcdqdmn4PHQPoDD1o7IEN+kJFPSH2G2tCEjoSENMEg/YeamnTOQyKpcJhy2boxXMr1Pf3wrdjmK0ZkLPFk1C8IFWmp09SZzyIGXslfBwR27NVKykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626855; c=relaxed/simple;
	bh=oeo++alqfwYTGaikWTJbdgrBRpEk84Rty13layED/tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQ8huyXQ9YzeMrP0rjITvCFb/YXvic4aX6tyWQZbhEUR1BY4E4zD3IL67ABf0fDimOZSJJjM37dmy3mr/rhxdSJqcrMUmkUjz1/PGdPlKWZGVD7gKWIDIUNEGL3Fo4gfhbU9NbBrJcLz86JouGd9QkCYHO4Lw3g+bjI08ltQeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reFAmdxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCB1C4CEEB;
	Wed,  7 May 2025 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746626855;
	bh=oeo++alqfwYTGaikWTJbdgrBRpEk84Rty13layED/tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reFAmdxltvoexbTeVAVEzcgR5drkQtD2f6e7fQNpevInq5MfCfPmd0yhwVWnaiFAO
	 yJbIw+XDZpeOQRQHwO08TBWsVHFLnfzWbk5omFHdBO/1xfVsb7lyilUaExIEDybx8c
	 K85Ci08Y3eqdx1Yn8JOjgaPzoas+cpsbVh3DaZ/aeO7Xl0HbEJAnjHO+8JuCWqJ3ND
	 WOxW1iQtHiT3pu2fqg5Q2BaeHl9Ncz/W2ePW7FZH8Zg1mHPrWZXOMNPas2m5KYWWgn
	 Gy9DcJYfRlIQDJwfUFDWzNSHhqRWO6L93iKOXczbVksWiv6YK/Vsv14yOny0TCFAfy
	 4Y6tmT5K5RJgA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 4/4] SUNRPC: Remove svc_rqst :: rq_vec
Date: Wed,  7 May 2025 10:07:28 -0400
Message-ID: <20250507140728.6497-5-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507140728.6497-1-cel@kernel.org>
References: <20250507140728.6497-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: This array is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 1 -
 net/sunrpc/svc.c           | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 513b5ee88293..a66d13e55831 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -205,7 +205,6 @@ struct svc_rqst {
 	struct page *		*rq_page_end;  /* one past the last page */
 
 	struct folio_batch	rq_fbatch;
-	struct kvec		*rq_vec;
 	struct bio_vec		*rq_bvec;
 
 	__be32			rq_xid;		/* transmission id */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 77e9c180f48b..8056af53d3c0 100644
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


