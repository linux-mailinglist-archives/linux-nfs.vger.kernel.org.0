Return-Path: <linux-nfs+bounces-16661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40BC7C0BB
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE1454EB568
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FA23ABAA;
	Sat, 22 Nov 2025 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WX8yQdsr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cTqtDRPr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AF253F11
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772821; cv=none; b=knR+9MUNK9BHqtfZX1fBtoReSw+hEWO11sxUCMcLG2XgEX2VNGQKpgnkVTuB5dzIIiTvRvwcjny2XDVwJiJjw2F6YjJi4fITxtspTSVilvv8CChXD0pnxF47qmwpIMPU+9D2X9DwavHa0efAZ7GzFoums25mNatzpg9o11q2yJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772821; c=relaxed/simple;
	bh=xIGB7CAp4qS+VwgG84OW8VLBDmriztMPJYYt8Si2yK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLvIQz5VGYMrZKpaWqYsVaTFUnVa9NqgsKQZFepu45IWeHU/22cMCjrt6YSEez0q7/gAabHTlOZxILgdIg+SdD/bm3RCqDiWioKiHkbShRyCYcXQUxoceJmduZf8M1NgQvMge2NMpOdXNnRvLkVwdlXeW4vaumo9OmibgLc+BFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WX8yQdsr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cTqtDRPr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D02014000B6;
	Fri, 21 Nov 2025 19:53:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 19:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772818;
	 x=1763859218; bh=hPxjow6zBBx1rTa1ifyEFbm0LqW6YdhPEDw6kdGjdvU=; b=
	WX8yQdsr0Oc7ote3kNJAev08AT2nXbuE3Di02CTgZ5/+xO4VZ038dX8v0+PyBn0U
	DrCQeMyQyHxz8+/MRnIo6ntDxHRY1oBj33LfeQ2LreEReofoRtroSCc1rYL5oLck
	4oH8LmNC8XE47HnV+qo3qs2TNe+hIUB/uIryBPIpObsRVCEXLvpIyWgWarxQOxjF
	/TgvAsMbplIrGM5pdLuVzkoNYNYIhqeR0dKOsgVMoBmvTVx9iaBqjlqHcSxKhqsV
	+No/cgndldFz+MYukjf01SK3uKI3hjEAg/0T4PYy4MepZY2w53VxJu3KdPXUt9/L
	ia6v5eTA26bAc0vVUDsusQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772818; x=1763859218; bh=h
	Pxjow6zBBx1rTa1ifyEFbm0LqW6YdhPEDw6kdGjdvU=; b=cTqtDRPrYKvkXUOjb
	55fwCUCnW0at1rH0qOkxH3p9nb/mna3TO2UJjcApBJDSHeCeafbexr+eru2K4Zvy
	k6f5xpb/HCEp9oyz0BFu1sUtZe+DRsmIzEmVM3l2aXaBsZj+WA7hQNVRhy4f7Fr8
	hWdSXJL3qA7y0xSgzJqtVY7bRWOd7abguVaZvFcz4vpNMzbZ61t2AivvI7Z7syD7
	Z8EH+GRxyiaCPJbc9C5pp5mOjo0gRd9BB7eB607kMcKt5CBMXr/ltDZQKL3yIO3x
	TKic3jWPvoxPUUSZ68Cpprvi6S+tI4Bm+fHaRKWouYOrQJ5Fh/orbZUwaL0fGFC0
	78bVw==
X-ME-Sender: <xms:kQkhabXPmnxgoHDciaXvSY6NJOrRmXoO8ygP3tmirG5UiGsaNzSeRQ>
    <xme:kQkhaXRP1IwJfwITrC-dVFxe5uozrxPCl0miTM7ctXt1FY_htF2BOlb_S42nL6qbu
    vmh5ICB6bT3KYVPP0uWPk7tCAyEFw5xpYbdzYbXNDGEfH_5zrM>
X-ME-Received: <xmr:kQkhaRNne9UsCzUhlTvnyTPVuChbr9uPf4UGYz2drCMlAipqztMIAE0It4B27P7hpf_wV0bOQXrJehgJ_FeUkEoUabLINltHPfwLyluLvhDb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:kQkhadRklyfYjzEyweoI1aVu5jRmJpLrqXCxMYBaWfa3cq263dV94A>
    <xmx:kQkhaXg18hHuL6M7-C0GykWiX5L98DanlskDL-ZTzh-OkZ76m2Qssg>
    <xmx:kQkhae-y-inQPRre_-dRsnB4pDgigKD386uuyKKx3JkZ64jBu0H4Mw>
    <xmx:kQkhaWFg3WCRcuJjzpomwgc1H4yEVI8bJLkMbA8n0gPGOHM65xm51Q>
    <xmx:kgkhaQ116tCu7Lw4xHxEzXYUi020RYTkkxiUFcEa6VfRRx7F03HyJfmn>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:35 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 12/14] nfsd: simplify saving of the current stateid
