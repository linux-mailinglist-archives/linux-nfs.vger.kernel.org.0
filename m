Return-Path: <linux-nfs+bounces-15829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E4C232AE
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FEBD4EDF56
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2C28E5;
	Fri, 31 Oct 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="QYlruCmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXv5bHpR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524352641C6
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881165; cv=none; b=JFU6I9lunzueiWzpYCEh4KmoXSK9H1IpVJXs95bgJJg5TBhDNd2De7kr5T0dkj8rBPDUhe1zJsXbRey2W7aH2RNsUigNExGy0v4Dm1QYFbUR1hKCkRuiaJhZKVzS6iDhhZifEvSpiPPIP9Tj7o+b/3XFWgU5MwOl5gccIjOJTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881165; c=relaxed/simple;
	bh=rTlTcQn09pFbYt+WquYY2ZawY5A2dKBp+ir0dwg2SQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxyUPc2OrrUJnJGGiJfPfItE3myHfAM9Fq12BYwkykwFNLcKIx3xDA0HzzePwh7DOavyWoJa3CgSLnclz/KvhPbTZ1stzXXR/GXqVFerGFyUHQnSjUON/bw+nWX/yHsTJ4BZTAB9RbKV1LudN/oVRrWt+mhsv5LsoBgiUNSa8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QYlruCmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXv5bHpR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A5EFC7A0163;
	Thu, 30 Oct 2025 23:26:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 23:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881162;
	 x=1761967562; bh=d3nCndqK/dOnStg5iwu8493vk8U/Yf1Z7QSeTO83sKo=; b=
	QYlruCmk0kYmcEfRFOF/UGI/Y2Ffy8uew+WREMrm2EdEP2IVMDcnHXaLKN2+ye56
	NbBILXn+sAP5PVLXGwm5Wah5o8pB+ljhefci0kcUIpDexXReMIlAgxvzMI27FDrA
	QP3UM7VZidZLShroyDpOlXFaFKC3WsMr+LGmKdDR2wzrCHyy5X0ndKNQ3xOHKzOG
	ZJifPxqrJ8nSA6WELOQd1CckIAKjfAwQxQcNfBOFFxUy4cGxr1sDaCZs7srZii7M
	S4BOKO5tFVe2FHJvhzp8JP4v0iz5Cvb2sv0C8LL5fHnjdQ100x6luxnuzO1X6nI3
	OvLoPUqEVLqIgF/evUMYeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881162; x=1761967562; bh=d
	3nCndqK/dOnStg5iwu8493vk8U/Yf1Z7QSeTO83sKo=; b=mXv5bHpRrr6pF9/0h
	2ZJSOWEuwIWhxDQ1gp/T43P6KHR7pAkrcoE3OkCF392qzRqZIZtiJ2YKYLS6MibA
	R1OJ42ypwTcYMydNBmNV0ow/AJdku9ppQmxBlTJLhAhhUnXj1MShqJdimswyS61P
	ZHLqZER0Ej+oEM6c+VUAAOTM4H5RvDM1AoJnVAc0sEmYzZkvnbVzr2RmqjXBbrRG
	0roYx50eBhcmyr6GbJjvXnsP1cREE08I61m+cG27/JVkLk68MmiOW7YSDFzoZPgr
	2BSlxLdTuZer62HYlWH6ULLvNTBHjEpJ1GQ6kRX39QRuFfJhepKa0lrzXMYDyxeJ
	B176w==
X-ME-Sender: <xms:SiwEadnK_BgNO5f0H9v5DEQB1jNGIBZPfTVhBSVjk2WrhZTqt3CQTw>
    <xme:SiwEaciVXufslKM9gJoPZselYg5-gy3X-6Q2_0_O5wFa7Znw9ynX2zoRvgG3UBTGd
    p-YEMLEeZZUnVOrEFmoged--_bcBaiPbYTBk4r-FsJMvVy0aA>
