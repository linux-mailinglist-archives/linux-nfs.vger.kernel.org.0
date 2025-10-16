Return-Path: <linux-nfs+bounces-15292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AE8BE3CD2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48D81883416
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688582E2EE5;
	Thu, 16 Oct 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRNCWTXq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0C442C
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622606; cv=none; b=hnNJNrZmgi3b8kvEiwqvuFgn1tUXAlV/av9FLkwvthF88EtjJa/dE3ctHxHQ3KKvnTqS8IIdr8AUZG0z3ij6aSGcT8xlODoPVbm9vnHlfNgzMfnFTAwvHntnDZatKy5mB8Wt6yOTQ0X6r6XbcwRO5ztFlx9g2zbP0QJ7VzJlRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622606; c=relaxed/simple;
	bh=t76Of3ecS/+lWA0irLVPCJQWxF0XzgQbj8AyG2wC08o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc2gJLHvMcXxnGO+Pf5/QNl8tvCfioCLz915HNH4xHQNL/AuZdi3a4ZABJ8+FJUT1rEVUdKhm+QxVTsMPzD9NDGv/vgf93uXGYok7XI64CXC1EUNctsRBCdERbi6bKYQXwgpMKJVCCmtTH3ql7ODDvK1BxiiMAnUbahxMo04GYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRNCWTXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AF3C4CEFE;
	Thu, 16 Oct 2025 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622603;
	bh=t76Of3ecS/+lWA0irLVPCJQWxF0XzgQbj8AyG2wC08o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRNCWTXqu+8nQHsPjeVaPZD555vw/HExETh9Cb59Wb6IrQh+TQDOk1I9CFKp9WBIH
	 mAnG6Ml4vLROdCr1sRYJkxJlpDe/r19tbiYV4xUMS6NEFZ4s3Qpo6XdjoyUyjKFwY7
	 QvsVF/GWm6EuWROFo9SQwuX6nwOt+BNmngsSEcretMzj0ezFTZuCxeqIr+0uTSummA
	 F7XGGQCGP4XwFP2Qu0ZJezmB49r+BSuxf6WP6kckkhucv/LZ20GwGiSKMW55vR0KSm
	 rUxWgWMQxJwhbpvsI/g4Hgkofot/dHtFXOAXiVqE8jyjhFXbR8dXkwBaqKFLbNH7PB
	 YN6hv0O9/xLWg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH v5 4/4] nfsd: stop pretending that we cache the SEQUENCE reply.
Date: Thu, 16 Oct 2025 09:49:58 -0400
Message-ID: <20251016134958.14050-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016134958.14050-1-cel@kernel.org>
References: <20251016134958.14050-1-cel@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 58 ++++++++++++++-------------------------------
 fs/nfsd/xdr4.h      | 21 ----------------
 2 files changed, 18 insertions(+), 61 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 28a79d23dd77..8ff7429ba060 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3507,7 +3507,7 @@ nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
 	free_svc_cred(&slot->sl_cred);
 	copy_cred(&slot->sl_cred, &resp->rqstp->rq_cred);
 
-	if (!nfsd4_cache_this(resp)) {
+	if (!(resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)) {
 		slot->sl_flags &= ~NFSD4_SLOT_CACHED;
 		return;
 	}
@@ -3521,41 +3521,6 @@ nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
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
@@ -3564,17 +3529,30 @@ static __be32
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
 
+	if (!(slot->sl_flags & NFSD4_SLOT_CACHED)) {
+		/* We weren't asked to cache this. */
+		struct nfsd4_op *op;
+
+		op = &args->ops[resp->opcnt++];
+		op->status = nfserr_retry_uncached_rep;
+		nfsd4_encode_operation(resp, op);
+		return op->status;
+	}
+
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
2.51.0


