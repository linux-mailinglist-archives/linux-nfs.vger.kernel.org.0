Return-Path: <linux-nfs+bounces-6879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9E79916CD
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA97284304
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADEB40BE5;
	Sat,  5 Oct 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpnpy+Xe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A0231C81
	for <linux-nfs@vger.kernel.org>; Sat,  5 Oct 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131885; cv=none; b=O010LnJTd6HhJFHJOu2w33Jq3rO2mbtT957tFAt0zNijbllth+wx2FsEUxh82Qwk8F8OiaCco+DSRMX/7VXmmSTnyBQiCpq6LUdSfvkmIBnwDeo4Aav15HjXcKEggBKTYow3HSrDDFPvYkDFn3R16+ZTmoVhY/ALfV7q801Rm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131885; c=relaxed/simple;
	bh=F3V7oCbbMfp9hP3i9avca6G95aRQNYSH2BVKtNoPQYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZCilqpI0dZkQD5iiHuedrRBUepe2ESYWJhSv0wywlN8KtZFT/sbFHsYCoWsxqnMO2/0gNzKw+h/zEMkAjl/J/rf6Kx6mY5crXzWT5h6ko9UX9f5wbOhdiA1QV+YKQ+hmzenJUs+blbeFaQQgoUsiKtPgjivX+nqFGlBNWn6SKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lpnpy+Xe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86e9db75b9so427825966b.1
        for <linux-nfs@vger.kernel.org>; Sat, 05 Oct 2024 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131882; x=1728736682; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq/AQOmhVJUVTQ7zbb6hry+6Ye8clkL2wg6RuLrbaQ8=;
        b=Lpnpy+Xe8Nb1UHy+8iTHri7Vn+ydnQzC3WRkscvkV5zwu/O9yjRAwGzu9W/kLVd1yU
         h0+AonvviptisR6yoFcfS6Qh+WK2xWc+tFXJli5Cnfs0+/qEBH//991ip1r2b78MfXUo
         HLHv/XnSvmGXVFNZHgih97g4kC9zMnJeCjgCWdaY1rU66DWYb0Q5PS/Bak+McpEOHsMf
         /L+kazkYQDPDnfioSGNPt+LBx9cnTwl5RZiUERQ+3RsDqOSvc58qm+Ud9yDcD3agJIVE
         cyZKOhr4vgERIui4Xf9pQXL8rb0CWXH4Z+1ktFf4NpysHPSR2xZHQaJh/SYN+D2j/5gz
         j5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131882; x=1728736682;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mq/AQOmhVJUVTQ7zbb6hry+6Ye8clkL2wg6RuLrbaQ8=;
        b=su0wR77vFTY+Rss2IZPZa0J7HZihXPYFKwpzXYKiDeDo4Vx+ijSYxag6IedwoDwDo3
         1tJauFwHLpfc4k859tUzAhWFZ45kdbXubH+FvNsFF8ikGbMKfTQtr8b20MN//6D0AHu0
         sdcLeNvn4SOBnpSPyWAvLFMJs0ESH7ue7RSWfCXKlfd/dCY4ki/MMmHtycyF51PZzgCm
         AtmNYE0mRB7zMswSCV35Se89i2jUZUH04UvHmzun4xromVoeVGizsM+k/s/gSUG4BQEo
         s4Q1Xzd4aRsYyRSbSfKwuSSyi1dW5XmqsM71bbyE/8t2JAQdBzxBTFU0XxcznP2WncXE
         z8hw==
X-Gm-Message-State: AOJu0YyY3O8zOTeJco9efoNwC4cB9KHkj+50EF7zejjyZT/NU6SoF0Qq
	P8MCs42UodrbkPHDD1je+RzSqhkf12yFoBpVgtQ2FPOH4tpn1dGIvktlsOAlAY5I0FYjEX9InAf
	CJkGftpH487oZQ6vpPjk1+jFg4XbzlH5HzW4=
X-Google-Smtp-Source: AGHT+IG3yWPfoivoi2Ay8+K+HDQbXlsxKpy0lPZwMuGMoakSf+tq6QzQ4MgiFyC+ZXGLq5KfYMQKiSz4GPhVJ8dHt0U=
X-Received: by 2002:a17:907:9809:b0:a99:3f4e:6de8 with SMTP id
 a640c23a62f3a-a993f4e6e28mr143352966b.64.1728131881652; Sat, 05 Oct 2024
 05:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706224207.927978-1-sagi@grimberg.me> <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <CAM5tNy5WLTk6KbVwe4J8+0=ChhGQgXnK_Matt2Y1j_8W-0KR9g@mail.gmail.com>
 <bdae2f17-7fca-484e-ae46-b822df9f3576@grimberg.me> <CAM5tNy51seoWht2vk46DX_setpaoe26PDYTQ-CwmLC_iyY0mNg@mail.gmail.com>
 <CANH4o6OeyMFYqGUYJnbjowm+wznvCfLOm6n+OHOXdpMTuGLZEQ@mail.gmail.com> <CAM5tNy4KEKymJ9QhJZG+PevO7qDt7Fk3m6ORKF0UhoVmcjoAVA@mail.gmail.com>
