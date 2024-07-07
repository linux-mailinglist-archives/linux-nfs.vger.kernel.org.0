Return-Path: <linux-nfs+bounces-4699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C09299F1
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 00:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0011F211E7
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 22:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C514A82;
	Sun,  7 Jul 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5ZgqrMp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A86D26A
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720389949; cv=none; b=sQSepN4kplB+q/8HvoCLZv7RBx3MwPgG0mOX7BPNF488Qk4uJN5beTEPWo82SMYy1vbNKXQiSKqF9v90pIVr0vZ+0wFpsPVOFhhXj0/d+dDc7/qG1ATdBEBZ0VxVx5VL9IeEvDEEflr5NxHmBQFS4AN8VxeGJAL2E2mruWOgWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720389949; c=relaxed/simple;
	bh=m0lQaxboMSBMMialQOA4PQ7OOgWKtq1KTI5gmp1liBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSBUgRS4X3VXLqvSMtFdmkv8hC1mdv2X2p2tUWo8kZCxDsheWYvnQc+cY3tVSfAFxZdAg7VPISQ8blFL0c/gR7YxJL1yw+GEV73RZlWenEYzr/m+kNT971c65ZWKawlJAGU3nQsCdfmX7c2IPmg/T68z3qxMo2YFjF//NRbUj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5ZgqrMp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-73aba5230b6so2085085a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jul 2024 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720389947; x=1720994747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgBnW7csaL4UhHd55Q6xeNJTP8OEO4RGnu79pptwebI=;
        b=F5ZgqrMp2/lablLMDvOjhMklsQRqXnc7yGTuF5lp/7uXKoQ128/enw3TSgWTNYfNt7
         Qzuq/4keveg5AdpvJkgXzo+9/ckTK6IyoL6QDl0UpEoyteUQEF/jpEU/51Ll/5RVuFZP
         SIPyTp4BFD80gIQkLxOuI0hN8+Oi96zJ6Y/oHBT1qFP4TROVEO4tPknCIdPHfUJd3A8L
         Q70fePmfngawCklEYwGtyfltzzfKGgOB8omdsgmMJ1DXUdHq9VeMgf4skanG1i94DNja
         l457d6QOekqj+IAuCwgCTExBmR8K60qD7FSfFJB8i/2lHMphRps1Kz5e2NqBfUBiOQri
         4sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720389947; x=1720994747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgBnW7csaL4UhHd55Q6xeNJTP8OEO4RGnu79pptwebI=;
        b=JE6UC9qLK/tmo6nC5wsPf8V50W6zzLNCrf9gnbbKnli3GeOQjh0vVkgs69/8rK7dsw
         iQw0HkDoixYvp3vbqUOVhG1V9RddWG1+6Ux5pc1mCicAUUTAH11yTrdMbhjqIAa0gXKk
         G0uYYKKZ/RvIuf3vsEjOzbPaBl0S95FJRZYoZITrazyGyUs13XphmGDDMQqwJjwRSDtl
         iKWobN27LjO+tZEN+sJyuixrRrTreY6wpvJgjgcjgkDOhCVxHCBWUrStGLi3zjy2flrA
         q9fa1cbSR/0xlFPIGlMLmQXcSDWlpMU5UE/W1j2XtEc7JeU5uRl5DKkgtc+tHFQ20FLl
         Bheg==
X-Forwarded-Encrypted: i=1; AJvYcCWE6lzwwvMXDlkaEp/lufa6Yq1zlrmiqjCf1/SkHCP0tcy4BuMExfHvQ6dYnE1I/ZnKDhiYeRshD36tUn49iUta5dw0Ojk7NSx8
X-Gm-Message-State: AOJu0YzgZf0SuEW+mWPd2ZMXXrkjRhNok4roSGaWv3MfVbQfm3mB7ZLR
	IQCHLyqMxJ6WgcX/D/9+JwanDGEi5xIxAGN9TLx2QE2ynXSJy5S/s9G3uP1rmcUFnYP8k0aPEzW
	VW66+CbscN+t/2SgoXnrS5J7+eg4d
X-Google-Smtp-Source: AGHT+IEcoX2yduhj3VOegiUWpar4/YVUL8C28UwSNXGxvbrKpLilBxINHr0BYPL4eNRN9fU2jXZChA7W26zjgRs54zk=
X-Received: by 2002:a17:90a:ce15:b0:2c8:3e89:bbab with SMTP id
 98e67ed59e1d1-2c99f3c0834mr14342034a91.22.1720389947418; Sun, 07 Jul 2024
 15:05:47 -0700 (PDT)
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
Date: Sun, 7 Jul 2024 15:05:37 -0700
Message-ID: <CAM5tNy51seoWht2vk46DX_setpaoe26PDYTQ-CwmLC_iyY0mNg@mail.gmail.com>
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
>
> I do agree that there is an argument to be made that Linux nfsd should no=
t
> hand out any delegation that is not explicitly solicited by the client,
> but I don't see
> how this particular delegation against a wronly open is any different
> from any
> other type of delegation that Linux nfsd hands out today.
I guess the point I was trying to make was that, if a client explicitly
asks for a write delegation, then you issue it and the client screws up,
"the client got what it asked for".

However, if the client has not previously seen a write delegation for this
case and is not asking for it, then if it is buggy in this respect, a
server upgrade
results in a client failure (fun and bothersome to track down, even if
it really a
client bug). ie. There is a risk in this change (as Jeff noted) and imho th=
at
needs to be considered (and tested for as far as practicable).

Anyhow, all the best and good luck with it, rick
ps: I suspect you guys are like me, in that you do not have easy access
      to other clients, like the resurrected CITI Windows client or the
      VMware one. (I think there is also a NFSv4.1 client in Windows
      server edition?)

