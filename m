Return-Path: <linux-nfs+bounces-37-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA27F5462
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 00:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5621F20C9E
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277D200AE;
	Wed, 22 Nov 2023 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnDaCsOb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D64D8
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 15:19:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2839cf9ea95so264979a91.1
        for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 15:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700695154; x=1701299954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmaKjoVHsabulBFjO/QcZHUFy3Uac19UbPRk+g7uSUk=;
        b=nnDaCsObcbdRkufYxQUe6G/GlVQ2Xj3vEtFPHJF9m680kImQEnbhEa+NN0rBkg5FTR
         8IthjdgphQmWuLn2S8cpZzMIBe1B5IJY7vvRna3jtHwEOaU8FUBtGRiUXexY9D+i4lbm
         aQJZiwX5kDEijHwLVnsq/C7E5XZeBnHcCmU9Dsa86Hxjl+ALvimEMkV9i4SQmSHIR3jZ
         vZeaIrTDd+j6GCyS9gBJxwJsOoW/bPNUjuTWLYI91i9Iau7DLsZah0UO6JRZykU/X2g4
         wf3SIjPy5YYqbrEYJypPIbQVkvBsFv5I2Kq51dCyAl/Kl8S95mSDcr9BjGjTR6bkXMi9
         4iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695154; x=1701299954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmaKjoVHsabulBFjO/QcZHUFy3Uac19UbPRk+g7uSUk=;
        b=cNdpRiLnA+q7yariWJForFVmP9LVB7mkaUo3bD+S1DwyQd89AL2c/qPzXbigQMmAto
         0eyPH0XqafNS1cI++gulI1u2IiYPVubJ9jesmY/1NTX8DOm28uMZGnKiXepmu/0uir14
         OxEVOiNk6W5MZ0tLDpSLZpUFUqYeA/xqy79FY6inVBR7UaQOkH+32brBn7HUpUNuSRKH
         VVZTnuB176W+kHZMp+6LFMSS2U9RmiqBb0I0P0k/iy7/7dx0KbzhNauVfXXM2Pc8Mtan
         xdv6+gxN4moA+KJUSTxgtRRVmTpUyhNhomy0/7nOy/c54s41CxPF8iSEo3iWWVYiE9jU
         TosA==
X-Gm-Message-State: AOJu0Yz4b+7cjsRxllcgjY4JyC7av5KV50Ca1RdPMtoR40MctIjRpvtt
	ctphQ5euVvVplUJ9uaGpZI0OQslvKlEpbPbMQg==
X-Google-Smtp-Source: AGHT+IGXZFyX9vBUoP1kExsqOUqAh5VH12lH+3KEMeni5ChhakbgywfFTvuyrXlgenSrX0xeOXExC9DFv5FA+TbSdd4=
X-Received: by 2002:a17:90b:1c89:b0:280:c98f:2092 with SMTP id
 oo9-20020a17090b1c8900b00280c98f2092mr4017373pjb.33.1700695154517; Wed, 22
 Nov 2023 15:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
 <CAFX2JfnzDczbegELv3GMCYb3CEKZ+5WfgVotdoA3CyjUprGpTQ@mail.gmail.com>
 <CALXu0UebE2oGgWLMn-NkfGq5n+2dEFnqrOy617SRMmKF-dGOXg@mail.gmail.com>
 <CAFX2JfnDC1xZvuuUiHe8_RpBehwCZriZ13yYPk6pQSPSV4V-qQ@mail.gmail.com> <CALXu0UevOCU0dm-0WUEZZFCV=V8jQxmy2OQYhtptVyVAZeWs3g@mail.gmail.com>
In-Reply-To: <CALXu0UevOCU0dm-0WUEZZFCV=V8jQxmy2OQYhtptVyVAZeWs3g@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 22 Nov 2023 15:19:04 -0800
Message-ID: <CAM5tNy7QYgMUo_tTSPQ6hqxO8WrscBn1O2XpeJVK67OCQMu+2w@mail.gmail.com>
Subject: Re: How does READ_PLUS differ from READ?
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 2:48=E2=80=AFPM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Sun, 19 Nov 2023 at 19:02, Anna Schumaker <schumaker.anna@gmail.com> w=
rote:
> >
> > On Sun, Nov 19, 2023 at 12:59=E2=80=AFPM Cedric Blancher
> > <cedric.blancher@gmail.com> wrote:
> > >
> > > On Sun, 19 Nov 2023 at 18:48, Anna Schumaker <schumaker.anna@gmail.co=
m> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sun, Nov 19, 2023 at 12:38=E2=80=AFPM Cedric Blancher
> > > > <cedric.blancher@gmail.com> wrote:
> > > > >
> > > > > Good evening!
> > > > >
> > > > > How does READ_PLUS differ from READ? Has anyone made a simpler
> > > > > presentation (PowerPoint slides) than the RFCs?
> > > >
> > > > No slides, but at a high level READ_PLUS can compress out long rang=
es
> > > > of zeroes in a read reply by returning a HOLE segment instead of th=
e
> > > > actual zeroes. It's perfectly valid for the server to skip the zero
> > > > detection and return everything as a data segment, however.
> > >
> > > So how do you differ between
> > > 1. a hole, aka no filesystem blocks allocated
> > > 2. a long sequence of valid data with all zero bytes in them
> >
> > That's up to the server! It could use something like fiemap or lseek
> > with SEEK_HOLE or SEEK_DATA. It could also scan the data to see if
> > there are any zeroes that could be compressed out.
>
> How can the client figure out whether the data in a READ_PLUS reply
> are zeros of data, or zeros from a hole?
As I understand the RFC, it cannot. Or put another way "a hole is a
region that reads as all 0s, which may or may not have allocated blocks
on the server file system".

Although SEEK_HOLE typically returns the offset of an unallocated
region, I don't think either the POSIX draft (was it ever ratified?) nor
RFC7862 actually define a "hole" as an unallocated region.

On a similar vein, Deallocate can simply write 0s to the region.
(It does not actually have to "deallocate data blocks".)

At least that is my understanding of POSIX and RFC7862, rick

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
>

