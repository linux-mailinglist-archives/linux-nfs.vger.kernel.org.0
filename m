Return-Path: <linux-nfs+bounces-17088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5680CBC050
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Dec 2025 22:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 602FC30081A1
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Dec 2025 21:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EB18634F;
	Sun, 14 Dec 2025 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TBKfQCJG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wl3Ue85i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865AA226CF9
	for <linux-nfs@vger.kernel.org>; Sun, 14 Dec 2025 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765746458; cv=none; b=tk6cviKurdpBv0/hv1+xmGE8hjQ3Jj2jArXUDpK2FYzIpSt1+pL4bPz+eSMYue00qW7/kCV74KNl1lohl9jQpe4X5y+xAq8vCC4nOTfPT3Gjb2V3fcXoUZLHDAdiiBz3niIWA6aD3AzE1AMnmAz8AjTKdDVfAJjNIEnLaL756ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765746458; c=relaxed/simple;
	bh=TPMWd2+A8XiVWqHdmjMgGC6ucSU9wwAoSbEUIma7Njw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=SC3F5Ix1WJfqAC5zi4N5ia7h1KsWsSaR1taSwCjENjG3CENgvdlsE/B4OGvUwV1fPTVyvWrD2rZhRZY4Crug0/pMlfSXoJGz1k4J77F49dsIeafVb8EA82piAlnaRj7kLxJ/319X1mI7/cGbN9HjtOBlIlpA5Uv7LsmfvMMX2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TBKfQCJG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wl3Ue85i; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A166EC01E3;
	Sun, 14 Dec 2025 16:07:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 14 Dec 2025 16:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1765746454; x=
	1765832854; bh=xGM2RmEyZa2Z+r7kSzlCvFJiqn8V+NA6CgnXaEgdqQA=; b=T
	BKfQCJGdbHvLJ95CSacZOk9Td9CLJ1BsJwgJ91qon1MoTy+VlEJtcD2lZbr/Q2ix
	+bQLskiqX+5x7phcDW2AVVw8Q89MODTlOrPacFZzz9KR4gJMHWt56h8Qqp2qjalX
	v7oTYvTjnb0j7Zk1/LkPg3cnmoBKFyrCqO5cPQSmnEPYfDAoOWOoeoD8n2d2MzT1
	KaXhM6C+npCGw3edV4lm3vfRMK31Zf8y6OUU5vwPJfpW0GKmPWR+jBTY2wIPz2EN
	Jy7jrge1L1/MnIs7lsDTUiEPIDKol8JifY6YNA35TqZh0miKywchG8AfXHRnF4pP
	zt6oGpZrK3/MsCLLjTALg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1765746454; x=1765832854; bh=xGM2RmEyZa2Z+
	r7kSzlCvFJiqn8V+NA6CgnXaEgdqQA=; b=wl3Ue85ilCUHWAzW6aWWy28rze91A
	LmYZbfbtasfznorwoyFz9x9iGK1yxluDhj8xj7MT3Zz7iH41Tr9rd2PHv/Ae0xNo
	95XPgD5lEtjG/mjwuU1ZhPo/FAfAXCXb+dJa2nvJn1/hgdn+nYg547b2ykT92m9P
	il4h97BpXkMNV6Zdezff2v1HcSNAxo9yGvdH/SOtfNde1o2WaJn72GZKX0p00/JO
	KqJ06b1KjAyin0fM7azb36Ru5Y+lDfZuBYrvFwea8LIeWiAoAxcQar/dqRodzyKo
	m+Dnb1t5sQVVjmiyu572gwODIPNkShFxCgisEWYfpaj4ZIq37yhce0nPA==
X-ME-Sender: <xms:Fic_aX-HMntORbWPXcuiQ87lGKQidJ-Dh6sga4fbN0cHVKD3lS_7Uw>
    <xme:Fic_aXYMxdwyE7VJYzydo_wfsX0KgtEne7yDG1WCEUMI_tqggKryefwoacVB4qwps
    xMvvxG09f4x5PC7otNbKhD-cRlJ1Mjsjj5bZiofwunZAxB1>
X-ME-Received: <xmr:Fic_ae2soyIrfoEgK7R6fkTfJuoWaJfVceOGdGaLPeHDdGSu5e20aB2Qh7Bvk5bhH9cBL3AS_k_-oo8zjbKRQV7JYXr4tBav3R_Dg-_flfqj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefufffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehrohif
    nhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeffhe
    efteettdeiteeutdegveffhffftdehleelffffueejvdelvefgvdfgleelueenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofi
    hnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghv
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgt
    phhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Fic_aab-dqEBE_HxqEF-K8h_v6YY1oV4VJHqTrdTG-uOEBG2zQocww>
    <xmx:Fic_aeJf8cMkB4Rq-j92F1bOj9uj55C2IfoD9b-opT61cOvtRnfHfA>
    <xmx:Fic_aRH-cjmJILGzZDxsK4nAWBYctq9kzHSRqbIecZrnGsVVM739jQ>
    <xmx:Fic_advp7cnY8mvkArCVGSNGx-IJH6VymZ_e-ZJLsxjRlIEDNjVhEg>
    <xmx:Fic_aVcNYCtO1ETxUPKGhfxRsJGT-LHKiWtRm7UKY7ZqhqseNgHEGIBF>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 16:07:32 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: use correct loop termination in nfsd4_revoke_states()
Date: Mon, 15 Dec 2025 08:07:28 +1100
Message-id: <176574644820.16766.17101861601059612460@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

The loop in nfsd4_revoke_states() stops one too early because
the end value given is CLIENT_HASH_MASK where it should be
CLIENT_HASH_SIZE.

This means that an admin request to drop all locks for a filesystem will
miss locks held by clients which hash to the maximum possible hash value.

Fixes: 1ac3629bf012 ("nfsd: prepare for supporting admin-revocation of state")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 808c24fb5c9a..bedeb5f035d7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1778,7 +1778,7 @@ void nfsd4_revoke_states(struct net *net, struct super_=
block *sb)
 	sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYOUT;
=20
 	spin_lock(&nn->client_lock);
-	for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
+	for (idhashval =3D 0; idhashval < CLIENT_HASH_SIZE; idhashval++) {
 		struct list_head *head =3D &nn->conf_id_hashtbl[idhashval];
 		struct nfs4_client *clp;
 	retry:

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
--=20
2.50.0.107.gf914562f5916.dirty


