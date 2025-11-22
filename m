Return-Path: <linux-nfs+bounces-16660-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B4C7C0A6
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09A03A68E6
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B346023EA8E;
	Sat, 22 Nov 2025 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="h66B3a2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EL6SmXnv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372423EA80
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772816; cv=none; b=hH57DoX4y4Be1zLmPG5WdSHJwvC5OvBoFwoLt8hWh9Badns7Paj39Iw3XQDaDeCG9pnqd7uqbnL90HADlfBqWvyk0vcDQo08e+xxrvL+FZK4hMdd4gx2+mGzvW+LAhoooCWMEKbdXo9y5LpYuUQRbrPAgHaxMXQ/lKd2CoFFLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772816; c=relaxed/simple;
	bh=+l2G3NCOsnBgGcuBqFoouRSmDpaB3BsXRUtGsrSsLBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYRIDpPXUOTaDDx8xDvQaFTty0EAF/hxN+vId+xirqv53DltVobW1eEuEBw8bgVIb+jgjQF615GOSPnHyS3TFAtuAXM0Rf0pfrTBKIIFcXw3cRW5tm+0k4CC/jeyXfUqYsF+HbStJXrSOtfkESaTmi91wBUtQ2yyGqzJi4fl070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=h66B3a2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EL6SmXnv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 731FC14000CA;
	Fri, 21 Nov 2025 19:53:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Nov 2025 19:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772813;
	 x=1763859213; bh=lQlQHcZaRGkeNYt1qtJb6GmJWM0IeDQAmVXi8v2r0AI=; b=
	h66B3a2YV0GC5ZqgKZViPi/PF5T3nX1aM6yfjPozmpSVfm3Sah58XpSkfHetWUjv
	32cQ2Ft3jKCQbaNRNkfPeWnSdn8AKswMFNSkGrXU8ekFJIbdNsdhgzNMfa3aYr33
	4wsdMpLG2EmnBhheIqKhbaPaBFV/FxPW9gXNACkxv5AP2BK+y2o/SLMnT++0iEV6
	qgkcyhznUDmvWbcICLMKshUsmESz7vAzMR6DD4CbjHDd7kQUmHYuIK65plDB3YiP
	il6dtGbpV9akQWrTMObZlLsIV+CNRVED2ztpP8ZrJyBeLMposR2+RTcxAkxxzy42
	dQMWV6sU9aIy14hQlVJu0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772813; x=1763859213; bh=l
	QlQHcZaRGkeNYt1qtJb6GmJWM0IeDQAmVXi8v2r0AI=; b=EL6SmXnv6csIqMXMp
	kFMPoi7aEboNRDLzz4VESmTN0n+NKp0OG2NfqRZiuu92rA1zRGF+zfdYqO8dvaQi
	A5YiHaRExH7z3Hb10yxZxlr4QuGF1gZNxLPxFxDDGhrrQ21fBAuJvFpCm22a3iMZ
	oDWa7OSmUfc+wzcVqKUFXz9r3x21oD0t0EYShiuo0V0OdecoCaGtBxtQa/VyJ9CK
	Zjirxih5JcMx9M3/PR0hGmmfX7Vi1jpqvZMfOCilPQ88nGIcAymHJAo2HqRRQZvA
	XRMAduyWDWKLSgbYPDm+gutBurAqHb2jhSEAx/Svmqz8bTjRIr6LddGegrgbTneP
	SGg+w==
X-ME-Sender: <xms:jQkhadI3mrJ0EFXYjJqyY26DeljqIVk-wQ8GRDbR0yOifP9o5eH07w>
    <xme:jQkhac2x2SJksBAgJuy4ZVvnGSWYrEq3kL4tpV3lDvXfmAl8XcgkKu6KMAmDIZ5pZ
    1BWLQsJqnXm-ch1I9PivAIjB9GnTkG4ZG2iEDA8T2hKgwf04Q>
X-ME-Received: <xmr:jQkhafg8LmSpKZmudsuCUffx1kWrZJO9Um4UtjXVfndRmKyecQuebDbjAx3JEBoUyXRbt5jjIrkuK-3yr5TRpm5KlCf3_PSEA75la62xcFOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:jQkhaVU1BFufkWbJ0dxC2jSxkeFgC6gqhm7aYQKhcOpiPoD7E2DC0Q>
    <xmx:jQkhaWXihs_1LRuAmRZgkkZkJp-j8SdQilg8uymPnqQ15k9zT0UiHg>
    <xmx:jQkhadhBIWbhIApgjTcZgbV84injwurrSCiqyYlhpJM840Z5yeWjdw>
    <xmx:jQkhaZaPeW4HQ9cbyT_5eOrlQ9gIxeRUu27rl_F86WteiPd1YbZmXw>
    <xmx:jQkhaWpD9SQyDxAtnELcqGRgyASNu_AC4dL30Lu7px7XaWJVHmiGNv_Z>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:31 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 11/14] nfsd: simplify use of the current stateid.
Date: Sat, 22 Nov 2025 11:47:09 +1100
Message-ID: <20251122005236.3440177-12-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251122005236.3440177-1-neilb@ownmail.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
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
index ae9427ac7e5e..784f241c7119 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2943,8 +2943,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->status)
 			goto encode_op;
 
-		if (op->opdesc->op_get_currentstateid)
-			op->opdesc->op_get_currentstateid(cstate, &op->u);
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
@@ -3391,7 +3389,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_closestateid,
 		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
@@ -3411,7 +3408,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_DELEGRETURN",
 		.op_rsize_bop = nfsd4_only_status_rsize,
-		.op_get_currentstateid = nfsd4_get_delegreturnstateid,
 	},
 	[OP_GETATTR] = {
 		.op_func = nfsd4_getattr,
@@ -3452,7 +3448,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_LOCKU",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_lockustateid,
 	},
 	[OP_LOOKUP] = {
 		.op_func = nfsd4_lookup,
@@ -3489,7 +3484,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_get_currentstateid = nfsd4_get_opendowngradestateid,
 		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
@@ -3518,7 +3512,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
 		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
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
index 03f29a6d7c14..de66b2971cd3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7191,6 +7191,11 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
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
@@ -7507,6 +7512,12 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -9102,21 +9113,11 @@ nfs4_state_shutdown(void)
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
@@ -9150,66 +9151,6 @@ nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
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
index 87986f1d5506..4f54108f24f9 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1036,8 +1036,6 @@ struct nfsd4_operation {
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


