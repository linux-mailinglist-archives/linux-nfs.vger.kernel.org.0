Return-Path: <linux-nfs+bounces-15259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A71BDBD28
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 01:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B30444E1147
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0C188596;
	Tue, 14 Oct 2025 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="E63cWX4N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="db7KHNp1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7212E7BC0
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760485107; cv=none; b=gMVS2XxqM11uxUCVTKBNNH+KW5nbvE6mxLmGqO6UYZO6piFgxcEIhfI2OcHuQQ0dijn7kT9XkKKpL/UrIu3Z4joXl7PN9zeAMNd41F2Bvj44JC1KmWnnt2fdGqkIvGSlbxthddbRGWJVoLZ46LoWbthPbCUYZQ32hvAWCfhDqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760485107; c=relaxed/simple;
	bh=MvPe+jRQrH7wWc27zqgYHLhgBpE3CZDdcuBsmFo79ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jsw/n5b6ogDbRql5Cmi5vjsa1lF/qMs0Tn71a4gwjKqGTSeFDFBdNl+8EcU2+K0tf+Ruy1uADUmafuBpRM5B4QA7nIVBaVoWOf+cA5OjkrnBnK4TZ4x4LDOltL7rWaQCtayFiCCzbM5G1t2ZsESn5C7Vvdk2+q/t2NZ76nGKBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=E63cWX4N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=db7KHNp1; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95B7B7A01A6;
	Tue, 14 Oct 2025 19:38:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 19:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760485104;
	 x=1760571504; bh=YMWRaJRRTdvjvJqHg87fRHv+kvpIGcHbl60JuNbrYeQ=; b=
	E63cWX4NXZkf9w0T0Q/jMdBum/oZ0sIKAfTrSNCb7ot2eVc95P8mFsLchWlN2RS/
	DACOzQ5ggSaqWp8twsktH3W9of4ItGuBZsLWhWEd7a+m+ib4a6nQoGoX9/+/QUdU
	a5pY7BpVPeJlxxbN6A1ovRn3QIKi0jU7eBBCqJqdBftFvlFN6CG2DSBQ8UM/7DCN
	Fc6wpkpk2jAm1bYMIcXduptGpvcDbTm0LUnD1fIlo193Akx52yqVU/LgjVTkWhxt
	6b7J2TPzK25yCF1IrIfeGpluUtwp3E1xdIrUMBKTKnonR3hrim7ApCIZ8udWY2pR
	JT42Dmow+MXUw/PE/m4sFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760485104; x=1760571504; bh=Y
	MWRaJRRTdvjvJqHg87fRHv+kvpIGcHbl60JuNbrYeQ=; b=db7KHNp1o/hmlE7RN
	m4Wge9NG0eyqfvingluyuKXsQEIwUPnIs9bO+oQonUWFPODqUMdYld8/X5Q4D39s
	wtyGFVHcbHxW4+gjS7Zbh74fqzmubrnurxqflTwXXfakNhfhD+vV/A7hx69HftQC
	y8lC1IfySW9ciaWyfm3CL6xme17Y/tx3Q4pBdoAevDeeBqq7If4cOz+wsu7PZIXi
	qSLOZJrUTml3Vt+9Sd+50koIMLAmeCZ0YBPkWKU3GNhEG53c+412v5CnLO/G20XR
	YJFoi4v1qn3Eh7qUFdCPabiHXn4aXlrR402s5scYB4x7luWvlryfRWt41XLmSIfD
	I2r8g==
X-ME-Sender: <xms:8N7uaC8_FVP4j0YzvuyyITqYIsLorYaXTcQGrld3gSUTviKo4tJkOg>
    <xme:8N7uaGZilW8GJsvcRwxNZ9hwrm1mM9BHBK5810mouUEA42QEcTH2g0XygeqppYxEy
    -g2mdiGEO2WG_YnzCtmhTO6JvBA4yXGYjGPwnn8D4BpFNBfbY8>
X-ME-Received: <xmr:8N7uaB3kzSuZg8Pl4DBkRtGSbIdS5sD82-oDD6FZldVqkeCQ2MQF2TBM_BcaOGIIcBGTtXK4OC4LHrYYJ9ddUNALJbVT9c2a-UPqPaWSJsbX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddukeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8N7uaBaeRfZjm1vr5ixyeiCiEgDfy7AZOxiGO2iyUVkMCqSRsJhJmA>
    <xmx:8N7uaJLiaZ5CZzHbdFubkzwApGXjzyM1FryqhK0CnVr8Wzwpb3RiXg>
    <xmx:8N7uaAHDbJ7rAJfUFU2b8ZRCbfCQiPn0jqXTGX_GajspQquY2r5l6A>
    <xmx:8N7uaAtkdtyARCNMGSB_m5dVHKyopzzO48c0G-F24Z2qamfxdVWDfA>
    <xmx:8N7uaAdBQ8-1-gp5MmuaQh7aLqvZ7T8CwVBj1UKK0x0AwwHETw4ueDfN>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 19:38:22 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] nfsd: stop pretending that we cache the SEQUENCE reply.
Date: Wed, 15 Oct 2025 10:34:35 +1100
Message-ID: <20251014233659.1980566-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251014233659.1980566-1-neilb@ownmail.net>
References: <20251014233659.1980566-1-neilb@ownmail.net>
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
nfsd4_replay_cache_entry() say:

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
- nfsd4_replay_cache_entry(), and then simplified to (hopefully) make
  the process of replaying a reply clearer.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 57 ++++++++++++++-------------------------------
 fs/nfsd/xdr4.h      | 21 -----------------
 2 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 631147790d5e..4816859d304f 100644
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


