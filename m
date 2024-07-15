Return-Path: <linux-nfs+bounces-4890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45587930C68
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 03:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478C42812A8
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7BE291E;
	Mon, 15 Jul 2024 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Kl6xOXQQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3B4C6D;
	Mon, 15 Jul 2024 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721008090; cv=none; b=N8cHXZnQfD8L9aotWN87nFLOsqVx8ld+1RnCrO2PFB68wkLL7umyVjuRNd4Lw52UIVP2yJ9DgBxaMU+18JzqaCZorZUwvUzbr1DW5dZyJVd1LYnmQ2MAVrdeRZAJ5e/5icf/cmn/xZ9i2WLo1wRewCsifixFeINl59y7akWkfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721008090; c=relaxed/simple;
	bh=6NBogB+15y8/cr5/SGFVD66tjydLDWAtv8bQFiwBn3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHmJPCopfGrKjsRVKvVU7CFoxx0adjlqHfkQRO/YYmp13uZ7LEOjhs3yEl7j4GQo+/Tm6gS5iQ/+ahBlkiSuMF4+BLZmMMAlrR6Sf2i52QTfEn+6uLiZkFPXvSISiyBcWZ11/2wGLoJ0pzYtIwZejCdvXaTKCugLegYCG1Iduas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Kl6xOXQQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721008081;
	bh=BPaM86IV8DbjzzQhxMJepkxYYERbWk091giJrL2Zc9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kl6xOXQQU1NVZYq/orjR4IVXpmayif5cjiNsqPXSTYQZcnUe5EsLYBNVBXPB8oLPe
	 dR7wmLECPPfX6gm2jrPI0V12Xr7bjdlbQD8vZo22YN4P2+yTawmJjZIGpn9aDHr+Ra
	 DR6h43t0FUnrwAJvc2i/Mllb17IZ8TK3HhJix3WqJP6uCbDNj6R1zqrTT4dsNDTIrM
	 UzoKHZs5hlbbJFiHiQFnHuYf3OcGhGuWEQY9nQvY6LF6rhUP4Vo3fC2SqWzg6HSehw
	 tQOoKV8gi0lv3eLVvVqTlbmAhiAAcoIzV2IVvKugWnueO5R/Of6xYMP03WUdLdxHET
	 HYVS7aVtuYuAQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WMlTF0cHNz4wbh;
	Mon, 15 Jul 2024 11:48:00 +1000 (AEST)
Date: Mon, 15 Jul 2024 11:47:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <Anna.Schumaker@Netapp.com>, Trond Myklebust
 <trondmy@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Kairui Song <kasong@tencent.com>, NFS
 Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nfs-anna tree with the
 mm-stable tree
Message-ID: <20240715114759.16a86e78@canb.auug.org.au>
In-Reply-To: <20240715105836.6d6e6e50@canb.auug.org.au>
References: <20240715105836.6d6e6e50@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gb.QN8J2+=7iLZbOJIgbFxI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gb.QN8J2+=7iLZbOJIgbFxI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 15 Jul 2024 10:58:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the fs-next tree got conflicts in:
>=20
>   fs/nfs/nfstrace.h
>   fs/nfs/write.c
>=20
> between commit:
>=20
>   237d29075ca7 ("nfs: drop usage of folio_file_pos")
>=20
> from the mm-stable tree and commit:
>=20
>   64568b27b2d2 ("nfs: pass explicit offset/count to trace events")
>=20
> from the nfs-anna tree.
>=20
> I fixed it up (for the nfstrace.h file I just used the latter, and see
> below) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/nfs/write.c
> index 3573cdc4b28f,680505d664f0..000000000000
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@@ -279,9 -180,9 +180,9 @@@ static void nfs_grow_file(struct folio=20
>   	spin_lock(&inode->i_lock);
>   	i_size =3D i_size_read(inode);
>   	end_index =3D ((i_size - 1) >> folio_shift(folio)) << folio_order(foli=
o);
> - 	if (i_size > 0 && folio_index(folio) < end_index)
> + 	if (i_size > 0 && folio->index < end_index)
>   		goto out;
>  -	end =3D folio_file_pos(folio) + (loff_t)offset + (loff_t)count;
>  +	end =3D folio_pos(folio) + (loff_t)offset + (loff_t)count;
>   	if (i_size >=3D end)
>   		goto out;
>   	trace_nfs_size_grow(inode, end);
> @@@ -2073,8 -2062,8 +2062,8 @@@ int nfs_wb_folio_cancel(struct inode *i
>    */
>   int nfs_wb_folio(struct inode *inode, struct folio *folio)
>   {
>  -	loff_t range_start =3D folio_file_pos(folio);
>  +	loff_t range_start =3D folio_pos(folio);
> - 	loff_t range_end =3D range_start + (loff_t)folio_size(folio) - 1;
> + 	size_t len =3D folio_size(folio);
>   	struct writeback_control wbc =3D {
>   		.sync_mode =3D WB_SYNC_ALL,
>   		.nr_to_write =3D 0,

Due to commit

  564a2ee9f9f6 ("mm: remove page_file_offset and folio_file_pos")

in the mm-stable tree, this also required the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 15 Jul 2024 11:23:30 +1000
Subject: [PATCH] fixup for "nfs: pass explicit offset/count to trace events"

interacting with commit

  564a2ee9f9f6 ("mm: remove page_file_offset and folio_file_pos")

from the mm-stable tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/nfs/read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 6355a777e428..a6103333b666 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -367,7 +367,7 @@ static int nfs_do_read_folio(struct file *file, struct =
folio *folio)
 int nfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode =3D file_inode(file);
-	loff_t pos =3D folio_file_pos(folio);
+	loff_t pos =3D folio_pos(folio);
 	size_t len =3D folio_size(folio);
 	int ret;
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/gb.QN8J2+=7iLZbOJIgbFxI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaUf88ACgkQAVBC80lX
0GwkUQf9E6IG7ZpMGdegQzcym8LVON/5In03s4669LGHAG0PkVnWmdFF7Lfrduwv
dFjIeUyeodVDCgGSxPGT/vaWgpu0zyj9h7vkPfw3g7PGH6ddmf5/cFgQiSqmUEsv
ZFCPdL3HJxa5uJ1K6Ec00xgiXxH7i437U5PKi1g3caJk2OZfbQFti5Z6HrXPSggK
8/ltBwKkz+SmiKDQ7RPl3Z4EoaynRdPdE13CxbamzUc6IjxsAezoXzzBCLy1HzOz
wTz7yu0O5YZab8IOmUWhHgyKsoxKF/yAnzj7/AleUOP+o5HbKdR7LApeEuJsSHQN
fG1Nwo+HZAKg1xYd72NLZCkiOMcHjQ==
=pZGy
-----END PGP SIGNATURE-----

--Sig_/gb.QN8J2+=7iLZbOJIgbFxI--

