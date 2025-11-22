Return-Path: <linux-nfs+bounces-16656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D09C7C0A3
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 280364E2F17
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB423ABAA;
	Sat, 22 Nov 2025 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="V+5bT7Ti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QSnwUOiM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F323D7D8
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772800; cv=none; b=p8kidXE7f3FB0hzr2Azn8GuZ1YnDzlzApRaSBM0a2geNZB7ZOcPr/F7dpWvXhBuHX3kbODYK/Kr0Byy3YtD8Yo3K625DZHbySiTPLoBQ0v8pDnp9lBHXfN5twgEZVuMRCqYGwsNiAir5FXDk7D+bSB59Jt44/iXmAxZBCHIaE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772800; c=relaxed/simple;
	bh=uURkXF+eSaOJE0FFeytzsS8Y6KgWNpt36zr6DNdCK5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/CiTFCvVUIM50TNgK1qztZDNP+VH0kWCsgWNwHnDfEq9X2DqziIGMUnLZ4yviz2RYxg3qhNi+ISiaRsVhd0FN4KYUnP1kXYfB+DoaWUXdg3jqN0NsVM0oebmjkffmDXOZsnuteBESZyf69Ltteajz1mMGq65SPzdQZT9KFeRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=V+5bT7Ti; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QSnwUOiM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8734E140009C;
	Fri, 21 Nov 2025 19:53:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 19:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772796;
	 x=1763859196; bh=YouDDFHK/mq3+i/W8i6ood2cqMYZWkABcQx0rvvLVjw=; b=
	V+5bT7TixfMw06yV/VSa9SkzPajE99GMcTkEt5rIzlyRjeRjSjiQ6glgSipyV57d
	WIPGlImGoGYWpgJfN5jWnetxhW4siWIHoB/EccAjn4psCRHEbSdA8sWXhnrNektJ
	XOF1mVCqpon+E3tMhsDweqldE5TOthJ5o1VSGnYgI8k7/VYHA/hZkeCr381z3fvv
	hewLJll9S1cMW/J0w0c8/bMB+y5D09iAcQI4opS8zZBk9msuDi39355F6YWWQxoQ
	Hg6SZpKwUq0lfdbahiaA1hSGHqfj4p0VXzdlu+BzFF9/YbaVeCoz2m5kkop2QMKK
	5jXAX8Kl1QA4OgqnFOMhSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772796; x=1763859196; bh=Y
	ouDDFHK/mq3+i/W8i6ood2cqMYZWkABcQx0rvvLVjw=; b=QSnwUOiMBY4Rw5M8S
	jWqAU59u2VS6hRh/4UzvdfPZ11THp1tHgQNo0gWWSg+zydtLJNSMLncypVkvbkh7
	neo2DvoUq4AgcKWMGd997GNdfO4JSXBPmoz5OFm4wP3tYL04BMtAF4SmygG0Wecv
	2j6pTRFpJ/Iigx6K6UBJFZ+Lc6Zpy7kN0bzIyVFgLpklgpllb4NtwvEpgbJTqdlY
	VUS9qmIz6LHbTpupD69gsE+qM54iRalZuhHiovb45OBgg4wcs9vZ6c4T/u0pESFz
	NbhykMXzetfn6qComX3+gl3TTkTKMav8mws63Sbo2jTHtY1AVkAwumegeH+DNmGf
	mzDZw==
X-ME-Sender: <xms:fAkhabKeS-jXbu5etfwO8ItdJ6lLlNPndG5hrisPr3oy2j0WcqQ6Jw>
    <xme:fAkhaS2_T3itzUxCQaSyzGOT1SZPiedmjO290rx-4Hl6eU3uGBgpRAHWLIOpV09DK
    oCbCYk5Jliu7ax4aGioS8jsmtn_GXmz4fyaRLFdYmIl7wD0tg>
X-ME-Received: <xmr:fAkhadgu9muNcAZdpjM4IqU8nGnLVkJ7LTSaT9SkTz_tmEsAdjmYYx5Xjo1lPO5xoloVr_VyE6_m4EeYPJF-HdoTd1E1puRBlfHU4wYuO2xK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:fAkhabVx9YhUGJnK6jdKv3z0SN_Aho8Hvl7QKk_xC5oBncHI7CbsKw>
    <xmx:fAkhaUXX-wPizMIiunSSOSPBoqFOvUTylkkJx2TsattwgjX3gw_RkA>
    <xmx:fAkhaTjFbs6m3XT1omt1IQ-sNQmcempswWVzcmGc5Tuz7eDBLwXJWw>
    <xmx:fAkhaXa_AthMZI_v7i4zaJu5GWcIAxWDL6ZbwsMZhHKRkY0mFufWew>
    <xmx:fAkhaUoC-GwIwOUNFn5AptN6LT20Q0Yag-ONgiOr87ncKvv_qOBEkD2b>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:14 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 07/14] nfsd: revise names of special stateid, and predicate functions.
Date: Sat, 22 Nov 2025 11:47:05 +1100
Message-ID: <20251122005236.3440177-8-neilb@ownmail.net>
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

