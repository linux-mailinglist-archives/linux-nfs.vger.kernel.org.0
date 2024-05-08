Return-Path: <linux-nfs+bounces-3212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C68C03C5
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46421F218CF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825812BEB6;
	Wed,  8 May 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyPAbQ1/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8988BEE
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190741; cv=none; b=S5dCnBpFSPc0Sk7xDEPzqE6GG/GDYXc8PRmVJlf16tsCegdro/iO14rikBdwNgOoLg3tfgnStOnvCWbd135+G9aB73e+vtxIfR/F0NgH8Gk/JCPEDjA2rAjoY8o/mrhm3RVVEkZ2Ck/viGs6sxVRCWwW/bDr5NFJW8cfPBrVNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190741; c=relaxed/simple;
	bh=Eq0b7iFJq0mTCZkGQVFPub5gh/92dITPA0z1Wn+MpZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKvyA1aN8jcTbLNbMT19vSSa4t4eb7o/n6xiW8FLgbC1SkHq4z5wTe8gJ/Y+qf20ZHAd5L7hlxRD8Kb6ftAMXwUFt0TeDzR/TRAbfigmTJ+oCwfeVEHeOWi0Wz2fww9iiKjMnup6CvXp5ZQ/i7UrRLqSeyKW7vnL6hnxN3WV6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyPAbQ1/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51faf2325f4so809062e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2024 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715190738; x=1715795538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyuNEHBhOHu2lFnfyz/EA6MNfXhMRJo+SsdaFvfKi/M=;
        b=DyPAbQ1/lHQVTJhhgg/ZVlT56dNtx8DphETk/ZTprka48CoepuPHrGp5LILCknUYjr
         i1Myu4PKVTv3+SBl55Wiq9RNpDiUHyub2JWQfxHt5GA/bi48Hg1W6CqWFywKbJHnGDtx
         n4ea204xkvxCDDy41cqK2aAXIBKvzyGOAvMcqCmzLVzJCf8TuLrS4kFQXKOASawsc4+B
         fVv0PD3zW+9UTwCOhVnOCS/5zDuoW4gpv+ayTIZcXM93T5MmZS5puf85VUdpmQU1/Dg1
         y/h/YogVFgH+t7XVdOfo4gLP2wl9px5xxw0w7E2LCEqR5FQB9wOdBThsSIDjiDFqTLzp
         xR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190738; x=1715795538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyuNEHBhOHu2lFnfyz/EA6MNfXhMRJo+SsdaFvfKi/M=;
        b=j9EZyhMkyErsrrEuiEaraRhYSZLQDU4j3K5YXUXEselj6LYRGYcTcDa75Ufcxd23g1
         kAo19a69GPm98nitsiFPJarUTnfsk+lVtaKcH2W+yEiivVWXh4qvEHE8n9pOsPMxuZRs
         +w+qY2PZiKnJkueKVy1eSSD9EY50AEbYXcoFsNEDuFYKAgjMhpUlhijvND0RonEkVfc5
         j7I8VjqJButulongR2CT21pKlP7jhKp0OT2RVYXXXZiw1WRd+lh2BMxznoyBNzX2wIMi
         KssmgW4WVSSPMrY/kS97EjfWGOqOEck0RmkRCvf2j4+5XhawsHsSQNB6B+sK1AdZstNi
         YSLg==
X-Forwarded-Encrypted: i=1; AJvYcCUR55cI5sZPAbVvB9gbeIEHJ6WAkCJWnEnhiyGxgmqZnWxQYHu9K9EOuoHMeEE1GBA4PiXJQEwDXeTo6Yho7ddxmHJ02pc4p9mN
X-Gm-Message-State: AOJu0YxyAz6Lsa//M0aawG/w1s23EAYIFWVmNonEhL6OiqQ5h8/M0zIi
	sqHScxB6w/0MoJZP5HWpSxVtjil5lflMZ50IMJXuBoNUR6mZf53n4IVzt0PE1uQOfbLTsiwcJpq
	hDGkglK+bK1ArwXiYze1Pbt75ayo=
X-Google-Smtp-Source: AGHT+IEh1E0xlLfGcFB+mUpfJM7yTOOnblzPBHcRuJNLLzf4EnlR9Vsa7o/eGdULvdQuy6H+o2/Jsg2Pyq7+Q7CuvcI=
X-Received: by 2002:a2e:a715:0:b0:2de:1457:9d22 with SMTP id
 38308e7fff4ca-2e445f80bccmr19699621fa.0.1715190737927; Wed, 08 May 2024
 10:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507195933.45683-1-olga.kornievskaia@gmail.com> <9D9DB9E5-E772-462B-BD38-7F703459A0FC@redhat.com>
In-Reply-To: <9D9DB9E5-E772-462B-BD38-7F703459A0FC@redhat.com>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Wed, 8 May 2024 13:52:06 -0400
Message-ID: <CAN-5tyFWrqihMv8UwvAmrcxuFdM6S5qMvnZgWkJqWXm6iFJeVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pNFS/filelayout: check layout segment range
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:50=E2=80=AFAM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 7 May 2024, at 15:59, Olga Kornievskaia wrote:
>
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Before doing the IO, check that we have the layout covering the range o=
f
> > IO.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/filelayout/filelayout.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelay=
out.c
> > index 85d2dc9bc212..bf3ba2e98f33 100644
> > --- a/fs/nfs/filelayout/filelayout.c
> > +++ b/fs/nfs/filelayout/filelayout.c
> > @@ -868,6 +868,7 @@ filelayout_pg_init_read(struct nfs_pageio_descripto=
r *pgio,
> >                       struct nfs_page *req)
> >  {
> >       pnfs_generic_pg_check_layout(pgio);
> > +     pnfs_generic_pg_check_range(pgio, req);
> >       if (!pgio->pg_lseg) {
> >               pgio->pg_lseg =3D fl_pnfs_update_layout(pgio->pg_inode,
> >                                                     nfs_req_openctx(req=
),
> > @@ -892,6 +893,7 @@ filelayout_pg_init_write(struct nfs_pageio_descript=
or *pgio,
> >                        struct nfs_page *req)
> >  {
> >       pnfs_generic_pg_check_layout(pgio);
> > +     pnfs_generic_pg_check_range(pgio, req);
> >       if (!pgio->pg_lseg) {
> >               pgio->pg_lseg =3D fl_pnfs_update_layout(pgio->pg_inode,
> >                                                     nfs_req_openctx(req=
),
> > --
> > 2.39.1
>
> Looks right, less duplication to just call pnfs_generic_pg_check_range()
> from pnfs_generic_pg_check_layout() now.

filelayout.c is not the only caller of pnfs_generic_pg_check_layout().
flexfilelayout has a wrapper around those 2 functions and calls that.
however, the argument about duplicated code frustrates me because
currently the code has 4lines. but if we were to re-write the same
with a function, it would be more lines used in total (flexfiles has 8
lines for it).

>
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
> Ben
>

