Return-Path: <linux-nfs+bounces-9417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A12A17509
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 00:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943493AA33C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F51B87EB;
	Mon, 20 Jan 2025 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="K+VZqfF9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6D155A52;
	Mon, 20 Jan 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737416044; cv=none; b=RtMbUIBkg06+iYAplmXBq+mSsnSV3v4qTREMMTwu0g5RaJJfaOa8/OcXL4SBjIC+E6Uc8Hkh9A1h3BE45n2VtvUwyCfUWSOQM/+fido/RiK9sf9RdShJTNcFBd9EE4LSL3VilWjl8cp9fGLAjXs1fjdOHajFsCidPqJf8aInfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737416044; c=relaxed/simple;
	bh=q2+z/AgrVg9lawfRF/HooN7I+8BGHSJn+qg8UYQub/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7RsKBeu+IsswviTwxzWln15Me1kVAGRx5TYT/a6XYQAT1xtRnipZxC3z+153rR6mrgyM65ILiAVClazyQQUPCtqSXgOR8iput3lKb+Ffyl3jj1WgsWzjZzpD+uTEroDRxMiIvxR4+AclX4M3mPxPC9Qqc2kvjGOYjCmBKGYBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=K+VZqfF9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1737416029;
	bh=i1JYFYbVyeyYAlFOmNEBG1xB/oZu928Wo1ZuODRiPIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+VZqfF9cMMN5NWU8yMt4t9oBZKvuWRTEhVQPOBAypMhut8pTtfEATcx5+ocvgEdI
	 JXklTH5EakT/2c4YlYtAMQ9+kGQ4iWbwRTo8xxfe6LhYa5gRul5P+HO5votcWALU5S
	 YG592Io7FVQBmvmP51wDvDImv2ppe80Rz6QHVWiK3tSnV/zjS3BwGTBHsSD3gQc0pz
	 4gvirZPScznHc2wQSWoPtGsc2Cd25VDx3uvz/r10CE5bVpUCS1gAP/T8WW6bcc4RRw
	 +4meYOIl+zZmjPzz+8P/fs6JsozOhBc9JnTOQHPXH4v398g7JtcOMDO7VFsIaGJ4I9
	 rHpk+uIlkmJVQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YcRVj0vntz4wcD;
	Tue, 21 Jan 2025 10:33:49 +1100 (AEDT)
Date: Tue, 21 Jan 2025 10:33:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, NFS Mailing List
 <linux-nfs@vger.kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Mike Snitzer
 <snitzer@kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 nfs-anna tree
Message-ID: <20250121103356.10d8a15c@canb.auug.org.au>
In-Reply-To: <20250109084503.1e046ef7@canb.auug.org.au>
References: <20250109084503.1e046ef7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=IcfgXVQE4sfyNzIqvH4xt3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=IcfgXVQE4sfyNzIqvH4xt3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 9 Jan 2025 08:45:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/nfsd/filecache.c
>=20
> between commit:
>=20
>   735aab1241ea ("nfsd: nfsd_file_acquire_local no longer returns GC'd nfs=
d_file")
>=20
> from the nfs-anna tree and commits:
>=20
>   f905e00904cc ("tree-wide: s/revert_creds()/put_cred(revert_creds_light(=
))/g")
>   51c0bcf0973a ("tree-wide: s/revert_creds_light()/revert_creds()/g")
>=20
> from the vfs-brauner tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/nfsd/filecache.c
> index 2adf95e2b379,dc5c9d8e8202..000000000000
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@@ -1255,8 -1247,8 +1255,8 @@@ nfsd_file_acquire_local(struct net *net
>   	__be32 beres;
>  =20
>   	beres =3D nfsd_file_do_acquire(NULL, net, cred, client,
>  -				     fhp, may_flags, NULL, pnf, true);
>  +				     fhp, may_flags, NULL, pnf, false);
> - 	revert_creds(save_cred);
> + 	put_cred(revert_creds(save_cred));
>   	return beres;
>   }
>  =20

This is now a conflict between the nfs-anna tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=IcfgXVQE4sfyNzIqvH4xt3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmeO3WQACgkQAVBC80lX
0Gz87Qf/Uz3fxZOFqYzAhWcHcdRwV+3nfDH8UXcAop/wnPRVewSoNFgvuJk9MxRU
Ci829lmxn8qCMWjpaLiKcIX2mQHDW+aKwooqiUZqWu8EQpQ3fOEnPj1UtxfJizA5
VhpgDUvqeX++315iVmyWprkSjySDykibDDs91anIogpF3WlY29xa0s40dLYfPAqU
L35DRShk84KiscXV+5xFwCIH6zcP3771NyQiLzYDmA8AnUL43tqFhg2qzS3WMKvr
mJoQVNcPt3CVMMjxz18tgurNYVVb55G//epbKFDw0K8TgddFOYzynOEs2cP8VmJz
HPjUKgQ5C9uWbAxayugdghl5leYamQ==
=P5kQ
-----END PGP SIGNATURE-----

--Sig_/=IcfgXVQE4sfyNzIqvH4xt3--

