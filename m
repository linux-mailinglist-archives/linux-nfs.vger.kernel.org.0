Return-Path: <linux-nfs+bounces-5867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1F962EA8
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26F6B2127A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B91A4F38;
	Wed, 28 Aug 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl6bnOAi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EB1A4F15
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866815; cv=none; b=Edds5ULNc0EUKOjsn3IrR1rdHnNL6vxhV2iI6S57PTAvmhaapA6O2uY9mDbdTmZ7AbcErk1vEygXEKB2tuCsjL/5/xtdBNaSw6OFfqLGc2HAgAQDTA3E7Npt/DdDG+plQwYlwZfU4levys1B1SiPM6Rvn2qMdJi6Dfqvrn5rgH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866815; c=relaxed/simple;
	bh=6oFDHWl9ASZRRqKca6rJtTNEg2+eX4CfpH82kVFivvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVl/aXryLTIID1BEtat/7BH4hoLtNpL4D40WqSjrcH5AUOMVeGyEfpmJWVJ/85Rp1ikGQD9aGe4465VLmd5ZlCwTg/ZTrqE5BPXnpq5L8/ymLn+1TMdklQNZ6y3vwrp2GUjSIYoFZAqVrQCN7vqZat1IpAPpcMYZIcwgH6WQlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl6bnOAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E59C4CEC1;
	Wed, 28 Aug 2024 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866815;
	bh=6oFDHWl9ASZRRqKca6rJtTNEg2+eX4CfpH82kVFivvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fl6bnOAi79TlLt6gVMYT0wRL3ojfl/q7qIEZ1nTBGIHH+yynNv48z0lVOCBzK8N0b
	 7DzUZVtNoveIf/DZemGc+slm6cccbD/zjV01qMZcXLWFJaOKFuxriMJ8MMwth4AScL
	 vNMVn4nU8M6f8Hdros24C6lYAFV+r8nNhHMtZ2WSRHlyzu/zEZBuAaFXFse508vH21
	 h5aHPbNhm31k+pKMQ8sfE386QWjcaHPGohgWELx/njucrFj8t+7lBUgas2Hzp6B3Fp
	 yylUpDyeQMDLK/ybYfb1tK4LK1I+4JB2br/p2OOnPAiCc3mg0nVfRtjORXkEf6RK3R
	 1YghYREjCiKPw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/7] NFSD: Async COPY result needs to return a write verifier
Date: Wed, 28 Aug 2024 13:40:03 -0400
Message-ID: <20240828174001.322745-10-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828174001.322745-9-cel@kernel.org>
References: <20240828174001.322745-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4213; i=chuck.lever@oracle.com; h=from:subject; bh=K/lF++1pminDy6pTIOKTccQ4D/b/G5sJcZBdqmrNj4o=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmz2D6jI7oEBfZa87kARZg0yFbwQc8EGOD7/Cre s/5ULkv4H2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZs9g+gAKCRAzarMzb2Z/ l8ZVD/4qCsjQVCc6EWKKWbMvM8JRBpahKKkV+5aBUDjhXSOBpWjKrEGun5+xC7QxMFMn6F26Xmf 0MpwOrivwYDh1W2YHLLo2w6lHO5zxAiLX9CofX3XGTviZdC2XtGoG/U8YWlOlNFEWplPQuy+7X1 FJrzTwu6PwMuxcD9B2AgZe+C/zbhFIllW/OviERn/Epg5H04kpo8fHgsYorAT8oFG9O8BpfyVD7 SVIf591iJXjsAfwzxa5G/gOIZKXmphgXIOE6cbMHV/H62P9CaLOpuyQqwAcPlXRs5Mt4wBzOsI8 nFxW2DYNb3Z3AAeXKWUPb1MZyId17WVChQXGEIe7IzEZD9x7z+zVNB8JHAt3aMtsOQI1peNr7c5 zpXjfKQSzfO0TmVfpUK3oxwtmsJa0vLS8qTOYYyfwwiiiHp6tF7LPHPvY29KrXgXR+MzxFC+NV3 xv//SSas23GEiLVXxI2jT/a5/di+/40XMMTdJnmS9M9wUNYzWT1AtEX6NChZFMYkh0fL4Gi6X6T oEWGLlAUwu2RbuGvsxO5MCdy2bKX5jI03nkeiwzYMTmAHA/x5WU4sSBFCzgMUN9b5Pu3hdckcvZ cL5qoZboLGe0HXdjl5faXPOH4CL8h3TsPfMpSlpE7RWy0RXkt9XNKtwwA35vEEQXsB2pRMROOBl ldxFjhArbXQoTJg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Currently, when NFSD handles an asynchronous COPY, it returns a
zero write verifier, relying on the subsequent CB_OFFLOAD callback
to pass the write verifier and a stable_how4 value to the client.

However, if the CB_OFFLOAD never arrives at the client (for example,
if a network partition occurs just as the server sends the
CB_OFFLOAD operation), the client will never receive this verifier.
Thus, if the client sends a follow-up COMMIT, there is no way for
the client to assess the COMMIT result.

The usual recovery for a missing CB_OFFLOAD is for the client to
send an OFFLOAD_STATUS operation, but that operation does not carry
a write verifier in its result. Neither does it carry a stable_how4
value, so the client /must/ send a COMMIT in this case -- which will
always fail because currently there's still no write verifier in the
COPY result.

Thus the server needs to return a normal write verifier in its COPY
result even if the COPY operation is to be performed asynchronously.

If the server recognizes the callback stateid in subsequent
OFFLOAD_STATUS operations, then obviously it has not restarted, and
the write verifier the client received in the COPY result is still
valid and can be used to assess a COMMIT of the copied data, if one
is needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2e39cf2e502a..60c526adc27c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -751,15 +751,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			   &access->ac_supported);
 }
 
-static void gen_boot_verifier(nfs4_verifier *verifier, struct net *net)
-{
-	__be32 *verf = (__be32 *)verifier->data;
-
-	BUILD_BUG_ON(2*sizeof(*verf) != sizeof(verifier->data));
-
-	nfsd_copy_write_verifier(verf, net_generic(net, nfsd_net_id));
-}
-
 static __be32
 nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
@@ -1630,7 +1621,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
 			NFS_FILE_SYNC : NFS_UNSTABLE;
 	nfsd4_copy_set_sync(copy, sync);
-	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
 }
 
 static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
@@ -1803,9 +1793,11 @@ static __be32
 nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	struct nfsd4_copy *copy = &u->copy;
-	__be32 status;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfsd4_copy *async_copy = NULL;
+	struct nfsd4_copy *copy = &u->copy;
+	struct nfsd42_write_res *result;
+	__be32 status;
 
 	/*
 	 * Currently, async COPY is not reliable. Force all COPY
@@ -1814,6 +1806,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 */
 	nfsd4_copy_set_sync(copy, true);
 
+	result = &copy->cp_res;
+	nfsd_copy_write_verifier((__be32 *)&result->wr_verifier.data, nn);
+
 	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		trace_nfsd_copy_inter(copy);
@@ -1838,8 +1833,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-
 		status = nfserrno(-ENOMEM);
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
@@ -1851,8 +1844,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_err;
 		if (!nfs4_init_copy_state(nn, copy))
 			goto out_err;
-		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
-			sizeof(copy->cp_res.cb_stateid));
+		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
+			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
-- 
2.46.0


