Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D54B9228
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 16:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbfITOZu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 10:25:50 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:37884 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388721AbfITOZu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 10:25:50 -0400
Received: by mail-vs1-f44.google.com with SMTP id p13so4819021vsr.4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcx1uEMvw3GzLwM9G/xTNgfTgrB4S0D+++CX9SvPoGo=;
        b=O0syWT8jFI+00Akbw2Fy69+dZPwuNeOZQrPkZar8U+pIIqJbEviLxtlKXd2qop84SZ
         +MTxzrP3FnknlNiSrtZ1/tqwfCwr3w9cc+m9ZkAFFjuUFgmFLAk4HJkQTiXek1PRCB0+
         erN4vFa1eg+HR3RNrj8RyZfGiYT2mibr3sjnfGF9N1tRgdVbsV8/1poJHP4jaXXoUYKX
         6LRFNy3AfIgVfXx88iGBLfheaW6JikfzoFy54AWt2WrtszO3t07Ys9svxnFZ9nbFgO2r
         gWGPGoXxo2TF3vmuPs8ruKRfpO3VH8HTmSSgiq3060+QHRJwJ8ATW3WsaxH1dArWl3LH
         hDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcx1uEMvw3GzLwM9G/xTNgfTgrB4S0D+++CX9SvPoGo=;
        b=XOmBbxcyZ8u8N1ElfCj7JoDpxw0MPPrRZjHvZZbH9WSjkrXz19Bmr+VTmqiOJOl9z1
         4/3ZxdpsSL0hGm8b3Uz4PUGWsg8H616dNFuTLYPrTCMnTy32c6AajiTjPlnw8VFeXkGC
         sgkid+SA8TtXEKFpUhSUCb/WiPW8lLFfP7gJciEa/LkFjHHvwUBEP4XcD2LUrWm5Gp5r
         /ywSLou9OJCY3eIGZqOhVSEkyFXLvWeXxwZDzRFQqKaYDiPet4dgd1dDiahwsHH3Fxr7
         1aNhCg1jXwlNLrCAvY5p9prLPd70hFjcOsbESYcQMCmlBRs5QatETLnfiCBcd+2bH5S+
         OIvA==
X-Gm-Message-State: APjAAAWoVL7V/ujpmzzNs3j0wrkPxAyzQ9UwMAceV1e6uL6Y9GOLy9OP
        cIPk30lOT5IZSHgel1VqW1YfTG2emNB0JLXWawvwiQ==
X-Google-Smtp-Source: APXvYqzSSyq9qsPgS5DSvNSTxOjbbccOwTtXjT0flcOHBr1d1hpaIM1sxKmSAZjC9JttqeQr1Ith3e/tWHhWbYoDoeM=
X-Received: by 2002:a67:c991:: with SMTP id y17mr2766886vsk.85.1568989548886;
 Fri, 20 Sep 2019 07:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <CAN-5tyF27z=+3tbU1De_wR0aosiczn67dNanBmBe4icj=uAYwQ@mail.gmail.com>
 <4c620de7a944ff38644eceb4fed863f5092f1a15.camel@hammerspace.com>
 <CAN-5tyGX_Mb-wGTREtSWRFFSNK0qjgqLbm8SFPG=DPM7M2OWoQ@mail.gmail.com> <8720be3295e3b0035396b9bec70231a628231c93.camel@hammerspace.com>
In-Reply-To: <8720be3295e3b0035396b9bec70231a628231c93.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 20 Sep 2019 10:25:37 -0400
Message-ID: <CAN-5tyHgP75cJL4SNb+-Q8iDaJOTPt6JUbjMQjJYvdZfBrdecA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Various NFSv4 state error handling fixes
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Thu, Sep 19, 2019 at 7:42 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hi Olga
>
> On Thu, 2019-09-19 at 09:14 -0400, Olga Kornievskaia wrote:
> > Hi Trond,
> >
> > On Wed, Sep 18, 2019 at 9:49 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > Hi Olga
> > >
> > > On Wed, 2019-09-18 at 15:38 -0400, Olga Kornievskaia wrote:
> > > > Hi Trond,
> > > >
> > > > These set of patches do not address the locking problem. It's
> > > > actually
> > > > not the locking patch (which I thought it was as I reverted it
> > > > and
> > > > still had the issue). Without the whole patch series the unlock
> > > > works
> > > > fine so something in these new patches. Something is up with the
> > > > 2
> > > > patches:
> > > > NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
> > > > NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU
> > > >
> > > > If I remove either one separately, unlock fails but if I remove
> > > > both
> > > > unlock works.
> > >
> > > Can you describe how you are testing this, and perhaps provide
> > > wireshark traces that show how we're triggering these problems?
> >
> > I'm triggering by running "nfstest_lock --nfsversion 4.1 --runtest
> > btest01" against either linux or ontap servers (while the test
> > doesn't
> > fail but on the network trace you can see unlock failing with
> > bad_stateid). Network trace attached.
> >
> > But actually a simple test open, lock, unlock does the trick (network
> > trace attached).
> > fd1 = open(RDWR)
> > fctl(fd1) (lock /unlock)
>
>
> These traces really do not mesh with what I'm seeing using a simple
> Connectathon lock test run. When I look at the wireshark output from
> that, I see exadtly two cases where the stateid arguments are both
> zero, and those are both SETATTR, so expected.
>
> All the LOCKU are showing up as non-zero stateids, and so I'm seeing no
> BAD_STATEID or OLD_STATEID errors at all.
>
> Is there something special about how your test is running?

