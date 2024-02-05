Return-Path: <linux-nfs+bounces-1792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95F849FBE
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 17:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DA81F22561
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B988D3CF58;
	Mon,  5 Feb 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7WLNGl7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44703CF65
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151575; cv=none; b=pYd/HD+c1qUe6aVKGz7jjYW57zda67zmvCeg5g0U0YobvfaP2vJsjyK1XHAUQDSP/8bQ8WHpqDzgmfsSl7W314LvVCZexTR854xxUAwJLyWwrYROOffEE9tuRRYkiL8J4Uat1Dmut2RBvlVU4sENiW618HspEQ4t+KoZcGckx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151575; c=relaxed/simple;
	bh=5zZ6DiAA6VzdztMdUtGUEADKWFK0bVeSRSjQ7dsC5D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXCC8flGyMwQ7tm9ijEAT/ksBtRHTdx9puC96WL8l2UmNlak3lGVsGiphiArJEiaPEt9dKEeDijB4oqFcpVhSSbOvt4m9hDW+fTOb2VSnRB/OUraEjz6eT/+yMFMkVB/uQV6WE2ePq37H4B7NaXqgNP9J/3Dkpu0tAl1D5ahDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7WLNGl7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707151572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1B76+a887AJ9ybDmOzO/zZgFM1hBidtLb9z3CpvpCtE=;
	b=O7WLNGl7x5byWD1t4e5UlKUHgd64TfTmScMPlfh00jP3ylN6H3s6zHzbv2IuNgg8LiWfhh
	8R6i1P09wbasOe0h1hMmXdMnj1AV63WurGvjMbza7UjpdaPuU5aPSQZkooGkWz39lWSjtF
	Or0yb/7VT5Q/6UOi937NW0UtLOrC8uE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-vRgoctMbP-S1necBILeMWw-1; Mon, 05 Feb 2024 11:46:11 -0500
X-MC-Unique: vRgoctMbP-S1necBILeMWw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33b250a4bd7so1335664f8f.3
        for <linux-nfs@vger.kernel.org>; Mon, 05 Feb 2024 08:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151570; x=1707756370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B76+a887AJ9ybDmOzO/zZgFM1hBidtLb9z3CpvpCtE=;
        b=KSAQGDF/pjrVXt/nY0uS9LcKpfVpO29CMl8VDNj+mw2/SIp9Ohc827E2+Wly9symkZ
         cW8shquKVlDgv5PD3AmXBPTGp3Y6ZXEs21G+QlPVwt+4YU9NA4DSoRa5r5SGAnxM1Vjp
         zlS0xCMi34g3XiXd/PD8CwSCf0iOekMfsJIoEo4iqQedejM/uvslYfFZEjX/qL3/v/qY
         fe9rND0l7J4qU5tJe0aBNZnvYku6iWlaSGvZb8I5yWeFkaEfIHpAOiE0xJb71yfF20e3
         EJps6uYmhvpJiGl19gXMbY4rkYI2uJYHby7iOC/5eJYTmxl7qd07go7AB0fYpC3wg/Gr
         RELA==
X-Gm-Message-State: AOJu0YzjSYWwdDF4Q5sonTE7o6vPcA6DFNcExRAjn0vWQQTPURSUbvXO
	vQ3tD85W3Kv4qX6GaeFpjSp9Exf4x9sUyNlM1U7Az4wsr+PWBxN0PwiJoQllwasOwIoLilzF2F7
	80sSQOc0MgqJy1m2vw46CF6Qdonh0xWyCCypPtlpEUQiGZu+/jDg9VyH7nw==
X-Received: by 2002:a05:6000:142:b0:33a:f855:d5b with SMTP id r2-20020a056000014200b0033af8550d5bmr76164wrx.11.1707151570066;
        Mon, 05 Feb 2024 08:46:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0zIRSdC+3NFlQ3p/g9FrgIX0bj/Swhae6oo+ysGrEJbRMZsQb1HzoIk1CiPtQfHwmP6iJBQ==
X-Received: by 2002:a05:6000:142:b0:33a:f855:d5b with SMTP id r2-20020a056000014200b0033af8550d5bmr76142wrx.11.1707151569542;
        Mon, 05 Feb 2024 08:46:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVARBqN+8ik/a71M/fr5kKUwQ2NQpW7KFkv7Z2P5GMgAiupXMRbvrQObe/fMlC5bskdsVxgQuZX5BR5HVP2kaiQXNxzsAGWplYAV85K+l/rPDoLNynHE4fhUFpYgmw2cXQuk9frUwUwS5Hi93B3lO9HwUspSXg/cZ1zBfZXy2ZxP4+oQ81U4Nl6B6xRldw71CMkUJk3OC6TQXTfWpmM3d/vlDshkNR2dBYh1bwHEGLWl9T4hacwia4=
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4523000000b0033b17880eacsm13188wra.56.2024.02.05.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:46:08 -0800 (PST)
Date: Mon, 5 Feb 2024 17:46:07 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	"olga.kornievskaia" <olga.kornievskaia@gmail.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
Message-ID: <ZcEQzyrZpyrMJGKg@lore-desk>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
 <Zb0hlnQmgVikeNpi@lore-rh-laptop>
 <e706a77b4ddbceeb8b0ebac4dcbca03f8196e8a5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="41hxKUPJ+PtSz3ku"
