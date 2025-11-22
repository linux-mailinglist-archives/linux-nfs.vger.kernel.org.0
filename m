Return-Path: <linux-nfs+bounces-16659-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EEDC7C0AC
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02A9A4E2E6B
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C211F09AD;
	Sat, 22 Nov 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WE7vywTs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pdCDZiZV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309414A91
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772811; cv=none; b=VVHWJbKRNmzVZWz+u/R6f+v6+pouYOxyXsytGOs+knYnRWR5Y5TObK3MW3il+Er1QCja2+5K+JOR7V/5IuGb1SxVc4CDm4jPd1I6d1lPHfuA/E/LFq6fKxNY96ReBue3MmQOaAkyk4xqbjYjK8RKJkGj3TWsHu73iYHK+shoE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772811; c=relaxed/simple;
	bh=FlvuxTkS+Udsdr4lk7f3PPkphuU0279ofp5t7ozqpKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELW5zTGkE/W60FB1HZabD5pocNmTF2nFNGzV5JltW3YQmjNpUBLauDuPC2V+vzrr3TiOXYYwzr/CeRLMzzFV33PN02gWBTjqiAZfPgZh1XyIlxwEimi87T5pjkwrA4XwdtAzUuQULQjO34InY5O9K1C8+mv88GucowJX+Qppwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WE7vywTs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pdCDZiZV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F11314000B6;
	Fri, 21 Nov 2025 19:53:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 19:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772809;
	 x=1763859209; bh=E5i5AO5/dEJHVRCDJ1VOv03WPmzPzAsxnS8cePdAfi0=; b=
	WE7vywTsMo0C9uQ3ynPXgbjW52NjYeI26GqZcogHk3JgJD8meSXrmIP0JguMOsD/
	jfaMSsZpvwwnRyCPvig6+NjvV8gGZLO1zX2MoVGW82pRQFBXDbc2TitJooH1JCva
	DWVDnu7dsLCFt7scvU+ok++9dPvh0cSZe8aR7G4+h3L4/X9u8B2M32gMYwMA/xG7
	YdRJjEQSzeinZcXla1RrVV2XBOUrw12nAcJ5w29OCAhtSgN9APRmb2/a2cFkMN9B
	EMqoRs8pTeXBvbgz/o4ChIaSO3/NWu1qMXksyTGhkOGPq9qDrVXd9veI2krzjD5y
	k6GZdFkaOvEZbWsuJzJFxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772809; x=1763859209; bh=E
	5i5AO5/dEJHVRCDJ1VOv03WPmzPzAsxnS8cePdAfi0=; b=pdCDZiZVEErKO1VHr
	lyLd3DvkW9pDb4lgXyTiDzEq8AxLulWJbnytddt9659vPn+HgX4CNYc4MB18UK/P
	LD6Dj5KRalfpx9lG8S6QMAee+vCoBDZP+wP1RtzoB1HWNJHlbnVj9zKSXEGEgtuy
	bpbd6MQCDutqk5pezG4yUXe9SLrKIkh21Vj6qWfUastn5li0Qm2NMqFgu5VZRB+Q
	jLY1exNYg9WTJPZHf1cgxfTaRYBp3un3IpmI/4t9E7yvID3SFHLtnAE+L/hpn+T1
	/xj/erU2MdTBQ1OPyqb2ag2A5yYVfceAVrTZYKW0Ka4MywSvZ/Zf9FXVcxIh279X
	VoV3w==
X-ME-Sender: <xms:iAkhaWcoUPoPc1yXtOwPn5Nd1ft_21MK0BSJpoy0Bq9uq3rVxyDObA>
    <xme:iAkhaT7_0iBMOzBZV7u1eHnrMZwvmQFL5v_lmLX3prIQfZd10GV5f9PsfkJlVlbx9
    Rl7JhFCKBYGJlgx740hnD8sGMEu1kh2zpLpEYtlNA8QlqXI>
X-ME-Received: <xmr:iAkhaRW8E-V7UgDwbacRoV40LU1w1KmWOYlV7oZUuvjSrPBm1ZdtXsVEAoKmfbK2o_KqhiLmlNreGefspFvkJMS2LNj70CEy2XJ54AEbV8Oy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iQkhaa5iq8F5AZJsAH_UT5KfTK5iIWzr7ikWFekva2CtvMqhL8ACUQ>
    <xmx:iQkhaUonf7M1MkiNxvocvaeBhRdrko646TRv8DMGz1eEo-_4xAhpfg>
    <xmx:iQkhaVlV2J27fcwiqraRHZRnDEKM4aYcnT744Adu2zyLcxm7sqtH5g>
    <xmx:iQkhaYPD3ntXrLDdgCA5iFNHuRsbVMabsLTxaBKLj2Hmh6ey3DFm_w>
    <xmx:iQkhaT_gkJkn60N4Vt-pGnH70_KGCxpdEMn7Rz_yotkz_rtPGzuQLI1K>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:26 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 10/14] nfsd: simplify clearing of current-state-id
Date: Sat, 22 Nov 2025 11:47:08 +1100
Message-ID: <20251122005236.3440177-11-neilb@ownmail.net>
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
changes since v5
- fh_put() is ACTUALLY changed to clear fh_have_stateid.
---
 fs/nfsd/current_stateid.h |  1 -
 fs/nfsd/nfs4proc.c        | 25 ++++++++-----------------
 fs/nfsd/nfs4state.c       | 10 ++--------
 fs/nfsd/nfsfh.c           |  1 +
 fs/nfsd/nfsfh.h           |  1 +
 fs/nfsd/xdr4.h            | 13 -------------
 6 files changed, 12 insertions(+), 39 deletions(-)

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
index 0f490f2524fa..ae9427ac7e5e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -746,10 +746,7 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_restorefh;
 
 	fh_dup2(&cstate->current_fh, &cstate->save_fh);
-	if (HAS_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG)) {
-		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
-	}
+	memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
 	return nfs_ok;
 }
 
@@ -767,10 +764,7 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_nofilehandle;
 
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
-		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG);
-	}
+	memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
 	return nfs_ok;
 }
 
@@ -2964,9 +2958,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			if (op->opdesc->op_set_currentstateid)
 				op->opdesc->op_set_currentstateid(cstate, &op->u);
 
-			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
-				clear_current_stateid(cstate);
-
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
@@ -3411,7 +3402,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_CREATE] = {
 		.op_func = nfsd4_create,
-		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME | OP_CLEAR_STATEID,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_CREATE",
 		.op_rsize_bop = nfsd4_create_rsize,
 	},
@@ -3465,13 +3456,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3504,21 +3495,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
index 3aebe90a12ec..03f29a6d7c14 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9105,7 +9105,7 @@ nfs4_state_shutdown(void)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	if (cstate->current_fh.fh_have_stateid &&
 	    is_current_stateid(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
@@ -9115,16 +9115,10 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
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
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 3c449e5e2459..b8e6abe830e3 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -807,6 +807,7 @@ fh_put(struct svc_fh *fhp)
 	}
 	fhp->fh_no_wcc = false;
 	fhp->fh_handle.fh_size = 0;
+	fhp->fh_have_stateid = false;
 	return;
 }
 
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
index ea61e1a4c263..87986f1d5506 100644
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
@@ -1032,10 +1023,6 @@ enum nfsd4_op_flags {
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


