Return-Path: <linux-nfs+bounces-1794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBD584A129
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 18:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC66B23118
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FDE47F76;
	Mon,  5 Feb 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOC91Zy0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEF47F53
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155075; cv=none; b=AopnAQCePUBU+20obADm6mWS6RBWle0dS0kYRpNJedIIajJ7nyFHs6qOFdvMGW2ENrbm0fpHDRzboQA65oPcTP8ylyG6aJbLB8Mzf2LroTtW/M8QYqeUg+t4sH+pqhu5fFYd8XHAShWFeUKZ4Ft3WFel7xuzwZh2xJZ6bvEkPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155075; c=relaxed/simple;
	bh=13kjaWEcsqV8eT4ufuiXkpNoJxuFUA6MLPwg3ICVJoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBZVr7Sa62MvTfz0g04rNd3hDkDaXMMMbNVUaz62W/8bcLB9yTgGS/0+yWSOJY0Qn8CukNpZ/rB0i2wy0pPkplJ0aKOPdZKj/gsaAxCd4hiHTpGFhM/YXeY2KGhqUXjTexT1Z400kr76PIxYGgbUOpLVIILLWDwJ7eMb4p7NysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOC91Zy0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707155071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAa1DUfWQvH/b7Y1UlOawH4JMVYFw8tQeLQXOx3zzDI=;
	b=EOC91Zy0WfnjLpqK7ax0NC8H3BRbQydh9posgQCIjbhU1QKokJ2zPAvvBahWj6PJVC03Tr
	cSYMZV8V0g2nwVtyRp95fD54ie+sMaMUnuVFd7q8g77dxulFGIOeRhLIBYnUw9nStBAi4H
	2rXpyOs7p3/ohAOOXiYjYu0kC9J/UzE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-5FsQIl5TNqi6MkC2uxZoAw-1; Mon, 05 Feb 2024 12:44:29 -0500
X-MC-Unique: 5FsQIl5TNqi6MkC2uxZoAw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40efad468a5so24543455e9.2
        for <linux-nfs@vger.kernel.org>; Mon, 05 Feb 2024 09:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155068; x=1707759868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAa1DUfWQvH/b7Y1UlOawH4JMVYFw8tQeLQXOx3zzDI=;
        b=aSkxzh3FAwBwGT8sasqbUS4qevnMoENOgrJv7LGOIHLJU0stFsrlF7gxsHUgHJutHI
         YN22lBSs6KFskol7zkSJg1IY/JwQfOZ+Z5zznVOjZwZlkXvZ+UZTt2RJsv62gZLrYV96
         fiB9KMbVE8Sf2/DfHGQMOxlE+jMVKI3dxK/uTmCUmoVMDN6OKpCg0NacguIGOEc7hQuQ
         ZFCxtQ1xsOlSDeGNvQXHsdRgMQBQiFq9D/hTz0zwWxx5cjS7XkACbg8PL+KK9hcu8tq3
         uC20g+vVMzdogu6B2fyFZJydmuJE5D5KU4YAWlEhLQrRHB4c/T6Vlp46xJzMzObzEwju
         l5ag==
X-Gm-Message-State: AOJu0YwCBecprOoqt0BwCgGKguTs9Rv1EPlb0hv8wrbjiF/iayFS+14P
	QmGY5wFQmiBsRahG7Tg5/O13yH7bFo7hy3k4FMhpZNIx8QjwUOlKhBWTRziauNaygDcycDBwVKH
	t1aGxmnpiFD41IQckWNj5vSwEsbAsB/WvMCb8/PJhFkRMrvkAXyGyTRO9TQ==
X-Received: by 2002:a05:600c:1d1d:b0:40e:88b6:4eac with SMTP id l29-20020a05600c1d1d00b0040e88b64eacmr301459wms.3.1707155068673;
        Mon, 05 Feb 2024 09:44:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUmHhVy1uTpqaTjfCcw5MHgDvbV5v3l3Tg9bgMei6zMQ7TKpwhZEWhlztTfm2VQbP1/2QknQ==
