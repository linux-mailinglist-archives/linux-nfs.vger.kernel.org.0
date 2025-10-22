Return-Path: <linux-nfs+bounces-15548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E97BFE6EB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A6E74EC60F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A7288C20;
	Wed, 22 Oct 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cgsx8nkm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d6jYzOUF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E427F01B
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172653; cv=none; b=WRyVV3EcHei9Tg/puP5RESi0PIHYq22xZRkZEqiO+P19a1NxsSpHgmJVWBLvGl+n+ZBfF+rhvl58qS3Qy5LcnFMy2r3+CosqfGAp6Z8q9LHD6rlhBkfZ1KZ9azvEMeKJpiWX9YN5/4PxTjFi2Q+kRqbzJGxqa0jLGYvVo1bsPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172653; c=relaxed/simple;
	bh=GYVd/KLjeG8B2M6x6UmOsAbPKk0n0U82ztkBr9vIvhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeqyEIZQUjP5CYTXMdS5vfVm96D7KZlhuOxT/9wBwiLxB/RnnFHmG34Zb09J7WSYEXag7wvVh+B4aqDh1Mq47vxMGJlO7ujogAqNGua/T+CGtczoLlOQoSf4NYdyGc0HZIshk7OR7k/ADOnKd2pbtVugiSPpSFCRzmPpivgAjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cgsx8nkm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d6jYzOUF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DB79EC01B7;
	Wed, 22 Oct 2025 18:37:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 22 Oct 2025 18:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761172650;
	 x=1761259050; bh=Fm4c2eUOXVOiJ/2cE7YUTMlgwgQHikBs1qg+rVV77Uc=; b=
	cgsx8nkmTXl0lW+K+9V/HRsj/Jh9uhG2nhVIHVGeSRPK4vpx7YivyPow02ESI2hS
	uM3+BucL7EUHXwJwaX4El7ixeMRA4Edu/RsNYrCZ8i44TTPDwLRtuaroBWY7rDOi
	RTYPg9ngiu8U06Y1joNtaKIqf4RLyqfas+NIT3AbSwlEQ+iU2M81xLSkC+eh7f0l
	3NoDYjJ4efWnAzEJ6hTQVDVUbtcGBp51q5eV7W81xaYPjyVp/mC2KRMsZoWMMw+6
	sq59CG6GE7Vno63hoMATxozqq+UiDN5VPyNcYqte+qf/Fkl0f3sOB9MV/EqnA7yO
	+//UD5vlUHhg11n64M4Y1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761172650; x=1761259050; bh=F
	m4c2eUOXVOiJ/2cE7YUTMlgwgQHikBs1qg+rVV77Uc=; b=d6jYzOUFi5FO7DBSa
	5L+PPg32/XqKObhG2hsWxHSq3PwDtxoRfYfWfKSLyltuga7sAJHRifyBPncE+3IF
	IAWWyLmL3iiU+zXU2gNRafsdzSCZqXNgR3H8iGpaMjGUW9ED5KIJEGP5COW9c9Pw
	int17+i7OUda6XUdj1OJ906Y55dnJ0w0uUOgrByxFz6vTGxdTyTZiSGxS/XrIfbX
	ORmaKgknZvdciG5wMUX6OiIhiQidipjCbbRVmKZvhGI/mnQzDhloLiI4o8y8UU8m
	40SiGAuwZ+FaapxVofc3l8mCc2/TQWcdUtwlBJQfgZXo4Tubhh9OI008CCc7Xq4A
	GVLlw==
X-ME-Sender: <xms:qlz5aPI__leJAyoUJJW8Qx4e96hylfspnWiD9C7esyp2Q8--B2UKIw>
    <xme:qlz5aG3nPautTXXiKR_3RJrTFHZ6idIqbyRnKpYM4fEoVWVhpKVHvjYqCxzIHoRS6
    fjsI6U5b9enRGp8yjZY8ahxKvpGNCzjKiPfHC1jo_admEoa8Q>
X-ME-Received: <xmr:qlz5aBjShq4tqWIfxzNTtaTokfDRo-xjWqaNXkXR_MkmsPFGdTfMtJf6SCScUjVNFrQprjN0J4hbGscvhl7hOhg4gNCZuXtnxX3Ry2VXanX5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:qlz5aPVzNtKfx5qqPJtuBxDj_jYrrFginLd01Dhb3zQy9bB0D6bkxA>
    <xmx:qlz5aIVMry_qo6QWhjf84nt11Owt5U-5FnhACU_aj7YQ1j6-i6aXCA>
    <xmx:qlz5aHgxLzwJ_iWnB3OycnVU5rUTeCthMyRlW8vg5MPOSwcrY_Oolw>
    <xmx:qlz5aLZWMr9r9YAUoyXvUAKeqPEgiSPhtGcF_gpZtgZiTBK2npAaDA>
    <xmx:qlz5aIqziJAt6Fa5vNpsgoBj50iDB2xqvRNWkEAZvmpjzIZyb33ehM64>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:28 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/8] nfsd: revise names of special stateid, and predicate functions.
