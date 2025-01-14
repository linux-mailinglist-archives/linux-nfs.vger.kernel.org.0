Return-Path: <linux-nfs+bounces-9192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEFAA10087
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 06:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D72116436D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 05:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963BC233558;
	Tue, 14 Jan 2025 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JjUyjZx2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A501FBBFB;
	Tue, 14 Jan 2025 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736833517; cv=none; b=J8FCg22Wh43p4K8SQn79kd2NwYyphFAUpOnsni32rY5ql8ykxIMrtO3pDTSL4r3+CYD7JKnkpzcgIRxRLZfhHQpS8ALPKE5/jP+OxxP1m0qRnzQn2K+PGK33vjd4JkmowThxg/HWHQyjoBcWV/GKNPZ4Fbo/IgR1Q6kXUbGw+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736833517; c=relaxed/simple;
	bh=Rx3QkI8fHFS3I+3ZExvd/eL68VTXi0xxMAmj4R43JjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgSipoJiovUjyToRU6nKtnRTK75vZN05UXCDqRdH6k0HUDUVIdCG7LgURAeMDHysK2z7kLRh/d7IphVvAfh5eMEVi7knOf3MOy+tgajEhqJX/UsKwt90TrKc82mpuUf6NSnhd9QynyjnEPIYA9shutOwpa365KWtvs61kuKj2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JjUyjZx2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1736833506;
	bh=FbHHklyarQt1Kbq7Dn193gulcfZjRL6aS2iljygsjAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JjUyjZx2zd+n1lQMcpsbDe6OzBtiBUCEF0lgLddPS6RiCg8IIhfRuWvMQzT1GPRch
	 xLoik7zP4DunLBBdZpjpmESh+WfOE2WiSFMOcD1HMjhNDD8Nv0fWDWAzd6NIlnmaDM
	 uZ9/3Wn00tnSm1RiIsE6WM3MSpQhiue4Ynrm4pzXebsJ7OoyIx4XNihTtsKd7LYnpV
	 gtuc4xo4KC0INXTFROPlKT+MT4lLso86xWUnNEQTHV8XRwJ2ZCBdYB2969hHY2aEU0
	 gi5P33Krw6UZTUunqEJxDWiQbwzYgpVPozX+Vi0bCCmBjC/NFxrk707rhToHLDOJHu
	 MAy+zD1s51VHw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YXJ4K6DkRz4x1V;
	Tue, 14 Jan 2025 16:45:05 +1100 (AEDT)
Date: Tue, 14 Jan 2025 16:45:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Mike Snitzer
 <snitzer@kernel.org>, NFS Mailing List <linux-nfs@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the nfs-anna tree
Message-ID: <20250114164512.2793b899@canb.auug.org.au>
In-Reply-To: <20250109152349.46442c56@canb.auug.org.au>
References: <20250109152349.46442c56@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lc9x=AGhjP0ra+zpW_52Vdr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lc9x=AGhjP0ra+zpW_52Vdr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 9 Jan 2025 15:23:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the nfs-anna tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> Documentation/filesystems/nfs/localio.rst:284: ERROR: Unexpected indentat=
ion.
> Documentation/filesystems/nfs/localio.rst:285: WARNING: Block quote ends =
without a blank line; unexpected unindent.
>=20
> Introduced by commit
>=20
>   cc1080daed34 ("nfs/localio: add direct IO enablement with sync and asyn=
c IO support")

I am still seeing those warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/lc9x=AGhjP0ra+zpW_52Vdr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmeF+egACgkQAVBC80lX
0Gygugf6A2jyvK0sACethtaQAnV94+q+rf+LyXSWiJv/PiLBJHHl2JIYuSU2PHh6
f0nq3owrYkpovQgBebcuDdbS3d+LYdXsUiVzSd/318aURhawoManZqDULvmV++6l
y9bEmGD9lWfDBul1OMWKn4Al3crJiogAfX5J2i7XtcBqFXBi36YnX2GeuuQaJ5Lg
Dwko0J1DBvd+XAADZwA3Cn66dOpNv3PJZ1Rc3+V7veYy2GPQKfdiJCqez1ejH0Ab
ImTRHQtPjBK1HBHyVWnVOt8XgObnxJO3HMxenHIMfOaAI8MTiEA49yx/vFuYBFE5
3+KLF3l5rD1IoMy11PvPsXOAq01Hhg==
=xyxL
-----END PGP SIGNATURE-----

--Sig_/lc9x=AGhjP0ra+zpW_52Vdr--

