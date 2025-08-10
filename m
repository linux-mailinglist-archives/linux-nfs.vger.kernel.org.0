Return-Path: <linux-nfs+bounces-13541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B1B1FA9A
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0211893789
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4DB1EA7E1;
	Sun, 10 Aug 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC2r6pPZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1929CEB
	for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837541; cv=none; b=YOdsNqNDiM/ysSP6QZoG4yax2DX86twm+NrS8COnc0hBzlmrqMPqfAfQxJUwXi2tTlnftDanxP/6zfH8o6AlzZp7h2KJY/5fOKkXkG+A4tS8xXOuA+Euys5lESFRSrqSERde608n4d2yMTLLjneFUueIx192VdXf4/StTzoKyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837541; c=relaxed/simple;
	bh=Ra2UUboWnUO9uftf441rRgunX98gcSq9xtFi6BYSwEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhv9uY4SkvnkxFLVPINCz67AGYBb8BUn8uUX1bgskxTH6NmL3ayv1TAx3ekpEienTvxBWGCi9QyDNKKZsVH5YLeyyDNZAvbqsP46BAmqKC1FrCit5EoCCxablOL6fCY9EsXL5NNxRGtwdh4rYQOtS+M/lo5calkBOwjLGOxxeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC2r6pPZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso5789092a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754837538; x=1755442338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EbEBQBk6N9C1aKKjqV3tmJamvOcmCiIt++WC4RUxew=;
        b=iC2r6pPZMzGtJyCbb8R/Mf313QiF0IDqbbTfV2kKK17dD0NRmQ7NxrRZH0jgcsM08C
         kXK3E197+nFj4GHS+CIyklGItwVmtwNWeTyBKT/jdixu5UiErNUXbA4hIvDFCnh6w1RM
         YhzqRoY73tV5HuaaMow0ExPwipCPVaNFqF4K4AC18jCkhrXo96+hP4+eatbVhk9enwdo
         USO3p7LXKNujyHEOr/HOg6cHjqhD9ydafsNdHNEpJxkMy08O17YbF7mwUWtYAy6tKzUk
         7jy1ok+8GP8uYQT45MAbgEfU2aO8zFTBOASKG6c2SH1hTb1DIU4maC5a9d6IscaBpJxs
         fVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754837538; x=1755442338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EbEBQBk6N9C1aKKjqV3tmJamvOcmCiIt++WC4RUxew=;
        b=qSQu8mloXQ58Wk7xbzSx08zMVLQ32iLh4Y9o9T3fRQojQt8FlP8FtZguO2K6nvP9Qc
         m5ded/lGB4N3HWfPrPfZFa19dURtx4SzZjVfMYz+BW/ZdQfwg3pW0Ne3sPnb8Q4ewmLQ
         gEUDCQKhd6OFri2E7++Sj4yec/AGZ+1K51jOcTf4NQ08YeXIOo4WPnDUuBdkklI4tRbX
         eYtVJV3+zroJE5g3Y0y1+eKi8UG1VsPOExVNpXsl8/ozfbKtH0/Zd6dJpGhEgrLyNBgJ
         rnWFlEJoIQHpKbBDQfFQqLUti1hIhuzhqQTbTg8hHkJu6rCYCE/xvqUPQa5rl4IJLoCK
         gWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPzed0bM+XqRDMIcQyprUVqHxgqFMI46dqkvNuxOfVF/sN8QKWxsCdZNjGrZymtAiqUPcW3qUHPEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwzWCrxaXTiCoTbpPLOZRpGJojVgth4nyLvnLPdAdeReC16qm
	+useLVfPV1X/ejeqPO3favNxcQ6Ovyc8HTX5/StoMaK0PlYAhFkcvVQUAAg1ijNmGhQNOXyAplQ
	G4XYNmMdVfy6WmKnnJP1byppSTgGuxA==
