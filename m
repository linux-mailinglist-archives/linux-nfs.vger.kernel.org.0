Return-Path: <linux-nfs+bounces-15634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D29C0B5CB
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDCF94E7769
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59B1F30C3;
	Sun, 26 Oct 2025 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="X0FawlnX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZfUUx3d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E252F99B8
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517651; cv=none; b=D3rdpK/9wfV5W0KUFyTkok8V+8hxtU7mqjBp1mcke7XcWwi+zNcerGqOY9uMxQO/d0bu9btQ4to6ess4KM6G+YNWkp0xiwZygAdHgHjw0KDqKp+QYcP+I/3e/STENhYAsZnVi0FGGntYeOgkZ/sFp7tbyCzmlpEaqlwB+NG/LmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517651; c=relaxed/simple;
	bh=PAOdXTicPsMN9mFPEOkJaSj0ZVwOEzmtWZcVA9dMVCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz+7DnlAa439HUj66Ogk9IQSir3SdOFkPrTcgf9a/pVf1LqwFZuAL07UEyBrDV0nk9wwzGuz9x/Z8eEVADV8xj2pcAsrBEbeGywSBh67MlypR08N48MlfSexeOHEq23GBU4Grao/6XAJTQ0nBOTd7O3Y/cUx0c5fotb4yME+jrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=X0FawlnX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZfUUx3d; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A33237A028A;
	Sun, 26 Oct 2025 18:27:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 26 Oct 2025 18:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517648;
	 x=1761604048; bh=cd+AoGw/ZM8esDyp6N6pH5AAEdt2fyTZ5PHZuCrzZ28=; b=
	X0FawlnXudbxBG8MxF5KanNTeipIbPHQkDqtu3QSocCRPGM3Dx0AsnQ6deYEbvYL
	S9q1FmG2FpOxvh7kzNAc9da3sD35jzisUOjqOibyBTa0aevBSGtyuWPOJBCY+syX
	ymxeJbHCkV91sRC/WCNn/FPllMc3QnnNpelk6Q6dZGbcs+7D50OuPykx3p1bxNJu
	Y30EvEoi3ncrqgME1cCszpNhNxKgllcDyJy+t2hq3KKz2OkFJWPrFiuh+KtAkX1p
	XGyKbPbAXCA2BP+Mxxq7nBDyhCg3h8C4kZC3jginceAZpXsDFg83J5FiLvuafkn+
	Snav6Vfdx0WYPxBGX0PQ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517648; x=1761604048; bh=c
	d+AoGw/ZM8esDyp6N6pH5AAEdt2fyTZ5PHZuCrzZ28=; b=nZfUUx3dwhnqw4aJn
	cSMmHIjUgLp3+QJfzG8Kw/e/jfSXzbYaGnjXLeOftXj4xcYMcWGOZhw4ShbMjHG1
	Oy9eawgyHNABKs+x1p//DWvXdgY+Fq6K1ezYZG+EZlba/36B403t0yrsk2H8Nuta
	BJUVy/Vy//Bx7KB3pCcGQmzDls6Z9g9AX3j5CPlGXL8cu6e24hwWTICegvaNHhDO
	UxhCZHMdFyDW8+lQeN/GUtT2jDa27w395xG6vnOCYgFpJLcRLzLn/B54FZ+LJXah
	cC0ycoOZ5ElZ0ZOWTq2sRHDecOYrVA/yUx7YY6j/yX8RlKA4PlcedDFOEJX0SIK2
	vyUzQ==
X-ME-Sender: <xms:UKD-aKDQuMM_P06c_25_01tk5lEz2QKat6oNP4N_oOhhBX77OQKqkw>
    <xme:UKD-aIPVEWwIYPa968WEPqZ-sFOcWcaO9wA5ejwJDrwPm2yuKgQxRCwvPxDNc1eyn
    swlOZiA7bm9HftoSKThZl1DYDtsTWBhTP1xlgRFQEVD7Ndf5Q>
X-ME-Received: <xmr:UKD-aHb18sB9D6NvlgkIzjXf4mPqxLX1TKUvsp0DBJJL3_WoBE0KdvMnSIu9Cl5MbeJL0pE63PLSEmynEvIXCgGv1cbuTjK8W4h57KSGT6l->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:UKD-aPv2r_DBi3rZ6z2q8CyOpd6Bjl76G8Nrv2keGAxgoJsxZs0ZxQ>
    <xmx:UKD-aBN6q1IDH2pS-JUL6oPXwCV9C21QPNZ28OaLtXaDiyXhpE8JTw>
    <xmx:UKD-aO4qZNXXw9vWdS8JfCDZRVKz6sbtaUpO8owUv77wO1FnX5osqw>
    <xmx:UKD-aPSRqN9mXniBVBTnEz3i-MOpSaY9QMb3NBQ5OxIPvYBgqB1stg>
    <xmx:UKD-aLipb1-zFQ3LNiFckoMJPFqGVe3PMGKS88feCWs-hcqqCYheiftH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:26 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 03/10] nfsd: revise names of special stateid, and predicate functions.
Date: Mon, 27 Oct 2025 09:23:48 +1100
Message-ID: <20251026222655.3617028-4-neilb@ownmail.net>
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