In-Reply-To: <CAM5tNy4KEKymJ9QhJZG+PevO7qDt7Fk3m6ORKF0UhoVmcjoAVA@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sat, 5 Oct 2024 14:37:24 +0200
Message-ID: <CANH4o6P8+LJ47mkY=mfT9155BYVUK4Cuf_Y_Gk78ng_pk0o00g@mail.gmail.com>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:33=E2=80=AFPM Rick Macklem <rick.macklem@gmail.c=
om> wrote:
>
> On Wed, Sep 25, 2024 at 8:03=E2=80=AFAM Martin Wege <martin.l.wege@gmail.=
com> wrote:
> >
> > CAUTION: This email originated from outside of the University of Guelph=
. Do not click links or open attachments unless you recognize the sender an=
d know the content is safe. If in doubt, forward suspicious emails to IThel=
p@uoguelph.ca.
> >
> >
> > On Mon, Jul 8, 2024 at 12:05=E2=80=AFAM Rick Macklem <rick.macklem@gmai=
l.com> wrote:
> > >
> > > On Sun, Jul 7, 2024 at 1:21=E2=80=AFPM Sagi Grimberg <sagi@grimberg.m=
e> wrote:
> > > >
> > > >
> > > >
> > > > On 07/07/2024 22:05, Rick Macklem wrote:
> > > > > On Sun, Jul 7, 2024 at 4:07=E2=80=AFAM Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > >> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
> > > > >>> Many applications open files with O_WRONLY, fully intending to =
write
> > > > >>> into the opened file. There is no reason why these applications=
 should
> > > > >>> not enjoy a write delegation handed to them.
> > > > >>>
> > > > >>> Cc: Dai Ngo <dai.ngo@oracle.com>
> > > > >>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > > >>> ---
> > > > >>> Note: I couldn't find any reason to why the initial implementat=
ion chose
> > > > >>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but =
it seemed
> > > > >>> like an oversight to me. So I figured why not just send it out =
and see who
> > > > >>> objects...
> > > > >>>
> > > > >>>   fs/nfsd/nfs4state.c | 10 +++++-----
> > > > >>>   1 file changed, 5 insertions(+), 5 deletions(-)
> > > > >>>
> > > > >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > >>> index a20c2c9d7d45..69d576b19eb6 100644
> > > > >>> --- a/fs/nfsd/nfs4state.c
> > > > >>> +++ b/fs/nfsd/nfs4state.c
> > > > >>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *=
open, struct nfs4_ol_stateid *stp,
> > > > >>>         *  "An OPEN_DELEGATE_WRITE delegation allows the client=
 to handle,
