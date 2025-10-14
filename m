Return-Path: <linux-nfs+bounces-15258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13518BDBD25
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 01:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E898D4E5591
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 23:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF82E5B11;
	Tue, 14 Oct 2025 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TRti4Xtx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQ9amy4Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A85188596
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 23:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760485100; cv=none; b=WJubLecaC+ESHE9FYtkqVFZyCEEqIlMC5bMW3wJht1cwHn+I2+HmZPaKsuQd6q02YFYkV76f0RisZzCM5KsfYVxHQavxDPWxNvC/7OVUBwr2ltyriCZnYBwZmnMIqSx3Y4dTRDLIIuV2gz2PB9BJ13YJ8+n6iVj/mhDz/LKR1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760485100; c=relaxed/simple;
	bh=TnlVVWuIyo46wm6AM54c0GDzlo3PnWxrb/5FqR6rda8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHjO50ni7InEnf1O7MNsArHLUX0o2LOarpkFnle0S64qeuo9iN+063y78eE3yiN41cp9XGKaiJUE3r0FtOVyL2R5d34in7lxU9TIBL1hKOFh8uVsWXpIDETEqPDeobqMC8VMQSOggW/SIqetOQiCf0vNuLXGGn9Yqa1uF6cUq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TRti4Xtx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQ9amy4Y; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAA6E7A01A6;
	Tue, 14 Oct 2025 19:38:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 19:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760485097;
	 x=1760571497; bh=hwXul+31vAbCepyHrcGXSrABgKe5EE7sVxEVzVqc+KA=; b=
	TRti4XtxMAwuU+z6XKD1jZCieXJ5POq5t31mw1G6pSAtJcVriDHab68nPYmaGsDB
	GajN+webzjwrKL4GrzMv+59FO9x+nezmYCrpzUuC9/jp9Q1Jh7Nqm6qdB39cRMD4
	ZYpLMs9hNXWbDKN9FCKr8U53UYVCf7Th4RoJkgTtpA01WiHeq2yPWu9LpQJemoj1
	pSZUsEmap8NME8ikXN1vLZMS9bbtxxLirX31lDRRffWuZj7WNdq3UIQiA88gVSRs
	FmcA1zIkCy4z6rkBKjBT0Mld3ThvtxymI4gGTo2wLW0+1KBUSsJrkymG60wH2j22
	9iQF16CtHmdq7gOT7Oy4ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760485097; x=1760571497; bh=h
	wXul+31vAbCepyHrcGXSrABgKe5EE7sVxEVzVqc+KA=; b=PQ9amy4Yjv/KzqjqY
	ZaEwutOp6KM6sJFhuRrOUh6yjSfaJJI7D1u/tAS9KDS7oBaLs4QzObJixOVa5Fma
	qa9vrq8xOcsPBpWpEfMkquS8YeVCAjOmRSf4K+xsSZXTxmZgtM5J6+mDpxERQhn5
	GZ/gkR5JyogrEgWnffp6Q06ZKaOGjQu3cR9MsHTJ5FkzXgZpEBcwnMlRd3cD/WYw
	R6gNGOMXsXs/9gmY3NBhcQfjU14uZEPDN0HB5bj9P+Npcu5p0hbZn/7wTSVpVU5M
	p8n9+GGZiJuBGo/FKmCRjRoZ5MVwJmGtKRS2raiSi+LGXBBOGFch/4HF+MjLtAQn
	oFH4g==
X-ME-Sender: <xms:6d7uaEQOPmDVZjNcuhMAtYbXESLg6VJHw8sgZVwaMseNUjXBLoAfSw>
    <xme:6d7uaFdsXtH4kFhNZHwXjpBYrzGIvCCtH7uttKbSaCIniqCnVc4XiL7iYz49y4Fr5
    nEzIUPNO9oafXu_mMX97901p0Wkcad3gR0uDPsWan5oXMeh>
X-ME-Received: <xmr:6d7uaLqlgZUZ2Q2wUagookYeY5rDGq_rpqS7np-Fwoi0bCK57bkZSU3NXtZK8d9uZEUrBG4cE1gVl_Wo8lgJ5dzgZWSEx29rFgOfBy84ZOTL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfevjeduvdeufeeileefteegudetheetffdtjeegvdfgtdetjeeihfeigeffffehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6d7uaO8bfhp7UriWqL3YsLtpEWMG8qSKo9NhCQdZY5EoXkUrpWtI8g>
    <xmx:6d7uaPdtlP2HhBYNd1cj8UnaafPhDaOPk4qtCEb8g08Ix8CyQExQjA>
    <xmx:6d7uaALb4nNwzyY33ctEvf_V_gUYCu3U6dCSImHsrWHtK9zErzmtCQ>
    <xmx:6d7uaHiCO9gYxPygxyP9lvHOpS2zWErdCVDU9afIkewYIPdkXGwLQA>
    <xmx:6d7uaFzcqFPVGoM1pNmiu9iQROh1d6NNjSqgrA241qvChRlmBxeOtdrO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 19:38:15 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
