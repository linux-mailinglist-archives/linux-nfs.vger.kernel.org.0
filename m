Return-Path: <linux-nfs+bounces-1301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544883A5F1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 10:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7391F2D8F4
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420518044;
	Wed, 24 Jan 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFAr/F4l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB518032;
	Wed, 24 Jan 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089939; cv=none; b=myCGQzfk2UfI95eHyYgZRUBNMdiH/peFU5AYk8O9zTPnnjUxJeUNjGkjaZw67768uCqD2WuZt7NCcQ75EBQ9W2JXBmRsP/FSw4IW87V8nllac4oKxnvm7Xguc81xpIR2cnjTRM8j6ivnwEgp8MfJ1TFWY5KNtr+epfaXox7ru1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089939; c=relaxed/simple;
	bh=FrHhwRT74LzSAxTYDGblPpNTXXJlf04Uj/YWEWBkekI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkFZcp4oZiqwIj+JArRZyXRLJJHaBDVJZ45wVCmIn9kDuOGuea92qhWUsL+w2JL/fgv80gy1E8KmJtmFPcFvgl1MQ60sbddCC7m82JiGLwmGoBec2nQlTZNmUCxvVXL34BndWRH2ML1GTgdDNBkxfW1oLyIUtFZ4MFgLfArAQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFAr/F4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9891FC433F1;
	Wed, 24 Jan 2024 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706089939;
	bh=FrHhwRT74LzSAxTYDGblPpNTXXJlf04Uj/YWEWBkekI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFAr/F4l3Zj2y3DvLi82KBSvozWVujy2ittCR06wYIJJEG0wU/uBwU770ShDMowmi
	 ptXD6zYI4/IIVGkoIG4PIP/P3P52OpfU4uO2r06rrY07Y1dHBI0j+XX/3T0ll5t0VO
	 CzN3FVRMwZwbXe5+CnMUb9EtF3VfDHbiaCgY+Oc6aa62Bnw9JeX9pGEfTOtuOiAy6A
	 cwuZq96mi+aLxEJZ4wDxounb1SiDd39dbAO6DgVemw76pGp85GuTTlx636qMEJZPdv
	 kRYn+wz4BKQH3aH7ob8CJ1qgQ2RzmI5m3uvjPDmS9pBHB5yW+n/2m/cDACjqdjCVMk
	 F9tY/WEeB7SMA==
Date: Wed, 24 Jan 2024 10:52:15 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>,
	linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
	kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Message-ID: <ZbDdzwvP6-O2zosC@lore-desk>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
 <170595930799.23031.17998490973211605470@noble.neil.brown.name>
 <Za7zHvPJdei/vWm4@tissot.1015granger.net>
 <Za-N6BxOMXTGyxmW@lore-desk>
 <85b02061798a1b750a87b0302681b86651d0c7a3.camel@kernel.org>
 <Za-9P0NjlIsc1PcE@lore-desk>
 <3f035d3bc494ec03b83ae237e407c42f2ddc4c53.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dfijB6BbaqwUDN2H"
Content-Disposition: inline
In-Reply-To: <3f035d3bc494ec03b83ae237e407c42f2ddc4c53.camel@kernel.org>


--dfijB6BbaqwUDN2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> That's a great question. We do need to properly support the -H option to
> rpc.nfsd. What we do today is look up the hostname or address using
> getaddrinfo, and then open a listening socket for that address and then
> pass that fd down to the kernel, which I think then takes the socket and
> sticks it on sv_permsocks.
>=20
> All of that seems a bit klunky. Ideally, I'd say the best thing would be
> to allow userland to pass the sockaddr we look up directly via netlink,
> and then let the kernel open the socket. That will probably mean
> refactoring some of the svc_xprt_create machinery to take a sockaddr,
> but I don't think it looks too hard to do.

Do we already have a specific use case for it? I think we can even add it
later when we have a defined use case for it on top of the current series.

Regards,
Lorenzo

>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--dfijB6BbaqwUDN2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbDdzwAKCRA6cBh0uS2t
rANyAP9i20KXWb/nbg18Mp0jyYE4BoELA+TaXQRtC3o9m9M30AEAjnZNc7Nw6W35
xJMldpec4sHoC/HU7x4qqiUH3e4JzAY=
=Qoyo
-----END PGP SIGNATURE-----

--dfijB6BbaqwUDN2H--

