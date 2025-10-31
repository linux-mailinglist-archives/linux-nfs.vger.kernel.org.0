Return-Path: <linux-nfs+bounces-15826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D33C2329C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64E1B4E21BC
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0C259CAF;
	Fri, 31 Oct 2025 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Lc/Fo9Ay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1wqsbmrw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AE828E5
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881151; cv=none; b=HZWfUm05x5nXdR/jNTp5u0WqS93v5ut+oFmBqOd8t1EBL8hR423IgMc2FXOxlYBrv3nmqfLGA3WwEe9qi/ll88R9BeFEuwT5EhNsVWBJTpvtgG2vYmAUtP+efcaBNkqyNWv+4o6nwzhkcP1qwzSmEWyRJwNt9rllRO2VK1aSTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881151; c=relaxed/simple;
	bh=/3GseQwMt08CJkNZR3MBubrWOdbeOL6PEW4vd6g6+18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acDCmtqp24DeiSJa6GT+SkiG3E/LSVFnyEaSVzN2BgaGE/Vqj4f1hNRdHyUieTDn2n7nmjI/+FN+m8xwv89SImTKsOwPIwUC+tVFI1Sin7WsOc/KfB9utaOx2Ac3lNwnrHNJmFYvqyhjQuPbwk7bCRdcaMrYZfqIBithlDtLxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Lc/Fo9Ay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1wqsbmrw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FF1A1D00154;
	Thu, 30 Oct 2025 23:25:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 23:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881148;
	 x=1761967548; bh=XkxhDHEnL4m+jY4wO5EjHy80SMJ5bTBDd8dgR7MB15w=; b=
	Lc/Fo9AyzosYX0/ueAzyPG55Lo1f+PcSlaMsJU7rIeReASlwGQsMognGYHXTJQsP
	pTPVpji08VH0lO7mBWFnbnIyQv4VeEXdqIZZN2Zc5CV5zDZ8uXJToe1wGS64GsbP
	o4LCXUHtZ08ApFiFSmEzZXxYyJbqsoIFgU6KWywBcW84CtYFRxeVGrPaG0se20lw
	kxUh0PRjhdjRd2DEhXLGM81BKZFXGqaNnPdKSFkeQt9dSyAvkhf8DAktzVjAtMsZ
	D2JDUmtJFMyDSY+g3BF+84vLZP0SpjIqxfkTlmdSNYXWQ//OkxiKSFh1R3MvneEb
	xiDXgFyU/OP4g7Mm8kpd3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881148; x=1761967548; bh=X
	kxhDHEnL4m+jY4wO5EjHy80SMJ5bTBDd8dgR7MB15w=; b=1wqsbmrwbnNp0KSy4
	gP4SvYZrhr4MJdT9+3S04UopngIOdKoEALsVVdATbDSeqoEN26Jzcpsa4JDl6azv
	607oQQFFlu+Ekq9OMX69irttJaU+/6GLDCevWOxAj5luNhZUfZpF5ZDEzbAomcS/
	ydGPZ/hTOpze9s4eQ1AaDaUeWgxiHodhuPn/JuIJJg894taQmWCpC9sNn+j12kTe
	PZu0TL5+JGOgsQq69M6VaF49D0r2me6voI9uEA6+Q/eJKPtLi/ga4NEpVh2pXcOJ
	jFuD4POkoPkOFis6EZj0tMXfN0yW3y7aKAzXPCNCKIv+rp7dvQ2AScWVhP1TsKJL
	r/YUA==
X-ME-Sender: <xms:PCwEafNdAz0bOWHQ19qh6VVVQev3kkJPQ6zIvWUmyFVFif0OcwCoYw>
    <xme:PCwEadqTTE4_WdJ56hFHBRYj-0QL5JL-fygOyylL8m8v7Dr11uFzQOGERefM-2Erb
    RvqDOlTI9o_nQYGktzJWhyZotp6mxl33_Zus5xacpZttPja>
