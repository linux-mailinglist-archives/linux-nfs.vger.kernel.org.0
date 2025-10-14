Return-Path: <linux-nfs+bounces-15209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B920BD6D3E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 02:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00C5734EBE5
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 00:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7F2F5B;
	Tue, 14 Oct 2025 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GagSMJ6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="soiEFws8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1776FC5
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400372; cv=none; b=Nq4hPntLp+dPKQm+DSgWmLQmL+VSngTrEn/dlSrTJeuy1ilX943y3Kfvv6NkIMThc6RYhRN+yrwLGQLV3Wlm0SaB8V8dZCzWNKhy101bZDv3NSinRtrJLXbSLzG3X33PBEfljIE/KrdIwHbFOQC0zTId9hbEb3mkTlL2iOKHlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400372; c=relaxed/simple;
	bh=fJyOqLrAHfk9x7ryofO1u0dQdFrPGgOk8Lp9+4RZhys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWzYxqrylVd1BxY6G8QQtTs4ipRNd8GxOzeJRU+S94AwR7TzK5rWzqvkHi5q6CJnONvhptiPOl2Ytj4xU+atDyyWSy3iVKC0qQr1DZ45IPjSth/i6JcbQ6gkGWmz0x/s7uRR4Btp3EFpP/SKTePdiRHMFtY3hEDLH6VuBE+Ub0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GagSMJ6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=soiEFws8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EBC551D0013A;
	Mon, 13 Oct 2025 20:06:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 13 Oct 2025 20:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760400366;
	 x=1760486766; bh=YxJoTq6Ha7Z7WWxXDLDaGGk879UiEo9Dk9ip0sB/8O4=; b=
	GagSMJ6qgus32TbEYY0UZqhd0raqJdnL35eYusKvOGb8mHAj+vBi+UrCmJ8LPUA8
	m82uwkFpsNec4mZx/2kvGjnLUX5vqHRflTE6ItpgoHfnGI3BoP9+xJ8MuWFtGeWw
	1kG2h/xzaihEwZFYbyieTnOndujumzjAX5xmXXnTaUuRY5K0Dg7JKQzSRHVWC/nx
	6YG8ZpKKo39CRHmD5j5CrdgczcTnx8tAQ9N59pI/ElnqGlva2gJZ+wB/B8U4ir1O
	cHC8ykK8vrmDLaKI+CFOMD+0ynfyWN0rfirfz8zvvuoIcrHcSiemhSKjHlSwbu21
	VnE6b2uCHQQkTWw7tbxj1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760400366; x=1760486766; bh=Y
	xJoTq6Ha7Z7WWxXDLDaGGk879UiEo9Dk9ip0sB/8O4=; b=soiEFws8IAJGNVC1+
	8o+1oPEAsy0lskKQOKoIPwRTI/CPpYBIaztMZBMSiF61qYdiKLGC2H/PhVqgosPc
	DrNH4Xm7C6EQtPhVBK/Vr3WhlPj/f+NP5fQc82Q6o0v8KFYPLCXK72Im5XbTCxUl
	9wNIsPPpS0KC2XSx2O3CI28gevwxlnIiFTC9kaicQkOxupN4Fx9qTBPphy/TwsGr
	ooYuoEdlK8PjTqXGZrTHUs7Lkq7iX9iyoSGLWrnVMcWfaw5fckZoXsYxqqXdA0vO
	8ExNmY9/YkKojzNfROXhdWrADHVQ7ucHpoCRjaw6XmDlSOWu4okBfr0ZNwBG0j0r
	44HoQ==
X-ME-Sender: <xms:7pPtaCkXOMQP8KBJZHS34o-Ze5atKa3YC5b8fhr66IEKLHXR6qi5Ow>
    <xme:7pPtaNjz7c95AgCqBBEqfYslE2am-QMeKHpOT9Ho1evqt18D2pEaYEUx277XhyWA8
    YeRhcxVmxWBZ9IqGvlCdzfjb8v2PszOa6Dg_ASzHv0BW7uDdA>
