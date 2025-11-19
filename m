Return-Path: <linux-nfs+bounces-16516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AEFC6CA0B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3B6B4EFACF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB11221FDA;
	Wed, 19 Nov 2025 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="U+FDKPWA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AvgXgXAq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C62EBDCD
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523179; cv=none; b=WUygwTGCIxpNqjKkjQY7w8ZwnwqDroKJnJmqty59KQ1EQi78wOSKZcdFIG/eS6npNnTvWjmmR26M0CnKesnBaZwoVpRiVKP6i+GLzhV1l4Xkv8GR2WPV0cnFaeoxAKWyzV5O2eibcHqMDUMls+TmfQfUpQXYFmMNQLUNS43BV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523179; c=relaxed/simple;
	bh=uMQ5kA0YiPJBLT7xPvrs14V6+xxGeidygtuExu7Cvmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIEjRXUIwoz9P55AytzdxKbk3cmZKFmyqdA2sPR7Qj7ajr1bL8WQkyYYzhHDIoHxIintADWNidG3DmsVqSp1U2SNWESTnLExlHBWCC4aRooPncHRq4mrOPbNRYsfbsDcWWwmb5btdbC8uYKtOEc39Hmz91yQ7o5Jv3Ujit4HGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=U+FDKPWA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AvgXgXAq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D1FA1D000B5;
	Tue, 18 Nov 2025 22:32:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 22:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523176;
	 x=1763609576; bh=OvnhEuUhJgHy2HtarUq460UjVK7U+b1a/6F+IYd0wds=; b=
	U+FDKPWAvxTWENXc5lqLQPYgATfZwrokvCG1FwKRXH/aC69Lrrx7+B2/LvSNfao2
	lAt3orv2Gsu+pVqpwt7Nps95N12KeFfPXBSHpgsTPkCs8lcKjFlbN8qCdA5mZ09Q
	qgITwRcABw98O/XCN7s35Fl6m8JCoeIKkzihRB5Yd50UHGmwBm4JlD7XQf8rEqou
	oHAZUALLynaT/GQLhUUfg9LXvl3WAKyxagORzCr+FtwRdXysVC+Tmnj4WzgRPEo+
	caz62ZbLnhgBCD+i09cLN0y3hAllLFaaZcMlKIpjKgjGo7V3jYWV8Hbh6rB1g0Qw
	TXUfAelk7KAF++yLGgbMzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523176; x=1763609576; bh=O
	vnhEuUhJgHy2HtarUq460UjVK7U+b1a/6F+IYd0wds=; b=AvgXgXAqUspJaDBCb
	P7Ttb7eiVesabmuxJP/ovtJxyNpmX/YgTT6vxCCG7rgxkCD8Xzh5PqVQjbovk6mM
	98LVXxf+TEwSC6/9sBGVj2zNWrQMPyIIeNkufeOdPC4DDKFTfF2cyoz3yTscWqG3
	c1BgNByzMpn+MAFjyCcJ4CF0350q0SsxaPZahFW41ePWqSlX2tpkJApOokBDa6OK
	3XH5uWC46YyAzFM8g7X/N13X9DlpwsAcbNFQsv+K8RDkcCNith5GzcWKPpTBv6aw
	aIvVPNTN46xqEJ2D2AKguKlWkvtlOM3W9iaakyj0syzI3CR4OItIqsTiRT3kwa0O
	nbhHQ==
X-ME-Sender: <xms:aDodaRRYv_CTg2rcynl6mvRY_IxyjH5793B0KDxKXk0W1rMl4ui5fw>
    <xme:aDodaee5e-x-ZsKAYl8jYiixzriYK41E_Z4CzQINy4uIJXrmP0zbhwIGP19R7Yweh
    M-GwBuNuxk0xLtok_ePkxIMFsTNBR-LkHbGEpc6im7H1XmgUw>
