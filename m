Return-Path: <linux-nfs+bounces-7026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB97998BC7
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F8E1C24915
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9C1C7B6E;
	Thu, 10 Oct 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6xgu7Oq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F42C6BB
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574423; cv=none; b=qu0yJmAIskOwKP/2ddVyNTpD/Vfh4UQ9dAG+ta3MqSCa9P/fsRYRGjLLKK2auJP//b91EFib5/akX+5QqixjKf0gp39xalsNqaDlsgS7e4dSKWTIdY+b1yVYxwNMoG5GqcDk4oe+Fj4jj9VLK4+ydVpFvOhKDBoEWi8YNb5PWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574423; c=relaxed/simple;
	bh=uqXecdjcR8k3LA+NVp/r1LZh3qnd4ctXahiF7ZIOrxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmLvLzcqlghiCsdHQXnrMET35wxH2BYmKTzgoblTjk8eoY9bhyEhPx565KrBmQ6IrHeJJRguoR9tiYwgG4D5Tfbl1HA1NSTnTZpaQyhHd1MvC5LTabEKWvfamiBQIO7Il4sKBYAT8xZoctY88R4V4M9yhoSQ8EAhS/ngzcD/USo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6xgu7Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86443C4CEC5;
	Thu, 10 Oct 2024 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728574423;
	bh=uqXecdjcR8k3LA+NVp/r1LZh3qnd4ctXahiF7ZIOrxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=a6xgu7OqY9vIG6Pua/CNkPWd10Qs4u4hWPNurmFxCRVrGt8JP1Y2AUzq4uW2BxK8P
	 in3YQqsLHmJr5lk8NY5CjOYSmpUC0WnG0K4tm2zp6Z1OnvkH7evNBtc9rTXOnbhQoF
	 2UDYn2MLlFEDUNxdcg2D2c5lWRReDAy4HMZRl9P2CuLu0KccLhdUBMwtsqbPNY6j0T
	 tIzjTTkF4zQVPtPLUsTbpEu0PTUAcwC8Zf3OBDEmnPVxHaMu5LGVfoXrpsY4nhOUir
	 CO/xHOIFzcC1JaYHRSWCO2HDAM3jIbcnzOyTnn+uG3cSaRnrNxsWg53m4UVVmDS3+9
	 FGDeG8nFOfwoQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
Date: Thu, 10 Oct 2024 11:33:32 -0400
Message-ID: <20241010153331.143845-2-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=chuck.lever@oracle.com; h=from:subject; bh=jkBWB3dERlUwH60EFio6ZCtKUyJs0/ABgNt15AT6Wd8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnB/PMH5YB0RUMB6huDL/ufMU7iOumW2GYgVmia /VgactAfIiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwfzzAAKCRAzarMzb2Z/ l7fZD/wOo5qruTZRC++nSswxBrs+bqqrAW6PQ2/nSaNRiHn4/1y6xIN5wOjxR2zO8RSNzaju1qa uc2rSS7o1dQcuPuq7GjmbLdrQEgnjE5M/Js61/8NAeV8PCeO1Au6JfUI7iV3VB7hD5Y7qaYECGz Rkyf/3CCw4u5J/4NUginuHJJVQvuXDISHJ1VSSbBeNTfridvQ+siIk8SWT7hLAOrh0sd5e7EvCR GAr/1RT7eGxe9PSdwI0fXIMdrNxavL0KvcREtVx0nSep1ZbAO/TXUrs5BEqLnU6bhza1yedBg5l 5HzZpHUajKR6mUY286LCtu7K+ZCGaXi9uGKyceVqaFvWE62rL9o+owuNvPqY28T4yQtBSAuyue+ OPMOc7RhFEDP7himVcOBnAevq5xw0n3/EHaBShrYAxZDvWlpvEFjLs55QSBgt9VAAjJ8MIDEnf8 qerEGiTYSEKkqa7LWUW0kPzAgffhyC7UOfisBoWUpOW5Ic3b4sizGpvwTWBZGvJQGhToUFYZ01T wKKmXTecN/fVbqp5/xvPzEPUrlTml3a3z00ahiwoqRSqWiiYXJRuOBFivUt3Sve6D9H5tcCRPiB S7KSa3Y8TYjsiNe67FwArDFZcyHd7IS7vRhBU4m6L0hw5tVccIBxWa1AdgJabzUT9jETGFUV5it zbJ3ls6lFcFWaqA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSv4 LOCK operations should not avoid the set of authorization
checks that apply to all other NFSv4 operations. Also, the
"no_auth_nlm" export option should apply only to NLM LOCK requests.
It's not necessary or sensible to apply it to NFSv4 LOCK operations.

The replacement MAY bit mask,
"NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE", comes from the access
bits that are set in nfsd_permission() when the caller has set
NFSD_MAY_LOCK.

Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9c2b1d251ab3..3f2c11414390 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7967,11 +7967,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (check_lock_length(lock->lk_offset, lock->lk_length))
 		 return nfserr_inval;
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh,
-				S_IFREG, NFSD_MAY_LOCK))) {
-		dprintk("NFSD: nfsd4_lock: permission denied!\n");
+	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG,
+			   NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE);
+	if (status != nfs_ok)
 		return status;
-	}
 	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
-- 
2.46.2


