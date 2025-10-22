Return-Path: <linux-nfs+bounces-15554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D22BFE6FD
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8B7A4E9B77
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46672288C20;
	Wed, 22 Oct 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="P2JUyhIK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBHVkJUi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01126F443
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172679; cv=none; b=JrKVaHu63qd+cJCdT2+7f1bcVKtJgPVn3U2rFJ9GubAhdgA1gCubkk/XzBfhGi4pbNqYZE/ZAnFH5aZNt05QyAzHJRtWejZTmBVM4rRHHN+9cckwK3ldIY4kNdhNZ+hJS7vpZ5ObKeAbwiSxeL479WE2y4JqQF0XG+jma3AdX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172679; c=relaxed/simple;
	bh=FZU0FdTGEJ/lk4Rv7fHoRf6EYZghfXFYufMWTnhq/UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyewhY6aICkFVLDdOYS/jFJlm4lKfiWbtno26MiY80/0C0XVnKnuk39gEkvuk7FOpcMz6Rg8w5cdBCECDThp5lgtL3x6F4aSlGwl4OTaXTNnJhp+9gkikDZiT8ymZm+CfT34gKqUYKSuRW5umdOh9xXYb8/dnHpMxrdSc/mNpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=P2JUyhIK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBHVkJUi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6072114001B2;
	Wed, 22 Oct 2025 18:37:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 22 Oct 2025 18:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761172676;
	 x=1761259076; bh=2gzSyMWyVaN1OFXMe2B7R+wB8DVCxGj4CUwdPC1pInI=; b=
	P2JUyhIKeXRqqcbTj4z73AmvADGfjNg934fuNnXNjyjNJRGmar/DgdwSvwXxQoCE
	nC8aTnFUb3I5x6tKEP7y4P5HRHJz1+kX7vaWNny3aJfrTybxcwDvHW9XGPsn7yRi
	CgAmE+WXbc2tmHKxWxlsloh8QTcrewjETrRFHzLq86MxeZ7a5cc44CykRMMtfLrA
	CbALGTVAx76Rtb/f0Dree5ju3Wlo8xi2uSFg6AGr2S8LA6ybKKyGHM99d/oAcDtf
	9yLY26+Fjtqp2KxijECgkZPunbT3g8obYuFD2JimqgVPfOF7FdWHO0mjxezA6Ios
	9UrijwRKdgXk6agUIF97Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761172676; x=1761259076; bh=2
	gzSyMWyVaN1OFXMe2B7R+wB8DVCxGj4CUwdPC1pInI=; b=cBHVkJUi2y6ML98y/
	M6X3w4bzTTTmpMtqXChrsRnfhwKhkgf9E2IWX9Jwgbm6jDRFu/awrrxIBSqmcqGz
	2fEkZv3qQHaRcYrFcFPKF8NXfu+E6y3ee0Ctwqq/aD4w5kBfcJXkSrilnOu2etJO
	oNhFbM79IJlww2gsuhwzqQR+gZtxjdZZmT6bPmNVIlhbDoKaZ33oAHqBSbiw4uS4
	AREaZqYZdQ7VYXTGD7V+nyjxkw3ncPIAijIFEbMZrN4sYGUX0oP3Sv7dCM6fh2aY
	8lsSmF7SPiHzNrfM6o3NwUFG3ZHR+1Cm7FEvIncC34QeBtMluO7deVI8ixXHrAzu
	c1R2w==
X-ME-Sender: <xms:xFz5aOrlpVG2ido4Aj-h1lesLDFls8CDVyK3YRNlQsgo1Pmq8IfJWw>
    <xme:xFz5aAViXKdYe5PxCzsl2MV9yMfF_xIQCL0TGTpg7qLfni89IxXzu9J9xY5VaY_8F
    72zmWGnkZDBoAQWHCTr_BM9RRg38VCIswj5tvD4hqbTJIp3>
X-ME-Received: <xmr:xFz5aNCUxT0VvwGsx7u7qRU7YLK8nRxQ4xYsr0pd8fzKK6-h0yXDvShMEKzv42j_nlMEpWTEUMXUs2_cCmZOVIYMhoSYFws6yy4W2klvwtKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:xFz5aE2sgEQDL8IklW8O2u6lNLiSruTXajhno70LZJkpsZbtceYlMw>
    <xmx:xFz5aP1ZCMnImUFRdxumsyjUvIioVdD6JYtBTZ2W5qxsB1f0Viu7dg>
    <xmx:xFz5aJC90wNDH8iYEeouBClc-ECt5cZ_lsIosu-BvKkDZUe4tSzGPg>
    <xmx:xFz5aO6MP4yLWO3uBIg-KMNxywTPDYyj851Qar9QroU7-9bTn7ugTw>
    <xmx:xFz5aIJ_BvnqHHDBSt74fEhYlmVgoS_RGSGgCSwm14_ZObSJIAcv3hrg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:54 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/8] nfsd: discard OP_CLEAR_STATEID
Date: Thu, 23 Oct 2025 09:34:34 +1100
Message-ID: <20251022223713.1217694-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022223713.1217694-1-neilb@ownmail.net>
References: <20251022223713.1217694-1-neilb@ownmail.net>
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
index 19dba0664ec2..235fd27861b8 100644
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
@@ -863,6 +865,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
+	nfsd41_clear_current_stateid(cstate);
 out:
 	fh_put(&resfh);
 out_umask:
@@ -930,6 +933,7 @@ static __be32
 nfsd4_lookupp(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
 {
+	nfsd41_clear_current_stateid(cstate);
 	return nfsd4_do_lookupp(rqstp, &cstate->current_fh);
 }
 
@@ -937,6 +941,7 @@ static __be32
 nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
+	nfsd41_clear_current_stateid(cstate);
 	return nfsd_lookup(rqstp, &cstate->current_fh,
 			   u->lookup.lo_name, u->lookup.lo_len,
 			   &cstate->current_fh);
@@ -2958,9 +2963,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
-		if (op->opdesc->op_flags & OP_CLEAR_STATEID)
-			nfsd41_clear_current_stateid(cstate);
-
 		/* Only from SEQUENCE */
 		if (cstate->status == nfserr_replay_cache) {
 			dprintk("%s NFS4.1 replay from cache\n", __func__);
@@ -3410,7 +3412,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_CREATE] = {
 		.op_func = nfsd4_create,
-		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME | OP_CLEAR_STATEID,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
 		.op_name = "OP_CREATE",
 		.op_rsize_bop = nfsd4_create_rsize,
 	},
@@ -3461,13 +3463,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
@@ -3497,21 +3499,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
index 94af863fac0e..909318f8fdd3 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1046,10 +1046,6 @@ enum nfsd4_op_flags {
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