X-ME-Received: <xmr:aDodaQoMa9XWjVg74BFnjTdtT2skRtSbaM7eHnb47Pc7FmyjBmhxJG9uvJ8lgRUvBr9WIsIqtJiliK6lJKrhjCpENqL1U9bVjLx1AyTIh_Ja>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aDodaf-LirQcsjbHPYg1eZtt2ojxd4xZ0zfXwlSgDMPaXyxuN3fm_A>
    <xmx:aDodaceETvADhjaHvMnlklp4Uy1N6uVNBLGOtn8VpVF4CCesTY5ykw>
    <xmx:aDodaZJxXWU-2Jp1abd3wlp80kbWdHJ633mhZOYPOUK3ZB8hQx8sYg>
    <xmx:aDodacj9cnkisqbfZxpQl0gb1Pd0gtduXjd8BKDbJnfesOlbt3WzaA>
    <xmx:aDodaSyKKguVDYm0lqvLBkBpZolrWhlTe233CumaElnNXEK3kWFXcIRR>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:54 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 09/11] nfsd: simplify saving of the current stateid
Date: Wed, 19 Nov 2025 14:28:55 +1100
Message-ID: <20251119033204.360415-10-neilb@ownmail.net>
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

OPs that return a stateid must update the current stateid stored in the
COMPOUND state so it can be used in later OPs.

Every OP that returns a stateid uses nfs4_inc_and_copy_stateid() to
provide the stateid to return.

This patch updates that function to store the resulting stateid in
cstate->current_stateid, and passes cstate (the COMPOUND state) through
to the function in all cases except when used in a callback.

This removes the need for op_set_currentstateid.

This also sets the current stateid in more cases, such as LOCKU and
LAYOUTGET.

One case that this does not cover is CLOSE.  CLOSE always reports a
special (invalid) stateid, so it is changed to simply mark the current
stateid as not valid.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 11 -------
 fs/nfsd/nfs4layouts.c     | 10 ++++---
 fs/nfsd/nfs4proc.c        | 11 ++-----
 fs/nfsd/nfs4state.c       | 62 ++++++++++-----------------------------
 fs/nfsd/pnfs.h            |  5 ++--
 fs/nfsd/state.h           |  3 +-
 fs/nfsd/xdr4.h            |  4 ++-
 7 files changed, 32 insertions(+), 74 deletions(-)

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
index eaa4b8e40dc8..9dce3004b846 100644
--- a/fs/nfsd/current_stateid.h
+++ b/fs/nfsd/current_stateid.h
@@ -5,15 +5,4 @@
 #include "state.h"
 #include "xdr4.h"
 
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
 #endif   /* _NFSD4_CURRENT_STATE_H */
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe..4519a01bb354 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -414,7 +414,8 @@ nfsd4_recall_conflict(struct nfs4_layout_stateid *ls)
 }
 
 __be32
