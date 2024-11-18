Return-Path: <linux-nfs+bounces-8053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266759D1A3A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E141F282467
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D7D1E7C1F;
	Mon, 18 Nov 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIFy81ov"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8141E7C1A;
	Mon, 18 Nov 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964459; cv=none; b=aKsoH8PIffnuDPMYXK+QDbQO/FSgB8onMogVJWxz13nHOOoL3OgripFR2qc6pcD7xAHzlRylmTWR6T1CJaadTgVlOf4NfDwvNW6qFJF6izt30DzmpJG5xqJmXTAuWTuCavfW2o0yD1usfzWC+csoa7AORSeHdO9mysDt20KBhSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964459; c=relaxed/simple;
	bh=kudmYckbgBJUAUmnlP964NvQden0S9yrCfqiiDIoS9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tdh6M2QvJOWYSTm+qP2qR7V/d7UX0H5kwqIzBxtewv4Obno7gxjgHzvfoZ2aaDVc3wkUdUDRs8Ok/x0cp4XYMTpDdnATDRvFF7qt8ZtGtGRYbsHNBTaowlI1RjxBqT5p3zMl0Lv++9nweiBqYdrnBrYkH0Vamc9YDujrqqG8fAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIFy81ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9177C4CED9;
	Mon, 18 Nov 2024 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964459;
	bh=kudmYckbgBJUAUmnlP964NvQden0S9yrCfqiiDIoS9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIFy81ovTS+9sC0ine8sg8oP5UmoFjHgdc0YbZ5Vq2fUDVtcGZY9Td+eV/2eAVUV8
	 seGTggAFZhoPVkwUghmBHxEXMOwVIKRXhcbr4zaZ3I9DRWmLFUkxyF3VAOA5XtIPxt
	 /fAiN8nMSm08nggYMUkDxX1sF3caA11YJKAOltxuNHg9Wqugc/IhDj6Nr4rNsABFft
	 eI0cYY8v+6ridDCOX9NdDqihI16mx8q9iUsF5PIZmQBfSk8f1YDfkKWR+cZxu0+nXL
	 SAFlACF4eawgR3gxJnIOzwzI94b2/wp+5+Oo+mMKUnX2gqIJZEUEhE6U2o+HEuVQ9v
	 2PTQgvuXgXIjQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 6.6 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Mon, 18 Nov 2024 16:14:12 -0500
Message-ID: <20241118211413.3756-5-cel@kernel.org>
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
index e74462fb480f..444f68ade80c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1816,14 +1816,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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


