Return-Path: <linux-nfs+bounces-6653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A098685E
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 23:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858541F23FF7
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F611411E0;
	Wed, 25 Sep 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUu92DZj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E501B54767
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299999; cv=none; b=EnEIQn7GbmCtM1/spB/axlKVNhbCXFxTpd7UwonicPMwQeUYn0WzOFaqq/3x1iHCYcGsmvSZ76HNK0odCh6cFXD5X1svdkd+O2lzLGOaBjEPhZqDbktSE/qBRaKCTOrnnqhk1qMBJivac3t+BVSTCQhWaXpmiNKTi4pl9Xkn+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299999; c=relaxed/simple;
	bh=7ctJcP8antt+QjADwsy2SEuP0q87NHPl9IkDs+m2Dns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjY51kvV3cxoiY/5VaGhXoHqT1y0woHikXu3UFg6B42VxNSo663oQ0W5YzWTMJjxBOdijGRkGFNRnwfygCB2MAyq/146m5rTVDqFY2S7GeYzSeE/AyYJZ/vgumJ0NlcbtAxIB+zxRqV2R2AxLTNofuGyexfc1ZfloZYnX9gD5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUu92DZj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365928acd0so456061e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727299996; x=1727904796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYU1r8tpUcCggqswJUAKbhDmIwe6C2LoYXf9mjacZJg=;
        b=DUu92DZjgrBIUeuFj7XkW2tRfmhAgzSH7Plb+7LaNEjsQbV8naWvpJlObV5wWnp3zs
         sy3rgAaz8LHf1aODlTShOmMMAWtXvKvQG2ebQ98y9gs7R9MWkWg9l6PWtL6ZF3mc+uo6
         iOaiUYGKgIYbcE9bySdxmsP9jwqco7XThnFFSUrtjL8oy+9vUZgKUE1P9+eZ38ZoewIj
         U0tIFviezh3aug3p5o2IpirnkKZ7cuDBStQbZQ0FIAwbirBvEarAghbtnFFZYsMqlUH2
         MQUGkUXXnr2r+1IcBhLPO51HDXvkGcJOS5laF1UH86XZaxdegDlc1/UHusVs6+Xi19Ok
         /a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299996; x=1727904796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYU1r8tpUcCggqswJUAKbhDmIwe6C2LoYXf9mjacZJg=;
        b=v9pdmh7THJYjrOI+KJ7wfsmZzeXRSPwdGzM0BBGcE2TvgRvYpXrsrxGdedbmsNUngB
         9jkHRr+n7Jbt4V8Bi6xjv9NVOVEEGew/RdoGQN1PyGPQtiE/uiukvxJfbjATo/5H5VPp
         CW5W3f2a8FdRSefNX/Ezf7eXlR9u+2cRsMcEJedShSzZCGiW8JX2AJ3xRv8CMXqk+khp
         tPEdZekywRSFRhJcc0kkPnUohJkEbPttxscE8qXoFFXlII61pRKob6+y+DqyyDKPKtmV
         jvDGEFhb8UmYjlnK0TbKY+LaeCYbPvan1fEfBh/aOV8pW0q4UXQDgpwpcweEfRqtFR8M
         JLKg==
X-Gm-Message-State: AOJu0Yww3hsutp794LT5e2utybTI8EvqpmQKAvsPxy0bfBGI8sR8CR4U
	BO4x9xH5lbi+jj+DeTxTE0k0AVFhT1Y1Bzd+8UAXxWZ/p//+7z10S5xNfMPVSvLWhathS4wU5Tr
	3RSYpMHbeybulQIdKRDvtkgggFHC4g9A=