Date: Thu, 23 Oct 2025 09:34:28 +1100
Message-ID: <20251022223713.1217694-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022223713.1217694-1-neilb@ownmail.net>
References: <20251022223713.1217694-1-neilb@ownmail.net>
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
IS_CURRENT_STATEID(foo) is clearer.

There are other special stateid which are described in RFC 8881 Section
8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
currently names them "zero", "one" and "close" which doesn't help with
comparing the code to the RFC.

So this patch changes the names of those special stateids, adds "IS_" to
the front of the predicates, and introduces IS_SPECIAL_STATEID() which
tests if a given stateid is any of those listed in 8.2.3.

I felt that IS_READ_BYPASS_STATEID() was a little too verbose, so I made
it IS_READ_STATEID().

Places where we now use IS_SPECIAL_STATEID() didn't previously check for
"current_stateid", but I think they should.  I don't think that change
actually affects behaviour.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 46 +++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..b270dc0af7f1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -60,26 +60,34 @@
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
+static const stateid_t invalid_stateid = {
 	.si_generation = 0xffffffffU,
 };
 
 static u64 current_sessionid = 1;
 
-#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
-#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
-#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
-#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
+#define IS_ANON_STATEID(stateid) (!memcmp((stateid), &anon_stateid, sizeof(stateid_t)))
+#define IS_READ_STATEID(stateid)  (!memcmp((stateid), &read_bypass_stateid, sizeof(stateid_t)))
+#define IS_CURRENT_STATEID(stateid) (!memcmp((stateid), &current_stateid, sizeof(stateid_t)))
+#define IS_INVALID_STATEID(stateid)  (!memcmp((stateid), &invalid_stateid, sizeof(stateid_t)))
+
+static inline bool IS_SPECIAL_STATEID(stateid_t *stateid)
+{
+	return IS_ANON_STATEID(stateid) ||
+		IS_READ_STATEID(stateid) ||
+		IS_CURRENT_STATEID(stateid) ||
+		IS_INVALID_STATEID(stateid);
+}
 
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
@@ -371,7 +379,7 @@ nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
 static int
 nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
 {
-	trace_nfsd_cb_notify_lock_done(&zero_stateid, task);
+	trace_nfsd_cb_notify_lock_done(&anon_stateid, task);
 
 	/*
 	 * Since this is just an optimization, we don't try very hard if it
@@ -6495,7 +6503,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * open stateid would have to be created.
 	 */
 	if (new_stp && open_xor_delegation(open)) {
-		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
+		memcpy(&open->op_stateid, &anon_stateid, sizeof(open->op_stateid));
 		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
 		release_open_stateid(stp);
 	}
@@ -7059,7 +7067,7 @@ __be32 nfs4_check_openmode(struct nfs4_ol_stateid *stp, int flags)
 static inline __be32
 check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid, int flags)
 {
-	if (ONE_STATEID(stateid) && (flags & RD_STATE))
+	if (IS_READ_STATEID(stateid) && (flags & RD_STATE))
 		return nfs_ok;
 	else if (opens_in_grace(net)) {
 		/* Answer in remaining cases depends on existence of
@@ -7068,7 +7076,7 @@ check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid,
 	} else if (flags & WR_STATE)
 		return nfs4_share_conflict(current_fh,
 				NFS4_SHARE_DENY_WRITE);
-	else /* (flags & RD_STATE) && ZERO_STATEID(stateid) */
+	else /* (flags & RD_STATE) && IS_ANON_STATEID(stateid) */
 		return nfs4_share_conflict(current_fh,
 				NFS4_SHARE_DENY_READ);
 }
@@ -7129,8 +7137,7 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	struct nfs4_stid *s;
 	__be32 status = nfserr_bad_stateid;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
+	if (IS_SPECIAL_STATEID(stateid))
 		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
@@ -7186,8 +7193,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 
 	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
+	if (IS_SPECIAL_STATEID(stateid))
 		return nfserr_bad_stateid;
 	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
@@ -7386,7 +7392,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (nfp)
 		*nfp = NULL;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
+	if (IS_ANON_STATEID(stateid) || IS_READ_STATEID(stateid)) {
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
+	    IS_CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


