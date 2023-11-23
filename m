Return-Path: <linux-nfs+bounces-40-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A637F68EC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 23:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C8FB20E20
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 22:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA81401C;
	Thu, 23 Nov 2023 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWqYnAI2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3246310F8
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 14:14:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso2544925a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 14:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700777659; x=1701382459; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5vSTfYWkE/phKODgcMUMbJYSZMT8h+eiNWLJmZM51g=;
        b=PWqYnAI2AjA3dXy+//sh0YpMLMafr1mh40EZokyr586lUts5UpmTkP5InHGpT9nPiM
         HikzXXGYKimrrAts5GkuxbdmGWUQioigebPrpWYwRb5rgTL9mv6d70x6sUS9GV59F6Jt
         sT6WfWrwAv3HSo4bycPgRloaOLe9Y7OYKlGWyyn7xNYA8RYbAkY+MDDfhLgmSgtZORFg
         AEg4lZrEdI4RlSkLW4vuvvcJyKYGByUjYWODcFO57wZ7knD+3R5j+2W0NFZh1N1jenTc
         XZWmL9G0jd0e+IjcbvkMGnGtDDJRgmjNWT8BSK4V32SN0Up/yNNujLJUft8gbuwKdcH1
         JDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777659; x=1701382459;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5vSTfYWkE/phKODgcMUMbJYSZMT8h+eiNWLJmZM51g=;
        b=Eq2o0w3hq7rNK67zH7SbUTPiJJQbVhcfwDtseygE4ZXHaeHmwoMZhqbokHeZOID1Pe
         Ncfhvvr7Ew/jgn2vvfsAXrmvBbdVVHWmjj2eWG8ZHJkRRaT/OFbIA0bNwwxtSZk77XxZ
         JqQRfnS3cIRh9aQKnOWMVewHX/CE9GwOkTDSeGBwQfz0k41yvCHM7vaEjWWsbl0U6fIE
         Wmo6VGOFr6RCrqAp/abC9v4zRgSQ5293y9aJl3ioPL6gc2VuqdN3ebs+M9BpCOvj0NB0
         f1NgUzH8k2sqaonkYZ36X1kPeXtU/n73/FSvYDbCmGq6aSY/FvFKXPyHXJPjh3ChIg/6
         dFkA==
X-Gm-Message-State: AOJu0YwR+Ddncz7PDwpeHiT/Nk13QJAxJtsBTSQxgvo2qLqaDhVO5Jun
	KQWPqntqGkVWECaXDzuYse4RIUTmPgs2xh8VYcFU6nhhpiw=
X-Google-Smtp-Source: AGHT+IFgDHmN+1rTmFo7T6vJymoJaHMBLumHulpQf0/JaJy6Kz7K4uOI17gl2Db+WEDVmNU12gNfEHh0rm274/aagD8=
X-Received: by 2002:aa7:d795:0:b0:548:aca1:b15f with SMTP id
 s21-20020aa7d795000000b00548aca1b15fmr3581811edq.17.1700777659168; Thu, 23
 Nov 2023 14:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
 <CAFX2JfnzDczbegELv3GMCYb3CEKZ+5WfgVotdoA3CyjUprGpTQ@mail.gmail.com>
 <CALXu0UebE2oGgWLMn-NkfGq5n+2dEFnqrOy617SRMmKF-dGOXg@mail.gmail.com>
 <CAFX2JfnDC1xZvuuUiHe8_RpBehwCZriZ13yYPk6pQSPSV4V-qQ@mail.gmail.com>
 <CALXu0UevOCU0dm-0WUEZZFCV=V8jQxmy2OQYhtptVyVAZeWs3g@mail.gmail.com> <CAM5tNy7QYgMUo_tTSPQ6hqxO8WrscBn1O2XpeJVK67OCQMu+2w@mail.gmail.com>
In-Reply-To: <CAM5tNy7QYgMUo_tTSPQ6hqxO8WrscBn1O2XpeJVK67OCQMu+2w@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 23 Nov 2023 23:13:42 +0100
Message-ID: <CALXu0Ue6d7Z+gh5VS_64scjUwPA_-PVKmsv0W+uEx93vbf6dgw@mail.gmail.com>
Subject: Re: How does READ_PLUS differ from READ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Nov 2023 at 00:19, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Wed, Nov 22, 2023 at 2:48=E2=80=AFPM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > On Sun, 19 Nov 2023 at 19:02, Anna Schumaker <schumaker.anna@gmail.com>=
 wrote:
> > >
> > > On Sun, Nov 19, 2023 at 12:59=E2=80=AFPM Cedric Blancher
> > > <cedric.blancher@gmail.com> wrote:
> > > >
> > > > On Sun, 19 Nov 2023 at 18:48, Anna Schumaker <schumaker.anna@gmail.=
com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Sun, Nov 19, 2023 at 12:38=E2=80=AFPM Cedric Blancher
> > > > > <cedric.blancher@gmail.com> wrote:
> > > > > >
> > > > > > Good evening!
> > > > > >
> > > > > > How does READ_PLUS differ from READ? Has anyone made a simpler
> > > > > > presentation (PowerPoint slides) than the RFCs?
> > > > >
> > > > > No slides, but at a high level READ_PLUS can compress out long ra=
nges
> > > > > of zeroes in a read reply by returning a HOLE segment instead of =
the
> > > > > actual zeroes. It's perfectly valid for the server to skip the ze=
ro
> > > > > detection and return everything as a data segment, however.
> > > >
> > > > So how do you differ between
> > > > 1. a hole, aka no filesystem blocks allocated
> > > > 2. a long sequence of valid data with all zero bytes in them
> > >
> > > That's up to the server! It could use something like fiemap or lseek
> > > with SEEK_HOLE or SEEK_DATA. It could also scan the data to see if
> > > there are any zeroes that could be compressed out.
> >
> > How can the client figure out whether the data in a READ_PLUS reply
> > are zeros of data, or zeros from a hole?
> As I understand the RFC, it cannot. Or put another way "a hole is a
> region that reads as all 0s, which may or may not have allocated blocks
> on the server file system".
>
> Although SEEK_HOLE typically returns the offset of an unallocated
> region, I don't think either the POSIX draft (was it ever ratified?) nor
> RFC7862 actually define a "hole" as an unallocated region.

Opengroup ratified that one. See https://austingroupbugs.net/view.php?id=3D=
415

>
> On a similar vein, Deallocate can simply write 0s to the region.
> (It does not actually have to "deallocate data blocks".)
>
> At least that is my understanding of POSIX and RFC7862, rick

Can anyone please confirm that RFC7862 and READPLUS cannot distinguish
between allocated and unallocated regions in a file?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

