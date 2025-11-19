Return-Path: <linux-nfs+bounces-16514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CB3C6CA02
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B5894EF656
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B441DF742;
	Wed, 19 Nov 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hCSkGjkC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cx+bgw04"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1D2EC579
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523170; cv=none; b=OmdTNU8QJtjMtLoDNKyf4Rd4Eslx9fBn5UOqtWsEFzokjH3zoWc9bmMLbmsHCQZaG6ATjMtjfkD5r0pH4OgFksjctY6zdsl4lGNS6U3uN9qp6FXd9S/N0vYGYfemXzjJy42aPRmAytDhGIkBV76/4Hosn19VXKT65VrHxVe24/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523170; c=relaxed/simple;
	bh=049WRyx2BIbhpqdX/+akMaVc46ab3Jn2Tr3P9+O8Ux8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8+VkPxy285ky4/2gvDxXLS9ioiDdVJ4p+AZvUek5NvbJ75SvXjOX7E5VhzPwyZoX6nUIYIIbTM34O+w3vYgbGAeuT3n8HVjNXOnO51R1O3KOdz0J3/+2PPMef6MbUolLQlWzKn7biHgtP70G9LIK5c/D6fGBW72Ve/mlqbNEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hCSkGjkC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cx+bgw04; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CDC41D00158;
	Tue, 18 Nov 2025 22:32:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 18 Nov 2025 22:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523166;
	 x=1763609566; bh=jJAm0jnuBGk6uSycFwq90itr/7DsWyD2XKiXv4ej77U=; b=
	hCSkGjkCLLWnikQtccDV4NIiQd0e6CA5m25eZAaSM6M5iS7il12FQjDPJWUefvJH
	I0dWC/cAw2oe+YRFxd4cNYiCAb1XBK232JLKb4mANM/X6iSjKNGIduGC83AZGcKz
	Bndy9PuSJpZh95f6xhJIGX58wXqMIMjP/uZmZUV9egzeY54fXW+fSX9qmVcCMXQU
	2dx342lOOEv8dgs+lIWpFPl+OHTMxdbJ1YQsWnUpIpOQJorD7XpDM9kUJ37IuoME
	fuGwOO98/4qnC3eDqwidE0P3fQ+Cox2HRqZthxWteV7Pu8NGhm7Arv1lCUPkO3Ov
	z/3s4PHsqO0HTMrVPX0xOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523166; x=1763609566; bh=j
	JAm0jnuBGk6uSycFwq90itr/7DsWyD2XKiXv4ej77U=; b=Cx+bgw04gzsFvrrm2
	+MwSdh7dCYMb+PumulqNldErAjB5npEt3Jna39swkDPWW5Xbt8w4miZKiEf4QhSN
	y6LLscb/cN9/bWcIYhS+FAZFV+nd7xPkcr5ddpR6x9TOin0B4yW0Ve+NdP0P2Ww7
	xY7u0+zVr/dQC23tn2Q8gGeTmidhMQZ9mCG0dSnOzAEPO1fdI9OovbzPvcuFXzcF
	xfCXeLeYoBm7nqGd4eIl4pWqxM1HkD8eeef93jijZZlGtk3D7dw+sz5AJXhuP8Ha
	iDB1q5khTrml+f8P2/wq3GdW6zEMCU46DcPQIZ11wH7MVGSyXFM2fUgjScphO1By
	58jlg==
X-ME-Sender: <xms:XjodaVg1CdjPhrZnBoxMnZPBbdyKHL3iqJJu-vm7Q7CLTL0tlrrP7g>
    <xme:XjodadsHarb7Tuab5qlFbONnNk1zY8cZauyC_VFi2heP0TlVws9FdHa0baegxeKHy
    hTnMk7KtBGzhSgrCrVBqrDi2p5RxVR-Jj4aQXnmpFcBJGlsG8s>
X-ME-Received: <xmr:Xjodae502157E7C7e-ytLa27ZJS4xFUr94DQp5f0ECiuL7XNHZwCesz8nsfPJgty9LPidv_lzhDAUInOjp4xqA4zld4WY5MsXw06SI2s3yzK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:XjodaRMN1KH0OkSdR088GaYglHmkNGQIRmnbsgOQlTsnVK2DoY1WfQ>
    <xmx:XjodaUtyAlkRZhWzwnJmrHMwbcnBhzp9-h143iN52i6aA3ZBQ6jUcA>
    <xmx:XjodacYqDg8dZEl2kXrb4xIJ0PYyBDSW5oC8YuQ2mNf7hHJd5l6r_g>
    <xmx:XjodaeyQBlQZ8E6WXGPkzpPiye94-34Y3F88YjhpmLlnlfb-zgz5gw>
    <xmx:XjodaXAksA5AzxS9CwAXVeH2u-aUuGB9nYFaslnFNj3FeHbs7KPJpQsW>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:44 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 07/11] nfsd: simplify clearing of current-state-id
Date: Wed, 19 Nov 2025 14:28:53 +1100
Message-ID: <20251119033204.360415-8-neilb@ownmail.net>
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

In NFSv4.1 the current and saved filehandle each have a corresponding
stateid.  RFC 8881 requires that in certain circumstances - particularly
when the current filehandle is changed - the current stateid should be
set to the anonymous stateid (all zeros).  It also requires that when a
request tries to use the current stateid, if that stateid is "special"
(which includes the anonymous stateid), then a BAD_STATEID error must
be produced.

Linux nfsd current implements these requirements using a flag to record
if the stateid (current or saved) is valid rather than actually storing
the anon stateid when invalid.  This has the same net effect.

