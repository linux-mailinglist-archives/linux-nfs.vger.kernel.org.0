Return-Path: <linux-nfs+bounces-16030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A715C3302B
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 22:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C5DD4E133A
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 21:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB5242D87;
	Tue,  4 Nov 2025 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Cweh95+F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBRgZGdw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920DF23A9AE
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291091; cv=none; b=mlXxkD/xDhMMGv5IGnTkmC/iOYXmj763qRrAvwyhlUHYx+uRuzcBQCAftpKFgxRXzVSAXj8OY5lsgjQPdmo3FhRu4s0pw1VCl25Vp9XbS9lbLCQwFcT/FaicJyLlSW6gPe9+WT8A6kphKrg0PabMYGpKxepY4xLp/EX3CXkvQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291091; c=relaxed/simple;
	bh=4z+3ow0MQSaNtczlXKUxO4V68xVy5xhkIoeKajNXUzc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hCyMfD9WoQMe++BUvjHLmmgHOs6xbxeQyvRIUQw056a16zD2bnPO6ZWNRAOlJpcSRaTfmQMlc1g+moHOQvN17Wl0HaAgYM02cWbHwLsdaAaXGcgvEF8pMc8wnW/u15AKdPzQ4jbyM1o71rfNViHCC8R9BtDXfT7kxLewOXoQuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Cweh95+F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBRgZGdw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 78345EC04FD;
	Tue,  4 Nov 2025 16:18:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Nov 2025 16:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762291087; x=1762377487; bh=KdEwHKCXK+ldH+7t8FNFpWX8i2L6+Xb2kKG
	nHPxMveI=; b=Cweh95+FSk3dQ+mUcohWKiIA8ELO4TtGAeaPq1/J6E2tSUjVIIi
	lgniPVvkRV1CamZAankwTR/8qqzS6FFJhmNFZU3PbRvZWTtf+zW7DuF0jdX6n7pH
	IbHDPC94vJTZoN9ELqhdO+g9Sm+eHCEMbGWkZNa23lf1nE6IUuX4h/n7spiMjnDx
	sop4G8BtY2MBSS7PvHTzx7SIzEYwVQScI2X0hyZCgdZVDN7q1s2fPfmoWYob/AOn
	Zv434upbn+6cInVLnOWNzHLV7ApIl2ZIIqEl/f39R1HZdjTOb9OgyJgRX0RFB+rb
	T2nLOHilE+lP8VOYiofCfs85II7Jxwk8BLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762291087; x=
	1762377487; bh=KdEwHKCXK+ldH+7t8FNFpWX8i2L6+Xb2kKGnHPxMveI=; b=a
	BRgZGdwMGZiwB1b+N3H2yYP6jip7LWZRtplgjHyziylNJUS8JbWI4gVfu5FkSxOY
	7n44zyEJfaQnDHKT0K9KjxL/+aHplHc0iuzXCbJKZ5krbjnEMx6n3NiI8m8gWhEu
	m72/uKFkrqDhg9SBLxmHsELbeivFyD5I1BjBpUza+6TZZVPipSyYrd8PGBrkEuBm
	bhVVJMnKLIZARC7Wv7XTF6mBmYRxiRps/Hb+YTzRQ8NbJEGwBLW7jXUgIOI2CTgj
	WQ8Ql5Zkg47kcjtrFkhPJPSiwJ5QwlTu9dO7j91Qmbjlw6CScXpOIRmt8yW4tr22
	VQ6zl4zywYfSQlxhHT+sg==
X-ME-Sender: <xms:jm0KafqfQF0OaiAx3HpcZWNPJ22ZqpweBe8FdiSeUiVqKtivu5oY6Q>
    <xme:jm0Kab69hAk38PFW-J4NHWwjmaC_CfR38xpjQ0nRrseBqECMjT7mkqBtqkh3t_B89
    lzO7erSz2AgVHfSxc-Wb2-oUqCCFs2db_mW26Eo-E72iONDvA>
X-ME-Received: <xmr:jm0KaedZaerOXU1HPjlWxiIf6VvbNWFtUNqe4ps9dt8VvH4zyM1p1kOazCUEFK-ZZy20EnDVkUESIb1QlMU9sHU09VvIZdWKQrCp6hF8jVa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphht
    thhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehsnhhithiivghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgeskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:jm0KaY4_RDeZaiZI6gZdWiUKuJXDiaJXQwWmp4OYXV_4969DnRNWHg>
    <xmx:jm0Kadt3xdvwD0J_AqnPomVD50SmrsGgEt674mG5q9D_7hpRlnlnbA>
    <xmx:jm0KaQgq9LYbjBWlqFCy8T6SCLMVZk4R8LluX4pQ5eU21pxrorUKkQ>
    <xmx:jm0KaQpx82baqH8GGm5KSH1k8JMI6UMnb4MgX2QKPyT2y_cDFarRqg>
    <xmx:j20KaTo2elFp4F0JNalNpEG6KTZsYWBHjkbbkuO_RFo8ITeBbUHyV7ov>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 16:18:04 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Mike Snitzer" <snitzer@kernel.org>, "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH] NFSD: Prevent a NULL pointer dereference in fh_getattr()
In-reply-to: <20251104160550.39212-1-cel@kernel.org>
References: <20251104160550.39212-1-cel@kernel.org>
Date: Wed, 05 Nov 2025 08:17:56 +1100
Message-id: <176229107621.1793333.11409972513367324811@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 05 Nov 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> In general, fh_getattr() can be called after the target dentry has
> gone negative. For a negative dentry, d_inode(p.dentry) will return
> NULL. S_ISREG() will dereference that pointer.

That isn't correct.  While a reference to a dentry is held the inode
cannot become NULL asynchronously.
It can change from NULL to non-NULL if another thread "creates".
It can become NULL if *this* thread calls unlink and no other thread has
a reference.
But it cannot suddenly become NULL.

I like the patch as it avoids a dereference and so puts less pressure on
the dcache, but it does not change correctness.

Sorry if I implied otherwise when I suggested it.

NeilBrown


>=20
> Avoid this potential regression by using the d_is_reg() helper
> instead.
>=20
> Suggested-by: NeilBrown <neil@brown.name>
> Fixes: d11f6cd1bb4a ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_REA=
D_ALIGN support")
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsfh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> Hi Anna -
>=20
> nfsd-fixes is still based on v6.17-rc, so this patch does not apply
> to it. Can you take it for v6.18-rc ?
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..16182936828f 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -696,10 +696,9 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kst=
at *stat)
>  		.mnt		=3D fhp->fh_export->ex_path.mnt,
>  		.dentry		=3D fhp->fh_dentry,
>  	};
> -	struct inode *inode =3D d_inode(p.dentry);
>  	u32 request_mask =3D STATX_BASIC_STATS;
> =20
> -	if (S_ISREG(inode->i_mode))
> +	if (d_is_reg(p.dentry))
>  		request_mask |=3D (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
> =20
>  	if (fhp->fh_maxsize =3D=3D NFS4_FHSIZE)
> --=20
> 2.51.0
>=20
>=20


