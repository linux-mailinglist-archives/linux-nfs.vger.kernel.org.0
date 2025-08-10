Return-Path: <linux-nfs+bounces-13542-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B6B1FABE
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E70175C37
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0AE2309BE;
	Sun, 10 Aug 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTNb3qXf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B4FC0B
	for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754839656; cv=none; b=EzjtyvDXmDOL0wxd6ABciyK1p1nuICofVYM1kjBfM7WbCq1OuuHCzTt2nQvzvMnQ+4QwDEKjeumHXrLI9oU5euO/SsD3udR2V95plAltEjQFtVyLhOb+Y985u9Kh1dvy3ieXyGOKY3fzUFM2eYFpR44oQ4Rpe0BUAsxlbCyQkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754839656; c=relaxed/simple;
	bh=f+dX/pk3dgI4/UwvtGtp7BQzWQnCO3fwWker2yfcDfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lg9o4zj7FeJ5rOptvHhWvm67eMmJW9k+RH8HqBXtB3lNV/UoZ8ONdFmIUMKF5hEqAtJdU5Ib8090CDT75JU1WKcbrWOWK+cJlbybvmWNUGYVB9FmfzEzzk2BZGkK+jSdgaRMytwxR1Ey+cmYtAw4xsBLgqDBLmGpkzR8sJLoDUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTNb3qXf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so8060273a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754839653; x=1755444453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzZ7qgOYCff0kIoQMKbl6KQyePygRLzaSMwsVqP8KgQ=;
        b=FTNb3qXfy/jwVx5ilSAlcqc9bEVfcFI6Ze0BPqi6prhIX8+xe8OacPEbENl1zhgRSV
         m6kEfcTq0A8rnhT0pZn7hi41iKl2O0YRUavQmcIrkIcc3QrP5MNIzzn20bzD7hKY9WOJ
         8l87OhCUNVAVQIzY7RnZG8loblApZPXa5LboXvNz1MIika2ql0t67R5QglIrF2x/MzrI
         0u+eIJTmFRT8mgbbilMtbM2cFtH6gS8skOPvYUs8GUozg4v3deh3XafV7qezTvMV8nE9
         7wNpXSsYsObm1rP476vCnW6vU4LhNqVpBd15/PUnahYPkTsZT8SFSFBBs41YH/7wkkKl
         CIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754839653; x=1755444453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzZ7qgOYCff0kIoQMKbl6KQyePygRLzaSMwsVqP8KgQ=;
        b=GnriEhxbxX23i+ivx8yD4h+yTfOiQQ6Y4Kdd6Rux2Seqe1xxMYh+UfuarV5T92Ayqr
         danwBmpcJw7dsG4Q8mK97JMcv6x4Ir5EEdzimqt0hzK5JS7D8lojlp+6SNwCGGT1pviL
         08qtckFSw7muVKYyr7fgfNPr8QNslSviY7/NZIoskbZXXYAsfugtroq03GxkrWPyjQwR
         go3TKy9/RbokSPi7AsjNOB5OK2H2/0Qr477hHYB1UwmeEfXiSyAzuX2BihgYR/1aACzl
         kglBhNK3LbBQvsi37tyCLmXam/vph5yInTR5O7AU+42i2zSeX5fdP7aLQKlCSEDTzVlq
         Bn/g==
X-Forwarded-Encrypted: i=1; AJvYcCX2v1oqoasqE1GTsfeLPpnhA6xo0Mk2N1evfP109NWkcTxJWGejZZc90pMTnkuuaXE8hwGR/9R0DKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzluqTaFPUyJiQoE7ffmUkOf+7tu4/onb/43CT9X5JDj4bYKtIY
	v0ISs1nh3J/glZuW9fw6FAk03VVJgu4n6hvaL2YBvuXt934q7lKvGHqWwpKY48d64ZcszHeLIM/
	zZcD/xIQCkYLQnOGnMTyXnJNzzHeXMw==
X-Gm-Gg: ASbGncvz5cOJJSreRkFLV083Wwlqi/NaN77QX8pfOl6Txd1I5Ad5jVCnJd7wSsYw+7B
	sz30LHwEzj5AzyMw7xl3YqkN9BZgzpyAV8coOl6Gvdp3YthVUgnbxSibcDzes5ZLgTJBubMBysr
	/iyIOoSDCj2d01p9FE+7EF9EjnfDYOTXjFxYgF6V/0R/UKnFuvJuKcGSzN5fXdsb9aSOWlYU6pQ
	CNcsjRZK6o6ADlendZzzYCszzDKIul/k1JR2GY=
