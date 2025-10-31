Return-Path: <linux-nfs+bounces-15858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF33CC26545
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 18:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 627D63512E5
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA79305E18;
	Fri, 31 Oct 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="kL1pSJjD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B422F3607
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931609; cv=none; b=dEw3krhymGAOj9AXwJmDsypWLQ3R9HCTjdWgu9ic0JA/9atuPrYokoX9DzWthjg6uiLgTSz3a/iP9q1wxlRjo0aaN/TY5Vw8W1dM/ZpuiXfMCu3BOXxStlvHzFazCiPF/xxzbOs+K/Wp1wnBQ2gfZwcQuBEqEDWdvQUahFaw62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931609; c=relaxed/simple;
	bh=kX6ixjj1S/kADGjq+ioiYTpWKH7gnr+DklJP+PanIo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKj4SVIA6XU9P1+23nzNpeW4VxmMSxz9pDpSzJYNXCTdqufxijE4mZmBf56eaouGhh5sOzj/ageuSdLJCHHSARbEVAlqwhDI8cIofXN2wZ64d1zDpyuLQRyvainVuG7kEXNJysrbbS67Fn2mpwEEWtrtUXM7hZN6Y1WAsRiOiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=kL1pSJjD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378e8d10494so24272621fa.2
        for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761931605; x=1762536405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGIj606kC4xu3T3Oefw3/1ddCsFbJDTVthM2Ql8BrhY=;
        b=kL1pSJjDZEMD0BWYA2fsr6btE4EWTqpVZblqPogHPAD9TrK4VPponNEXMNhlHs8r6d
         Ud+ffpZnIxWOvWN10uRgksZLVjST1aSfM/jMIgm+i/Mrl3hCWCUg7Px4RxpCVtqqX/tI
         HN4O8QHtkZ+GphNCHFff1q/tVPQx3WFpIGaAyd/2O5OmLbgbYW6CnssUMZTBvvgAN15V
         vkVE0cR90+NoLARtcvW8SU3u9YRYcBqbR/4N04OSXppzIUE4hY2tDVb3Jnboy9z4t4tA
         gpzOKfw+E1rO1thTto9X1F6+LC/KcCymhNDM5JknVkQsUxD9HIgmcmjNVBYTja1YVSyV
         PicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761931605; x=1762536405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGIj606kC4xu3T3Oefw3/1ddCsFbJDTVthM2Ql8BrhY=;
        b=h5h9jNtUlbgKpc5QBV/j9eeh/1NV1/gXRVb+AhiQknpM4asDQbKF+bTEqT60nFzuQO
         ndJSgyHfNEBtVGGdqYOMrGmLFqXOfsDXvA0cLH3KeZnNXcCSiX1S3146Lfw9Ji4ZsHaC
         EiPGgwyZ/C685b5v7nlG9yTAfx2itB70no8pxg/P5YlSi+z4v/XE6fJ210cjSV5jlXaH
         L65Q+rbt4dBDpgOw6DtZPZ/3eyFY0hZeJZ4VRfJ8iUKbQcKPIgzG/kqlIa7QbFdGNoy+
         YypbVFaGDuWYns37fjmFBfRrpOJTiUqdsX9QHJC1NpAitl/ya0rXrIxN6qrQ+aw1CpjN
         CSeg==
X-Forwarded-Encrypted: i=1; AJvYcCX2LdihNPvQVc68b2dBggm+7TukXI0X+hK0XwO5WqdPd8+5KaGSQZHKt9woVOKqDO/X438Ejno0Yjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BLe7RmVPHQDSQ77kuzwopegvPyEcH4eHvzu70K4zZAdQEb9m
	3GfYp1K8VYkUuExLn/1FHS8Leq5Ae31cINLdpU2TQKg6UyaAgs+/3fZlBFhB/Zig5euMXKT/8b7
	aU17ND5ac3jVvCnIxGx9aR9PNarYIeAYqDw==
X-Gm-Gg: ASbGncslRwb0TbYSRQGcKFRT63bQa43OphS76lCPRjE0EqwO5EYWex6sjVomQr2vDmM
	BEAE8aXen8q6eF5YiaUzwDCaQFnpOs0K7zq/JJyRyGDr1ypdq0FEV8MrwoUoMmk47MM1tcMoG76
	cLN44zgfHuBhwVwP2LnSdMRVeylDxCkial7pXpvsTh5S31LfAvhYP6f38cUdL5MhJ6vwEbu7bsn
	PbNnjqvsjPh/0UeeQEfTlYnDzWU8xwJLc/SdE+UsaCac9AMlHTPFzcUx/llIOHvhsmS7w==
