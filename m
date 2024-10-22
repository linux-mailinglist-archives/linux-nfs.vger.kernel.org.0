Return-Path: <linux-nfs+bounces-7362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811549AB19B
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 17:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7B3B21278
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650151A0AF2;
	Tue, 22 Oct 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll67hQw/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B985C5E
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609441; cv=none; b=c62rHCfcv1e5/QeD+1p3aRlkQOxTXmGgsjwx7N5rLp73n65AhkxwjdeRFabhRuY84iJQ4zgAKCUBd8lT3kqTVR+5Rpnrkgz5xVmdeHn1ulreXIJ/MwqeWRYgF+EnwZmPa+LabrKxM0dgpxzSeGpRsw0W3dRWrsniuekYVvnp4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609441; c=relaxed/simple;
	bh=gjNf2XRWzRa8byTPrOjJkMdXhxplpSBH8d50Pt/ZlGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuAUu2EaUWlrwJ4XFIW8DoFItXNrLQAas0kx401uqAh7yqjxTWaP611Vzy7eB6ipOBTftdaLZ/5e3mfXbYhuSRMjv/eG6pgrXYRRyODyuZcKDed8wjnyiB3SplzKxNGfbTOdj65OSP8OXFuoBgOjIzDHLofMRZi9zxC+IiHo5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll67hQw/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso2455101a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729609438; x=1730214238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgnp8t5btTOm3DzEXyljMRpZGDxCiLmTYSEDvjHlaBs=;
        b=ll67hQw/8uu6OQxUrkmLyS4RH8LKa23RzwqSLXjyCmQ+Gp+KrtUVAszOiZPb+kS20L
         MiP3k3aa9xlqyk7QCzqXoDs/TmLyB63IOb/fIJzvRHthlQ2aUSLfvZVpHOzpNoCi84s6
         Dkwu65X/BEVaYJpHonvy+UdIf1wVJwTeBpiG0SqMNy/GTqPe8bE4lBB0v/CLMGnOouFM
         5VG7rpHlsYDMNfiA8CUup9Y5kjDl8TaCgSfG+OvPS7mhGFCu6plPV4LGmcr4IFzpNpQU
         GHg1G0SPNnUgyhhhX0g6gLMSrvkn4h9hMqcPTa5azv3+nCF311G+H159C5N2G6mWg/yD
         Y29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609438; x=1730214238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dgnp8t5btTOm3DzEXyljMRpZGDxCiLmTYSEDvjHlaBs=;
        b=rPxiGBumBPGmtdtL/EKhHBrwx8E5cuLlUoUQ5omA7+ebtJz8VstR8fPp3ItYydBuZB
         iSi6ZHT/jfRo/7Fp0hcknqe0efEo00Cn5bOHeoqTY11uJyqosRJ6XDHiIWMW6BzecTec
         G5fKXtaGA/10KfQFeQGjkxW7k999lfz4z0a1iN/cahH+SeV9fyN6klZx2qfzlxsQppfR
         TMQXqDJt12WDtL7WOvNPtwAi2iRIS9/6B+oZtOwAQHWsbRSTEdVIi1BCFv7YsrRhGC3s
         SR2yAyo00kZg/zhtw4SCtRylQ/TuchoRZk+QRazNNIAl+LB030+MEO8diHy0hStlHnjy
         OXyQ==
X-Gm-Message-State: AOJu0YwXI5mhzsu89KF2Zn0H5k4As0idaACXy8iK06ORyN1QAKKZ224F
	ceQO7GQt8tfMbnSlzTPW+UFFL99fUUNrRbBOkXoQ6CZ2ghmKiM+q0R6EUY/G8BgC5Q2Xge9UIj7
	3jZHWHbizF6YZzurRZHWPelKPvqUynoY=
X-Google-Smtp-Source: AGHT+IGggCsSiv8bfk3Eh5KMaesk4ZUY39nW4CsFuoUoS4QuVs6N8TbFKrzUubFI+CmiywJmzDy60F71GnCENjiUnk4=
X-Received: by 2002:a05:6402:2551:b0:5c9:5a96:2869 with SMTP id
 4fb4d7f45d1cf-5cb7fcdbfaamr2798474a12.10.1729609437611; Tue, 22 Oct 2024
 08:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4S0O28CcDGV43BWXegSZSPVEYgFKpaLxLSNSgjti_L5Q@mail.gmail.com>
 <0A2D2441-712D-4EE5-BFDB-E77108BB1A1F@oracle.com> <CAM5tNy4jsSeAWQX43K9+6n=byvuGJF0o4enySTmdY-j=Y8BvvQ@mail.gmail.com>
 <DD0FDD16-B48A-40BA-B231-C6139DCCD130@oracle.com>
