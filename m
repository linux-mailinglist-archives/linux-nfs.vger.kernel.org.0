Return-Path: <linux-nfs+bounces-1049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062182B88E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 01:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF980B22BB5
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D77362D;
	Fri, 12 Jan 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA/7/FG+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAD62A
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so6914049e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 16:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705018829; x=1705623629; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqkg5MRPq6ZJmYebpLqsbj9BO9s6KGYJPr+A6d45MJg=;
        b=eA/7/FG+alo0HILC7e1ShwAw0KsswNmKkAVhBHto+qXLuhFWRqK8X7NJt5j+yMDFYC
         QQ9qSnTjQZouxm4XmCoiPHNx4e0K4e7h5BBNMhzxBCw/23rT0xHfeyWQCziOPHDbCzlv
         POC78VjkKAIrBQViRweyJi/8z4UUyONWNcIotfEAVC9JQfy1Zp0+a1wVnSlGekTzXUc0
         7tqQAGhZt4zoBJ+0kXMhOT1JI3icKhxg+18RAvBqCymmju9TFrogOy0vCuQ8rkNHCdhA
         f/W6SkKoUpErhT67ray00TJjPggWb30G9FXxvviV/CNOpXNdtThaqZORQzHbJWrASZka
         shTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705018829; x=1705623629;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqkg5MRPq6ZJmYebpLqsbj9BO9s6KGYJPr+A6d45MJg=;
        b=fCNG5LwUckj/eTBLbOQZAyAiYq35hhLVUHMK63k8s1zsHEfsMeb0hST/IaLm23aEA1
         0lZhiRlkSYGjnMtNqaDUg+vQ2BilM0v8qv/nx1e80Ou6CQJR2Et7AnopEqi5WNC24dr7
         ueYL1FGympihzb8eoE9Qhtbn/5gZMUVABH+nv4JzRes0T9ZzwzmqhJfIMDCCbf5jpwAl
         cef/uZPd19EA2vjCrvP3fAQq8Xkzf9mqz1uLz9u2nrFVqAzKx11DnVAqqnWGdOd2FGvp
         ONX9wZoYfgONBNPbNDW55VOkAQgdahJIL5sbMEYJDm+szrMsDqmW7vYbsq02Pnq6dGsB
         xeTA==
X-Gm-Message-State: AOJu0YwmuWjYE/OQgeGJWBvgNUm6mBKs+Oc7SM59bACvHOuZF8tuiy2w
	BOVKTvuEdArcXEXv+XIycQRABk27l4c3RNr/HzK7+t4rewo=
X-Google-Smtp-Source: AGHT+IGRrscjg2cryl3WgqlrAOpKHBW9b04UMIAFcRLPto0HfY6dCiN9aG2iqEzMv+8/zMgFYoxha4DN7hw1OzYoFjw=
X-Received: by 2002:a05:6512:ea0:b0:50e:7be9:52fe with SMTP id
 bi32-20020a0565120ea000b0050e7be952femr264817lfb.91.1705018828860; Thu, 11
 Jan 2024 16:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQniGNGuPm5CTTs3oJRuCH40HTt6K91nCAPRnt0tECxkBA@mail.gmail.com>
 <bce828afb68c973d684b3e179cf8d6ce39c8b9c3.camel@kernel.org>
 <39adc7fc114c6f8ea38fe7c846c322dab5fac907.camel@kernel.org> <CAKAoaQkdY-NOgWoVKN+oitTSFbmfC7fixoxDfXR0SF-6EJrEOw@mail.gmail.com>
In-Reply-To: <CAKAoaQkdY-NOgWoVKN+oitTSFbmfC7fixoxDfXR0SF-6EJrEOw@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 12 Jan 2024 01:20:02 +0100
Message-ID: <CAAvCNcCpHHCGfmRXN2n35xhzvL-te1iaG+=56H32E89GvCJQeQ@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jan 2024 at 22:28, Roland Mainz <roland.mainz@nrubsig.org> wrote=
:
>
> On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
> > > > Are there any known issues with NFSv4.1 mandatory locking nfsd code=
 in
> > > > the Linux 5.10.0-22-rt-amd64 kernel (technically the Debian Bullsey=
e
> > > > RT kernel) ? Is there any kernel or NFS test suite module which cov=
ers
> > > > NFSv4.1 client mandatory locking ?
> > >
> > > Linux doesn't support mandatory locking at all since 2021 [1]. The Li=
nux
> > > NFS client and server therefore do not support v4.1 mandatory locking=
.
> >
> > Forgot the footnote!
> >
> > [1]: https://patchwork.kernel.org/project/linux-fsdevel/patch/202108201=
14046.69282-1-jlayton@kernel.org/
>
> OK, this is pretty bad in terms of interoperability.... ;-(
>
> What should a Windows NFSv4 client (Hummingbird, OpenText, Exceed,
> ms-nfs41-client, ...) do in this case ?
> It basically means that locking for these clients will fail if the
> server does not support it... ;-(

The Windows nfsd supports NFSv4 with mandatory locking. Or use SAMBA
like everyone else.

Honestly, while your msnfs41client for Windows is impressive, the
NFSv4 protocol is fighting a losing battle against SAMBA on every
other front than Linux. Even the HPC market is evaporating for NFS
since the day M$ came up with SMB DIRECT, as SMB over RDMA.

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