X-Google-Smtp-Source: AGHT+IE/ycpXARqvG7joLTDMfwksj2oBuuanCXVxPni/YOXOIbMj0IPGZ8Q9Lwf24WYLyH7lj1jKZET70tDlOf2XpyM=
X-Received: by 2002:a05:651c:1595:b0:355:e2d9:9c8c with SMTP id
 38308e7fff4ca-37a18dfbd6cmr15591261fa.28.1761931605121; Fri, 31 Oct 2025
 10:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030163532.54626-1-okorniev@redhat.com> <18c5ba1652045fb20bc74972d4024e9f42762875.camel@kernel.org>
In-Reply-To: <18c5ba1652045fb20bc74972d4024e9f42762875.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 31 Oct 2025 13:26:32 -0400
X-Gm-Features: AWmQ_blbhOsRxMe6povrWQBXN5CkkKzBYVBE3gtSgxn8mGlqtkFpWiwJJcKZT7c
Message-ID: <CAN-5tyFmPPp8X3NdJS9AynQ43ppzq4yFMD9gQWroWbsF6v+seA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: don't start nfsd if sv_permsocks is empty
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:55=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2025-10-30 at 12:35 -0400, Olga Kornievskaia wrote:
> > Previously, while trying to create a server instance, if no
> > listening sockets were present then default parameter udp
> > and tcp listeners were created. It's unclear what purpose
> > was of starting these listeners were and how this could have
> > been triggered by the userland setup. This patch proposed
> > to ensure the reverse that we never end in a situation where
> > no listener sockets are created and we are trying to create
> > nfsd threads.
> >
> > The problem it solves is: when nfs.conf only has tcp=3Dn (and
> > nothing else for the choice of transports), nfsdctl would
> > still start the server and create udp and tcp listeners.
> >
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfssvc.c | 28 +++++-----------------------
> >  1 file changed, 5 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 7057ddd7a0a8..40592b61b04b 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
> >       return rv;
> >  }
> >
> > -static int nfsd_init_socks(struct net *net, const struct cred *cred)
> > -{
> > -     int error;
> > -     struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > -
> > -     if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> > -             return 0;
> > -
> > -     error =3D svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS=
_PORT,
> > -                             SVC_SOCK_DEFAULTS, cred);
> > -     if (error < 0)
> > -             return error;
> > -
> > -     error =3D svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS=
_PORT,
> > -                             SVC_SOCK_DEFAULTS, cred);
> > -     if (error < 0)
> > -             return error;
> > -
> > -     return 0;
> > -}
> > -
> >  static int nfsd_users =3D 0;
> >
> >  static int nfsd_startup_generic(void)
> > @@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const=
 struct cred *cred)
> >       ret =3D nfsd_startup_generic();
> >       if (ret)
> >               return ret;
> > -     ret =3D nfsd_init_socks(net, cred);
> > -     if (ret)
> > +
> > +     if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
> > +             pr_warn("NFSD: not starting because no listening sockets =
found\n");
> > +             ret =3D -EIO;
> >               goto out_socks;
> > +     }
> >> >       if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
> >               ret =3D lockd_up(net, cred);
>
>
> Assuming that there is no regression with rpc.nfsd startup, this looks
> good to me.

I haven't found a combination of parameters to rpc.nfsd that would
ever trigger nfsd_init_socks() to have an empty list. Looking at the
nfs-utils nfsd code I see code that fails nfsd start if there were no
sockets.

I've been digging into code evolution. And day0 was nfsd would
svc_create() and then call svc_makesock(UDP) and svc_makesock(TPC)
(originally ifdef-ed). So sockets were always created right there.
Then starting from this commit 02a375f0ac4bc "knfsd: separate out some
parts of nfsd_svc, which start nfs servers", nfsd_init_socks() was
born with the check for sv_permsock being empty. I'm assuming it's
because function is called multiple times and socket creation needed
to be done once... anyway looking at old code, it looked like sockets
were created in the kernel. Then later socket creation was moved into
userspace. Then rpc.nfsd would make sure there would be sockets before
calling into the kernel. At that point I believe nfsd_init_sock()
would always guarantee that sv_permsocks would have sockets there
making the code.

> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>

