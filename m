Return-Path: <linux-nfs+bounces-15551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8405EBFE6F4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B54E4242
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3720288C20;
	Wed, 22 Oct 2025 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EDbNpyCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vFiHfC75"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6827F01B
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172666; cv=none; b=mC7RYcgGvV4wpTw9sRzCMTu7Yy+w6FPYvUrzcZnjbj+b6ZK7mkJrL7UEcRP0mPqtIMEgLQ34fw9HBNjN7XXVsgnJuFR2J+UDv1PBzd76evjlRih1Q88xmEbYxa9HJNNuOkxG9GodrMUn7iF4bG92iiQFmGXOm7jfYi/4PlfM0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172666; c=relaxed/simple;
	bh=U4hdyDX9WQhgErijEKqWr0zQFzmz+fvaV03oW1TfndY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvE/LHHILMMvOzksVF7CbNjgyhkGMnr8o1xxv5QroHPYaRypIYIgprAkDtKPxsqtQcxxNHifoW2BRKeYlw4Wxk2TnRU/WuiiTOLAZ9BxyJfwGtezrpz5jZX0Oox8JbM5XWw3YHF7AcWSWPNCPtfJMyzTUKW0swbPpHEQ+T8oRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EDbNpyCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vFiHfC75; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FDEFEC010A;
	Wed, 22 Oct 2025 18:37:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 18:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761172663;
	 x=1761259063; bh=HVFD3SEXmmxCpWEbN3AdOIzzoHl43/ygtWD/O74VukY=; b=
	EDbNpyCCdyXGdudeyIgs1ZNxPIoEl/CeCAT6rfcKN/9gOXy5oFcWfY8Rh5gbq/lj
	kSgIiUWWiDR9NJEPZz0vnD2YdecwP0D+ki6iCWKWyBXw9lbaOWXHEqgLEDRpjRfQ
	MO+Kq5wAiUd9KzcgxbTOnefFskXMVKPjG4r1BmazH9HULidzNoHCPT5XZqXW3imF
	NnlBVb7332RepJHbzKMC9ntZo5HGGFTk+XaZu1nujIR6Ca7ytp8WU6juFxi93cAN
	dCkhHPWPaYdP/LfYqYDONsR9QmnrOMu3x19edNSJ5nYKKcuYOF88k0mYgnMRfu28
	0zJSYnHxZg1As9K8oeHRoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761172663; x=1761259063; bh=H
	VFD3SEXmmxCpWEbN3AdOIzzoHl43/ygtWD/O74VukY=; b=vFiHfC754k6dIIuJC
	dT7uzPIZptNWqGNxb9vmD+kjKdX4nkd00bG33U9BXVHYzjgATRaWry5IY4yZXFw4
	gHNRCRFa9i8JRLOX7IL6iSKHM/oyesl3vWseJTuzDqY8VjY2inAHaJBfli12PowO
	aTWAJGrqppQ7S/FiXfjO/nuwD+wkGP6YZoray/vg2XVkus3wiPnWzeOk/dy+TeUC
	j1f3T0mlXZiwY51R+peMiJLeq+ap57E3LU6nTBmISw6WxL/s7Fn+v1bGUCMYUuXW
	RQeHfNUBXA/FzpOMe5vfPzf6cOnJtxSB6UX3hSZdMsSRCq76vRdDXR7/UTr4gGD2
	eortQ==
X-ME-Sender: <xms:t1z5aAIM7Rku0zHNyP2YxME9BirqWhIJ5_DDCAUUCjTDRlk_y7TfaQ>
    <xme:t1z5aD0qAcgPM0ldmwrynGkTTLcwOwIdWma8xxwTWKmsmzKv4P1eBLg_6RcM0YwXb
    lPbOCV35qSyrr4a32_ghf2FPsA_hD9nibfh6ARi54oY_RyJBQ>
X-ME-Received: <xmr:t1z5aKgkcVOIE9UFMZg34zKxuHGg3-i43i-oOar564G8VZz2jxZINEIZLZ_R4UoNF1aHQIZ3_q5xZv4QlSg46eIjgSu96d9m9AKHdQQ_fyg1>
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
X-ME-Proxy: <xmx:t1z5aEX76IxgoUVKuJnwB_0OBfWiKQCQn5A4ZSt9eCYzZnl3qjdWUQ>
    <xmx:t1z5aJXJBDEeJoqkkNAqouytywjMc6kbJDlv626cZOQ6pvIYnbVJkA>
    <xmx:t1z5aEjRscaWkgz_AVjO6hLZgvwKu4ahFKePoPfEfxtMfYMCgDALtw>
    <xmx:t1z5aEZCJchKcVTaL65vci4JX9AVqPGIqKbJyqmNomCHf4roXresBw>
    <xmx:t1z5aJozWQ6otmpBejHgcCDbiwO_AJaxYEFILSBIVHfzSj8fOcMocMrc>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:41 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/8] nfsd: discard v4 ->op_get_currentstateid() function
