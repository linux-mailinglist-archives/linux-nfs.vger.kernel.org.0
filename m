Return-Path: <linux-nfs+bounces-15282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C4BE12C6
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 03:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39B4834F4E3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 01:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4381134BD;
	Thu, 16 Oct 2025 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="x/WCmRvf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PP12dW4b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C44A21
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578419; cv=none; b=jXBYiNcS3cxrKXeJ1SyabFBQb3xTgYO+qfGeOsXPc/m8Ocd0v3SNbFI9VGzjKzH4Q7bl4/O1Oomb2UM/hFK4D+eOv9KT8QNQ+momaK7WNgrfLAgfaiztcSlWV1UXnaMst844oAemscDnGj2NhI5VEEnI6bk9RGXO6YcABHJOiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578419; c=relaxed/simple;
	bh=1Mn1ydfSSvoj70MCO63SnogJQcOBeZMG6D2S1bTiq6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amhU3OE0FQgla73sBD88TTvclzIRJAoup1i4peH8a97Fqm0jzMokZi//gkSG+GFBNDxX0fbN/tkWOxVZanU3Dx6YViM4gQ+WM6ovVvP8oFdNc6CsG2S48in2diD4M5c5osmnURfJirBbWFZcx1t4dG3QFBaQ/oiaS/FTBqMiTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=x/WCmRvf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PP12dW4b; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 601217A0132;
	Wed, 15 Oct 2025 21:33:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 15 Oct 2025 21:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760578416;
	 x=1760664816; bh=4srOJEyywli8lCpl1UgzH7BFAzt+bgbkU0ISPh95Pwk=; b=
	x/WCmRvfxK1OGuzxKeyZ8riJU5B39r0o1yxdt842MfD2IKWYbPG8PH6ndKFxTi4w
	MeXAlEo7UedcVKRG1g4kQCHPAVoD5e4Vw1gyG4Z3UHdqk/roMezxAmPytZ2DxSL9
	XST0aomxX5a77/LMMkHOSGRKZsma01xtVctrlpvR951hgiKJ8CY7rUlNc1zohX5t
	dxQ99bGUID7KCmb1bm5i9mdFZIjxDYJRk1Dc3em4LqLlLOe6jTn5bzz59EOAa2NW
	d57362P9/UEnwnWMvYkjgQ3ogMg4MMBnwFcqjb3P3oMlkOTDpv4ah7K6eMIO0oyW
	xKnYTH7rOUsu6+E186HLEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760578416; x=1760664816; bh=4
	srOJEyywli8lCpl1UgzH7BFAzt+bgbkU0ISPh95Pwk=; b=PP12dW4b+H1HBg8WL
	/K5vj/imrKcHIkNKC8e0NVBtEGynD9MQrSZfd8wQ8SdlRLhyoL6QXgSSA4SnnIIH
	rDV4lp0wmjNBs/L10YIk0TsKurbNc+fw1frILf+ZQKWTcFYluxqFcR9NIgrxmY95
	Yuap/t+aM1BBANYCjz1KbJjRxHlL9XwOxNZStGifDLCRt7IZcanV/vGDyZN+u6rB
	GOZ2G4pKF5CjYVKwlVJ7gVRcj1I40hJEbtRFeuMHO6mZzUtc4yYIotoMhdYU13T9
	10aqce/NpkU5llXyDfFoF5W5omeBkbReCzvJhVnqM8BZWwpqRpjS0bGfqYgMP2b8
	UU9Og==
X-ME-Sender: <xms:b0vwaHyxRzWRGLq95I73XpOPtnrD16zhnBrSjcM5ZLL7bRd5WrJQ1g>
    <xme:b0vwaC87vTb_PNUh_I6DHSJocr1I1NIbkbjwlMm-V04UpMBZf2D-2zPpELOnbVbrL
    QnjH3IPzXwTUc6Fj384YwlwyW3mOdL9W3YeExyPz2Mfcui7ow>
X-ME-Received: <xmr:b0vwaLLH1esht_ApYbqOyM_XpuBw_M2w8ln5WwQC8v3M-SPruNRW10Zx-yTRl7XFZsuRn2pejktnz7PllAUOcfqMAHa9LGB6OeRAfyUrvuVz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegleekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:b0vwaIdiddPAPkNa2VPY7AtbSl_bxetXMzkxdbPqCQa79UBxUqjqZQ>
    <xmx:b0vwaK8MaswP7PYEcsDwhvZZwEbJJo4QpTLJFH2fv6ziINOR9u9AAg>
    <xmx:b0vwaFq_EFNCXNUw7QtaPZyyxIBNJu2xKQ-1Pr-9hzq0i8Xn-2XZRg>
    <xmx:b0vwaPDLDOueL6y1OU7s-lhUjX6cm_3WxVhgowuDfsmvrEeNonlkAQ>
    <xmx:cEvwaJS1sSHN7OneEa8wQ3yryARi9roxSFTwwOhllzuRsoKaAXMONXh8>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 21:33:33 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
Date: Thu, 16 Oct 2025 12:31:13 +1100
Message-ID: <20251016013310.2518564-2-neilb@ownmail.net>
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

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Closes: https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@redhat.com/
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 50 ++++++++++++++++++++++++++++++---------------
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/xdr4.h      |  3 ++-
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f..60451fd98bdf 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4349,6 +4349,36 @@ static bool replay_matches_cache(struct svc_rqst *rqstp,
 	return true;
 }
 
+/*
+ * Note that the response is constructed here both for the case
+ * of a new SEQUENCE request and for a replayed SEQUENCE request.
+ * We do not cache SEQUENCE responses as SEQUENCE is idempotent.
+ */
+static void nfsd4_construct_sequence_response(struct nfsd4_session *session,
+					      struct nfsd4_sequence *seq)
+{
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
@@ -4398,6 +4428,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
+
+	nfsd4_construct_sequence_response(session, seq);
+
 	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
 	if (status == nfserr_replay_cache) {
 		status = nfserr_seq_misordered;
@@ -4495,23 +4528,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 230bf53e39f7..6135b896b3fe 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5085,7 +5085,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 		return nfserr;
 	/* Note slotid's are numbered from zero: */
 	/* sr_highest_slotid */
-	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots_response - 1);
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_target_highest_slotid */
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


