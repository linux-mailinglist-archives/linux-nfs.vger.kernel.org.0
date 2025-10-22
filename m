Return-Path: <linux-nfs+bounces-15549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0DCBFE6EE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F76F1A009B9
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B422F39B1;
	Wed, 22 Oct 2025 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XlJYcf6e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yNtIfcXw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68826F443
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172657; cv=none; b=nIxH56l4w/zyB5crvsrovSQjqsWbpYMZtYXLu3BKUDelquliJ/m4eknR0OrPfavifkfrvZ3aD9s99nmGw9ICIFmn8c/19oCbmHFOzG52Ut7ysJ+PVNGFIzPsIBdQBRRJbw0SRw1Hi8dASUmoUftDx9WX/Ja9lxTHcKOk/aakltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172657; c=relaxed/simple;
	bh=8CZyRbKdSLBI6U5GvQqWeHfzTP3wwWUqfR8BUEDtEuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNPUDeYiUYtpxY6u8DM8hEXmKp3HwCQnwkwzXnDfR3hmf0NcJ7a+8vWZecBzPw2c9wzSHexpmCr6FWD5yPVmNGeSOnqkvCwuxtdiiRim1d3dqvJudvn5nCUbpWvnMYFjivK9W39I/+Ah7VBLG549wfUFENC+bd7dXwl1iGtBywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XlJYcf6e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yNtIfcXw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DDAE71400126;
	Wed, 22 Oct 2025 18:37:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 18:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761172654;
	 x=1761259054; bh=PY6fyELvkHOzb3QQMNQu8x7Oqb6lW0KxatqiYzYTt00=; b=
	XlJYcf6eQlzw3CSinImqc9ZnXU8fYx/sSga1AvByDgp8QYpu+npcZHF6wQodztbU
	GutJOy/krWAMVAghqaeE2sGQDUXsbHXvcC5vAgNbtFyfhxAcKjt4qsp9OPwY0CNW
	Y+cidQMO16yYvD9qY0FTIV1nfe6Yo22s0dLYvb9W8VKG9E2kxKckQdquuASAkhno
	nBYo1kuxXEZvGkjXAJb6ROT9tMisRF4S3n8H0LNLUqQLWLVC8AF9CZD206pbdCIH
	qoHYUbvwe+jnysGUtScWS74c7PkMTdz7Lt+YDnhWXdh7m+Y/93XJailm91POLAuR
	QXwGqi1v/XWiAq79LBQVHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761172654; x=1761259054; bh=P
	Y6fyELvkHOzb3QQMNQu8x7Oqb6lW0KxatqiYzYTt00=; b=yNtIfcXwyyCSkMWRV
	eiOm2AZEPpdKshdElAMMLNOfS8kp9mXCTF0aZkIdAVuqFHS46LpxVQmCu3S2qyON
	dcB1Agy8o6zaL+Istqqnz3z9XJMAacjFGlzHCYKck1Jg9ieC5ME915ZTMj+SYjho
	LHDj+ja1KxDQCq4um8lLsg5XxjNDv7Imp7T2O3N2msd4/XvnmJVsZrJdMa0U/+ih
	0Go7z2tFQ474WltvAwpJl4M+QFXYocd5hw0iHlhGNIgq+SV7o1dhk7mgYBTQAziu
	adkhKLL+7omkdQ2Y32lAEqDpQEP09gyY4UJ6O7yEoiFErOMy2oCjqFAAqfyJ28O/
	paCsA==
X-ME-Sender: <xms:rlz5aEm5zjBvR6yGR8UADKNB27Z9iIq8JhL5ZZLE57tv9LfaaH0eIA>
    <xme:rlz5aMTUi-gWlZCKkT_ooXhY8K9orxLpjP0RomHQRQS2bXiP4E05l17p9RaPhtTj7
    trl5tZlARnByEtYgBiS8lj2l0ZfWMi_JtVf4JV1HYoPiPwiVb4>
X-ME-Received: <xmr:rlz5aDEfT6VyYNEhAN7KPLvGA5ECvwikO8KBXOuzc3yIT8Cz3kDt6Rzmc__g2gryCd7Nt7-_dZNvhHRB4_YUdQO2Yipw35nG_Xz6OUJa75v1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegjeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:rlz5aBEdWB7qk7dJUIJLp1QT_RzyNx58xAhMiukOtCa7sqmZnNbNmg>
    <xmx:rlz5aBTFfS5PhwpvY-l3hcqBcHrCKZScuebeKkY1t8j-6wdD7QWuIQ>
    <xmx:rlz5aCJYFd8JHBn6MXPaVshPfTFBzoncrYFrY7DqtygvgjJ1X0xoYw>
    <xmx:rlz5aMYWa-MehY6Cjd8bOqEMIrAovZJTUxftbjvBspCQ6zYTw8f2og>
    <xmx:rlz5aNxBkI0xSfvq3BXEyXrRJ9g5aJgJFMu2kKj7hM1q0uFcOIkFU2mw>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:32 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/8] nfsd: prepare XXX_current_stateid() functions to be non-static
Date: Thu, 23 Oct 2025 09:34:29 +1100
Message-ID: <20251022223713.1217694-3-neilb@ownmail.net>
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

A future patch will call the current_stateid accessor from both
nfs4state.c and nfs4proc.c.  To prepare for that some cleanup and
documentation is in order:

- rename to have a nfs4v1_ prefix, to mention "_current_stateid"
  consisently, and change "put" to "save" as that seems more meaningful.

- provide kernel doc for the three functions

- move the "v4.1 only" test from put_stateid to get_stateid as it seems
  to make more sense there: it is only reasonable to test
  IS_CURRENT_STATE() when we know that session are in use.

