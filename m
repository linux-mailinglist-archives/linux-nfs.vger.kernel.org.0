Return-Path: <linux-nfs+bounces-9387-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EEBA163F8
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2025 22:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D475518851DE
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2025 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D031DF73E;
	Sun, 19 Jan 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e/AtAUr9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC901885A1;
	Sun, 19 Jan 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737320676; cv=none; b=AaXVw0lck7LtSps4HbVn4Rj6E5iWgzBDa8lGJJ3aN4jPOo0dq9NYA1G+uPRB4jcpRTYs5TM+D9EKsXAZQ4FPPKuRjVVdQEpZ0zMxtQJwjjf+Z/0A9SDXDOfstnt7kockZiCOUBQelSCcIVK97FyrwTJMrBmqqJesplevza3I1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737320676; c=relaxed/simple;
	bh=5p6JhAyniKyb9enbwJnZ7ltEfDhNtUri/wn0HI/o4BY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MraZbCxwG3u5OGVE75HdnMLYZl5kUij8L79eXzVg94lbIzUcZnbKHVerggteTrsbRSApjziMP6QLn1J6C3P3arvYkk6Or47C1ziZHYHulot2A9ppVz3J3fquwEYs4GfVvZ0gjKt+0CO+SQWtsGVNykQOx8ai5vFIvTAbBeBizdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=e/AtAUr9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1737320664;
	bh=+ILTK5B/EspEgy3VHU/M8C8AKyBZbalVALHT0AaPIG4=;
	h=Date:From:To:Cc:Subject:From;
	b=e/AtAUr98/o1vYu5wku7OFObcRguDyr+3Il/QTzI8A5bDlM+cgzbKVNyl8h9uc5KE
	 yMAPrEHBDb5jiNiG5qUfX8u6HKH81L257rNc248NrXZ/yo6BJQq+QmzI4KF1dj4B8Z
	 hPyCQGcGzmLYkonOxRmMvLVWpIHPP52fpZBo4WgyEgDjxFa7jZk5HLKvRXDau6D1I1
	 eEYXtyOC/jU3+8FCFWy3uMJM7WEpSdup00EnJM0J7+I83mASBH+3hh6r0saQJzP+IN
	 q/H0PN41GOrJOfzKcANLRuAPc+nkbl0o04euWAjVANQQ2YMeQaK0W5WWjIOoiMAsF1
	 zvKSfUZBCySNg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YbmDm3nkhz4wxm;
	Mon, 20 Jan 2025 08:04:24 +1100 (AEDT)
Date: Mon, 20 Jan 2025 08:04:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nfs-anna tree
Message-ID: <20250120080431.4f753663@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qrh2+1M9xkwU84DjEvsE7ko";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Qrh2+1M9xkwU84DjEvsE7ko
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  10c40d82f80c ("NFSv4.2: make LAYOUTSTATS and LAYOUTERROR MOVEABLE")
  c01ac4340156 ("NFSv4.2: mark OFFLOAD_CANCEL MOVEABLE")
  55100b4651ca ("NFSv4.2: fix COPY_NOTIFY xdr buf size calculation")
  ca878023c599 ("nfs: fix incorrect error handling in LOCALIO")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Qrh2+1M9xkwU84DjEvsE7ko
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmeNaN8ACgkQAVBC80lX
0GxsIQf+LH2exIeeEtiY03bZZqHoa2QgD9S+lsDwBOcL2noX7KapIMcu7GV15rjH
Ozbu4rwVQ+01OlbRqIOoTamLfWTN4A3PRUhrR/CtSZQku148SNFl7vgcErelt0jW
rwC9hbsS1KAfYiusbgFHBneg1D3Jz1MDgdXOrcq5x9dchpkQ6mfVKhMAM3SaAV0o
lTrKkzJ0K+goImXfnwz0zq94gnM2E8bltZ8CN7sZKi8W8W2FGBCjONpLaAV8pA5P
zWQykUOu7FytAfuTkbxCFAvBrktcPnZ9r1MvGbPQ6oK1bV7Li3XZzlne8K5QQII0
gmBwfABeUmN/99DGPIQzxeNQZ2votQ==
=xiK5
-----END PGP SIGNATURE-----

--Sig_/Qrh2+1M9xkwU84DjEvsE7ko--

