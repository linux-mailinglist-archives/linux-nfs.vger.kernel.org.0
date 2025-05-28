Return-Path: <linux-nfs+bounces-11965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8404AC729F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 23:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9050D1BC75A6
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB720B81D;
	Wed, 28 May 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xhs2g6QW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C4156F3C;
	Wed, 28 May 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466928; cv=none; b=KGuyFa9W+rF/HlyotBqwe+t8OUPX5EWfKcCne/ZPN/l9tTJPtS7D+ugR2dvYQ69mTZPRzmW8L2xgnf9s1B/788CPPlUH5CTHdX1IlZ1jo3n2D7YygsxAx5eAS/d/jNLiFe6j173og/mCX86s81A/F2BR9wDsdnUD6BjVvcd+X+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466928; c=relaxed/simple;
	bh=jNERVCNqkSP5QKFQTNEm2bguz7VN6bMt5UJGM0pMvTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ddRf4SeaZcajI3aA/YrW4wS/EdRSlU0TW8SmUQYcqkI2+O/fP0GknKvUFuB+c8k7XUC9t9dnpafDvgdtGjZzRmJEuBzAlRwP9kgC8zjKMlItCiXkgiQEtHlBxSr3EXg739YMizhyAWu7VTE5ug9N7W5wcufrEWVWiQn8egpEXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Xhs2g6QW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1748466924;
	bh=TBGtLU9W/IuMo6RhJI8z+1luDohP70q7lTVL6U0+FM0=;
	h=Date:From:To:Cc:Subject:From;
	b=Xhs2g6QWdX246yq44FsRT+rkd1nKHT1KgUlLzbTiyRbclJwzjafQCshwbay00Ph/w
	 eoEFx3CgbHx4ijeMzM2a3Uv6VXJu/3TtS8vwV6+bEP5klVPnYa8yHy0h2PYh82nr4D
	 lDqDk7baPwoHXDhCjDF+W96TdTCcidndGp0CC0aN+xbtDeuqvb7WuQxQv66GSwfTZ0
	 e23UKBYNFlgzPPls62XQPnX+omLoXfRby3eQ9ux6QDtk6d4Go27fNRZ4WHOdtyWSvn
	 R48UijxnBIum2H0Ph/mrhTQQt5temRTcTS4CIb/FLQmzuivIbsj+75myThsNOBiuOS
	 4sMcfYlTy7vgg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4b72Mw0xWqz4wy6;
	Thu, 29 May 2025 07:15:24 +1000 (AEST)
Date: Thu, 29 May 2025 07:15:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nfs-anna tree
Message-ID: <20250529071523.273eab82@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AnhhVMhr=fkNmn_dsX8Vope";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AnhhVMhr=fkNmn_dsX8Vope
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  fcb340ec3b51 ("sunrpc: fix race in cache cleanup causing stale nextcheck =
time")
  3433575f4da5 ("sunrpc: update nextcheck time when adding new cache entrie=
s")

These are commits

  2298abcbe11e ("sunrpc: fix race in cache cleanup causing stale nextcheck =
time")
  5ca00634c8bb ("sunrpc: update nextcheck time when adding new cache entrie=
s")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/AnhhVMhr=fkNmn_dsX8Vope
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmg3fOsACgkQAVBC80lX
0GwIqAf8CD+AKDmRLhzkXPr/SKuGQAcK/UMNrWz7tvBaWTnyyW4IODd6gyrf7v+Y
sW+TXu1WG2Pa+OPZlUSETCzBzRCDrgjulqmYUkpWAbvRb3EULc6ZZelSRhyvBO7F
Zv5JcBAW2Ky0pQ0EF/gPYSq8Wn9KQVicF7Wk/Jc0Mp+5BPfe8x+dpDO6bNLekxju
SGgL9YXf9rpy5HfqFK6Weiso+OM4sIkAMj5/fxSTsz/wFpOa2Uxf0eZ05gLJSG6N
KzqBESzump4LYztaWXNjKolSBji7kZ84wz/YHRK/sSnGMyGbIz4y+pFTgwC7SbYg
V/pw1ocCQ4gBe7pk4aWzmLqSOOEvKQ==
=6lUg
-----END PGP SIGNATURE-----

--Sig_/AnhhVMhr=fkNmn_dsX8Vope--