-nfsd4_insert_layout(struct nfsd4_layoutget *lgp, struct nfs4_layout_stateid *ls)
+nfsd4_insert_layout(struct nfsd4_compound_state *cstate,
+		    struct nfsd4_layoutget *lgp, struct nfs4_layout_stateid *ls)
 {
 	struct nfsd4_layout_seg *seg = &lgp->lg_seg;
 	struct nfs4_file *fp = ls->ls_stid.sc_file;
@@ -453,7 +454,7 @@ nfsd4_insert_layout(struct nfsd4_layoutget *lgp, struct nfs4_layout_stateid *ls)
 	list_add_tail(&new->lo_perstate, &ls->ls_layouts);
 	new = NULL;
 done:
-	nfs4_inc_and_copy_stateid(&lgp->lg_sid, &ls->ls_stid);
+	nfs4_inc_and_copy_stateid(cstate, &lgp->lg_sid, &ls->ls_stid);
 	spin_unlock(&ls->ls_lock);
 out:
 	spin_unlock(&fp->fi_lock);
@@ -528,7 +529,8 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 	}
 	if (!list_empty(&ls->ls_layouts)) {
 		if (found)
-			nfs4_inc_and_copy_stateid(&lrp->lr_sid, &ls->ls_stid);
+			nfs4_inc_and_copy_stateid(cstate, &lrp->lr_sid,
+						  &ls->ls_stid);
 		lrp->lrs_present = true;
 	} else {
 		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
@@ -659,7 +661,7 @@ nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 		container_of(cb, struct nfs4_layout_stateid, ls_recall);
 
 	mutex_lock(&ls->ls_mutex);
-	nfs4_inc_and_copy_stateid(&ls->ls_recall_sid, &ls->ls_stid);
+	nfs4_inc_and_copy_stateid(NULL, &ls->ls_recall_sid, &ls->ls_stid);
 	mutex_unlock(&ls->ls_mutex);
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ca1ed0a1bcab..eaa6a8c25ed6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -630,7 +630,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	status = nfsd4_process_open2(rqstp, resfh, open);
+	status = nfsd4_process_open2(rqstp, cstate, resfh, open);
 	if (status && open->op_created)
 		pr_warn("nfsd4_process_open2 failed to open newly-created file: status=%u\n",
 			be32_to_cpu(status));
@@ -2526,7 +2526,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	if (nfserr)
 		goto out_put_stid;
 
-	nfserr = nfsd4_insert_layout(lgp, ls);
+	nfserr = nfsd4_insert_layout(cstate, lgp, ls);
 
 out_put_stid:
 	mutex_unlock(&ls->ls_mutex);
@@ -2943,9 +2943,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			goto out;
 		}
 		if (!op->status) {
-			if (op->opdesc->op_set_currentstateid)
-				op->opdesc->op_set_currentstateid(cstate, &op->u);
-
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
@@ -3379,7 +3376,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
 		.op_func = nfsd4_commit,
@@ -3424,7 +3420,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 				OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_LOCK",
 		.op_rsize_bop = nfsd4_lock_rsize,
-		.op_set_currentstateid = nfsd4_set_lockstateid,
 	},
 	[OP_LOCKT] = {
 		.op_func = nfsd4_lockt,
@@ -3461,7 +3456,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN",
 		.op_rsize_bop = nfsd4_open_rsize,
-		.op_set_currentstateid = nfsd4_set_openstateid,
 	},
 	[OP_OPEN_CONFIRM] = {
 		.op_func = nfsd4_open_confirm,
@@ -3474,7 +3468,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ce7b958fa076..f01c72876ca9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1216,7 +1216,8 @@ nfs4_put_stid(struct nfs4_stid *s)
 }
 
 void
-nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid)
+nfs4_inc_and_copy_stateid(struct nfsd4_compound_state *cstate,
+			  stateid_t *dst, struct nfs4_stid *stid)
 {
 	stateid_t *src = &stid->sc_stateid;
 
@@ -1225,6 +1226,10 @@ nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid)
 		src->si_generation = 1;
 	memcpy(dst, src, sizeof(*dst));
 	spin_unlock(&stid->sc_lock);
+	if (cstate) {
+		memcpy(&cstate->current_stateid, dst, sizeof(stateid_t));
+		cstate->current_fh.fh_have_stateid = true;
+	}
 }
 
 static void put_deleg_file(struct nfs4_file *fp)
@@ -6402,6 +6407,7 @@ static bool open_xor_delegation(struct nfsd4_open *open)
 /**
  * nfsd4_process_open2 - finish open processing
  * @rqstp: the RPC transaction being executed
+ * @cstate: the nfsd4_compound_state for the current COMPOUND.
  * @current_fh: NFSv4 COMPOUND's current filehandle
  * @open: OPEN arguments
  *
@@ -6412,7 +6418,8 @@ static bool open_xor_delegation(struct nfsd4_open *open)
  * network byte order is returned.
  */
 __be32
-nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
+nfsd4_process_open2(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		    struct svc_fh *current_fh, struct nfsd4_open *open)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct nfs4_client *cl = open->op_openowner->oo_owner.so_client;
@@ -6494,7 +6501,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			open->op_odstate = NULL;
 	}
 
-	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &open->op_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
 
 	if (nfsd4_has_session(&resp->cstate)) {
@@ -7689,7 +7696,7 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto put_stateid;
 	}
 	oo->oo_flags |= NFS4_OO_CONFIRMED;