> > > > >>>         *   on its own, all opens."
> > > > >>>         *
> > > > >>> -      * Furthermore the client can use a write delegation for =
most READ
> > > > >>> -      * operations as well, so we require a O_RDWR file here.
> > > > >>> -      *
> > > > >>> -      * Offer a write delegation in the case of a BOTH open, a=
nd ensure
> > > > >>> -      * we get the O_RDWR descriptor.
> > > > >>> +      * Offer a write delegation in the case of a BOTH open (e=
nsure
> > > > >>> +      * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY d=
escriptor).
> > > > >>>         */
> > > > >>>        if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=
=3D NFS4_SHARE_ACCESS_BOTH) {
> > > > >>>                nf =3D find_rw_file(fp);
> > > > >>>                dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > > > >>> +     } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRIT=
E) {
> > > > >>> +             nf =3D find_writeable_file(fp);
> > > > >>> +             dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > > > >>>        }
> > > > >>>
> > > > >>>        /*
> > > > >>
> > > > >> I *think* the main reason we limited this before is because a wr=
ite
> > > > >> delegation is really a read/write delegation. There is no such t=
hing as
> > > > >> a write-only delegation.
> > > > >>
> > > > >> Suppose the user is prevented from doing reads against the inode=
 (by
> > > > >> permission bits or ACLs). The server gives out a WRITE delegatio=
n on a
> > > > >> O_WRONLY open. Will the client allow cached opens for read regar=
dless
> > > > >> of the server's permissions? Or, does it know to check vs. the s=
erver
> > > > >> if the client tries to do an open for read in this situation?
> > > > > I was curious and tried a simple test yesterday, using the FreeBS=
D server
> > > > > configured to issue a write delegation for a write-only open.
> > > > > The test simply opened write-only first and then read-only, for a=
 file
> > > > > with mode 222. It worked as expected for both the Linux and FreeB=
SD
> > > > > clients (ie. returned a failure for the read-only open).
> > > > > I've attached the packet capture for the Linux client, in case yo=
u are
> > > > > interested.
> > > >
> > > > Nice, thanks for testing!
> > > >
> > > > >
> > > > > I do believe this is allowed by the RFCs. In fact I think the RFC=
s
> > > > > allow a server
> > > > > to issue a write delegation for a read open (not that I am convin=
ced that is a
> > > > > good idea). The main thing to check is what the ACE in the write =
delegation
> > > > > reply looks like, since my understanding is that the client is ex=
pected to do
> > > > > an Access unless the ACE allows access.
> > > > > Here's a little snippet:
> > > > >      nfsace4   permissions; /* Defines users who don't
> > > > >                                need an ACCESS call as
> > > > >                                part of a delegated
> > > > >                                open. */
> > > >
> > > > Yes, I had the same understanding...
> > > >
> > > > >
> > > > > Now, is it a good idea to do this?
> > > > > Well, my opinion (as the outsider;-) is that the server should fo=
llow whatever
> > > > > the client requests, as far as practicable. ie. The OPEN_WANT fla=
gs:
> > > > >     const OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE     =3D 0x0000;
> > > > >     const OPEN4_SHARE_ACCESS_WANT_READ_DELEG        =3D 0x0100;
> > > > >     const OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG       =3D 0x0200;
> > > > >     const OPEN4_SHARE_ACCESS_WANT_ANY_DELEG         =3D 0x0300;
> > > > >     const OPEN4_SHARE_ACCESS_WANT_NO_DELEG          =3D 0x0400;
> > > > > If the client does not provide these (4.0 or 4.1/4.2, but no flag=
s), then I
> > > > > suppose I might be concerned that there is a buggy client out the=
re that
> > > > > would do what Jeff suggested (ie. assume it can open the file for=
 reading
> > > > > after getting a write delegation).
> > > >
> > > > Well, that is obviously not what the Linux client is asking for tod=
ay,
> > > > but even if it
> > > > did, what would it set in the OPEN_WANT flags for O_WRONLY open? it=
 would
> > > > set OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG.
> > > >
> > > > I do agree that there is an argument to be made that Linux nfsd sho=
uld not
> > > > hand out any delegation that is not explicitly solicited by the cli=
ent,
> > > > but I don't see
> > > > how this particular delegation against a wronly open is any differe=
nt
> > > > from any
> > > > other type of delegation that Linux nfsd hands out today.
> > > I guess the point I was trying to make was that, if a client explicit=
ly
> > > asks for a write delegation, then you issue it and the client screws =
up,
> > > "the client got what it asked for".
> > >
> > > However, if the client has not previously seen a write delegation for=
 this
> > > case and is not asking for it, then if it is buggy in this respect, a
> > > server upgrade
> > > results in a client failure (fun and bothersome to track down, even i=
f
> > > it really a
> > > client bug). ie. There is a risk in this change (as Jeff noted) and i=
mho that
> > > needs to be considered (and tested for as far as practicable).
> > >
> > > Anyhow, all the best and good luck with it, rick
> > > ps: I suspect you guys are like me, in that you do not have easy acce=
ss
> > >       to other clients, like the resurrected CITI Windows client or t=
he
> > >       VMware one. (I think there is also a NFSv4.1 client in Windows
> > >       server edition?)
> >
> > Windows Server only has a NFS4.1 server, but no client.
> > NFSv4.1 clients for Windows are available from OpenText and
> > https://github.com/kofemann/ms-nfs41-client
> I'll believe you. (I have no access to Windows servers.)
> What was weird is that I had someone with a problem a few
> years ago, who claimed they were using a NFSv4.1 client in Windows server=
.

The Windows NFS41 client project was done by CITI at the behest of
Microsoft&SUN Microsystems. Then Oracle took over SUN, stopped
funding, and instead tried to milk money out of the stakeholders for
"support", and the project was quickly abandoned.

https://github.com/kofemann/ms-nfs41-client is based on CITIs original
work where they left off, with major improvements to get it useable
for production systems

> I even "corrected" them, but they claimed they did have it and
> indicated that they had gotten it from Microsoft? Maybe they had the
> OpenText one and he didn't realize it. I hadn't heard of the OpenText
> one (used to be Hummingbird long ago).

Nope, the binaries for the MS NFS41 client popped up around 2008-2010.
Read https://www.heise.de/news/Quelloffener-Windows-Treiber-fuer-NFSv4-1-fe=
rtiggestellt-1103643.html
OpenText is NFS4.0, CITI is NFS4.1, the resurrected CITI is NFS4.2

Thanks,
Martin

