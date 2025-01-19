Return-Path: <linux-nfs+bounces-9386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892ABA163F4
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2025 22:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B93A5712
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2025 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD66A1C878E;
	Sun, 19 Jan 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X2vYvcq9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D91885A1;
	Sun, 19 Jan 2025 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737320565; cv=none; b=oyj45a9zCfjuvKe+oMGZk9AFFtikPF8Xym5x6aNBL0KcR9u0JRi7hrb9h1m/HNoXdAx6fuBcckIBvDSW4GSNmxLfuHeVRKu6DemIWZYw1D1jnomPoWF0HycQYclePjGmGdB7WwA9hrh43+x2xgXmKUb3ynGfBR9RvYq86+PSUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737320565; c=relaxed/simple;
	bh=BuJKD9hdZ1YMfgcNMkFcuHylRvdp2ci/AsYh82fAJvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IthXWqZ1BYvyo+I0jd2900TsxRTvkcZOXIkFkK5xU6dMeL5vX/SpFq+0/hgZyemSf3FoUdbod5RR+lULGOejUAqJVHF6izhsb81QNaGIYAvMIJ3kNgJmdr+7Yk/17QMhsUXtWYMnxDDq1rqL0hqeo+/HTNJuDtdCfZ+ly/Fm6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=X2vYvcq9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1737320545;
	bh=A7WI8ztHvjdmtlYC+DmwAZxZXm4ZpNvBV338o7cB6F4=;
	h=Date:From:To:Cc:Subject:From;
	b=X2vYvcq9BrIDYpx9h6pMcmwNH+nHE9ZEfi9xzeJv3aqy4RziwhvGMp7CMZulrOsqn
	 8fk2kgph03iBhLR/Gc1QklPzcnekI+8AlsgZYmuVBueEhXd8LrTmtjYEN0W3Qr+TG/
	 cDiSSpZ2xcJx2FtQFRp4tbtgsBXLt0RRPRVfaluAzDCbXkoWGNH4tXcwx0rXl/OTMg
	 qIPlwQfqcK/uDXrWvM8pVXTvh+woL9lQEwLm+iJn8f2T262XZCK6KCRwhyj9ZCx3rc
	 ygJlt6LzIyoLimQP2pMtGvxW9H75p4AKrGjPtW+Lno5DGcJVSn2rKIpOKlU7Cml0qV
	 mhbDfRYi8pQCw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YbmBT0ZL8z4x5J;
	Mon, 20 Jan 2025 08:02:25 +1100 (AEDT)
Date: Mon, 20 Jan 2025 08:02:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: NeilBrown <neilb@suse.de>, NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: warning fetching the nfs-anna tree
Message-ID: <20250120080212.26c96b53@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J=y/JaxlEElProi8Nms5fRv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/J=y/JaxlEElProi8Nms5fRv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the nfs-anna tree, today produced this warning:

Commit

  d9f3e89b21a7 ("nfs: combine NFS_LAYOUT_RETURN and NFS_LAYOUT_RETURN_LOCK")

added this unexpected file:

  fs/nfs/pnfs.c.orig

--=20
Cheers,
Stephen Rothwell

--Sig_/J=y/JaxlEElProi8Nms5fRv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmeNaFQACgkQAVBC80lX
0GzQXgf/Ugpe3CQrVIF+s68Ob1s4JP1gF9libzEZJ+9F72rBjRKMPCTYU7Xv73/Y
QrfgYntXos9Z3YqsxsEttIT47p0qTzF1/zqg0olBzWuCARxxf2WMkHQhnHhLZmMO
uJg5ZnXjWhoAvgN397JjrnZHXjMIrbWF8jTYzLLHiZ+q/W4jMIeNrt5pfWTfxHIu
iQF1Nu+SKcb71wwaOFjCQzDHhhZsiapE7lGjsQbzVtuw4zog/kbtfq0g6OX2tBk3
zjLxvXaIrUeE2nwmwfAIECwoOLNmCNBUmfh6ulapXU510Vo5Ktn9fNALoSPE/+8h
S2S+gX7Ax9xDwyDJOnT4y0ncH8b+VQ==
=mNMu
-----END PGP SIGNATURE-----

--Sig_/J=y/JaxlEElProi8Nms5fRv--

