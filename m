Return-Path: <linux-nfs+bounces-43-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF707F691B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 23:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070E628197B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6A11C8F;
	Thu, 23 Nov 2023 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrpSyCdx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760ED47
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 14:47:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2857670af8cso520548a91.0
        for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700779621; x=1701384421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlQd4U9NgPxSge5CIcK2S1J3HNMym0rUtGC+zT+w7Mo=;
        b=DrpSyCdxNaILtcesSBkRk1gnmKIBNG923LZ+9BC0po6fWElIM4rR9ZrY4svLfXChgD
         kHiZZHl8LM6kjSgpSXtV+aropA9elNrQETbGkBb5q1K/gBH1Sg90V9dX67CYRyMBdh0s
         gNI9NVcTpR/GVJsXjGcYcMjzcmuihC6zySKdBBvt1PRZWtWNS9CO56Zy2K5tyoQ0Ttim
         EAf9owPZ+SjNJv+Ft2wznfB4TJaW4ZKmWnXGE3UUUy6K57ueOegqS4XsqfqPOJPC8xjy
         yK1tNOnVZ3oMMU2OQPfNKJsoIBJddss2qf6Zn+qCjuHBvevbJV7dhBRZXLwDtC4fQzsp
         V03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700779621; x=1701384421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlQd4U9NgPxSge5CIcK2S1J3HNMym0rUtGC+zT+w7Mo=;
        b=FvKN9VNfUKEdClJ3vyJvVFLhoL8qif0kiMgyW8txtka5h8PcAXX+whTiStQwZ9XrUS
         JEhsUm+PIxL4CgXygIsKcw0kHPGmGwOeqCH9LwWXCEPWFlW6oNky2V3vW5o147+nHkKn
         Eo97LdhNRyW5AvDAIgnOh73PMTRJ12zHf2cs4Slg9wn3GbxCrXSQ+18UKoBuy+Q/AcoV
         ASu43pDsmi1Knh4Lm61TiXMbeMy7rRRamg9BJeDKvJc6tK5h1ckq6Bqte4NrDghp3B6h
         8Y0ah19VyLg1bUvWQFiROg0SFn00PP0pUBVQ1l94kXlF6rmBAxfq4Fmv5axkpO8IQUu1
         E+eg==
X-Gm-Message-State: AOJu0YzymRV+/0eus1t+kWRDq30Qc+OXVujORssiQYcNCbkx9EkwROLD
	TEzo6bfg/5oISTsBA3geXL8iZRkML2lyrQOF63hUYPc=
X-Google-Smtp-Source: AGHT+IFS/ZHUTenetFbyWv2eGMvULuAyCdpHUK3Ww4T713pThqf5QE4jffdcYgNvjy8J92jkuXOeGEH4cAvp3hO+IEc=
X-Received: by 2002:a17:90b:1c8b:b0:285:6943:eca2 with SMTP id
 oo11-20020a17090b1c8b00b002856943eca2mr763399pjb.29.1700779620906; Thu, 23
 Nov 2023 14:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
 <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
 <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com> <CALXu0UccoNs0A4MjQH7gPboarWyZcRQzsy2zJRxk51LR0hGDVQ@mail.gmail.com>
In-Reply-To: <CALXu0UccoNs0A4MjQH7gPboarWyZcRQzsy2zJRxk51LR0hGDVQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 23 Nov 2023 14:46:50 -0800
Message-ID: <CAM5tNy7TvGgNRjdyo+hYMvOM4PCEMbEfO+T7M1QCOv+OMx6dUQ@mail.gmail.com>
Subject: Re: <DOT>foo gets NFSv4 HIDDEN attribute by default by nfsd? Re: How
 to set the NFSv4 "HIDDEN" attribute on Linux?
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 2:24=E2=80=AFPM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Wed, 22 Nov 2023 at 23:42, Cedric Blancher <cedric.blancher@gmail.com>=
 wrote:
> >
> > On Mon, 20 Nov 2023 at 12:46, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Sun, 2023-11-19 at 17:51 +0100, Cedric Blancher wrote:
> > > > On Sat, 18 Nov 2023 at 12:56, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > > >
> > > > > On Sat, 2023-11-18 at 07:24 +0100, Cedric Blancher wrote:
> > > > > > Good morning!
> > > > > >
> > > > > > NFSv4 has a "hidden" filesystem object attribute. How can I set=
 that
> > > > > > on a Linux NFSv4 server, or in a filesystem exported on Linux v=
ia
> > > > > > NFSv4, so that the NFSv4 client gets this attribute for a file?
> > > > > >
> > > > >
> > > > > You can't. RFC 8881 defines that as "TRUE, if the file is conside=
red
> > > > > hidden with respect to the Windows API." There is no analogous Li=
nux
> > > > > inode attribute.
> > > >
> > > > Can we use setfattr and getfattr to set/get the NFSv4.1 HIDDEN and
> > > > ARCHIVE? We have Windows NFSv4 clients (and kofemann/Roland's codeb=
ase
> > > > supports this), and that means we need to be able to set/get and
> > > > backup/restore these flags on the NFSv4 server side.
> > > >
> > >
> > > No. They would need to be stored in the inode on the server somehow a=
nd
> > > there is no place to store them. These attributes are simply not
> > > supported by the Linux NFS server.
> >
> > Linux has xattrs, which are per inode, and can be backuped and
> > restored via tar --xattrs. That would be good enough
>
> Also, it is legal for a nfsd to give the DOT files (/.foo) the HIDDEN
> attribute by default? Right now on Windows they show up because NFSv4
> HIDDEN is not set, and it is annoying.
First, just to let you know, I am not a Linux developer. I work on the Free=
BSD
NFS code...

To be honest, you can do just about anything you want in the client. The RF=
Cs
basically define what goes "on the wire".
Now, having said that, you might run into difficulties doing this
because "hidden"
is defined as a RW attribute and to set it would require renaming the file.

rick

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
>