X-ME-Received: <xmr:SiwEadfQ-krEJwTRYp8GBYWUGyHOBWJRLFjsHrx7b_43wzSn3Bs4tiD3twNshGWHENPLT9-2DsAz5UkbGNkSOlBpfFNLTT9qdkiL0AlN584U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SiwEaUiFjSA7QFvr8p8ideLu8d9tl5ittDS-lrV7lZwtALTxVx5Spg>
    <xmx:SiwEadw-1rYubdHEyalcOr3ryGy70JCH989IExv_wO6asEYPgtr_4g>
    <xmx:SiwEaYOKsp_NxYtFWXMbJ6O8IjWOTOeMueWbsWLB5xVMkqiV7r-twg>
    <xmx:SiwEaWUiQ8AmwrwEeECYD3BshBl0WrSiSZ9V2ZEAX0l1IKCV_4-xgA>
    <xmx:SiwEaTFFxEP3RKW6gWUeJ7xPKcuEHhAXj6GoYjm3KZIyG242Sdtc_1Rq>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:26:00 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 05/10] nfsd: simplify clearing of current-state-id
Date: Fri, 31 Oct 2025 14:16:12 +1100
Message-ID: <20251031032524.2141840-6-neilb@ownmail.net>
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
index 2ab411718a27..948604a888c2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -714,10 +714,7 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_restorefh;
 
 	fh_dup2(&cstate->current_fh, &cstate->save_fh);
-	if (HAS_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG)) {
-		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
-	}
+	memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
 	return nfs_ok;
 }
 
@@ -726,10 +723,7 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
-		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG);
-	}
+	memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
 	return nfs_ok;
 }
 
@@ -2965,9 +2959,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			if (op->opdesc->op_set_currentstateid)
 				op->opdesc->op_set_currentstateid(cstate, &op->u);
 
-			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
-				clear_current_stateid(cstate);
-
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
@@ -3412,7 +3403,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_CREATE] = {
 		.op_func = nfsd4_create,
-		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME | OP_CLEAR_STATEID,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_CREATE",
 		.op_rsize_bop = nfsd4_create_rsize,
 	},
@@ -3466,13 +3457,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3505,21 +3496,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	[OP_PUTFH] = {
 		.op_func = nfsd4_putfh,
 		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
-				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
+				| OP_IS_PUTFH_LIKE,
 		.op_name = "OP_PUTFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_PUTPUBFH] = {
 		.op_func = nfsd4_putrootfh,
 		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
-				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
+				| OP_IS_PUTFH_LIKE,
 		.op_name = "OP_PUTPUBFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
 	[OP_PUTROOTFH] = {
 		.op_func = nfsd4_putrootfh,
 		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
-				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
+				| OP_IS_PUTFH_LIKE,
 		.op_name = "OP_PUTROOTFH",
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 82951a6ebb1c..fb10835eac2c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9091,7 +9091,7 @@ nfs4_state_shutdown(void)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	if (cstate->current_fh.fh_have_stateid &&
 	    is_current_stateid(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
@@ -9101,16 +9101,10 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
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
index 85019ae58ed3..995fafc383a0 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -94,6 +94,7 @@ typedef struct svc_fh {
 	bool			fh_use_wgather;	/* NFSv2 wgather option */
 	bool			fh_64bit_cookies;/* readdir cookie size */
 	bool			fh_foreign;
+	bool			fh_have_stateid; /* associated v4.1 stateid is not special */
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ae75846b3cd7..1eae9f9f43bc 100644
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
@@ -193,8 +186,6 @@ struct nfsd4_compound_state {
 	__be32			status;
 	stateid_t	current_stateid;
 	stateid_t	save_stateid;
-	/* to indicate current and saved state id presents */
-	u32		sid_flags;
 };
 
 static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
@@ -1029,10 +1020,6 @@ enum nfsd4_op_flags {
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


