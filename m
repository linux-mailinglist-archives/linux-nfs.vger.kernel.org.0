Return-Path: <linux-nfs+bounces-15353-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73364BEC142
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE40189875A
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DD3354AF8;
	Sat, 18 Oct 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="wVlpq0fw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w1JNDMAv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5B2746A
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745977; cv=none; b=K3CC7cPd4I98sOAyysVexk15zNs98709cFEem+NnhGcAt1X7IC8yn43F1TCpeFQXoVIOPNcro/75w518aCzW3GC4rV1dc5OCuv0axgxQrvP0jOiW6SI7Lh2OJ+Lmf0QZgafho+NYpu14AcPaSwmMt5CceS1INmbUsMoFIJ9WeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745977; c=relaxed/simple;
	bh=7QKLGvQPyfepO7jV8fBbuFbwEdWAlgVqFGQWXuko3L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw4TNqQbTxW6wxXZXo/nunt/rXp1CN/bzK+2poo2093CIVy/rZFcETINGV4K7xOOZem9g1ly5FYksrPP17AlpQJFkLCCNCytrOyGSOx5pWB8aAOQ0Lf9xvWshIDDHaNO8wn/RxOUPVTdYpqPTki9hy/nDxztvpY+cXE92NG5kuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=wVlpq0fw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w1JNDMAv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75BB97A010C;
	Fri, 17 Oct 2025 20:06:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 17 Oct 2025 20:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760745975;
	 x=1760832375; bh=VAoM9j2ttRbz52o5FeL+ZloeN3kis1txruBf7GAcvFw=; b=
	wVlpq0fw6cE+/Y56gYoolUgRQM+Gh6JmdD1xCOlC5E7aZ2Kvsn3nnMBs2Y2iC5oW
	e/pM522c9RnBqaugFF1zHobP1SEmHy45v8x0wv/69H6gAngqV7fUKcbPbvEgPUzW
	29ltPUV9n/IVS+sbAPldVrPuJOcknprGPA47ZropR1/jmvchOpqH1NqLV5WoXqV+
	akz7wMPit625shJgxi57NODww4OgIC0z/T3QAAZneiiVImn/LHAbsNy62GHiEmxx
	XgpyugCoti77k096rwwQQRgGmGwMt5B4hwQ4YRnE6YB9PZT0zHwJCwjOI8+IpTUK
	d7VfngwwFTtqifj8TCtfTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760745975; x=1760832375; bh=V
	AoM9j2ttRbz52o5FeL+ZloeN3kis1txruBf7GAcvFw=; b=w1JNDMAvJIqaPinBQ
	XXnh5yoAyGi7faKGHDTAsWQIOD12Art3z6ykZQfcGsmJmKJzZko4yNu7kvvQODsg
	M27Gcgew5lu/0nupvUyReBjf4zNZovp8xm4rkmAV/XNH2W0KNqTVZq8j4wKD4NXB
	J7QTyrkrTxgX6aq1GoBnF/E0MHW7ISv57Mdkw0NBDQR2ZAKI9X3KX3F6mOiaZ7xJ
	EGpEJAtEbSEZKm6pLkPBUmBBpmMYzA9DTNHU2UZkfWUlTgRw+b1Kd89mcZFkQLr3
	zpqjeGyAzAjr8q7G1hyFgwOHgE6az1ljv+GSNT8CD5o50x3kVA1PkodVNI4eANLz
	X+hbA==
X-ME-Sender: <xms:99nyaLUeG9KABVrgKwzKZ7a-gIq2x63GbJU8sDPDAUrQ4qcNJzWCUQ>
    <xme:99nyaHTybw-NyDMDsByFnP7wlIrlGN2gfif33_z-wSSbwGXGH8yfwttmEz-9SlWRh
    EhZGU803pywsKhwrfDtPYVR6gs9oxS2MKpqEQfWUVpAYpw>
X-ME-Received: <xmr:99nyaBPOMYpZ_MBoaUDvPafE-Cx67Noz8dBvDyCXey-UiWnxMTwPS26eDEPDyVmd66sx83jGc0Zv0D0nY_uKTuNqFFLENYFnuNAFFuNyXYTL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:99nyaNQ_y-03HL3a0TRpocsBQudZ9tcxm8401x4uaQ0ZGZIQtZI7vg>
    <xmx:99nyaHh0yPCTfdxPuaLMD0wsZOmwM7L_CwZ8bitIz424jbQcWHndQA>
    <xmx:99nyaO-FzZscV7EgY9y4G5fYXlQmyG9uXafzUC_6SCxgNrNMOJmlIQ>
    <xmx:99nyaGE3M8XemZ8JhmT_kPKddiNxhAz_ydJvzyAId22sQsbrSK_D8g>
    <xmx:99nyaA2EQz3YRD-RSwGWXlpTPHQPBkC0OkPVQUgvDtxny5cPu7dAqAa->
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:06:13 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] nfsd: discard ->op_set_currentstateid()
Date: Sat, 18 Oct 2025 11:02:23 +1100
Message-ID: <20251018000553.3256253-4-neilb@ownmail.net>
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