X-Gm-Gg: ASbGnctMI5Br92jXgJnx+gZuDfaQM3NArNIYvgv6iEIFvnTs7kwuGxdDGlaEtuQCJak
	3nm9tzgdeONr3NFv9nza/EVJdSV+gnS+QdoyolIPQ7fnfj7zaKrIVD9F6F1SBxU7VAIJ3T4GJzl
	hH2Qvs1YhTTkjb47YUGxHlQcVMq9U/SeEpDfs78qf3MNJCnWrP6ULiLv7qrsIfat3o3OXNEVb6z
	gxXNJby4oqTjFyQXujkU+dCGxX5LXM+sPZIsPE=
X-Google-Smtp-Source: AGHT+IF/Txo/cHsu26IxtMafiOIcGdWekKGHKgGaAH9OocoYLtcdEKeQCAsidHuDFcCjEtzecyrfwQTMxY8kcS9GLYo=
X-Received: by 2002:a17:907:7ea9:b0:ae0:9fdf:25e8 with SMTP id
 a640c23a62f3a-af9c6545abcmr891707566b.47.1754837537782; Sun, 10 Aug 2025
 07:52:17 -0700 (PDT)
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
 <CADaq8jdfV0EjVehzGNFw2MxKZvc_Dj-t6Af0NqNKe3oZ66xDMQ@mail.gmail.com> <CAM5tNy4jx3ML_XhWaAo=Ffde3ZzqR5mGd-kcVvpAtxXjesChJA@mail.gmail.com>
