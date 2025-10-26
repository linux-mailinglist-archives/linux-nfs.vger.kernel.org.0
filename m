Return-Path: <linux-nfs+bounces-15639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523CC0B5DA
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB73B1A51
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313532F657E;
	Sun, 26 Oct 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TjRrmYCt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKQrcX/B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62D2D9492
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517675; cv=none; b=cHOL+W5yQvcfwslCZLMzE0+lpZZf0bXuhRbytzgYI25k7Y65CWUIw5UBmclfNaDntl/ltW2fbDeXBRNrm69PnumqViKii9NAkEjrJVkgdA4AnVXUj8JzhNxv338pt9HxIoEzuV/jpqu+IlOoqZkjr/o70Lv0i+IehcWVoTHV6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517675; c=relaxed/simple;
	bh=VWCAsnePEYsa09yMge1XWhwslp3sz5a58vdwTorfPP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3yvrhj4ZrXOclLswMsK0OcagZeO56J3YRatXWOt2pLjkKtWH/EnSjzCo/DO09eXBZEXiV9dvJlh1JpPjlALpXHXifwzbqlllyVOk+BEb9C8jBoCJNtMpOA5gnzTN793c1NCFDYQHEUzuR/CRa7U7BpJduvm4rWx4X9bXMz/YAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TjRrmYCt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKQrcX/B; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9BCC81D001A9;
	Sun, 26 Oct 2025 18:27:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 26 Oct 2025 18:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517672;
	 x=1761604072; bh=Utr0C6bdww7LA6Hvj3/m2hZjrUVitRY/tytzyEy4oJg=; b=
	TjRrmYCtbPD7Dyw7aRXoEq3VKFfTgn/k0FjO4RSENKLBdbnV7yQa7yLU/6PVM10H
	JiEAHE+4fa4KSqHJLglAZS+uApsdnBfwZyb+BTGDLlMUrD0kvVPjRSWE09NuBr48
	FTYmGsbhiE0mOy0gRfEUUw2VTAfoVULZgHQdTPUSWhTYLTDCU+lrGYwB4SEd62fD
	WJS0yAKuEqA02367La0ZkHvTbLwjqAhmXOuNSOyhhkJpBrlXC1x3gc9dUeGCXwgH
	ZvykWgg9+sLgQ202fwlHovM2rVQEqw+0WAWMDQkw2DT2k9vTF+O7AD7ik3fGhkn5
	AnZyDFfn+sXuyswdA5NrEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517672; x=1761604072; bh=U
	tr0C6bdww7LA6Hvj3/m2hZjrUVitRY/tytzyEy4oJg=; b=VKQrcX/B++yQy0Ybz
	+uVuiUfHkTmgOub8BAQI7N5JXglRK4U8kfUV5033FmnCn96tpKyoCLz7EKODSHwa
	Y+VsfbqfO2URM1P9qbK7C1p2ba8hWNbFkJRHqIIVeWa5aYC6y2cCHYCiK1thcDUI
	sSMlEDPgCcAYO8K83pX/SaqwaTHCtu0LKlwE3B4/o1etnFUxwUd8H2HyK8Zwoo5I
	S7tQNafN4BCgjvYt/one7NRK9TUg2I8hS4UJd8FUKWwz9kAf+QhW8/MhdkYAMn4W
	pA9RCd2Z9FlaYKPyqKk7U46kp2TxozDg5KofYDv2MOhejR61IvyIJQMdgcaILedv
	FMH9w==
X-ME-Sender: <xms:aKD-aAZhYyAKZCK8oiQVKWu-LApiBOc4_r8Yb6g1Xra32tAU-TJqOQ>
    <xme:aKD-aPH0dLAbiT02qf7X6SbD4XdF3dTV4kLcD6nMNuZhPMMjaiTVBnhwdTMMz_Pzd
    N_SXntpjm1IEqpYj1R0CpZxrOwdu69dc-5vzalkDk2FLsWwKg>
X-ME-Received: <xmr:aKD-aEwrzEpK6EuF1aCxL7tPBkJ5EGK-oMBtrKaSqu3El5oexUNH3uxLf-OXR0Y3mrMGVURsfAPHuYmgVd47l-llElYLbdKe2a4rq0pXxHFD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aKD-aBkn0v2aGmmVkoB3-C6V35u_5kop8KYjtWrJHI6IhRm91CZI5Q>
    <xmx:aKD-aNnqHAGdq4zZWKusNotpLYIcCknaVGolKmfARrnUx99z5_CxtA>
    <xmx:aKD-aDwTi7GQjn8NIljpBJvRfjAeagY7icAyBVCa32kX9V6sXoL1eA>
    <xmx:aKD-aCqP11wzzWqNtwvTCTmSPppqE5RmiypmbS8EOP5pqBFT_IbE6w>
    <xmx:aKD-aJ51pmiozeRI6myGkE-089P47tYW8pGgQoDbcVjge_1NcbmSRl6H>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:50 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 08/10] nfsd: discard ->op_set_currentstateid()
