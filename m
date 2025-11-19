Return-Path: <linux-nfs+bounces-16512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC03C6C9C1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 3F17D2929B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDADE2D8396;
	Wed, 19 Nov 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VlIJibZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hC/xpWGP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378492EBB99
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523160; cv=none; b=hYNZ8RJ0ZswMyPIaN1afdvB2/pl0qArXDkxizlIi+jM8RFfKs74iXytm8oVHZUFrFYGaz/jTLKt6HBpu4IuqEhkB7w0xpMbybEDc/l4hNPUkRy0qmO57fxy/ZeMpLV7gGkYysgI+A47xgaa9+6hmFy9+HQ/nZW90oZnEyt+ZNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523160; c=relaxed/simple;
	bh=w9AtjVhuZFPfLPpHe+CM2NFnKTfCdbArcG1JuuOiX2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHc7sgZNAMRIkCMSGhgsATKZmi/p4fqK8hUBj862bWRmL+hEjvxdPSOkgqGNqbISzRXvWvnRmkn1Env4O90DW+U1KZuR1IlOVLLGMPO6YuJFZUIdlXmuUzRRA9WHTqL5Gh/o7aK5VvzMvx9mUGrrTXy5NHL1Oe7ikq7JmQDmt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VlIJibZ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hC/xpWGP; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E9431D00151;
	Tue, 18 Nov 2025 22:32:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 18 Nov 2025 22:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523158;
	 x=1763609558; bh=Wifn3mYZVykhmmXTTQXGAht9FRswrUinEgUFEOPsp0g=; b=
	VlIJibZ20NfRKk/511MPk421D49Mz5vnqrbXUn2fRaemOoasVQvBrpYaNPPN/274
	Q2vQAHwNLqYRpqqIqiezjWxwqOQ1/bqHXVNAhS8F+T7I16vSQ2/RbZrfiQ9G7Dwk
	cYVSYxJgN62kBpHtHDTC1H0pxePRh0FYJDcHjzJ9vvdqcJmNByagjzN9DONaNg+d
	V/1Raz4KASbo60iW+7UrNG7rH1S/PYr8ZPSIXepgAo9wIy2rreB3bU1awYnQFHJS
	UZfpIGfIYgnvV2ranfcr/lA9gSdXGvtusTxVR6kM2DSRDpUiuCNi4NlVZl/90Ffe
	AtkFXOaod4htIrL13up3tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523158; x=1763609558; bh=W
	ifn3mYZVykhmmXTTQXGAht9FRswrUinEgUFEOPsp0g=; b=hC/xpWGP+bo7lL4z4
	ymy4tbEPgKdkBWf5nQfyxq7EFxmoxktERRySrQS/XMeAdEDjfxqPqyu9E6WOdM3U
	I9M6dnpDI2v+SIG+pY4pn26sJkEEhQHMehEXNz/DJKlDAYkV3mfRl2Emus3Ka4zL
	qe63VlV4tvo60Uj3xS3pvEiDpThneC1h6D+e/4Op+ZbqzHc+EZWeFVXVpa4b69x+
	zNpF31GKndWujUsQSyNRw0iUktxgY1M6aRp/48UTjFQ0Q6yYCBlmpGLAKBAA4q0W
	LyOj4pU2jUzwIzVHybr54u4CnUgI0tnx9C3QSyhyGsncM/r8uRIcem/9shTdQu1/
	itC/A==
X-ME-Sender: <xms:VjodaSx7br58csYw2kNEjbPuM__m9rFfu7YBT6LwRblqwPPFuKrPFw>
    <xme:VjodaR87tQNswoB9BkSHx2gbXzqn7iP-KP1jf8zy3762UiNDZ_wpHTbtuPUmxFNcW
    au8O5ot6ptz02Qzf7CIHQP-S7vDxf_a4wPfN256Bc7ekfeWJg>
