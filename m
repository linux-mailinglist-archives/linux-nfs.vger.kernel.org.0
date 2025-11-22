Return-Path: <linux-nfs+bounces-16650-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC36C7C088
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E952935F9BF
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63D1F09AD;
	Sat, 22 Nov 2025 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="b68DyCJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G8iGbJSe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5514A91
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772774; cv=none; b=Auf9sw7NyOw6MxSrzN9ijU+el7e4gTd94qey5Lk11/E6r+AuuGLTi+z+QRblUMpd3v7rSBNbta+K8TlZGkA8TXNjjlnhzoIdxvWkGMCvUO68A//S6KKX+7itUk36S5WAOTaM9klnSYAWJ10o9IrhSNLTome/bPMXn1hcrTP5Neo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772774; c=relaxed/simple;
	bh=IE/qkI62mssy8APCNwpemnZcfDSsJcoZ007smn7khwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7JH1S8gdVm47WzesHCwhBMCf0gAe+ZrixM/jeawjbCTljPn9hGCnijyXkoGAOAXGeEwvvJ6BKh0LDMa8XSIDciyz96hzfVxO5cKzjoGBVBoX27oezMDWeJget3R7Jqd3O3aKkVfYMx3dU/LmLLByqIJcayGheTs8YK2QlShHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=b68DyCJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G8iGbJSe; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62C95140009C;
	Fri, 21 Nov 2025 19:52:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 19:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772771;
	 x=1763859171; bh=UJOiwWML3KyjOTUgRQfxIvv1YE00lHFywavySo2lkeA=; b=
	b68DyCJ1J8fYHuRnNGH812rEULMcylMh/B4uEzG4rjtP3RplCCYfgxx+hRJav1LJ
	Gme4/YJASLBetDvqjC5mmB2xtftfNRY7WM3Zl4UgEYqiX9cywpYCxLx3Th8hw2HQ
	u+1hzQ68w3b+SkZbQhPpuIWZqFOc4J4CyIZaCFcq8CHpWuW6wcSf6B4y9y4/OEQs
	KGEvT7gPJSZOG1TNZfN9KBgIguBWO61gl9scKzxRcnkSnj3pC7PGrxTYTGd4aBGp
	WcF0uRfmWRbhr6fKK2Ii6fgRNLCdNVETiyKdlZukjkk3/WFzJ1AplumaH/U9wheu
	ZgdKyc110JEWtiFyXtl5Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772771; x=1763859171; bh=U
	JOiwWML3KyjOTUgRQfxIvv1YE00lHFywavySo2lkeA=; b=G8iGbJSej7ZfpicDx
	cIEO/LzAuyD9yHQwEyRWOnWpzD2tMZS0tr+qeDJeFv6OrV1Ahn954pElmeF6B4B6
	/1dTt+ikfF8RtL3CuuwXXWjMYM5+bCZV63vq5QkjijvJ8wSMq1FwkLMBtQ6Y50Eg
	gMZGtRrURl8w6JZSucEZKNB0gVCyuPlUWeZN1BbytTRjLuNBVBWTt6fDsKky4/Vd
	CpAXP6zkfrSRcgzVfJlAPIuGAwxePMYtra4b3krpJ8GeUcShUnosWXQ15Qv8CXtR
	D2TZy/z/tuocb7mpKWOi3iOJEJBa4mrQP5LoXNSESwq1ovcJeR+2jL7yk88kxtzA
	H30lQ==
X-ME-Sender: <xms:YwkhaVOblkAsP9xvDRxYK0ws_jPit7TlVt6uEz9EMfFkwBLr5e9tHA>
    <xme:Ywkhabr1ofEN-KHPaBo4BbQ-0kZ8CidUhPPkWPFU865exOo8qgDR6vsAcwD5eG9dc
    _wDXl22Olt-SMivuKYCzyXesYZYj3XaRWkFRxivBtmx64BW>
X-ME-Received: <xmr:YwkhaeEW9oBeBsKBy6dtxr4sDXwhkjCJMc3K-WiOweANW2CDoEpNu8RREjYBPSqsGtEVhbXeOeeX7RR_Wj8Zm3FerMKTMgdDgVvy5pJjqSXq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:YwkhaYpTrxqDvFz6Y_fw2YruAh8OyqJ8ddmY7fHVXsIQ3dWt8DbeGw>
    <xmx:YwkhafZcYvdL6xJNeodIMHEoz3bxAtnwODjw6LGZcgIC_zee4ZFnMw>
    <xmx:YwkhaZW3Xkr7IqI-3E4f6VQUB1-WltlLWFOBCoK007hD-c48pxa5CQ>
    <xmx:YwkhaQ9_qETr96_YaK8mWCl0liPpTFmHw1I7Dl1ms_xP4x5gmZf-ow>
    <xmx:YwkhaSuy326_cCR65Q3SVHhkx0DuW_ZQrc3Jw4X3JYg4_olv0AMdT2Ta>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:52:49 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 01/14] nfsd: rename ALLOWED_WITHOUT_FH to ALLOWED_WITHOUT_LOCAL_FH and revise use
