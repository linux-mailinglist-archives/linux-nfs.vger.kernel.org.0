Return-Path: <linux-nfs+bounces-7115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C11C99BB57
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Oct 2024 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC7FB20F7D
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Oct 2024 20:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BFB14883F;
	Sun, 13 Oct 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu92F44Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C037E574
	for <linux-nfs@vger.kernel.org>; Sun, 13 Oct 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728849759; cv=none; b=WiRffu0sX4Br1krMVoQ4APv3Ej/dEetO5FE8a32zlFU2/HEju5Y7+eOF1tuFShG0QN/tdvvRI0Lj1x3PUKNmvdS1VGPpjY494JhsFLveLE3JRz75i+5W7VnlQFt+utGhoLEJjuXs4/XWXQTgnwiPwSuSPMx4uvtXRI8++awR33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728849759; c=relaxed/simple;
	bh=LAD6HnyKMMmcKMgev+kIytEJPtdSm/H/lTFxXvD+cfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdyxtNHNHcl5f90y3Qao2PKb0/zVL+Xzpe28eWCiTaqtZhUHC55scxeYlwAMkyAAVDGiSdlMQNc9b6pEozcllCS8+RB5B7BtOiuH6RfYIvzgYH0SbJPk7CM7CR9fm+RAI+Q+Doe8HifBTkgVOQ1qpTwTAj//oBUGGOlYZ8fPh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu92F44Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CCAC4CEC5;
	Sun, 13 Oct 2024 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728849758;
	bh=LAD6HnyKMMmcKMgev+kIytEJPtdSm/H/lTFxXvD+cfM=;
	h=From:To:Cc:Subject:Date:From;
	b=mu92F44QVO/AT/aXUn9Vwl0Ixmnp7RA6rmek+GqMnlr9fvbVvKCKxJAbPrEMbUdkt
	 c5gHIj/qMcDSHdHhkZT/d6+yWDNQjdrlVZLfdfo8zqhyKzNYwibyX70DtEV2FO+JpI
	 IbpNr7bVRVJn+PEM9gqRSNI7Iv7wRbpix4f2cqZ6/ONIgqFRQmivgwo3qBnyr3yngN
	 r/rtZ5bSPU+hwWHjC8OT9prjjdWJ1/JVWjdNkFyFlXSGCKwBk9fmhW3EHBMiU7Rw8m
	 MOCiiemc7pmkP88SENPsuU4lqS38I92VTvcKGCu3KvbchRldwqVU5Z99n+yZU+5cgj
	 k0kG97qTOdmDA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2] NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
Date: Sun, 13 Oct 2024 16:02:28 -0400
Message-ID: <20241013200227.170049-2-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=chuck.lever@oracle.com; h=from:subject; bh=HBRzeew4GYHo9Pl+gWMyyyS+pDWLqdw3w23G/iNoWWI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnDCdTuH40tA8k9i2+FYTJrEdpobM36jeFPtwaa 00OPG1T++GJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwwnUwAKCRAzarMzb2Z/ lx+bEACTIzGznlMP4gI6P1DXL8lhtnipHapWY9HepagOwZwPgveSlkzsrfhVWZewHolEAUhbOS7 2p88lpPzAgF2XVcUCaDQu0vsImCRGg5cxNeMw89+k1JOThAMvkI+h5vutzpfngFYjtxmonNFSRI Bsk1V3gntwPXsmGB9bvFJVxZw6P9hLHNzujK4BrQW2uYEJKBRGfGgTcykDQh6QBwyL+7Yo99ITM 4lg5+3cNHgN1c379wJkaDVleqJbi9i1lhmkwK/ErStWAMQl7MegUUkTGp5DBe+9cVyeMUPUFUVi r/QgWASGvQWGmgHBmuaYOontu1AQPHbDvMQFglkdM6OyzyzvBXltTUygO7Z0IbGbqMjFT5Bmzza AzjevM/PgNbSZQVdMxGpStX5d5lW0STdLQNR2bn2N1U2HBy+uNLBuIBKGOQdeVgXkD/uEKDcxvd KRRQGUTBaWf+NtMAkjbZH0xuoSR21d3QRo4+8UrPKiZDvZBTBvzv4E0tlViMeaC72inB1Cw7LgU kPcf4r5wqicoA/o5jpSn2KD8IGFOkWv/oClvgUq+Py6xOlVhls7amk5kCmNTqzGYqvePmgXUPEF SXiPTq6U/Flc/y87MmGO18s+Gk5Skm0Z518sv9ocabM9+t5KFxN8/iUSBY2DxigyyvMXp1DNd2u 3aBt6s7VZqv73Rw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSv4 LOCK operations should not avoid the set of authorization
checks that apply to all other NFSv4 operations. Also, the
"no_auth_nlm" export option should apply only to NLM LOCK requests.
It's not necessary or sensible to apply it to NFSv4 LOCK operations.

Instead, set no permission bits when calling fh_verify(). Subsequent
stateid processing handles authorization checks.

Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

This passes the nfstest lock tests and the git regression tests.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 73c4b983c048..b6f395927aca 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7964,11 +7964,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (check_lock_length(lock->lk_offset, lock->lk_length))
 		 return nfserr_inval;
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh,
-				S_IFREG, NFSD_MAY_LOCK))) {
-		dprintk("NFSD: nfsd4_lock: permission denied!\n");
+	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0);
+	if (status != nfs_ok)
 		return status;
-	}
 	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
-- 
2.46.2


