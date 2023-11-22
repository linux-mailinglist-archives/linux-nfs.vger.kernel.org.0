Return-Path: <linux-nfs+bounces-32-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC357F538A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 23:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70FE7B20D94
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E61C686;
	Wed, 22 Nov 2023 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5UpMt6y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB121BF
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 14:43:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso632552a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700693000; x=1701297800; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glZd7CIizrcnFVarqS4XLSw3nlB05Khtm3RISDTzB1Y=;
        b=k5UpMt6yglESw1pMMn8tAgq6QMQijxj1I1IOmxYrtUVKP5g9YewP1wewjaAF7kqfwB
         PekKk6QkJddHfA7jcInPUU1x0VXWq1ELocvzgskTkSSm0WneS1lediN9pRaX8tQ0zL83
         XIEhtJORzAchC/qRHmwZIZyZwUh3N1bqE1nG5axeFhB1escaSBBiOnqWPutOCHkFMDRO
         l69+u88b+E3Cjsr7bM+vXAC8QF4xAZMLVz6Vw71qJvCSgilUcc3EiQdfY5GG0rhip4nQ
         wswlJjocYRLsL8wsR2kURttA4Nm1SOp7jErd8oq1V+D099mOk8lJRtyPxg9iib3KvISX
         InTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693000; x=1701297800;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glZd7CIizrcnFVarqS4XLSw3nlB05Khtm3RISDTzB1Y=;
        b=J208sE9Yy7HgLy9Yud+CEBPdm//W/wELz0GMCw31M0/Ka4xdDT65+OCD4m/Ff7vKqt
         +UxeRSLBOj+IiFGz3GNWx/UBfo8WU0EQyCW74NrxY5pHEa4JMQYLszEou41zZc5OSsN6
         G8ismW7Q3b/uOFhXJ1SNwP5pzkE/CiMvwsPo9dNTetpmmIYL1DieyDckWAXl6O7btM31
         kMnJcSfzgtGXU4KE31Sg0rhBQ6LZa6QDnqd1t3pIkYENxOrirAae1BALwKVLpc23bbWS
         dyzWFo67Nx6P87avJHWApQqkkskdf9YdfTo7+Xss73vbidYn2JRIUF8icHcVWR9rF4SQ
         iJ+Q==
X-Gm-Message-State: AOJu0Yygyl0zc5L+8H6QshIOFugIGQOH0pTlTiFMOGFhYCzdo3spEzQA
	cryActchpL3ElIjeoISXQlbZJC36bCcHqXT3oXKwm4Qp
X-Google-Smtp-Source: AGHT+IEkcT0CEIRUStJDW0WHOTXCoVm6pcPWFj0FsymIs54h9IVv9hR2X6abnSiMqbek4+6JzoXen99kIPcI1AO3hPQ=
X-Received: by 2002:a05:6402:31ee:b0:52e:3ce8:e333 with SMTP id
 dy14-20020a05640231ee00b0052e3ce8e333mr781338edb.18.1700692999979; Wed, 22
 Nov 2023 14:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com> <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
In-Reply-To: <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 22 Nov 2023 23:42:43 +0100
Message-ID: <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com>
Subject: Re: How to set the NFSv4 "HIDDEN" attribute on Linux?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Nov 2023 at 12:46, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2023-11-19 at 17:51 +0100, Cedric Blancher wrote:
> > On Sat, 18 Nov 2023 at 12:56, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Sat, 2023-11-18 at 07:24 +0100, Cedric Blancher wrote:
> > > > Good morning!
> > > >
> > > > NFSv4 has a "hidden" filesystem object attribute. How can I set that
> > > > on a Linux NFSv4 server, or in a filesystem exported on Linux via
> > > > NFSv4, so that the NFSv4 client gets this attribute for a file?
> > > >
> > >
> > > You can't. RFC 8881 defines that as "TRUE, if the file is considered
> > > hidden with respect to the Windows API." There is no analogous Linux
> > > inode attribute.
> >
> > Can we use setfattr and getfattr to set/get the NFSv4.1 HIDDEN and
> > ARCHIVE? We have Windows NFSv4 clients (and kofemann/Roland's codebase
> > supports this), and that means we need to be able to set/get and
> > backup/restore these flags on the NFSv4 server side.
> >
>
> No. They would need to be stored in the inode on the server somehow and
> there is no place to store them. These attributes are simply not
> supported by the Linux NFS server.

Linux has xattrs, which are per inode, and can be backuped and
restored via tar --xattrs. That would be good enough

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

