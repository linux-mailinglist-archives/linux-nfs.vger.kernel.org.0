Return-Path: <linux-nfs+bounces-15354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F6BEC14B
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA4064F89FF
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA84A1A;
	Sat, 18 Oct 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="wrD5rIge";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Un0oWFJY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C31397
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745984; cv=none; b=FMoGZxjPFqFfx/M4oZmRJS7GNjPXQpqM3jNw+DIKInfI7DlaAUI8NPbjBeaxhclExyTu2gJjxWqK58/9yndw+vbJRFmLAmT7GeTyO+2UDHgxNCkqAMUTU/qBFLFVG64MglvVdakw7IkTYhj0wUzbI6rYoEhmLXP+E3Mn6CpS9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745984; c=relaxed/simple;
	bh=hP0t2qwYW91Sho23Ptl1xDoeAXckR1znObM6Yosqb6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ow7Fobcyf/KOhlpQVm4ycNYk3Xt/m7v3qapcMetNJe5bGbZ/Cs6IBX4ROXtHwThqvIYyuC9B6EgpV8QMdc4R3pnHX1t0G1ywDSA97/V3PLWIiWnkHNHVPG3WtXkGnGXM93mJgGYffHttH76KBMbek7ZRE61rmOPGuvUklVKRIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=wrD5rIge; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Un0oWFJY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFF2D7A00FB;
	Fri, 17 Oct 2025 20:06:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Oct 2025 20:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760745980;
	 x=1760832380; bh=AIjBuHNPgk24DGc8gvCr1qRtbUCxpuh/dZddrWuFaLA=; b=
	wrD5rIge4G4V/ly0++VysknEWpivYlkxO/13rTK2bheOP3eTrRaU6RynOdW5prIB
	ZydHpYY7O2szy+ZioqhITVbpkHzb9AyPuT6mRC1AlKJAqif6Jese+zkNHIYo7Gm2
	4J/OwhznaUNhTTO2Z1M3uIMEqEz1lfIvBVT0Acv7MtJoUtX17UeqyVuq+sC2u9Hj
	riQl5gYk8JvBxkL4Q/0GxgXmy642Igz1ki7m0egRTxRXJO+AJocUKFPvrkIJvQ4H
	4qrNuyCYPs+8/nMj7lO251guZavSBWowMvEEBL1mwuTE/TOkCn/g8R0EhldBA61A
	+Gxa/FnOY78PD1JwRq/j+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760745980; x=1760832380; bh=A
	IjBuHNPgk24DGc8gvCr1qRtbUCxpuh/dZddrWuFaLA=; b=Un0oWFJYcev6hGr/+
	+nr2D9F2L4RL486K4OtzQBasbmCt6HPdEcRqZO4pzjCk7BrT6PoJUulAvTxmhWOn
	BKV+uQ2f+X23Yt18Jry7hO7Z6ZcS1S2tH+TsHJK38Zsn+h4yCt/wkY6NkmQKc2Ch
	ppgUth1tG1JvqS+tMREnTu+i2CkyjrOLyjZkqgklCw3e88RCk2uOwRMuAdpVjeUd
	1nGYAxydLAiSRKrOvGPFGz/bn6sPi1oOpRAPYzcYKbqp7jU1sSMyzd1xXai0wS9J
	DMBtjzthRyJJTf2bqSJQeM4aA4Tf7Ak1TIXXe9CAObdAiqE4i9aHwCZ+UeLxBwKQ
	UgI7w==
X-ME-Sender: <xms:_NnyaD10NNvbdYnL7ssg24mASfSZ_APhveIDDS7lNIC-WY4AlNQxoQ>
    <xme:_NnyaFyNcXs4mqpDNhQPBY4rSMaNrVIwvcj4VfrFmk9jhEfghXhbyTqRCyhvYqWK-
    or5-Ma1iRYl-tvns58QlXyGjB7d5_E5eSwmveTtGjGrf6KytSM>
