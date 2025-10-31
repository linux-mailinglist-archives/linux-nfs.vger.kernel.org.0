Return-Path: <linux-nfs+bounces-15832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949EEC232A8
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468613BF112
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D328E5;
	Fri, 31 Oct 2025 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iXmpzZdK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1iA+OS/q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8325CC7A
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881179; cv=none; b=W6SsunJfNDGPmczuz2SH42S92Ukfm6Sp0HPcFLyA9LmNq1rIamuIV2ltqifbkZfiId3Lv+gBZnnLR/6zfw+E3RFnjtYcGGM25c4eIfXJOL5RPv9exmyaZVNb1kM0pmoaOcgosBwQNUET4DSy3cj+jFQxpas1do/Uw4ySRWZHsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881179; c=relaxed/simple;
	bh=rVzzFWuL9ihl6slRA3Cxv9WAngnvvhTzNl4u/tyDLLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsh8C2iYOnj7Y45k7guLMjOUjtiQjGsSSylrxXswcw/VpSdOKBhHcy+CsN4TO4ITf0znYkgYMmDPy7jVrBEAFqkJDgDAfkRVWgySIH6eQweCwiRC6unndVx2l9TMB3OGzXKpFPGnR9F9fl8lj9ZCtKZ722gZHKAQjLtiVEjuWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iXmpzZdK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1iA+OS/q; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E388E7A011A;
	Thu, 30 Oct 2025 23:26:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 30 Oct 2025 23:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881176;
	 x=1761967576; bh=db9LwmP1tLSPONQQP/Yy+fOGOtmMEV/jQ9rbMJLjJQU=; b=
	iXmpzZdKrUoK1Ia1WcsxVKaMcHTx/BYLTQG2Hrie0OCBpkYZpcoLhfvuL1WAXG/E
	n4ePq4gyTxyq4Hj7lDPJXgAspdxhEJmdHAzZ+pZmk8JvQ3msbBmOXd8I0NH+WH1E
	cBw/70W6lxdhC1vM+hKeEvhmWvvGAflCGll2shlxkdzLZbSWZmi9kqAeuu1K71t7
	qA7vRII8nDyPCi+QSIHdArejotHN3iANHwufpvtLMWDfSlkPu7mPTzqMxPiH8krC
	mBcnwPl5j3x60QN2vPDbAd3wukjYnodfMVFeK3otC2r5bqh9yziY96kqBpZ2H3Qe
	S9jSh9IT6+EqrDPonCYryQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881176; x=1761967576; bh=d
	b9LwmP1tLSPONQQP/Yy+fOGOtmMEV/jQ9rbMJLjJQU=; b=1iA+OS/qgqI+hDq/9
	/T/N9qVYAxgjSLW4djtOPZ2bnZgTvGRYxVvRzJ2cLsU3N01QM+eIBPmIUvNc7UXb
	SVdKuMxIpCPo0EkYO8N77LlF/a1J+H/z4s2SxkX0besbsyhU3h8QgFm/jNSHoBBT
	tR8V0+2EnGXOAn/sxbeK4boyK7hG/2fN4k9+GIjV2AQZPiK+9BaTkt0nNU2mDZPo
	5Tey9/ST/CtFM3n59MszipfC83r5elkh3Xi/vkUA7zredJTKxH/xkLEjQre41oJH
	LSY6O6QPJrtaYSLs6wTQAgTYHHvrtyYJjMolBRnCtvsaIFl1SLkKvB6TktN/Ysj1
	b/XHg==
X-ME-Sender: <xms:WCwEaS4fK5Sj6wLIKKGzi-Lo0gH4yU-h4NEvtlCYM2WTjaD7tN2lrg>
    <xme:WCwEafnbOG7ylVUmBOHxL2CTaRjzHGHcWZIXKR7oMLJH6-JbqM1GUrSRy2aX6eMVB
    mTKKHIjIwgH_CT3m9seNJ79d1a9fozUWDL2YH4uiGd_XWrFGqE>
X-ME-Received: <xmr:WCwEabS5JgQiYfp10wEvB36fh8k88UE9kYlfTFyX9SLDcNMWVZrfma4ZESfY2PHKO_vnLj8UpiMkqPElQFnzcfy9j4XPjE4Eg-6HyaeJmJNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WCwEaWE5Mr1Z34eu2UCtZ0oGqW4PaqpUfpZS76pdPbqe7zq56uUIAA>
    <xmx:WCwEaYFj0RdCKKGp9uO04znXhw1OabV4fKUgAqyBkkeXLhDjDFiKWg>
    <xmx:WCwEacRiqWs3PWDr2m8r53FADqKVvQkFWE1yXVZx2txP8A58uDtqyA>
    <xmx:WCwEaRKckxizjzPHL6U4gEsE7DEwj2i2GoJGkCVv1ORPF_fSQF-buw>
    <xmx:WCwEacZ1EpWu1A8GgTYfb3rciU_yh3SzxLnAituuwc86q_vWCka-jBzd>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:26:14 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 08/10] nfsd: simplify saving of the current stateid
Date: Fri, 31 Oct 2025 14:16:15 +1100
Message-ID: <20251031032524.2141840-9-neilb@ownmail.net>
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

One can that this does not cover is CLOSE.  CLOSE always reports a
special (invalid) stateid, so it is change to simply mark the current
stateid as not valid.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 11 -------
 fs/nfsd/nfs4layouts.c     | 10 ++++---
 fs/nfsd/nfs4proc.c        | 11 ++-----
 fs/nfsd/nfs4state.c       | 63 +++++++++++----------------------------
 fs/nfsd/pnfs.h            |  5 ++--
 fs/nfsd/state.h           |  3 +-
 fs/nfsd/xdr4.h            |  4 ++-
 7 files changed, 33 insertions(+), 74 deletions(-)

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
index 284a79be0c26..e527594148ca 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -626,7 +626,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	status = nfsd4_process_open2(rqstp, resfh, open);
+	status = nfsd4_process_open2(rqstp, cstate, resfh, open);
 	if (status && open->op_created)
 		pr_warn("nfsd4_process_open2 failed to open newly-created file: status=%u\n",
 			be32_to_cpu(status));
