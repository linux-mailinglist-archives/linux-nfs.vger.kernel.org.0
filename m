Return-Path: <linux-nfs+bounces-15638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25D7C0B5D7
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7185A3B161F
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64981F4CAE;
	Sun, 26 Oct 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ix16f/Of";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qtUmb1/N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CD1F30C3
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517670; cv=none; b=Z1VPpR1WLfldCISz9Lr1RA3bfi++q9idZB3EWGgqag8n98PcEWPwkW69hTezpTydmCXCbTcE4wd1WFrjECWQR8AO4Di5pK9zm7AjCO3yerN5nPD1QcqXCXZtST885FZCBAnxGdtOLs/egNNgDBTqPxuUCt+pwpLw1+d2GwwBXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517670; c=relaxed/simple;
	bh=yviz5x7MrmSoO2zLguEv+QBtfvgJM/+q6PIhmzbkBz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ8yVU43zDTnLKyBR8D/Xq5plA8mDDNMBB/qVT86ZVgrYSwuof2+6B/0HNFwwQhX30sU5Xb0Lsj/AxHGJtCU47nX3mYMBag++Vr8WcbnM5xux2Bk3ymsf2541QuZLQa2JARcwQcax4Htha8RhC5/pM046YXaHgHhQ6qJu9/Bg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ix16f/Of; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qtUmb1/N; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E380A1D001B0;
	Sun, 26 Oct 2025 18:27:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 26 Oct 2025 18:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517667;
	 x=1761604067; bh=y1E2QgIYuB7Uy3E+HVFykw1INkoRX5rpDNpbLPPco5c=; b=
	Ix16f/Of+kT2T6dbqexUVpeZOcwwrZzZfJXthLRfeJ6dXY2rv//rjPYPuCtHzB66
	/mlqHwJZa/MVd72hh2APAD0DqGthfT1SBe9JILYG1UJav2Nn4RFUWbMlIEG9hd7/
	3SPV7VO96E4WpFSeozdX9wnA5pJi+Q+rc2/9gj9vtw89nqVkGsjfmiGCiCl4P6oA
	MdheIpa2lWyvviamqWobafarDVG4MhnXNKBa8sVHJpzRqG8NnOqxYJW9ALCvi98r
	ZQYom3KbXNtVUt0RklTm88xmzvzopjpOTybLK7bwATudY41//SwuKPWBc2uiNpmW
	JN4RPzcihHJwEvZz9+SrVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517667; x=1761604067; bh=y
	1E2QgIYuB7Uy3E+HVFykw1INkoRX5rpDNpbLPPco5c=; b=qtUmb1/NRZmmLwIaU
	e1Ckrux8ZHzmK154lMtHhHldUi0RIhp/cjYnPGJuPi3cV3PrextCZlJE4EivY0ry
	2YEESMGndWOarnBTbvsdknWZh8Jy0JBvaldezXFsLvoCZVbBshS5e0nROrfJR57H
	2BMJ1v+vroH3V7mcLq0/Ox8Vflyqq9NX2zmiRHlx9NTi+JzkcbZN/NwGmdyRJp2X
	dJBrXL9jGVpgjuAO7g4A8GwK5zT/4IyOI9VCtXnD/IWXY/OorYP88jj8sFpASQ+v
	bDgp3gmK2IpKUJ2+/VI0kSOKpoNzV95/fTC24FqK5d+KwJacOwdoezgR6EjiCiRo
	m4oig==
X-ME-Sender: <xms:Y6D-aMw-n8Mac6jM8fKz8C0DVvM-A6gVS_PYaKVIbo2q6Cx6GH-f5A>
    <xme:Y6D-aD9GuiAt1LOtj2iIgWiF3eeXI9JPlCjvTVoNtZdx6tfo9XQt964RxVkyLbBa1
    BciXLxhWNUwEclqIcy2IzErFC-WRcCr0bn8W4kMo2veCtihHg>
