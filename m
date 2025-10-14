Return-Path: <linux-nfs+bounces-15208-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A85BD6D39
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 02:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DE518A5A17
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 00:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2538F6FC5;
	Tue, 14 Oct 2025 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="o5klApNG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SC/c7yGh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFA33985
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400365; cv=none; b=W+sSTm1dogzU5OIf+3Ow6hNMhzIr++B3ZWHGBBay2nTWrxf+WAU+D1lohoWYpqWU7xC4xrJGOcW9rDN4xP2if2MkB2xfxdP6t2xnFmfEps7sfhDsW/i1kjdL/kEZzMvk1eytZDvVgkRQjMklLDsFHEA+QQeIYs/XWU1rU4qGTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400365; c=relaxed/simple;
	bh=azBC1sBxmUlDRbjX6Q5FS7gLkS5PIK7QyoWGEKnQ0Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtLj5hmJhu4wmwbt4D9t+3VmM+gGxuj1VsT2vTacJ7B+sVJU81vPI6daP1NQ1AKcqzHv6HnAWONrwaVTisxMeJBSIFyPrdPGQLFQcZ0zAo5VvMHRGWE1aywPrBcH79/DkfxVhvKlrMv8Uo+E1TDHuD13tduaoZXYD/K4ARTCr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=o5klApNG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SC/c7yGh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 374041D00133;
	Mon, 13 Oct 2025 20:06:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Oct 2025 20:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760400362;
	 x=1760486762; bh=6aQreBuZ+0b8Twi4QfxdkRqo/PbWBGGQo/yVhpfidv8=; b=
	o5klApNGjBD9U6JfA6hgGzSDBXJrhDRWRRwJJ6xW7ViP/7jbFr53YzQ14ej7LTIx
	IN7U+Gi5xz1rkjdqYt57SoUCzhQ1ndngdzw1ARhmlicXQ72HL1/ziEOqd981mNKl
	gmDrLhB7ipW20vRjT3yQwBrV9U+K1OfulNJAha5rnaOFcMZj44G25v2Zt9y6ylCM
	aUqvjri8TLeHqUR62TcdPcy9SK6nyq3k92T5qTQpTHCx3JVC8l9N5DaoxQ9gCKGY
	70DiWGGOJXCr+vaaIthXApoYf2pXMmcizdIQ/YxmxCsvTGnwEMxcQ4pPBQ7/Fga+
	Da5XSjBKkStRg9FCBpKz8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760400362; x=1760486762; bh=6
	aQreBuZ+0b8Twi4QfxdkRqo/PbWBGGQo/yVhpfidv8=; b=SC/c7yGh+zwe7Yxlt
	8AtjMTK8nhBomFnK+5cUZ0V2FV+KGDGzcaJemQfTKPlOh8Tc8DYo4WaTFB7NaLvR
	11J5o4wk42MzeDobgFVf0QTYLfMQJleQbdV1CxjWRTwy3AvD75ReDUtcJ0UDnD2w
	pMHp1pM+NJmsclKIaBGsT9g0iEa/w37y4rX3ZRgUsYPLJs9T+THdJHUHrCKQ049Z
	MVMmCuXygzyeRIEJsNhKT1ja1sYX4+eP1nN0xb/I6bJAhDYWdn4gOBBEKCaRvz5c
	fu/nev7yVQl7hvHhf74YwvSxU1EPXx/s5i2klTQR7PjEEURMrzWJx0Nhwy+s9iQI
	NvVpw==
X-ME-Sender: <xms:6ZPtaJNMJsuxpnpY8atnzGEcNbxKcPA7Ax51zhGirPVccxRqSOenYg>
    <xme:6ZPtaPrtD_E-F1WScMGxcGNGyiHoyetiWMsRgDpDVkNkQ2fbOTpFR4brYe41h7N9s
    d9sCDsSwK4i_1yIuf3OTOTbJ0_5VoNcKW765be5mhfgNi0a0iA>
X-ME-Received: <xmr:6ZPtaCFK0mqO9VwQihLivAHyO_77NiBZ6iFJzyhr19diCP0wOZ8Q1nc9HNk3wLOrkDWfxkabXR5u4apCU8-OelsA9-QM8JiH4OkX59K34L18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeltdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:6ZPtaMqlfEIQ4OmC2dplu2gQ8pQSmMoD0iFgBRyhBD1BpZ9TTSZHQQ>
    <xmx:6ZPtaDbis7RbSi-Js-9NsB4mBzM8zvuQRp6ravPPOBywUJg5v9_95w>
    <xmx:6ZPtaNXzy3oJesbW1I1K6qrdWXaTV23cGZqVSaf4AyTjrmul85oijA>
    <xmx:6ZPtaE-mTBJ5GHAgxi2gQEFeBBr1U88v-SkXd2NyanKY9I3etPLHCg>
    <xmx:6pPtaGtzQe6MmaDSqyFhHpFREOiMsi0sNybN2QiSUg3ik8RLQyyxkOnI>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 20:05:59 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
Date: Tue, 14 Oct 2025 11:04:41 +1100
Message-ID: <20251014000544.1567520-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251014000544.1567520-1-neilb@ownmail.net>
References: <20251014000544.1567520-1-neilb@ownmail.net>
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
ops after the SEQUENCE are replay from the cache in ->sl_data.

However it does this in nfsd4_replay_cache_entry() which is called
*before* nfsd4_sequence() has filled in reply fields.

This means that in the replayed SEQUENCE reply:
 maxslots will be whatever the client sent
 target_maxslots will be -1 (assuming init to zero, and
      nfsd4_encode_sequence() subtracts 1)
 status_flags will be zero

which might mislead the client.

This patch moves the setup of the reply to *before*
nfsd4_replay_cache_entry() is called.  Only one of the updated fields is
used after this point - maxslots.  So that field is copied to
client_maxslots so that can be used as needed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f..1c01836e8507 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4360,6 +4360,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client *clp;
 	struct nfsd4_slot *slot;
 	struct nfsd4_conn *conn;
+	u32 client_maxslots;
 	__be32 status;
 	int buflen;
 	struct net *net = SVC_NET(rqstp);
@@ -4398,6 +4399,27 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
+
+	/* prepare reply so that it is ready for nfsd4_replay_cache_entry() */
+	client_maxslots = seq->maxslots;
+	seq->maxslots = max(session->se_target_maxslots, client_maxslots);
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
+
 	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
 	if (status == nfserr_replay_cache) {
 		status = nfserr_seq_misordered;
@@ -4425,7 +4447,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
 	    slot->sl_generation == session->se_slot_gen &&
-	    seq->maxslots <= session->se_target_maxslots)
+	    client_maxslots <= session->se_target_maxslots)
 		/* Client acknowledged our reduce maxreqs */
 		free_session_slots(session, session->se_target_maxslots);
 
@@ -4495,23 +4517,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
-- 
2.50.0.107.gf914562f5916.dirty