X-Received: by 2002:a05:600c:1d1d:b0:40e:88b6:4eac with SMTP id l29-20020a05600c1d1d00b0040e88b64eacmr301444wms.3.1707155068253;
        Mon, 05 Feb 2024 09:44:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUkcToFXjLEdAdIiy94fMNLqhNgnyG59aChCgrdhrcgwjPhrZnhy3+w7J8fKsgeL0AWjti13FEnWguFpu2WmU3yYEJvMXNYy0VbBLH2jabNzUYoytPfNGbNDTgT8BGbxorS4GO3C7D35hzPnGRikIv2oJunZqdzpo6tORegzo1ai8ctyqc2VfnVJuOG4TKeH2GcI3v60bN9uE5IykPX9nMzsx3jXdbGdvgwmBA7NVTqMLcvI+sDHXU=
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0040e4733aecbsm512363wmq.15.2024.02.05.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:44:27 -0800 (PST)
Date: Mon, 5 Feb 2024 18:44:25 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	"olga.kornievskaia" <olga.kornievskaia@gmail.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
Message-ID: <ZcEeeRrYOQsKOPw_@lore-desk>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
 <Zb0hlnQmgVikeNpi@lore-rh-laptop>
 <e706a77b4ddbceeb8b0ebac4dcbca03f8196e8a5.camel@kernel.org>
 <ZcEQzyrZpyrMJGKg@lore-desk>
 <799dc278c5d15605e1535303a7a15dee4eef82b3.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ayO4eR3f6pk4ILW8"
Content-Disposition: inline
In-Reply-To: <799dc278c5d15605e1535303a7a15dee4eef82b3.camel@kernel.org>


--ayO4eR3f6pk4ILW8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2024-02-05 at 17:46 +0100, Lorenzo Bianconi wrote:
> > > On Fri, 2024-02-02 at 18:08 +0100, Lorenzo Bianconi wrote:
> > > > > The existing rpc.nfsd program was designed during a different tim=
e, when
> > > > > we just didn't require that much control over how it behaved. It's
> > > > > klunky to work with.
> > > > >=20
> > > > > In a response to Chuck's recent RFC patch to add knob to disable
> > > > > READ_PLUS calls, I mentioned that it might be a good time to make=
 a
> > > > > clean break from the past and start a new program for controlling=
 nfsd.
> > > > >=20
> > > > > Here's what I'm thinking:
> > > > >=20
> > > > > Let's build a swiss-army-knife kind of interface like git or virs=
h:
> > > > >=20
> > > > > # nfsdctl=A0stats			<--- fetch the new stats that got merged
> > > > > # nfsdctl add_listener		<--- add a new listen socket, by address =
or hostname
> > > > > # nfsdctl set v3 on		<--- enable NFSv3
> > > > > # nfsdctl set splice_read off	<--- disable splice reads (per Chuc=
k's recent patch)
> > > > > # nfsdctl set threads 128	<--- spin up the threads
> > > > >=20
> > > > > We could start with just the bare minimum for now (the stats inte=
rface),
> > > > > and then expand on it. Once we're at feature parity with rpc.nfsd=
, we'd
> > > > > want to have systemd preferentially use nfsdctl instead of rpc.nf=
sd to
> > > > > start and stop the server. systemd will also need to fall back to=
 using
