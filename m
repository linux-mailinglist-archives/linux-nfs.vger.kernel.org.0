Return-Path: <linux-nfs+bounces-7559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103C9B52AE
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 20:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929B21C2108C
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26F420697E;
	Tue, 29 Oct 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMryc/QP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B41FF7C2
	for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230048; cv=none; b=mGbsyvKj1RAYZmWDeRhd1pxd1PEIbvR9DpwX+3X3qkCLjmtKIhn1wcuC+rb5SemfXtC8jcq6AUQeYEwCwioytVX5McPam3BUVoguiXkiHy2RptGF/LIXKFxeT19vlXN4a9UDqeVHx6mOvCUhkUuWbcWIG4jL8WEnJSt6p1p3vuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230048; c=relaxed/simple;
	bh=LirewynzsXTSX/vn5KqNnbE1rEVYJnJbz+kM7dsS2MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrLUb98fiu8kwlYidDlDMBBv3Fp4fMhvxcfwNGxeJixn4kP4ZDr/H55HAy+Rz06grw8xAAHzXaoz4SzQuAOLSsfdIK355veBXcbuCl6ZSxjJ77zXP603O+hnowtuZxL0k4aEbskxy1PJUAr+Yr/q9+m8wCROgWPz7XLuUw5UNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMryc/QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0179DC4CECD;
	Tue, 29 Oct 2024 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730230047;
	bh=LirewynzsXTSX/vn5KqNnbE1rEVYJnJbz+kM7dsS2MI=;
	h=From:To:Cc:Subject:Date:From;
	b=vMryc/QP5hDEg9DSmpfG/MtgLLfPNvwnIuTxUIMf7m+rAXVK3VkAva/POC/59B1/2
	 THWffA+vRfzko6X8a43jM9MGgdKqMrCqtP4t7HW3ixjnHx2OulUlLdExzSPvp4wO67
	 ZDiDkewvPScL4U/NFzbM++Rb39/1KyJpareNriN9pa61oy47WaCinlekpOO1i8q/gQ
	 yAyXnlFzIXwNhSk/fnU1WrFxwGIW5gku9+78t+LkA7ip5rRMNOGzJn0BgOhkCBm2Je
	 atDUkS5nIFhbYnt9bnjBci07lwNExFOJ9D2avQHXKuL1aHpbNpoAmnpLLhK8mroqJq
	 p2/3iUWNZUEuQ==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Never decrement pending_async_copies on error
Date: Tue, 29 Oct 2024 15:27:19 -0400
Message-ID: <20241029192718.34954-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=chuck.lever@oracle.com; h=from:subject; bh=U1W2OF84MFpLbISZ0HYEozSLQkYapQoEy3xkTSm+U/Y=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnITcWxX8pKi4ZyFS4r+pidqZrNc87PdBceDCaP Le1M2UYeYOJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyE3FgAKCRAzarMzb2Z/ l3FbEACOV68OJlxf/FiLn7HxhpRDbfaIPL6UY+hNerIqXlYUurMD2jj0Iyo5hReUoyxkAD6hQd+ +qrL9jeUcv1N8OF7Q+HWpa9s2XzZvgIqR3l6XKFV9tr6T7KmsEy82wQ0TPdbvFv1pirdBDZxy4O kCPYnQYrSQED/nwNMM+xxEsCLkmYikN+c0t9s/0bNm/nw9iC+MGWIrZaL9yRPdm+tJFnRQmaRwG JUHsVAXw2Zkdm+/ZFqSZ6jFdFybCfPdRSv8QiYIk1v1E8iHeCQaI1yXFGPR65KnOXoUGLBYXLCc +RpqRYMYqp5UWmzdCwtncyqvQ5s2W2bv2SuNCfe1aomHEiD1cwRDHGb63uIkKH72jWzeHdFmQN7 5tuo0nY/OM0Fo95dznYf5YdLnYo99pTqe12qTSKmDmrrTus9x3tCg+2f8RoRICUsciiJ5uP9/NR aLdPgXGJXiuCAY1ZMIqjEGN6CY6b3UKKMqAuxvIsLYGvV5EqWbrNE6lbkMzW9TC8XZlxc+z5fX6 tLrC/Kc9xDBIcnQ6Kuv/ebqekyk/o/f8b4SBjOvWJpmsnGKC+E4lS0Oc85/KOJwdk6cJB15P7bh jiwrtVJdIa4hyCe2zS1avxH/SsqWPvOSApSMPQ5gABlCbkwJZoZtZD1sOV64tLETb+e0GRKPhnr gVVC5drdXTdCbIg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The error flow in nfsd4_copy() calls cleanup_async_copy(), which
already decrements nn->pending_async_copies.

Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3c89eca35208..130155dfcc1e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1923,10 +1923,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy->cp_ttl = NFSD_COPY_INITIAL_TTL;
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


