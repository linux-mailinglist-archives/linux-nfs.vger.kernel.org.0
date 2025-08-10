Return-Path: <linux-nfs+bounces-13544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B55B1FAC2
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E23B5A2F
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA3C226888;
	Sun, 10 Aug 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDceU6F5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E01C6FE5
	for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840308; cv=none; b=OsV6am6j4+RguIPs9z1sijPQDwBKRmK3KmNyEG+0QAVUmeXj6vZuey1ymTmL8RXuTkKEo/KJh+1AUm9nFPca3OvJAh6Dn7l2gXhXG7v1HbmINnXYBJzAfTB8yZp1axFjTs3SeHyVwLSfa0n1nfrnjfWIwrDEXyoIm2NRljTZa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840308; c=relaxed/simple;
	bh=tVAR2H6d0zIX0Zp1jMoWRDyEQPjj5l9ShI8LVDkG2cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojIZHeY+SQIw/QZwmWEsfHbBGY0at1vgdTzVDBhivTSsYWfwmsn8WlUHuUdvl8bLsYkANMnHggBNXPzom1a2O50R8InSgUNfXpM79KnKV6esJ2+kpousVmlWYZG5yCHpdBsuSMLpKigeUVs/I0kC5qKJ/pffYiEJdR90YDXaCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDceU6F5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6180ce2197cso2102843a12.2
        for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754840304; x=1755445104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWVLJbsFZAgUybJ9sgM5L/oYtxRd3TslQh0KGXsynRA=;
        b=WDceU6F5WNnKpNUZDb/D2hP6jYyiKVdR5uz5JQ0HxldR/BYs5xdc7vsE/BHDP5MA0d
         M7byhZI0WBYh6nmqXVk913TutAKPJACUEsuxNMQdXtGRxyYfAVoWv+NbWMchobgjAsAd
         X2PjowOpMmiQUVyfHWg1vrmsSAxLy338ADzeEimFeFSLYBNEYiwhg8/lUwVwqolAGmwM
         N/JlZ6pshHxs1nCaX1GD3Kb/9g5fVX/2OpF0+enTwAJ7dQrh7oAp5CpbeWn/du5z8OBU
         hOX9BIjjrgRt7znfu3HitLhKJJMIEVtnj1SLLh6RvbEEVknzPl5PlYs6Hmdzfor8OgJs
         twgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754840304; x=1755445104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWVLJbsFZAgUybJ9sgM5L/oYtxRd3TslQh0KGXsynRA=;
        b=egdqQAWTcgOuBowKR1R68lkjTFDwGmoeV/NngCxMZlr4q78wTQXVUjJG232JitNWRi
         clIIIkuEQfOE0tt+xxGOCyL24kXjvbJ4VowwcXZ62gAuPxykxsfGlMgKMeoGzjLD5Pwx
         neX4yTCWPWRErbjO+tjkDUBDtwYoVn5v4aqF8eQTvNNpGH9Q7GkByz1+Q3ujJImQV/eY
         nWHkbUCrG+YokejRVad5ikq284m/Ro+tW56HAKPO7DDB65i+gDtNcH68df2rVXbwLL1k
         UUARJthFVFOnru7WVoys1MyV7XwDISoABJ/NgVkFj+eN/kOgEBouSFyGuBR292MbQ817
         BtIw==
X-Forwarded-Encrypted: i=1; AJvYcCWOQlRTEFBoMVPKd9oo7BdAo6wzRStdqfG6m/Y7/VJAjfDtnoLQq03hqQrKKE3hw5MOoPFIoUR2D1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AXH+idqqeonXfKZtcYrRtDBAJp0Yu+4UVWSshryQO17t4epQ
	bgpOIktPVwgu6f6P6BwO5mcRuWL+3mta+fodPa9zBMG89pqEhFYzxseqBQOFEgk0T0RsDmtiBCs
	VoCeUblsscfG3vH5eD7CJNZ/30OGmUw==
X-Gm-Gg: ASbGnct2AteFNLc/kd+365rdZ2G3M92hR5gqKWdZKHSNba94NoVZoojVVvuNgX0krBi
	vsN9CcfbzDh+09OC4jMXFN9HG7KSvBVipkjh7c3FCe/vNyBBimu2kfzb4FFUNHAGVmcg//kOCED
	aMdrxiQFRQuuIQP72pHycubJo9OJAuz0qQ4Px72bfR8BmXE/J7yXXvtLTY1HpHoDzaq+N2O9Hgk
	Nt+eFkKt8dmgAeKWSufJBjyxpvlwZKACsCFrWs=