Date: Sat, 22 Nov 2025 11:46:59 +1100
Message-ID: <20251122005236.3440177-2-neilb@ownmail.net>
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

nfsdv4 OPs which do not have ALLOWED_WITHOUT_FH can assume that a PUTFH
has been called and may actually assume that current_fh->fh_dentry is
non-NULL.  nfsd4_setattr(), for example, assumes fh_dentry != NULL.

However the possibility of foreign filehandles (needed for v4.2 COPY)
means that there may be a filehandle present while fh_dentry is NULL.

Sending a COMPOUND containing:
   SEQUENCE
   PUTFH - foreign filehandle
   SETATTR - new mode
   SAVEFH
   COPY - with non-empty server list

to an NFS server with inter-server copy enabled will cause a NULL
pointer dereference when nfsd4_setattr() calls fh_want_write().

Most NFSv4 OPs actually want a "local" filehandle, not just any
filehandle.  So this patch renames ALLOWED_WITHOUT_FH to
ALLOWED_WITHOUT_LOCAL_FH and sets it on all the other which DON'T
require a local filehandle.  That is: all that don't require any
filehandle together with SAVEFH, which is the only OP which needs to
handle a foreign current_fh.  (COPY must handle a foreign save_fh, but
all OPs which access save_fh already do any required validity tests
themselves).

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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v5
 - fix compile failure: need cstate->current_fh
 - comment for ALLOWED_WITHOUT_LOCAL_FH improved
---
 fs/nfsd/nfs4proc.c | 59 ++++++++++++++++++++++++++--------------------
 fs/nfsd/xdr4.h     |  2 +-
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index dcad50846a97..947b1b6d2282 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -729,6 +729,16 @@ static __be32
 nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
+	/*
+	 * SAVEFH is "ALLOWED_WITHOUT_LOCAL_FH" in that
+	 * current_fh.fh_dentry is not required, those some fh_handle
+	 * *is* required so that a foreign fh can be saved as needed for
+	 * inter-server COPY.
+	 */
+	if (!cstate->current_fh.fh_dentry &&
+	    !HAS_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN))
+		return nfserr_nofilehandle;
+
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
 	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
 		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
@@ -2919,14 +2929,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
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
@@ -3507,21 +3515,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3557,7 +3565,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_RENEW] = {
 		.op_func = nfsd4_renew,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_RENEW",
 		.op_rsize_bop = nfsd4_only_status_rsize,
@@ -3565,14 +3573,15 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3593,7 +3602,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_SETCLIENTID] = {
 		.op_func = nfsd4_setclientid,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_MODIFIES_SOMETHING | OP_CACHEME
 				| OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_SETCLIENTID",
@@ -3601,7 +3610,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_SETCLIENTID_CONFIRM] = {
 		.op_func = nfsd4_setclientid_confirm,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_SETCLIENTID_CONFIRM",
 		.op_rsize_bop = nfsd4_only_status_rsize,
@@ -3620,7 +3629,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_RELEASE_LOCKOWNER] = {
 		.op_func = nfsd4_release_lockowner,
-		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_RELEASE_LOCKOWNER",
 		.op_rsize_bop = nfsd4_only_status_rsize,
@@ -3630,54 +3639,54 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3690,13 +3699,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3711,7 +3720,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	[OP_GETDEVICEINFO] = {
 		.op_func = nfsd4_getdeviceinfo,
 		.op_release = nfsd4_getdeviceinfo_release,
-		.op_flags = ALLOWED_WITHOUT_FH,
+		.op_flags = ALLOWED_WITHOUT_LOCAL_FH,
 		.op_name = "OP_GETDEVICEINFO",
 		.op_rsize_bop = nfsd4_getdeviceinfo_rsize,
 	},
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ae75846b3cd7..e27258e694a9 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1006,7 +1006,7 @@ extern __be32 nfsd4_free_stateid(struct svc_rqst *rqstp,
 extern void nfsd4_bump_seqid(struct nfsd4_compound_state *, __be32 nfserr);
 
 enum nfsd4_op_flags {
-	ALLOWED_WITHOUT_FH = 1 << 0,    /* No current filehandle required */
+	ALLOWED_WITHOUT_LOCAL_FH = 1 << 0,    /* No fh_dentry needed in current filehandle */
 	ALLOWED_ON_ABSENT_FS = 1 << 1,  /* ops processed on absent fs */
 	ALLOWED_AS_FIRST_OP = 1 << 2,   /* ops reqired first in compound */
 	/* For rfc 5661 section 2.6.3.1.1: */
-- 
2.50.0.107.gf914562f5916.dirty