X-ME-Received: <xmr:Y6D-aILdQ_fFpeylhl-i6HKkQGqwYDvPKmAjY4REX3gNkaylczMmvNYBWy2MgesXnf-v6a7LF1BXlqp4UOTIIMyzMa0p7fmaVMQQ563motLi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Y6D-aBeMrRSDq9AAZNi5zttuM-vSRRvCWbEAbxw3bSKvFzRxwLO9Pw>
    <xmx:Y6D-aP8eazdkcD_Na-EwvzFZkQ864EWpGiXHuPqgxz5FxGMR9kFufQ>
    <xmx:Y6D-aGpruRomHwypKGMYGY0dfk337_xMQzXItkmwFiic-zpZd7yeWg>
    <xmx:Y6D-aMBuNPe1n2E-xtnhqliTjoJvmIrn07we9oFUswpd226AkIkuyQ>
    <xmx:Y6D-aOQGsbTgt9FYBlGKihikxKLr15t6mMO2h7ItWH4zTI9zAI6SPmnJ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:45 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 07/10] nfsd: discard v4 ->op_get_currentstateid() function
Date: Mon, 27 Oct 2025 09:23:52 +1100
Message-ID: <20251026222655.3617028-8-neilb@ownmail.net>
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

It isn't clear to me that the indirection involved in
op_get_currentstateid() serves any purpose.

op_get_currentstateid() is only called immediately before the only place
op_func is called, so the former can easily be folded into the latter.
The functions themselves are trivial, each a single line.  Including
these in the relevant op_func functions works well.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 20 ------------
 fs/nfsd/nfs4proc.c        | 15 +++------
 fs/nfsd/nfs4state.c       | 68 +++++----------------------------------
 fs/nfsd/xdr4.h            |  2 --
 4 files changed, 12 insertions(+), 93 deletions(-)

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
index 24d769043207..25a91e9b7433 100644
--- a/fs/nfsd/current_stateid.h
+++ b/fs/nfsd/current_stateid.h
@@ -17,24 +17,4 @@ extern void nfsd4_set_lockstateid(struct nfsd4_compound_state *,
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
index 995ac3c4c150..b0a12436b638 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -943,6 +943,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_read *read = &u->read;
 	__be32 status;
 
+	nfsd41_get_current_stateid(cstate, &read->rd_stateid);
 	read->rd_nf = NULL;
 
 	trace_nfsd_read_start(rqstp, &cstate->current_fh,
@@ -1172,6 +1173,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status = nfs_ok;
 	int err;
 
+	nfsd41_get_current_stateid(cstate, &setattr->sa_stateid);
 	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
 					      FATTR4_WORD2_TIME_DELEG_MODIFY);
 
@@ -1259,6 +1261,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status = nfs_ok;
 	unsigned long cnt;
 
+	nfsd41_get_current_stateid(cstate, &write->wr_stateid);
+
 	if (write->wr_offset > (u64)OFFSET_MAX ||
 	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
 		return nfserr_fbig;
@@ -2945,8 +2949,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->status)
 			goto encode_op;
 
-		if (op->opdesc->op_get_currentstateid)
-			op->opdesc->op_get_currentstateid(cstate, &op->u);
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
@@ -3396,7 +3398,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_closestateid,
 		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
@@ -3416,7 +3417,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_DELEGRETURN",
 		.op_rsize_bop = nfsd4_only_status_rsize,
-		.op_get_currentstateid = nfsd4_get_delegreturnstateid,
 	},
 	[OP_GETATTR] = {
 		.op_func = nfsd4_getattr,
@@ -3457,7 +3457,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_LOCKU",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_lockustateid,
 	},
 	[OP_LOOKUP] = {
 		.op_func = nfsd4_lookup,
@@ -3494,7 +3493,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_opendowngradestateid,
 		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
@@ -3523,7 +3521,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ",
 		.op_rsize_bop = nfsd4_read_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_READDIR] = {
 		.op_func = nfsd4_readdir,
@@ -3581,7 +3578,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME
 				| OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_rsize_bop = nfsd4_setattr_rsize,
-		.op_get_currentstateid = nfsd4_get_setattrstateid,
 	},
 	[OP_SETCLIENTID] = {
 		.op_func = nfsd4_setclientid,
@@ -3608,7 +3604,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_WRITE",
 		.op_rsize_bop = nfsd4_write_rsize,
-		.op_get_currentstateid = nfsd4_get_writestateid,
 	},
 	[OP_RELEASE_LOCKOWNER] = {
 		.op_func = nfsd4_release_lockowner,
@@ -3690,7 +3685,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_func = nfsd4_free_stateid,
 		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_FREE_STATEID",
-		.op_get_currentstateid = nfsd4_get_freestateid,
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_GET_DIR_DELEGATION] = {
@@ -3758,7 +3752,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ_PLUS",
 		.op_rsize_bop = nfsd4_read_plus_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_SEEK] = {
 		.op_func = nfsd4_seek,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index af6bd0248b8a..d870c933be56 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7488,6 +7488,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client *cl = cstate->clp;
 	__be32 ret = nfserr_bad_stateid;
 
+	nfsd41_get_current_stateid(cstate, &free_stateid->fr_stateid);
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s || s->sc_status & SC_STATUS_CLOSED)
@@ -7708,6 +7709,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	dprintk("NFSD: nfsd4_open_downgrade on file %pd\n", 
 			cstate->current_fh.fh_dentry);
 
