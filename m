Return-Path: <linux-nfs+bounces-15552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22356BFE6F7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0362E4E84FF
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7826F443;
	Wed, 22 Oct 2025 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BcPG6LxK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eyn0f9EE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A271301715
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172670; cv=none; b=Pz6rp7ZMndE5JAXFcrQOPcljvB10Ar7aELg25P0lV1/AUs3Yesc/6ASHubqiJ7oElHj5Pul4Z4GhtY4JMRMWNFAaoypNaRf4g2TQWkQyVfme6QORB7lLGXOIARuadLS9R3CP3FYrOMJC8fFhbtmPHF/bEmPcwKA4B2IL0YUowOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172670; c=relaxed/simple;
	bh=do9NTHMoEF8GFLHqmHoCq8kAKk6OaMzGhVRSorICG+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDtRDLTSUzQ15keBA2dCthKjJiOpgdNzLEbAnC9mrOUM4XRrVJK8Hi20g7goPzYiHPD4dSUs+JdOlByWe58+/p5wENGZ/YU1RIH28D8B/O4b3hIQUL+j+1Gm1kfrhwoHPZhg8xsukfQQVAIcFt5FeKd7c2m68IznuQ4JLmps37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BcPG6LxK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eyn0f9EE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CB462EC01B4;
	Wed, 22 Oct 2025 18:37:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 22 Oct 2025 18:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761172667;
	 x=1761259067; bh=T9BVu3urUGAKgNOItMLM1X+uGoeabxeqwpcyJ2iSAj4=; b=
	BcPG6LxKSLt67fHJKNStGqCMyG4g7BKwPmL/Ye3EjK2uheqIRwQvQlLHWMqmVLnR
	Tv/+h/GmHe0TW7ONyewLs6DLZhuveQs5AqdKe4Vzi8kdxo3m6j/895FMwrf82wz4
	ej2+zBT2FLQ1RV1MIbThGQqEA14zaMcrQQoPtlEKwb4h92dwYH6uAldiO6wY2Qjo
	27RB4uOBppUXq+6/a15ffBfHr/q+6/dFRaS1oeqxQwl35gcO+SC52OfEB2/6aFz+
	DsFsVi9jZsp5eyzjwhF0uCWUQfVkr1xlOIYBXj7JKtAsspPug0pnA/jPopVMhoCY
	Xjy2xytAVNJb7Kufvcsi/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761172667; x=1761259067; bh=T
	9BVu3urUGAKgNOItMLM1X+uGoeabxeqwpcyJ2iSAj4=; b=eyn0f9EELqI+anGGV
	bvUo5VhRhpHabMT30j+P0UAMkdxTwu078kcgHoE9FEngWXVhRa6cKeW3ay/hwN0z
	xTjSnUfgs4Y9N7ddlJmsKf4k0GrMpKeMMs5Kic2ZLcMUmsVUMx8gYv/wL45FScQQ
	OrmFge0mCC7a57mIkcP8SH00Km89fnsqrAeFBaBWaKr4PHp1H5IdwFw70/aRDmHI
	lI6fua5JrKBQW+cUYYzhuFzpc2ZoKCkuROvT8SvCZAmN4w6WHM7YtAis0zompQVt
	xp5AqrOS6/gB6U7gh474BtjL3Foik4ni8iLi6m8hrFr5EkiD67OZ/ar0H5wxlmpi
	fwE5g==
X-ME-Sender: <xms:u1z5aKDJONFocN5DGp2TauquRp4wpOOLp3lqdvdTqf2wGLX5H_TEdQ>
    <xme:u1z5aIPaRLFsSxMaiQwPWThzPTjk1wysm4PRzgVn9IpvEY5levUGFW_03ObvQVASl
    LA58XtpGvUxoHlmjCh1wL731GT8tAsbwgBEpCEAktqm3a-7CQ>
X-ME-Received: <xmr:u1z5aHYWKqqKZ0857EAC_IzMnP-LY259Kf01pts6M4wySwJ3tRMKCETwVpFcVzG7QddlQqLwYuEP5P3S_vIWx-mjPdH0hGLK_s30qUyEImOb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:u1z5aPsDzzAkeFWe8P_DKOKykEU8CQUsDKrCq4se4BJZEgPZMyYNkA>
    <xmx:u1z5aBMDkoF47EfweGIuDsLgHB8XldTtnRvA8_96bhHOPmMqX069IQ>
    <xmx:u1z5aO5_ojhhwflLINt1HFkzEmq28HHg7hXGws6iwxEmVSsYSmAe7g>
    <xmx:u1z5aPTCkH1vfz7VNHAnZi0WmzEcNKFLftAGL_Da67wOY9b7FQXDsQ>
    <xmx:u1z5aLjiQLaVXVJviA5O7HL4-ieR4Pa-lD-MHrwruWNuVCtBcL6KRuiS>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:45 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/8] nfsd: discard ->op_set_currentstateid()
Date: Thu, 23 Oct 2025 09:34:32 +1100
Message-ID: <20251022223713.1217694-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022223713.1217694-1-neilb@ownmail.net>
References: <20251022223713.1217694-1-neilb@ownmail.net>
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
index 805bb6744251..8d21fc900fc7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -644,6 +644,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	nfsd4_cleanup_open_state(cstate, open);
 	nfsd4_bump_seqid(cstate, status);
+	nfsd41_save_current_stateid(cstate, &u->open.op_stateid);
 	return status;
 }
 
@@ -2958,9 +2959,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
-		if (op->opdesc->op_set_currentstateid)
-			op->opdesc->op_set_currentstateid(cstate, &op->u);
-
 		if (op->opdesc->op_flags & OP_CLEAR_STATEID)
 			nfsd41_clear_current_stateid(cstate);
 
@@ -3404,7 +3402,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
 		.op_func = nfsd4_commit,
@@ -3449,7 +3446,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 				OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_LOCK",
 		.op_rsize_bop = nfsd4_lock_rsize,
-		.op_set_currentstateid = nfsd4_set_lockstateid,
 	},
 	[OP_LOCKT] = {
 		.op_func = nfsd4_lockt,
@@ -3486,7 +3482,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN",
 		.op_rsize_bop = nfsd4_open_rsize,
-		.op_set_currentstateid = nfsd4_set_openstateid,
 	},
 	[OP_OPEN_CONFIRM] = {
 		.op_func = nfsd4_open_confirm,
@@ -3499,7 +3494,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 97541a2b9717..429ed80a13a7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7744,6 +7744,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	nfs4_put_stid(&stp->st_stid);
 out:
 	nfsd4_bump_seqid(cstate, status);
+	nfsd41_save_current_stateid(cstate, &u->open_downgrade.od_stateid);
 	return status;
 }
 
@@ -7828,6 +7829,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
 out:
+	nfsd41_save_current_stateid(cstate, &close->cl_stateid);
 	return status;
 }
 
@@ -8463,6 +8465,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	nfsd4_bump_seqid(cstate, status);
 	if (conflock)
 		locks_free_lock(conflock);
+	nfsd41_save_current_stateid(cstate, &lock->lk_resp_stateid);
+
 	return status;
 }
 
@@ -9133,37 +9137,6 @@ nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate, stateid_t *stat
 	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
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
index a87e7523cea0..94af863fac0e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1063,8 +1063,6 @@ struct nfsd4_operation {
 	/* Try to get response size before operation */
 	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
 			const struct nfsd4_op *op);
-	void (*op_set_currentstateid)(struct nfsd4_compound_state *,
-			union nfsd4_op_u *);
 };
 
 struct nfsd4_cb_recall_any {
-- 
2.50.0.107.gf914562f5916.dirty


