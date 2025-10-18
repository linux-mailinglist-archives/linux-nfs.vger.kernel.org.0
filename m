Return-Path: <linux-nfs+bounces-15352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D6ABEC13F
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 905894F608B
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2359EC8E6;
	Sat, 18 Oct 2025 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ub2XoQXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="caoVeqYB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11CE33EC
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745974; cv=none; b=Idqa4kvgVrroSXCjmOKS6c3p7luFna+QnmhThBnAQ9tClkxiEeKg+vAICdoWYzE6h3cdPZNXWxm4Aksy3jPojEAJ2nfy5Id9keOe8J+iFWybwoYFlyVojglvDwLrZ657MidaePzSxDQKBPpu8yfmtaC7AITeqSk2zoa3B9MleT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745974; c=relaxed/simple;
	bh=3zBF5XXm9vP9spSq06z8UCqLDJgGQ1r9SwrQaA406oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICqiNLpN3VOUF0rLZMUojUST/vucB83IMm2mX6Y6mWtfBpvwTJ1SyqCDKG9ou3oWfCQsQfrrqwzei6XvupTLnup/FbOVFIUCNZIfoVBMJQixP1081YHpNJvu/H7Ghk7uvxTTFP2ZbZXuujiWCAthFvHOoSx/9Q6+YrFu4C/kyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ub2XoQXy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=caoVeqYB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DA32C1D000DD;
	Fri, 17 Oct 2025 20:06:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 17 Oct 2025 20:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760745970;
	 x=1760832370; bh=sUa9SYpCdWfmvtWXhr4GF7whAZRS90NhY5Y4G5wxXIg=; b=
	Ub2XoQXyWDaDV9ziKBTBeatveuKEW2K44Hee883hnuk5l5uKFDUZbvyq3vEwo1bi
	RvXj0h6OHYn6zvK6s6sbTPAMVXt1xox9WT2z0EXRYTrqsgM5WC6JvbWXlwuvmRQK
	67OpNVyo/NeDBwHHOevRMAm4peT82Wl6WzPDumen944Lw53usu2pj/+dYQkF5/cl
	rdgliXbmsY4ASdfZqxfK5fGZUDeNP0z+R+kBW2ejNdUfKojv7ulyvySlBqQIuCus
	255N0wXc5t3bHedcQo1pHylMG+2NuLMyDNehBiLDoNQoUoHjrZ0O/dugbsudWXYr
	PRj2h70oEmp10z5G21trzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760745970; x=1760832370; bh=s
	Ua9SYpCdWfmvtWXhr4GF7whAZRS90NhY5Y4G5wxXIg=; b=caoVeqYBXP741+I+H
	uhcyq9ysc9wI1BsxA+1o1YO2HDfVn9+ai43qgezXINVIGrbm2ZDBsqgadjvRTblU
	q6PRlpOfhJixxt62rWczLQ3Cr20yfjd+c6f1uV6uZ1zNj4mLb+LJTnLdkqcdp+qj
	ToPi0HTC1eH0gcc2nvN/r3ME6Q+S9VVaIA7/MkwmXxWasK8e28cA7OTG8zkEmVz+
	7MnMhxGJUbvoSGfmR1IA8w4fPS36VE4Me6XTep/v5V2nJ240/7l8lLJ2sf2d+1uQ
	D8wZitwZQ0c+Xcvkzl+7sU2eESbIOnifpN6ZFTFxsLrSSOmnQhJkZYUQtudXk8Py
	ka9uw==
X-ME-Sender: <xms:8tnyaIuVMRjdWFYodVL66kYHPlMKQnWv2RWJWyrG5bLgoqNWVNISoA>
    <xme:8tnyaJLPDDdSKEru7DcDuTgwOT8tTiVkGc3uEl7MoVqFjkxK14om0oD9laHgytN3m
    clVlqIKLBa2IFczYr3r_KgLehThnvYnFLAo1KftdEZshzR74A>
