Return-Path: <linux-nfs+bounces-15641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF87C0B5DD
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4583F34A6F7
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5902BEFE5;
	Sun, 26 Oct 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="m4FBC1Te";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8Nehzg3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36191F30C3
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517684; cv=none; b=qNIk0vd2iyz1v57ip4ufBoyUXb0lpZfCJ702oW/qvEyy33+a1UN8b77PG2yC99umSkYzHnOn5Uyh5NWL0UHBqith0/WAb2Cav4RtHjfDLEGhUhyL2EqkKx4t3p/04xFaLLunso8KjvrxarzjKPlQiEplgoFHWQ2llXcht+vGQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517684; c=relaxed/simple;
	bh=C8u18PJisdrlnumf0JBc1D0yVgK2zoevDpnhTaoHV1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/wZgmzwUm5VMdEEe2x3SAO0RKT8kn2nEj8Viefv6OKEs6vMcfy4j6Ubu9Pwgn3/g+s7PepMlfmPffws1v+jN4Qe/cfkRJQ1+GS6T1oP/alAKFhATRNiSM3Yix8roUBYwMfJeoV1kk2IQYsk1IIUJz3ZXCCxHk7rJjQmB+j0EXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=m4FBC1Te; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8Nehzg3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DCE327A0289;
	Sun, 26 Oct 2025 18:28:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 26 Oct 2025 18:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517681;
	 x=1761604081; bh=5PLuzhFArpw9fUqEmDWkka/sgzY+ZgxjHvHVaGW/fUo=; b=
	m4FBC1TebzNqa7nPtAeH33fi1TjEjfEReodCLNIQm0sqy/YXRHK58/G1Ix0TKu0R
	3Y2L1B5cHwUo+NQ6bB7+HWVnkl52u4/soMpPBZBFHWySwKLMCKzeefynol5eLZPa
	o2tvdwfyTAoswMEboZ9Fi9N1o9SqzpJGeHOwtmzE2j/47mxrR1yCO3qC4x9AVZXq
	P+rcX8/cgostMkCPz/cv0Uqb9Z+r+/fGF0ajQwJRIN+55k7fJkJjhTqSNlGp8bgz
	hbCn7pBIj/nzPql36a1FzKkdRaqytEIDWifyUbtLkanjcQfRIX41hop4napnmDjb
	/3Ui/IhCI2/gUQti0hQLqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517681; x=1761604081; bh=5
	PLuzhFArpw9fUqEmDWkka/sgzY+ZgxjHvHVaGW/fUo=; b=X8Nehzg3yHXFr4dcy
	2L8COPsKCwt+1lLdH7tVDM0Rj0Sol8nSUuxhup/uLTGWWo+sFOOnYHRO4AB6s6+/
	stIZz14+4ZLiGVwvCKWAqd3ib9Bz50CiUxbggah6YjqtMOzhjQAoEN5MrO2PQ2Lx
	SX9gD1YVKsAa/i3IfHFoMxp5+WIkxgBrUvMbglcK6/v0kaVC/XDg21G28PbaXIZB
	04+zpHRGkw4d6n3N+t7cx3XIorvZbNMslgOHHUjVgwYYri6gZ65HDl6OzEFggwMQ
	U/sH5wl8shvvkdZ6OF80oQ1fBpITRGW/LKtdxeAnM9kAcNiQh+guzH/DfB9uR2aq
	wjkqw==
X-ME-Sender: <xms:caD-aAS8f9etbpyKArtscPI5ywb3bc3YezBt2-wH5W2BU4bsZ_h6sA>
    <xme:caD-aBfnb0fVTbvoHSwEz30KNblLyyF0J1xmzZBMmkDvwxxEuwedDK333YD9TVPip
    RNVsdn-HAkWtJZg-55SZ6__1XjgS_MD8i9OeA4eQfv59m5DuA>