X-ME-Received: <xmr:_NnyaNsy7fWT4cjtRdSWwxVSYIVX7Sa65CL5aT3pLGr4Wskvt8XKFCB4-uuW2dS3LTyuDZJefW4IKyfp9bCNM0Am20mBak-QIzOuVTl17KYj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:_NnyaPzYgIGD6eHZL3r5hZZ4zeJz33mmdYe52_lF3diviZWejgYRvA>
    <xmx:_NnyaICalN168K026sWVqHYHdxAtmO1l-cmQhh09sPMZCDbC5b7M3w>
    <xmx:_NnyaFfnRNih913lXWDEkmg6P4jjyIebZWXbcV1FHIrtEri81qeGPQ>
    <xmx:_NnyaKkga8EPSB7koCI0kN0h5VW0FI5BbFJzyEV9WqkLXV2bQw7UmQ>
    <xmx:_NnyaJUTxEimOF0xXfrgV7NKFwWvqL2j8S1xVWEnLMiow2cFJ1taAbOs>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:06:18 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/7] nfsd: discard OP_CLEAR_STATEID
Date: Sat, 18 Oct 2025 11:02:24 +1100
Message-ID: <20251018000553.3256253-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251018000553.3256253-1-neilb@ownmail.net>
References: <20251018000553.3256253-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Having per-op flags which significantly simplify many ops clearly
has value, so ALLOWED_WITHOUT_FH makes sense as many ops don't need to
check for a valid filehandle.

However such flags reduce locality: you cannot look at op_foo() and see
everything that happens when the FOO operation is received, so they
should be used with caution.

OP_CLEAR_STATEID does not simplify many functions and the simplification
is minimal, so I believe its value is not worth the cost.  This patch
removes it and calls clear_current_stateid() where it is needed.

Note that the existing code only calls clear_current_stateid() when an
op returned success.  This is not required.  It certainly must be called
on success but calling it on failure is of no consequence as the whole
COMPOUND aborts in that case the the current_stateid won't be used
anyway.  So the new code pays no particular attention to status.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 20 +++++++++++---------
 fs/nfsd/xdr4.h     |  6 +-----
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5b41a5cf548b..944f10a08c77 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -685,6 +685,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 ret;
 
 	fh_put(&cstate->current_fh);
+	clear_current_stateid(cstate);
 	cstate->current_fh.fh_handle.fh_size = putfh->pf_fhlen;
 	memcpy(&cstate->current_fh.fh_handle.fh_raw, putfh->pf_fhval,
 	       putfh->pf_fhlen);
@@ -703,6 +704,7 @@ nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
 	fh_put(&cstate->current_fh);
+	clear_current_stateid(cstate);
 
 	return exp_pseudoroot(rqstp, &cstate->current_fh);
 }
@@ -864,6 +866,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
+	clear_current_stateid(cstate);
 out:
 	fh_put(&resfh);
 out_umask:
@@ -931,6 +934,7 @@ static __be32
 nfsd4_lookupp(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
 {
+	clear_current_stateid(cstate);
 	return nfsd4_do_lookupp(rqstp, &cstate->current_fh);
 }
 
@@ -938,6 +942,7 @@ static __be32
 nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
+	clear_current_stateid(cstate);
 	return nfsd_lookup(rqstp, &cstate->current_fh,
 			   u->lookup.lo_name, u->lookup.lo_len,
 			   &cstate->current_fh);
@@ -2929,9 +2934,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			goto out;
 		}
 		if (!op->status) {
-			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
-				clear_current_stateid(cstate);
-
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
@@ -3374,7 +3376,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_CREATE] = {
 		.op_func = nfsd4_create,
-		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME | OP_CLEAR_STATEID,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_CREATE",
 		.op_rsize_bop = nfsd4_create_rsize,
 	},
@@ -3423,13 +3425,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3459,21 +3461,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 368bad2c7efe..0ca30a92d40c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1027,12 +1027,8 @@ enum nfsd4_op_flags {
 	 * the v4.0 case).
 	 */
 	OP_CACHEME = 1 << 6,
-	/*
-	 * These are ops which clear current state id.
-	 */
-	OP_CLEAR_STATEID = 1 << 7,
 	/* Most ops return only an error on failure; some may do more: */
-	OP_NONTRIVIAL_ERROR_ENCODE = 1 << 8,
+	OP_NONTRIVIAL_ERROR_ENCODE = 1 << 7,
 };
 
 struct nfsd4_operation {
-- 
2.50.0.107.gf914562f5916.dirty