X-ME-Received: <xmr:8tnyaNnnTDK41CfE_SnMjhyybTMUXrRLaBqRZbrMu9Cnl-bocWhFcgFUd4S8_g7OlITz4tEOAxjuonpExdeMxkJ2vxVLn_DStFV6mz8eLivA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8tnyaCIdBVFBwf1rKGiMu4RQAMTQW4ComX-BxfG6t-qW8GF4D9_SBg>
    <xmx:8tnyaK7CJ9UZPCTlUN9TMihEAA7ATGd7UR4aOIxaA2P1c-9gBjMNYQ>
    <xmx:8tnyaO1WbmYT0blqUJ9cOsCdbnWs5GIu1CJYCNdg7GjucL0iGZNhHQ>
    <xmx:8tnyaIdnmHX2Y3UXI3eJgy3SEJNaNk96T1kQvAuyB6OzI8lV8j5kJQ>
    <xmx:8tnyaGOi7OpHW-DofJI4Q-6sJP_gGgWF_5fD2ysWq5YpPSYO9wcNWx-c>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:06:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] nfsd: discard v4 ->op_get_currentstateid() function
Date: Sat, 18 Oct 2025 11:02:22 +1100
Message-ID: <20251018000553.3256253-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251018000553.3256253-1-neilb@ownmail.net>
References: <20251018000553.3256253-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

It isn't clear to me that the indirection involved in
op_get_currentstateid() serves any purpose.

op_get_currentstateid() is only called immediately before the only place
op_func is called, so the former can easily be folded into the latter.
The functions themselves are trivial, each a single line.  Including
these in the relevant op_func functions works well.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 23 ++-----------
 fs/nfsd/nfs4proc.c        | 15 +++------
 fs/nfsd/nfs4state.c       | 70 +++++----------------------------------
 fs/nfsd/xdr4.h            |  2 --
 4 files changed, 15 insertions(+), 95 deletions(-)

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
index c28540d86742..7c6dfd6c88e7 100644
--- a/fs/nfsd/current_stateid.h
+++ b/fs/nfsd/current_stateid.h
@@ -5,7 +5,8 @@
 #include "state.h"
 #include "xdr4.h"
 
-extern void clear_current_stateid(struct nfsd4_compound_state *cstate);
+void clear_current_stateid(struct nfsd4_compound_state *cstate);
+void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
 /*
  * functions to set current state id
  */
@@ -18,24 +19,4 @@ extern void nfsd4_set_lockstateid(struct nfsd4_compound_state *,
 extern void nfsd4_set_closestateid(struct nfsd4_compound_state *,
 		union nfsd4_op_u *);
 
-/*
- * functions to consume current state id
- */
-extern void nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_get_freestateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_get_setattrstateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_get_closestateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_get_lockustateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_get_readstateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-extern void nfsd4_get_writestateid(struct nfsd4_compound_state *,
-		union nfsd4_op_u *);
-
 #endif   /* _NFSD4_CURRENT_STATE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9d53ea289bf3..41a8db955aa3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -949,6 +949,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_read *read = &u->read;
 	__be32 status;
 
+	get_stateid(cstate, &read->rd_stateid);
 	read->rd_nf = NULL;
 
 	trace_nfsd_read_start(rqstp, &cstate->current_fh,
@@ -1153,6 +1154,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status = nfs_ok;
 	int err;
 
+	get_stateid(cstate, &setattr->sa_stateid);
 	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
 					      FATTR4_WORD2_TIME_DELEG_MODIFY);
 
@@ -1240,6 +1242,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status = nfs_ok;
 	unsigned long cnt;
 
+	get_stateid(cstate, &write->wr_stateid);
+
 	if (write->wr_offset > (u64)OFFSET_MAX ||
 	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
 		return nfserr_fbig;
@@ -2914,8 +2918,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->status)
 			goto encode_op;
 
-		if (op->opdesc->op_get_currentstateid)
-			op->opdesc->op_get_currentstateid(cstate, &op->u);
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
@@ -3365,7 +3367,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_closestateid,
 		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
@@ -3385,7 +3386,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_DELEGRETURN",
 		.op_rsize_bop = nfsd4_only_status_rsize,
-		.op_get_currentstateid = nfsd4_get_delegreturnstateid,
 	},
 	[OP_GETATTR] = {
 		.op_func = nfsd4_getattr,
@@ -3424,7 +3424,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_LOCKU",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_lockustateid,
 	},
 	[OP_LOOKUP] = {
 		.op_func = nfsd4_lookup,
@@ -3461,7 +3460,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_opendowngradestateid,
 		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
@@ -3489,7 +3487,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_func = nfsd4_read,
 		.op_name = "OP_READ",
 		.op_rsize_bop = nfsd4_read_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_READDIR] = {
 		.op_func = nfsd4_readdir,
@@ -3546,7 +3543,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME
 				| OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_rsize_bop = nfsd4_setattr_rsize,
-		.op_get_currentstateid = nfsd4_get_setattrstateid,
 	},
 	[OP_SETCLIENTID] = {
 		.op_func = nfsd4_setclientid,
@@ -3573,7 +3569,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_WRITE",
 		.op_rsize_bop = nfsd4_write_rsize,
-		.op_get_currentstateid = nfsd4_get_writestateid,
 	},
 	[OP_RELEASE_LOCKOWNER] = {
 		.op_func = nfsd4_release_lockowner,
@@ -3653,7 +3648,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_func = nfsd4_free_stateid,
 		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_FREE_STATEID",
-		.op_get_currentstateid = nfsd4_get_freestateid,
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_GET_DIR_DELEGATION] = {
@@ -3718,7 +3712,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_func = nfsd4_read,
 		.op_name = "OP_READ_PLUS",
 		.op_rsize_bop = nfsd4_read_plus_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_SEEK] = {
 		.op_func = nfsd4_seek,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1e821f5d09a3..18c8d3529d55 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7487,6 +7487,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client *cl = cstate->clp;
 	__be32 ret = nfserr_bad_stateid;
 
+	get_stateid(cstate, &free_stateid->fr_stateid);
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s || s->sc_status & SC_STATUS_CLOSED)
@@ -7707,6 +7708,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	dprintk("NFSD: nfsd4_open_downgrade on file %pd\n", 
 			cstate->current_fh.fh_dentry);
 
