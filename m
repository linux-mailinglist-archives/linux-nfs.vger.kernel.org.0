Return-Path: <linux-nfs+bounces-914-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A3823B1A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 04:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F801F2602F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A025257;
	Thu,  4 Jan 2024 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TORlpXbg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B05227;
	Thu,  4 Jan 2024 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704338773;
	bh=0/37jBO1P9a8O4nUJr8EgmsTgUeLZ1xiDU4LCCXbelQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TORlpXbgyvs8USbSCfQxUlJr9xe7iu0HhomnIQyUJUV4mwZdZv6Z7/7pcELi9b1TE
	 pgAeCVzcAS6k4dMb5Vy3izR2q8JRCPT2div5heG+l8alt9hiYgeHovpO4VDvbhaq7w
	 J5sJ1SGk4wweSszGDR6ijGsjx4oO16aZHFnjyhq8NqLbZXHBkuhJx/ZuJ9dbtw2ZzO
	 lCFk7CwuA5GgZv2S+vae2n8xHyNG5GxlG78GNIOq7Ag8Brf8jGLQQdsonYZixE9QNF
	 /HsuiLntIlUr1JvrEj4224/HH+ZMOSpQX7hd3kOB8IDFCljmWhbontnRrIXUZVwXdo
	 pjWrYKkRZSXDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5Bnd1W6Mz4wch;
	Thu,  4 Jan 2024 14:26:13 +1100 (AEDT)
Date: Thu, 4 Jan 2024 14:26:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, NFS Mailing List
 <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the kspp tree
Message-ID: <20240104142612.715f10f6@canb.auug.org.au>
In-Reply-To: <20240104142350.34d38d09@canb.auug.org.au>
References: <20240104142350.34d38d09@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E+dWFudbY8N8LSX.6SQ8fQT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/E+dWFudbY8N8LSX.6SQ8fQT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Just cc'ing the nfs-anna tree contacts]

On Thu, 4 Jan 2024 14:23:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> The following commit is also in the nfs-anna tree as a different commit
> (but the same patch):
>=20
>   cb6d2fd30ddd ("SUNRPC: Replace strlcpy() with strscpy()")
>=20
> This is commit
>=20
>   d8056629633c ("SUNRPC: Replace strlcpy() with strscpy()")
>=20
> in the nfs-anna tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/E+dWFudbY8N8LSX.6SQ8fQT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWWJVQACgkQAVBC80lX
0GwWeAgAjZq9JqZb3T554QeXAMJhv14hQGltV5//u6wABo/4M8lauqpBQolT+pHe
6w+NSkuMex4qP4ksHOCyZeBpp8qsOR0mTXGaWwjSm8ZTkbeOK2ZsVX3YbSDgl/4U
PgdvFxlZ6R8YVAmyeYENcJtpWDLryruW0vx2yxnrTp1Jgqs5rapdME/qBi9HyRg0
/YvwOJkeFl+PhT57zgyzX0XXknJcRdj5NRLASCej94nlrveE6mXfcqnERuafzpFW
J/gC8rnoX7KgKKYd4iJviZDEGCP577bOlpkH4K+J5qF0UjBuv17MTkEtBWNgwJHP
RKliXdwvJF2eav/7SbZeFhWoqMesjw==
=kmcH
-----END PGP SIGNATURE-----

--Sig_/E+dWFudbY8N8LSX.6SQ8fQT--

