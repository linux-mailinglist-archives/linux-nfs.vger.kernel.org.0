Return-Path: <linux-nfs+bounces-6647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E529861D6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 17:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208F41C27119
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F0817557;
	Wed, 25 Sep 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpFlGACD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CF49620
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275488; cv=none; b=SjSkDgaPLVGztZAcYGJ6neOQMcYoihl/r1kungCukDFwTtQsSmyyT/mS1r3smZeTpYO89gKANKX9QzWIbZ6AMQTG3rfsrCZnP+kdJmPw2tNVRQCCR5WzXAfyC8LXuFVfKTZYZJQf6l2oiYdHbMbmTRmvKR9X0w7dXTtc45YKRJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275488; c=relaxed/simple;
	bh=jwy2Lh9NGwhdm0D6du1DrKM7gPc6mN9T6lHq4YXkbzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gpWzKY+Yl2hhXY6KyfQUFSp9NA57ALSBXC/QnR2W2d7+O3moRcM1TVzbvkb90PJu99h7dOMzIBs4IXJn8EznnuOjqySRIi5FnuxBixJ9PKoxpq2xywrxcyugCF1tPNZUEmcw7NEu5cR7JAnl9VZ/H9/42uMI6MIWMCE6mv7/+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpFlGACD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so872293166b.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727275484; x=1727880284; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdacfTBCJgwTToLmAay0ZUTaMXzrR9OjozoT7pwzDZA=;
        b=jpFlGACDY/VO+COw+1ekbbERq1jDqCxC0AcAtPIChFPpsdh+Quy/V72qS4vHKwI7PW
         bqA9xquTsLCnc2B71QQahIKQeICQVDvrRa/jlth8Pl4EgN2vDhyygLp+NQSH5IKSHCSD
         GTTRT1aKBddekz9pfHdNzDJzBWOEZrymYF666JeP7AK7YKv/65v0I2z+weM9wxVDtLe3
         EycZcFHMnKzKglW/muvRRg9+Jycmbb/YDm+nr46KyM+M/8rplX4T75K4KEVknVhPp20v
         dNcuFd+LPlU2P57Cv+euxnxoUMzbbAu0EdUpstfwkBPherfVrGyCnf0hbIQZaeHsxHw6
         tBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727275484; x=1727880284;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdacfTBCJgwTToLmAay0ZUTaMXzrR9OjozoT7pwzDZA=;
        b=EDBGHj3XMV5vsI3pZavgundgRgTtJkwxKd2fDVSpFZWec4ZTML215vU6Z2uWlb6DcD
         JTsiGKEYEuefvZMMfFZMFDuYTpD8/HkYqjikiHKxlvw/+I7PpL+T33mibBMePYZle6tq
         nLhw28oSx4JWC4dkvubGH2pFdMNn/vL1+/mdkWWk+Jrvnf0cjIilWmeLrrXloNck5fdr
         Z50t8K3igJjLx2ohSTKn6cyjwl3eZgzh0dvNLUw1kOmRQ+wJGE9W+kLS654O53Y4HdvK
         sXld34Wsb4Ri2RwmpM3ZNGrLDvEOIidRRrRr8UBXESfpOPDNkTfUxNeQs4K3zgkP3Vjp
         SAqg==
X-Gm-Message-State: AOJu0YxxJDNZuNp7hNAvBVgZiPCRVjhYYeR4xKZlmqWYFibYT4SGCgEL
	khSAUy3xlsLZ6Ir79sbxXc4sSt/JYJ5m7isG7XcKA+KH2GnvuACFInBVyjaQhMtd7qrnxyHm2k0
	ebJx38OTYzG7nXrS7G4GdxxQ7FdC/5ZXwXr/gfMIX
X-Google-Smtp-Source: AGHT+IG1KpC0bpnHIvGJUyb+q2zlJMIKbCXDC91ieWYNJ7lUcVmkSgWrOksnakptfLDWvnCy+lwbabic+ORmja2Zb0M=
X-Received: by 2002:a17:907:7287:b0:a8a:9207:c4c1 with SMTP id
 a640c23a62f3a-a93a068a306mr302627766b.58.1727275483784; Wed, 25 Sep 2024
 07:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706224207.927978-1-sagi@grimberg.me> <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <CAM5tNy5WLTk6KbVwe4J8+0=ChhGQgXnK_Matt2Y1j_8W-0KR9g@mail.gmail.com>
 <bdae2f17-7fca-484e-ae46-b822df9f3576@grimberg.me> <CAM5tNy51seoWht2vk46DX_setpaoe26PDYTQ-CwmLC_iyY0mNg@mail.gmail.com>
In-Reply-To: <CAM5tNy51seoWht2vk46DX_setpaoe26PDYTQ-CwmLC_iyY0mNg@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Wed, 25 Sep 2024 16:44:07 +0200
Message-ID: <CANH4o6OeyMFYqGUYJnbjowm+wznvCfLOm6n+OHOXdpMTuGLZEQ@mail.gmail.com>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 12:05=E2=80=AFAM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Sun, Jul 7, 2024 at 1:21=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> w=
rote:
> >
> >
> >
> > On 07/07/2024 22:05, Rick Macklem wrote:
> > > On Sun, Jul 7, 2024 at 4:07=E2=80=AFAM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > >> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
> > >>> Many applications open files with O_WRONLY, fully intending to writ=
e
> > >>> into the opened file. There is no reason why these applications sho=
uld
> > >>> not enjoy a write delegation handed to them.
> > >>>
> > >>> Cc: Dai Ngo <dai.ngo@oracle.com>
> > >>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > >>> ---
> > >>> Note: I couldn't find any reason to why the initial implementation =
chose
> > >>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it s=
eemed
> > >>> like an oversight to me. So I figured why not just send it out and =
see who
> > >>> objects...
> > >>>
> > >>>   fs/nfsd/nfs4state.c | 10 +++++-----
> > >>>   1 file changed, 5 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > >>> index a20c2c9d7d45..69d576b19eb6 100644
> > >>> --- a/fs/nfsd/nfs4state.c
> > >>> +++ b/fs/nfsd/nfs4state.c
> > >>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open=
, struct nfs4_ol_stateid *stp,
> > >>>         *  "An OPEN_DELEGATE_WRITE delegation allows the client to =
handle,
> > >>>         *   on its own, all opens."
> > >>>         *
> > >>> -      * Furthermore the client can use a write delegation for most=
 READ
