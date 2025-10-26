Return-Path: <linux-nfs+bounces-15633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D41C0B5CC
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19103B271C
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A541F4CAE;
	Sun, 26 Oct 2025 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="tl0VIqBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n3GwWd7d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF92BEFE5
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517646; cv=none; b=ULd7CIWDvtXVa7BVr90ggNFt8yspueX49aW/GL+iTengTwQW24b1+qpNqOBeT3mYIrOpUW4BrmpZuyCs+2Sd7JG5luvUMmBRk02qJ4ZKQgo+lQXb3WBeYx/TsOMw3rQMLWYB2Iu/OMocxmvq8/GXLDZkGXBX6sznEfN8x14OOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517646; c=relaxed/simple;
	bh=FrfwhboZ5MVhur20BX5Fbqgcx6jtGNOSUkBziptgdgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZJs3rPmQo0N+tPjVId7o9Mr6tzdeRc835VxUqWhXo7M8D5Ho3B7PI3Jo7qYkbRiz93eOY+usQAGYFgPaxFcaktij2FimOoOO92Dnpvbh2DZ5eqy7rsssZKtIoEAhdCfUXp4JQ7ulsQRGGjvi7F6LvGmYaD8CbInQ/z0FQHdjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=tl0VIqBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n3GwWd7d; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A387A1D001AD;
	Sun, 26 Oct 2025 18:27:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 26 Oct 2025 18:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517643;
	 x=1761604043; bh=nQ5Lisit+7RgJGwuBiQJv8f8zExNdxdUoQY+kefXeKU=; b=
	tl0VIqBSNyOE1RfExRAFh7/2uM5s2GRAjAhFEbtR8dpZb4u+ut9Bac0LITE9WzzQ
	reSGfJICPVFVYkDAw17Kd4QH0uJv5RLVfqvXowRSc79uBCXlARxeTzl3Y9nBIA+4
	Sp/8DURuSjvDAEM7btMuSwroOyyVRoqvmicFyTETMNZ3OJDmXtgLDgfwIesTPfAF
	689VsFAuX0ukhzld+Hyn3m9tQ2Ksj271a3DcncdMPNXjblq0qmsrN7FWFnrZ4yMb
	BDmJNVrIY3DfIxGAMD6vO14P94SBV0t0Dw9xI42V/8KfIV2XftaauxZtb/Im/Soe
	jsZRjFBvfoaxM9cFRb3znQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517643; x=1761604043; bh=n
	Q5Lisit+7RgJGwuBiQJv8f8zExNdxdUoQY+kefXeKU=; b=n3GwWd7d2NoC+g8Tr
	DGsS3MBYHDMM4gIrY/0un3GNVdqtWohAOipW/KQo02m/2vSAOaK4vj3jOtGi+jCY
	e0ozWRiZE9bm6gSejInt4fl2pVSybud2bV+/0D3ZUv+RRCyhvhAoqiEqIxRB0kYL
	65CZS+Yagyean112+JJcZyrns8Ak4LHwVEI5lDE3qiwzN88P0SRT0ndHzlmHIukf
	k0iz01LULiMa+t2oEVM7Ym9413uU0CCMzjtppaUPXKulPAItALw//TnoF9eHATG3
	E3025XWiulIcKgL1S3bQSdeX1CuzSk+D8ktl9fQ6eT4zWbZVivtahqyTphq5sUyO
	B6y4w==
X-ME-Sender: <xms:S6D-aL4JlsIJt2ZVegxeb3PFHpY81GG6g-ZlvoS7X6LGiD3_wQha9g>
    <xme:S6D-aEkbPF1zld1twWyySFJBNEfP2v1gzniGRKvkIdrKGo4wwZkPVJMC_lAb5hnsJ
    sX_yNIEilT08kGVg3mh2SngJNLtoM75FR4wBqEnqsd7S-qu5kY>
X-ME-Received: <xmr:S6D-aMSOKnHTbq1oxraM-E6OLGtJzBVYZCynmKzW21BDQDfy_aPIG8aHS0WnaqgRkL6UWjTXhyKNZJBg0zkK2xuxEJ933FiERC55hhkEdh24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:S6D-aDFRAOQid5AS0WanlsDSvdqgQZgPq84JfWEGm_qBH7MkIVNhUQ>
    <xmx:S6D-aBFnthpg_lXovmUdn7INGVCAmYdTEM-Gh9A74CpHHpkTR4X1PQ>
    <xmx:S6D-aBRHH5EYNBuoK1osGDi84UnF3Syre1Vk3IXuzd_y6qrHBVmMiw>
    <xmx:S6D-aCKypdBzvj2b7GEFnQuZmDIfVWWCSTh3ep4XPCCL_gwE5fgjrA>
    <xmx:S6D-aFY0xjm7N390LxyvzFjQcF57PUutbOLnpoI4CFivFZMbvQeVFLZZ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:21 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 02/10] nfsd: drop explicit tests for special stateids which would be invalid.
Date: Mon, 27 Oct 2025 09:23:47 +1100
Message-ID: <20251026222655.3617028-3-neilb@ownmail.net>
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

In two places nfsd has code to test for special stateids and to report
nfserr_bad_stateid if they are found.
One is for handling TEST_STATEID ops which always forbid these stateids,
and one is for all other places that a stateid is used, and the code is
*after* any checks for special stateids which might be permitted.

These tests add no value.  In each each there is a subsequent lookup for
the stateid which will return the same error code if the stateid is not
found, and special stateids never will be found.

Special stateid have a si.opaque.so_id which is either 0 or UINT_MAX.
Stateids stored in the idr only have so_id ranging from 1 or INT_MAX.
So there is no possibility of a special stateid being found.

Having the explicit test optimised the unexpected case where a special
stateid is incorrectly given, and add unnecessary comparisons to the
common case of a non-special stateid being given.

In nfsd4_lookup_stateid(), simply removing the test would mean that
a special stateid could result in the incorrect nfserr_state_stateid
error, as the validity of so_clid is checked before so_id.  So we
also move the stateid lookup before the clientid lookup.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e1c11996c358..594632998a12 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7129,9 +7129,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	struct nfs4_stid *s;
 	__be32 status = nfserr_bad_stateid;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
@@ -7186,20 +7183,18 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 
 	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
+	stid = find_stateid_by_type(cstate->clp, stateid, typemask, statusmask);
+	if (!stid)
 		return nfserr_bad_stateid;
 	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
+		nfs4_put_stid(stid);
 		if (cstate->session)
 			return nfserr_bad_stateid;
 		return nfserr_stale_stateid;
 	}
 	if (status)
 		return status;
-	stid = find_stateid_by_type(cstate->clp, stateid, typemask, statusmask);
-	if (!stid)
-		return nfserr_bad_stateid;
 	if ((stid->sc_status & SC_STATUS_REVOKED) && !return_revoked) {
 		nfs4_put_stid(stid);
 		return nfserr_deleg_revoked;
-- 
2.50.0.107.gf914562f5916.dirty


