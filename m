Return-Path: <linux-nfs+bounces-15831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28297C232B1
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52B844F001C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165F928E5;
	Fri, 31 Oct 2025 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SNuSnArP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFJj5wfs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4225CC7A
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881176; cv=none; b=C7UQMzjuUBZIptteRbzsCfs9rkcsfO4GGwi3FZTkfsIuoOF4ECJa55Q9wLCvtKH3wOeaZUVEIkPcLyo3HIEQryaSIh1y+bIGP/NCwHfeq6s/gaj4QssdASU/ZzkCFVIoMTNKp6q8ca0ivZ4MDWc9ac57GBaNBvBFs9VyE68gR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881176; c=relaxed/simple;
	bh=/iKArKfrYPRKfK21GdPG9megMj3BoPF9I25ynA2U824=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I60se/Rnc8kdHNleB9JpxZlJoNOS2KvHftpAhf7VYjRA7I9NB2gVOlq98cGf5o8qzUumlf99dcwKrC5Ccr5cYBNHUqSMGl0NPMFsC2GSR2h2shij8A5qxl/e0zAQGH8tErVKdRqTiCcqQSG5E72XXw/i9vOIma8PXP9ZY4feSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SNuSnArP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mFJj5wfs; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 144871D0011B;
	Thu, 30 Oct 2025 23:26:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 30 Oct 2025 23:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881171;
	 x=1761967571; bh=BDjk5hPFvt/i0PMTIftfhD9eB/ckvhqZcJ35khUj1gg=; b=
	SNuSnArPVy9/QTB/JVHgjWL1p1HLV3DpapZvxWYI8zKPGjeWSELm2lZh7sFV6qWx
	CTid6GnpKm6oztfaV5QrUB1m5pOQDddo8UDBCcqOlpDc3TWNofrL0uHYZXMIhQIe
	ZSFNWFr5XPIrnTDvq9rDc96sOVeOnKO3BnRONsw3Tii6/awEPq+gdkKLFFTlDqpR
	0JypegADoC0E795HYR4sg37Q/q7EoSXaOPbzlLbx5MFdV8QQtG3aWI1Uql0eF8Gz
	bA3qY1Sey78EComV0V4gf16QNfMB5PWnHJUbfYUKHg6DDqKr7NbbJNV1NETE+21b
	KSA1YDqrJOx2X272lMiSeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881171; x=1761967571; bh=B
	Djk5hPFvt/i0PMTIftfhD9eB/ckvhqZcJ35khUj1gg=; b=mFJj5wfsKfSEGOzVi
	UbVRljT78h2WtmNF5ucGW3oXrTfslyyXtFydt4m8eZoGr5tfJR6kotkP5DYDNfkI
	RVca2OLcUy6gTiuvKCQTMpF3Ks55TzT0Qy+28VnKDeVp3sAcp3JwiPJmi5G1JMfY
	6kE7w8O1wJluJEqb+ZJ+krmh+lruACcj89+Qgsdyg/eZ5tYng7Kk3T2p+ftVQ8YF
	niReqMnknGMMeH9Kxre0I+v1GQxsS+PG3MmY/jkWSu2L/haAsibrHb2Di9tEad3z
	QQrhyylttgChCfP7V+Jhos+2GJcJFkXvSKwbx2pC8x9WUtVu2SnEcEFLONvsYRO9
	HP5mg==
X-ME-Sender: <xms:UywEaVcZibQ3rfdHTYFtlJwfGXDxcQ-ng_HtBYKxKRdhGubAAPClXg>
    <xme:UywEaW41ydCuKg6QP8xIlkjZQP_2UPBhb5zgrTTGqXr5w4oGjx7_3VXQujxLZqFR5
    iFK0tiKjBiWSU-wISL_27FxCX74-Vw1vuJGtautDp7xfLnKVA>
X-ME-Received: <xmr:UywEaYXu15kMHLisghU_MnKGiYcCNZ8ibeoVNEmj3ITZgQ_zmic10vlH9cEYHbJqfp1nitxByPKNsFAVIYmaunds4_3k8tTfwAv02gFmcSt2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:UywEaV58xZ1xrb9FiIMkw6vr1YcZXXKfRavTCZrg3slDI9hs8UZDnQ>
    <xmx:UywEaTo38CsZI-Rh-P8cuKNPt5Xf4vk4X59slm2j5LuTxJMyL-cQCw>
    <xmx:UywEaYm-jUswAd3eo9Gwov2V1xsL0tRvBB8TqO0IcQ8oxiTJi6RJxw>
    <xmx:UywEafOs3QZy9C2ky769BktCm6XnH1_r3LJKXAn3gdDOiDM4LwjRSA>
    <xmx:UywEaS9dFpO5jRVSPCWXKokWmNCal6d14N9dsmGTlvA_SxslQ3hIUxoi>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:26:09 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 07/10] nfsd: simplify use of the current stateid.
Date: Fri, 31 Oct 2025 14:16:14 +1100
Message-ID: <20251031032524.2141840-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251031032524.2141840-1-neilb@ownmail.net>
References: <20251031032524.2141840-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

In NFSv4.1 any use of a stateid in an OP should check if it is
the special stateid that
   has "other" set to zero and "seqid" set to one

