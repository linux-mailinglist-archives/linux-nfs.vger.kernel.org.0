Return-Path: <linux-nfs+bounces-7542-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CCE9B3B32
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 21:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761611C21D99
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55601D54D6;
	Mon, 28 Oct 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV2MY/4i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7418EFC9
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146640; cv=none; b=RGqnp3EK3n3eVetsBnMm7sE1iJO/mDdk0nRoGoJ4owgGtccPsZ9nlLFiqSrPuCgH0PwznHQdsCmthy4zdKnqAR/DvIPcQkxHnF+KPR/5KeHkR34e95Vov/pkguUyO/wnldk0iNNedoYTI3eGk2ofEiWWaChQxWHO9IWR9jf2WeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146640; c=relaxed/simple;
	bh=nNwApHikL7z8fq2AsfjvWjAh/YpJCxVxiV00SRge/Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1y+Zt3bDB+4+Ptx1BJUrUiCcYxRE40pBbTca0BYRse/xy0W8lbMJGjrMkZHs3PltvxyIU5eKyuNyjg9SDcgy98EgFAfzfjygkpx7YMWo5yTLnQv/f5gqOhD47gc5e7Ty+9m76bB9dppGi7kBtNW7U95VhjxzahkVeduVXjcikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV2MY/4i; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb3110b964so37460621fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730146636; x=1730751436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCKjKS9HkACpQS6+NoO5LQFJF6jrrayB7Ohe3gaARVg=;
        b=QV2MY/4icAPY0NSvexg1N6weWr0WOx/e64OT0DL5Y4YW6f1nM37YVSC7ji85huAELg
         CD82s22TlTQh9olqg80sK2+2/AdKgj1qw6T7JuFShMyUMLP5RMsjSGf1SJv9Tf2TCNLn
         9gF+Hwolq7MOCh2Al/G9mMdBAlTdXUq4PhPUqv0keMZtLeLuLH7lxzheLwoL2E2EW+Rb
         kXzqZW9oLR8IFoTGWt2Npwbf7YYn8L03sdqu4b0gplJzos3jv3zJkRnhCybfhOPPcLI1
         w/beigwsJ751e9JBc98mWMD5L6/T7b+SxlDNI0kbjHf9GK9aibiaZju11CqTfIg1KeT3
         zFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730146636; x=1730751436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCKjKS9HkACpQS6+NoO5LQFJF6jrrayB7Ohe3gaARVg=;
        b=YLzGzHRM9UMPkQ7VQPy2a2WmTAvdnLBocd95QI471egjBtjCvotnOw/OU0yQ/kX/hL
         d1sNtwYTkQioKagzjTbvvDlXgpfV8Voua8/dYHu0Nq2d9WK1LjscoZre6Lxq8zHOHoWF
         MD2pAOkNcAzXAYZr+ea3s3OE5IYM5D2Ec0kYSGNSuQa27L/lzTCjVnlTge1ELQkA05B+
         solCUzvLUhQCnNsgu6Q7GtGZKawD9obqGpNRYXECKcQfh80+0ManLkc2tE+BLNUyXtZK
         AhB0Oq3iGQq+0ymsapXRD8BcOZKPSP8oXMkO7k9gDxGatf4ICmR60PCkxHh95dNZAyOL
         vA0A==
X-Gm-Message-State: AOJu0YwMkqnd5/Id8/70CaO2DagSNxa0mDeoZ1mHaMXk0wtt015W/fm7
	oNQyjlRzcDJ2uBMJz4gaPzgnGF0V3YHCiSjkh8N71/VOOF9IsFp/eO2iPdBotHGBrmC9wokvlAn
	4+bM0iYgitzePz2y8JwODXuBG2P0TO1Y=
X-Google-Smtp-Source: AGHT+IGTN0AlI8zwZxnkQxGfWQYXUvW6BQK/xp0gvL7uzIQ3GAILZWlmJ9d8DkJtUY7wF9gLSnAJEgmgasMT9jBb1fM=
X-Received: by 2002:a2e:851:0:b0:2fa:dbf1:5b2d with SMTP id
 38308e7fff4ca-2fcbe0a911fmr30543291fa.39.1730146636098; Mon, 28 Oct 2024
 13:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4RY-vMZU5zP=-X4F9ahPYHbAAyLkWKBbJc01jB_LD2jA@mail.gmail.com>
 <FF23731E-7672-4933-8261-04EA2E6B488E@oracle.com>
