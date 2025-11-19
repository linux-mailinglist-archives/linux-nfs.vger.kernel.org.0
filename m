Return-Path: <linux-nfs+bounces-16518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ADCC6C9DC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id BAD952C4F8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C82EBDCD;
	Wed, 19 Nov 2025 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iWMkWhJn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kw+NechN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6622E9EC7
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523188; cv=none; b=pOEJzOps3kXT+C+rlYX6Fz6jXCMqJGniVDzsGJNId3QZlhJ/5CZ7dwSgFPtSyICQuI1UJ6QycmIawkPwhPM/ti8D0PR3Csu9YqgtPiPIDlSB4ZL6omjKcdOzWLQDK6wlOkg6iJCJ9qY9WDQPjbIGvmECCy6fk2uY1zWzA2fuljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523188; c=relaxed/simple;
	bh=SxPRwlVhQ1m2o97wtOUFPVukMkwjueIwqA01AoH2T+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Whnm+iIwY3+UhwfVIoW/a7vc/O4lEHGMoTqQyndWvOfawkBQgBE57rfldFlsA4415NJ8H2pHkaQaSyHxBiwe+qJHIVQJmWJl9c2En9jDEFAlpDYIrPy36oqSpv9HW3CwbbSKWZV0SOe4NwEEcVAIImC1jlepG4NRpD5fm0+S+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iWMkWhJn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kw+NechN; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D7EA7A0141;
	Tue, 18 Nov 2025 22:33:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 22:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523185;
	 x=1763609585; bh=QFcrYXbu/sefP13QnwuZi9AqVUtohjtShGQZQFLT4hU=; b=
	iWMkWhJnH0TEmKY1iMfmDewvoLAHu9pjhZB0UC+mjeOc6evi3DPxgOKbQHTpDpSF
	C04+0X/jJIUO0zFVO3UMkLdZsqb/jKd9tKGrnqaLIvEXQF7NuYb2dVvmYL1DBlUU
	SodKtXS0tAvHNUneNM0z1uMCxe2wZm0/Y9B0OkgHRwyBfecySwoP4DpziIvq8vmg
	yI4jbKbiP5GkS9vgCkxHslblGy3kCoYawl+WlhIOcILsAvOr9VPael92CG4zLKUr
	iqume4tIlCg3ALHtTiGwNdKMU+V96u8UB5WPTkorZhN7crp/Cm+VTM/1m/JjaRxG
	fPB8SeWUvo51QU6TnKCzIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523185; x=1763609585; bh=Q
	FcrYXbu/sefP13QnwuZi9AqVUtohjtShGQZQFLT4hU=; b=Kw+NechNqAZ7o9IW5
	nPEhrNO7ii6OrQWID4xbMYnOnATHRKcoKOOCI4KuKbMtHozX8aTzNd/VD1PKeOjn
	946S8D5yRF2o8+bbaOYVCNJMiqdLbWoWMmBv+b1979dlXkedgF8fHS67pxaBdkxn
	m+wV9tx5M6B3saH8JRcmcNsTkaPsTaT8VHOBXUbVf42RKct6OLSjp/CA+Q5MK/Cp
	JfSz1Ahk486hqCBf6vvaKHHRaMxKmFv9j2gBge5vXmSo0/xF3jdae88yIGyobNZw
	55i0WhZIjDZsBqLFAFLc9ki3Wo8xUwBa3doJlFvU3ihz82LTlRGHfFdm6uhFf3md
	WrOag==
X-ME-Sender: <xms:cTodaUdrxoK5ohvzz70YfjZVLvcxVdRdI57leMZomi6C-uUf9dKQOg>
    <xme:cTodaZ64wmFFKCzYOAbZcRY4u6LL9-k007ByFKCfHsllZzPC2Xf7vrADZZ_Ew7Zca
    PzjPUKVIH-4I0kY3CxxckBWQJI85lJ90nHNk6tkikK-WLhLvg>
X-ME-Received: <xmr:cTodafXpMRB67KTnlAGIm1vsysqG3MsOB0U-7aJNwSihoegWMfFReZ-qKDxDPCegHKSH32xGp5X8PbJ6GWb-BQnFDF18gVg0BKx2feOHfL-M>
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
X-ME-Proxy: <xmx:cTodaQ4rPMUNUuTpVa5ev934UvZmB8xS1lOKbU4uOCwXc5iXNK-oNQ>
    <xmx:cTodaSq4qkTr1FZ0z1riiElpIRv4rdJE7oixTFE7U9xgeAJ7pgpF-g>
    <xmx:cTodablEDmDLdlk_bpQDiDysEd22iw9eb6eaUPJX68vJcUkYCXCmRQ>
    <xmx:cTodaWPvZY6kZQy3AXvVgz0kdcQbmM0L0CFne0bEyaVYw-bD5yEiiQ>
    <xmx:cTodaR97gyyhk3h0_rgseo1OpBvhj2qncZsw-RKu5ija2CAofgjJUH9H>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:33:03 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 11/11] nfsd: conditionally clear seqid when current_stateid is used.
