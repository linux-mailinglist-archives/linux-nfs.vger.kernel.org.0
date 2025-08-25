Return-Path: <linux-nfs+bounces-13885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF9EB345A9
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0408189B368
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDFC2FD1A0;
	Mon, 25 Aug 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="BAqD/rjD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8332FC864
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135447; cv=none; b=E3cyKouq+DBQUbQnR2RGAp03xi1zG8jUxRBtlaAVZn1eAEc3XlxBye7VaYddiU/I5L+ziOTdP+I1PQgc9LxJ7J+EFZbtdv1CSLqq0AwxxsSwXLyP8TL2m2F5CEOsJLppO9nEZuR0iVeZkZa9jFQUBWAVQ8j+vBFMr+HnL4qJW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135447; c=relaxed/simple;
	bh=Al/SdFlVdwsboKTKX9VTYI5ARDu++bODp3uWJuIq7rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoU+DDbYZjFdpFvRQxA3FviNpy/oojKELq2Ja02Sc92s/S2tBxu+vXfhFGdLMnF1VEDgLbDUXDeS/cLxFdqxjNm68Ibai9OwwyjUtZoCdd//wlfHM7onEvGX+EW+bFox4A1+G2IU7d0grZ/wZJ8yyGm6dlBmfW5x4nvcgS2xeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=BAqD/rjD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f39c0a22dso2514911e87.1
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1756135444; x=1756740244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TapsdavtgNfz8Ufj9DWudHiGzx6EpwiFuyJUyv0ekqE=;
        b=BAqD/rjDfEEtCNQ8tZlGRNZi6IVbibIjXYN42G3nqeld0Rn42YmkKXVM/6nbnhEpD2
         1WQPMtlcbkAn+LEx4W29/eMktnM8wcoifQPn0iYZFsQFf54oLYtfbrCOqvd6e9MbMal6
         piJJulmeWfh9Du//QIh+75wnGiAsSYrc5Z0qEZpLZD5hTN+Q2iTqprx2/0yWaDgUUXMf
         QRaD+4gmN7VafNDdfBK0U86jgqkCZsGYVbBnYITk8afnbytNFevghxDyBiBG4QnOAi+H
         kdJc6yPmcnD6M8YeD7egSgEf6skni+zu25j4PAbZMieEiYcE6H0436l1ebnV/oQK+PMe
         /a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135444; x=1756740244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TapsdavtgNfz8Ufj9DWudHiGzx6EpwiFuyJUyv0ekqE=;
        b=fG413T/Z3ye/2EbC+HE1JUPAzCUbWwkU59bZlmsmSXH8jAsfwn+ihx9eYMUDPaIRoV
         /vPov6+SI0CW0k1j4PT7m5sWoPxDaDxA0CPY2yJlQoCBO2+Ff00f58HIkrXiM0KRRDTX
         cSlQNif6QJhz2TLNVKTip1ccmCKr2YUj/ki+9qoGYgTeRiHIhb0bsb57EfezAjeBNaSS
         +pyRM4V8tOJezhCIrB7AusyUecJifZ2EFY5bLvDfgseSZoXK4eYeI289RJ9j7vO9Vca/
         JfercTK+Lo6iz++kD8VRIgsUg1glgE85PTt66bLh+CPUHssK7oGQ/VOBnf72kA3JTjMe
         DYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZxgxOgs8/Ld1rFOFMpVIDNbclqNivF635h+BAYeLmDgm/2/UYFT3LgrXjxFaqDOgPlFjxzd+u/sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xzzS9wbRVMPkcBVWJd+o+Ia4Wgwl65o7BgvTsWypn2+aHmfG
	4/gOY3VNACbpchDCLySvSg4zUntaBzVG65jY0/rbUGaYjnNhubMJfY57GM1Yzj8hMxCJEvbkljw
	WJmnmCHcnbLWL9k94n5MXN5cQ0hUqUHM=
X-Gm-Gg: ASbGnctwwLmy2lnkHLcqQWB3SMpT1vekxZErzhIW+yksoeLv0eTD7honPiTnks+8CJh
	tWDg/Vz8yWfQAse0vHX069aQAkyZ1aTwgu0/t/jtwzNs15ft/7rXIuayazaqBT7m4qzJxB3qOfm
	4UoBuwxlv2nrfDLWOSfDMCmfwPDCC7eQrWkCloST7swZIDEa84Y8tYKd5sr62J9cFFgZDBUwBO4
	Wi9Q64vsX7zlWP/Woqw1Uig3loGs28ctbffldwYOA==
