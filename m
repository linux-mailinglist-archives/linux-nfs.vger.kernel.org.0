Return-Path: <linux-nfs+bounces-16515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A28C6C9CD
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id C1C642926C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E27C2ECE9C;
	Wed, 19 Nov 2025 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="erqchvrO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGAhh8Go"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723672EF651
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523174; cv=none; b=bFdCsNlNCQzJL/H36ytncshYXb/oewa+RssX82m1MGGfFlPhgtid1BD4ZcQEY5NyNw3PJJH8FBQtU8qGKFY4K0qNiw1M9g5NDagj6RoH3NnxnhU/nfnXtVRy6JQ78ujSoSmZAe9FtXumPlJXLFudb/Ln4vv1b0nDpyf3igBEkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523174; c=relaxed/simple;
	bh=TYAcERApHLLGXoJy1bgD3IWd8izwIGnbXIi5DbHAjRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOXTidesUHx7B+jmr5Rulstfndn3Vwgkjx/8sRt148dBPdfeTHC/kGI9/2KKzPr5rw15HWk4JUoL1D3cB+o2xJDTBfwRHvu1b2fQAOg+zKO92jA0Lzc0P21O4KNjNPqr3P4b5/I/1rxqrk40xFP6n9IE4nyCB4pgz+yVtDMrkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=erqchvrO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGAhh8Go; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C54841D0015C;
	Tue, 18 Nov 2025 22:32:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 18 Nov 2025 22:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523171;
	 x=1763609571; bh=A56HR8dC1yjXd9fFrtNyO7oqAjT4RQkXOSzPSN3bslM=; b=
	erqchvrOjPEtdmc0sRDxkoPftnrzK/KFly/j/kAyuB5So6FQ6YB8EhGESnU1K3o+
	88Evw4+NGiGFigl8ZclLbLJ1uweURbkXobQtXbQRyYEd0xp1oOsnsA6s1aGJ+T0R
	q2fAovbRwMOPWV1tXtp4DlhK0izKNMNIKII+rMOhQxoTh6SICLRfF8OF1+R2AHZP
	TN/MzJ+tb30fjZ0dI3b01WpIDkMoCo9JI8UN6xSE0wT4W7jrFjlvZ91fYy605754
	HThq8pOvubJfai4M3Vd3p3VJy4Bl6dmMZuKrv/HTYCAcqcLtVVKZquS8LvSfcWwF
	X2qK5jEelUIIRZYZ8lL3NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523171; x=1763609571; bh=A
	56HR8dC1yjXd9fFrtNyO7oqAjT4RQkXOSzPSN3bslM=; b=bGAhh8GoNdgmyrJvh
	YcdM7WyG/pD7dRK9JOe88PhJ5P4aFjdxh51JeAXXQlgQAotLpTxTzjnNRmGPM3pD
	Fas2KhFtA8pCUmAD9F+4vwwqemubZu4sDke9T9mwZeLzXE3wIr5fqAILR9xHTJ5Y
	2xnq6hc0SuOAOeGrNd7eCdHaLrRmTCOcMEpklZJgMazGcgz9FVAaP1cIomquF0p/
	0fScSPwwgvNakoOr+PPuHgGQ91CQwJtRWhPKuElWNQDrxbttcrXHRbjkAF8g9ERK
	kKb20h4pWTEYpCneovr/rylXWmq6NI4h1X7fZZUVR2sP8BcxTgtFc+wRLkTsFv0h
	7ONCA==
X-ME-Sender: <xms:YzodaURVlat2vj9KIXNUS5wqV-GbeYNqSPeaek9pvvjQJj5KFCgg3w>
    <xme:YzodaVenUcN6rBMedYg_md9vUnzv43stQ_-zbD_PvSebRlhNf3jw3H4MsRz8VA0zv
    QwcVgk7A0LVvYVvffv-YTaaTu7vvZAcygzVXayZ40w9sEn5XQ>