X-Google-Smtp-Source: AGHT+IEDTOrk9fD8MuHXF57TKo/zm0zLtEPW+whTpv3BKby2JaaoIdQLtgPrKoWaYYQjwcdknUcjjun2qNvdtUaTp2c=
X-Received: by 2002:a17:907:97c4:b0:af9:70f0:62e3 with SMTP id
 a640c23a62f3a-af9a3e3fddemr1467684266b.15.1754839653022; Sun, 10 Aug 2025
 08:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4L1Smwc-H01AuKjNbtu9WMzWxJVRtuOjr0Fp_yLiZX7Q@mail.gmail.com>
 <CAABAsM5nzVzPDB3Ubeqg35F7Qd8pBveiYPi1M+KFnMPjb2dxXw@mail.gmail.com>
 <CAM5tNy7Aab8fQ58BghMBsWvs6Xc5U90q9gXWaKeEaZaqcs2Ltw@mail.gmail.com>
 <CADaq8jeAhdOLrD9Y6o1xJsMuGYZLoJdMAonfB5RuX63xV_i0UA@mail.gmail.com>
 <CAM5tNy4kPWfPHHRVr712AG=g5wJ+fThG9KFX_9JoT85seTSE=g@mail.gmail.com>
 <CADaq8jdfV0EjVehzGNFw2MxKZvc_Dj-t6Af0NqNKe3oZ66xDMQ@mail.gmail.com>
 <CAM5tNy4jx3ML_XhWaAo=Ffde3ZzqR5mGd-kcVvpAtxXjesChJA@mail.gmail.com> <CAM5tNy6GZWSYWftqexCk2Q0qTsiz0Aq2pn0HxG=h-POPFoQAoQ@mail.gmail.com>
In-Reply-To: <CAM5tNy6GZWSYWftqexCk2Q0qTsiz0Aq2pn0HxG=h-POPFoQAoQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 10 Aug 2025 08:27:19 -0700
X-Gm-Features: Ac12FXy6qxGz2rXdm2tD56bPwlu_LFhN6LhDcRMwmxoj_yR_8qNPhXKEZFPNVdY
Message-ID: <CAM5tNy7DxmejQgwJJSAyvVEuOXYsbHmGCKu+6DYm68iuULNe+A@mail.gmail.com>
Subject: Re: [nfsv4] Is NFSv4.2's clone_blksize per-file or per-file-system?
To: David Noveck <davenoveck@gmail.com>
Cc: Trond Myklebust <trondmy@gmail.com>, NFSv4 <nfsv4@ietf.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 7:52=E2=80=AFAM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Sun, Aug 10, 2025 at 7:32=E2=80=AFAM Rick Macklem <rick.macklem@gmail.=
com> wrote:
> >
> > On Sun, Aug 10, 2025 at 6:58=E2=80=AFAM David Noveck <davenoveck@gmail.=
com> wrote:
> > >
> > >
> > >
> > > On Sat, Aug 9, 2025 at 5:02=E2=80=AFPM Rick Macklem <rick.macklem@gma=
il.com> wrote:
> > >>
> > >> On Sat, Aug 9, 2025 at 1:12=E2=80=AFPM David Noveck <davenoveck@gmai=
l.com> wrote:
> > >> >
> > >> >
> > >> >
> > >> > On Friday, August 8, 2025, Rick Macklem <rick.macklem@gmail.com> w=
rote:
> > >> >>
> > >> >> On Fri, Aug 8, 2025 at 8:38=E2=80=AFPM Trond Myklebust <trondmy@g=
mail.com> wrote:
> > >> >> >
> > >> >> >
> > >> >> >
> > >> >> > On Fri, Aug 8, 2025 at 9:47=E2=80=AFPM Rick Macklem <rick.mackl=
em@gmail.com> wrote:
> > >> >> >>
> > >> >> >> Hi,
> > >> >> >>
> > >> >> >> I'm looking at RFC7862 and I cannot find where it
> > >> >> >> states if the clone_blksize attribute is per-file or
> > >> >> >> per-file-system.
> > >> >> >>
> > >> >> >> If it is not in the RFC, which do others think it is?
> > >> >
> > >> >
> > >> >  Before you told us about ZFS,  I would have assumed per-fs.
> > >> >
> > >> > Given the uncertainty in the spec, you may wind up dealing clients=
 that assume it is per-fs.
> > >> >
> > >> > Although this is not a  catastrophe, you might want to file an err=
ata report explaining the negative consequences of assuming this is per-fs.=
 It won't get into a spec for a long while but it does provide as much warn=