When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
is testing the stateid to see if it is a special stateid.  I find that
IS_CURRENT_STATEID(foo) is clearer.  But an inline function is even
better, so is_current_stateid().

There are other special stateids which are described in RFC 8881 Section
8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
currently names them "zero", "one" and "close" which doesn't help with
comparing the code to the RFC.

So this patch changes the names of those special stateids and adds
"is_" to the front of the predicates.

As CLOSE_STATEID() was not needed, it is discarded rather than replacing
with is_invalid_stateid().

I felt that is_read_bypass_stateid() was a little too verbose, so I made
it is_bypass_stateid().

For consistency, invalid_stateid is changed to use ~0 rather than
0xffffffffU for the generation number.  (RFC 8881 say to use
"NFS4_UINT32_MAX" for the generation number here, and "all ones" for the
generation and opaque of anon_stateid).

Signed-off-by: NeilBrown <neil@brown.name>

---
Changes since v7
- fix is_XXX_stateid() which all inverted the test
- use sizeof(*stateid) instead of sizeof(stateid_t)
---
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index aae0b301f38f..f10c22d02735 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -60,18 +60,18 @@
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
 #define all_ones {{ ~0, ~0}, ~0}
-static const stateid_t one_stateid = {
+static const stateid_t read_bypass_stateid = {
 	.si_generation = ~0,
 	.si_opaque = all_ones,
 };
-static const stateid_t zero_stateid = {
+static const stateid_t anon_stateid = {
 	/* all fields zero */
 };
-static const stateid_t currentstateid = {
+static const stateid_t current_stateid = {
 	.si_generation = 1,
 };
-static const stateid_t close_stateid = {
-	.si_generation = 0xffffffffU,
+static const stateid_t invalid_stateid = {
+	.si_generation = ~0,
 };
 
 /*
@@ -93,10 +93,16 @@ static inline bool stateid_well_formed(stateid_t *stid)
 
 static u64 current_sessionid = 1;
 
-#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
-#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
-#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
-#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
+/* These special stateid are defined in RFC 8881 Section 8.2.3 */
+static inline bool is_anon_stateid(stateid_t *stateid) {
+	return memcmp(stateid, &anon_stateid, sizeof(*stateid)) == 0;
+}
+static inline bool is_bypass_stateid(stateid_t *stateid) {
+	return memcmp(stateid, &read_bypass_stateid, sizeof(*stateid)) == 0;
+}
+static inline bool is_current_stateid(stateid_t *stateid) {
+	return memcmp(stateid, &current_stateid, sizeof(*stateid)) == 0;
+}
 
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
@@ -388,7 +394,7 @@ nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
 static int
 nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
 {
-	trace_nfsd_cb_notify_lock_done(&zero_stateid, task);
+	trace_nfsd_cb_notify_lock_done(&anon_stateid, task);
 
 	/*
 	 * Since this is just an optimization, we don't try very hard if it
@@ -6512,7 +6518,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * open stateid would have to be created.
 	 */
 	if (new_stp && open_xor_delegation(open)) {
-		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
+		memcpy(&open->op_stateid, &anon_stateid, sizeof(open->op_stateid));
 		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
 		release_open_stateid(stp);
 	}
@@ -7076,7 +7082,7 @@ __be32 nfs4_check_openmode(struct nfs4_ol_stateid *stp, int flags)
 static inline __be32
 check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid, int flags)
 {
-	if (ONE_STATEID(stateid) && (flags & RD_STATE))
+	if (is_bypass_stateid(stateid) && (flags & RD_STATE))
 		return nfs_ok;
 	else if (opens_in_grace(net)) {
 		/* Answer in remaining cases depends on existence of
@@ -7085,7 +7091,7 @@ check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid,
 	} else if (flags & WR_STATE)
 		return nfs4_share_conflict(current_fh,
 				NFS4_SHARE_DENY_WRITE);
-	else /* (flags & RD_STATE) && ZERO_STATEID(stateid) */
+	else /* (flags & RD_STATE) && is_anon_stateid(stateid) */
 		return nfs4_share_conflict(current_fh,
 				NFS4_SHARE_DENY_READ);
 }
@@ -7401,7 +7407,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (nfp)
 		*nfp = NULL;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
+	if (is_anon_stateid(stateid) || is_bypass_stateid(stateid)) {
 		status = check_special_stateids(net, fhp, stateid, flags);
 		goto done;
 	}
@@ -7823,12 +7829,12 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	/* v4.1+ suggests that we send a special stateid in here, since the
 	 * clients should just ignore this anyway. Since this is not useful
-	 * for v4.0 clients either, we set it to the special close_stateid
+	 * for v4.0 clients either, we set it to the special invalid_stateid
 	 * universally.
 	 *
 	 * See RFC5661 section 18.2.4, and RFC7530 section 16.2.5
 	 */
-	memcpy(&close->cl_stateid, &close_stateid, sizeof(close->cl_stateid));
+	memcpy(&close->cl_stateid, &invalid_stateid, sizeof(close->cl_stateid));
 
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
@@ -9101,7 +9107,7 @@ static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
 	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
-	    CURRENT_STATEID(stateid))
+	    is_current_stateid(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


