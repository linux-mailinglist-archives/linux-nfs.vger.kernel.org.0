Return-Path: <linux-nfs+bounces-13830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A308B2FBBD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 16:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3097818990BD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC415E5DC;
	Thu, 21 Aug 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="OZWFu8VL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB42EC553
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784623; cv=none; b=A1erhhSBhUJoU05IiEna3Z5MqcxBK4De8RBhaVxNk/rpxnHZRSz3boWpjHpUNvIo4Qh69Xz7lSFHT9NVKjYVTwCqSdWdq144uk55YzKalu/DMWKTFkoPgGRXPl8Lg7DvO5+4U6uKRF2QUcMbNz+UI9vad/AyvZ6gqV7BFGmLhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784623; c=relaxed/simple;
	bh=g9QVok8wFPgoeXNPLpqlhSuaj4Qi2VGotETjUtt8DH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxxE24nDrTAZv651rkBedSHePDT8nzvj6FvXWJxDxFLLvOSUWjYrd8qRVASpI/z6DOVlpNqHKZuk1SDmEkgr/649SgobEZwJGDBce5weZGkTKh6c1td9Kj3Wc/Tg4ZTQg8VR4G4ppnzqb5cGUvtBtMKXbfWKUK+5Orhfibeyvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=OZWFu8VL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55cf526f6b5so729690e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755784619; x=1756389419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK+e93BzUfYOxZ1c3SEPzzDMizHxIcyK/DjMCb0MRUs=;
        b=OZWFu8VLR0+DPRVZCnO9Mor9S4D1puw5a7ZK/GApQejEpr4whnX0pbRSdyRPDPYHMY
         WF6C7v5bEHT/H4sr4rbRP0th25vTNM//K11saaLoOil2Ui8RdqdXM9XDJmZFDgoQTmTt
         4JVtyrq/b+rAj79ZfhZq3oPymA+HaGPC7jidV5uzG10aralykP3iMd5sy6HYrDBhriNo
         lKgFACWvjwzL0KRIj559mRlXtL9uuGATSnRL/G6eVcpxNDGbU3dPoZPVuI5FEA7Y5H1d
         3IQWQCCDNNg+zqBFLPIpyFZihrCNnij7waULoETEufK0iQnl2qLVhnboRTp0vdrBnZla
         NHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784619; x=1756389419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK+e93BzUfYOxZ1c3SEPzzDMizHxIcyK/DjMCb0MRUs=;
        b=PzyewBsazUZK/cfssvk2lp6EJhluy1L86BPdW2pxTio2GhA9eiVdvdi8Lp6M/f7iQV
         E/Y9t4MGJWP8/CdAcTjOGVZfB3ZgTDBIXpl2WY+4+ZkJhnhIqeope7gdTUAcAhtcf7x+
         CmJw6klzwqJGcyTfAcnkxmU/luyvZ6ZkWqMH9xmUiMvcwsn+rbNSYooYqb6iHjPTFmMI
         0Y4l4hA6auhRr8dsdKTEydhQo72SCAaztXIXXKfeqnP24gGtGjPl0Q73efpysHc7kDcm
         aHMmOjxkgwJRqzJuPH4z2uW5gbeMuAAfZOt0/qETKuoOR1mmRiVk1oNCQRyRohP4YF1R
         o2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsXHqX0nOkJC1t94sDaw+Kpi5SPqWKe6iH2UsEMz04ho7q3Z7BdKEOl/S6zbGypwsVaq9E+zHgpQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycI/8/M5/ydscD76jZFSruXIkg5LUJM9goVQqZm9SX8scDEEuo
	Y2Td2MuO9s7PZ0f0+UIk6m9jMjkp1H7Fnet7AeLpmtK9YsQDzG05Kd4xj7dJX87m/MZUUx9rkOo
	K92Vz9hxr6/AUzGF8noVihDCDTOYiWRCLet5l
X-Gm-Gg: ASbGncvfJj0q0UIgrdoKKhtG30hy6uzhbjLf4hyVWHbp4tImQCm/B/eQI4th4KbKhYV
	RPrCbECSrBkn812dnCCVkW7E0Zux3sNcfHqpykCMkJMK2f5sc+wzHbETNYnF+Evz80cA00Uy6kR
	OG2ZiRbgOL4gjch5/IHunVmg6XZ65Fu9Cza7wYf2Xg9OXfj9+hSc/IIrR9ZVPuaYOrfhmVkuFOL
	5LAKkQkIH4c6nX8Dq57EtLN+PQReLUa6OWpgFnD
X-Google-Smtp-Source: AGHT+IEGcIgcEeh9kck2pHUdB2+DL1rr7rvpcfgdLFGetFg0X/bsIeqf6LW4GmuODQKX98K8RKXhqXeGwwtNg6yA/Ns=
X-Received: by 2002:a05:6512:4504:b0:55c:e632:982a with SMTP id
 2adb3069b0e04-55e0d5a4c0amr629188e87.46.1755784619197; Thu, 21 Aug 2025
 06:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
 <175573171079.2234665.16260718612520667514@noble.neil.brown.name>