In-Reply-To: <DD0FDD16-B48A-40BA-B231-C6139DCCD130@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 22 Oct 2024 08:03:46 -0700
Message-ID: <CAM5tNy6YEs9qOPvNRgE6A7c1VjCs4yEK84MUn4Cp2OSk-HE-Bg@mail.gmail.com>
Subject: Re: RFC: Dealing with large POSIX draft ACLs for NFSv4.2
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:28=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Oct 21, 2024, at 6:33=E2=80=AFPM, Rick Macklem <rick.macklem@gmail.c=
om> wrote:
> >
> > On Mon, Oct 21, 2024 at 7:45=E2=80=AFAM Chuck Lever III <chuck.lever@or=
acle.com> wrote:
> >>
> >>
> >>
> >>> On Oct 20, 2024, at 7:09=E2=80=AFPM, Rick Macklem <rick.macklem@gmail=
.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> As some of you will already know, I have been working on patches
> >>> that add support for POSIX draft ACLs to NFSv4.2.
> >>> The internet draft can be found here, if you are interested.
> >>> https://datatracker.ietf.org/doc/draft-rmacklem-nfsv4-posix-acls/
> >>>
> >>> The patches now basically work, but handling of large POSIX
> >>> draft ACLs for the server side is not done yet.
> >>>
> >>> A POSIX draft ACL can have 1024 aces and since a "who" field
> >>> can be 128 bytes, a POSIX draft ACL can end up being about 140Kbytes
> >>> of XDR. Do both the default and access ACLs for a directory and it
> >>> could be 280Kbytes. (Of course, they usually end up much smaller.)
> >>>
> >>> For the client side, to handle large ACLs for SETATTR (which never
> >>> sets other attributes in the same SETATTR), I came up with some
> >>> simple functions (called nfs_xdr_putpage_bytes(), nfs_xdr_putpage_wor=
d()
> >>> and nfs_xdr_putpage_cleanup() in the current client.patch) which
> >>> fill the large ACL into pages. Then xdr_write_pages() is called to
> >>> put them in the xdr stream.
> >>> --> Whether this is the right approach is a good question, but at
> >>>     least it seems to work.
> >>>
> >>> For the server, the problem is more difficult, since a GETATTR reply
> >>> might include encodings of other attributes. (At this time, the propo=
sed
> >>> POSIX draft ACL attributes are at the end, since they have the highes=
t
> >>> attribute #s, but that will not last long.)
> >>>
> >>> The same technique as for the client could be used, but only if there
> >>> are no attributes that come after the POSIX draft ACL ones in the XDR
> >>> for GETATTR's reply.
> >>>
> >>> This brings me to one question...
> >>> - What do others think w.r.t. restricting the POSIX draft ACLs to onl=
y
> >>> GETATTR (and not a READDIR reply) and only with a limited set
> >>> of other attributes, which will all be lower #s, so they come before
> >>> POSIX draft ACL ones?
> >>> --> Since it is only a personal draft at this time, this requirement
> >>>       could easily be added and may make sense to limit the size
> >>>        of most GETATTRs.
> >>> This restriction should be ok for both the LInux and FreeBSD clients,
> >>> since they only ask for acl attributes when a getfacl(1) command is
> >>> done and do not need a lot of other attributes for the GETATTR.
> >>
> >> Generally, I don't immediately see why POSIX ACLs need a restriction
> >> that the protocol doesn't already have for NFSv4 ACLs.
> >>
> >>
> >>> Alternately, there needs to be a way to build 280Kbytes or more
> >>> of XDR for an arbitrary GETATTR/READDIR reply.
> >>
> >> IIUC, NFSD already handles this for both READDIR and NFSv4 ACLs
> >> (and perhaps also GETXATTR / LISTXATTR).
> >>
> >> So I'll have to have a look at your specific implementation,
> >> maybe sometime this week. I can't think of a reason that our
> >> current XDR and NFSD implementation wouldn't handle this, but
> >> haven't thought deeply about it.
> >>
> >> It might not be efficient for large ACLs, but does it need
> >> to be?
> > Nope, it doesn't need to be...
> > Well, this in embarrassing (blush!).
> > It turns out it works fine for GETATTR of a large ACL (either the
> > acl attribute or the new ones added by the patch).
> >
> > For the client side, I could have sworn I needed to do the
> > "fill in the page stuff" to get the large one to work for SETATTR,
> > but for the knfsd, it figures it out.
> >
> > Btw, I was only able to get to about 60K, because the ext4 fs
> > I have on the server wouldn't allow an ACL with 1000 entries to
> > be set (replied with out of space on device).
> > --> I did get one with 455 entries to work and most of those entries
> >      were for 110 byte group names.
>
> IIRC the Linux file systems have a 64KB length limit on extended
> attributes, where ACLs are stored.
>
> ENOSPC is a little strange.
Well, when I did this, it had nothing to do with NFS. (I did the setfacl
locally on the server.)
I will try a test doing the same setfacl over NFSv4 sometime to-day
to see what happens.

The good news is that the "hard problem" I thought existed doesn't
exist. I will try the client without the "use pages code" and see if
the client really needs the change or not.

If you are interested in trying it, I left two files "groups" and "bigacl"
on the nfsv4-newlap server. All you do is put "groups" in your group
database and then "setfacl -M bigacl <file>".
(Oh, and I usually "echo N > /sys/module/nfsd/parameters/nfs4_disable_idmap=
ping"
so it uses names instead of #s for the groups, but you can try both ways.)
--> I think the ENOSPC failure occurs either way.

Anyhow, thanks for pointing out that big acls already worked
and sorry for the noise, rick

>
>
> > So, what can I say, except I should have tried it before I posted.
> > (One gotcha is that FreeBSD only handles 32 ACE ACLs, but
> > when you look at the packet trace, you can see they are all in
> > the GETATTR reply. Not an excuse, but...)
> >
> > Thanks for the reply Chuck, rick
> >
> >>
> >>
> >>> Btw, I have not tested to see what happens if a large POSIX draft
> >>> ACL is set for a file (locally on the server, for example) and then
> >>> a client does a GETATTR of the acl attribute (which replies with
> >>> a NFSv4 ACL created by mapping from the POSIX draft ACL).
> >>> --> I have a hunch it will fail, but I need to test to be sure?
> >>>
> >>> Thanks in advance for any comments w.r.t. this issue, rick
> >>> ps; In particular, I'd like to know what others think about adding
> >>>     the restriction on acquisition of the POSIX draft ACLs by GETATTR=
.
> >>
> >>
> >>
> >>
> >> --
> >> Chuck Lever
>
>
> --
> Chuck Lever
>
>

