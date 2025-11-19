Return-Path: <linux-nfs+bounces-16511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF1C6C9BE
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 897302AE3E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924912E9EC7;
	Wed, 19 Nov 2025 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AaGJwcxl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMwnT+I3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D02ECE9C
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523156; cv=none; b=AaanSLNfkvprCR24Lrf8jJunZ3qQZ9LaBpBb8KmjmmoODTVlxSj/EzAbZzxOFc5IU6Y+QBF5r4LibCU5jD44Y54S0U42zZDqKS92RWAeVYD5WVzHLBx8ifglQAT/9/zU3wpZ/o41oV92BZHb+dQ53bForLsvF/xxCCg8vOzu3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523156; c=relaxed/simple;
	bh=+ABL252nNLraVR9H+ijCqifJgt6Bg9Xx7X8k6DyWDyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW8LcOBvBNjdCaHxco/RQqVqtlSDuGe3yvPHfPmikENS43SgW/CWQ25KfqbT+MOBowVqZxpRaxUTRhlO4nciDECfKVPwJPG3GtAb0nZZimP74qFq5+9tBiCE4B+DdAFNYtiHGlR6h0HIVGMb5Jyq8+DHfbaIq+1lC4NzeFdy+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AaGJwcxl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMwnT+I3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id AE8E31D000B5;
	Tue, 18 Nov 2025 22:32:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 18 Nov 2025 22:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523153;
	 x=1763609553; bh=YOes9NlCRNixty/F1Kac43m2qOW1/Uv3tc1Bi3Bgv9c=; b=
	AaGJwcxlqxTb1rw/5CyKf81KBtrhJthRV06GWFhJu6+YbcHQRKfaUd3U5jb3WsJF
	CdaFxScDI44ixyAeZvtWgHs5ix7v9HIgBJklK57bydr2tzGguxy/LOXvcbEYpAvp
	HWX3M0zF2ZSe5LFhIVZDHfvOfQ+J/x+KQzRRB0VEXrHZzZ+3jQr0om2E17eNf2Bk
	CAHN4ub0aktB/hLuSxO7wn79CbQPHG90oWhxTmZj8w2wJvN0R6i8iCdvXf2y996B
	uRGW/rui5DjmBuh44TFlOtv4Hw42UpjXm1Uns+SpUMx3MXR0LwC3nz+jv3JaKFUO
	TjCkeV1LBIHAXUQL2650qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523153; x=1763609553; bh=Y
	Oes9NlCRNixty/F1Kac43m2qOW1/Uv3tc1Bi3Bgv9c=; b=qMwnT+I3X/f2Z4h2I
	E9FFWS0QMpj7UEPFyDW3AWtaFpjmxziS0XAQvg5jFNfKGN25CInyk8FA16Mj3vgP
	jMIHM995GcIRNYnVlPryyTY4NqMAa8RGxzcxWN9+gj48ZBnjmgfGqUwf4CKNvdnb
	V3CDD5angU21YNl3JLx4zw7imaa2qnn2cfYS6aGXM7vHLFEh86T0JitwADsMy9oz
	cM0t/ZyGv2Jk9IW56LP23EtDQbfhNcl+iFj7xZnvUn1jdaz47YZ+oZeJNLUffzeE
	4zYZWtl3L+5roC4Rl4LkK9yutNirOIElDzV9GdVNrTjcLBzyIdvA8PXi2cl3cqz0
	NCo+g==
X-ME-Sender: <xms:UTodaT_CZCM85uqNrZD0RAI1i20if1TGLijBOo_vcLabq61TAksbaw>
    <xme:UTodaTaQ8ENQrJAwgN3S5u7mvN9nGGiqhh0xsuTSqyvYf6ai3dbu1N606BXR5-Y7V
    N9gnDhJ63AvD9mT9YN6PDh-hw7RCH2aQ0iJhmyyn5k7AjUQeHA>
X-ME-Received: <xmr:UTodaa1FiR0jm17qNkQiDZNp7ji4dlr6fkHSFPw4Q0bkTy4AOmn4Wdsn2rgjRohHHBAhCFkIM4P3EB8SYAK2S_ajlXyXPynGpVEG4srIFNOH>
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
X-ME-Proxy: <xmx:UTodaWaIdQ1s_jhyisjRkIlgV-IaVpBBOLhShXUtYu4bnRDZc6kBMw>
    <xmx:UTodaaKGFOzYYEnYvE9O8-6_gUaS7nGLHH_OlJAZe6L3lBoQDxE80Q>
    <xmx:UTodadH9Oh7BGvvbgqQn8s-xr1Q5_dmJK8F2_freaFvrtwgChXybzw>
    <xmx:UTodaZtO3CcV5ocKZesUCYW1ZV988d08D-WW7eH_L2KIx8GVpSz8bw>
    <xmx:UTodaRc4378O4UKnPFRMxtGkrqiitZ6KVxAg_uxCrYi5ljv9Ar6hwb04>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:31 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 04/11] nfsd: report correct error for attempt to use foreign filehandle
Date: Wed, 19 Nov 2025 14:28:50 +1100
Message-ID: <20251119033204.360415-5-neilb@ownmail.net>
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

A COMPOUND with
   PUTFH foreign filehandle
   SAVFH
   RESTOREFH
   some-op-that-uses-current_fh
   COPY

will report NFS4ERR_NOHANDLE for that 4th op as ALLOWED_WITHOUT_LOCAL_FH
is set and ->fh_dentry is NULL.  However that error is not correct.
NFS4ERR_STALE or NFS4ERR_BADHANDLE would be the correct error.

This patch saves the correct error and reports it when appropriate.

It is highly unlikely that a client would ever notice this difference as
the COMPOUND that would produce it is bizarre.  Maybe we don't need this
patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 4 +++-
 fs/nfsd/xdr4.h     | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e6f8b5b907a9..e61b1ee6c8d8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -712,6 +712,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			 * in the COMPOUND, and extend it to
 			 * NFS4ERR_BADHANDLE.
 			 */
+			cstate->saved_status = ret;
 			ret = 0;
 		}
 	}
@@ -2856,6 +2857,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	resp->tag = args->tag;
 	resp->rqstp = rqstp;
 	cstate->minorversion = args->minorversion;
+	cstate->saved_status = nfserr_nofilehandle;
 	fh_init(current_fh, NFS4_FHSIZE);
 	fh_init(save_fh, NFS4_FHSIZE);
 	/*
@@ -2907,7 +2909,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		}
 		if (!current_fh->fh_dentry) {
 			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_LOCAL_FH)) {
-				op->status = nfserr_nofilehandle;
+				op->status = cstate->saved_status;
 				goto encode_op;
 			}
 		} else if (current_fh->fh_export->ex_fslocs.migrated &&
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 3de8f4e07c49..bcaf631ec12d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -187,10 +187,11 @@ struct nfsd4_compound_state {
 	struct nfsd4_session	*session;
 	struct nfsd4_slot	*slot;
 	int			data_offset;
-	bool                    spo_must_allowed;
+	bool			spo_must_allowed;
 	size_t			iovlen;
 	u32			minorversion;
 	__be32			status;
+	__be32			saved_status;
 	stateid_t	current_stateid;
 	stateid_t	save_stateid;
 	/* to indicate current and saved state id presents */
-- 
2.50.0.107.gf914562f5916.dirty


