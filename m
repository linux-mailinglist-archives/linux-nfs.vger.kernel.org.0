Return-Path: <linux-nfs+bounces-17043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D7CB753A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 00:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA8F130012D4
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6CB194A6C;
	Thu, 11 Dec 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="5MkwRDxa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qh4wc3Hr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93A800
	for <linux-nfs@vger.kernel.org>; Thu, 11 Dec 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765494051; cv=none; b=V5TYnFeW2SIJl2z99CSA7vFiSr4Ch2+9W4Ac4rWRL9iBIco4NCg4VcVH32yQCuFHa5mlm1XGUZGTmKDv+lBPgyknpp0RShhLSyzg2q6mB3nPv3YLtgmTe3LTE24eagB/pPnQPzSNPKgR87RAN/njl6v/wd6/d92nAdEr4AbpKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765494051; c=relaxed/simple;
	bh=/zxRVTYCHDTqHE9xmJ7+uZAuCiyDnENQVKNIt5Kne34=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=J9v0H3we9hXuacqikbV+O52ctiIj7id9827sqde8WH3zmTtz0KtJycnLsCqIon31exA6FbtXR/IMqs/MBp9OhRL41Czy8LgNWp95csXlcfcXDb5dCx2XJizleFkkXa+OLhOzZrxwu0LR9FuhVhPPg+NdJypJsyHktf6ff+5FJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=5MkwRDxa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qh4wc3Hr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A49C1D00166;
	Thu, 11 Dec 2025 18:00:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Dec 2025 18:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765494048; x=1765580448; bh=eA2vptayTHWUAfanpGHPqMIlQJM8NfTbeAa
	sH+/HmO4=; b=5MkwRDxaDsdbnwrHr1ULc2QDQDGMGaGm76GWtVYxz/5qvyFKLrp
	4bRcbwB4b+zAKBlA2O7dRBgpjRwJj3SSFp6nigVDQajFyVsyMYVQltsSU0wNqsHA
	+RcyvYK2CHgvCkLsc3/5rcsIwVa5W5FBoPNNIQlNnS7pHeUDwxEjkw0cVxtJUQle
	JWEppG/I7X2L4IFNj/cz6EHMB5wyvE1ej1B0VFgxRh7GwQDF/J1JmIRQ1rI2XhU7
	W9sCMYnikaShsNpwm91NPu9ttDSMv7g/YJ087SMRW07MZIn56yuCzJ79ISdxKXV6
	vQE+zBrN0n/3XbBBhbEBclvQL/P5r/JBJeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765494048; x=
	1765580448; bh=eA2vptayTHWUAfanpGHPqMIlQJM8NfTbeAasH+/HmO4=; b=Q
	h4wc3Hrb+V6/CtUv1tPquu+3P4LmT4Rb3ycVZ4VkFnMcnGobAYFlJgDLrJEkl7Fw
	Q1KaG8NTH5MFScnbRTGXWLkFabmbwYOx3pQ/DlvjiI/LToxbvPcDSZK1tNhre6on
	G+iriahbbkUrs6iVn/Szw1f5oUh9iA8T0s+V1culwUdnJSvNdW3IM87LdhLDPteo
	ecwy0RGFYg+G9n3DPN1Ag/ng+qI3hTB7bGgMJ+HhesTdPWn6O1Mwdo9upCmdLQav
	iHUGTtqpHj2BObVK26VpEsHouoJqQdXNL32K4xuftZ2w19hXVBJMhEMD+2OGEPQG
	BthBr2QMOO1DHsrFsdlag==
X-ME-Sender: <xms:IE07ablduMRt4S3An1wvGrQQYxmx9UtWoMUt2rscgBVTo9yoQyvWmA>
    <xme:IE07aREiDjqhyJhBQ0Di-8QmBgWxrmZliKWnXSCqMhYnJnVVo9c2LDvqDXPIVGkfy
    BmOvmZwsLFGLlUPap1g3YXAeAdrl2qi2d7gk-Zs9soQWkAO1g>
X-ME-Received: <xmr:IE07aT6jj3vVDl7gCBOG2Rvt2SqJXSyW-amXuEF8pSHNOREN-vNtEe5MWA1k3wL-SLYDU1JjDPFafmr8TAwt6GuA7zn796mXhfxioov-wRvB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepshhmrgihhhgv
    fiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrth
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IE07aZmjqXgbeRsfjp-subA-_xFb52uTgycxQUTxFACoDbAeMYPCzA>
    <xmx:IE07aYry9o8KW5fKb4KSOnnvoL_kz6BL8HLsww080We4ViUGjojkIg>
    <xmx:IE07aYugkr_8Tyk7SLIKjedngFKOeuoIN8ZHwx90Y0GGTPb7pMGJpQ>
    <xmx:IE07adGYqUsztJEW17zbAVlxCFuPnoYpIkYdjUxs2d6rbIrootcyVg>
    <xmx:IE07aQxnI2aqKvpvExyAeXPP-nHZ1k11Kwz1nHD4t0lYRtwKiNC-veEm>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 18:00:45 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Scott Mayhew" <smayhew@redhat.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Fix permission check for read access to
 executable-only files
In-reply-to: <20251211123434.3261028-1-smayhew@redhat.com>
References: <20251211123434.3261028-1-smayhew@redhat.com>
Date: Fri, 12 Dec 2025 10:00:42 +1100
Message-id: <176549404255.16766.6301657662845248203@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 11 Dec 2025, Scott Mayhew wrote:
> Commit abc02e5602f7 added NFSD_MAY_OWNER_OVERRIDE to the access flags
> passed from nfsd4_layoutget() to fh_verify().  This causes LAYOUTGET
> to fail for executable-only files, and causes xfstests generic/126 to
> fail on pNFS SCSI.
>=20
> To allow read access to executable-only files, what we really want is:
> 1. The "permissions" portion of the access flags (the lower 6 bits)
>    must be exactly NFSD_MAY_READ
> 2. The "hints" portion of the access flags (the upper 26 bits) can
>    contain any combination of NFSD_MAY_OWNER_OVERRIDE and
>    NFSD_MAY_READ_IF_EXEC
>=20
> Fixes: abc02e5602f7 ("NFSD: Support write delegations in LAYOUTGET")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/vfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 964cf922ad83..168d3ccc8155 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2865,8 +2865,8 @@ nfsd_permission(struct svc_cred *cred, struct svc_exp=
ort *exp,
> =20
>  	/* Allow read access to binaries even when mode 111 */
>  	if (err =3D=3D -EACCES && S_ISREG(inode->i_mode) &&
> -	     (acc =3D=3D (NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE) ||
> -	      acc =3D=3D (NFSD_MAY_READ | NFSD_MAY_READ_IF_EXEC)))
> +	     (((acc & NFSD_MAY_MASK) =3D=3D NFSD_MAY_READ) &&
> +	      (acc & (NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_READ_IF_EXEC))))
>  		err =3D inode_permission(&nop_mnt_idmap, inode, MAY_EXEC);

Reviewed-by: NeilBrown <neil@brown.name>

The new code is cleaner and more correct - thanks.

NeilBrown


> =20
>  	return err? nfserrno(err) : 0;
> --=20
> 2.51.0
>=20
>=20


