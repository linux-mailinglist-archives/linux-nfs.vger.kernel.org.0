Return-Path: <linux-nfs+bounces-4698-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314C9299D8
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4B32815D4
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E72E85E;
	Sun,  7 Jul 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0pSDV4J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20D76F1B
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2024 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720388966; cv=none; b=Xl1rM4JadK3jZ9CTd7SIMragYVets0wDY1WnBkst7hIkytc/3nQqAHP13Y4r7tMR/qB0OIEqayyWomkoro9L3Zx209XXTT5KPKQBWyStV8Q7O8OXCJA9NYinbtuoGugFV/VKOw2XpesHAKfrzqeZzUsqMobkRx/mjmRsa/YWV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720388966; c=relaxed/simple;
	bh=ciZBox53dB3xvDpXHlJw5G3G8BQ3hynEmsf2ZayQ3ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnw1RHV3of54eyMMecD+zKg6tE/0mKACld647UHDoUT78MsGzakqcPKX4aP65ZcCQ0eDq3PSJfokIt3wlCUTW0YNlgOfiWK49zq1/ummgBihX+M318k1dHwJ58pt4uovcDZWg/4SYqQY/AMUlq6CQkRudKtihSLXwCGKuQEXH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0pSDV4J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb1c918860so28072995ad.1
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jul 2024 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720388964; x=1720993764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWjThoMGEdg5rExaj5Ixi0ucwSvOnp9TOGvXLC4TwAY=;
        b=A0pSDV4JpXNYKU/RmySfVemkPDb4TsfGkTK3cjovUXDQ3sxKH96I94gEM4Fwkc1oRb
         3YMI8KEcwvBabqq18wDWL4IKe9ipoO8KOGfnJRnI+40j8BYaUCsVXHtE4jodm4jQ7MMb
         bzcu8EDzZ0PlxqOiT3efgx6tBKZ786u54rJ5zbnXn/ZBJyfnMKejnFSUzxY0tww/Opal
         naYnt5ITOdj0RiGNZmpciPacxki+QM6EGYAsAYeN4heQHCm4RS15LSQZD0KbGYLiezqy
         ofhjwQmknBpEx07qZQtks3T0v5F1bx+43XKm70b/fA4OLp5qBbLR1f6gWnLzWe59xx5f
         gC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720388964; x=1720993764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWjThoMGEdg5rExaj5Ixi0ucwSvOnp9TOGvXLC4TwAY=;
        b=sEZeylwJYjx2EcUeds+RnCWMRqhrYIaIta/S1x9jjV0sLTuRiMSfyQykx1lbxsVdCo
         sjGqSNVmRNgPT8qog2/YLDyAhwj/N5UcJ+RXCvrBhWixjMP1rHdKApLgzWROYFmTyM0X
         ohRYlxQV+E999OH4Y2negnlI/arrlRvc4JUzQYx45uT/bU3WvGefFqHFLaVX5S4zNTI9
         /8AWdS/nrVJg2dVvlN6dDK16YT4yPTDZNmxazfy//UaGIJQVnLlQrCk+m7mCBHvc4maZ
         BQ1lQCWGo3rIyKI4SZ8kFXB729DaunX2y3WfBdMNGQ4rgWIXouRpyNAQCL5cS35UYp96
         PDcw==
X-Forwarded-Encrypted: i=1; AJvYcCW4DF4EBgOehZcTNtRzLgpmBsKcGBBENJ4uLxOAnequbLXFU8nUEqKJ47ixf2B3cteCiWSCmESndjhp1+SBOxe4f+05EP/3KHHP
X-Gm-Message-State: AOJu0YxW3RVDMHoDn6jFIilMs1akDCQtX7Johr6/5sQdegrPgMUgM2Ly
	0ZwYIHo+YdmAib9wUJVg7Xd9QHyoL8RlfgZ65zg3v5Tf/yIiUDaj/UT/FGsi6MiCS1Z5/It7L6b
	TWLadn5LL4AuDM7IxrFhCKl6jgQ==
X-Google-Smtp-Source: AGHT+IF4vneaiy2AdvCADvGV8bbYuKNj+vYi9D528RYMyfmho4b35UijszdojPm4ZHTREl96fhwvHpIIP772sPmXz84=
X-Received: by 2002:a17:90a:6807:b0:2c2:4109:9466 with SMTP id
 98e67ed59e1d1-2c99f30922emr14229528a91.8.1720388964036; Sun, 07 Jul 2024
 14:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706224207.927978-1-sagi@grimberg.me> <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <CAM5tNy5WLTk6KbVwe4J8+0=ChhGQgXnK_Matt2Y1j_8W-0KR9g@mail.gmail.com> <bdae2f17-7fca-484e-ae46-b822df9f3576@grimberg.me>
