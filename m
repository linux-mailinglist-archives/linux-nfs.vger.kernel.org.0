Return-Path: <linux-nfs+bounces-16655-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A3C7C097
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E9344E2FAB
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27E2201004;
	Sat, 22 Nov 2025 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VDRRfs9m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jocWOB2o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC7239E80
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772796; cv=none; b=Arkq8VbM7smhOFvloWsQ09b96Gazc4QEpS9IrNLgq3vTU27Cbj/j59qlZd8grfTokrr4NCVbcKCtVgN0SyKUBoYUYxTOu30iAiqZFdbkthD+Rd8s6oKiFOOLCg+M3D2IuZ9xOzELtb3D3h/rsXJOqShmI7Kkbawbxz1974zngzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772796; c=relaxed/simple;
	bh=Ss+9/opJq/sCXHZlNy+Gzc7yBOo32/4poED6gDGh2zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlcHCaR8scxUNAS8cmrJktN6k87IZF3pWUZ90a1P1AH/CGKcUuE9E9ZdSCn9OpnkqXJrSLCzZtKR2PTAH9uVp7NJfvHiU59wQ06zuuvW8nMmVm/uLmrOWuu/u5BOz2kGD0TVIqhxj22BXF30cKnZJKeQfBbqMkCRMm/AXgogDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VDRRfs9m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jocWOB2o; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B1FF14000CA;
	Fri, 21 Nov 2025 19:53:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 19:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772792;
	 x=1763859192; bh=Ktm40IA5Is2Sc2B3SxKbdNkLbzd1ugcmP03IEK4HhqM=; b=
	VDRRfs9miEsIcWuTis55DrL3NnK382Nh9/Xw7Ooc1vrpvwu9bOMzCFmBIHsLwiAw
	u20tNEwtTuO/vQInCBmjI6nuEvNas7HsI+vOW2pHrkVUBNSNAXkQ4NJgg2A7E7zX
	A+p+j0wxQVRyjuC+x+CXtkXUyM3n6gC7Dt5JwEvF+fi8yTIn2AWdOgB1Lz0c9Ovs
	DGNZ/8UuH0N/XtJ2dhPcfUyLc5FdhTQk+4qjNP1KQk+0Xjzo+GERVIqPc2wSqJXQ
	EdVmCrUgKRLXD88elbl+zcAfKSiyu/OsC987rEFgRhyj2LbTQ4lXx0CNgib2s4d3
	a4NQxKxcc0+tBpDhRwd6Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772792; x=1763859192; bh=K
	tm40IA5Is2Sc2B3SxKbdNkLbzd1ugcmP03IEK4HhqM=; b=jocWOB2opVzM/9c0y
	RLDNKum/qcAXsKyhvKstaLAk6pU5AfHBGD322fubE932rhnGBtJsAOohSQClc/yI
	64yAHy2412cUMc8aSQDnEkTy+aXpPDQR8zlf7T724bNYjl9J33l0UQgJuSZuZKd6
	TzMyN6bx2aRqemIMlPVRUHCdRdOhAKB6g8E5f7nJpz3kKHK0TqIPrA0XYEtlaqM9
	NkCfvuWVzuRPbfnd1ioIExYkoLTJMhhisl69+b7B47XDZ9fbMQNQ7odaxzru+t4D
	qc311BJm40Ojy+5/YGxfDkLUB8VVyex7qdjaT1ilOdHlIsjoJiSY+ojcP4SrB4Aa
	Ez1/w==
X-ME-Sender: <xms:eAkhaYLyEj09ix0sUimPdQLtbAmnatWRUUcjyTXYa1hd3eP6qx7dIQ>
    <xme:eAkhab1OO0q1NDEdsfmkquEjEoNVDo2IxR_noq8z1dAin_YWVjTTvy4K-28xt1WK_
    8LZu-4Zfr0Pc-ys4FH-B_y_jD_UQJSRYCDvaVxY6fQnR7GZNg>
X-ME-Received: <xmr:eAkhaSiv_agCkf72YQB5LZYNbG3x5Ly6fi-e8T8Zw1gqBitjPgJzbqXXTSu92e7BBy_hXV3LDxq6D0eNFnk0tqhqHBx6HCt3VzmxCLwIeqSb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:eAkhacXzLuwKQkyWNMYEQcgovdFmSV2jTUfVzxTlTIkmLtqi4UOh7w>
    <xmx:eAkhaRWYErVSItcj0Ckz1LZP6ethN1GCcFS9euz2QiK6crfNh2C1NQ>
    <xmx:eAkhaci9GcYCgYqQw79a_pv0u3Hxb_cHr-tV816ocGWZQSAwDql8ZA>
    <xmx:eAkhacb03-sjeDAsdc1Q0gqmTHYLQGLmgw89WAG_SmFuZFPTv0ToAQ>
    <xmx:eAkhaRo68G7ESmdQ8RQF42xJxMEBlDaKL2oBP4TIy7XrwhEnXlkhYy-S>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:10 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 06/14] nfsd: drop explicit tests for special stateids which would be invalid.
Date: Sat, 22 Nov 2025 11:47:04 +1100
Message-ID: <20251122005236.3440177-7-neilb@ownmail.net>
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

Note that current pynfs synthesises a "stale" stateid for testing which
is actually invalid - it has a form that Linux NFSD will never generate.
So the nfsv4.0 tests in pynfs incorrectly report several errors with
this patch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v5:
- minor improvements to stateid_well_formed() comment.
---
 fs/nfsd/nfs4state.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..aae0b301f38f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -74,6 +74,23 @@ static const stateid_t close_stateid = {
 	.si_generation = 0xffffffffU,
 };
 
+/*
+ * In NFSv4.0 there is a case where nfsd should return NFS4ERR_STALE_STATEID
+ * if the stateid looks like one it might have created previously, and
+ * NFS4ERR_BAD_STATEID if the stateid looks like it was never valid.
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


