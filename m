Return-Path: <linux-nfs+bounces-16508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D2C6C9BB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 261E02CB02
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA398221FDA;
	Wed, 19 Nov 2025 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="La1f0spy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fRTcjynq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFD2D8396
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523141; cv=none; b=AWoO5jLBbLbMDgDDtLOOizB2RfYMqmeo/3AyabzLQqZIn90CKB+kJUKhQr+Psy6r5zNdrYE3uZBro/U7upiDToRMxLPNRoFGPGeR2hMJT/yZkxTrLMxnwXKCmRvDs6Ko1m54lnEvcahdpNu8wIYVeSphLRdf9KxdmLM7AU205eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523141; c=relaxed/simple;
	bh=ypMo7V2A2APYu9JJgqjfCRv7qTlpl+rgFRjVabWgOvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oV4iLFC1q7gc5krjVwl8EnAe9gL7pEvwiJUN15AnT4hNDEOo0QaLR73xo8t8Mceh07sv+UBLfl/XlnOeqP/SP/PJOLuPwCRY1/SCu+OzXdCmd9JbhH8BEznJEsVgTnVbdVnsW1EeqwaiLA5eC80BWVc7iCyqSl5OzadN8yMvmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=La1f0spy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fRTcjynq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56FC57A0102;
	Tue, 18 Nov 2025 22:32:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 22:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523138;
	 x=1763609538; bh=R4xtmOaDUIoKUdD4jt1yir/am/BFEsq05GF8Xh6Pl1g=; b=
	La1f0spyb43x1g9x8m+S7vRozZcLifxl9xHyLWfD0ad5qBCE0ARsj8HLS8/g3lkZ
	jUgLmDLhOusfK439t6xFsCSDanuUBEJOP9Q6ejzQYWNYBMSX+r/ItH63EY/diQX7
	3AHsY58g7i0WGWg+FEX4y0GJACZchClm10ue/Bn9bAERXHvi5wtTu0XG1pxFiEKQ
	FCjkhR6xl4a41+HoceQJgk+n79lnL/pQTEqymIe9RGE53aHh2qVnEl+yyzx/v9HF
	3LKtuqEnbJfq7rUnoe3pp/QRE4VD+eAfYSz707kd7oPPdFu+f973L9HDGijAGrdp
	BGVBDyR+/S4Bh1u2TpDk6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523138; x=1763609538; bh=R
	4xtmOaDUIoKUdD4jt1yir/am/BFEsq05GF8Xh6Pl1g=; b=fRTcjynqDt6+nCRws
	U2ejlEybrUaz/BEGWrNQKmymhBq3aRnfeN32fJR9Mg34LbWuU48bV9rbXwS1/xSb
	FjV64T3HljZkbomwW0ORBscT8/JcKlbamp/8XZ9Wy8+ykfE0VoZnnlKsUYRF3Yie
	U0M9kHY1Fq3M5G/rALhSmMkdrdbdYE9uBWP0qne2fcFb4PiV/NOro9DuM7e54/TK
	rxU8pMJgIS8FWI+OiWBGDtHPoFTmddJb9vaGJZxHSlcixcbkCiDtBWImcHXaBWXD
	aQ49OsilH+UT7+MSEm5cJ65uPhLBQv5UcHzOs7MTpuDE1N4e9nzmmLI5hT0LWkq2
	ZeIFA==
X-ME-Sender: <xms:QjodaRFQEeSeRZEdhEJXVxvyc8DK5VCUrFBgwhMEWi0zFo7ORc55BQ>
    <xme:QjodaaCeay5tQgt5UE7zWq-3KBz7gkomnDyuNWQjsLi6owqx7SgYUhV07LhMAhhlp
    J16jRsCYSoiJksNZFRDVp1LkLJmgsSAKU-cwPKV_Vcz5MOohwM>
X-ME-Received: <xmr:Qjodac-kmbg81cl08eOqN4qIXOjPQMzeDEZnOeJwMfMPLYMKoGnUNqfEHIez5kW_AvPtOLyvPAGhuBnZyy5jajaweRJIaTKWWw8mach2TzNX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QjodaeCVPvh5KbtER0Bwq679zU99ms6A6vMwcWzRflKHZyTHc3OowQ>
    <xmx:QjodaZTfQr76f4NzqlUUCRqmE4RriBEKz4HoGKZt6YqIevQt3PfLZQ>
    <xmx:QjodadtI-Br425n-eFsB95etUVXKT3ETAWbWrARJhJrTRVY0UiTVEg>
    <xmx:Qjodad09GK9VRHiwUadiMO8ar2yzo6AthJ_HmWAPHFI8Lw5oglUztQ>
    <xmx:QjodaWmAhssgr9UrBRO9cHOhfFUqhNRICQnx589QnkAKz8xZeQuDTus1>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:15 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 01/11] nfsd: rename ALLOWED_WITHOUT_FH to ALLOWED_WITHOUT_LOCAL_FH and revise use
