Return-Path: <linux-nfs+bounces-16033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADFC33389
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 23:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454AC1881E08
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA9190664;
	Tue,  4 Nov 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Vf8HJj8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBD1iw5D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFC280330
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295181; cv=none; b=qhxaYkpkxVbooEZC1CKT1r/mNZxHAqV8rC09QW7OpPirpIgio5hppdL+hNMVG/S0BPT8ZurNdP16uV1QOHDDRAz3ckb3BPlhs5AfSozN7W5F34Q7+UF5mVbdyar1CLRfYURB3m8/fY8rdg0a7xCLt1Yn6hgH92RWaDjbXSlRDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295181; c=relaxed/simple;
	bh=J5OkmUW0DIMzNcRACBzxDX5edWnirK9i2+iTi6pXn7s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IAughqOokDQb0KjZpyrjP5ifep/bIFHR7QoedMJBAQKIsR9juvdHSRPdcPBiOttLHMjUJUARVgyMdLGMkTSWXRdEzKpbgjT91HeufiojP/AHUh22huOQbaW4lZqeT3BiQVGgUQ03+fzQHS6/4cr4gVQoyVJIsiX7HMEdv8tEV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Vf8HJj8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wBD1iw5D; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EC146EC04B7;
	Tue,  4 Nov 2025 17:26:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Nov 2025 17:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762295178; x=1762381578; bh=PnHDNUoPV6lbyH18l3BkF1M1oY6P9LNtZon
	t508fBBA=; b=Vf8HJj8qFc2y+P3ul1s7DAi3d8oty3YyCyJISAU8gMLCoXSz7eS
	IxazMNt8z2K362PL2egNqocx0e+vWoi4ndOMIVToTbfotdZH0gVgNmn+OtHJxemG
	Se3bWt7XyoNBCvS2XhoVs6Eslzq8dbZXJNkxPjAkbON9oPjdRmPgQpFtUp+PLTVH
	336IJICApTIDAHvqL5NmJo5UtlfMYqotTFhQbT9dZLe4Ytzfh1yXg/kaIfdvEMOG
	lYV08FWF7vx2Z6awsr4seQcNJGiTjLur196yOr1vRrRdOlYSs2mUeK1zKq+SiBbu
	6/0md8BOI/RzjbNJS7oy3EGnV1dgb3q8cyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762295178; x=
	1762381578; bh=PnHDNUoPV6lbyH18l3BkF1M1oY6P9LNtZont508fBBA=; b=w
	BD1iw5DDmnU/HTvPZAtOFlVeRJ343wiCHraVI7jsQULlVMVKnIUiwdpL+DeYwOiR
	z7gw1g/xxyVP8xrWytElxRfv1d2CbbHw7LMsU1nHt6GwdFvWMR1G0EChvN8Wqw4W
	mQ7iD/Gwo4zaaYm62Q8oDnpnCtq45ApFPPi4A0Mp6nkVoLV+NBkYzI+NzVNolTiL
	EXoSwQ6utkCe58rOQFyd4UU4BKowmNzM12qbS3V7VpWqJLt0jEtut+ieFguKK7M1
	CAAx3A5sTvLo/EBnUXGdOGH0swdomBx6kKimSxOp6Vqvr/arBN3QeWdonYOupPFa
	XFkvehor2TNQFdZgdaqYg==
X-ME-Sender: <xms:in0Kac-muj2CSGBwFHmmHx4--FyenMWp08F3YkRuRNuQEguMidyhBw>
    <xme:in0KaW8E-UFS497NsX263rad5HnLcMGdNcoiOWHI9mYv_27N7ic7AP5MX2svvaDnJ
    0HKOr9HsgWvP7M5fAYSAeiDtjWCXy57qL9C5iX4zGH-eIVhsKM>
