Return-Path: <linux-nfs+bounces-11964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DEAC7298
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 23:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63461BC7538
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 21:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC929220F3F;
	Wed, 28 May 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fLkxi5pP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235219B3EC;
	Wed, 28 May 2025 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466784; cv=none; b=fh1WBsdPusb/+eBlU4zzjibeXvd418MpaSBz6v17QOdXoHB8zVTnTxn4s6Cw8rw6Ja9QVqJY90oF+Vtp4IM2mP/SD8ciYsXmNhPeLmcsigq/zkg/G1msikjhSvq548SABDyiWqqMaJihTcbN3yTXGawCGMwtV3KGjIvHyON/ab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466784; c=relaxed/simple;
	bh=B1dJQNdURrw4rLjUeXXoBmpbVavIVpxnCv5m/seyF9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DfCDgW6wq0JnTd6on912q7//HA7Tig9eB/L1YnwW/t/s0DOlN8Vj+Njt/De0KNmfYj+fxCJykQWPxM7DoA/YIj1X3nyuXnW+sr3FM1S5/U4zOxqAhOPzMHXdkM/YuHVk9yqmPZWPGbr9rJGZdRFwXiBlwg4jDH7O4x6OgjAUY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=fLkxi5pP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1748466780;
	bh=+5Ei/8QNz7zs4TJvFRQxJ+aTL3fgH7zEb18HGTXwx4Q=;
	h=Date:From:To:Cc:Subject:From;
	b=fLkxi5pPw4IU+IAcGiZIJjd0Cnq9zYXl2p/ix7uXaXdgEI8brlkfAX4770c7sE+xI
	 t3myFz2lzevD3kU5NGAEWYpqWg55pv7yWHTf+w3UCOa7bLdwG4upWl1KHVH6YR7WcL
	 c2QKG1SiCh6zgwHeEo6/gF01xRQhxY1zyAqHH/S//TqvFOEgaE7b9Dwye76GyUHONd
	 ViYlFckzQF1QvU7jnI9Z95Zeur4x1sGMwy3glI4cO3FPuafp0OSvG4Zkc8VeCef5N4
	 fChmWVGUybGyd0vnvh3M9C4p0aE/WCK68dIzKX2zoz7FnF/eNgwQr3cLB9csOsgScv
	 QjgfWj0WTMWwg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4b72K800F3z4x8Y;
	Thu, 29 May 2025 07:12:59 +1000 (AEST)
Date: Thu, 29 May 2025 07:12:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nfs-anna tree
Message-ID: <20250529071259.3da451d7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xX3r/pUhntQn7M.qhBT8r6u";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xX3r/pUhntQn7M.qhBT8r6u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f75f8ab8c93c ("NFSv4.2: fix listxattr to return selinux security label")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/xX3r/pUhntQn7M.qhBT8r6u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmg3fFsACgkQAVBC80lX
0GxJqgf+NfT9ptMgHJ8FKX1yi/PRgFvqyafUkPaOHyx6OCcR50qcBbZa5MFOycnI
i4DvCc3tafmAe733zizT7+OwBu9cCeITwdI7pRxp0yIAgrH29rF6IXsDD14nf2oW
mT+Tvw3ShTY0KY82HI2wuuhucA4ND05B+HEFLTryeqGqbJDUujUhh5W0wGMguvzb
cWOZdywpFTmrLXPHEZMIceW5+jWR4hoaJU1Z/jbmp2V2QcDpFXaKfDD4IMEunvUm
VJ0w/AjYgw5PrXf4cynhtGKH27411whsIVp5GP3IiXsFoZaO183WSRbtba33Bdy/
RNoG7a/Peb5NiFg1AbODjShRX4u5Hg==
=Bh2B
-----END PGP SIGNATURE-----

--Sig_/xX3r/pUhntQn7M.qhBT8r6u--

