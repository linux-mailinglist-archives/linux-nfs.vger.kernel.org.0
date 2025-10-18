Return-Path: <linux-nfs+bounces-15357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73B8BEC154
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B647C4088D2
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65BB1397;
	Sat, 18 Oct 2025 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="m0hCASSK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoM2P7Mi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DB4C6C
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745998; cv=none; b=oZzgBQEPgQB9n1gpDFGAZVAOP0VA7fPygb5Apy70F0iQkcTV7mCVTP1Z9zzuq6tQBNqb7ONQIdBHtcGgqNkeNZAPJAkGT0fd/DAWyXvgPI7j2KgaUHz0RsMpvzyG0t+00pW7om0e6nQ7p6UyQrriZ8zXGHr7e72Sex4iiMqbJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745998; c=relaxed/simple;
	bh=Bbu78wgdaTg95lMc7q0lNmUhBgeYrHwYyjkEs5tcH/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4x57xG6V1wRDihdWPK/CXtcX5tOyhCW9u4MR0gBnbVqvuPS5e7duEOtyTnx+nrNriFslQwoVtoj3bhaDLA46BQtsOWfeaqkzgwTRir12iYVPKFPOpXz76tTGC3rvyTE5kt2TetJ4cc97ibhbzvWDs33ZNHIUmYNKneo21uazfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=m0hCASSK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoM2P7Mi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 433AD7A0100;
	Fri, 17 Oct 2025 20:06:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 17 Oct 2025 20:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760745996;
	 x=1760832396; bh=WyFtUQ3qnH9ZtlO9knpRjcAhnEJci19pSJfhCEVcq7E=; b=
	m0hCASSKQK1DbUulUf4VZLlvAtS+r71y5lMXZ49P7Ne6eG7/Gjwg7yFofZi37UPf
	VK+Eadh2dzeTh49CbEnToGd+4y736sMKlYVgLe5y5GSFZLToGXLqV9rhRIFEErd/
	UPKz+CcSIn6qTmXtU2vZ05aiKju0BJgO/Wf+El4NwwrRFiLuBykc3kiGUugXoz9u
	hT6G5RniHbifbF3dyB7ohWu1Qt3EVuef3obAdwg627ZX5QCWn33Q8oQyC0gRT6zq
	IDrscGBnJUP8YGDJGldkS/trZlYgseDMDxH6ErPhUDB4dM2DP2xyT6nFJ1sod4dh
	ea5oHacqxHCUnqxdhqhBzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760745996; x=1760832396; bh=W
	yFtUQ3qnH9ZtlO9knpRjcAhnEJci19pSJfhCEVcq7E=; b=HoM2P7MiCaKzt8PiB
	JmLmfhgV7LiGR0chAbKXIMAPQaUEQShfVHF5MsxXnhWsQ8Y7owlJdiRDATRr9Am7
	1cSnGBu5uknfxoDhUsdaGxLz8PsvJYMSxGyyz9txiRNJPWLoOdBr4PalYUwTVD79
	h4re5UF2/283RAOWO9dYJvReEfn4mr2jGQWaCuIYxGah60vQuvtqJ7+Jl2TvF2fo
	Ry5A9SmJlKOSjrD6DAeeFX0D+7VKhGq6L8tWlFGPW9+lxiM91xLYBCcp0QbkyUJD
	2F+7a1pab06Aox2AEe4KL030fjgEG+sILLAmlwwic46QObTtm8UbbL6IOqOREaqN
	S3RvQ==
X-ME-Sender: <xms:C9ryaOvIGaO_-APV4GIKYnCz_bQyITNS6KPFC4pohSdQ31dH1aWlwg>
    <xme:C9ryaHLvkpZ9lIszHGKPYHafDICqWGMDy_cX-28IfnqB5sNYvdoBf8lq3pPh06a1G
    AMULVcFi8szbrIRzBSXQd8kRFE4LnUhp-NqBlprF9we2KuLvg>
X-ME-Received: <xmr:C9ryaDm6iwHWJsAtPm3eoK4bSAKwZadCWlYxnJ8hv6KLwHtxoZ2bI5iu0rcqXef0aSiedddOpwvsXIldZeqy6du2oFDnTr2SejLERFN2aXju>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DNryaALwRjDHz2Rd86cun3ge8VWW98H72Fd0jMPHY_gKOr6dzSpZZA>
    <xmx:DNryaA7MI67KeMylVvZpmfFj6BUSYFSAl2PIxoRvBoA2OmXzkBWvAg>
    <xmx:DNryaM2Uqh4HMVGacGwNpZThxJGh1sPpGACbOdQST_uBEDNwsPRtSg>
    <xmx:DNryaOf_VVFt3VpBJfvuwc1xjyi-rHkXjqAQJ2idkUrgPV5qauqe4Q>
    <xmx:DNryaMPNcgf38i8hGyVkQbdcGazaM9q9JEQAqcmGWMrX67Zr-KXzaR9Q>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:06:33 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] nfsd: use a bool instead of NFSD4_FH_FOREIGN
Date: Sat, 18 Oct 2025 11:02:27 +1100
Message-ID: <20251018000553.3256253-8-neilb@ownmail.net>
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

fh_flags only contains a single flag.  The svc_fh structure containing
it has a bunch of other bools.  So change this one flag to a bool.

Doing that clarifies the code and makes the struct slightly smaller.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 5 ++---
 fs/nfsd/nfsfh.h    | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bb432b5b63ac..6e0f774f1f86 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -691,7 +691,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	if (ret == nfserr_stale && putfh->no_verify) {
-		SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
+		cstate->current_fh.fh_foreign = true;
 		ret = 0;
 	}
 #endif
@@ -2889,8 +2889,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 				op->status = nfsd4_open_omfg(rqstp, cstate, op);
 			goto encode_op;
 		}
-		if (!current_fh->fh_dentry &&
-				!HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
+		if (!current_fh->fh_dentry && !current_fh->fh_foreign) {
 			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
 				op->status = nfserr_nofilehandle;
 				goto encode_op;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..85019ae58ed3 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -93,7 +93,7 @@ typedef struct svc_fh {
 						 */
 	bool			fh_use_wgather;	/* NFSv2 wgather option */
 	bool			fh_64bit_cookies;/* readdir cookie size */
-	int			fh_flags;	/* FH flags */
+	bool			fh_foreign;
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
@@ -111,9 +111,6 @@ typedef struct svc_fh {
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
 } svc_fh;
-#define NFSD4_FH_FOREIGN (1<<0)
-#define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
-#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
 
 enum nfsd_fsid {
 	FSID_DEV = 0,
-- 
2.50.0.107.gf914562f5916.dirty