X-Google-Smtp-Source: AGHT+IFyzWUmkwCMUcVUrLTeAbPx7iII8hMTSOJ9Cvm07wjRaynqhCTCtYmnVtyXF9YKC0K+4teOHG1+Y+AcTsmWpPk=
X-Received: by 2002:a05:6512:158b:b0:533:e83:c414 with SMTP id
 2adb3069b0e04-538800b2719mr2556483e87.59.1727299995604; Wed, 25 Sep 2024
 14:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706224207.927978-1-sagi@grimberg.me> <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <CAM5tNy5WLTk6KbVwe4J8+0=ChhGQgXnK_Matt2Y1j_8W-0KR9g@mail.gmail.com>
 <bdae2f17-7fca-484e-ae46-b822df9f3576@grimberg.me> <CAM5tNy51seoWht2vk46DX_setpaoe26PDYTQ-CwmLC_iyY0mNg@mail.gmail.com>
 <CANH4o6OeyMFYqGUYJnbjowm+wznvCfLOm6n+OHOXdpMTuGLZEQ@mail.gmail.com>
In-Reply-To: <CANH4o6OeyMFYqGUYJnbjowm+wznvCfLOm6n+OHOXdpMTuGLZEQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 25 Sep 2024 14:33:00 -0700
Message-ID: <CAM5tNy4KEKymJ9QhJZG+PevO7qDt7Fk3m6ORKF0UhoVmcjoAVA@mail.gmail.com>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Martin Wege <martin.l.wege@gmail.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:03=E2=80=AFAM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> On Mon, Jul 8, 2024 at 12:05=E2=80=AFAM Rick Macklem <rick.macklem@gmail.=
com> wrote:
> >
> > On Sun, Jul 7, 2024 at 1:21=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me>=
 wrote:
> > >
> > >
> > >
> > > On 07/07/2024 22:05, Rick Macklem wrote:
> > > > On Sun, Jul 7, 2024 at 4:07=E2=80=AFAM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > >> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
> > > >>> Many applications open files with O_WRONLY, fully intending to wr=
ite
> > > >>> into the opened file. There is no reason why these applications s=
hould
> > > >>> not enjoy a write delegation handed to them.
> > > >>>
> > > >>> Cc: Dai Ngo <dai.ngo@oracle.com>
> > > >>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > >>> ---
> > > >>> Note: I couldn't find any reason to why the initial implementatio=
n chose
> > > >>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it=
 seemed
> > > >>> like an oversight to me. So I figured why not just send it out an=
d see who
> > > >>> objects...
> > > >>>
> > > >>>   fs/nfsd/nfs4state.c | 10 +++++-----
> > > >>>   1 file changed, 5 insertions(+), 5 deletions(-)
> > > >>>
> > > >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > >>> index a20c2c9d7d45..69d576b19eb6 100644
> > > >>> --- a/fs/nfsd/nfs4state.c
> > > >>> +++ b/fs/nfsd/nfs4state.c
> > > >>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *op=
en, struct nfs4_ol_stateid *stp,
> > > >>>         *  "An OPEN_DELEGATE_WRITE delegation allows the client t=
o handle,
> > > >>>         *   on its own, all opens."
> > > >>>         *
> > > >>> -      * Furthermore the client can use a write delegation for mo=
st READ
> > > >>> -      * operations as well, so we require a O_RDWR file here.
> > > >>> -      *
> > > >>> -      * Offer a write delegation in the case of a BOTH open, and=
 ensure