It is not clear that the indirection provided by op_set_currentstateid()
adds any value.
It is only called immediately after the only call to ->op_func() if that
function call returned 0.

This patch discards op_set_currentstateid() and instead interpolates the
contents (each a single call to put_stateid()) into each relevant op_func()

Previously the put_stateid() call was only made on success.  While it is
only needed on success it is not harmful do make the call in the error
code.  It simply copies a stateid (which could be invalid) into a place
from where it will never be used, as after and error, no further ops are
attempted.

So the new code calls put_state() without checking 'status'.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 12 +----------
 fs/nfsd/nfs4proc.c        |  8 +-------
 fs/nfsd/nfs4state.c       | 43 +++++++--------------------------------
 fs/nfsd/xdr4.h            |  2 --
 4 files changed, 9 insertions(+), 56 deletions(-)

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
index 7c6dfd6c88e7..8eb0f689b3e3 100644
--- a/fs/nfsd/current_stateid.h
+++ b/fs/nfsd/current_stateid.h
@@ -7,16 +7,6 @@
 
 void clear_current_stateid(struct nfsd4_compound_state *cstate);
 void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
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
+void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
 
 #endif   /* _NFSD4_CURRENT_STATE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 41a8db955aa3..5b41a5cf548b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -644,6 +644,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	nfsd4_cleanup_open_state(cstate, open);
 	nfsd4_bump_seqid(cstate, status);
+	put_stateid(cstate, &u->open.op_stateid);
 	return status;
 }
 
@@ -2928,9 +2929,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			goto out;
 		}
 		if (!op->status) {
-			if (op->opdesc->op_set_currentstateid)
-				op->opdesc->op_set_currentstateid(cstate, &op->u);
-
 			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
 				clear_current_stateid(cstate);
 
@@ -3367,7 +3365,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
 		.op_func = nfsd4_commit,
@@ -3411,7 +3408,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 				OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_LOCK",
 		.op_rsize_bop = nfsd4_lock_rsize,
-		.op_set_currentstateid = nfsd4_set_lockstateid,
 	},
 	[OP_LOCKT] = {
 		.op_func = nfsd4_lockt,
@@ -3447,7 +3443,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN",
 		.op_rsize_bop = nfsd4_open_rsize,
-		.op_set_currentstateid = nfsd4_set_openstateid,
 	},
 	[OP_OPEN_CONFIRM] = {
 		.op_func = nfsd4_open_confirm,
@@ -3460,7 +3455,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 18c8d3529d55..59abe1ab490d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7738,6 +7738,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	nfs4_put_stid(&stp->st_stid);
 out:
 	nfsd4_bump_seqid(cstate, status);
+	put_stateid(cstate, &u->open_downgrade.od_stateid);
 	return status;
 }
 
@@ -7822,6 +7823,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
 out:
+	put_stateid(cstate, &close->cl_stateid);
 	return status;
 }
 
@@ -8457,6 +8459,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	nfsd4_bump_seqid(cstate, status);
 	if (conflock)
 		locks_free_lock(conflock);
+	put_stateid(cstate, &lock->lk_resp_stateid);
+
 	return status;
 }
 
@@ -9082,13 +9086,11 @@ get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
-static void
+void
 put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (cstate->minorversion) {
-		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
-	}
+	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
+	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 }
 
 void
@@ -9097,37 +9099,6 @@ clear_current_stateid(struct nfsd4_compound_state *cstate)
 	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 }
 
-/*
- * functions to set current state id
- */
-void
-nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	put_stateid(cstate, &u->open_downgrade.od_stateid);
-}
-
-void
-nfsd4_set_openstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	put_stateid(cstate, &u->open.op_stateid);
-}
-
-void
-nfsd4_set_closestateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	put_stateid(cstate, &u->close.cl_stateid);
-}
-
-void
-nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
-		union nfsd4_op_u *u)
-{
-	put_stateid(cstate, &u->lock.lk_resp_stateid);
-}
-
 /**
  * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
  * @req: timestamp from the client
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index b94408601203..368bad2c7efe 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1043,8 +1043,6 @@ struct nfsd4_operation {
 	/* Try to get response size before operation */
 	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
 			const struct nfsd4_op *op);
-	void (*op_set_currentstateid)(struct nfsd4_compound_state *,
-			union nfsd4_op_u *);
 };
 
 struct nfsd4_cb_recall_any {
-- 
2.50.0.107.gf914562f5916.dirty


