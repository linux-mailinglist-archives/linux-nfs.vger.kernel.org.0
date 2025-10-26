Return-Path: <linux-nfs+bounces-15635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74BBC0B5D1
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612453B1845
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBF41F4CAE;
	Sun, 26 Oct 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="S4+CkQvQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVRT3zZj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470371F30C3
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517656; cv=none; b=CavhHdzy3XSkYvBPhzIz6elchZbUe7/w6M6h0NOvkEOdzRLJP7qhkhKQT1jUgrhGWDY4jSV0UykEwSNUU/YI0bZ2zXt9zShNlokc/JvNNLtwfKZw3E1hzqpDkIDS0bzDSUL1ff5vMnd+UiSKPmFEutHIbboNhYSusf8aP1BBqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517656; c=relaxed/simple;
	bh=xTbMv6hYp5+EQoMnjMI9wZ7aQzcVY2HZUiCNrPjA2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA6rOs34BX+lWdaPscABeBh6L3+qKIQXzfONcXzL+VcaQxrO7yCkaiMgtCro13/Vnd9JMvoXkoE0QFYkCBoKorDhUWlxGsA/8DS7C2xtgCLo6Dy+eaIFmGAWNC8pX2ESAFDbqyy4Dk+SE9KeQ3GZV80OPKpZtENMudiX0NQbtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=S4+CkQvQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVRT3zZj; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 685D31D001B1;
	Sun, 26 Oct 2025 18:27:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 26 Oct 2025 18:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517653;
	 x=1761604053; bh=87vJwUKwbh+oqICoXwRQguyXCnoboRRelmmrCpd5oc0=; b=
	S4+CkQvQjPXctn3TRLZPLPV3VPjbn1mYS2B7VAkxnnNJbUpTPW+0vJQrxthFGGne
	ixlqZWWD0fZxjaE0+yhsKZocB+riJG/unIYttUsOtqwCJ5AkKjwdwxZSG6f41Xqt
	32Oz5dWusq44rgEKBK11XuvFBGYT0V7K6pOwnKGrwLK5XG2HzHCY9AssBDU2JsmX
	OsefiJKHyMJwmKlMUbi/rhMzXreYiQ0Hlf9gr676W7rVKD/qjP6IalDNPiwaX5Qp
	OQflu6ffPvJt4DkWhSGDce69M2b3h2IDH7WPYJrhknJnZbYqwoJBpZBcdgnbq1aC
	xLw+D5lAa3juOV2XyzK3qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517653; x=1761604053; bh=8
	7vJwUKwbh+oqICoXwRQguyXCnoboRRelmmrCpd5oc0=; b=iVRT3zZja9XEZuytZ
	23+izggmIo/wirJibJdt/6RFg398cixBgn63HXoVmUSwAbJDDVoXXNyTXkDgP2j9
	kQwnHBsWmKqTOvNy2bx9a0T0rmOfLKndL5mfH4v6C/YxllKtTtMFDU6hXdLkgFjl
	OD8T8F3PsQ7Zbyp95Q9joYGn+xmyQT+Zv1pbVDqH2Dv8xkQ+8OMlIzJiDNgSgwVP
	U3kqfZbRcyZg5G019whdlLkKguzq7xVg59y/MQXqj3XY0vHj5z5dfngNbKCN717t
	zkvesIu2HrpQTz5aATs4FCfdVNMh2FNxDMvcDJS+kwQfQ0arE6VIfdfBN8tXFP1Y
	78ECg==
X-ME-Sender: <xms:VaD-aAqrXfojyGZPBRycJWGGo2FLQBI26pVwZ-2asiIJONmWoROzzw>
    <xme:VaD-aKUQNhI5EhCqvtj079P3Qc6qMucnmunp4G2YjvDA9AIOk3nBM0IPIaMyNOx-4
    BSUAUAQDnvKPODrfxDeNlZOWWoOK1wMnD4fKQWpn0HNH3cz0g>
X-ME-Received: <xmr:VaD-aPCu2AoLFHm93-aLcVW1VV_T8G10rpxkTzRm768hTQAx_SVcvVWyHCRbiiY9CqZkiV45rJfEvcwlY-G8UzO0v293cdg6nB1mSme5CXBn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VaD-aO2Lm5S-xIc_BnXUQaj6Gx7WKMRFu1bpEY1_2aloi52xwBNU2w>
    <xmx:VaD-aB1R4_CnH4lFdxxPlaVUBykZRHvmsarHm8L0Nl8J0h6QX6ofDg>
    <xmx:VaD-aDC2lUfUqWs0mmbqzKrqdKI7NL2ZT0hn9Q6rYColscLg_Hl6nw>
    <xmx:VaD-aA4ptp5HB46MGAgL218y2mJZpWSOhYw1G_6oQm0GckmjJ0h40g>
    <xmx:VaD-aKLsG5JN8Ws62mq2gnwBqsayF6apa5t1CM-8xL8ZHmQT5_vUvK2U>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:31 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 04/10] nfsd: prepare XXX_current_stateid() functions to be non-static
Date: Mon, 27 Oct 2025 09:23:49 +1100
Message-ID: <20251026222655.3617028-5-neilb@ownmail.net>
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
 fs/nfsd/nfs4state.c       | 75 ++++++++++++++++++++++++++-------------
 fs/nfsd/xdr4.h            |  6 ++++
 4 files changed, 58 insertions(+), 26 deletions(-)

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
index cd8214a53145..83f05dec2bf0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9083,27 +9083,54 @@ nfs4_state_shutdown(void)
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
-put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
+/**
+ * nfsd41_save_current_stated - const saved a v4.1 stateid for future operations
+ * @cstate - the state of the current COMPOUND procedure
+ * @stateid - the stateid field of the current operation
+ *
+ * This should be called from operations which create or update a stateid
+ * that should be available for future v4.1 ops in the same COMPOUND.
+ * It saves the stateid and records that there is a saved stateid.
+ * It is safe to call this with any states including v4.0.  v4.0 states
+ * will simply be ignored.
+ */
+void
+nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
 {
-	if (cstate->minorversion) {
-		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
-	}
+	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
+	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 }
 
-void
-clear_current_stateid(struct nfsd4_compound_state *cstate)
+/**
+ * nfsd41_clear_current_stated - clear the saved v4.1 stateid
+ * @cstate - the state of the current COMPOUND procedure
+ *
+ * Store the anon_stateid in the current_stateid as required by
+ * RFC 8881 section 16.2.3.1.2 when the current filehandle changes
+ * without a regular stateid being available.
+ */
+void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate)
 {
-	put_stateid(cstate, &anon_stateid);
+	nfsd41_save_current_stateid(cstate, &anon_stateid);
 }
 
 /*
@@ -9113,28 +9140,28 @@ void
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
@@ -9145,56 +9172,56 @@ void
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
index ae75846b3cd7..e2a5fb926848 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -202,6 +202,12 @@ static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
 	return cs->slot != NULL;
 }
 
+void nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate,
+				stateid_t *stateid);
+void nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate,
+				 const stateid_t *stateid);
+void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate);
+
 struct nfsd4_change_info {
 	u32		atomic;
 	u64		before_change;
-- 
2.50.0.107.gf914562f5916.dirty


