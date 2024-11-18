Return-Path: <linux-nfs+bounces-8059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8399D1A53
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D091F2270E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963991E7C19;
	Mon, 18 Nov 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE2h3vt6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F080154BF0;
	Mon, 18 Nov 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964749; cv=none; b=NQQAK+OHeuxbQThiqD0BKvu6LomLAXbUr3mDSCl3VdsXV/qlOoIIOAZ21BpKXhip0EXOsk8Yli4dgebltToxkqqs/oojOPkZ+1lH7o6NlTX3SPbOLFJGH0ZIwjgzms8PZaAyanPs0uyVz1NWXGOrNZid8UYkLOlddOA4aRHbEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964749; c=relaxed/simple;
	bh=3eaJq0tUJXwU7juddQdOjpKHZ4TZ6rOQUlaYChzYvak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIYWPf7uSfci3SVsNSonKTsYhlJWxx2MSyXOGVpR86BA3SPPAumZ9MsRef6QQXo2CTa0I20zShtwrJFVmOLXXE4GcOk8IkJFby1APSMGJ4kxk8NapBi7gxDjSwo88elD8u7EDANnHj3hpohVkae8W0RHfMwigTod2wDfNWm+vM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE2h3vt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EF0C4AF0B;
	Mon, 18 Nov 2024 21:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964749;
	bh=3eaJq0tUJXwU7juddQdOjpKHZ4TZ6rOQUlaYChzYvak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fE2h3vt6isYgn0WS1NdXMmqC8semEr+vx4echXpr6QNkQBzWwbUdtupnD2Rmc25tn
	 0mn067FE4ut1OqxyBpicxrVcnoA6s5RRMInmZLYqhko4fTvJXkNXRLCHVKw9o1gOPf
	 3VlmOQGtKTlT1Px4QVbM0MUs6T+b86eSjsgmJaKsfUEMnC5Tariry1FTSb3TVemM3M
	 aSgvpf7zW91uh8Q/0eheaBFfV+LFP2r3FtMoi1NS1MLCVQ54g8MfxX4qutPr6FdA8u
	 gBG42iOGEHzVR+x4d3elwKQ6DBIx8+nbq5gmmMQfhMpaqocSf24PJq4rloz2Pttvsy
	 iLYeas4LRVCPQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 6.1 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Mon, 18 Nov 2024 16:18:59 -0500
Message-ID: <20241118211900.3808-5-cel@kernel.org>
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
index 6637a7ef974b..c0f13989bd24 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1786,14 +1786,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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