Content-Disposition: inline
In-Reply-To: <e706a77b4ddbceeb8b0ebac4dcbca03f8196e8a5.camel@kernel.org>


--41hxKUPJ+PtSz3ku
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 2024-02-02 at 18:08 +0100, Lorenzo Bianconi wrote:
> > > The existing rpc.nfsd program was designed during a different time, w=
hen
> > > we just didn't require that much control over how it behaved. It's
> > > klunky to work with.
> > >=20
> > > In a response to Chuck's recent RFC patch to add knob to disable
> > > READ_PLUS calls, I mentioned that it might be a good time to make a
> > > clean break from the past and start a new program for controlling nfs=
d.
> > >=20
> > > Here's what I'm thinking:
> > >=20
> > > Let's build a swiss-army-knife kind of interface like git or virsh:
> > >=20
> > > # nfsdctl=A0stats			<--- fetch the new stats that got merged
> > > # nfsdctl add_listener		<--- add a new listen socket, by address or h=
ostname
> > > # nfsdctl set v3 on		<--- enable NFSv3
> > > # nfsdctl set splice_read off	<--- disable splice reads (per Chuck's =
recent patch)
> > > # nfsdctl set threads 128	<--- spin up the threads
> > >=20
> > > We could start with just the bare minimum for now (the stats interfac=
e),
> > > and then expand on it. Once we're at feature parity with rpc.nfsd, we=
'd
> > > want to have systemd preferentially use nfsdctl instead of rpc.nfsd to
> > > start and stop the server. systemd will also need to fall back to usi=
ng
> > > rpc.nfsd if nfsdctl or the netlink program isn't present.
> > >=20
> > > Note that I think this program will have to be a compiled binary vs. a
> > > python script or the like, given that it'll be involved in system
> > > startup.
> > >=20
> > > It turns out that Lorenzo already has a C program that has a lot of t=
he
> > > plumbing we'd need:
> > >=20
> > > =A0=A0=A0=A0https://github.com/LorenzoBianconi/nfsd-netlink
> >=20
> > This is something I developed just for testing the new interface but I =
agree we
> > could start from it.
> >=20
> > Regarding the kernel part I addressed the comments I received upstream =
on v6 and
> > pushed the code here [0].
> > How do you guys prefer to proceed? Is the better to post v7 upstream an=
d continue
> > the discussion in order to have something usable to develop the user-sp=
ace part or
> > do you prefer to have something for the user-space first?
> > I do not have a strong opinion on it.
> >=20
> > Regards,
> > Lorenzo
> >=20
> > [0] https://github.com/LorenzoBianconi/nfsd-next/tree/nfsd-next-netlink=
-new-cmds-public-v7
> >=20
> >=20
>=20
> My advice?
>=20
> Step back and spend some time working on the userland bits before
> posting another revision. Experience has shown that you never realize
> what sort of warts an interface like this has until you have to work
> with it.
>=20
> You may find that you want to tweak it some once you do, and it's much
> easier to do that before we merge anything. This will be part of the
> kernel ABI, so once it's in a shipping kernel, we're sort of stuck with
> it.
>=20
> Having a userland program ready to go will allow us to do things like
> set up the systemd service for this too, which is primarily how this new
> program will be called.

I agree on it. In order to proceed I guess we should define a list of
requirements/expected behaviour on this new user-space tool used to
configure nfsd. I am not so familiar with the user-space requirements
for nfsd so I am just copying what you suggested, something like:

$ nfsdctl=A0stats                                                 <--- fetc=
h the new stats that got merged
$ nfsdctl xprt add proto <udp|tcp> host <host> [port <port>]    <--- add a =
new listen socket, by address or hostname
$ nfsdctl proto v3.0 v4.0 v4.1                                  <--- enable=
 NFSv3 and v4.1
$ nfsdctl set threads 128                                       <--- spin u=
p the threads

Can we start from [0] to develop them?

Regards,
Lorenzo

[0] https://github.com/LorenzoBianconi/nfsd-netlink

> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--41hxKUPJ+PtSz3ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZcEQzgAKCRA6cBh0uS2t
rMzaAP9l/bpJg/6gB+MNuLKKcUo69a1XDPGkA58cOl73C4UccQD+KtqT87L+S1ey
s5iI5MvECARMKsyIS8BeD+yoNMkM3gY=
=50pK
-----END PGP SIGNATURE-----

--41hxKUPJ+PtSz3ku--


