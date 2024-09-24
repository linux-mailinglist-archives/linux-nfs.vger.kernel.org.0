Return-Path: <linux-nfs+bounces-6625-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D86A983C1D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 06:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB602827F2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 04:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DBC22619;
	Tue, 24 Sep 2024 04:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mR9yz2Eb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78031B85CF;
	Tue, 24 Sep 2024 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727153193; cv=none; b=BT91frV8Aj4nKq5A/ipqkjO65ZTEIg8+uCI6WTtTHJiujtutOoiiPSsc2Rmpo4bEGJIgczdk6ATDJ252PIIE9472V1ZQwUSkEilcVpjsHanFdhpcLQoWoq3aGlOXcpGMiYa3nuKkeQrDaIUbhwKsChf9HkX7LRyt7+AkDSDpTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727153193; c=relaxed/simple;
	bh=Uv98T+R53KNCg7QExl800hN4g2ywFhjy5HhJLVPvHEI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oS6DJWok80NsNwSEAsZ++f0q059jlxLRJbVp2mTTheHv1vbJkz5q7AyXXeg9b9BjtTo1dXldn6IGRn3wL6EoMqknci4ghG5BSWxLkeeBOi6+2COQ9SZ6nmYuKLy8uxnciwjvzhWGKRi0saPOy1Ug2zmWMAevGXbFYH+UEfSmzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mR9yz2Eb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1727153186;
	bh=9P3s7knmsd3pjZsQ/5LZqhO9PKFdM8ZTtkNb22tKDQY=;
	h=Date:From:To:Cc:Subject:From;
	b=mR9yz2Eb9KzvgWTLVOQ7QaU4S5ZFJoXi4mnjSCx5D6p2CBWc7iGhBcti8U90onhsb
	 sJxvNblNtL4FnZsZ3K+T07lmyusRLRMsjWBXjSl2e0q9UIRNdy5zBWgI0V7ZmAUmeq
	 3PL2q/lgPtwv1as+vlJ92VXC+TSFM6pkfcMKXrR5zoNB9oWEQkDwNB2O97WxawUZ8i
	 CPe64nOfJrfD/1h/X8ZTo45uEdJMUI8nJAdfU+HWrGQWtRt6sndxX7bToR3jYcplXV
	 9o005npqR3P48ZWfyp0m+UG7TIpoNlYPbApAn8zUclQevsDsDYddsWaruaAujebC4d
	 tMbw8EIr4n4Mg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XCS4L4K0tz4wd0;
	Tue, 24 Sep 2024 14:46:26 +1000 (AEST)
Date: Tue, 24 Sep 2024 14:46:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Mike Snitzer
 <snitzer@kernel.org>, NFS Mailing List <linux-nfs@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the nfs-anna tree
Message-ID: <20240924144626.3b374ff3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r0oBXvhLC2vXhPzgkA=HOlx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/r0oBXvhLC2vXhPzgkA=HOlx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nfs-anna tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/nfs/localio.rst:43: ERROR: Unexpected indentation.
Documentation/filesystems/nfs/localio.rst:56: ERROR: Unexpected indentation.
Documentation/filesystems/nfs/localio.rst:179: WARNING: Inline emphasis sta=
rt-string without end-string.
Documentation/filesystems/nfs/localio.rst:190: WARNING: Definition list end=
s without a blank line; unexpected unindent.
Documentation/filesystems/nfs/localio.rst:191: WARNING: Definition list end=
s without a blank line; unexpected unindent.
Documentation/filesystems/nfs/localio.rst: WARNING: document isn't included=
 in any toctree

Introduced by commit

  92945bd81ca4 ("nfs: add Documentation/filesystems/nfs/localio.rst")

--=20
Cheers,
Stephen Rothwell

--Sig_/r0oBXvhLC2vXhPzgkA=HOlx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbyRCIACgkQAVBC80lX
0Gw1Kwf9FvKj3y06mibaU6Lj2oEoXICyPp2qQwwu/BxYdNV3MuLOSgQvvUMji3Mm
9xuQ80v/P2lsXPzwK525EDBDZWXR6Re23WfbvTYaHpZ2TB7GZog5HXV4XGMAV6ve
cSFUEnHYPBY6XWahSNHKl+tw+WxhlocjqcsAlsIlcSHMBN/j0/1lKDd4G3a4QSAi
H6M4Ug0rCaz8Y8ktq4HVMz3XMgf1kIE32oz8ChBd53ZtRJ3DG8MwLS1iBiwneipZ
OeN+hI4L1DMfiMCY6wnp7z6zH68knBVKuRxKVx6+KUJ17kk9wNbSPhjVaH4TUQeD
zr6G8QhtfPURWoqASBRKAWpCFshSug==
=0KI7
-----END PGP SIGNATURE-----

--Sig_/r0oBXvhLC2vXhPzgkA=HOlx--