@@ -2497,7 +2497,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	if (nfserr)
 		goto out_put_stid;
 
-	nfserr = nfsd4_insert_layout(lgp, ls);
+	nfserr = nfsd4_insert_layout(cstate, lgp, ls);
 
 out_put_stid:
 	mutex_unlock(&ls->ls_mutex);
@@ -2954,9 +2954,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			goto out;
 		}
 		if (!op->status) {
-			if (op->opdesc->op_set_currentstateid)
-				op->opdesc->op_set_currentstateid(cstate, &op->u);
-
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
@@ -3390,7 +3387,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
 		.op_func = nfsd4_commit,
@@ -3435,7 +3431,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 				OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_LOCK",
 		.op_rsize_bop = nfsd4_lock_rsize,
-		.op_set_currentstateid = nfsd4_set_lockstateid,
 	},
 	[OP_LOCKT] = {
 		.op_func = nfsd4_lockt,
@@ -3472,7 +3467,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN",
 		.op_rsize_bop = nfsd4_open_rsize,
-		.op_set_currentstateid = nfsd4_set_openstateid,
 	},
 	[OP_OPEN_CONFIRM] = {
 		.op_func = nfsd4_open_confirm,
@@ -3485,7 +3479,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f4d18a4c1063..d2c5c1aefed3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1199,7 +1199,8 @@ nfs4_put_stid(struct nfs4_stid *s)
 }
 
 void
-nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid)
+nfs4_inc_and_copy_stateid(struct nfsd4_compound_state *cstate,
+			  stateid_t *dst, struct nfs4_stid *stid)
 {
 	stateid_t *src = &stid->sc_stateid;
 
@@ -1208,6 +1209,10 @@ nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid)
 		src->si_generation = 1;
 	memcpy(dst, src, sizeof(*dst));
 	spin_unlock(&stid->sc_lock);
+	if (cstate) {
+		memcpy(&cstate->current_stateid, dst, sizeof(stateid_t));
+		cstate->current_fh.fh_have_stateid = true;
+	}
 }
 
 static void put_deleg_file(struct nfs4_file *fp)
@@ -6385,6 +6390,7 @@ static bool open_xor_delegation(struct nfsd4_open *open)
 /**
  * nfsd4_process_open2 - finish open processing
  * @rqstp: the RPC transaction being executed
+ * @cstate: the nfsd4_compound_state for the current COMPOUND.
  * @current_fh: NFSv4 COMPOUND's current filehandle
  * @open: OPEN arguments
  *
@@ -6395,7 +6401,8 @@ static bool open_xor_delegation(struct nfsd4_open *open)
  * network byte order is returned.
  */
 __be32
-nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
+nfsd4_process_open2(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		    struct svc_fh *current_fh, struct nfsd4_open *open)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct nfs4_client *cl = open->op_openowner->oo_owner.so_client;
@@ -6477,7 +6484,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			open->op_odstate = NULL;
 	}
 
-	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &open->op_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
 
 	if (nfsd4_has_session(&resp->cstate)) {
@@ -7674,7 +7681,7 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto put_stateid;
 	}
 	oo->oo_flags |= NFS4_OO_CONFIRMED;
-	nfs4_inc_and_copy_stateid(&oc->oc_resp_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &oc->oc_resp_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
 	trace_nfsd_open_confirm(oc->oc_seqid, &stp->st_stid.sc_stateid);
 	nfsd4_client_record_create(oo->oo_owner.so_client);
@@ -7746,7 +7753,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	}
 	nfs4_stateid_downgrade(stp, od->od_share_access);
 	reset_union_bmap_deny(od->od_share_deny, stp);
-	nfs4_inc_and_copy_stateid(&od->od_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &od->od_stateid, &stp->st_stid);
 	status = nfs_ok;
 put_stateid:
 	mutex_unlock(&stp->st_mutex);
@@ -7816,7 +7823,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * copied value below, but we continue to do so here just to ensure
 	 * that racing ops see that there was a state change.
 	 */
-	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &close->cl_stateid, &stp->st_stid);
 
 	need_move_to_close_list = nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
@@ -7832,6 +7839,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 */
 	memcpy(&close->cl_stateid, &invalid_stateid, sizeof(close->cl_stateid));
 
+	cstate->current_fh.fh_have_stateid = false;
+
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
 out:
@@ -8405,7 +8414,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
 	switch (err) {
 	case 0: /* success! */
-		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
+		nfs4_inc_and_copy_stateid(cstate, &lock->lk_resp_stateid, &lock_stp->st_stid);
 		status = 0;
 		if (lock->lk_reclaim)
 			nn->somebody_reclaimed = true;
@@ -8650,7 +8659,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfs4_locku: vfs_lock_file failed!\n");
 		goto out_nfserr;
 	}
-	nfs4_inc_and_copy_stateid(&locku->lu_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &locku->lu_stateid, &stp->st_stid);
 put_file:
 	nfsd_file_put(nf);
 put_stateid:
@@ -9099,44 +9108,6 @@ nfs4_state_shutdown(void)
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
index dbb3497b088c..4c439eadc818 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -964,7 +964,9 @@ __be32 nfsd4_reclaim_complete(struct svc_rqst *, struct nfsd4_compound_state *,
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