In-Reply-To: <175573171079.2234665.16260718612520667514@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 21 Aug 2025 09:56:47 -0400
X-Gm-Features: Ac12FXwows9QjUiL1_2hAVCQVkT8k7evlkN6RldNXZieePWZE1kz4z7wvoiJ_5M
Message-ID: <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:15=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
> > On Tue, Aug 12, 2025 at 8:05=E2=80=AFPM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
> > > > When nfsd is in grace and receives an NLM LOCK request which turns
> > > > out to have a conflicting delegation, return that the server is in
> > > > grace.
> > > >
> > > > Reviewed-by: Jeff Layton <jlayton@redhat.com>
> > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > ---
> > > >  fs/lockd/svc4proc.c | 15 +++++++++++++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > > index 109e5caae8c7..7ac4af5c9875 100644
> > > > --- a/fs/lockd/svc4proc.c
> > > > +++ b/fs/lockd/svc4proc.c
> > > > @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, st=
ruct nlm_res *resp)
> > > >       resp->cookie =3D argp->cookie;
> > > >
> > > >       /* Obtain client and file */
> > > > -     if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &hos=
t, &file)))
> > > > -             return resp->status =3D=3D nlm_drop_reply ? rpc_drop_=
reply :rpc_success;
> > > > +     resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &f=
ile);
> > > > +     switch (resp->status) {
> > > > +     case 0:
> > > > +             break;
> > > > +     case nlm_drop_reply:
> > > > +             if (locks_in_grace(SVC_NET(rqstp))) {
> > > > +                     resp->status =3D nlm_lck_denied_grace_period;
> > >
> > > I think this is wrong.  If the lock request has the "reclaim" flag se=
t,
> > > then nlm_lck_denied_grace_period is not a meaningful error.
> > > nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
> > > getting a response to an upcall to mountd.  For NLM the request reall=
y
> > > must be dropped.
> >
> > Thank you for pointing out this case so we are suggesting to.
> >
> > if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
> >
> > However, I've been looking and looking but I cannot figure out how
> > nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
> > happen during the upcall to mountd. So that happens within nfsd_open()
> > call and a part of fh_verify().
> > To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
> > from the nfsd_open().  I have searched and searched but I don't see
> > anything that ever sets nfserr_dropit (NFSERR_DROPIT).
> >
> > I searched the logs and nfserr_dropit was an error that was EAGAIN
> > translated into but then removed by the following patch.
>
> Oh.  I didn't know that.
> We now use RQ_DROPME instead.
> I guess we should remove NFSERR_DROPIT completely as it not used at all
> any more.
>
> Though returning nfserr_jukebox to an v2 client isn't a good idea....

I'll take your word for you.

> So I guess my main complaint isn't valid, but I still don't like this
> patch.  It seems an untidy place to put the locks_in_grace test.
> Other callers of nlm4svc_retrieve_args() check locks_in_grace() before
> making that call.  __nlm4svc_proc_lock probably should too.  Or is there
> a reason that it is delayed until the middle of nlmsvc_lock()..

I thought the same about why not adding the in_grace check and decided
that it was probably because you dont want to deny a lock if there are
no conflicts. If we add it, somebody might notice and will complain
that they can't get their lock when there are no conflicts.

> The patch is not needed and isn't clearly an improvement, so I would
> rather it were dropped.

I'm not against dropping this patch if the conclusion is that dropping
the packet is no worse than returning in_grace error.


>
> Thanks,
> NeilBrown
>
>
> >
> > commit 062304a815fe10068c478a4a3f28cf091c55cb82
> > Author: J. Bruce Fields <bfields@fieldses.org>
> > Date:   Sun Jan 2 22:05:33 2011 -0500
> >
> >     nfsd: stop translating EAGAIN to nfserr_dropit
> >
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index dc9c2e3fd1b8..fd608a27a8d5 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -735,7 +735,8 @@ nfserrno (int errno)
> >                 { nfserr_stale, -ESTALE },
> >                 { nfserr_jukebox, -ETIMEDOUT },
> >                 { nfserr_jukebox, -ERESTARTSYS },
> > -               { nfserr_dropit, -EAGAIN },
> > +               { nfserr_jukebox, -EAGAIN },
> > +               { nfserr_jukebox, -EWOULDBLOCK },
> >                 { nfserr_jukebox, -ENOMEM },
> >                 { nfserr_badname, -ESRCH },
> >                 { nfserr_io, -ETXTBSY },
> >
> > so if fh_verify is failing whatever it is returning, it is not
> > nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
> > translate it to nlm_failed which with my patch would not trigger
> > nlm_lck_denied_grace_period error but resp->status would be set to
> > nlm_failed.
> >
> > So I circle back to I hope that convinces you that we don't need a
> > check for the reclaim lock.
> >
> > I believe nlm_drop_reply is nfsd_open's jukebox error, one of which is
> > delegation recall. it can be a memory failure. But I'm sure when
> > EWOULDBLOCK occurs.
> >
> > > At the very least we need to guard against the reclaim flag being set=
 in
> > > the above test.  But I would much rather a more clear distinction wer=
e
> > > made between "drop because of a conflicting delegation" and "drop
> > > because of a delay getting upcall response".
> > > Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nlm=
4
> > > (and ideally nlm2) handles appropriately.
> >
> >
> > > NeilBrown
> > >
> > >
> > > > +                     return rpc_success;
> > > > +             }
> > > > +             return nlm_drop_reply;
> > > > +     default:
> > > > +             return rpc_success;
> > > > +     }
> > > >
> > > >       /* Now try to lock the file */
> > > >       resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lock,
> > > > --
> > > > 2.47.1
> > > >
> > > >
> > >
> > >
> >
>