When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
is testing the stateid to see if it is a special stateid.  I find that
IS_CURRENT_STATEID(foo) is clearer.

There are other special stateid which are described in RFC 8881 Section
8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
currently names them "zero", "one" and "close" which doesn't help with
comparing the code to the RFC.

So this patch changes the names of those special stateids and adds
"IS_" to the front of the predicates.

As CLOSE_STATEID() was not needed, it is discarded rather than replacing
with IS_INVALID_STATEID().

I felt that IS_READ_BYPASS_STATEID() was a little too verbose, so I made
it IS_BYPASS_STATEID().

For consistency, invalid_stateid is changed to use ~0 rather than
0xffffffffU for the generation number.  (RFC 8881 say to use
"NFS4_UINT32_MAX" for the generation number here, and "all ones" for the
generation and opaque of anon_stateid).

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 594632998a12..cd8214a53145 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -60,26 +60,32 @@
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
 #define all_ones {{ ~0, ~0}, ~0}
-static const stateid_t one_stateid = {
+static const stateid_t read_bypass_stateid = {
 	.si_generation = ~0,
 	.si_opaque = all_ones,
 };
-static const stateid_t zero_stateid = {
+static const stateid_t anon_stateid = {
 	/* all fields zero */
 };
-static const stateid_t currentstateid = {
+static const stateid_t current_stateid = {
 	.si_generation = 1,
 };
-static const stateid_t close_stateid = {
-	.si_generation = 0xffffffffU,
+static const stateid_t invalid_stateid = {
+	.si_generation = ~0,
 };
 
 static u64 current_sessionid = 1;
 
-#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
-#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
-#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
-#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
+/* These special stateid are defined in RFC 8881 Section 8.2.3 */
+static inline bool IS_ANON_STATEID(stateid_t *stateid) {
+	return memcmp(stateid, &anon_stateid, sizeof(stateid_t));
+}
+static inline bool IS_BYPASS_STATEID(stateid_t *stateid) {
+	return memcmp(stateid, &read_bypass_stateid, sizeof(stateid_t));
+}
+static inline bool IS_CURRENT_STATEID(stateid_t *stateid) {
+	return memcmp(stateid, &current_stateid, sizeof(stateid_t));
+}
 
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
@@ -371,7 +377,7 @@ nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
 static int
 nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
 {
-	trace_nfsd_cb_notify_lock_done(&zero_stateid, task);
+	trace_nfsd_cb_notify_lock_done(&anon_stateid, task);
 
 	/*
 	 * Since this is just an optimization, we don't try very hard if it
@@ -6495,7 +6501,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * open stateid would have to be created.
 	 */
 	if (new_stp && open_xor_delegation(open)) {
-		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
+		memcpy(&open->op_stateid, &anon_stateid, sizeof(open->op_stateid));
 		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
 		release_open_stateid(stp);
 	}
@@ -7059,7 +7065,7 @@ __be32 nfs4_check_openmode(struct nfs4_ol_stateid *stp, int flags)
 static inline __be32
 check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid, int flags)
 {
-	if (ONE_STATEID(stateid) && (flags & RD_STATE))
+	if (IS_BYPASS_STATEID(stateid) && (flags & RD_STATE))
 		return nfs_ok;
 	else if (opens_in_grace(net)) {
 		/* Answer in remaining cases depends on existence of
@@ -7068,7 +7074,7 @@ check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid,
 	} else if (flags & WR_STATE)
 		return nfs4_share_conflict(current_fh,
 				NFS4_SHARE_DENY_WRITE);
-	else /* (flags & RD_STATE) && ZERO_STATEID(stateid) */
+	else /* (flags & RD_STATE) && IS_ANON_STATEID(stateid) */
 		return nfs4_share_conflict(current_fh,
 				NFS4_SHARE_DENY_READ);
 }
@@ -7381,7 +7387,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (nfp)
 		*nfp = NULL;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
+	if (IS_ANON_STATEID(stateid) || IS_BYPASS_STATEID(stateid)) {
 		status = check_special_stateids(net, fhp, stateid, flags);
 		goto done;
 	}
@@ -7803,12 +7809,12 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	/* v4.1+ suggests that we send a special stateid in here, since the
 	 * clients should just ignore this anyway. Since this is not useful
-	 * for v4.0 clients either, we set it to the special close_stateid
+	 * for v4.0 clients either, we set it to the special invalid_stateid
 	 * universally.
 	 *
 	 * See RFC5661 section 18.2.4, and RFC7530 section 16.2.5
 	 */
-	memcpy(&close->cl_stateid, &close_stateid, sizeof(close->cl_stateid));
+	memcpy(&close->cl_stateid, &invalid_stateid, sizeof(close->cl_stateid));
 
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
@@ -9081,7 +9087,7 @@ static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
 	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
-	    CURRENT_STATEID(stateid))
+	    IS_CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
@@ -9097,7 +9103,7 @@ put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
 void
 clear_current_stateid(struct nfsd4_compound_state *cstate)
 {
-	put_stateid(cstate, &zero_stateid);
+	put_stateid(cstate, &anon_stateid);
 }
 
 /*
-- 
2.50.0.107.gf914562f5916.dirty