X-Google-Smtp-Source: AGHT+IE8FUDIxxrm0Q8QciOUFnagFTGUlqp7WKn9Lqw9aXrCZZg2InjyHO4KxS4ldzxtSITNBQc8WeB/HBxicSmBtAA=
X-Received: by 2002:a17:907:94ca:b0:ae3:67c7:54a6 with SMTP id
 a640c23a62f3a-af9c655308dmr835071866b.34.1754840304020; Sun, 10 Aug 2025
 08:38:24 -0700 (PDT)
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
 <CAM5tNy4jx3ML_XhWaAo=Ffde3ZzqR5mGd-kcVvpAtxXjesChJA@mail.gmail.com>
 <CAM5tNy6GZWSYWftqexCk2Q0qTsiz0Aq2pn0HxG=h-POPFoQAoQ@mail.gmail.com> <CAM5tNy7DxmejQgwJJSAyvVEuOXYsbHmGCKu+6DYm68iuULNe+A@mail.gmail.com>
In-Reply-To: <CAM5tNy7DxmejQgwJJSAyvVEuOXYsbHmGCKu+6DYm68iuULNe+A@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 10 Aug 2025 08:38:10 -0700
X-Gm-Features: Ac12FXy5F14I4QmkMIlJWBSiLmWWGudTgbX7AUwyx13G1dhFQClunZP336zVlco
Message-ID: <CAM5tNy4xWh_Hyv-kdJcPV5C59PE5EZzh-5TWZCYUtOpa1MnkpA@mail.gmail.com>
Subject: Re: [nfsv4] Is NFSv4.2's clone_blksize per-file or per-file-system?
To: David Noveck <davenoveck@gmail.com>
Cc: Trond Myklebust <trondmy@gmail.com>, NFSv4 <nfsv4@ietf.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 8:27=E2=80=AFAM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Sun, Aug 10, 2025 at 7:52=E2=80=AFAM Rick Macklem <rick.macklem@gmail.=
com> wrote:
> >
> > On Sun, Aug 10, 2025 at 7:32=E2=80=AFAM Rick Macklem <rick.macklem@gmai=
l.com> wrote:
> > >
> > > On Sun, Aug 10, 2025 at 6:58=E2=80=AFAM David Noveck <davenoveck@gmai=
l.com> wrote:
> > > >
> > > >
> > > >
> > > > On Sat, Aug 9, 2025 at 5:02=E2=80=AFPM Rick Macklem <rick.macklem@g=
mail.com> wrote:
> > > >>
> > > >> On Sat, Aug 9, 2025 at 1:12=E2=80=AFPM David Noveck <davenoveck@gm=
ail.com> wrote:
> > > >> >
> > > >> >
> > > >> >
> > > >> > On Friday, August 8, 2025, Rick Macklem <rick.macklem@gmail.com>=
 wrote:
> > > >> >>
> > > >> >> On Fri, Aug 8, 2025 at 8:38=E2=80=AFPM Trond Myklebust <trondmy=
@gmail.com> wrote:
> > > >> >> >
> > > >> >> >
> > > >> >> >
> > > >> >> > On Fri, Aug 8, 2025 at 9:47=E2=80=AFPM Rick Macklem <rick.mac=
klem@gmail.com> wrote:
> > > >> >> >>
> > > >> >> >> Hi,
> > > >> >> >>
> > > >> >> >> I'm looking at RFC7862 and I cannot find where it
> > > >> >> >> states if the clone_blksize attribute is per-file or
> > > >> >> >> per-file-system.
> > > >> >> >>
> > > >> >> >> If it is not in the RFC, which do others think it is?
> > > >> >
> > > >> >
> > > >> >  Before you told us about ZFS,  I would have assumed per-fs.
> > > >> >
> > > >> > Given the uncertainty in the spec, you may wind up dealing clien=
ts that assume it is per-fs.
> > > >> >
> > > >> > Although this is not a  catastrophe, you might want to file an e=
rrata report explaining the negative consequences of assuming this is per-f=
s. It won't get into a spec for a long while but it does provide as much wa=
rning as you can right now .
> > > >> >
> > > >> >
> > > >> >
> > > >> >>
> > > >> >> >> (Or maybe, if you have implemented CLONE,
> > > >> >> >> which does your implementation assume?)
> > > >> >> >>
> > > >> >> >> In case you are wondering why I am asking,
> > > >> >> >> it turns out that files in a ZFS volume can have
> > > >> >> >> different block sizes. (It can be changed after the
> > > >> >> >> file system is created.)
> > > >> >
> > > >> >
> > > >> > The guy who allowed that probably thinks it's a helpful feature.=
  Sigh!