X-ME-Received: <xmr:caD-aHppOzgfZMkrkoE8toXYlrY8GMppEg1HQ8P2YaFuhf_lawjBggfMsyQm4TNDrEuJPSHT-udMcA-k4zysgMxKPxQ1PTBRRUtZiRxAvLzF>
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
X-ME-Proxy: <xmx:caD-aK_0dD62aSmaIBMaOzczMO4J2s1z7DqDQnBeK8z_NNcoCg-whA>
    <xmx:caD-aLc3a2WCfTmlzUJlGIdiIZREBwR5GOyHz0dKWPNyfXL-5Zz-kA>
    <xmx:caD-aMJBmSComh2coWu3MfkbdhBaP_yVMYzFfLxXZw429nYHCC155w>
    <xmx:caD-aDjCNXsEE9CWUDPhYROEZAUUmVKCd_fvka3nn4TkSYKLa0rGsw>
    <xmx:caD-aBw65QZX2kIC41gOT4RJeS6guSUIYY7cAx2uvlUNBi7ZnaSjm_un>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:59 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 10/10] nfsd: discard OP_CLEAR_STATEID
Date: Mon, 27 Oct 2025 09:23:55 +1100
Message-ID: <20251026222655.3617028-11-neilb@ownmail.net>
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

Having per-op flags which significantly simplify many ops clearly
has value, so ALLOWED_WITHOUT_FH makes sense as many ops don't need to
check for a valid filehandle.

However such flags reduce locality: you cannot look at op_foo() and see
everything that happens when the FOO operation is received, so they
should be used with caution.

OP_CLEAR_STATEID does not simplify many functions and the simplification
is minimal, so I believe its value is not worth the cost.  This patch
removes it and calls clear_current_stateid() where it is needed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 20 +++++++++++---------
 fs/nfsd/xdr4.h     |  4 ----
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3ebc4357cd67..a6e7898c4157 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -684,6 +684,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 ret;
 
 	fh_put(&cstate->current_fh);
+	nfsd41_clear_current_stateid(cstate);
 	cstate->current_fh.fh_handle.fh_size = putfh->pf_fhlen;
 	memcpy(&cstate->current_fh.fh_handle.fh_raw, putfh->pf_fhval,
 	       putfh->pf_fhlen);
@@ -702,6 +703,7 @@ nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
 	fh_put(&cstate->current_fh);
+	nfsd41_clear_current_stateid(cstate);
 
 	return exp_pseudoroot(rqstp, &cstate->current_fh);
 }
@@ -857,6 +859,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
+	nfsd41_clear_current_stateid(cstate);
 out:
 	fh_put(&resfh);
 out_umask:
@@ -924,6 +927,7 @@ static __be32
 nfsd4_lookupp(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
 {
+	nfsd41_clear_current_stateid(cstate);
 	return nfsd4_do_lookupp(rqstp, &cstate->current_fh);
 }
 
@@ -931,6 +935,7 @@ static __be32
 nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
+	nfsd41_clear_current_stateid(cstate);
 	return nfsd_lookup(rqstp, &cstate->current_fh,
 			   u->lookup.lo_name, u->lookup.lo_len,
 			   &cstate->current_fh);
@@ -2952,9 +2957,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
-		if (op->opdesc->op_flags & OP_CLEAR_STATEID)
-			nfsd41_clear_current_stateid(cstate);
-
 		/* Only from SEQUENCE */
 		if (cstate->status == nfserr_replay_cache) {
 			dprintk("%s NFS4.1 replay from cache\n", __func__);
@@ -3404,7 +3406,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_CREATE] = {
 		.op_func = nfsd4_create,
-		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME | OP_CLEAR_STATEID,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_CREATE",
 		.op_rsize_bop = nfsd4_create_rsize,
 	},
@@ -3455,13 +3457,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3491,21 +3493,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
index e4357d79271f..1599fa66b5e9 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1027,10 +1027,6 @@ enum nfsd4_op_flags {
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