-	nfs4_inc_and_copy_stateid(&oc->oc_resp_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &oc->oc_resp_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
 	trace_nfsd_open_confirm(oc->oc_seqid, &stp->st_stid.sc_stateid);
 	nfsd4_client_record_create(oo->oo_owner.so_client);
@@ -7761,7 +7768,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	}
 	nfs4_stateid_downgrade(stp, od->od_share_access);
 	reset_union_bmap_deny(od->od_share_deny, stp);
-	nfs4_inc_and_copy_stateid(&od->od_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &od->od_stateid, &stp->st_stid);
 	status = nfs_ok;
 put_stateid:
 	mutex_unlock(&stp->st_mutex);
@@ -7831,7 +7838,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * copied value below, but we continue to do so here just to ensure
 	 * that racing ops see that there was a state change.
 	 */
-	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &close->cl_stateid, &stp->st_stid);
 
 	need_move_to_close_list = nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
@@ -7846,6 +7853,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * See RFC5661 section 18.2.4, and RFC7530 section 16.2.5
 	 */
 	memcpy(&close->cl_stateid, &invalid_stateid, sizeof(close->cl_stateid));
+	cstate->current_fh.fh_have_stateid = false;
 
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
@@ -8420,7 +8428,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
 	switch (err) {
 	case 0: /* success! */
-		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
+		nfs4_inc_and_copy_stateid(cstate, &lock->lk_resp_stateid, &lock_stp->st_stid);
 		status = 0;
 		if (lock->lk_reclaim)
 			nn->somebody_reclaimed = true;
@@ -8665,7 +8673,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfs4_locku: vfs_lock_file failed!\n");
 		goto out_nfserr;
 	}
-	nfs4_inc_and_copy_stateid(&locku->lu_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &locku->lu_stateid, &stp->st_stid);
 put_file:
 	nfsd_file_put(nf);
 put_stateid:
@@ -9114,44 +9122,6 @@ nfs4_state_shutdown(void)
 	shrinker_free(nfsd_slot_shrinker);
 }
 
-static void
-put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
-{
-	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-	cstate->current_fh.fh_have_stateid = true;
-}
-
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
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index db9af780438b..1714471d173d 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -56,8 +56,9 @@ extern const struct nfsd4_layout_ops ff_layout_ops;
 __be32 nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, stateid_t *stateid,
 		bool create, u32 layout_type, struct nfs4_layout_stateid **lsp);
-__be32 nfsd4_insert_layout(struct nfsd4_layoutget *lgp,
-		struct nfs4_layout_stateid *ls);
+__be32 nfsd4_insert_layout(struct nfsd4_compound_state *cstate,
+			   struct nfsd4_layoutget *lgp,
+			   struct nfs4_layout_stateid *ls);
 __be32 nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate,
 		struct nfsd4_layoutreturn *lrp);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1e736f402426..c6e97d6daa5f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -797,7 +797,8 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy);
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 			struct nfs4_stid *p_stid);
 void nfs4_put_stid(struct nfs4_stid *s);
-void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
+void nfs4_inc_and_copy_stateid(struct nfsd4_compound_state *cstate,
+			       stateid_t *dst, struct nfs4_stid *stid);
 void nfs4_remove_reclaim_record(struct nfs4_client_reclaim *, struct nfsd_net *);
 extern void nfs4_release_reclaim(struct nfsd_net *);
 extern struct nfs4_client_reclaim *nfsd4_find_reclaim_client(struct xdr_netobj name,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 55dab88b011c..1f26438168a8 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -965,7 +965,9 @@ __be32 nfsd4_reclaim_complete(struct svc_rqst *, struct nfsd4_compound_state *,
 extern __be32 nfsd4_process_open1(struct nfsd4_compound_state *,
 		struct nfsd4_open *open, struct nfsd_net *nn);
 extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,
-		struct svc_fh *current_fh, struct nfsd4_open *open);
+				  struct nfsd4_compound_state *cstate,
+				  struct svc_fh *current_fh,
+				  struct nfsd4_open *open);
 extern void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate);
 extern void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
 		struct nfsd4_open *open);
-- 
2.50.0.107.gf914562f5916.dirty


