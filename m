Return-Path: <linux-nfs+bounces-8999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F71A06766
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9E77A315C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6E2046B1;
	Wed,  8 Jan 2025 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W85768rN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A02040B9;
	Wed,  8 Jan 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372713; cv=none; b=NauYpNPt/8NAZsIgkeykN3b9+V9vSO5Z+W9405x1R4ZhVc+6ibnSXf67jC9CHu35MqJKDKV3QZpGee3tu2JJe/RzuquLd1zgpYu74PGVKuLTIfWt+E6GaSdpESfYC9ICh/Q37YXngTCVqQ5nIZmm1lL95LYWXpv43DICgKxmw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372713; c=relaxed/simple;
	bh=X0aAD+o4Opsr95XHrthvpsnLVv6sXFdpfvO1nU4p1Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SrXJCTZQ4dUQ7Ma/uSwdIg3mYNLqs6C9jpxpbJk+SnOFpji7+rLN5NSUGTNBLcIBfImf32FHxgmMq/E3DnztoJqMgos9YIwwltX96kDqLxGitqo6DPMQplrAkas7JUwTa3MC78DDwFZ2RTeKIF2c+eZJUPAYPdFkcb5Pms1eMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=W85768rN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1736372697;
	bh=5y5fC8vBsfLkwmxzYmaRRRrfDFBy7Wm7ZUP1hlHJ7ww=;
	h=Date:From:To:Cc:Subject:From;
	b=W85768rN3aphxMKKtm2ieL4jVLE3PuomIEWwdKJNYrr7oQCZVRfBB7j1wn3WyNVoC
	 DF+DdWp0CKPDhyvJ+Cfy1FCbPdX/4IIzOKLVm/02LcG8xlxlshifxxtgBB/+KmLxTF
	 hOzT7K6Ewq5Oi6na3RW7chIPCapj+23PNIXdIsRIQUYjdkMY/m3kRvsLcEFtvPV8y1
	 ZEgAJ9J7xLtx3h3bh8AVLQmtPQwBPcmYD3MUj6nVlfiJ24fP/+/j1T3RmjqNZj3Kyy
	 nNhZhPJyMKmTByh7Qibcah4ZmNWXikasYeaqeiBCIcA3fimfy+1vKKyzOu3Ayh1EML
	 GfC6MTfrEiX3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YT1fd2P1Qz4wc4;
	Thu,  9 Jan 2025 08:44:57 +1100 (AEDT)
Date: Thu, 9 Jan 2025 08:45:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: NFS Mailing List <linux-nfs@vger.kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Mike Snitzer <snitzer@kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the nfs-anna
 tree
Message-ID: <20250109084503.1e046ef7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e2WIvSe0jOiXRtiGlQHwXfK";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/e2WIvSe0jOiXRtiGlQHwXfK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/nfsd/filecache.c

between commit:

  735aab1241ea ("nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_=
file")

from the nfs-anna tree and commits:

  f905e00904cc ("tree-wide: s/revert_creds()/put_cred(revert_creds_light())=
/g")
  51c0bcf0973a ("tree-wide: s/revert_creds_light()/revert_creds()/g")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfsd/filecache.c
index 2adf95e2b379,dc5c9d8e8202..000000000000
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@@ -1255,8 -1247,8 +1255,8 @@@ nfsd_file_acquire_local(struct net *net
  	__be32 beres;
 =20
  	beres =3D nfsd_file_do_acquire(NULL, net, cred, client,
 -				     fhp, may_flags, NULL, pnf, true);
 +				     fhp, may_flags, NULL, pnf, false);
- 	revert_creds(save_cred);
+ 	put_cred(revert_creds(save_cred));
  	return beres;
  }
 =20

--Sig_/e2WIvSe0jOiXRtiGlQHwXfK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmd+8d8ACgkQAVBC80lX
0Gxk8Qf9EWDqLoE66YL1N0TYXR8PVajbp8UQifNuk5g7O2Exet1J1DbiiDh0LEtd
b99KDrYM3RRJcHeMk5UVWeoJPX33RcjNFvu0m6oIR2kagqFs8w6cI6Sl9AtH3hDw
XzbbjhCwMISPtkyziD5hcmk79Ro3EGgdlBb4jgLsrdzkPtSLUPbVG5ybLShgAP+q
VwhlPrZr4paZj0T7MWPjBj/iIyz7d6TM2Xh4x3AGxK9dOuLklZ9Oau1o+bUkGvd6
B2A9MCituSiaC1QxSeWHBNPpMBF6nWOr2sL4jxD0EoqPi9AouISnwNHyKLkHGKTc
+aSfRQZhuJFaFbgWSKp8nlkQB4PWWA==
=MK/l
-----END PGP SIGNATURE-----

--Sig_/e2WIvSe0jOiXRtiGlQHwXfK--