Date: Wed, 19 Nov 2025 14:28:47 +1100
Message-ID: <20251119033204.360415-2-neilb@ownmail.net>
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

nfsdv4 ops which do not have ALLOWED_WITHOUT_FH can assume that a PUTFH
has been called and may assume that current_fh->fh_dentry is non-NULL.
nfsd4_setattr(), for example, assumes fh_dentry != NULL.

However the possibility of foreign filehandles (needed for v4.2 COPY)
means that there maybe a filehandle present while fh_dentry is NULL.

Sending a COMPOUND containing:
   SEQUENCE
   PUTFH - foreign filehandle
   SETATTR - new mode
   SAVEFH
   COPY - with non-empty server list

to an NFS server with inter-server copy enabled will cause a NULL
pointer dereference when nfsd4_setattr() calls fh_want_write().

Most NFSv4 ops actually want a "local" filehandle, not just any
filehandle.  So this patch renames ALLOWED_WITHOUT_FH to
ALLOWED_WITHOUT_LOCAL_FH and sets it on those which don't require a local
filehandle.  That is all that don't require any filehandle together with
SAVEFH, which is the only OP which needs to handle a foreign current_fh.
(COPY must handle a foreign save_fh, but all ops which access save_fh
already do any required validity tests themselves).

nfsd4_savefh() is changed to validate the filehandle itself as the
caller no longer validates it.

nfsd4_proc_compound no longer allows ops without
ALLOWED_WITHOUT_LOCAL_FH to be called with a foreign fh - current_fh
must be local and ->fh_dentry must be non-NULL.  This protects
nfsd4_setattr() and any others that might use ->fh_dentry without
checking.

The
       current_fh->fh_export &&
test is removed from an "else if" because that condition is now only
tested when current_fh->fh_dentry is not NULL, and in that case
current_fh->fh_export is also guaranteed to not be NULL.

Fixes: b9e8638e3d9e ("NFSD: allow inter server COPY to have a STALE source server fh")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 58 ++++++++++++++++++++++++++--------------------
 fs/nfsd/xdr4.h     |  2 +-
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index dcad50846a97..e5871e861dce 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -729,6 +729,15 @@ static __be32
 nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
+	/*
+	 * SAVEFH is "ALLOWED_WITHOUT_LOCAL_FH" in that current_fh.fh_dentry
+	 * is not required, but fh_handle *is*.  Thus a foreign fh
+	 * can be saved as needed for inter-server COPY.
+	 */
+	if (!current_fh->fh_dentry &&
+	    !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN))
+		return nfserr_nofilehandle;
+
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
 	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
 		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
@@ -2919,14 +2928,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 				op->status = nfsd4_open_omfg(rqstp, cstate, op);
 			goto encode_op;
 		}
-		if (!current_fh->fh_dentry &&
-				!HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
-			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
+		if (!current_fh->fh_dentry) {
+			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_LOCAL_FH)) {
 				op->status = nfserr_nofilehandle;
 				goto encode_op;
 			}