X-Google-Smtp-Source: AGHT+IHsfUqODCHvkXt9O/tYsG65yd+FzqcvP32bh3kHFg3DtPF9uxDXlTwy+hFx06btyljQS88oEwRPCTjjyM9Jxcs=
X-Received: by 2002:a05:651c:2119:b0:336:6132:7002 with SMTP id
 38308e7fff4ca-336613274e1mr21131721fa.39.1756135443283; Mon, 25 Aug 2025
 08:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
 <175573171079.2234665.16260718612520667514@noble.neil.brown.name> <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
In-Reply-To: <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 25 Aug 2025 11:23:51 -0400
X-Gm-Features: Ac12FXxMOCQH0oOaWR5_WhUOwfxaznxkQ8Mi9RpaC_CW1SFIYZxRA8IBDAEPiDU
Message-ID: <CAN-5tyEf2tGv=uSr+B6QRYfakUijNbenrVeDWkdyTobRjzny9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:56=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Wed, Aug 20, 2025 at 7:15=E2=80=AFPM NeilBrown <neil@brown.name> wrote=
:
> >
> > On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
> > > On Tue, Aug 12, 2025 at 8:05=E2=80=AFPM NeilBrown <neil@brown.name> w=
rote:
> > > >
> > > > On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
> > > > > When nfsd is in grace and receives an NLM LOCK request which turn=
s
> > > > > out to have a conflicting delegation, return that the server is i=
n
> > > > > grace.