X-ME-Received: <xmr:VjodaeJgnxLwXfWB6nu9aZvN56N-1NSMx050Fp0i-LOybtTf99Xm3Ld7rxnhZEx_yue0E1Hp9shnzovn5COLpJHfIf6Vku9S8UFIV2x4y7Is>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epheegleegleefhfdvffdvheehfeejudeugfefleeigefffffhgeevgefhteeikefgnecu
    ffhomhgrihhnpehophgrqhhuvgdrshhonecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgv
    hidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    uggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Vjodafe7LE8OMR0N0EyCbIrzblvSsCbZOJ3aiKBif9T1PAl6GCCF8Q>
    <xmx:VjodaV_BFcdiQH606RwIZPBM8Un-9pcmMsCgm3XPVliQs_1u48Gy8A>
    <xmx:VjodaUrOwoSfyfJMj8rDB4P0ySta9RO0Rzl8gkxa9LUYtJhxanFqDg>
    <xmx:VjodaSDIiPLteBJtVnkXPUWdBFMFmJChRmgriKFOuDhhuIi36nre4g>
    <xmx:VjodaUR749s0V4WB4D9cDuHgmtyqio2vO-wWCfbhqIA2Y0GUZaUD6WUo>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:36 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 05/11] nfsd: drop explicit tests for special stateids which would be invalid.
Date: Wed, 19 Nov 2025 14:28:51 +1100
Message-ID: <20251119033204.360415-6-neilb@ownmail.net>
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

In two places nfsd has code to test for special stateids and to report
nfserr_bad_stateid if they are found.
One is for handling TEST_STATEID ops which always forbid these stateids,
and one is for all other places that a stateid is used, and the code is
*after* any checks for special stateids which might be permitted.

These tests add no value.  In each case there is a subsequent lookup for
the stateid which will return the same error code if the stateid is not
found, and special stateids never will be found.

Special stateids have a si.opaque.so_id which is either 0 or UINT_MAX.
Stateids stored in the idr only have so_id ranging from 1 or INT_MAX.
So there is no possibility of a special stateid being found.

Having the explicit test optimises the unexpected case where a special
stateid is incorrectly given, and adds unnecessary comparisons to the
common case of a non-special stateid being given.

In nfsd4_lookup_stateid(), simply removing the test would mean that
a special stateid could result in the incorrect nfserr_stale_stateid
error, as the validity of so_clid is checked before so_id.  So we
add extra checks to only return nfserr_stale_stateid if the stateid
looks like it might have been locally generated - so_id not
all zeroes or all ones.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..ea931e606f40 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -74,6 +74,23 @@ static const stateid_t close_stateid = {
 	.si_generation = 0xffffffffU,
 };
 
+/*
+ * In NFSv4.0 there is a case were we should return NFS4ERR_STALE_STATEID
+ * if the stateid looks like one we might have created previously, and
+ * NFS4ERR_BAD_STATEID if it looks like it was never valid.
+ * There is not a lot of redundancy in the stateid that can be used to make
+ * this distinction, but it would be useful to differentiate special
+ * stateids from locally generated stateid.
+ * Special stateids have si.opaque.so_id being either all zeros or all 1s,
+ * so 0 or (u32)-1. Locally generated stateids have si.opaque.so_id as
+ * a number from 1 to INT_MAX (as generated by idr_alloc_cyclic()).
+ * We can test for the later range with some simple arithmetic.
+ */
+static inline bool stateid_well_formed(stateid_t *stid)
+{
+	return (stid->si_opaque.so_id - 1) < INT_MAX;
+}
+
 static u64 current_sessionid = 1;
 
 #define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
@@ -7129,9 +7146,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	struct nfs4_stid *s;
 	__be32 status = nfserr_bad_stateid;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
@@ -7186,14 +7200,15 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 
 	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
-		return nfserr_bad_stateid;
 	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
-		if (cstate->session)
-			return nfserr_bad_stateid;
-		return nfserr_stale_stateid;
+		if (!cstate->session && stateid_well_formed(stateid))
+			/*
+			 * Might be from earlier instance - v4.0 likes
+			 * to know
+			 */
+			return nfserr_stale_stateid;
+		return nfserr_bad_stateid;
 	}
 	if (status)
 		return status;
-- 
2.50.0.107.gf914562f5916.dirty


