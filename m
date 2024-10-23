Return-Path: <linux-nfs+bounces-7373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B129ABACD
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 03:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CF4B21C50
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 01:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFD01BC58;
	Wed, 23 Oct 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaxKYCtg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F9118E1F
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729645210; cv=none; b=Xiqz0GH2pLuq4AJt8iB1gXt1yAe6FF2IPE2EGUmeRyXREWrGQ4vL5v61XeQDmVe3gl6WiLTUWTLOmnNxowlQRgfXbuXGkC31fgXoMeLZt6mlFZxMTZRK//jOLgNhOX1lOYBtf0ULRphB2Tg8vZ0ZHvgACTbomzTk9tqCpehWdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729645210; c=relaxed/simple;
	bh=UQrIxdQam8zQk9KsE6uj69AqPPV/3EsyQWnCG9OvGlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OG9ruLbTC7QFJm3NID3QmL2Jeo0dgACdO6pZ2kFaz9lZKsHMYa/dlu97EwQnx4gwIIAFSXTgvDQbhBgbtuwcIhSHSx02njXKitmCXExHI0AzdGyIAO+uZfu7YH/XMcXVTXlNA95vEiXNfyC7npof5Gubx5RAogmll1+fbcvWozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaxKYCtg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so7299632a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729645207; x=1730250007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JGfl6bAUADVO0WJ2bKGxiSxByn+FjDjfdrz1Xvbqss=;
        b=TaxKYCtgqjbscBuP71EBWu80oecYcw+9ZiaGfJ3ge+yZr05W1H7DUbRNZk0MAJ2PW2
         Rs+QuFCQ3XqT8Vp/xttwnioo/6gZgEhYsD+hyECgwpQjiy0OlH42ia7komJtYG0XH33V
         jNQtRnRSCUo87w8FZKUkJHd0lQTk5N9l3lp7GMk7LM3KcYa95iqTp47Q7/5uWp80hkz8
         Ln4EWJipxjq1hdd08tjbgDrH+vWfeBK2WPqpKI1uvzuwuDnIiYx06bStMDdQ8ZqoYm7/
         HLENtvJcbRd5MqjQiP/5manqfOwVR7OwAJdNGkKHFewGm+JpXsk+kMkF/0KY+nB6sxLj
         Ofig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729645207; x=1730250007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JGfl6bAUADVO0WJ2bKGxiSxByn+FjDjfdrz1Xvbqss=;
        b=X/klKjv9GJqXidGiGo0xCT6AD5Ws5/yU5Ble+GVFRRTGi+PldJFw44TmjqTt2QGxyU
         VlOoztKSCseVA4PMXKMxWAFRRQ0A9LquzcCtDTpQnipY9ouCHmDBFDLTdRRjjZrL+ydc
         SlkMat4E/5Ml9+4CD928B+xkGlrd6baJ/bwBTqgNblaNaOIxRIKli/bDe1/poSt6PSLF
         teRlSYfuQjrGLiieqdhOvSnF+0DUsOq6cvl2Pzlv3pfQlVVoOMKkrBIrZRwxCXon1/rQ
         5YjRlSe6P6KBo4DK5CEvvIGTxtfI9EpoBbtBBsOkpZNhskKjhSW1kz0ydofCiF0CQ0CK
         /JuQ==
X-Gm-Message-State: AOJu0YwGEtyiLWUR017xwM2o+vNH6tLLxBGeYkCJFioNR0dOznuVRde1
	uGN/doUxtQ94HJuOCGgYybSayw68wsz4IvpF/3kCKGPAYaHqC/jeiSdblBgmzfQmMvO+E5Y43cJ
	mP9GMrA9yha6NVjltG2u68XdvDcCUhGk=
