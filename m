Return-Path: <linux-nfs+bounces-15283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E1BE12C9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 03:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0694E4B47
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 01:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4655134BD;
	Thu, 16 Oct 2025 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="E0QVtwJl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHj4+1GZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093374A21
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578423; cv=none; b=bEN1dzv84+lq08xd8kciSvpbLz9p0z0FZfMDWjrNrUeq+Cx9BqalO3eGnW/mr/zIOFgo/AHOZPOmoaHWNZ+VZQb0topUEz7IdoQu/PSs3XCxbXHs6GqCgTuja/J8h8vfB1WRsbw1M/6AAl7myQHl0FaiU4f0zj51CujgNILMcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578423; c=relaxed/simple;
	bh=mF8PSIyTb00CNYDbLJBkM0ffOKipftJmIBm0W7WyBhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akJKBh+aqGUu2ZH4t5dVdnPBP+fQXpTbZPDSx1xV2ovZGi/eCHQttWTs07eMR3sM0R0Ve/rKnbDshYPJ2YtwCC2lo6C4elKoJcxhLP1jrDRBdXQa18/Rb0cmBiFfEyFazdOE7P436qJkNe+0VXulC36ei7e4S2hznvkbXD0oc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=E0QVtwJl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHj4+1GZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F2681D000F8;
	Wed, 15 Oct 2025 21:33:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 21:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760578420;
	 x=1760664820; bh=G9wLpmKBKcQ6mFF1wzGIX6IX5jCULVRmJYsES+W88XY=; b=
	E0QVtwJloYQpLag0qaZdP+zo/CKBYgLw0dy2wbXdl8G/Z2sBPF9wlyEp/g/nR0BW
	j/zBejcE/pXoBz6kAPD9CBcgYwmtr1zWS4D6hfwTnXm1JEwpGdytDW18wBmHNsTf
	TsEL+v6l4DOIP9TLROmAf+5sbw2dgxp3KtKobdct0eu3CUOre+WRJbzigE6rse6p
	Y/+EZM7vArPYNfqoAxuf9RPr4tXxw1vQPM/yMLCNO7ZJB6E2sPCbBF15kPXzNlN8
	sfMTt1sb1ytz8BrWFAxDXXnd5IhW2a8XlXzkL+h6iv05YfNnjjcthwiLV7P43O1B
	SigGSE2/Co9d7hj4/gYLzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760578420; x=1760664820; bh=G
	9wLpmKBKcQ6mFF1wzGIX6IX5jCULVRmJYsES+W88XY=; b=iHj4+1GZ/3ZUEOBL8
	DCck1uEqHmve9yCPkpJtX91I82cpCdEqi9+lTplY68B0lPqh4yMYpeGClfJBcKo/
	YLZZmlujVsgGEQuMl/6evHEJOgr1GReKHsIIbSd9/UiNJp1buf8Qul8pwxYvHZt/
	g8xiHULak6LDmn77vvnvL7YaJCwreYHuwtHjIqRwYg6d6RnV/NsSw3A2F+8l+p8+
	nqNyW5HZjnpQtTiFvv8kuCWRnRfvjFzx+RhS5XuplVwoNR8+8YhRCMi+U7IO0xyD
	TXSg5uwBVJhQmpeEHqPDP28q5uBR0L4douuASdRIQS2DL0ojVP6hHixHiRHNKQWT
	5UbCA==
X-ME-Sender: <xms:dEvwaBr2WWTGooGxD8PeH_AQnYd9J3z5ehHM2jjfrDZ5SGzl2nMVJA>
    <xme:dEvwaHVm0vBV_7O-kAeq7j5_rOWRf6donUAm4uicjcjj2AzYyj3mPAVdrqa1kMf_9
    99hkbh3D2t-vO57ZOz6Qc0eLOK5XsIhxI9ZhjCCPKHNUZBc>
X-ME-Received: <xmr:dEvwaIAYQsRm3c7aSzLIZoqlRi94DjJx3D5a3IijoUvG9aesl-SFHS5VqZKvBIYj6bygYdvzEyyt4JmWbBljIg8w8EPuiVSMbPsvpK7WngPy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegleekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:dEvwaD3eFGyrMNrn9jNbT5Ww04C7cecEVBgFk907soZkP006UjFyKw>
    <xmx:dEvwaC09P_Gn2aiM5nERzAR7i-R-D6oGYRwJzGe8lERdaXHaJuMN4g>
    <xmx:dEvwaACZj4Nx0BEamEl_J98dFOGvB2xUYTKlZgDBQXrX-CKsi8KNwA>
    <xmx:dEvwaJ6boiGq6N7k4irDhJe5PVqesHIvBMnTi9DQAoo79DvGBgN1Wg>
    <xmx:dEvwaLKrLmE3BioCqJhgWTS0D_tRf7xke0_24NLxXSehLr1EEH6DtHB_>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 21:33:38 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] nfsd: stop pretending that we cache the SEQUENCE reply.
Date: Thu, 16 Oct 2025 12:31:14 +1100
Message-ID: <20251016013310.2518564-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251016013310.2518564-1-neilb@ownmail.net>
References: <20251016013310.2518564-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

