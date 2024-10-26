Return-Path: <linux-nfs+bounces-7513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3789B19B3
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 18:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29622B21058
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B2B676;
	Sat, 26 Oct 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShR4ERlc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E96FB9
	for <linux-nfs@vger.kernel.org>; Sat, 26 Oct 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729958567; cv=none; b=SWT+fYTEomC4LvzcRoi2SzzjeWfO2ovGLbZfgHdlSkXu3V/cZ6+JYUCMmyV9kferBjb2YchybeKumcXJOAr5pGhRI2bSYBPPpVDTtreC/2EokZgch2mn5BnuP3zGgHs23K2eH6ODhZ2qdwKEKMwaHHEw7J3SEtXM30xNv1BK5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729958567; c=relaxed/simple;
	bh=y8U/VEPwzi3YSOv7zVzk9iHlVgBnfMn646oXnUqAzBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c555Mc78mQ+i6YI7jC+U/XHwn6PmO4QkFcH9M+mknVPkCk1gdwFEY9cGl1eOsXsCPnrH6MHdxiScYBCriK7yTRaUCTXJA3nugYAT8zjv0P7bQQaJhxoO1Lf8OkffnR2X9PoHO9ag80eAbK9PObM7TG1t+zIX0IMZoJCyAseM9UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShR4ERlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57588C4CEC6;
	Sat, 26 Oct 2024 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729958566;
	bh=y8U/VEPwzi3YSOv7zVzk9iHlVgBnfMn646oXnUqAzBY=;
	h=From:To:Cc:Subject:Date:From;
	b=ShR4ERlcg1jh26ePatwO6F3nQKd+BtkiYm0M2HOnG9aR7z80vMERUwdDds+AZnc4n
	 onoMziuoQUjJDX+ABUNTdazUUlOKDeq+19X3+QCGUPaW0gCso4IZlB3ophr5SObE0z
	 4M5sf38lER8rh1L8FUcbP1+klCcyj77LQMEB5Ya/BztFkg24W6wa6OW5ZyjGlZHeHg
	 IX9qZzn6dP/e9dRTEsIsj1dD9oR5dmdU2ykKP0N4ZSv0/v2SgbEeczJmfwBMswj0sf
	 q9o6HVeRxCG8xaDBiBGBc+BoYifZs5Bu5QxBdUOMdqFmgihH61VJTR6zD2XxVNsemg
	 nPcuFNI8O07/A==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Initialize struct nfsd4_copy earlier
Date: Sat, 26 Oct 2024 12:02:38 -0400
Message-ID: <20241026160237.4304-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=chuck.lever@oracle.com; h=from:subject; bh=8cvnO89cGUa9SzyqWVqmEXCfpTISgNHduiCDkDL2WiQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnHRKdMz+JON6cREMbRGr4zlfHYd/ZhJMiYdIR0 M68IdJMtWKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZx0SnQAKCRAzarMzb2Z/ l3vtD/9jBvLjWqatFAYcMAzJ0B6c2xiHHctgGggHq3JXSk0Gbv7a0fZP+VNVHUAozUnyG1h+F5o dhcKvoeFKWucQoID1U1yxi6lxHY2JWD0a3EXwBqvABL0yn3Jm3DlaxQp3xvbvLLWaryuOsETnT9 SXawb1/xBlCuM3QwXrmYfh3Q+GjDWdFCP03MGPm9fSYdPMiLV+i8bVrhhc5z67YXZFu92AiLwUY 2Uxfk+DBKDyQqhhWeFEWtC742Ki9ZZJv9Sf+XxHVnUEYSWtalQHF6CjAUfS+rpKDOYVWKMCsEb4 WM7bpiLRXzzFcWAhReFusVEa4ydvcTFowHGywDvXEIf7hMYGGTgdEnyv41mPCCEmhV8KMiFHE80 Qwa3sRGNPRfRlGIM4DZ9pCVJawII5TeAJgGjCMTzDfAsBqeeLhTT70yzbT12G2oCyzxs39ZDr5h 4V3VcR5wAcDhIrVUzWazHe3nTi7f11NFev4Wdct4LMLODO5aRLiNwk9XR6BOvGfti5Hk0BfsiWy 3kVwU/QqRS/Jqiw6mYBQtSH4Y/icebdIWMwzXxwlvTiAJ9opPxAlGYCNKwotghdv4eRy5u9vqOJ rYNI8sJqFhaKqF61Q5rs3ipbif3ROvI5kR2lpYN46+xRZkSj3v2Dd371AvCBQnHXhgt1aaXQJqO 8ZXeSYRjf0SKSwQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Ensure the refcount and async_copies fields are initialized early.
cleanup_async_copy() will reference these fields if an error occurs
in nfsd4_copy(). If they are not correctly initialized, at the very
least, a refcount underflow occurs.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b5a6bf4f459f..5fd1ce3fc8fb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1841,14 +1841,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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