In-Reply-To: <FF23731E-7672-4933-8261-04EA2E6B488E@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 28 Oct 2024 13:17:04 -0700
Message-ID: <CAM5tNy48nGKcQZ+-hegvweGVbrzKQGw444-gxe4zzx9S+UMmZA@mail.gmail.com>
Subject: Re: posting POSIX draft ACL patches
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 8:02=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Oct 25, 2024, at 6:47=E2=80=AFPM, Rick Macklem <rick.macklem@gmail.c=
om> wrote:
> >
> > So, I've finally figured out how to use git format-patch. It took
> > me a lot of tries before I discovered all you do is specify "master.."
> > to make it work. (I still haven't tried to email them via gmail, but
> > I've found the doc for that.)
> >
> > At this point, the patches are still in need of testing (I have yet to
> > test the nfsd case where file object creation specifies a POSIX draft
> > ACL, since neither FreeBSD nor Linux clients do that.)
> >
> > Is it time to post the patch sets for others to try or should I wait a =
while?
>
> My only hesitation is that the draft hasn't gone through WGLC
> yet. The probability of changes to the wire protocol decrease
> over time, but after WGLC, we can be pretty certain that
> the protocol is stable and won't get any further changes
> that might risk interoperability. The client folks might be
> OK with just a personal draft, which we have now.
>
> Maybe we should consider merging this work now and hide it
> behind a Kconfig option that defaults N. The risk there is
> that folks not directly involved might enable this anyway,
> and if the protocol changes, we'd be stuck having to support
> one or more pre-standard versions. Opening the floor for
> comments.
>
> For now, usually the developer can maintain a public git repo
> that contains their patches so that others can pull them for
> testing. You are free to continue posting new versions of
> the series (with a cover letter that contains a change log).
Ok. Reading between the lines, my interpretation of this is...
1) Don't post patches until they are ready to be considered
     for upstreaming.
     (I was really asking about patches for testing, but failed to
      mention that.)
2) If I put the patches somewhere others can "git pull", that
    is probably the best bet for patches for testing.

So, I just put the "common" part in a github repository forked
from linux-next.
https://github.com/rmacklem/linux.git
It has three branches (common, client and server), although I
have only populated "common" at this point.
(Btw, if someone is inspired to try a pull, just to see that it
works, that would be appreciated.)

I'm not a git guy, so maybe someone can explain how I can
move a bunch of patches from a local clone of linux-next to
the clone of the github one (so I can then push them to github).
- For common, I just did each patch by hand with a fresh commit,
  but there's enough of them in "client" and "server" that this
  will take a while.
  - Is there a better way via git?

Anyhow, once I get all them into github, I'll just leave them there
and try and coax others into trying them for the next testing event
(in the spring, maybe?).
I'll assume WGLC happens sometime between 6months->never,
so that should work out ok, I think?

>
> We probably want to see some unit testing (ie, pynfs) but
> that can be developed separately.
Yea, I know nothing about Python, so hopefully someone else
will be inspired to do this. I wonder what is out there for testing
the NFSv3 NFSACL protocol?

>
>
> > A couple of questions...
> > The patches currently have a lot of dprintk()s I used for testing.
> > Should those be removed before posting or left in for now?
>
> The usual policy on the server is that dprintk()s that were
> used for development but have no diagnostic value for users
> or administrators should be removed before merging. We also
> don't like to keep dprintk() call sites in hot paths.
Yea, I was really just asking w.r.t. test code. They are not indented,
so they are easy to remove at some point.

> Observability in hot paths is done with tracepoints, but
> if you don't want to add those, just leave a comment where
> you think each tracepoint might be best, and someone can add
> them later.
>
>
> > They are currently based on linux-6.11.0-rc6 (linux-next of a few
> > weeks ago). What do you guys do w.r.t. rebasing them?
>
> When these are ready to merge, the series should be based
> on nfsd-next (server side) or the -next branch for the
> client side (Trond and Anna take every other release, so
> ask which is preferred).
>
> Pull the base branch into your repo and use "git rebase".
I forked what was called linux-next in github, so hopefully that
should be it?

Thanks for the comments, rick

>
>
> > There are three sets: common, client and server (common is
> > needed by both the others.
>
> We'll have to decide how these will get merged, as I
> mentioned to you previously: Either one side goes first
> and pulls the common branch, then the other side
> merges later; or one side agrees to pull all three at
> once.
>
>
> > The other two sets implement client and server side for handling
> > the new attributes proposed in
> > https://datatracker.ietf.org/doc/draft-rmacklem-nfsv4-posix-acls/
> >
> > Thanks in advance for any help, rick
> > ps: The problem I thought I had w.r.t. server side large ACLs does
> >      not appear to be a problem. It also appears that the nfsd always
> >       sets up a scratch buffer, so the server code doesn't do that, eit=
her.
> >
>
> --
> Chuck Lever
>
>