X-ME-Received: <xmr:in0KaUR5mhRiKyIz5yUwlONr96_LGVONvSGxw1g21JfGw9ql3NJPqemIpCW3TU-JAG58uGQJrf5_qXihtssvFOHX8rEi4toNhI-DAhBcOLHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvvdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:in0KaScoGOBUO27mMkJHjVMUfVFqRlOxh9zfY7bi8BGSFZWZSiN-hw>
    <xmx:in0KaQD3BDxdWlONtH5wQ3HVo2PgkZCuuuFTp_9CJh5sWY4qMvSREA>
    <xmx:in0KacmKVAou9Ws5bi7hlyJu9VHSL1Xl58DYiOWW1hNPjkmtQuwuww>
    <xmx:in0KaTcJ1g0hiYsAWkgwQTO7Fp_gM0Gf79WrvItelrwy3nq-87uCZg>
    <xmx:in0KaY8O4KYGarm-XuEWL9rNp4ozHY_fF_dfeLdrHaWMMpHlBZzILF5B>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 17:26:16 -0500 (EST)
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
In-reply-to: <5907db3b-818a-470e-932a-db494dc15402@kernel.org>
References: <20251104160550.39212-1-cel@kernel.org>,
 <176229107621.1793333.11409972513367324811@noble.neil.brown.name>,
 <5907db3b-818a-470e-932a-db494dc15402@kernel.org>
Date: Wed, 05 Nov 2025 09:26:14 +1100
Message-id: <176229517456.1793333.18248554635305336951@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 05 Nov 2025, Chuck Lever wrote:
> On 11/4/25 4:17 PM, NeilBrown wrote:
> > On Wed, 05 Nov 2025, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> In general, fh_getattr() can be called after the target dentry has
> >> gone negative. For a negative dentry, d_inode(p.dentry) will return
> >> NULL. S_ISREG() will dereference that pointer.
> >=20
> > That isn't correct.  While a reference to a dentry is held the inode
> > cannot become NULL asynchronously.
> > It can change from NULL to non-NULL if another thread "creates".
> > It can become NULL if *this* thread calls unlink and no other thread has
> > a reference.
> > But it cannot suddenly become NULL.
> >=20
> > I like the patch as it avoids a dereference and so puts less pressure on
> > the dcache, but it does not change correctness.
>=20
> I think the steps I'm worried about is if NFSD unlinks the file, and
> then something subsequently invokes fh_getattr() assuming that is
> safe to do.

nfsd never creates a svc_fh for the dentry is it about the unlink (or
rmdir).
A delete involves an fh for the=20
I'm guessing=20
Commit: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test =
in clamp()")

is the problem.
parent, and a name.  No fh for the child.

>=20
> How should I update the patch description?

Maybe just drop the patch for now.  There is no regression and nothing
to fix.  Maybe we can make the change latter as part of a cleanup.

NeilBrown


>=20
>=20
> > Sorry if I implied otherwise when I suggested it.
> >=20
> > NeilBrown
> >=20
> >=20
> >>
> >> Avoid this potential regression by using the d_is_reg() helper
> >> instead.
> >>
> >> Suggested-by: NeilBrown <neil@brown.name>
> >> Fixes: d11f6cd1bb4a ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_=
READ_ALIGN support")
> >> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/nfsd/nfsfh.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> Hi Anna -
> >>
> >> nfsd-fixes is still based on v6.17-rc, so this patch does not apply
> >> to it. Can you take it for v6.18-rc ?
> >>
> >> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> >> index ed85dd43da18..16182936828f 100644
> >> --- a/fs/nfsd/nfsfh.c
> >> +++ b/fs/nfsd/nfsfh.c
> >> @@ -696,10 +696,9 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct =
kstat *stat)
> >>  		.mnt		=3D fhp->fh_export->ex_path.mnt,
> >>  		.dentry		=3D fhp->fh_dentry,
> >>  	};
> >> -	struct inode *inode =3D d_inode(p.dentry);
> >>  	u32 request_mask =3D STATX_BASIC_STATS;
> >> =20
> >> -	if (S_ISREG(inode->i_mode))
> >> +	if (d_is_reg(p.dentry))
> >>  		request_mask |=3D (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
> >> =20
> >>  	if (fhp->fh_maxsize =3D=3D NFS4_FHSIZE)
> >> --=20
> >> 2.51.0
> >>
> >>
> >=20
> >=20
>=20
>=20
> --=20
> Chuck Lever
>=20