In-Reply-To: <CAM5tNy4jx3ML_XhWaAo=Ffde3ZzqR5mGd-kcVvpAtxXjesChJA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 10 Aug 2025 07:52:05 -0700
X-Gm-Features: Ac12FXzdE3HnrQWKTjlVf-pDmiDvBNmlT_8xMLXqHh_JtT5-xyTOP8Q7M4LFZq8
Message-ID: <CAM5tNy6GZWSYWftqexCk2Q0qTsiz0Aq2pn0HxG=h-POPFoQAoQ@mail.gmail.com>
Subject: Re: [nfsv4] Is NFSv4.2's clone_blksize per-file or per-file-system?
To: David Noveck <davenoveck@gmail.com>
Cc: Trond Myklebust <trondmy@gmail.com>, NFSv4 <nfsv4@ietf.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 7:32=E2=80=AFAM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Sun, Aug 10, 2025 at 6:58=E2=80=AFAM David Noveck <davenoveck@gmail.co=
m> wrote:
> >
> >
> >
> > On Sat, Aug 9, 2025 at 5:02=E2=80=AFPM Rick Macklem <rick.macklem@gmail=
.com> wrote:
> >>
> >> On Sat, Aug 9, 2025 at 1:12=E2=80=AFPM David Noveck <davenoveck@gmail.=
com> wrote:
> >> >
> >> >
> >> >
> >> > On Friday, August 8, 2025, Rick Macklem <rick.macklem@gmail.com> wro=
te:
> >> >>
> >> >> On Fri, Aug 8, 2025 at 8:38=E2=80=AFPM Trond Myklebust <trondmy@gma=
il.com> wrote:
> >> >> >
> >> >> >
> >> >> >
> >> >> > On Fri, Aug 8, 2025 at 9:47=E2=80=AFPM Rick Macklem <rick.macklem=
@gmail.com> wrote:
> >> >> >>
> >> >> >> Hi,
> >> >> >>
> >> >> >> I'm looking at RFC7862 and I cannot find where it
> >> >> >> states if the clone_blksize attribute is per-file or
> >> >> >> per-file-system.
> >> >> >>
> >> >> >> If it is not in the RFC, which do others think it is?
> >> >
> >> >
> >> >  Before you told us about ZFS,  I would have assumed per-fs.
> >> >
> >> > Given the uncertainty in the spec, you may wind up dealing clients t=
hat assume it is per-fs.
> >> >
> >> > Although this is not a  catastrophe, you might want to file an errat=
a report explaining the negative consequences of assuming this is per-fs. I=
t won't get into a spec for a long while but it does provide as much warnin=
g as you can right now .
> >> >
> >> >
> >> >
> >> >>
> >> >> >> (Or maybe, if you have implemented CLONE,
> >> >> >> which does your implementation assume?)
> >> >> >>
> >> >> >> In case you are wondering why I am asking,
> >> >> >> it turns out that files in a ZFS volume can have
> >> >> >> different block sizes. (It can be changed after the
> >> >> >> file system is created.)
> >> >
> >> >
> >> > The guy who allowed that probably thinks it's a helpful feature.  Si=
gh!
> >> It's not just a feature change after creation, it turns out to be base=
d
> >> on file size as well.  A small file gets 512 and a larger one gets a f=
ull record
> >> (128K on my test system).
> >>
> >> And, yes, block cloning requires alignment with 512bytes or 128Kbytes
> >> depending on the file.
> >>
> >> I can return 128K for clone_blksize and that will (sub-optimally) hand=
le
> >> the 512byte case, but I think it is also possible to increase the reco=
rd
> >> size from 128K-> after the file system has files in it.
> >>
> >> I'll take a look at the Linux client to try and see if/how it uses
> >> clone_blksize.  I need to decide if I should always return 128K
> >> (or whatever the full recordsize is) or 512 for the small files.
> >
> >
> > I don't see the point of returning anything but 128K given what you sai=
d above.
> > If a file has to be smaller than 512 to merit the 512 block size, it co=
uld still be cloned with a 128k clone_block_size.  The spec makes an except=
ion for the last block of a file being shorter than the block size so retur=
ning a 512-byte clone_block_size.
> I'll be experimenting with it soon.
> What I do not know (you could write what I know about ZFS on a
> postage stamp;-) is whether the blksize for a file changes as it
> grows.
> --> So the problem is a file might get 512 because it is small when
>      first created and then grow large. Again, I do not currently know
>      what determines the blksize. Whether it is the first write being les=
s
>      than a record size when created or maybe it does switch to recordsiz=
e
>      (128K in my case) when it grows beyond 128K or ???
>      - I do know that ZFS allocates new blocks whenever data is written
>        to a file, even if the file is not growing. (Which is why it canno=
t
>        support ALLOCATE at this time and probably never will.)
>
> I'll be poking at it. For now, I just do not know, rick
I should have done a scan before posting.
I just ran a little program that printed out the blksize of every
regular file in a ZFS file system.
It turns out that the blksize is any exact multiple of 512 up to
128K (the record size for the volume).
Since most are C sources or objects, most are less than 128K.

If I return 128K, then most files would not be CLONEable unless
the CLONE is for the entire file.
Of course, I do not currently know how clients actually use
clone_blksize either. (Do they check alignment using it before
doing a CLONE or ???)

I'll be playing around with CLONE for both FreeBSD and Linux
in the coming days.
I'll post if/when I have useful info, rick

>
>
> >>
> >>
> >> Thanks for the comments, rick
> >>
> >> >
> >> >> >>
> >> >
> >> >
> >> >>
> >> >> >> Thanks, rick
> >> >> >>
> >> >> >
> >> >> > Yes, but since ZFS only supports filesystem level snapshots, and =
not actual file cloning, does that matter to anything?
> >> >> ZFS now has a feature it calls block cloning, which does clone file=
 ranges.
> >> >> (It was only added recently. I do not know if the Linux port uses i=
t yet?)
> >> >>
> >> >> rick
> >> >>
> >> >> >
> >> >> > Cheers
> >> >> >   Trond
> >> >>
> >> >> _______________________________________________
> >> >> nfsv4 mailing list -- nfsv4@ietf.org
> >> >> To unsubscribe send an email to nfsv4-leave@ietf.org