Date: Wed, 15 Oct 2025 10:34:34 +1100
Message-ID: <20251014233659.1980566-2-neilb@ownmail.net>
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

nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
new SEQUENCE reply when replaying a request from the slot cache - only
ops after the SEQUENCE are replayed from the cache in ->sl_data.

However it does this in nfsd4_replay_cache_entry() which is called
*before* nfsd4_sequence() has filled in reply fields.

This means that in the replayed SEQUENCE reply:
 maxslots will be whatever the client sent
 target_maxslots will be -1 (assuming init to zero, and
      nfsd4_encode_sequence() subtracts 1)
 status_flags will be zero

The incorrect maxslots value, in particular, can cause the client to
think the slot table has been reduced in size so it can discard its
knowledge of current sequence number of the later slots, though the
server has not discarded those slots.  When the client later wants to
use a later slot, it can get NFS4ERR_SEQ_MISORDERED from the server.

This patch moves the setup of the reply into a new helper function and
call it *before* nfsd4_replay_cache_entry() is called.  Only one of the
updated fields was used after this point - maxslots.  So the
nfsd4_sequence struct has been extended to have separate maxslots for
the request and the response.

Closes: https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@redhat.com/
Reported-and-tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 51 ++++++++++++++++++++++++++++++---------------
 fs/nfsd/xdr4.h      |  3 ++-
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f..631147790d5e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4349,6 +4349,37 @@ static bool replay_matches_cache(struct svc_rqst *rqstp,
 	return true;
 }
 
+static void nfsd4_construct_sequence_response(struct nfsd4_session *session,
+					      struct nfsd4_sequence *seq)
+{
+	/*
+	 * Note that the response is constructed here both for the case
+	 * of a new SEQUENCE request and for a replayed SEQUENCE request.
+	 * We do not cache SEQUENCE responses as SEQUENCE is idempotent.
+	 */
+
+	struct nfs4_client *clp = session->se_client;
+
+	seq->maxslots_response = max(session->se_target_maxslots,
+				     seq->maxslots);
+	seq->target_maxslots = session->se_target_maxslots;
+
+	switch (clp->cl_cb_state) {
+	case NFSD4_CB_DOWN:
+		seq->status_flags = SEQ4_STATUS_CB_PATH_DOWN;
+		break;
+	case NFSD4_CB_FAULT:
+		seq->status_flags = SEQ4_STATUS_BACKCHANNEL_FAULT;
+		break;
+	default:
+		seq->status_flags = 0;
+	}
+	if (!list_empty(&clp->cl_revoked))
+		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	if (atomic_read(&clp->cl_admin_revoked))
+		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
+}
+
 __be32
 nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -4398,6 +4429,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
+
+	nfsd4_construct_sequence_response(session, seq);
+
 	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
 	if (status == nfserr_replay_cache) {
 		status = nfserr_seq_misordered;
@@ -4495,23 +4529,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 out:
-	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
-	seq->target_maxslots = session->se_target_maxslots;
-
-	switch (clp->cl_cb_state) {
-	case NFSD4_CB_DOWN:
-		seq->status_flags = SEQ4_STATUS_CB_PATH_DOWN;
-		break;
-	case NFSD4_CB_FAULT:
-		seq->status_flags = SEQ4_STATUS_BACKCHANNEL_FAULT;
-		break;
-	default:
-		seq->status_flags = 0;
-	}
-	if (!list_empty(&clp->cl_revoked))
-		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
-	if (atomic_read(&clp->cl_admin_revoked))
-		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 	trace_nfsd_seq4_status(rqstp, seq);
 out_no_session:
 	if (conn)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ee0570cbdd9e..1ce8e12ae335 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -574,8 +574,9 @@ struct nfsd4_sequence {
 	struct nfs4_sessionid	sessionid;		/* request/response */
 	u32			seqid;			/* request/response */
 	u32			slotid;			/* request/response */
-	u32			maxslots;		/* request/response */
+	u32			maxslots;		/* request */
 	u32			cachethis;		/* request */
+	u32			maxslots_response;	/* response */
 	u32			target_maxslots;	/* response */
 	u32			status_flags;		/* response */
 };
-- 
2.50.0.107.gf914562f5916.dirty


