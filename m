Return-Path: <linux-nfs+bounces-15949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F04BC2DA95
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 19:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F2618870FE
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD417AE11;
	Mon,  3 Nov 2025 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="WsP0LU+9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC32749FE
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194219; cv=none; b=uwFqlEpCnDi9Slnnh+0IP+JxRBIrPCjxW3BEWqk/cB/y4kM4WGNllNoMzpj2v2MI0tsDJk45RLVBXR+naNLR9fdELI0ERlJoum8H9ycJ2HybKl2g7Z6LwRgE55u5CIKbL6JjjbCZU0h3EU7aNHN/Gnz2qjAojjgdCMmt40HbIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194219; c=relaxed/simple;
	bh=7b+bgBOnfiJnZBHvSNfwSEstcdtjAvZFayECGUdVqV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=le7c/ZF0BZP1G1DpPFAB6cAU9ulYQgbQxpNusUv42PPGcSyU3QXhLBprA+EiSl8OOhR7L3+HS6r+qQRwr9zAaVqG93/KaH/gV6wmtqEXpeT/1DJqDq655+FrWeYAqVD0AEGyvEcHVlxci4bsbwmEuiBreW9QXHgEMXNgpUTK+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=WsP0LU+9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a1267c45dso39327311fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 03 Nov 2025 10:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1762194215; x=1762799015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOrMJ8sofkhNuWpKskBNE7CgFtjuCaG+d9Im+VGclQk=;
        b=WsP0LU+9oWWLrMcaPbO7Un1/dReLme4qwBSDhmjfW0uqD0SlxsfJsJNH1GzWlqSpMp
         w2NDoaHFd6hlqAMe/n9dzChNSjqmWI9GS6XPGwIqFJGQxQrsXIPLm23Roa1Z23eE2a4p
         3vD8pZaGeB4u4byjSW055u5TRnV9Gr67wAhHcTga0yNS3WOMPNttDHoQ3Zs7wybd8tWX
         dhy6xsnjCrFKd432D/c+VvOIrbwi57nV3sETYq0ggw7mokoDy13zY4JJ5mDajsNt+nxB
         hKaRPUvRN7XbLYUs3CAQtyte2a+twR2uLWFkS6jdZZRnVw8MbWQAUBpwFcvYcQBSTMes
         yc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194215; x=1762799015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOrMJ8sofkhNuWpKskBNE7CgFtjuCaG+d9Im+VGclQk=;
        b=ZBQDPtxJGsum9ZrN5yHF27IllfPij6roxWcxHUDO/EmVSj+7xkS3qDLkeBWRKO1NjA
         2DFzb++zXP1Q5OVLBgPKtI16mwucvJAS3q9H0QA3nQdZIiw6lkh6Y4bEb2Y0TjyUtW40
         ZFz9Nukl/rXa7QXrwZ7W7HtX6a4xGGunjgPSC3KZITH4+Pu+sdl/rNBfczXZupBfnl1K
         nqnlHEXDUnaigcIj6ova/4w40hAhioNSvVq5+o4nCoK0Peg+uroJed5cv6V8glxIILWP
         uO+E/MEQuiPZWh1nCWzxYKAsPlgsnqzrnuLhGek12YOmBmFA7lHOpFY7wgcShi/8dY1X
         e8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVAkHl94FRkowPNm9Yt5tpPvrlEvG/xtz9MoBT12HQnhEXMhoOJqtEj5LHeKyxkNUKjv1FCDNSidlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTDpHTWg+rMOxqpDwQr6zD66PjeN2ltktfMBRpS1p7/Z0IMV7
	2Kec045GEnYsSzv54YPi7lcLixMEYDoJ3R4YeLFAoB16Yg8KHTSoMNJ0YRt7T8urS4zNHhbxTu3
	a9EipbD4SW4dBkM+0SA416ehQk0SV8VM=
X-Gm-Gg: ASbGnct8Sg1ZF6WzvoREhNqhj/ojI59hz71JIDR8wRgi+9htL8Y4XDhfy6zYUGayAAw
	hFiBpt/Pfb/ryA7kWulKVbQgZRuYr52yVhUpyDDv4HSe+OKaP0i9I92gK0DvrIHnm0UAhBjEJwX
	POmQPCmMhj1B2yl9sEssGedY/dUzbP15BGoYtqE6aLo/6XR2gQZpJsK1DMHG5eohXxBp53tgXBc
	Xvs7YxMHZfnZOc0aeL9K579wj9icVODjoFjiCBLoqL87BTnKblNjiSwMnB2k1ItRCzTP2Gg4tfQ
	pNLm6uSSvQ147zgNsoo=
X-Google-Smtp-Source: AGHT+IFLutA4KMYGbrv2/FglIX6uUW/qgWk32i81dgoWXmTw76MbH1oLWUiB+W6MJucoa6Kj5MCtKR+Ii4/rdQW8ujo=
X-Received: by 2002:a2e:a9a1:0:b0:37a:2eda:51a with SMTP id
 38308e7fff4ca-37a2eda0b2dmr19696501fa.42.1762194214418; Mon, 03 Nov 2025
 10:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021130506.45065-1-okorniev@redhat.com> <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
 <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
 <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>
 <ff353db93ca47b8fae530695ea44c0a34cd40af8.camel@kernel.org>
 <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org>
 <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>
 <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com>
 <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>
 <176116947850.1793333.1787478761707441526@noble.neil.brown.name> <CAN-5tyHxvKoD651VEZr7kVoyHa2=pxRQXqQ6huUzRairAP2jqw@mail.gmail.com>
