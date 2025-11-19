Return-Path: <linux-nfs+bounces-16513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2529DC6C9C7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D48852A118
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79E2EC579;
	Wed, 19 Nov 2025 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="euywS5/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KpLrVxCz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8C221FDA
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523165; cv=none; b=FIoTkd3ufIq5DqHArhwYBXaHDwdWdBblhGcMRyj3NKdZ9iTQIGh3NrCg2hSVJWtyGXce65f1HCXNgauOtiheunGeUoNsnq1q8N8F66MsHgtveKXv0e2/NMpkELYw5Q4niBAVJNGZogYV2dbcoKlgTxTwelDD0U6mADKJ3bSMazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523165; c=relaxed/simple;
	bh=ty5MneoFnRMZBvI1Wsvn1yPh2RuMtgfT1KfJ5w0gcc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mez7gEPMDilZosVFmTGlI0AcS0HjAEc8EpPV13Kn3itdFoB4g+igDfcNYJz4rWO3ABz1R8vPGi0ZcAMj39gcwLWx3gmmdrDbPJj1y0CTDgaNyoDzJeIvx5wScXLoQQJfvn4vGDWuiKjkNunjiBvbsmonv2k4QX4Xo3/38tThyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=euywS5/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KpLrVxCz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A66441D00156;
	Tue, 18 Nov 2025 22:32:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 22:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523162;
	 x=1763609562; bh=1+Ie432DhomPijJBSjEHrdScAyZexqOx+paG2lwHYzM=; b=
	euywS5/pqBx0LoJy0Oe8UvQ8VWq5nf4IAJMqkrI+hNNpMuv2uoGDBYB7GfS2dLAo
	S8yYUgtmi18oNXAJVbVlluHHdC+1SHmi6h1P1RDM4T3gd5sCul3rPa8kP3oizqWs
	F8QUzMHqyfR+RRrEuAn65l+uUNOr5bsFfu403hdBBTrftEybY1zbtbptEJD4Nacw
	0F3aWSrYPfvbd06tCASaGVllphYYoAoRA2PwQfqj/4sYlfGk8zVReQLR+rsFmjLh
	FS+piSht0xtc4VYExbQIBea3RZFa6rNe0Rn36FlcIxlR7UbBX0x16P/kwDlD9Aqp
	qSgWf5TmR2Rp1lJoYpV1Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523162; x=1763609562; bh=1
	+Ie432DhomPijJBSjEHrdScAyZexqOx+paG2lwHYzM=; b=KpLrVxCziBHZv+ay0
	SLvBI/BvQCcooE64kCjbm+kdrHw30o/ykz6EnqqLQajpXyJ7DUchM2UMtxjJtI1D
	5I3ssoTHlLLxVffpxZ8cawWsgkhSls1nJ/pGJ5TjTsoyOrS8Rc9ZFnEXY6DAvB6z
	Tuf1vfDQg39tc7nQgkbU35sm9FNEEHX6rQ89h+dyh6jwPWdDNXo9a/nMqdgxmpRO
	MdCZKGbt2tI1A7HmO4L+PoniQBCfzHYThELSyrE06qyti2f8GaVnZALJk7b+dXxB
	51K4LF1Br2GGAIFF7lK5Da31kWiAinHBuX8uvuBrnspdpVok7SUjJY2kJsjFB9im
	jcXEA==
X-ME-Sender: <xms:WjodaZTsibHUNscKNp63OzkT3mBk_3HTBNvlxQv8PeArkBxX6N5G5g>
    <xme:WjodaWf0J-rSD7zAcL5bTj9QU6SyLhF6EPoGLIQ9glU6FIA1c3x0v9l0jq_kjARxH
    Zx2jX60QRt_lmYYX8KXMMKoA9jey74DaJlFHcNIf1OmhFgZ>
X-ME-Received: <xmr:WjodaYr0ToKFrIMdDvmbOg3xK8NdaEWsVHb7149D50J1VCu0CLJhXmQszIBVYb3FjKZ5-cB9ktTAW9feKRUeFwGcSjx9JjLbnRzTX1eA74Fq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WjodaX-Kd2oMka6HSkUNtZCg1pf7u_dCCS3rrVoYBTFyJE9kwkz-kQ>
    <xmx:WjodaUfh3fDQKmbuUMwzrKV4Jex_VZxbd7P-ymyPUTmVVXjyLi89Lg>
    <xmx:WjodaRLUgrVJVHy3C1hhVPALmceOgWStVOWy2d9Jl5ZKDxF-TMt6Tw>
    <xmx:WjodaUju3P3ITXGBvhAI1RGI0Bu7fi654yPY-vGRVrLtVVsh1s-lng>
    <xmx:WjodaXpOuVLNmEO1a_InFt5sITbWc94ej2Ptxf9AYTBkF9YiuwhlcHc5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:40 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 06/11] nfsd: revise names of special stateid, and predicate functions.
Date: Wed, 19 Nov 2025 14:28:52 +1100
Message-ID: <20251119033204.360415-7-neilb@ownmail.net>
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
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ea931e606f40..f92b01bdb4dd 100644
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