Date: Wed, 19 Nov 2025 14:28:57 +1100
Message-ID: <20251119033204.360415-12-neilb@ownmail.net>
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

As described in RFC 8881 scions 8.2.3 on Special Stateids:

    The stateid passed to the operation in place of the special value
    has its "seqid" value set to zero, except when the current stateid
    is used by the operation CLOSE or OPEN_DOWNGRADE.

Linux NFSD does not currently follow this guidance.  The seqid (known as
si_generation) is left unchanged.

This patch introduces a new status flag SC_STATUS_KEEP_SEQID which is
only used for lookup requests and sets it for the two exceptions: CLOSE
and OPEN_DOWNGRADE.  When this flag is not present, the value copied
from the current stateid has the si_generation (aka seqid) cleared.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 24 +++++++++++++++---------
 fs/nfsd/state.h     |  6 ++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7508158f5f8c..f4b2ae7bc44d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7202,6 +7202,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		if (!cstate->current_fh.fh_have_stateid)
 			return nfserr_bad_stateid;
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
+		if (!(statusmask & SC_STATUS_KEEP_SEQID))
+			stateid->si_generation = 0;
 	}
 	/*
 	 *  only return revoked delegations if explicitly asked.
@@ -7523,6 +7525,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!cstate->current_fh.fh_have_stateid)
 			return nfserr_bad_stateid;
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
+		stateid->si_generation = 0;
 	}
 
 	spin_lock(&cl->cl_lock);
@@ -7645,15 +7648,17 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	return status;
 }
 
-static __be32 nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
-						 stateid_t *stateid, struct nfs4_ol_stateid **stpp, struct nfsd_net *nn)
+static __be32
+nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
+				   stateid_t *stateid, struct nfs4_ol_stateid **stpp,
+				   struct nfsd_net *nn, unsigned short statusmask)
 {
 	__be32 status;
 	struct nfs4_openowner *oo;
 	struct nfs4_ol_stateid *stp;
 
 	status = nfs4_preprocess_seqid_op(cstate, seqid, stateid,
-					  SC_TYPE_OPEN, 0, &stp, nn);
+					  SC_TYPE_OPEN, statusmask, &stp, nn);
 	if (status)
 		return status;
 	oo = openowner(stp->st_stateowner);
@@ -7751,7 +7756,8 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 			od->od_deleg_want);
 
 	status = nfs4_preprocess_confirmed_seqid_op(cstate, od->od_seqid,
-					&od->od_stateid, &stp, nn);
+						    &od->od_stateid, &stp, nn,
+						    SC_STATUS_KEEP_SEQID);
 	if (status)
 		goto out; 
 	status = nfserr_inval;
@@ -7821,7 +7827,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
 					  &close->cl_stateid,
-					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
+					  SC_TYPE_OPEN,
+					  SC_STATUS_CLOSED | SC_STATUS_KEEP_SEQID,
 					  &stp, nn);
 	nfsd4_bump_seqid(cstate, status);
 	if (status)
@@ -8313,10 +8320,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				sizeof(clientid_t));
 
 		/* validate and update open stateid and open seqid */
-		status = nfs4_preprocess_confirmed_seqid_op(cstate,
-				        lock->lk_new_open_seqid,
-		                        &lock->lk_new_open_stateid,
-					&open_stp, nn);
+		status = nfs4_preprocess_confirmed_seqid_op(
+			cstate,	lock->lk_new_open_seqid,
+			&lock->lk_new_open_stateid, &open_stp, nn, 0);
 		if (status)
 			goto out;
 		mutex_unlock(&open_stp->st_mutex);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index c6e97d6daa5f..6043baf10ceb 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -138,6 +138,12 @@ struct nfs4_stid {
 #define SC_STATUS_ADMIN_REVOKED	BIT(2)
 #define SC_STATUS_FREEABLE	BIT(3)
 #define SC_STATUS_FREED		BIT(4)
+/*
+ * Ops other than CLOSE and OPEN_DOWNGRADE which use the "current stateid"
+ * must clear the seqid (aka si_generation). Following flag is never stored
+ * in states but is passed through to request the seq not be cleared.
+ */
+#define SC_STATUS_KEEP_SEQID	BIT(5)
 	unsigned short		sc_status;
 
 	struct list_head	sc_cp_list;
-- 
2.50.0.107.gf914562f5916.dirty