> > > >> It's not just a feature change after creation, it turns out to be =
based
> > > >> on file size as well.  A small file gets 512 and a larger one gets=
 a full record
> > > >> (128K on my test system).
> > > >>
> > > >> And, yes, block cloning requires alignment with 512bytes or 128Kby=
tes
> > > >> depending on the file.
> > > >>
> > > >> I can return 128K for clone_blksize and that will (sub-optimally) =
handle
> > > >> the 512byte case, but I think it is also possible to increase the =
record
> > > >> size from 128K-> after the file system has files in it.
> > > >>
> > > >> I'll take a look at the Linux client to try and see if/how it uses
> > > >> clone_blksize.  I need to decide if I should always return 128K
> > > >> (or whatever the full recordsize is) or 512 for the small files.
> > > >
> > > >
> > > > I don't see the point of returning anything but 128K given what you=
 said above.
> > > > If a file has to be smaller than 512 to merit the 512 block size, i=
t could still be cloned with a 128k clone_block_size.  The spec makes an ex=
ception for the last block of a file being shorter than the block size so r=
eturning a 512-byte clone_block_size.
> > > I'll be experimenting with it soon.
> > > What I do not know (you could write what I know about ZFS on a
> > > postage stamp;-) is whether the blksize for a file changes as it
> > > grows.
> > > --> So the problem is a file might get 512 because it is small when
> > >      first created and then grow large. Again, I do not currently kno=
w
> > >      what determines the blksize. Whether it is the first write being=
 less
> > >      than a record size when created or maybe it does switch to recor=
dsize
> > >      (128K in my case) when it grows beyond 128K or ???
> > >      - I do know that ZFS allocates new blocks whenever data is writt=
en
> > >        to a file, even if the file is not growing. (Which is why it c=
annot
> > >        support ALLOCATE at this time and probably never will.)
> > >
> > > I'll be poking at it. For now, I just do not know, rick
> > I should have done a scan before posting.
> > I just ran a little program that printed out the blksize of every
> > regular file in a ZFS file system.
> > It turns out that the blksize is any exact multiple of 512 up to
> > 128K (the record size for the volume).
> > Since most are C sources or objects, most are less than 128K.
> >
> > If I return 128K, then most files would not be CLONEable unless
> > the CLONE is for the entire file.
> It appears that your suggestion of 128K is correct for ZFS.
> I am still not sure, but it appears that, for files up to 128K,
> the files are a single block (which is any multiple of 512).
> --> As such, only the entire small file can be cloned.
>
> So, returning 128K for all files in the file system seems like
> it will be the correct choice.
>
> It still leaves the per-filesystem vs per-server question
> since (if I read it correctly) the Linux client uses clone_blksize
> per-server (and not per-server file system).
Actually, there's a good chance I got this wrong. I recall that
the Linux client creates a separate "mount" that shows up in
places like "df" for every server file system.
So, it is fairly likely that the Linux client is per-file system.

Maybe someone like Trond can clarify this w.r.t. the Linux client?

rick

>
> I do not think per-server is the correct choice, since different
> file systems on a server could have different block sizes.
>
> rick
>
> > Of course, I do not currently know how clients actually use
> > clone_blksize either. (Do they check alignment using it before
> > doing a CLONE or ???)
> >
> > I'll be playing around with CLONE for both FreeBSD and Linux
> > in the coming days.
> > I'll post if/when I have useful info, rick
> >
> > >
> > >
> > > >>
> > > >>
> > > >> Thanks for the comments, rick
> > > >>
> > > >> >
> > > >> >> >>
> > > >> >
> > > >> >
> > > >> >>
> > > >> >> >> Thanks, rick
> > > >> >> >>
> > > >> >> >
> > > >> >> > Yes, but since ZFS only supports filesystem level snapshots, =
and not actual file cloning, does that matter to anything?
> > > >> >> ZFS now has a feature it calls block cloning, which does clone =
file ranges.
> > > >> >> (It was only added recently. I do not know if the Linux port us=
es it yet?)
> > > >> >>
> > > >> >> rick
> > > >> >>
> > > >> >> >
> > > >> >> > Cheers
> > > >> >> >   Trond
> > > >> >>
> > > >> >> _______________________________________________
> > > >> >> nfsv4 mailing list -- nfsv4@ietf.org
> > > >> >> To unsubscribe send an email to nfsv4-leave@ietf.org

