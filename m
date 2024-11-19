Return-Path: <linux-nfs+bounces-8096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A59D1CC0
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01826B20A1C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67278381AF;
	Tue, 19 Nov 2024 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbNhzbkc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95225634;
	Tue, 19 Nov 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977259; cv=none; b=aZhmqIkFRmIN3h0Czx8DAkM4JaEE5m+HVcclAGB1sdlOCLZQshlMeF41BT1Ry74IHrYXPkG9TNoCBn+W8TqucAB8UYVlgizzXY6Nle+nsqbtOOBfFLHbyzVcx5Pz/5Ghb7nwQaT1TSHLR1OlQcdeHGzjo3fWXR8b3CbetP+4Xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977259; c=relaxed/simple;
	bh=MhMkh7nubvJ3BXZAouaiBI1ZVRU/V3tNdTtRFQi+vAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVNhQHRJ03eX+k18B8yHpVWSoWF/lQM1RZAiusgyHAXOoirAVKVyiXK+S6mlm+SAYJ1B6zUl7MF0fTN6aAQ7eJY4JHwriY+7UlidTcWIL2armZqq+gRsjHtW7B2QrvXI9IzUSfsKfjxJ8W7DStVbtF/yT0Km+eUAU8/athMIJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbNhzbkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49873C4CED0;
	Tue, 19 Nov 2024 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731977258;
	bh=MhMkh7nubvJ3BXZAouaiBI1ZVRU/V3tNdTtRFQi+vAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbNhzbkct+GMxWsqr9eK0UuPpccdSz7igrL/E0UHlFlj7AAKkRHqpc+/ystMGQoI4
	 jCNpMSGbeS02lKSMjdY2mKYQfVWE1/GNdDOU5mq+M0pAwy0i88iLWF0aLornjN6XlU
	 XL8HVKWE45o5Y3RqjuEC8yvtSJClYnVmXCan2+C4C/S34zgpkucBniXiyRpEHLK9aB
	 IZaVoicXIFZrxei+mvXTtKfmgpj5z47Dm0XGDMGtd0TA1Mo2JaFidkBiON/JYzf6fK
	 k/1iSFgVq5hoSZbTMUw7bpJC9hibJSDIPW6bIgmJQM7KQBllt4WUQOqabUfTPzj2Wi
	 Dx2ZHQdeo2Faw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 5.10 5/5] NFSD: Never decrement pending_async_copies on error
Date: Mon, 18 Nov 2024 19:47:32 -0500
Message-ID: <20241119004732.4703-6-cel@kernel.org>
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
index b439351510d2..237e47896af8 100644
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