nfsd does not cache the reply to a SEQUENCE.  As the comment above
nfsd4_replay_cache_entry() says:

 * The sequence operation is not cached because we can use the slot and
 * session values.

The comment above nfsd4_cache_this() suggests otherwise.

 * The session reply cache only needs to cache replies that the client
 * actually asked us to.  But it's almost free for us to cache compounds
 * consisting of only a SEQUENCE op, so we may as well cache those too.
 * Also, the protocol doesn't give us a convenient response in the case
 * of a replay of a solo SEQUENCE op that wasn't cached

The code in nfsd4_store_cache_entry() makes it clear that only responses
beyond 'cstate.data_offset' are actually cached, and data_offset is set
at the end of nfsd4_encode_sequence() *after* the sequence response has
been encoded.

This patch simplifies code and removes the confusing comments.

- nfsd4_is_solo_sequence() is discarded as not-useful.
- nfsd4_cache_this() is now trivial so it too is discarded with the
  code placed in-line at the one call-site in nfsd4_store_cache_entry().
- nfsd4_enc_sequence_replay() is open-coded in to
  nfsd4_replay_cache_entry(), and then simplified to (hopefully) make
  the process of replaying a reply clearer.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 57 ++++++++++++++-------------------------------
 fs/nfsd/xdr4.h      | 21 -----------------
 2 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 60451fd98bdf..7bd20c9efd29 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3494,7 +3494,7 @@ nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
 	free_svc_cred(&slot->sl_cred);
 	copy_cred(&slot->sl_cred, &resp->rqstp->rq_cred);
 
-	if (!nfsd4_cache_this(resp)) {
+	if (!(resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)) {
 		slot->sl_flags &= ~NFSD4_SLOT_CACHED;
 		return;
 	}
@@ -3508,41 +3508,6 @@ nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
 	return;
 }
 
-/*
- * Encode the replay sequence operation from the slot values.
- * If cachethis is FALSE encode the uncached rep error on the next
- * operation which sets resp->p and increments resp->opcnt for
- * nfs4svc_encode_compoundres.
- *
- */
-static __be32
-nfsd4_enc_sequence_replay(struct nfsd4_compoundargs *args,
-			  struct nfsd4_compoundres *resp)
-{
-	struct nfsd4_op *op;
-	struct nfsd4_slot *slot = resp->cstate.slot;
-
-	/* Encode the replayed sequence operation */
-	op = &args->ops[resp->opcnt - 1];
-	nfsd4_encode_operation(resp, op);
-
-	if (slot->sl_flags & NFSD4_SLOT_CACHED)
-		return op->status;
-	if (args->opcnt == 1) {
-		/*
-		 * The original operation wasn't a solo sequence--we
-		 * always cache those--so this retry must not match the
-		 * original:
-		 */
-		op->status = nfserr_seq_false_retry;
-	} else {
-		op = &args->ops[resp->opcnt++];
-		op->status = nfserr_retry_uncached_rep;
-		nfsd4_encode_operation(resp, op);
-	}
-	return op->status;
-}
-
 /*
  * The sequence operation is not cached because we can use the slot and
  * session values.
@@ -3551,17 +3516,29 @@ static __be32
 nfsd4_replay_cache_entry(struct nfsd4_compoundres *resp,
 			 struct nfsd4_sequence *seq)
 {
+	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
 	struct nfsd4_slot *slot = resp->cstate.slot;
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
-	__be32 status;
 
 	dprintk("--> %s slot %p\n", __func__, slot);
 
-	status = nfsd4_enc_sequence_replay(resp->rqstp->rq_argp, resp);
-	if (status)
-		return status;
+	/* Always encode the SEQUENCE response. */
+	nfsd4_encode_operation(resp, &args->ops[0]);
+	if (args->opcnt == 1)
+		/* A solo SEQUENCE - nothing was cached */
+		return args->ops[0].status;
+
+	if (!(slot->sl_flags & NFSD4_SLOT_CACHED)) {
+		/* We weren't asked to cache this. */
+		struct nfsd4_op *op;
+		op = &args->ops[resp->opcnt++];
+		op->status = nfserr_retry_uncached_rep;
+		nfsd4_encode_operation(resp, op);
+		return op->status;
+	}
 
+	/* return reply from cache */
 	p = xdr_reserve_space(xdr, slot->sl_datalen);
 	if (!p) {
 		WARN_ON_ONCE(1);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 1ce8e12ae335..ae75846b3cd7 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -924,27 +924,6 @@ struct nfsd4_compoundres {
 	struct nfsd4_compound_state	cstate;
 };
 
-static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
-{
-	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
-	return resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
-}
-
-/*
- * The session reply cache only needs to cache replies that the client
- * actually asked us to.  But it's almost free for us to cache compounds
- * consisting of only a SEQUENCE op, so we may as well cache those too.
- * Also, the protocol doesn't give us a convenient response in the case
- * of a replay of a solo SEQUENCE op that wasn't cached
- * (RETRY_UNCACHED_REP can only be returned in the second op of a
- * compound).
- */
-static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
-{
-	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
-		|| nfsd4_is_solo_sequence(resp);
-}
-
 static inline bool nfsd4_last_compound_op(struct svc_rqst *rqstp)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-- 
2.50.0.107.gf914562f5916.dirty