There is nothing special that I can think of about my setup or how
test run. I pull from your testing branch, build it (no extra
patches). Run tests over 4.1 (default mount opts) against a linux
server (typically same kernel).

Is this patch series somewhere in your git branches? I've been testing
your testing branch (as I could see v2 changes were in the testing
branch). It's not obvious to me what was changed in v3 to see if the
testing branch has the right code.

>
> Cheers
>   Trond
>
> PS: Note: I do think I need a v3 of the LOCKU patch in order to add a
> spinlock around the new copy of the lock stateid in
> nfs4_alloc_unlockdata(). However I don't see how the missing spinlocks
> could cause you to consistently be seeing an all-zero stateid argument.

I'm not testing with v3 so I don't think that's it.

>
>
> >
> > > Thanks!
> > >   Trond
> > >
> > > > On Mon, Sep 16, 2019 at 4:46 PM Trond Myklebust <
> > > > trondmy@gmail.com>
> > > > wrote:
> > > > > Various NFSv4 fixes to ensure we handle state errors correctly.
> > > > > In
> > > > > particular, we need to ensure that for COMPOUNDs like CLOSE and
> > > > > DELEGRETURN, that may have an embedded LAYOUTRETURN, we handle
> > > > > the
> > > > > layout state errors so that a retry of either the LAYOUTRETURN,
> > > > > or
> > > > > the later CLOSE/DELEGRETURN does not corrupt the LAYOUTRETURN
> > > > > reply.
> > > > >
> > > > > Also ensure that if we get a NFS4ERR_OLD_STATEID, then we do
> > > > > our
> > > > > best to still try to destroy the state on the server, in order
> > > > > to
> > > > > avoid causing state leakage.
> > > > >
> > > > > v2: Fix bug reports from Olga
> > > > >  - Try to avoid sending old stateids on CLOSE/OPEN_DOWNGRADE
> > > > > when
> > > > >    doing fully serialised NFSv4.0.
> > > > >  - Ensure LOCKU initialises the stateid correctly.
> > > > >
> > > > > Trond Myklebust (9):
> > > > >   pNFS: Ensure we do clear the return-on-close layout stateid
> > > > > on
> > > > > fatal
> > > > >     errors
> > > > >   NFSv4: Clean up pNFS return-on-close error handling
> > > > >   NFSv4: Handle NFS4ERR_DELAY correctly in return-on-close
> > > > >   NFSv4: Handle RPC level errors in LAYOUTRETURN
> > > > >   NFSv4: Add a helper to increment stateid seqids
> > > > >   pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping
> > > > > the
> > > > > state
> > > > >     seqid
> > > > >   NFSv4: Fix OPEN_DOWNGRADE error handling
> > > > >   NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
> > > > >   NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU
> > > > >
> > > > >  fs/nfs/nfs4_fs.h   |  11 ++-
> > > > >  fs/nfs/nfs4proc.c  | 204 ++++++++++++++++++++++++++++++-------
> > > > > ----
> > > > > ----
> > > > >  fs/nfs/nfs4state.c |  16 ----
> > > > >  fs/nfs/pnfs.c      |  71 ++++++++++++++--
> > > > >  fs/nfs/pnfs.h      |  17 +++-
> > > > >  5 files changed, 229 insertions(+), 90 deletions(-)
> > > > >
> > > > > --
> > > > > 2.21.0
> > > > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
> Trond Myklebust
> CTO, Hammerspace Inc
> 4300 El Camino Real, Suite 105
> Los Altos, CA 94022
> www.hammer.space
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