> > >>> -      * operations as well, so we require a O_RDWR file here.
> > >>> -      *
> > >>> -      * Offer a write delegation in the case of a BOTH open, and e=
nsure
> > >>> -      * we get the O_RDWR descriptor.
> > >>> +      * Offer a write delegation in the case of a BOTH open (ensur=
e
> > >>> +      * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descr=
iptor).
> > >>>         */
> > >>>        if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D =
NFS4_SHARE_ACCESS_BOTH) {
> > >>>                nf =3D find_rw_file(fp);
> > >>>                dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > >>> +     } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > >>> +             nf =3D find_writeable_file(fp);
> > >>> +             dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > >>>        }
> > >>>
> > >>>        /*
> > >>
> > >> I *think* the main reason we limited this before is because a write
> > >> delegation is really a read/write delegation. There is no such thing=
 as
> > >> a write-only delegation.
> > >>
> > >> Suppose the user is prevented from doing reads against the inode (by
> > >> permission bits or ACLs). The server gives out a WRITE delegation on=
 a
> > >> O_WRONLY open. Will the client allow cached opens for read regardles=
s
> > >> of the server's permissions? Or, does it know to check vs. the serve=
r
> > >> if the client tries to do an open for read in this situation?
> > > I was curious and tried a simple test yesterday, using the FreeBSD se=
rver
> > > configured to issue a write delegation for a write-only open.
> > > The test simply opened write-only first and then read-only, for a fil=
e
> > > with mode 222. It worked as expected for both the Linux and FreeBSD
> > > clients (ie. returned a failure for the read-only open).
> > > I've attached the packet capture for the Linux client, in case you ar=
e
> > > interested.
> >
> > Nice, thanks for testing!
> >
> > >
> > > I do believe this is allowed by the RFCs. In fact I think the RFCs
> > > allow a server
> > > to issue a write delegation for a read open (not that I am convinced =
that is a
> > > good idea). The main thing to check is what the ACE in the write dele=
gation
> > > reply looks like, since my understanding is that the client is expect=
ed to do
> > > an Access unless the ACE allows access.
> > > Here's a little snippet:
> > >      nfsace4   permissions; /* Defines users who don't
> > >                                need an ACCESS call as
> > >                                part of a delegated
> > >                                open. */
> >
> > Yes, I had the same understanding...
> >
> > >
> > > Now, is it a good idea to do this?
> > > Well, my opinion (as the outsider;-) is that the server should follow=
 whatever
> > > the client requests, as far as practicable. ie. The OPEN_WANT flags:
> > >     const OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE     =3D 0x0000;
> > >     const OPEN4_SHARE_ACCESS_WANT_READ_DELEG        =3D 0x0100;
> > >     const OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG       =3D 0x0200;
> > >     const OPEN4_SHARE_ACCESS_WANT_ANY_DELEG         =3D 0x0300;
> > >     const OPEN4_SHARE_ACCESS_WANT_NO_DELEG          =3D 0x0400;
> > > If the client does not provide these (4.0 or 4.1/4.2, but no flags), =
then I
> > > suppose I might be concerned that there is a buggy client out there t=
hat
> > > would do what Jeff suggested (ie. assume it can open the file for rea=
ding
> > > after getting a write delegation).
> >
> > Well, that is obviously not what the Linux client is asking for today,
> > but even if it
> > did, what would it set in the OPEN_WANT flags for O_WRONLY open? it wou=
ld
> > set OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG.
> >
> > I do agree that there is an argument to be made that Linux nfsd should =
not
> > hand out any delegation that is not explicitly solicited by the client,
> > but I don't see
> > how this particular delegation against a wronly open is any different
> > from any
> > other type of delegation that Linux nfsd hands out today.
> I guess the point I was trying to make was that, if a client explicitly
> asks for a write delegation, then you issue it and the client screws up,
> "the client got what it asked for".
>
> However, if the client has not previously seen a write delegation for thi=
s
> case and is not asking for it, then if it is buggy in this respect, a
> server upgrade
> results in a client failure (fun and bothersome to track down, even if
> it really a
> client bug). ie. There is a risk in this change (as Jeff noted) and imho =
that
> needs to be considered (and tested for as far as practicable).
>
> Anyhow, all the best and good luck with it, rick
> ps: I suspect you guys are like me, in that you do not have easy access
>       to other clients, like the resurrected CITI Windows client or the
>       VMware one. (I think there is also a NFSv4.1 client in Windows
>       server edition?)

Windows Server only has a NFS4.1 server, but no client.
NFSv4.1 clients for Windows are available from OpenText and
https://github.com/kofemann/ms-nfs41-client

Thanks,
Martin