Date: Thu, 23 Oct 2025 09:34:31 +1100
Message-ID: <20251022223713.1217694-5-neilb@ownmail.net>
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
index 875964551812..805bb6744251 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -949,6 +949,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_read *read = &u->read;
 	__be32 status;
 
+	nfsd41_get_current_stateid(cstate, &read->rd_stateid);
 	read->rd_nf = NULL;
 
 	trace_nfsd_read_start(rqstp, &cstate->current_fh,
@@ -1178,6 +1179,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status = nfs_ok;
 	int err;
 
+	nfsd41_get_current_stateid(cstate, &setattr->sa_stateid);
 	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
 					      FATTR4_WORD2_TIME_DELEG_MODIFY);
 
@@ -1265,6 +1267,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status = nfs_ok;
 	unsigned long cnt;
 
+	nfsd41_get_current_stateid(cstate, &write->wr_stateid);
+
 	if (write->wr_offset > (u64)OFFSET_MAX ||
 	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
 		return nfserr_fbig;
@@ -2951,8 +2955,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->status)
 			goto encode_op;
 
-		if (op->opdesc->op_get_currentstateid)
-			op->opdesc->op_get_currentstateid(cstate, &op->u);
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
@@ -3402,7 +3404,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_closestateid,
 		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
@@ -3422,7 +3423,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_DELEGRETURN",
 		.op_rsize_bop = nfsd4_only_status_rsize,
-		.op_get_currentstateid = nfsd4_get_delegreturnstateid,
 	},
 	[OP_GETATTR] = {
 		.op_func = nfsd4_getattr,
@@ -3463,7 +3463,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_LOCKU",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_lockustateid,
 	},
 	[OP_LOOKUP] = {
 		.op_func = nfsd4_lookup,
@@ -3500,7 +3499,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_opendowngradestateid,
 		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
@@ -3529,7 +3527,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ",
 		.op_rsize_bop = nfsd4_read_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_READDIR] = {
 		.op_func = nfsd4_readdir,
@@ -3587,7 +3584,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME
 				| OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_rsize_bop = nfsd4_setattr_rsize,
-		.op_get_currentstateid = nfsd4_get_setattrstateid,
 	},
 	[OP_SETCLIENTID] = {
 		.op_func = nfsd4_setclientid,
@@ -3614,7 +3610,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_WRITE",
 		.op_rsize_bop = nfsd4_write_rsize,
-		.op_get_currentstateid = nfsd4_get_writestateid,
 	},
 	[OP_RELEASE_LOCKOWNER] = {
 		.op_func = nfsd4_release_lockowner,
@@ -3696,7 +3691,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_func = nfsd4_free_stateid,
 		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_FREE_STATEID",
-		.op_get_currentstateid = nfsd4_get_freestateid,
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_GET_DIR_DELEGATION] = {
@@ -3764,7 +3758,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ_PLUS",
 		.op_rsize_bop = nfsd4_read_plus_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_SEEK] = {
 		.op_func = nfsd4_seek,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8e45c1bbe13d..97541a2b9717 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7493,6 +7493,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client *cl = cstate->clp;
 	__be32 ret = nfserr_bad_stateid;
 
+	nfsd41_get_current_stateid(cstate, &free_stateid->fr_stateid);
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s || s->sc_status & SC_STATUS_CLOSED)
@@ -7713,6 +7714,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	dprintk("NFSD: nfsd4_open_downgrade on file %pd\n", 
 			cstate->current_fh.fh_dentry);
 
+	nfsd41_get_current_stateid(cstate, &od->od_stateid);
 	/* We don't yet support WANT bits: */
 	if (od->od_deleg_want)
 		dprintk("NFSD: %s: od_deleg_want=0x%x ignored\n", __func__,
@@ -7787,6 +7789,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("NFSD: nfsd4_close on file %pd\n",
 			cstate->current_fh.fh_dentry);
 
+	nfsd41_get_current_stateid(cstate, &close->cl_stateid);
+
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
 					  &close->cl_stateid,
 					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
@@ -7838,6 +7842,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
+	nfsd41_get_current_stateid(cstate, &dr->dr_stateid);
+
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
@@ -8597,6 +8603,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		(long long) locku->lu_offset,
 		(long long) locku->lu_length);
 
+	nfsd41_get_current_stateid(cstate, &locku->lu_stateid);
+
 	if (check_lock_length(locku->lu_offset, locku->lu_length))
 		 return nfserr_inval;
 
@@ -9156,66 +9164,6 @@ nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
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
index 3bd201ad2fa7..a87e7523cea0 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1063,8 +1063,6 @@ struct nfsd4_operation {
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