The aim of this patch is to simplify this code and particularly to
remove the per-op OP_CLEAR_STATEID flag which is unnecessary.

The "is valid" flag is moved from 'struct nfsd4_compound_state' to
'struct svc_fh' which already has a number of flags related to the
filehandle.  This flag will only ever be set for the v4 current_fh and
saved_fh and records if the corresponding stateid is valid.

fh_put() is changed to clear this flag.  As this is called on current_fh
in each op that currently has OP_CLEAR_STATEID set, this automatically
clears the stored stateid when required so OP_CLEAR_STATEID is no longer
needed.

As fh_dup2() already copies all of the svc_fh, it now copies the new
fh_have_stateid flag as well, so savefh and restorefh are simplified.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h |  1 -
 fs/nfsd/nfs4proc.c        | 25 ++++++++-----------------
 fs/nfsd/nfs4state.c       | 10 ++--------
 fs/nfsd/nfsfh.h           |  1 +
 fs/nfsd/xdr4.h            | 13 -------------
 5 files changed, 11 insertions(+), 39 deletions(-)

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
index e61b1ee6c8d8..ae4094ff12dc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -737,10 +737,7 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_restorefh;
 
 	fh_dup2(&cstate->current_fh, &cstate->save_fh);
-	if (HAS_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG)) {
-		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
-	}
+	memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
 	return nfs_ok;
 }
 
@@ -757,10 +754,7 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_nofilehandle;
 
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
-		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG);
-	}
+	memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
 	return nfs_ok;
 }
 
@@ -2954,9 +2948,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			if (op->opdesc->op_set_currentstateid)
 				op->opdesc->op_set_currentstateid(cstate, &op->u);
 
-			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
-				clear_current_stateid(cstate);
-
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
@@ -3401,7 +3392,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_CREATE] = {
 		.op_func = nfsd4_create,
-		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME | OP_CLEAR_STATEID,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_CREATE",
 		.op_rsize_bop = nfsd4_create_rsize,
 	},
@@ -3455,13 +3446,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_LOOKUP] = {
 		.op_func = nfsd4_lookup,
-		.op_flags = OP_HANDLES_WRONGSEC | OP_CLEAR_STATEID,
+		.op_flags = OP_HANDLES_WRONGSEC,
 		.op_name = "OP_LOOKUP",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_LOOKUPP] = {
 		.op_func = nfsd4_lookupp,
-		.op_flags = OP_HANDLES_WRONGSEC | OP_CLEAR_STATEID,
+		.op_flags = OP_HANDLES_WRONGSEC,
 		.op_name = "OP_LOOKUPP",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
@@ -3494,21 +3485,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
 		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
-				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
+				| OP_IS_PUTFH_LIKE,
 		.op_name = "OP_PUTFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_PUTPUBFH] = {
 		.op_func = nfsd4_putrootfh,
 		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
-				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
+				| OP_IS_PUTFH_LIKE,
 		.op_name = "OP_PUTPUBFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_PUTROOTFH] = {
 		.op_func = nfsd4_putrootfh,
 		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
-				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
+				| OP_IS_PUTFH_LIKE,
 		.op_name = "OP_PUTROOTFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f92b01bdb4dd..7ffe0b8e44de 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9106,7 +9106,7 @@ nfs4_state_shutdown(void)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	if (cstate->current_fh.fh_have_stateid &&
 	    is_current_stateid(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
@@ -9116,16 +9116,10 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
 	if (cstate->minorversion) {
 		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+		cstate->current_fh.fh_have_stateid = true;
 	}
 }
 
-void
-clear_current_stateid(struct nfsd4_compound_state *cstate)
-{
-	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
-}
-
 /*
  * functions to set current state id
  */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 43fcc1dcf69a..0142227c90e6 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -93,6 +93,7 @@ typedef struct svc_fh {
 						 */
 	bool			fh_use_wgather;	/* NFSv2 wgather option */
 	bool			fh_64bit_cookies;/* readdir cookie size */
+	bool			fh_have_stateid; /* associated v4.1 stateid is not special */
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index bcaf631ec12d..b6ab32c7b243 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -43,13 +43,6 @@
 #define NFSD4_MAX_TAGLEN	128
 #define XDR_LEN(n)                     (((n) + 3) & ~3)
 
-#define CURRENT_STATE_ID_FLAG (1<<0)
-#define SAVED_STATE_ID_FLAG (1<<1)
-
-#define SET_CSTATE_FLAG(c, f) ((c)->sid_flags |= (f))
-#define HAS_CSTATE_FLAG(c, f) ((c)->sid_flags & (f))
-#define CLEAR_CSTATE_FLAG(c, f) ((c)->sid_flags &= ~(f))
-
 /**
  * nfsd4_encode_bool - Encode an XDR bool type result
  * @xdr: target XDR stream
@@ -194,8 +187,6 @@ struct nfsd4_compound_state {
 	__be32			saved_status;
 	stateid_t	current_stateid;
 	stateid_t	save_stateid;
-	/* to indicate current and saved state id presents */
-	u32		sid_flags;
 };
 
 static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
@@ -1030,10 +1021,6 @@ enum nfsd4_op_flags {
 	 * the v4.0 case).
 	 */
 	OP_CACHEME = 1 << 6,
-	/*
-	 * These are ops which clear current state id.
-	 */
-	OP_CLEAR_STATEID = 1 << 7,
 	/* Most ops return only an error on failure; some may do more: */
 	OP_NONTRIVIAL_ERROR_ENCODE = 1 << 8,
 };
-- 
2.50.0.107.gf914562f5916.dirty


