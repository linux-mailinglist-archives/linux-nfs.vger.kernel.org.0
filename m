Return-Path: <linux-nfs+bounces-15636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BFDC0B5C8
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0B4189AD4D
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8328468D;
	Sun, 26 Oct 2025 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="J3VJDvVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3R8LzcO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2FA1F30C3
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517660; cv=none; b=lhIOX6E7xKBJN/a8ln0BD7dfM+1uDMX3segPbnXhRupyEOPVzPXKIUrV8bJz/3Kdju1cJOsa/FrMrlpPKGRWnpB6sOEUhQ1gp/1V2ftYPpqb6RIGNios6lt22ZdiRm9JfzxR4GC8Prg7EOhx5nqkJvvkVtAXLadq/1SywO6aghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517660; c=relaxed/simple;
	bh=v0HOi49CHfqRzge3WYEO6L3bx2aE/ltrPDmwRwRdIcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4Pp7PG7s0fkdF8tAfyyd707651H1NxaferrWldaoM5iNrmE9Msn8nb3hNW3A7/TcxgFb+RmZSg0R4iEmRWwMRWMoecAfeJD5fkI1RMILIPCGE/LL2JAER0H0pXIzYJVhqMov50gQ5tkJzReOQ1Pu5HvZ8VAdGyVYbK+R1av800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=J3VJDvVu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3R8LzcO; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A2F67A028A;
	Sun, 26 Oct 2025 18:27:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Oct 2025 18:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517658;
	 x=1761604058; bh=JopodXV0qp/YHCjCl5bdjbN7/p5M/RG6Uw1PP49/2k4=; b=
	J3VJDvVut3n7cyOXf6tmfS10QUsS3DWK8pVQarLWh4/vhj0y1M1mk4Atvod/MNfl
	HTygSipfLaEIuFjyq3ylGG2wn1DETsokEM6exAwwj7waXdLytbgYKe72GO4fT7I8
	PWVBac+C/dhd7W5PGiV7wdbEoW4kt3kgbToV5cT+2qrlOvbrhKZ/yAURITOIjW0r
	PP44v8rTwQXzEH4aNTEvGUq8o9qaLXRI6uEyf1XYPkgjztVeSlUTH89RwcQosBwe
	FJudtTTcQnQaSguGzi8pZfYkYnH0LjhHuDIZYQFTDhm9luXRGNjsHXlapembuMki
	kJlOaLjBLbZpKwJ1A3Ji5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517658; x=1761604058; bh=J
	opodXV0qp/YHCjCl5bdjbN7/p5M/RG6Uw1PP49/2k4=; b=A3R8LzcOMC8Gyx1WS
	81eWcWuzcOfRlqpRrNehmpohpk3JyNr0ljcFCxNK5l5dNGMDfhN/B/uoTo/NI0Wx
	x9lg4P+QdwnYXjjimTTXAOK9T9vrJogn3NMBGb7xQpIesadRa4NKhHFKdmCO2Bz2
	dM/alF3uwUperdS3c7xfJccyqTrWg6fWCEkiyQ8Qi1eZN+CFpLu8T1jKDycvxhOF
	NW5QsdQDCmvb16O8+1CKKVRpHzmCcmB7/HtQ+IQc11vUyjVR9JpSTQcO9/sa4rYZ
	I672TCJXJNVUhLWHC8lE5EzqFw3eDlf8fJ4kR+OjHCTGgRZstZpwt8X/7GGQr1h2
	kuSqQ==
X-ME-Sender: <xms:WaD-aKCVCeXa6JByCoxOk-FAbZb3Pg3dh20Rg0mU43F0dpFljP0Jyw>
    <xme:WaD-aIO2c8hurLB5E81d_K6QxphS0-W3MAPMdhSGu257oHLWlkWMNgy3Fy7yPfDI6
    zKVMKolqexxEvLDLlVZ7jZOZe4gnryGJPx6bTHYiPLrnFPNJw>
X-ME-Received: <xmr:WaD-aHbCxXJKN0YAPPXni9_-VHdnTrqfFRsmvxU-XnlQ-mJrVemACqBpILMDeoTCpJNKzCfgczMcnOd3BU7CKVqO8B4KlyuXNWgTu40sowN_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WaD-aPs_nwd_x2BadgVcl4iq8001scxLXEJO-aWaNuEhA8R3BWHbHA>
    <xmx:WaD-aBOPI16c9_Le2j1Ctr50QjhKhEmS20wyjwma72MfDWFW7CtIMQ>
    <xmx:WaD-aO4bY_YQ1iQ9Eqk8BohwQhd3ri4YG51gyZEhZGeQEJsQkmrkGA>
    <xmx:WaD-aPQuuyQ8qqQeFat3h02YAgyWB0dIKA8RJrqc9VRgysOfr1xt5w>
    <xmx:WqD-aLiuiB6H92jWIuPTh9EMELheD5mewbzTlXZWu0Q9TtEzD1-BLBv0>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:35 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 05/10] nfsd: discard CSTATE flags.
Date: Mon, 27 Oct 2025 09:23:50 +1100
Message-ID: <20251026222655.3617028-6-neilb@ownmail.net>
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

The CSTATE flags no longer serve any purpose.  RFC 8881 requires that
there always be a current stateid when there is a current filehandle,
though the stateid might be anonymous and we now implement that.

This patch removes the flags for separately recording if the stateid is
valid, and assumes that it always is.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c  | 10 ++--------
 fs/nfsd/nfs4state.c |  5 +----
 fs/nfsd/xdr4.h      |  8 --------
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a2b78577ddb2..1f1d21dfd0cc 100644
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
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 83f05dec2bf0..af6bd0248b8a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9096,9 +9096,7 @@ nfs4_state_shutdown(void)
 void
 nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (nfsd4_has_session(cstate) &&
-	    HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
-	    IS_CURRENT_STATEID(stateid))
+	if (nfsd4_has_session(cstate) && IS_CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
@@ -9117,7 +9115,6 @@ void
 nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
 {
 	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 }
 
 /**
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index e2a5fb926848..3aebc62e4b09 100644
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
@@ -194,7 +187,6 @@ struct nfsd4_compound_state {
 	stateid_t	current_stateid;
 	stateid_t	save_stateid;
 	/* to indicate current and saved state id presents */
-	u32		sid_flags;
 };
 
 static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
-- 
2.50.0.107.gf914562f5916.dirty