X-ME-Received: <xmr:YzodabrEE4XNXReiGnhVujzHN1LzX9cKrEpuCMnln3fOJySv2VfKp6LUi4p_W11_SHz2vHxPdHQYcyySSDJ1-3wu74eg8PDKuAROWrpswmUv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Yzodae9Oj_cms0XMy2fQem232WPY0g8HARO7efFOZgVAghC2RWlCkQ>
    <xmx:YzodafckuZXyhPdTdh_S1SOAN7vS4qEMVSpI3tkd2fZcyIOJDS5GBA>
    <xmx:YzodaQLG7usjbj21bT5q2nFAHSdVwxWykJ9EFr2sM8GagwhY8qPhrw>
    <xmx:YzodaXiRcE69Dr79KCoC4oVEjBb_r5hAJu_QmhlX215mkjU_65ycVQ>
    <xmx:YzodaVzjPtNn2fCDxCuCDPjaGmgZ7RLLduPoK0QVdeLEF7BBX_hA2xc6>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:49 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 08/11] nfsd: simplify use of the current stateid.
Date: Wed, 19 Nov 2025 14:28:54 +1100
Message-ID: <20251119033204.360415-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251119033204.360415-1-neilb@ownmail.net>
References: <20251119033204.360415-1-neilb@ownmail.net>
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
index ae4094ff12dc..ca1ed0a1bcab 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2933,8 +2933,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->status)
 			goto encode_op;
 
-		if (op->opdesc->op_get_currentstateid)
-			op->opdesc->op_get_currentstateid(cstate, &op->u);
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
@@ -3381,7 +3379,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_closestateid,
 		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
@@ -3401,7 +3398,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_DELEGRETURN",
 		.op_rsize_bop = nfsd4_only_status_rsize,
-		.op_get_currentstateid = nfsd4_get_delegreturnstateid,
 	},
 	[OP_GETATTR] = {
 		.op_func = nfsd4_getattr,
@@ -3442,7 +3438,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_LOCKU",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_lockustateid,
 	},
 	[OP_LOOKUP] = {
 		.op_func = nfsd4_lookup,
@@ -3479,7 +3474,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_opendowngradestateid,
 		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
@@ -3508,7 +3502,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ",
 		.op_rsize_bop = nfsd4_read_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_READDIR] = {
 		.op_func = nfsd4_readdir,
@@ -3567,7 +3560,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME
 				| OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_rsize_bop = nfsd4_setattr_rsize,
-		.op_get_currentstateid = nfsd4_get_setattrstateid,
 	},
 	[OP_SETCLIENTID] = {
 		.op_func = nfsd4_setclientid,
@@ -3594,7 +3586,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_WRITE",
 		.op_rsize_bop = nfsd4_write_rsize,
-		.op_get_currentstateid = nfsd4_get_writestateid,
 	},
 	[OP_RELEASE_LOCKOWNER] = {
 		.op_func = nfsd4_release_lockowner,
@@ -3676,7 +3667,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_func = nfsd4_free_stateid,
 		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_FREE_STATEID",
-		.op_get_currentstateid = nfsd4_get_freestateid,
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_GET_DIR_DELEGATION] = {
@@ -3744,7 +3734,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ_PLUS",
 		.op_rsize_bop = nfsd4_read_plus_rsize,
-		.op_get_currentstateid = nfsd4_get_readstateid,
 	},
 	[OP_SEEK] = {
 		.op_func = nfsd4_seek,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7ffe0b8e44de..ce7b958fa076 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7192,6 +7192,11 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
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
@@ -7508,6 +7513,12 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -9103,21 +9114,11 @@ nfs4_state_shutdown(void)
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
@@ -9151,66 +9152,6 @@ nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
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
index b6ab32c7b243..55dab88b011c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1034,8 +1034,6 @@ struct nfsd4_operation {
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