ing as you can right now .
> > >> >
> > >> >
> > >> >
> > >> >>
> > >> >> >> (Or maybe, if you have implemented CLONE,
> > >> >> >> which does your implementation assume?)
> > >> >> >>
> > >> >> >> In case you are wondering why I am asking,
> > >> >> >> it turns out that files in a ZFS volume can have
> > >> >> >> different block sizes. (It can be changed after the
> > >> >> >> file system is created.)
> > >> >
> > >> >
> > >> > The guy who allowed that probably thinks it's a helpful feature.  =
Sigh!
> > >> It's not just a feature change after creation, it turns out to be ba=
sed
> > >> on file size as well.  A small file gets 512 and a larger one gets a=
 full record
> > >> (128K on my test system).
> > >>
> > >> And, yes, block cloning requires alignment with 512bytes or 128Kbyte=
s
> > >> depending on the file.
> > >>
> > >> I can return 128K for clone_blksize and that will (sub-optimally) ha=
ndle
> > >> the 512byte case, but I think it is also possible to increase the re=
cord
> > >> size from 128K-> after the file system has files in it.
> > >>
> > >> I'll take a look at the Linux client to try and see if/how it uses
> > >> clone_blksize.  I need to decide if I should always return 128K
> > >> (or whatever the full recordsize is) or 512 for the small files.
> > >
> > >
> > > I don't see the point of returning anything but 128K given what you s=
aid above.
> > > If a file has to be smaller than 512 to merit the 512 block size, it =
could still be cloned with a 128k clone_block_size.  The spec makes an exce=
ption for the last block of a file being shorter than the block size so ret=
urning a 512-byte clone_block_size.
> > I'll be experimenting with it soon.
> > What I do not know (you could write what I know about ZFS on a
> > postage stamp;-) is whether the blksize for a file changes as it
> > grows.
> > --> So the problem is a file might get 512 because it is small when
> >      first created and then grow large. Again, I do not currently know
> >      what determines the blksize. Whether it is the first write being l=
ess
> >      than a record size when created or maybe it does switch to records=
ize
> >      (128K in my case) when it grows beyond 128K or ???
> >      - I do know that ZFS allocates new blocks whenever data is written
> >        to a file, even if the file is not growing. (Which is why it can=
not
> >        support ALLOCATE at this time and probably never will.)
> >
> > I'll be poking at it. For now, I just do not know, rick
> I should have done a scan before posting.
> I just ran a little program that printed out the blksize of every
> regular file in a ZFS file system.
> It turns out that the blksize is any exact multiple of 512 up to
> 128K (the record size for the volume).
> Since most are C sources or objects, most are less than 128K.
>
> If I return 128K, then most files would not be CLONEable unless
> the CLONE is for the entire file.
It appears that your suggestion of 128K is correct for ZFS.
I am still not sure, but it appears that, for files up to 128K,
the files are a single block (which is any multiple of 512).
--> As such, only the entire small file can be cloned.

So, returning 128K for all files in the file system seems like
it will be the correct choice.

It still leaves the per-filesystem vs per-server question
since (if I read it correctly) the Linux client uses clone_blksize
per-server (and not per-server file system).

I do not think per-server is the correct choice, since different
file systems on a server could have different block sizes.

rick

> Of course, I do not currently know how clients actually use
> clone_blksize either. (Do they check alignment using it before
> doing a CLONE or ???)
>
> I'll be playing around with CLONE for both FreeBSD and Linux
> in the coming days.
> I'll post if/when I have useful info, rick
>
> >
> >
> > >>
> > >>
> > >> Thanks for the comments, rick
> > >>
> > >> >
> > >> >> >>
> > >> >
> > >> >
> > >> >>
> > >> >> >> Thanks, rick
> > >> >> >>
> > >> >> >
> > >> >> > Yes, but since ZFS only supports filesystem level snapshots, an=
d not actual file cloning, does that matter to anything?
> > >> >> ZFS now has a feature it calls block cloning, which does clone fi=
le ranges.
> > >> >> (It was only added recently. I do not know if the Linux port uses=
 it yet?)
> > >> >>
> > >> >> rick
> > >> >>
> > >> >> >
> > >> >> > Cheers
> > >> >> >   Trond
> > >> >>
> > >> >> _______________________________________________
> > >> >> nfsv4 mailing list -- nfsv4@ietf.org
> > >> >> To unsubscribe send an email to nfsv4-leave@ietf.org

