Return-Path: <linux-nfs+bounces-41-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775277F68F8
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 23:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED0CB20D4A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 22:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276B2FC4D;
	Thu, 23 Nov 2023 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0P3UPJF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0AD54
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 14:24:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso2555841a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 14:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700778287; x=1701383087; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rS+ZT5gaJ5yvIQzvCz3jgrZtzMx5EgZ29ewKN1kM0iI=;
        b=g0P3UPJFCWfXvOMQEW++vkqV9/1ksCFdTuqc0t9LraW3CHvVcCCdTzH06o3jPOdqAo
         /AKjl3Ngp5wh39XVnyLMhLPXKN2wQ6sBjL0/DlMmxdMtWEVMLapneroMTO2ZGW30wMFw
         LI/Ve6NVBFKwsZ56dECA9D6fwYfvrW2kfb3KZOrCY4wJJRBzfvoT9CUQ+PR26Ak06fjH
         Rpb5DN4+v6gq4oWX7xgtIhVvfCUAZZbgq+EFoSUtSrTXrgbwV/XF+/as7HAz7TyjPCKS
         PTnQgJHiYXQ2iADtlIoNdWEnjCGV2oky0twUpWPmPOwAmC0PFE2DL/NSEYS/yoF5FD4Z
         iTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700778287; x=1701383087;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rS+ZT5gaJ5yvIQzvCz3jgrZtzMx5EgZ29ewKN1kM0iI=;
        b=Mc5IScyKQledFKJZsaax3f0IkbUn/9bah1wupLeCIRfoKY5uasCGRnfZ0NOXimhrst
         t8cYQH++cY8AKiuzblPp7JZPOdkaSeP+hR2Ya7NdYK2QhKsXktLRTbjDvkJUyIfC0YNd
         +0NIqOiRgWiodMQ5ASNqi1IvLAIgDw6GARTQzUT0W74q1QuIby2AUS8CDaOAuJuXQ9u7
         /0liiTnI1NlT7wUjA3+Tn7TDIvCBnWh9QMa7J2oQoqpv0HaqBeq3zlnqiT2F5d6YUZCo
         I+iHJGAIRWNXy0PX+O9B6//BJCItGYB7IEvBU/pZpDFxdnX6pJRcIYOKChLEGYCKew7s
         Wodg==
X-Gm-Message-State: AOJu0YygCl+717jaojbw+sm/7rLXxJmLwMaEZh6LQMJMHTMLhh/JyIDI
	mpJlnyZtRST2Lus14YxbveHZRnlyeiL5g7t59rpqxsqo
X-Google-Smtp-Source: AGHT+IG5CINGpBaBr/2vwOqvyDL+HconF3Rbdadk6YpI8NOXQ9MHqr/6FSghEb1kxJE95nTmDtjscjxETNFQiO5Ta4o=
X-Received: by 2002:a05:6402:2d2:b0:533:5d3d:7efe with SMTP id
 b18-20020a05640202d200b005335d3d7efemr3791624edx.6.1700778286555; Thu, 23 Nov
 2023 14:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
 <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org> <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com>
In-Reply-To: <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 23 Nov 2023 23:24:10 +0100
Message-ID: <CALXu0UccoNs0A4MjQH7gPboarWyZcRQzsy2zJRxk51LR0hGDVQ@mail.gmail.com>
Subject: <DOT>foo gets NFSv4 HIDDEN attribute by default by nfsd? Re: How to
 set the NFSv4 "HIDDEN" attribute on Linux?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 23:42, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> On Mon, 20 Nov 2023 at 12:46, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Sun, 2023-11-19 at 17:51 +0100, Cedric Blancher wrote:
> > > On Sat, 18 Nov 2023 at 12:56, Jeff Layton <jlayton@kernel.org> wrote:
> > > >
> > > > On Sat, 2023-11-18 at 07:24 +0100, Cedric Blancher wrote:
> > > > > Good morning!
> > > > >
> > > > > NFSv4 has a "hidden" filesystem object attribute. How can I set that
> > > > > on a Linux NFSv4 server, or in a filesystem exported on Linux via
> > > > > NFSv4, so that the NFSv4 client gets this attribute for a file?
> > > > >
> > > >
> > > > You can't. RFC 8881 defines that as "TRUE, if the file is considered
> > > > hidden with respect to the Windows API." There is no analogous Linux
> > > > inode attribute.
> > >
> > > Can we use setfattr and getfattr to set/get the NFSv4.1 HIDDEN and
> > > ARCHIVE? We have Windows NFSv4 clients (and kofemann/Roland's codebase
> > > supports this), and that means we need to be able to set/get and
> > > backup/restore these flags on the NFSv4 server side.
> > >
> >
> > No. They would need to be stored in the inode on the server somehow and
> > there is no place to store them. These attributes are simply not
> > supported by the Linux NFS server.
>
> Linux has xattrs, which are per inode, and can be backuped and
> restored via tar --xattrs. That would be good enough

Also, it is legal for a nfsd to give the DOT files (/.foo) the HIDDEN
attribute by default? Right now on Windows they show up because NFSv4
HIDDEN is not set, and it is annoying.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