X-Google-Smtp-Source: AGHT+IFYbn5lzKduc4+cjxf2hKcCB8nMQNbzQU/dEmHgl7t2abw0Hh6EbKZ+3AiOT/GO5iOzs8GvHty/BfYrYDpUETo=
X-Received: by 2002:a05:6402:2546:b0:5c8:9548:f28b with SMTP id
 4fb4d7f45d1cf-5cb8af90fdemr614367a12.11.1729645206983; Tue, 22 Oct 2024
 18:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4S0O28CcDGV43BWXegSZSPVEYgFKpaLxLSNSgjti_L5Q@mail.gmail.com>
 <0A2D2441-712D-4EE5-BFDB-E77108BB1A1F@oracle.com> <CAM5tNy4jsSeAWQX43K9+6n=byvuGJF0o4enySTmdY-j=Y8BvvQ@mail.gmail.com>
 <DD0FDD16-B48A-40BA-B231-C6139DCCD130@oracle.com> <CAM5tNy6YEs9qOPvNRgE6A7c1VjCs4yEK84MUn4Cp2OSk-HE-Bg@mail.gmail.com>
In-Reply-To: <CAM5tNy6YEs9qOPvNRgE6A7c1VjCs4yEK84MUn4Cp2OSk-HE-Bg@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 22 Oct 2024 17:59:54 -0700
Message-ID: <CAM5tNy6zYia7zOve3=1LsrxSXTLEPhdbyzzCd8HQpV+kjjFkxA@mail.gmail.com>
Subject: Re: RFC: Dealing with large POSIX draft ACLs for NFSv4.2
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 8:03=E2=80=AFAM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Tue, Oct 22, 2024 at 5:28=E2=80=AFAM Chuck Lever III <chuck.lever@orac=
le.com> wrote:
> >
> >
> >
> > > On Oct 21, 2024, at 6:33=E2=80=AFPM, Rick Macklem <rick.macklem@gmail=
.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 7:45=E2=80=AFAM Chuck Lever III <chuck.lever@=
oracle.com> wrote:
> > >>
> > >>
> > >>
> > >>> On Oct 20, 2024, at 7:09=E2=80=AFPM, Rick Macklem <rick.macklem@gma=
il.com> wrote:
> > >>>
> > >>> Hi,
> > >>>
> > >>> As some of you will already know, I have been working on patches
> > >>> that add support for POSIX draft ACLs to NFSv4.2.
> > >>> The internet draft can be found here, if you are interested.
> > >>> https://datatracker.ietf.org/doc/draft-rmacklem-nfsv4-posix-acls/
> > >>>
> > >>> The patches now basically work, but handling of large POSIX
> > >>> draft ACLs for the server side is not done yet.
> > >>>
> > >>> A POSIX draft ACL can have 1024 aces and since a "who" field
> > >>> can be 128 bytes, a POSIX draft ACL can end up being about 140Kbyte=
s
> > >>> of XDR. Do both the default and access ACLs for a directory and it
> > >>> could be 280Kbytes. (Of course, they usually end up much smaller.)
> > >>>
> > >>> For the client side, to handle large ACLs for SETATTR (which never
> > >>> sets other attributes in the same SETATTR), I came up with some
> > >>> simple functions (called nfs_xdr_putpage_bytes(), nfs_xdr_putpage_w=
ord()
> > >>> and nfs_xdr_putpage_cleanup() in the current client.patch) which
> > >>> fill the large ACL into pages. Then xdr_write_pages() is called to
> > >>> put them in the xdr stream.
> > >>> --> Whether this is the right approach is a good question, but at
> > >>>     least it seems to work.
> > >>>
> > >>> For the server, the problem is more difficult, since a GETATTR repl=
y
> > >>> might include encodings of other attributes. (At this time, the pro=
posed
> > >>> POSIX draft ACL attributes are at the end, since they have the high=
est
> > >>> attribute #s, but that will not last long.)
> > >>>
> > >>> The same technique as for the client could be used, but only if the=
re
> > >>> are no attributes that come after the POSIX draft ACL ones in the X=
DR
> > >>> for GETATTR's reply.
> > >>>
> > >>> This brings me to one question...
> > >>> - What do others think w.r.t. restricting the POSIX draft ACLs to o=
nly
> > >>> GETATTR (and not a READDIR reply) and only with a limited set
> > >>> of other attributes, which will all be lower #s, so they come befor=
e
> > >>> POSIX draft ACL ones?
> > >>> --> Since it is only a personal draft at this time, this requiremen=
t
> > >>>       could easily be added and may make sense to limit the size
> > >>>        of most GETATTRs.
> > >>> This restriction should be ok for both the LInux and FreeBSD client=
s,
> > >>> since they only ask for acl attributes when a getfacl(1) command is
> > >>> done and do not need a lot of other attributes for the GETATTR.
> > >>
> > >> Generally, I don't immediately see why POSIX ACLs need a restriction
> > >> that the protocol doesn't already have for NFSv4 ACLs.
> > >>
> > >>
> > >>> Alternately, there needs to be a way to build 280Kbytes or more
> > >>> of XDR for an arbitrary GETATTR/READDIR reply.
> > >>
> > >> IIUC, NFSD already handles this for both READDIR and NFSv4 ACLs
> > >> (and perhaps also GETXATTR / LISTXATTR).
> > >>
> > >> So I'll have to have a look at your specific implementation,
> > >> maybe sometime this week. I can't think of a reason that our
> > >> current XDR and NFSD implementation wouldn't handle this, but
> > >> haven't thought deeply about it.
> > >>
> > >> It might not be efficient for large ACLs, but does it need
> > >> to be?
> > > Nope, it doesn't need to be...
> > > Well, this in embarrassing (blush!).
> > > It turns out it works fine for GETATTR of a large ACL (either the
> > > acl attribute or the new ones added by the patch).
> > >
> > > For the client side, I could have sworn I needed to do the
> > > "fill in the page stuff" to get the large one to work for SETATTR,
> > > but for the knfsd, it figures it out.
I tested this further and it does seem to be this way.
For SETATTR done by the client, the xdr_stream_encode_XXX()
functions fail for large ACLs. As such, something needs to be done.
Right now, the client code fills the ACL into pages and then does a
xdr_write_pages() for the large ones.
--> Does anyone know of a better way than filling in pages and then
      doing xdr_write_pages()?

For GETATTR done by the server, it handles large ACLs fine.
(It also allocates a scratch buffer, so the patch I wrote didn't need
to do so.)

rick

> > >
> > > Btw, I was only able to get to about 60K, because the ext4 fs
> > > I have on the server wouldn't allow an ACL with 1000 entries to
> > > be set (replied with out of space on device).
> > > --> I did get one with 455 entries to work and most of those entries
> > >      were for 110 byte group names.
> >
> > IIRC the Linux file systems have a 64KB length limit on extended
> > attributes, where ACLs are stored.
> >
> > ENOSPC is a little strange.
> Well, when I did this, it had nothing to do with NFS. (I did the setfacl
> locally on the server.)
> I will try a test doing the same setfacl over NFSv4 sometime to-day
> to see what happens.
>
> The good news is that the "hard problem" I thought existed doesn't
> exist. I will try the client without the "use pages code" and see if
> the client really needs the change or not.
>
> If you are interested in trying it, I left two files "groups" and "bigacl=
"
> on the nfsv4-newlap server. All you do is put "groups" in your group
> database and then "setfacl -M bigacl <file>".
> (Oh, and I usually "echo N > /sys/module/nfsd/parameters/nfs4_disable_idm=
apping"
> so it uses names instead of #s for the groups, but you can try both ways.=
)
> --> I think the ENOSPC failure occurs either way.
>
> Anyhow, thanks for pointing out that big acls already worked
> and sorry for the noise, rick
>
> >
> >
> > > So, what can I say, except I should have tried it before I posted.
> > > (One gotcha is that FreeBSD only handles 32 ACE ACLs, but
> > > when you look at the packet trace, you can see they are all in
> > > the GETATTR reply. Not an excuse, but...)
> > >
> > > Thanks for the reply Chuck, rick
> > >
> > >>
> > >>
> > >>> Btw, I have not tested to see what happens if a large POSIX draft
> > >>> ACL is set for a file (locally on the server, for example) and then
> > >>> a client does a GETATTR of the acl attribute (which replies with
> > >>> a NFSv4 ACL created by mapping from the POSIX draft ACL).
> > >>> --> I have a hunch it will fail, but I need to test to be sure?
> > >>>
> > >>> Thanks in advance for any comments w.r.t. this issue, rick
> > >>> ps; In particular, I'd like to know what others think about adding
> > >>>     the restriction on acquisition of the POSIX draft ACLs by GETAT=
TR.
> > >>
> > >>
> > >>
> > >>
> > >> --
> > >> Chuck Lever
> >
> >
> > --
> > Chuck Lever
> >
> >

