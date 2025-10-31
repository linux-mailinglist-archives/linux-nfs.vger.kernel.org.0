Return-Path: <linux-nfs+bounces-15857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F8C26542
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 18:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88173B77FE
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE56272E63;
	Fri, 31 Oct 2025 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QfzgG/xd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA692F3607
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931605; cv=none; b=JcuGqvIKqs5hJbeiCKKxUqnovhQhANN3UhckueNMQpPrPap9xYjB3Sxc4Zv7CTz4ckaDFuwCsQSC4tscrpJj3i7cnSdRpzUiSPcm/6ORDOMelnGfgcgt5b18cx0RJIKQH3BwAPe2CISW6wZKWEKdTSnlN7bmnrUxnZxgJxg6mHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931605; c=relaxed/simple;
	bh=eDP8I9Y0v7v5eLsq9jnXrSPcgVdMvKjUE0jt2U98rcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyRNEqmu9bORHuxUoMRpBsfhOTUPZpa9CkQMl1Q9n/XdWnhVMUaP3ECu5bGbvgHK/k/g8KwAqNg2suDqdvzeZXxxBPgdbsHjfpByHPrErTPzjHWn3bG80PB98rS2ZQLdE7aiTpcYUSTKAX7JP73eLgysAuHMVMcgauDoLE/YIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=QfzgG/xd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3717780ea70so29798461fa.1
        for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 10:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761931602; x=1762536402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3X86Pgu/fVhcKHgNgkBfbPX7kmE+N+Sn6h26bt+zio=;
        b=QfzgG/xd4jI0hj6yH5U20yZdeoIKTD5ZeUwsRgscuQVPsLvyPD/8ewYN35O8YOt49g
         rSHcWAYhBQMk5hNaMhlte22LKI4UzKU583UnAK5WPVDxPYb1oLfId40kCshU4c7/o6s6
         6g7yPQvrssbuIFWpYe3/m3DmjSueHcnmRJqqiRuUj8IbciwNrngzyyehfk/7U+k0cY0l
         86o7valAl0CopR4eNTefE2OuAXLf47JHrC38JKX0TMKi31ZqScND1ElJVJEm96UecWHk
         S8MTdYaguc8UYdCi5NPb07nZXup9j1+X0KIxkI6YFrP//rbrTxC5HfABalbXgwm3uS1z
         yp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761931602; x=1762536402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3X86Pgu/fVhcKHgNgkBfbPX7kmE+N+Sn6h26bt+zio=;
        b=MRTLjgwSfnVxqSAidqZx5eCwSS0RpJ19xYJNM7hpopfQeyJ49mV8zCpv0HQ3YMFVEG
         TbAAFZ7tAvOrZqrrFsiy+Crh8PEIHgIrYSnU0qy+jN3718mboguqLbfqbXpOQu/SNrY+
         0HtgPK7oKr4fEKnET51ckC3+X2t+m8vBpIhIrIqtI0J+kVDNHYYR6A6r05xQ2eWMB1kc
         cJw9Z4tHZ9znVdQtkjW+WEAcUDmRAg6lPIAzKW9Pz+IRd5/LWvWQm3qwMlrDlskSHlrf
         D6RHAy6kdJbmsPg1wsw5LHzARvo9qXMr9KmLGfI1vayQF1+shQ409HOh6Lba88HIaoLM
         VGbw==
X-Forwarded-Encrypted: i=1; AJvYcCXIihRdRijzGiGoXQrvSQu0MNJCKWQc5vWF0S8q+j7DOMwMWnSBZO+dT+P9GWKShMIv4lsFChltdcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRVeNmhZtTZKVO543V8gzNDjr1ATetJz1ehzh0SLNFwVSA5De
	TFv2lIUX3Uoknc/HhHnJ+7T7UebyyvUGYGEOrWL7QOT/Ir4hM1b567y8kL95GEG31jqzmp/9g0i
	nOpXMVxf/JElROzXf+hb3I4FlPbRmOh8=
X-Gm-Gg: ASbGncsWFMPMV6hQ517KJbr4rSkZLPR14kA7M3omk3OdQLfMyn7GVCi61JnvNWn+KpQ
	MPuK8m+ky5AhTdN0PJ/Zq1XQkcRztFFIdj+8ufN+J/mBLdPrHcLVi2BIc4Pb265ofeuOJUlNLxd
	Lb8rk6B5HntWc9Ka+S+ANCs75UPIaS8zYyafTp9NRrUeKawnPWgB7MRGhc69ode/NVVUE96LDY6
	ASVRawUIkFLnK9eaKRa9V4Vs/kMgPK0JmfnOTjXbjXoGklr48vM4ri/f4IDgKrkaVeuuQ==
X-Google-Smtp-Source: AGHT+IEo5lrMUqAW5IxVInvpyLsGZqiAcrZmnmB9IP3f6RB+f3Y+IYtyfCMWB+ZG7LpVYXYv+hdqmLxRcNnJiHDIWnw=
X-Received: by 2002:a2e:8845:0:b0:378:ea85:7f06 with SMTP id
 38308e7fff4ca-37a18e15bf3mr9586041fa.36.1761931601675; Fri, 31 Oct 2025
 10:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030163532.54626-1-okorniev@redhat.com> <bca68f1b-ca56-4e94-abd0-de4c509d3d00@oracle.com>
In-Reply-To: <bca68f1b-ca56-4e94-abd0-de4c509d3d00@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 31 Oct 2025 13:26:30 -0400
X-Gm-Features: AWmQ_bkfRtay-b2niKjH-WptfKRbcbueL7KlHNGMTQ-iIRL5vOzJNYB8PjSxE4M
Message-ID: <CAN-5tyGGnD1217Ui4KYRoBGxdLmzPqnkGsz4dK5G9GAmyj-uvQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: don't start nfsd if sv_permsocks is empty
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:52=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 10/30/25 12:35 PM, Olga Kornievskaia wrote:
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
>
> Fixes: ?

I don't think it deserves a Fixes. There wasn't a way (that I have
discovered) that would ever exercise that code because the checking
that we had socket(s) (or even setting up a socket) was done in
userpand by rpc.nfsd. nfsdctl doesn't do that and thus exposed the
situation where we are starting a thread and had no listeners. While
there was an option to change nfsdctl to do the checking, the kernel
change made more sense as I don't see a reason why the code is useful.

>
> One more below.
>
>
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
>
> I know the code refers to sockets, but the term doesn't refer to RDMA
> listeners at all, and this warning seems applicable to both socket-based
> and RDMA transports. How about:
>
> NFSD: No available listeners

This doesn't convey to me the fact that we didn't start the server. How abo=
ut
"NFSD: not started because no listeners were found" or
"NFSD: not started, no available listeners"?


>
>
> > +             ret =3D -EIO;
> >               goto out_socks;
> > +     }
> >
> >       if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
> >               ret =3D lockd_up(net, cred);
>
>
> --
> Chuck Lever
>