Date: Sat, 22 Nov 2025 11:47:10 +1100
Message-ID: <20251122005236.3440177-13-neilb@ownmail.net>
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
 fs/nfsd/xdr4.h            |  1 +
 7 files changed, 30 insertions(+), 73 deletions(-)

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
index 784f241c7119..806306f48043 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -635,7 +635,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	status = nfsd4_process_open2(rqstp, &cstate->current_fh, &parent_fh, open);
+	status = nfsd4_process_open2(rqstp, cstate, &cstate->current_fh, &parent_fh, open);
 	fh_put(&parent_fh);
 	if (status && open->op_created)
 		pr_warn("nfsd4_process_open2 failed to open newly-created file: status=%u\n",
@@ -2536,7 +2536,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	if (nfserr)
 		goto out_put_stid;
 
-	nfserr = nfsd4_insert_layout(lgp, ls);
+	nfserr = nfsd4_insert_layout(cstate, lgp, ls);
 
 out_put_stid:
 	mutex_unlock(&ls->ls_mutex);
@@ -2953,9 +2953,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			goto out;
 		}
 		if (!op->status) {
-			if (op->opdesc->op_set_currentstateid)
-				op->opdesc->op_set_currentstateid(cstate, &op->u);
-
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
@@ -3389,7 +3386,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CLOSE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_closestateid,
 	},
 	[OP_COMMIT] = {
 		.op_func = nfsd4_commit,
@@ -3434,7 +3430,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 				OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_LOCK",
 		.op_rsize_bop = nfsd4_lock_rsize,
-		.op_set_currentstateid = nfsd4_set_lockstateid,
 	},
 	[OP_LOCKT] = {
 		.op_func = nfsd4_lockt,
@@ -3471,7 +3466,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN",
 		.op_rsize_bop = nfsd4_open_rsize,
-		.op_set_currentstateid = nfsd4_set_openstateid,
 	},
 	[OP_OPEN_CONFIRM] = {
 		.op_func = nfsd4_open_confirm,
@@ -3484,7 +3478,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_OPEN_DOWNGRADE",
 		.op_rsize_bop = nfsd4_status_stateid_rsize,
-		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
 	},
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index de66b2971cd3..e3b38245ba45 100644
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
@@ -6399,6 +6404,7 @@ static bool open_xor_delegation(struct nfsd4_open *open)
 /**
  * nfsd4_process_open2 - finish open processing
  * @rqstp: the RPC transaction being executed
+ * @cstate: the nfsd4_compound_state for the current COMPOUND.
  * @current_fh: NFSv4 COMPOUND's current filehandle
  * @parent_fh: filehandle of parent when CLAIM_NULL
  * @open: OPEN arguments
@@ -6410,7 +6416,8 @@ static bool open_xor_delegation(struct nfsd4_open *open)
  * network byte order is returned.
  */
 __be32
-nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh,
+nfsd4_process_open2(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		    struct svc_fh *current_fh,
 		    struct svc_fh *parent_fh,
 		    struct nfsd4_open *open)
 {
@@ -6494,7 +6501,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh,
 			open->op_odstate = NULL;
 	}
 
-	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &open->op_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
 
 	if (nfsd4_has_session(&resp->cstate)) {
@@ -7688,7 +7695,7 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto put_stateid;
 	}
 	oo->oo_flags |= NFS4_OO_CONFIRMED;
-	nfs4_inc_and_copy_stateid(&oc->oc_resp_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &oc->oc_resp_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
 	trace_nfsd_open_confirm(oc->oc_seqid, &stp->st_stid.sc_stateid);
 	nfsd4_client_record_create(oo->oo_owner.so_client);
@@ -7760,7 +7767,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	}
 	nfs4_stateid_downgrade(stp, od->od_share_access);
 	reset_union_bmap_deny(od->od_share_deny, stp);
-	nfs4_inc_and_copy_stateid(&od->od_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &od->od_stateid, &stp->st_stid);
 	status = nfs_ok;
 put_stateid:
 	mutex_unlock(&stp->st_mutex);
@@ -7830,7 +7837,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * copied value below, but we continue to do so here just to ensure
 	 * that racing ops see that there was a state change.
 	 */
-	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &close->cl_stateid, &stp->st_stid);
 
 	need_move_to_close_list = nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
@@ -7845,6 +7852,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * See RFC5661 section 18.2.4, and RFC7530 section 16.2.5
 	 */
 	memcpy(&close->cl_stateid, &invalid_stateid, sizeof(close->cl_stateid));
+	cstate->current_fh.fh_have_stateid = false;
 
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
@@ -8419,7 +8427,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
 	switch (err) {
 	case 0: /* success! */
-		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
+		nfs4_inc_and_copy_stateid(cstate, &lock->lk_resp_stateid, &lock_stp->st_stid);
 		status = 0;
 		if (lock->lk_reclaim)
 			nn->somebody_reclaimed = true;
@@ -8664,7 +8672,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfs4_locku: vfs_lock_file failed!\n");
 		goto out_nfserr;
 	}
-	nfs4_inc_and_copy_stateid(&locku->lu_stateid, &stp->st_stid);
+	nfs4_inc_and_copy_stateid(cstate, &locku->lu_stateid, &stp->st_stid);
 put_file:
 	nfsd_file_put(nf);
 put_stateid:
@@ -9113,44 +9121,6 @@ nfs4_state_shutdown(void)
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
index 4f54108f24f9..ad1b96f50131 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -965,6 +965,7 @@ __be32 nfsd4_reclaim_complete(struct svc_rqst *, struct nfsd4_compound_state *,
 extern __be32 nfsd4_process_open1(struct nfsd4_compound_state *,
 		struct nfsd4_open *open, struct nfsd_net *nn);
 extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,
+				  struct nfsd4_compound_state *cstate,
 				  struct svc_fh *current_fh,
 				  struct svc_fh *parent_fh,
 				  struct nfsd4_open *open);
-- 
2.50.0.107.gf914562f5916.dirty