> > > >>> -      * we get the O_RDWR descriptor.
> > > >>> +      * Offer a write delegation in the case of a BOTH open (ens=
ure
> > > >>> +      * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY des=
criptor).
> > > >>>         */
> > > >>>        if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=
=3D NFS4_SHARE_ACCESS_BOTH) {
> > > >>>                nf =3D find_rw_file(fp);
> > > >>>                dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > > >>> +     } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)=
 {
> > > >>> +             nf =3D find_writeable_file(fp);
> > > >>> +             dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > > >>>        }
> > > >>>
> > > >>>        /*
> > > >>
> > > >> I *think* the main reason we limited this before is because a writ=
e
> > > >> delegation is really a read/write delegation. There is no such thi=
ng as
> > > >> a write-only delegation.
> > > >>
> > > >> Suppose the user is prevented from doing reads against the inode (=
by
> > > >> permission bits or ACLs). The server gives out a WRITE delegation =
on a
> > > >> O_WRONLY open. Will the client allow cached opens for read regardl=
ess
> > > >> of the server's permissions? Or, does it know to check vs. the ser=
ver
> > > >> if the client tries to do an open for read in this situation?
> > > > I was curious and tried a simple test yesterday, using the FreeBSD =
server
> > > > configured to issue a write delegation for a write-only open.
> > > > The test simply opened write-only first and then read-only, for a f=
ile
> > > > with mode 222. It worked as expected for both the Linux and FreeBSD
> > > > clients (ie. returned a failure for the read-only open).
> > > > I've attached the packet capture for the Linux client, in case you =
are
> > > > interested.
> > >
> > > Nice, thanks for testing!
> > >
> > > >
> > > > I do believe this is allowed by the RFCs. In fact I think the RFCs
> > > > allow a server
> > > > to issue a write delegation for a read open (not that I am convince=
d that is a
> > > > good idea). The main thing to check is what the ACE in the write de=
legation
> > > > reply looks like, since my understanding is that the client is expe=
cted to do
> > > > an Access unless the ACE allows access.
> > > > Here's a little snippet:
> > > >      nfsace4   permissions; /* Defines users who don't
> > > >                                need an ACCESS call as
> > > >                                part of a delegated
> > > >                                open. */
> > >
> > > Yes, I had the same understanding...
> > >
> > > >
> > > > Now, is it a good idea to do this?
> > > > Well, my opinion (as the outsider;-) is that the server should foll=
ow whatever
> > > > the client requests, as far as practicable. ie. The OPEN_WANT flags=
:
> > > >     const OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE     =3D 0x0000;
> > > >     const OPEN4_SHARE_ACCESS_WANT_READ_DELEG        =3D 0x0100;
> > > >     const OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG       =3D 0x0200;
> > > >     const OPEN4_SHARE_ACCESS_WANT_ANY_DELEG         =3D 0x0300;
> > > >     const OPEN4_SHARE_ACCESS_WANT_NO_DELEG          =3D 0x0400;
> > > > If the client does not provide these (4.0 or 4.1/4.2, but no flags)=
, then I
> > > > suppose I might be concerned that there is a buggy client out there=
 that
> > > > would do what Jeff suggested (ie. assume it can open the file for r=
eading
> > > > after getting a write delegation).
> > >
> > > Well, that is obviously not what the Linux client is asking for today=
,
> > > but even if it
> > > did, what would it set in the OPEN_WANT flags for O_WRONLY open? it w=
ould
> > > set OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG.
> > >
> > > I do agree that there is an argument to be made that Linux nfsd shoul=
d not
> > > hand out any delegation that is not explicitly solicited by the clien=
t,
> > > but I don't see
> > > how this particular delegation against a wronly open is any different
> > > from any
> > > other type of delegation that Linux nfsd hands out today.
> > I guess the point I was trying to make was that, if a client explicitly
> > asks for a write delegation, then you issue it and the client screws up=
,
> > "the client got what it asked for".
> >
> > However, if the client has not previously seen a write delegation for t=
his
> > case and is not asking for it, then if it is buggy in this respect, a
> > server upgrade
> > results in a client failure (fun and bothersome to track down, even if
> > it really a
> > client bug). ie. There is a risk in this change (as Jeff noted) and imh=
o that
> > needs to be considered (and tested for as far as practicable).
> >
> > Anyhow, all the best and good luck with it, rick
> > ps: I suspect you guys are like me, in that you do not have easy access
> >       to other clients, like the resurrected CITI Windows client or the
> >       VMware one. (I think there is also a NFSv4.1 client in Windows
> >       server edition?)
>
> Windows Server only has a NFS4.1 server, but no client.
> NFSv4.1 clients for Windows are available from OpenText and
> https://github.com/kofemann/ms-nfs41-client
I'll believe you. (I have no access to Windows servers.)
What was weird is that I had someone with a problem a few
years ago, who claimed they were using a NFSv4.1 client in Windows server.
I even "corrected" them, but they claimed they did have it and
indicated that they had gotten it from Microsoft? Maybe they had the
OpenText one and he didn't realize it. I hadn't heard of the OpenText
one (used to be Hummingbird long ago).

Anyhow, thanks for the update, rick

>
> Thanks,
> Martin
>