If it is, then the stateid saved from a previous operation should be
used unless that stateid as "special" stateid, in which case BAD_STATEID
must be returned.

Most ops that include a stateid pass it (indirectly) to
nfsd4_lookup_stateid().  The one exception is FREE_STATEID which uses
find_stateid_locked() directly.  (TEST_STATEID is not considered.  It is
given a list of stateids, among which any special stateid is explicitly
forbidden).

So rather than providing dedicated op_get_currentstateid functions for
each relevant op, we can include the required logic directly in
nfsd4_lookup_stateid() and nfsd4_free_stateid().  That is what this
patch does.

We also include an explicit return of nfserr_bad_stateid when the
special stateid is used, but no valid stateid is available.  This does
not change behaviour as the error would have been returned eventually.

This patch also removes the "minorversion" test in put_stateid() and
instead checks that sessions are in use when the stateid is used.  This
seems more natural.  Note that nfsd4_free_stateid() doesn't need this
explicit test as the function cannot be called for v4.0.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 21 ----------
 fs/nfsd/nfs4proc.c        | 11 -----
 fs/nfsd/nfs4state.c       | 85 ++++++---------------------------------
 fs/nfsd/xdr4.h            |  2 -
 4 files changed, 13 insertions(+), 106 deletions(-)

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
index 24d769043207..eaa4b8e40dc8 100644
--- a/fs/nfsd/current_stateid.h
+++ b/fs/nfsd/current_stateid.h
@@ -16,25 +16,4 @@ extern void nfsd4_set_lockstateid(struct nfsd4_compound_state *,
 		union nfsd4_op_u *);
 extern void nfsd4_set_closestateid(struct nfsd4_compound_state *,
 		union nfsd4_op_u *);
-
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
index 948604a888c2..284a79be0c26 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2944,8 +2944,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->status)
 			goto encode_op;
 
-		if (op->opdesc->op_get_currentstateid)
-			op->opdesc->op_get_currentstateid(cstate, &op->u);
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
@@ -3392,7 +3390,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_closestateid,
 		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
@@ -3412,7 +3409,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_DELEGRETURN",
 		.op_rsize_bop = nfsd4_only_status_rsize,
-		.op_get_currentstateid = nfsd4_get_delegreturnstateid,
 	},
 	[OP_GETATTR] = {
 		.op_func = nfsd4_getattr,
@@ -3453,7 +3449,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_LOCKU",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_lockustateid,
 	},
 	[OP_LOOKUP] = {
 		.op_func = nfsd4_lookup,
@@ -3490,7 +3485,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_opendowngradestateid,
 		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
@@ -3519,7 +3513,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ",
 		.op_rsize_bop = nfsd4_read_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_READDIR] = {
 		.op_func = nfsd4_readdir,
@@ -3577,7 +3570,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME
 				| OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_rsize_bop = nfsd4_setattr_rsize,
-		.op_get_currentstateid = nfsd4_get_setattrstateid,
 	},
 	[OP_SETCLIENTID] = {
 		.op_func = nfsd4_setclientid,
@@ -3604,7 +3596,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_WRITE",
 		.op_rsize_bop = nfsd4_write_rsize,
-		.op_get_currentstateid = nfsd4_get_writestateid,
 	},
 	[OP_RELEASE_LOCKOWNER] = {
 		.op_func = nfsd4_release_lockowner,
@@ -3686,7 +3677,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_func = nfsd4_free_stateid,
 		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_FREE_STATEID",
-		.op_get_currentstateid = nfsd4_get_freestateid,
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_GET_DIR_DELEGATION] = {
@@ -3754,7 +3744,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ_PLUS",
 		.op_rsize_bop = nfsd4_read_plus_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_SEEK] = {
 		.op_func = nfsd4_seek,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fb10835eac2c..f4d18a4c1063 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7175,6 +7175,11 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	struct nfs4_stid *stid;
 	bool return_revoked = false;
 
+	if (nfsd4_has_session(cstate) && is_current_stateid(stateid)) {
+		if (!cstate->current_fh.fh_have_stateid)
+			return nfserr_bad_stateid;
+		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
+	}
 	/*
 	 *  only return revoked delegations if explicitly asked.
 	 *  otherwise we report revoked or bad_stateid status.
@@ -7493,6 +7498,12 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client *cl = cstate->clp;
 	__be32 ret = nfserr_bad_stateid;
 
+	if (is_current_stateid(stateid)) {
+		if (!cstate->current_fh.fh_have_stateid)
+			return nfserr_bad_stateid;
+		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
+	}
+
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s || s->sc_status & SC_STATUS_CLOSED)
@@ -9088,21 +9099,11 @@ nfs4_state_shutdown(void)
 	shrinker_free(nfsd_slot_shrinker);
 }
 
-static void
-get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
-{
-	if (cstate->current_fh.fh_have_stateid &&
-	    is_current_stateid(stateid))
-		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
-}
-
 static void
 put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (cstate->minorversion) {
-		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-		cstate->current_fh.fh_have_stateid = true;
-	}
+	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
+	cstate->current_fh.fh_have_stateid = true;
 }
 
 /*
@@ -9136,66 +9137,6 @@ nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
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
index 1eae9f9f43bc..dbb3497b088c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1033,8 +1033,6 @@ struct nfsd4_operation {
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