X-ME-Received: <xmr:7pPtaKc9SLV8C4z3foYkW_YHjZ4C3KFy4uvTf0ynv8MoFw2rkgHeYkckdPxrUwfNR7RZoe4Ky-IJ6NCmX3pI27fLWyE5xEr2NQ2s47IEjaMS>
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
X-ME-Proxy: <xmx:7pPtaNi5B6NyUVL0IRJ19cxine55xPSPKyZGgkFWDvqaNQ-RiDaBTw>
    <xmx:7pPtaCwA2GQO_w9MjtnJ7As3OC7kJAAkWhbuqXLEr_XLCRJLGuGkWQ>
    <xmx:7pPtaJO539-4sV1dQohtxew4fCEBGi6RoX5J-kHeql8FmYXqhvHRdQ>
    <xmx:7pPtaDWMiO6QBAtPnDswj2I6kyrwBGgpDLPVHn_kYm4XJk564510kA>
    <xmx:7pPtaIEVLG-F6qTmmOv9ewrPl15YXA4msykKY6QOA8HoNAXDK7UTNIuo>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 20:06:04 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: stop pretending that we cache the SEQUENCE reply.
Date: Tue, 14 Oct 2025 11:04:42 +1100
Message-ID: <20251014000544.1567520-3-neilb@ownmail.net>
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

nfsd does not cache the reply to a SEQUENCE.  When replayed, the
SEQUENCE op itself is replay.

So removing the code and comments which seem to imply that we do, and
detect the case of a SOLO sequence to avoid looking a the cache.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c |  7 ++-----
 fs/nfsd/xdr4.h      | 20 ++++++--------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1c01836e8507..b51a37ad70aa 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3530,11 +3530,8 @@ nfsd4_enc_sequence_replay(struct nfsd4_compoundargs *args,
 		return op->status;
 	if (args->opcnt == 1) {
 		/*
-		 * The original operation wasn't a solo sequence--we
-		 * always cache those--so this retry must not match the
-		 * original:
+		 * We will simply replay the SEQUENCE.
 		 */
-		op->status = nfserr_seq_false_retry;
 	} else {
 		op = &args->ops[resp->opcnt++];
 		op->status = nfserr_retry_uncached_rep;
@@ -3559,7 +3556,7 @@ nfsd4_replay_cache_entry(struct nfsd4_compoundres *resp,
 	dprintk("--> %s slot %p\n", __func__, slot);
 
 	status = nfsd4_enc_sequence_replay(resp->rqstp->rq_argp, resp);
-	if (status)
+	if (status || !slot->sl_datalen)
 		return status;
 
 	p = xdr_reserve_space(xdr, slot->sl_datalen);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ee0570cbdd9e..390bfb0ba13f 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -923,25 +923,17 @@ struct nfsd4_compoundres {
 	struct nfsd4_compound_state	cstate;
 };
 
-static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
-{
-	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
-	return resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
-}
-
 /*
  * The session reply cache only needs to cache replies that the client
- * actually asked us to.  But it's almost free for us to cache compounds
- * consisting of only a SEQUENCE op, so we may as well cache those too.
- * Also, the protocol doesn't give us a convenient response in the case
- * of a replay of a solo SEQUENCE op that wasn't cached
- * (RETRY_UNCACHED_REP can only be returned in the second op of a
- * compound).
+ * actually asked us to.
+ * This doesn't apply to SEQUENCE.  We must always record in the slot
+ * that we have received a SEQUENCE, and must always respond
+ * successfully to a replayed successful SEQUENCE - that is handled
+ * separately from the sl_data cache.
  */
 static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
 {
-	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
-		|| nfsd4_is_solo_sequence(resp);
+	return resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS;
 }
 
 static inline bool nfsd4_last_compound_op(struct svc_rqst *rqstp)
-- 
2.50.0.107.gf914562f5916.dirty