X-ME-Received: <xmr:PCwEaYEqLMVZychzmBf3SpHKbujCywrTBreZxC0s_3opMShjZGT56Rrfn_-cZKHWLAW0CXVJyx3t8WaSXNvDzyYeGTi0-7Dq_7HDn4_nJg0u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PCwEaapu15L3_LAKgT0DqMfhidFzM2LaEdK135XTLuXZl-LBzPOJzw>
    <xmx:PCwEaZapVOrdlpIF9XBZqu8OdMInxwP_h7QNuAqRldr3f_DMrzM88w>
    <xmx:PCwEabUX4c9802Saafg2VBPOAAN-K-YChqurGc21JhynORt5WQJgTA>
    <xmx:PCwEaa8sCJ1Hh4B5_rofMdL10hRdCbepbdX3d0mJu7Ay5ZraVsKomQ>
    <xmx:PCwEacv8PcPTeI-5Z_-s1IptR1JEcG5wVEJtRZjNpbo9j31SDRDHjY78>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:25:45 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 02/10] nfsd: revise names of special stateid, and predicate functions.
Date: Fri, 31 Oct 2025 14:16:09 +1100
Message-ID: <20251031032524.2141840-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251031032524.2141840-1-neilb@ownmail.net>
References: <20251031032524.2141840-1-neilb@ownmail.net>
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

There are other special stateid which are described in RFC 8881 Section
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
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 83f8e8b40f34..82951a6ebb1c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -60,26 +60,32 @@
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
 
 static u64 current_sessionid = 1;
 
-#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
-#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
-#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
-#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
+/* These special stateid are defined in RFC 8881 Section 8.2.3 */
+static inline bool is_anon_stateid(stateid_t *stateid) {
+	return memcmp(stateid, &anon_stateid, sizeof(stateid_t));
+}
+static inline bool is_bypass_stateid(stateid_t *stateid) {
+	return memcmp(stateid, &read_bypass_stateid, sizeof(stateid_t));
+}
+static inline bool is_current_stateid(stateid_t *stateid) {
+	return memcmp(stateid, &current_stateid, sizeof(stateid_t));
+}
 
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
@@ -371,7 +377,7 @@ nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
 static int
 nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
 {
-	trace_nfsd_cb_notify_lock_done(&zero_stateid, task);
+	trace_nfsd_cb_notify_lock_done(&anon_stateid, task);
 
 	/*
 	 * Since this is just an optimization, we don't try very hard if it
@@ -6495,7 +6501,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * open stateid would have to be created.
 	 */
 	if (new_stp && open_xor_delegation(open)) {
-		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
+		memcpy(&open->op_stateid, &anon_stateid, sizeof(open->op_stateid));
 		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
 		release_open_stateid(stp);
 	}
@@ -7059,7 +7065,7 @@ __be32 nfs4_check_openmode(struct nfs4_ol_stateid *stp, int flags)
 static inline __be32
 check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid, int flags)
 {
-	if (ONE_STATEID(stateid) && (flags & RD_STATE))
+	if (is_bypass_stateid(stateid) && (flags & RD_STATE))
 		return nfs_ok;
 	else if (opens_in_grace(net)) {
 		/* Answer in remaining cases depends on existence of
@@ -7068,7 +7074,7 @@ check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid,
 	} else if (flags & WR_STATE)
 		return nfs4_share_conflict(current_fh,
 				NFS4_SHARE_DENY_WRITE);
-	else /* (flags & RD_STATE) && ZERO_STATEID(stateid) */
+	else /* (flags & RD_STATE) && is_anon_stateid(stateid) */
 		return nfs4_share_conflict(current_fh,
 				NFS4_SHARE_DENY_READ);
 }
@@ -7386,7 +7392,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (nfp)
 		*nfp = NULL;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
+	if (is_anon_stateid(stateid) || is_bypass_stateid(stateid)) {
 		status = check_special_stateids(net, fhp, stateid, flags);
 		goto done;
 	}
@@ -7808,12 +7814,12 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
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
@@ -9086,7 +9092,7 @@ static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
 	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
-	    CURRENT_STATEID(stateid))
+	    is_current_stateid(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