In-Reply-To: <bdae2f17-7fca-484e-ae46-b822df9f3576@grimberg.me>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 7 Jul 2024 14:49:14 -0700
Message-ID: <CAM5tNy7XLxrLMchDTA+AZJkYUGw41FQpajVN6s2f7Z6qnFjkmg@mail.gmail.com>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 1:21=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wro=
te:
>
>
>
> On 07/07/2024 22:05, Rick Macklem wrote:
> > On Sun, Jul 7, 2024 at 4:07=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
> >>> Many applications open files with O_WRONLY, fully intending to write
> >>> into the opened file. There is no reason why these applications shoul=
d
> >>> not enjoy a write delegation handed to them.
> >>>
> >>> Cc: Dai Ngo <dai.ngo@oracle.com>
> >>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >>> ---
> >>> Note: I couldn't find any reason to why the initial implementation ch=
ose
> >>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it see=
med
> >>> like an oversight to me. So I figured why not just send it out and se=
e who
> >>> objects...
> >>>
> >>>   fs/nfsd/nfs4state.c | 10 +++++-----
> >>>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>> index a20c2c9d7d45..69d576b19eb6 100644
> >>> --- a/fs/nfsd/nfs4state.c
> >>> +++ b/fs/nfsd/nfs4state.c
> >>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, =
struct nfs4_ol_stateid *stp,
> >>>         *  "An OPEN_DELEGATE_WRITE delegation allows the client to ha=
ndle,
> >>>         *   on its own, all opens."
> >>>         *
> >>> -      * Furthermore the client can use a write delegation for most R=
EAD
> >>> -      * operations as well, so we require a O_RDWR file here.
> >>> -      *
> >>> -      * Offer a write delegation in the case of a BOTH open, and ens=
ure
> >>> -      * we get the O_RDWR descriptor.
> >>> +      * Offer a write delegation in the case of a BOTH open (ensure
> >>> +      * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descrip=
tor).
> >>>         */
> >>>        if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NF=
S4_SHARE_ACCESS_BOTH) {
> >>>                nf =3D find_rw_file(fp);
> >>>                dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> >>> +     } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> >>> +             nf =3D find_writeable_file(fp);
> >>> +             dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> >>>        }
> >>>
> >>>        /*
> >>
> >> I *think* the main reason we limited this before is because a write
> >> delegation is really a read/write delegation. There is no such thing a=
s
> >> a write-only delegation.
> >>
> >> Suppose the user is prevented from doing reads against the inode (by
> >> permission bits or ACLs). The server gives out a WRITE delegation on a
> >> O_WRONLY open. Will the client allow cached opens for read regardless
> >> of the server's permissions? Or, does it know to check vs. the server
> >> if the client tries to do an open for read in this situation?
> > I was curious and tried a simple test yesterday, using the FreeBSD serv=
er
> > configured to issue a write delegation for a write-only open.
> > The test simply opened write-only first and then read-only, for a file
> > with mode 222. It worked as expected for both the Linux and FreeBSD
> > clients (ie. returned a failure for the read-only open).
> > I've attached the packet capture for the Linux client, in case you are
> > interested.
>
> Nice, thanks for testing!
>
> >
> > I do believe this is allowed by the RFCs. In fact I think the RFCs
> > allow a server
> > to issue a write delegation for a read open (not that I am convinced th=
at is a
> > good idea). The main thing to check is what the ACE in the write delega=
tion
> > reply looks like, since my understanding is that the client is expected=
 to do
> > an Access unless the ACE allows access.
> > Here's a little snippet:
> >      nfsace4   permissions; /* Defines users who don't
> >                                need an ACCESS call as
> >                                part of a delegated
> >                                open. */
>
> Yes, I had the same understanding...
>
> >
> > Now, is it a good idea to do this?
> > Well, my opinion (as the outsider;-) is that the server should follow w=
hatever
> > the client requests, as far as practicable. ie. The OPEN_WANT flags:
> >     const OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE     =3D 0x0000;
> >     const OPEN4_SHARE_ACCESS_WANT_READ_DELEG        =3D 0x0100;
> >     const OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG       =3D 0x0200;
> >     const OPEN4_SHARE_ACCESS_WANT_ANY_DELEG         =3D 0x0300;
> >     const OPEN4_SHARE_ACCESS_WANT_NO_DELEG          =3D 0x0400;
> > If the client does not provide these (4.0 or 4.1/4.2, but no flags), th=
en I
> > suppose I might be concerned that there is a buggy client out there tha=
t
> > would do what Jeff suggested (ie. assume it can open the file for readi=
ng
> > after getting a write delegation).
>
> Well, that is obviously not what the Linux client is asking for today,
> but even if it
> did, what would it set in the OPEN_WANT flags for O_WRONLY open? it would
> set OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG.
I didn't think to mention that the client was a rather old 6.3 kernel.
If the Linux client is still not setting OPEN4_SHARE_ACCESS_WANT_xxx
flags, then maybe it should do so?
And maybe the client developers will be encouraged to set them, if the serv=
er
uses them?

I'll admit I had assumed they weren't there just because my kernel is
out of date.

rick

>
> I do agree that there is an argument to be made that Linux nfsd should no=
t
> hand out any delegation that is not explicitly solicited by the client,
> but I don't see
> how this particular delegation against a wronly open is any different
> from any
> other type of delegation that Linux nfsd hands out today.