> > > > > rpc.nfsd if nfsdctl or the netlink program isn't present.
> > > > >=20
> > > > > Note that I think this program will have to be a compiled binary =
vs. a
> > > > > python script or the like, given that it'll be involved in system
> > > > > startup.
> > > > >=20
> > > > > It turns out that Lorenzo already has a C program that has a lot =
of the
> > > > > plumbing we'd need:
> > > > >=20
> > > > > =A0=A0=A0=A0https://github.com/LorenzoBianconi/nfsd-netlink
> > > >=20
> > > > This is something I developed just for testing the new interface bu=
t I agree we
> > > > could start from it.
> > > >=20
> > > > Regarding the kernel part I addressed the comments I received upstr=
eam on v6 and
> > > > pushed the code here [0].
> > > > How do you guys prefer to proceed? Is the better to post v7 upstrea=
m and continue
> > > > the discussion in order to have something usable to develop the use=
r-space part or
> > > > do you prefer to have something for the user-space first?
> > > > I do not have a strong opinion on it.
> > > >=20
> > > > Regards,
> > > > Lorenzo
> > > >=20
> > > > [0] https://github.com/LorenzoBianconi/nfsd-next/tree/nfsd-next-net=
link-new-cmds-public-v7
> > > >=20
> > > >=20
> > >=20
> > > My advice?
> > >=20
> > > Step back and spend some time working on the userland bits before
> > > posting another revision. Experience has shown that you never realize
> > > what sort of warts an interface like this has until you have to work
> > > with it.
> > >=20
> > > You may find that you want to tweak it some once you do, and it's much
> > > easier to do that before we merge anything. This will be part of the
> > > kernel ABI, so once it's in a shipping kernel, we're sort of stuck wi=
th
> > > it.
> > >=20
> > > Having a userland program ready to go will allow us to do things like
> > > set up the systemd service for this too, which is primarily how this =
new
> > > program will be called.
> >=20
> > I agree on it. In order to proceed I guess we should define a list of
> > requirements/expected behaviour on this new user-space tool used to
> > configure nfsd. I am not so familiar with the user-space requirements
> > for nfsd so I am just copying what you suggested, something like:
> >=20
> > $ nfsdctl=A0stats                                                 <--- =
fetch the new stats that got merged
> > $ nfsdctl xprt add proto <udp|tcp> host <host> [port <port>]    <--- ad=
d a new listen socket, by address or hostname
>=20
> Those look fine.
>=20
> All of the commands should display the current state too when run with
> no arguments. So running "nfsctl xprt" should dump out all of the
> listening sockets. Ditto for the ones below too.

ack

>=20
> > $ nfsdctl proto v3.0 v4.0 v4.1                                  <--- en=
able NFSv3 and v4.1
>=20
> The above would also enable v4.0 too?
>=20
> For this we might want to use the +/- syntax, actually. Also, there were
> no minorversions before v4, so it probably better not to accept that for
> v3:
>=20
>     $ nfsdctl proto +v3 -v4.0 +4.1

according to the previous discussion we agreed to pass to the kernel just t=
he
protocol versions we want to enable (v3.0 v4.0 v4.1 in the previous example)
and disable all the other ones..but I am fine to define a different semanti=
cs.
What do you think it is the best one?

>=20
> So to me, that would mean enable v3 and v4.1, and disable v4.0.
> v2 (if supported) and v4.2 would be left unchanged.
>=20
> > $ nfsdctl set threads 128                                       <--- sp=
in up the threads
> >=20
>=20
> Maybe:
>=20
>     $ nfsdctl threads 128

ack

>=20
> ?
> =20
> > Can we start from [0] to develop them?
> >=20
>=20
> Yeah, that seems like a good place to start.

ack, I will work in it.

Regards,
Lorenzo

>=20
> > Regards,
> > Lorenzo
> >=20
> > [0] https://github.com/LorenzoBianconi/nfsd-netlink
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--ayO4eR3f6pk4ILW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZcEeeQAKCRA6cBh0uS2t
rA/aAP9Natx9nC8aLKnzmXABa4eW5gvRmb7PbD34Mt/ZEJwvgwD9FEDh4QeBzfRZ
4KP1Un6GuWaBNndgTmjeklrSwLtwAgA=
=0aJ1
-----END PGP SIGNATURE-----

--ayO4eR3f6pk4ILW8--


