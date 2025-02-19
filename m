Return-Path: <linux-nfs+bounces-10199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BCA3CBA6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 22:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7EC3B0240
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 21:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F8A2580CA;
	Wed, 19 Feb 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tQgXeAfh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976F1C5F35;
	Wed, 19 Feb 2025 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001203; cv=none; b=ed+Koxpx4oadr6HZiV/b/0zRyLClOqAdZENJzc6CFe3RQ0Csu0fd++U8vjRO+UreMFIKHTeo9962j++ggLW/NwyvPtibT6N/q1GDKIJdDtnnhPlCU2D5nUJHJmjPpEEihjI7GazjsKpsV/4pb6s3rkpqSQQQTr2Ee6xZBCPcdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001203; c=relaxed/simple;
	bh=D5yQRlgjz8pIf0S3EvuJaVVxsdibweNfwCw0CARbfq0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=judr84lYDmpS48eb4Jv3nvz3fzxkZ91qY1mCI2wLRf/3U2K6uu0mtJWQMXqtf/pyQp87nXfhReR+1yiQug7o7xbP7OWS8jD3iHk36KCM5HITd1eHfVD2dksUIVSMGg21bVqrj25OVbHEuJ7n5E4z5vV6wyub9lyCqLCYZIjaK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tQgXeAfh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1740001194;
	bh=cIogJHhgqGA5f5yLXpjO29DTGRFoxWFnIadtsybhlqQ=;
	h=Date:From:To:Cc:Subject:From;
	b=tQgXeAfhhUkXRbZ/gaw9IWQKawVcPwHCiM6M0zlb9kuMGYtsInxP6W3gXDl8eaCno
	 k/ZnqbcPadEsHSwowZOHLR2vii2EpckOd6GB3oQwobcrpVLPb1i8FPI3H8R5jUueyx
	 ME3BjCFN4m6yZHQNV2sOiEiJ0TMu83qeoWx9FeinbB0zz9NdYVVYiRclHTEOqeL6mo
	 9iOq/7LjKUgxzTNCB6sRuTGAqo0jD6DNemb36Km0qhgGTCjmzBt0/SFjIfDxDo/NLs
	 /wnuGaomqpHNxOkEmLQh1oqn5bmy2Uk3bphQekWJc46jhaEnr0doXhL7+niFeTEQD1
	 ZNZpBHYySBRRw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YyqYQ4CQGz4x2c;
	Thu, 20 Feb 2025 08:39:54 +1100 (AEDT)
Date: Thu, 20 Feb 2025 08:39:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>,
 NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nfs-anna tree
Message-ID: <20250220083953.12e3ad01@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V=bh8+aeNG+zXVz8hrEld.k";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/V=bh8+aeNG+zXVz8hrEld.k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There are 2923 patches duplicated from Linus Torvalds' tree in the
nfs-anna tree.  It is unusable in this state, so I will drop it today
unless it is updated very soon.  It looks like an attempted rebase onto
v6.14-rc2 went badly wrong :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/V=bh8+aeNG+zXVz8hrEld.k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAme2T6kACgkQAVBC80lX
0Gzd4ggAjS2kcHFzQFQGuKtc4LdcsIgxBhNYrkzfhCM2MW12uu7HKH6rKZTT5A2w
YyiUNBRagVBh4Ao3OMuKGlQrYZVK9vHDvib0TUxmI53Lva2c+pqIF40+8hn0kNHf
fnICQsF+rGkjh0g3Yru6Z0LBE8lLOI1eMvIGtyzKUHopwzO1KRnigxHHTU6nRZn7
FhmEQUn2o4dW01SciUnxCYQvECrnZeCkgZvKiEC4khTBYB887UA0ZKQA9nFQK5hS
26CS65iMOYFBhl27LHni90RMn/sI7qUe3Of5QDKJQ1MEs0Bv+BlIV5KH8hpfivid
NbfJKz2PRfwl3pEn8qKYOfpExANp5A==
=AZTQ
-----END PGP SIGNATURE-----

--Sig_/V=bh8+aeNG+zXVz8hrEld.k--