- place the extern declaration in nfs4xdr.h rather than
  current_stateid.h as future patch will remove the latter file.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h |  1 -
 fs/nfsd/nfs4proc.c        |  2 +-
 fs/nfsd/nfs4state.c       | 66 ++++++++++++++++++++++++---------------
 fs/nfsd/xdr4.h            | 17 ++++++++++
 4 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
index c28540d86742..24d769043207 100644
--- a/fs/nfsd/current_stateid.h
+++ b/fs/nfsd/current_stateid.h
@@ -5,7 +5,6 @@
 #include "state.h"
 #include "xdr4.h"
 
-extern void clear_current_stateid(struct nfsd4_compound_state *cstate);
 /*
  * functions to set current state id
  */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2222bb283baf..a2b78577ddb2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2967,7 +2967,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 				op->opdesc->op_set_currentstateid(cstate, &op->u);
 
 			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
-				clear_current_stateid(cstate);
+				nfsd41_clear_current_stateid(cstate);
 
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b270dc0af7f1..8e45c1bbe13d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9088,27 +9088,41 @@ nfs4_state_shutdown(void)
 	shrinker_free(nfsd_slot_shrinker);
 }
 
-static void
-get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
+/**
+ * nfsd41_get_current_stated - use the saved v4.1 stateid if appropriate
+ * @cstate - the state of the current COMPOUND procedure
+ * @stateid - the stateid field of the current operation
+ *
+ * If the current operation requests use of the v4.1 "current_stateid" and
+ * if a stateid has been saved by a previous operation in this COMPOUND,
+ * then copy that saved stateid into the current op so it will be available
+ * for use.
+ */
+void
+nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	if (nfsd4_has_session(cstate) &&
+	    HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
 	    IS_CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
-static void
-put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
-{
-	if (cstate->minorversion) {
-		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
-	}
-}
-
+/**
+ * nfsd41_save_current_stated - saved a v4.1 stateid for future operations
+ * @cstate - the state of the current COMPOUND procedure
+ * @stateid - the stateid field of the current operation
+ *
+ * This should be called from operations which create or update a stateid
+ * that should be available for future v4.1 ops in the same COMPOUND.
+ * It saves the stateid and records that there is a saved stateid.
+ * It is safe to call this with any states including v4.0.  v4.0 states
+ * will simply be ignored.
+ */
 void
-clear_current_stateid(struct nfsd4_compound_state *cstate)
+nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
+	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 }
 
 /*
@@ -9118,28 +9132,28 @@ void
 nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	put_stateid(cstate, &u->open_downgrade.od_stateid);
+	nfsd41_save_current_stateid(cstate, &u->open_downgrade.od_stateid);
 }
 
 void
 nfsd4_set_openstateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	put_stateid(cstate, &u->open.op_stateid);
+	nfsd41_save_current_stateid(cstate, &u->open.op_stateid);
 }
 
 void
 nfsd4_set_closestateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	put_stateid(cstate, &u->close.cl_stateid);
+	nfsd41_save_current_stateid(cstate, &u->close.cl_stateid);
 }
 
 void
 nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	put_stateid(cstate, &u->lock.lk_resp_stateid);
+	nfsd41_save_current_stateid(cstate, &u->lock.lk_resp_stateid);
 }
 
 /*
@@ -9150,56 +9164,56 @@ void
 nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	get_stateid(cstate, &u->open_downgrade.od_stateid);
+	nfsd41_get_current_stateid(cstate, &u->open_downgrade.od_stateid);
 }
 
 void
 nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	get_stateid(cstate, &u->delegreturn.dr_stateid);
+	nfsd41_get_current_stateid(cstate, &u->delegreturn.dr_stateid);
 }
 
 void
 nfsd4_get_freestateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	get_stateid(cstate, &u->free_stateid.fr_stateid);
+	nfsd41_get_current_stateid(cstate, &u->free_stateid.fr_stateid);
 }
 
 void
 nfsd4_get_setattrstateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	get_stateid(cstate, &u->setattr.sa_stateid);
+	nfsd41_get_current_stateid(cstate, &u->setattr.sa_stateid);
 }
 
 void
 nfsd4_get_closestateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	get_stateid(cstate, &u->close.cl_stateid);
+	nfsd41_get_current_stateid(cstate, &u->close.cl_stateid);
 }
 
 void
 nfsd4_get_lockustateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	get_stateid(cstate, &u->locku.lu_stateid);
+	nfsd41_get_current_stateid(cstate, &u->locku.lu_stateid);
 }
 
 void
 nfsd4_get_readstateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	get_stateid(cstate, &u->read.rd_stateid);
+	nfsd41_get_current_stateid(cstate, &u->read.rd_stateid);
 }
 
 void
 nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	get_stateid(cstate, &u->write.wr_stateid);
+	nfsd41_get_current_stateid(cstate, &u->write.wr_stateid);
 }
 
 /**
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ae75846b3cd7..3bd201ad2fa7 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -202,6 +202,23 @@ static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
 	return cs->slot != NULL;
 }
 
+void nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate,
+				stateid_t *stateid);
+void nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate,
+				 stateid_t *stateid);
+/**
+ * nfsd41_clear_current_stated - clear the saved v4.1 stateid
+ * @cstate - the state of the current COMPOUND procedure
+ *
+ * Mark the COMPOUND state as no longer having a current stateid, so
+ * use of the "current_stateid" special stateid is now invalid.
+ */
+static inline
+void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate)
+{
+	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+}
+
 struct nfsd4_change_info {
 	u32		atomic;
 	u64		before_change;
-- 
2.50.0.107.gf914562f5916.dirty


