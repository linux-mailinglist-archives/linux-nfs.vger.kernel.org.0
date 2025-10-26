Return-Path: <linux-nfs+bounces-15632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5CC0B5C3
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DE824E61E8
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E52BEFE5;
	Sun, 26 Oct 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="K4s3hDxv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Srf1NDGj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897A2E8DFC
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517640; cv=none; b=K/xkgh93wQ3Ut0Jx4LDN05krQaNJNMcLSTyVGYcIw+TBlVhxAkphbrkOKD8+rjLoXWDpgEdCw1XGsn4I9opOQDJBn3RpOcKtWnm94x9dYffTlbfKSLSMEAo5aK3tjzUdKfAAhR3OugoHjH3QFDZQUVhdtmRfBic2K8kX91P4KH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517640; c=relaxed/simple;
	bh=a1RcaieALaBqRMncS5vtd9PJ1ItBjgfUrBsTBAlNoyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeG5QUbdQSJDF5Y/eWgJ2D2DmZSmQVjqdABcbi0GuV4ite5gDf8WcNNNxL9FHWDouQBn9hVRAkFx3kBCe4AhbSK9mIa63EVUuGaZzkfaRqVty4TqVVGgF8WBq9vfOAkHJckrLL77FpZi6OhWWlpaBKqi2O0xfCkgtOkzFaiZBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=K4s3hDxv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Srf1NDGj; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 472B97A0283;
	Sun, 26 Oct 2025 18:27:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 26 Oct 2025 18:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517637;
	 x=1761604037; bh=SUSe4foexyLvCtipc/VmgXBRzNjiV0mBNlPz9Qwu04M=; b=
	K4s3hDxvxbBIKDYHxdxj88BA/DpzCRL7dwaGWJXGzpArIGfhqd24HyDOXcopNrdI
	wCEfoshbJbt6+ecEtuFZJ+2VnEAFAByvndTEf7BwHU5Tk8euSvZZfK4k73Ve/dR5
	sCgRR3f+GWVQCplWZcc/undLaiOupUmEP+4zKF/CTjQZASUGzHVm2YrrwQ+aD/yK
	WEnQnp4GMG01qlcEa9ZOuxieRGfvXM/t9Yah30bNGV6+BspULwzTUDjSF0nvm2x0
	8UZOgj9WjLZB167JgKvTwjxTEfDi9N0zLUuoOBqhPYL1nTf73xn/YqLul++NXM4T
	B7Q1/qRW6c3Wb8/hsqAxRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517637; x=1761604037; bh=S
	USe4foexyLvCtipc/VmgXBRzNjiV0mBNlPz9Qwu04M=; b=Srf1NDGjL8Lcsawfz
	ZyvipGT4RB1JdLqYRvRlYBGQRc0uyDl14FRqlNQ7b1xIoqMkA8Aj2poJuuBDfuaQ
	BEO6TtrgyEARjZVoinh9a6lDSFBKYnItDsTEfIVcfwmH431suVYRF/x6S0GgJr+y
	jR1hSaFFpZi0QWmD2fEsd7houoHLh9mGAcEnBlSc8AFV9tp49QuB34JmiU9jieHz
	CZhj0xXmu2ROKBRyNmDKEMfXBErdj+e/i76FvNcwvs9nN8bKcwYmuzOR0F2DvXus
	3t34vPss01RvMqjym9RohJJ+IOm1o2EAPBhZfkk6GTr9PMWIfuqXv6KlxvA7IEmD
	myGRA==
X-ME-Sender: <xms:RKD-aIPBsHReufBezrzNka-PnH4lUiNf-6TwciGigntoMc7cca6ZnQ>
    <xme:RKD-aCpYU3PPZwR40jCG-qv5AINXHXuiy1UmhLxO12pCOLDdhYIaKWnE0yrnK8Pu9
    u07U3meEhfIGojW6-8obZH2kZ-rdZxlXvvHxDnUOngZ2CXbRw>
X-ME-Received: <xmr:RKD-aJGgLffxfxp5Jb9DlZq4TH_QKzchNjdPqozYt7uwZQcgBdnmrS1xqyLKkuMh2jpRIB5FMblttbuMg1gmG56MEkLg0yAcmwgbJZZvIwNz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:RKD-aHoTSeQv6fuwVTZN_wy_TSOK8aAt35fNUscjmFfPDv4LeJmwWw>
    <xmx:RKD-aCa2igHgI_qGhTSH1xY5dqe7U5UaMcdWX4qfnE2D-ss48l5VJQ>
    <xmx:RKD-aAXR7bXtI0I1SCEwO_j1yy5vTPK17ytA01DIicrz5NJW0MHCkA>
    <xmx:RKD-aL_zsDRm-i3Moql9LoB3-3HqMtZSAjmq_HZsaPm63Ian71ZASA>
    <xmx:RaD-aFt0pZa3uv-iHY96JG2U7p0ptz4CcoCQDusYAwV1REFGHxO5koKv>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:14 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 01/10] nfsd: fix current-stateid handling after PUTFH etc.
Date: Mon, 27 Oct 2025 09:23:46 +1100
Message-ID: <20251026222655.3617028-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251026222655.3617028-1-neilb@ownmail.net>
References: <20251026222655.3617028-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

According to RFC 8881 section 16.2.3.1.2 the result of a PUTFH op on the
current stateid is that it should be set to the (all zeros) anonymous
stateid, not treated as invalid.

Currently if a request contains a PUTFH followed by a READ request using
the "current stateid" special stateid, it will result in an
invalid-stateid error, where as it should behave the same as if the
anonymous stateid were given to the READ request.

This is easily fixed in clear_current_stateid().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..e1c11996c358 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9091,7 +9091,7 @@ get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 }
 
 static void
-put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
+put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *stateid)
 {
 	if (cstate->minorversion) {
 		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
@@ -9102,7 +9102,7 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 void
 clear_current_stateid(struct nfsd4_compound_state *cstate)
 {
-	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+	put_stateid(cstate, &zero_stateid);
 }
 
 /*
-- 
2.50.0.107.gf914562f5916.dirty


