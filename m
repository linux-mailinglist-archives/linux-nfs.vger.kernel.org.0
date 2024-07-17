Return-Path: <linux-nfs+bounces-4976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB709344AA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 00:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E05B20EFB
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EEF4503B;
	Wed, 17 Jul 2024 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LNHl7bux"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5740848;
	Wed, 17 Jul 2024 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254463; cv=none; b=jQOY6h/jIkN0gPf13oF3BbqY1dVeMH865lpANOvoiYlEHvqTvy5m4gYVXi3TTKDhu0G843nJqRg+WpFAHDx1u8c8SVR2CeowJva3qGxCDJw8JEBfrpQEl9ul7sL7fheuYRKvWDi1LtPeohgZOLxKtWCSNQh+rZ8WtA4DfUafC5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254463; c=relaxed/simple;
	bh=12xA9vZWHEWlfjg87b5zxlPpoze8yMWtiJZMHm3lhsg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EJh8oWO848vyvmHyf52W+B1+BcT0SzszHveD1dyl+b6JaqHuwp1FR7CeVTfTUQWQYXb0xONpUgCRFh68ak7/W2CdhltXhYSvZMFNGtJmZBMVEK15Fs3WqPpxeKxLuSJCm9wIMcbzKPaa7/moI1jzCluXh+zQZckaP0eY2egd5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LNHl7bux; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721254459;
	bh=jLJZz1mJlZuflYdGUU+XE8OTZLPg7gvb9AjSBS/73qs=;
	h=Date:From:To:Cc:Subject:From;
	b=LNHl7buxjYLBiyUC1GZzmRq6r5MyhnbTjQYCUojjRqwwzAPAMBRAEUy6Xo6fe86Vr
	 yKAmK05M7ORRrOB9TWXlgf0mKqABBcDQQ2RPJdhdD2kDfDQcOTv/R5iKOhGlID64GF
	 Y0PyKBUm7ZzxYIK5dfXCy2svUTORWEa8E/grZDAouzB9ihDrP+uogbVxKnt5pGvW9m
	 /8s8yAdUHR9EcFnji0xDorpaCVOfzfsqnjy2PkvX/Oswn14+18KRk91nsB91aa8C6w
	 a3Yzu/PELXv8/tyMHpjfTXmp4+VVqJIgF0/x1Vu7Nd4ONsF7oDDVGBXKVX3FtX6Zbt
	 XelTTY2nbRzUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPVbG6dDnz4w2Q;
	Thu, 18 Jul 2024 08:14:18 +1000 (AEST)
Date: Thu, 18 Jul 2024 08:14:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nfs-anna tree
Message-ID: <20240718081418.7257f5b4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5wzsI1tD99iEomOG+IXcGcy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5wzsI1tD99iEomOG+IXcGcy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c15ed35892aa ("SUNRPC: Fix a race to wake a sync task")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/5wzsI1tD99iEomOG+IXcGcy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaYQjoACgkQAVBC80lX
0GwrcQf/flNc0wVKWLRZ0FO56ZOIwNYa3HrfZskEcr9/VXLgXMloprk9fgDxBb45
YQXtG6JQZyUTxJY67t1kcbLLxav0dq60b9/r6O5DxDbCLRxjYJ6+IPOxKb1CGz68
A266cp425xENdby5p+gsuoU7RPEsPI8Wap7pMM1DaQ0gamGR2KlMWwALj01dYGU3
KkyDxbxQw2KlmiXTAxPadP1B6TW/oqR3eiwnnosaz/ripyskGlJ61HWTFa5JtSTz
g+Sw4v8wclL8u1Qmbk1zW9gOk0OT4JtheqHd8PhlM7iH10TzoTKL45UyZNAsnGLZ
e0lEVa6mTb1XwbA87UyZupXrKnfvBQ==
=UHpC
-----END PGP SIGNATURE-----

--Sig_/5wzsI1tD99iEomOG+IXcGcy--