In-Reply-To: <CAN-5tyHxvKoD651VEZr7kVoyHa2=pxRQXqQ6huUzRairAP2jqw@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 3 Nov 2025 13:23:21 -0500
X-Gm-Features: AWmQ_bmmRQIJpMETHcGaviY7J-wm_Sv2m_h3idhF36YY8TwzbUblqgI65DBK0AU
Message-ID: <CAN-5tyF2Cu6bHWR=+9NCVc8BG6fucR0zCo2TJS-c5iJXVFJHbg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:55=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
>
> On Wed, Oct 22, 2025 at 5:44=E2=80=AFPM NeilBrown <neilb@ownmail.net> wro=
te:
> >
> > On Thu, 23 Oct 2025, Jeff Layton wrote:
> > >
> > > Longer term, I think Neil is right and we probably need to fix
> > > vfs_test_lock and the lock inode_operation to take a separate confloc=
k
> > > for testlock purposes. That's a bigger change though (particularly th=
e
> > > ->lock operations).
> >
> > Thanks.  But in the shorter term I'd like to suggest this.
> > I haven't tested, but I think it should fix the lockd issue and make th=
e
> > code cleaner too.
> > Sorry - I haven't written a commit description yet :-(
> > As nlmsvc_testlock() is being passed a conflock, use that directly to
> > hold the found lock, and initialise it from 'lock' before, rather than
> > copying results the from lock after.
> >
> > NeilBrown
> >
> > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > index 109e5caae8c7..4b6f18d97734 100644
> > --- a/fs/lockd/svc4proc.c
> > +++ b/fs/lockd/svc4proc.c
> > @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
> >         struct nlm_args *argp =3D rqstp->rq_argp;
> >         struct nlm_host *host;
> >         struct nlm_file *file;
> > -       struct nlm_lockowner *test_owner;
> >         __be32 rc =3D rpc_success;
> >
> >         dprintk("lockd: TEST4        called\n");
> > @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct =
nlm_res *resp)
> >         if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host,=
 &file)))
> >                 return resp->status =3D=3D nlm_drop_reply ? rpc_drop_re=
ply :rpc_success;
> >
> > -       test_owner =3D argp->lock.fl.c.flc_owner;
> >         /* Now check for conflicting locks */
> >         resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock=
,
> >                                        &resp->lock);
> > @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct =
nlm_res *resp)
> >         else
> >                 dprintk("lockd: TEST4        status %d\n", ntohl(resp->=
status));
> >
> > -       nlmsvc_put_lockowner(test_owner);
> > +       nlmsvc_release_lockowner(&argp->lock);
> >         nlmsvc_release_host(host);
> >         nlm_release_file(file);
> >         return rc;
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index a31dc9588eb8..381b837a8c18 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm=
_file *file,
> >         }
> >
> >         mode =3D lock_to_openmode(&lock->fl);
> > -       error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> > +       locks_init_lock(&conflock->fl);
> > +       /* vfs_test_lock only uses start, end, and owner, but tests flc=
_file */
> > +       conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
> > +       conflock->fl.fl_start =3D lock->fl.fl_start;
> > +       conflock->fl.fl_end =3D lock->fl.fl_end;
> > +       conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;
> > +       error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
> >         if (error) {
> >                 /* We can't currently deal with deferred test requests =
*/
> >                 if (error =3D=3D FILE_LOCK_DEFERRED)
> > @@ -648,11 +654,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm=
_file *file,
> >         conflock->caller =3D "somehost";  /* FIXME */
> >         conflock->len =3D strlen(conflock->caller);
> >         conflock->oh.len =3D 0;           /* don't return OH info */
> > -       conflock->svid =3D lock->fl.c.flc_pid;
> > -       conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> > -       conflock->fl.fl_start =3D lock->fl.fl_start;
> > -       conflock->fl.fl_end =3D lock->fl.fl_end;
> > -       locks_release_private(&lock->fl);
> > +       conflock->svid =3D conflock->fl.c.flc_pid;
> > +       locks_release_private(&conflock->fl);
> >
> >         ret =3D nlm_lck_denied;
> >  out:
> > diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> > index f53d5177f267..5817ef272332 100644
> > --- a/fs/lockd/svcproc.c
> > +++ b/fs/lockd/svcproc.c
> > @@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct n=
lm_res *resp)
> >         struct nlm_args *argp =3D rqstp->rq_argp;
> >         struct nlm_host *host;
> >         struct nlm_file *file;
> > -       struct nlm_lockowner *test_owner;
> >         __be32 rc =3D rpc_success;
> >
> >         dprintk("lockd: TEST          called\n");
> > @@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct n=
lm_res *resp)
> >         if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host, =
&file)))
> >                 return resp->status =3D=3D nlm_drop_reply ? rpc_drop_re=
ply :rpc_success;
> >
> > -       test_owner =3D argp->lock.fl.c.flc_owner;
> > -
> >         /* Now check for conflicting locks */
> >         resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host,
> >                                                    &argp->lock, &resp->=
lock));
> > @@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct n=
lm_res *resp)
> >                 dprintk("lockd: TEST          status %d vers %d\n",
> >                         ntohl(resp->status), rqstp->rq_vers);
> >
> > -       nlmsvc_put_lockowner(test_owner);
> > +       nlmsvc_release_lockowner(&argp->lock);
> >         nlmsvc_release_host(host);
> >         nlm_release_file(file);
> >         return rc;
> >
>
> No crash with this patch.

Was the official fix for this problem posted and I missed it? If not,
how can we make progress on the issue.