My last attempt for restoring (prior to write delegations) behaviour
vs what happens now (even with patch#1). I bring it up again because
there has been misunderstanding of what the patch series is doing and
I believe (some) technical concerns (regarding nfsv2 client) have been
discussed and resolved.

In the old code (prior to write delegations), when a v3 client sent a
lock request (during grace period) and when a v4 client reclaimed the
same lock after the server rebooted, the v3 client got the in_grace
error.

With patch #1 (not in question here), the code at least isn't failing
the request with nlm_failed and instead drops the request. No lock
failure but the overall behaviour of the nfs client is different
(details below).

> > > > > Reviewed-by: Jeff Layton <jlayton@redhat.com>
> > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > ---
> > > > >  fs/lockd/svc4proc.c | 15 +++++++++++++--
> > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > > > index 109e5caae8c7..7ac4af5c9875 100644
> > > > > --- a/fs/lockd/svc4proc.c
> > > > > +++ b/fs/lockd/svc4proc.c
> > > > > @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, =
struct nlm_res *resp)
> > > > >       resp->cookie =3D argp->cookie;
> > > > >
> > > > >       /* Obtain client and file */
> > > > > -     if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &h=
ost, &file)))
> > > > > -             return resp->status =3D=3D nlm_drop_reply ? rpc_dro=
p_reply :rpc_success;
> > > > > +     resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, =
&file);
> > > > > +     switch (resp->status) {
> > > > > +     case 0:
> > > > > +             break;
> > > > > +     case nlm_drop_reply:
> > > > > +             if (locks_in_grace(SVC_NET(rqstp))) {
> > > > > +                     resp->status =3D nlm_lck_denied_grace_perio=
d;
> > > >
> > > > I think this is wrong.  If the lock request has the "reclaim" flag =
set,
> > > > then nlm_lck_denied_grace_period is not a meaningful error.
> > > > nlm4svc_retrieve_args() returns nlm_drop_reply when there is a dela=
y
> > > > getting a response to an upcall to mountd.  For NLM the request rea=
lly
> > > > must be dropped.
> > >
> > > Thank you for pointing out this case so we are suggesting to.
> > >
> > > if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
> > >
> > > However, I've been looking and looking but I cannot figure out how
> > > nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
> > > happen during the upcall to mountd. So that happens within nfsd_open(=
)
> > > call and a part of fh_verify().
> > > To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
> > > from the nfsd_open().  I have searched and searched but I don't see
> > > anything that ever sets nfserr_dropit (NFSERR_DROPIT).
> > >
> > > I searched the logs and nfserr_dropit was an error that was EAGAIN
> > > translated into but then removed by the following patch.
> >
> > Oh.  I didn't know that.
> > We now use RQ_DROPME instead.
> > I guess we should remove NFSERR_DROPIT completely as it not used at all
> > any more.
> >
> > Though returning nfserr_jukebox to an v2 client isn't a good idea....
>
> I'll take your word for you.

I didn't write the correct words here. I have said the correct words
in the other patch. v2 (or v3) client does not get an nfserr_jukebox.

> > So I guess my main complaint isn't valid, but I still don't like this
> > patch.  It seems an untidy place to put the locks_in_grace test.
> > Other callers of nlm4svc_retrieve_args() check locks_in_grace() before
> > making that call.  __nlm4svc_proc_lock probably should too.  Or is ther=
e
> > a reason that it is delayed until the middle of nlmsvc_lock()..
>
> I thought the same about why not adding the in_grace check and decided
> that it was probably because you dont want to deny a lock if there are
> no conflicts. If we add it, somebody might notice and will complain
> that they can't get their lock when there are no conflicts.

The disadvantage of unconditionally adding in_grace check() in the
lock call is that again it would produce a difference in behaviour
where some lock would not be granted as fast as before (ie., some
environments might notice the change?).

> > The patch is not needed and isn't clearly an improvement, so I would
> > rather it were dropped.
>
> I'm not against dropping this patch if the conclusion is that dropping
> the packet is no worse than returning in_grace error.

My argument for inclusion of this patch is that it restores previous
behaviour that the nfs client experienced before (ie., receiving
in_grace error). When we rely on drop-retry behavior, can there be
problems that the client runs out of re-tries and fails the request
(nlm has a hard coded retry limit of 5 and then its own timeout
value)?

I admit my reasons are hypothetical, we can wait until somebody complains.


> > Thanks,
> > NeilBrown
> >
> >
> > >
> > > commit 062304a815fe10068c478a4a3f28cf091c55cb82
> > > Author: J. Bruce Fields <bfields@fieldses.org>
> > > Date:   Sun Jan 2 22:05:33 2011 -0500
> > >
> > >     nfsd: stop translating EAGAIN to nfserr_dropit
> > >
> > > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > > index dc9c2e3fd1b8..fd608a27a8d5 100644
> > > --- a/fs/nfsd/nfsproc.c
> > > +++ b/fs/nfsd/nfsproc.c
> > > @@ -735,7 +735,8 @@ nfserrno (int errno)
> > >                 { nfserr_stale, -ESTALE },
> > >                 { nfserr_jukebox, -ETIMEDOUT },
> > >                 { nfserr_jukebox, -ERESTARTSYS },
> > > -               { nfserr_dropit, -EAGAIN },
> > > +               { nfserr_jukebox, -EAGAIN },
> > > +               { nfserr_jukebox, -EWOULDBLOCK },
> > >                 { nfserr_jukebox, -ENOMEM },
> > >                 { nfserr_badname, -ESRCH },
> > >                 { nfserr_io, -ETXTBSY },
> > >
> > > so if fh_verify is failing whatever it is returning, it is not
> > > nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
> > > translate it to nlm_failed which with my patch would not trigger
> > > nlm_lck_denied_grace_period error but resp->status would be set to
> > > nlm_failed.
> > >
> > > So I circle back to I hope that convinces you that we don't need a
> > > check for the reclaim lock.
> > >
> > > I believe nlm_drop_reply is nfsd_open's jukebox error, one of which i=
s
> > > delegation recall. it can be a memory failure. But I'm sure when
> > > EWOULDBLOCK occurs.
> > >
> > > > At the very least we need to guard against the reclaim flag being s=
et in
> > > > the above test.  But I would much rather a more clear distinction w=
ere
> > > > made between "drop because of a conflicting delegation" and "drop
> > > > because of a delay getting upcall response".
> > > > Maybe a new "nlm_conflicting_delegtion" return from ->fopen which n=
lm4
> > > > (and ideally nlm2) handles appropriately.
> > >
> > >
> > > > NeilBrown
> > > >
> > > >
> > > > > +                     return rpc_success;
> > > > > +             }
> > > > > +             return nlm_drop_reply;
> > > > > +     default:
> > > > > +             return rpc_success;
> > > > > +     }
> > > > >
> > > > >       /* Now try to lock the file */
> > > > >       resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lock=
,
> > > > > --
> > > > > 2.47.1
> > > > >
> > > > >
> > > >
> > > >
> > >
> >