+	get_stateid(cstate, &od->od_stateid);
 	/* We don't yet support WANT bits: */
 	if (od->od_deleg_want)
 		dprintk("NFSD: %s: od_deleg_want=0x%x ignored\n", __func__,
@@ -7781,6 +7783,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("NFSD: nfsd4_close on file %pd\n",
 			cstate->current_fh.fh_dentry);
 
+	get_stateid(cstate, &close->cl_stateid);
+
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
 					  &close->cl_stateid,
 					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
@@ -7832,6 +7836,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
+	get_stateid(cstate, &dr->dr_stateid);
+
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
@@ -8575,6 +8581,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		(long long) locku->lu_offset,
 		(long long) locku->lu_length);
 
+	get_stateid(cstate, &locku->lu_stateid);
+
 	if (check_lock_length(locku->lu_offset, locku->lu_length))
 		 return nfserr_inval;
 
@@ -9066,7 +9074,7 @@ nfs4_state_shutdown(void)
 	shrinker_free(nfsd_slot_shrinker);
 }
 
-static void
+void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
 	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
@@ -9120,66 +9128,6 @@ nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
 	put_stateid(cstate, &u->lock.lk_resp_stateid);
 }
 
-/*
- * functions to consume current state id
- */
-
-void
-nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	get_stateid(cstate, &u->open_downgrade.od_stateid);
-}
-
-void
-nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	get_stateid(cstate, &u->delegreturn.dr_stateid);
-}
-
-void
-nfsd4_get_freestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	get_stateid(cstate, &u->free_stateid.fr_stateid);
-}
-
-void
-nfsd4_get_setattrstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	get_stateid(cstate, &u->setattr.sa_stateid);
-}
-
-void
-nfsd4_get_closestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	get_stateid(cstate, &u->close.cl_stateid);
-}
-
-void
-nfsd4_get_lockustateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	get_stateid(cstate, &u->locku.lu_stateid);
-}
-
-void
-nfsd4_get_readstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	get_stateid(cstate, &u->read.rd_stateid);
-}
-
-void
-nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	get_stateid(cstate, &u->write.wr_stateid);
-}
-
 /**
  * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
  * @req: timestamp from the client
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 2a347c1bc3e7..b94408601203 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1043,8 +1043,6 @@ struct nfsd4_operation {
 	/* Try to get response size before operation */
 	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
 			const struct nfsd4_op *op);
-	void (*op_get_currentstateid)(struct nfsd4_compound_state *,
-			union nfsd4_op_u *);
 	void (*op_set_currentstateid)(struct nfsd4_compound_state *,
 			union nfsd4_op_u *);
 };
-- 
2.50.0.107.gf914562f5916.dirty


