Return-Path: <linux-nfs+bounces-8068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB39D1A65
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8641F22305
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2591E8821;
	Mon, 18 Nov 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp7GiXcX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BDF1E766A;
	Mon, 18 Nov 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964843; cv=none; b=UdStZDB195xKRmNlHjJSjP/QbUGiZR/D9kjxO0CBQqzvsyPb9Kf85rpjUHeqIcr4xdJ62lYgBAVKBGtNgDsI/36GlaszT/suE28Tki29ZMKLkZTmGvZ5PxHSyjVnf6/lCjwOmbQfFwHzmCsvKT3X/qWQxRGJVew88tp2un0t+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964843; c=relaxed/simple;
	bh=L/5WbSn0Hcf4WWyoyklgYacsCyDIHh4RMBF1geAQ6hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYyenVj4M2q6R6isW1LDxthC0WsTgkX9+I1v9W7Uu1yxEUL2AN4NyIygJpMr0vRzTdpiBh/8ZDIifAlmdr4ih5kFxmfHXKghdCtVUKtrBo10Hbi7gxsHYLys38jxcQEME6sCe9F6gwQNdSJYRTHXnnGeoXf3VmQMkQRnZvKEe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp7GiXcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF676C4CED7;
	Mon, 18 Nov 2024 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964843;
	bh=L/5WbSn0Hcf4WWyoyklgYacsCyDIHh4RMBF1geAQ6hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yp7GiXcXdtoLlp8ckiI2jqSFcgGb4UD0ixSa31DOym11WIUzSiROURvLkwKgbxqDh
	 r7CwtTEv7l7l22yDBue+QaE1vsClzEUIQ5K2a7ymFaa4clPrpaYFgMfwnQIS5P0eQJ
	 06tVNlelXuG1X+zGOOJ0Ybm4q8SNjs36aIQE44rm45qXMOxsHKnE7rnzVOf/z/OiAR
	 sns2xUSwIO7YXq2Bve09C2pwo0mrEC4hAfXq19tedSomdyzP3sNliGoo0ynNtGhp9y
	 VkQ+fUooBi7SWs9u8GFZGMR7p3DAgZpaoP53ndLlO+1AEShsDewIIkqdGmQHYRdjD7
	 P3fE9lrFrKgNQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 5.15 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Mon, 18 Nov 2024 16:20:19 -0500
Message-ID: <20241118212035.3848-8-cel@kernel.org>
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