-		} else if (current_fh->fh_export &&
-			   current_fh->fh_export->ex_fslocs.migrated &&
+		} else if (current_fh->fh_export->ex_fslocs.migrated &&
 			  !(op->opdesc->op_flags & ALLOWED_ON_ABSENT_FS)) {
 			op->status = nfserr_moved;
 			goto encode_op;
@@ -3507,21 +3514,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
 		.op_name = "OP_PUTFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_PUTPUBFH] = {
 		.op_func = nfsd4_putrootfh,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
 		.op_name = "OP_PUTPUBFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_PUTROOTFH] = {
 		.op_func = nfsd4_putrootfh,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
 		.op_name = "OP_PUTROOTFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
@@ -3557,7 +3564,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_RENEW] = {
 		.op_func = nfsd4_renew,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_RENEW",
 		.op_rsize_bop = nfsd4_only_status_rsize,
@@ -3565,14 +3572,15 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_RESTOREFH] = {
 		.op_func = nfsd4_restorefh,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_IS_PUTFH_LIKE | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_RESTOREFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_SAVEFH] = {
 		.op_func = nfsd4_savefh,
-		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH
+				| OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_SAVEFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
@@ -3593,7 +3601,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_SETCLIENTID] = {
 		.op_func = nfsd4_setclientid,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_MODIFIES_SOMETHING | OP_CACHEME
 				| OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_SETCLIENTID",
@@ -3601,7 +3609,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_SETCLIENTID_CONFIRM] = {
 		.op_func = nfsd4_setclientid_confirm,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_SETCLIENTID_CONFIRM",
 		.op_rsize_bop = nfsd4_only_status_rsize,
@@ -3620,7 +3628,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_RELEASE_LOCKOWNER] = {
 		.op_func = nfsd4_release_lockowner,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_RELEASE_LOCKOWNER",
 		.op_rsize_bop = nfsd4_only_status_rsize,
@@ -3630,54 +3638,54 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	[OP_EXCHANGE_ID] = {
 		.op_func = nfsd4_exchange_id,
 		.op_release = nfsd4_exchange_id_release,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_EXCHANGE_ID",
 		.op_rsize_bop = nfsd4_exchange_id_rsize,
 	},
 	[OP_BACKCHANNEL_CTL] = {
 		.op_func = nfsd4_backchannel_ctl,
-		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_BACKCHANNEL_CTL",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_BIND_CONN_TO_SESSION] = {
 		.op_func = nfsd4_bind_conn_to_session,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_BIND_CONN_TO_SESSION",
 		.op_rsize_bop = nfsd4_bind_conn_to_session_rsize,
 	},
 	[OP_CREATE_SESSION] = {
 		.op_func = nfsd4_create_session,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_CREATE_SESSION",
 		.op_rsize_bop = nfsd4_create_session_rsize,
 	},
 	[OP_DESTROY_SESSION] = {
 		.op_func = nfsd4_destroy_session,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_DESTROY_SESSION",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_SEQUENCE] = {
 		.op_func = nfsd4_sequence,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP,
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP,
 		.op_name = "OP_SEQUENCE",
 		.op_rsize_bop = nfsd4_sequence_rsize,
 	},
 	[OP_DESTROY_CLIENTID] = {
 		.op_func = nfsd4_destroy_clientid,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_DESTROY_CLIENTID",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_RECLAIM_COMPLETE] = {
 		.op_func = nfsd4_reclaim_complete,
-		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_RECLAIM_COMPLETE",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
@@ -3690,13 +3698,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_TEST_STATEID] = {
 		.op_func = nfsd4_test_stateid,
-		.op_flags = ALLOWED_WITHOUT_FH,
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH,
 		.op_name = "OP_TEST_STATEID",
 		.op_rsize_bop = nfsd4_test_stateid_rsize,
 	},
 	[OP_FREE_STATEID] = {
 		.op_func = nfsd4_free_stateid,
-		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
 		.op_name = "OP_FREE_STATEID",
 		.op_get_currentstateid = nfsd4_get_freestateid,
 		.op_rsize_bop = nfsd4_only_status_rsize,
@@ -3711,7 +3719,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	[OP_GETDEVICEINFO] = {
 		.op_func = nfsd4_getdeviceinfo,
 		.op_release = nfsd4_getdeviceinfo_release,
-		.op_flags = ALLOWED_WITHOUT_FH,
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH,
 		.op_name = "OP_GETDEVICEINFO",
 		.op_rsize_bop = nfsd4_getdeviceinfo_rsize,
 	},
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ae75846b3cd7..1f0967236cc2 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1006,7 +1006,7 @@ extern __be32 nfsd4_free_stateid(struct svc_rqst *rqstp,
 extern void nfsd4_bump_seqid(struct nfsd4_compound_state *, __be32 nfserr);
 
 enum nfsd4_op_flags {
-	ALLOWED_WITHOUT_FH = 1 << 0,    /* No current filehandle required */
+	ALLOWED_WITHOUT_LOCAL_FH = 1 << 0,    /* No current filehandle fh_dentry required */
 	ALLOWED_ON_ABSENT_FS = 1 << 1,  /* ops processed on absent fs */
 	ALLOWED_AS_FIRST_OP = 1 << 2,   /* ops reqired first in compound */
 	/* For rfc 5661 section 2.6.3.1.1: */
-- 
2.50.0.107.gf914562f5916.dirty