+	nfsd41_get_current_stateid(cstate, &od->od_stateid);
 	/* We don't yet support WANT bits: */
 	if (od->od_deleg_want)
 		dprintk("NFSD: %s: od_deleg_want=0x%x ignored\n", __func__,
@@ -7782,6 +7784,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("NFSD: nfsd4_close on file %pd\n",
 			cstate->current_fh.fh_dentry);
 
+	nfsd41_get_current_stateid(cstate, &close->cl_stateid);
+
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
 					  &close->cl_stateid,
 					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
@@ -7833,6 +7837,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
+	nfsd41_get_current_stateid(cstate, &dr->dr_stateid);
+
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
@@ -8592,6 +8598,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		(long long) locku->lu_offset,
 		(long long) locku->lu_length);
 
+	nfsd41_get_current_stateid(cstate, &locku->lu_stateid);
+
 	if (check_lock_length(locku->lu_offset, locku->lu_length))
 		 return nfserr_inval;
 
@@ -9161,66 +9169,6 @@ nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
 	nfsd41_save_current_stateid(cstate, &u->lock.lk_resp_stateid);
 }
 
-/*
- * functions to consume current state id
- */
-
-void
-nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_get_current_stateid(cstate, &u->open_downgrade.od_stateid);
-}
-
-void
-nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_get_current_stateid(cstate, &u->delegreturn.dr_stateid);
-}
-
-void
-nfsd4_get_freestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_get_current_stateid(cstate, &u->free_stateid.fr_stateid);
-}
-
-void
-nfsd4_get_setattrstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_get_current_stateid(cstate, &u->setattr.sa_stateid);
-}
-
-void
-nfsd4_get_closestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_get_current_stateid(cstate, &u->close.cl_stateid);
-}
-
-void
-nfsd4_get_lockustateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_get_current_stateid(cstate, &u->locku.lu_stateid);
-}
-
-void
-nfsd4_get_readstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_get_current_stateid(cstate, &u->read.rd_stateid);
-}
-
-void
-nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	nfsd41_get_current_stateid(cstate, &u->write.wr_stateid);
-}
-
 /**
  * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
  * @req: timestamp from the client
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 3aebc62e4b09..a5fc2d459661 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1044,8 +1044,6 @@ struct nfsd4_operation {
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


