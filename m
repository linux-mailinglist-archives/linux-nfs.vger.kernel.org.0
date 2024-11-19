Return-Path: <linux-nfs+bounces-8095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E79D1CBE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707752824A6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B912E3EB;
	Tue, 19 Nov 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax9mrnaK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C725634;
	Tue, 19 Nov 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977258; cv=none; b=XQLZaLzOnuTO6Urek9n2yY9Mi0LT7X3pO7EMrgG4pAZdkHZzGVRXhzl5+Fr9WYWc/WCfQSApOyqPH/c1bLO5Oz+ltBRld4PRuCCFvfwkS8Sy8pE09IIKa3IdVlX+yTRwIUBrUfz6a74oCkq8hzNMcwngVbJ6nA7sX7r44RaSdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977258; c=relaxed/simple;
	bh=JXoxCMjJrfAmsPpSItXNsxwRH/VrwdTEd6ottbb37KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/iXHtvQW3uxOTky1fk43S+RSnx7ZFiHfD51iyAay1Qy/PBxw8u9qBqXS4dq253mGikgrrcB7/cRbIoVMC+aackJLm69rjCqka7BfXKyamBd3DO4hr1+9u9/Eld0j7Mtw7GWTCqhhYYG8aep+x9lxGJJISx9WG9OPqaIfSqkTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax9mrnaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80061C4CED6;
	Tue, 19 Nov 2024 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731977258;
	bh=JXoxCMjJrfAmsPpSItXNsxwRH/VrwdTEd6ottbb37KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ax9mrnaKrGv9PineldMGz3M427ui1HIE68DaN85tk43VW1RWAOrFIGK7swWDkGyj2
	 zToEU4mUaMud2ftC3Q+zvhNnIjPz5/Hvkg9ne2e5otg7QQR3ToonpGe2nQvOcDyAqK
	 LXiNIoRT6pchzIx4eBV3OIzx+HDChM2cZUqLCTr0JnYrL/yu7wbqGlPxFIKVRA4vaB
	 9hI7JjHo0vSiporQ8LmdUFfOiw2TBSIwPdRGuHTl27TmVQ6B/n8x6qWVYq6gYOvZh5
	 PRd5dhfxPS5yzLd12iBN9G+7Wq5rMMgdHpbb2jl6kQpmCMtLJczrHBK4T+CLazL0ae
	 OhF11NeDosVAw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 5.10 4/5] NFSD: Initialize struct nfsd4_copy earlier
Date: Mon, 18 Nov 2024 19:47:31 -0500
Message-ID: <20241119004732.4703-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119004732.4703-1-cel@kernel.org>
References: <20241119004732.4703-1-cel@kernel.org>
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
index 9718af3c2611..b439351510d2 100644
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


