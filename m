Return-Path: <linux-nfs+bounces-9009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63ACA06CE0
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 05:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA80B7A2517
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 04:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174513B2B8;
	Thu,  9 Jan 2025 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qPAp8JPx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC822D052;
	Thu,  9 Jan 2025 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736396637; cv=none; b=JwHnQKK+bY53OKhILQwogxOZEA3X6qdIMB0/W2Q2SdUkSWHNZOMlsK1QH2pC5CpE4KxTpdxYkZP9P8BCmiwia4vxLCqeml7tYQloALQ0dR0bHF6EibRM0saDxV94CGtkdZUztbX8AIXsyhtuXZejcdqLtQepMUWOru3IBZUG5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736396637; c=relaxed/simple;
	bh=spdTS9iR+RIoAo2q6w1NgnY7g3M/Dzt6qy6HJYyopvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hwxNI9IZ1WOOI9HP4B4wFq9Ov+w7+cd3cmfvuNo2tQbZJXP9sRtJAF+sb4uCizizUbNY+lppmCglKY+eFnwYHeSGtRh6/j6bBzJlJ45gjV9EAcemvjb7IXy/ITAU4zDp8EqZmw8W7UleKQikSeFji/I7ODqf0edfwrEak/C7/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qPAp8JPx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1736396623;
	bh=NPPD3LzGb2++9e0+9IH3UpO10alHsxkHFOY/Dk508cM=;
	h=Date:From:To:Cc:Subject:From;
	b=qPAp8JPxnFBcAHDcJ6vfzM9hM/ZKCaAQJKtgRL0REo9f7iEnS2vCQsMiBrZt3V66S
	 u+sz9XpM41tAyOk6WF4TCs5OIfwTS87jkLuctdVlUS2VSUIPLBJXcNVce+F6pz8kM5
	 hWQn47fh7v2h4QanWD5SnpuVtIalGdLezadA9lSV/2oWlqdqj4HkJF6nQUMRIsz4w8
	 tErgFoizd9IpOzQ4D7azf5bX0RoB5DD9cyPMXkc+sYegDCjyydu5983r00Xsr00NMA
	 nt96qYCk6GB/UMLCQLt0mWOM+WuYnRDGiNeNzYsfp4h6mx1bGKzC+/8oO08Z1cJB8b
	 XmmFQ9OQBAj5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YTBVl25Dzz4wc2;
	Thu,  9 Jan 2025 15:23:43 +1100 (AEDT)
Date: Thu, 9 Jan 2025 15:23:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Mike Snitzer
 <snitzer@kernel.org>, NFS Mailing List <linux-nfs@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the nfs-anna tree
Message-ID: <20250109152349.46442c56@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dQDCW+9Okr+3scrclA1zfyC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dQDCW+9Okr+3scrclA1zfyC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nfs-anna tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/nfs/localio.rst:284: ERROR: Unexpected indentatio=
n.
Documentation/filesystems/nfs/localio.rst:285: WARNING: Block quote ends wi=
thout a blank line; unexpected unindent.

Introduced by commit

  cc1080daed34 ("nfs/localio: add direct IO enablement with sync and async =
IO support")

--=20
Cheers,
Stephen Rothwell

--Sig_/dQDCW+9Okr+3scrclA1zfyC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmd/T1UACgkQAVBC80lX
0Gy9cwf/Z9K+puC1b3IsX76YGr42seAZ3q0EEICZxq/cR9h5KBOaB+dL5ohezYJU
Y/rVYPodEIJ0h1Mk0mu/C2UHqGWXD/DoxajOBgSJBc5CKsrHFQDQsFWgk/NhlhUd
dGGKA1UHJwWy0b9g9PpL0LJzxrMMI2zxFLkgHaLxDVwGH71OLZ7c8HtbzO9TdKjC
6opO+hZUVYSyS/KUqE68tDy87pPXby2ibjVZN/pdaiqd67ryZAzTKCa0gIpwvM0Q
aOaAYWOEQeR2lAF4+v3uMO6MppeU8cVJH7Rl+oMOZ3grOUJ2QNq6aRljl+1Y80Ds
RybkK5J6Fx3dvjJTRfevUkBP5pw3Rw==
=KzSI
-----END PGP SIGNATURE-----

--Sig_/dQDCW+9Okr+3scrclA1zfyC--

