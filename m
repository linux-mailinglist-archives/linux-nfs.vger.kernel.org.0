Return-Path: <linux-nfs+bounces-31-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890DC7F5387
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 23:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D51B20D81
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 22:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59B26FB4;
	Wed, 22 Nov 2023 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxz2p1+0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D871A8
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 14:42:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50970c2115eso324599e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700692926; x=1701297726; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jZKQP/HixaWkorCz4WndN0ni3oM2++w3OxviwHJFzw=;
        b=Dxz2p1+00lgZjfptWungGsYweZQaBvOKDHOqmVpn4dX+54ACFQtifutVGaGBGtD1v9
         Z709O/eYoI9awA/7gEFBYFSNqxfOJJHqtcdeGX3pDOxxURGGocK8yjrgnVAIuqZ66FvI
         P3uxuxIl5FYMEmDnZf5tta9PXnAMrSr2ArVXrUqtq1tAaso0bqAsYm2KLQA50rvx0Bba
         iKXX4ENmobJHm8OWCtlGqfafS0qSptYwF95H+ZCddkUwcr3b53SZUEhJ1cmITguYW/rU
         +R5qNJNyjIjNSj5Q2+0Ynu+6de3wH79BQ7oeJf5YOxqkKuB2RXwEwSWIyCxlA6tFSjDz
         bhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700692926; x=1701297726;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jZKQP/HixaWkorCz4WndN0ni3oM2++w3OxviwHJFzw=;
        b=ITy+X30KR6bJt4MvG7NOCvVZLjLDh8kgf+EJhfbB+0jJf+FCSWYIpu+dQDOiTobFaO
         PUlpcISeR3S3hOwRlpto6C+2bl3rVBzGR7Z5LeZgBC5aWBResGG0qFJw/Jmy5bxbrh0c
         J0nz9QC3h+6DAEe8jaFL5udBdRku1DekaIaC416MFnTShU9fShwNamBbABgeweUYHLsV
         W8y0lgYnMxw/5MN7IB0Fqu/Y8Y5b03f06kOtNcbXmbRPMDsS24g8yhUzEDD6RqAxkcwN
         zljK1eHNoW2Leu/X4ehFEEs120S0Cm82j/SFVnWt9Jd1tHy92Sr//RwEB69F6iXp1z27
         pdrA==
X-Gm-Message-State: AOJu0YyT2mYMvSvtMemHRFvRpksNdq8cAs3O1hMSzqJzUkRw/wvDTIu6
	FME71scjiNzFJ13ScPaHcvyo2wKQ7CSRIAU49Ev21YOJ
X-Google-Smtp-Source: AGHT+IFJNEjAOD8qNd2TUBjdniDSWZc5OqY6j8aU2zb6o36aGbC6EnSuEB7hx0I45wqdrRCZp6/SauDTUewTu/DPev8=
X-Received: by 2002:ac2:4d11:0:b0:507:b0f7:ec92 with SMTP id
 r17-20020ac24d11000000b00507b0f7ec92mr2248001lfi.59.1700692926227; Wed, 22
 Nov 2023 14:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
 <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org> <628D6042-758C-4D8B-8CAB-BC970EC0EFBD@oracle.com>
In-Reply-To: <628D6042-758C-4D8B-8CAB-BC970EC0EFBD@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 22 Nov 2023 23:41:29 +0100
Message-ID: <CALXu0Ufx4muT4vpLBcBW5cunODzTWo=940NKAD5GoS05jHZhAQ@mail.gmail.com>
Subject: Re: How to set the NFSv4 "HIDDEN" attribute on Linux?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Nov 2023 at 15:44, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Nov 20, 2023, at 6:46=E2=80=AFAM, Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > On Sun, 2023-11-19 at 17:51 +0100, Cedric Blancher wrote:
> >> On Sat, 18 Nov 2023 at 12:56, Jeff Layton <jlayton@kernel.org> wrote:
> >>>
> >>> On Sat, 2023-11-18 at 07:24 +0100, Cedric Blancher wrote:
> >>>> Good morning!
> >>>>
> >>>> NFSv4 has a "hidden" filesystem object attribute. How can I set that
> >>>> on a Linux NFSv4 server, or in a filesystem exported on Linux via
> >>>> NFSv4, so that the NFSv4 client gets this attribute for a file?
> >>>>
> >>>
> >>> You can't. RFC 8881 defines that as "TRUE, if the file is considered
> >>> hidden with respect to the Windows API." There is no analogous Linux
> >>> inode attribute.
> >>
> >> Can we use setfattr and getfattr to set/get the NFSv4.1 HIDDEN and
> >> ARCHIVE? We have Windows NFSv4 clients (and kofemann/Roland's codebase
> >> supports this), and that means we need to be able to set/get and
> >> backup/restore these flags on the NFSv4 server side.
> >>
> >
> > No. They would need to be stored in the inode on the server somehow and
> > there is no place to store them. These attributes are simply not
> > supported by the Linux NFS server.
>
> To be clear: these attributes are not supported within the Linux
> filesystems themselves. NFSD could of course handle these attributes,
> but there is simply no mechanism to make them persistent on Linux
> filesystems.

You have the setfattr/getfattr attributes on Linux, which can easily
store such boolean flags.

It would also solve the backup and restore issue, as GNU tar supports
these via tar --xattrs

>
> NTFS might be an exception to that, but I believe Linux does not
> allow mounted NTFS filesystems to be modified. So again, no way
> to make those attributes persistent.

New NTFS kernel driver in Linux 6.x supports r/w operation

>
> But I do wonder how Samba on Linux handles these guys. NFSD should
> do something that doesn't conflict with that.

Did anyone figure that one out?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