Date: Mon, 27 Oct 2025 09:23:53 +1100
Message-ID: <20251026222655.3617028-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251026222655.3617028-1-neilb@ownmail.net>
References: <20251026222655.3617028-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

It is not clear that the indirection provided by op_set_currentstateid()
adds any value.
It is only called immediately after the only call to ->op_func().

This patch discards op_set_currentstateid() and instead interpolates the
contents (each a single call to nfsd41_save_current_stateid()) into each
relevant op_func()

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 12 ------------
 fs/nfsd/nfs4proc.c        |  8 +-------
 fs/nfsd/nfs4state.c       | 35 ++++-------------------------------
 fs/nfsd/xdr4.h            |  2 --
 4 files changed, 5 insertions(+), 52 deletions(-)

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
index 25a91e9b7433..9dce3004b846 100644
--- a/fs/nfsd/current_stateid.h
+++ b/fs/nfsd/current_stateid.h
@@ -5,16 +5,4 @@
 #include "state.h"
 #include "xdr4.h"
 
-/*
- * functions to set current state id
- */
-extern void nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_set_openstateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_set_lockstateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_set_closestateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-
 #endif   /* _NFSD4_CURRENT_STATE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b0a12436b638..54564e09cf99 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -644,6 +644,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	nfsd4_cleanup_open_state(cstate, open);
 	nfsd4_bump_seqid(cstate, status);
+	nfsd41_save_current_stateid(cstate, &u->open.op_stateid);
 	return status;
 }
 
@@ -2952,9 +2953,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
-		if (op->opdesc->op_set_currentstateid)
-			op->opdesc->op_set_currentstateid(cstate, &op->u);
-
 		if (op->opdesc->op_flags & OP_CLEAR_STATEID)
 			nfsd41_clear_current_stateid(cstate);
 
@@ -3398,7 +3396,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
 		.op_func = nfsd4_commit,
@@ -3443,7 +3440,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 				OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_LOCK",
 		.op_rsize_bop = nfsd4_lock_rsize,
-		.op_set_currentstateid = nfsd4_set_lockstateid,
 	},
 	[OP_LOCKT] = {
 		.op_func = nfsd4_lockt,
@@ -3480,7 +3476,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN",
 		.op_rsize_bop = nfsd4_open_rsize,
-		.op_set_currentstateid = nfsd4_set_openstateid,
 	},
 	[OP_OPEN_CONFIRM] = {
 		.op_func = nfsd4_open_confirm,
@@ -3493,7 +3488,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d870c933be56..96c490f24527 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7739,6 +7739,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	nfs4_put_stid(&stp->st_stid);
 out:
 	nfsd4_bump_seqid(cstate, status);
+	nfsd41_save_current_stateid(cstate, &u->open_downgrade.od_stateid);
 	return status;
 }
 
@@ -7823,6 +7824,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
 out:
+	nfsd41_save_current_stateid(cstate, &close->cl_stateid);
 	return status;
 }
 
@@ -8458,6 +8460,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	nfsd4_bump_seqid(cstate, status);
 	if (conflock)
 		locks_free_lock(conflock);
+	nfsd41_save_current_stateid(cstate, &lock->lk_resp_stateid);
+
 	return status;
 }
 
@@ -9138,37 +9142,6 @@ void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate)
 	nfsd41_save_current_stateid(cstate, &anon_stateid);
 }
 
-/*
- * functions to set current state id
- */
-void
-nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_save_current_stateid(cstate, &u->open_downgrade.od_stateid);
-}
-
-void
-nfsd4_set_openstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_save_current_stateid(cstate, &u->open.op_stateid);
-}
-
-void
-nfsd4_set_closestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_save_current_stateid(cstate, &u->close.cl_stateid);
-}
-
-void
-nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_save_current_stateid(cstate, &u->lock.lk_resp_stateid);
-}
-
 /**
  * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
  * @req: timestamp from the client
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a5fc2d459661..e4357d79271f 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1044,8 +1044,6 @@ struct nfsd4_operation {
 	/* Try to get response size before operation */
 	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
 			const struct nfsd4_op *op);
-	void (*op_set_currentstateid)(struct nfsd4_compound_state *,
-			union nfsd4_op_u *);
 };
 
 struct nfsd4_cb_recall_any {
-- 
2.50.0.107.gf914562f5916.dirty


