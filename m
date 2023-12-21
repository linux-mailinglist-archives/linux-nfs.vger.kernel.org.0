Return-Path: <linux-nfs+bounces-725-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A18B81B5BD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Dec 2023 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5C8B21072
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Dec 2023 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D06C6EB4F;
	Thu, 21 Dec 2023 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGlcxPi7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6376EB4D
	for <linux-nfs@vger.kernel.org>; Thu, 21 Dec 2023 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-20439c8296cso34806fac.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Dec 2023 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703161602; x=1703766402; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekkHLTjfyo049Y6bsDaSehfLAR3N4hnXpY0RdbqIOjo=;
        b=gGlcxPi7qxPinhVIyXxubDxf+Pmxsss6MKtTcJXc75ctp8JwD9pWK4eCoi8sw5Y/R6
         nSMY3m+BMb1YfOsMia5k8FTMMBejJPfWzpXT3LWH5TaTdpqrHtQ6aYkZm5GGSpVvaWU1
         NLn0TLBxgFplBhc/q81x7TL+hh1MJE3GEHs7LRu7Dyyt4Vp/9BG9xHYarxMjd9EzwO7E
         9MlLKuNjbSNcyE4P9eR5iLzLyWTVrGMX1th6ocMy6G+gwcdVH4M36MxIZ9hkaQNajBIu
         wt07veDHThRUf4hD24Y+8+FGfVfwNx837FMKGZNXKvk9KUzLvoMZT6QAvegnICQEQ9co
         KIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703161602; x=1703766402;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekkHLTjfyo049Y6bsDaSehfLAR3N4hnXpY0RdbqIOjo=;
        b=E+Juy78wZtdXN2GN8CiqlY4sfPnaf38mCR5TydF3rgoMvSr9d/bPWChJ4nK5PNjKSw
         +6DPE0rE8z8NCYgN0jnNsKXXsxl49dQ7dO/Vqzp3/Kt27NeTsDqP4/4Fhq1K1JIJ4FKO
         FuoDr4tDT9gadt7UDIqRfSHsG+J1DfrSZNU+mf78QD2ivYdKDtYZeUEeXvYMcEpHnDn1
         g/TqJxeySQEbIqb2fCkTxMM5Q0zdD1QdjugAiDPnUENfydk2dP/adUA98nw9oAILCzcJ
         sMlRiCgv3gJxjQVV2NsgYYhjhfVVc+XI6cB2QdpoLqLSFfq3cOoy1bumlN4wF2CXfaUm
         hRvQ==
X-Gm-Message-State: AOJu0YxbHwPjPckLVThgTTZazKr2K+zQxIlrHom3m6ZxFhJjQE9X6jKv
	+/RamIJiyDLHWNznlSEMdwxAefO9XKJpN5E1rfCUBwf7
X-Google-Smtp-Source: AGHT+IGfJimiYcvu7ZNZWl2t8YJSjF/anr+r+Zdnp1HVwG56zUQR1gjbXHHs7yQaiboOTs4z+ZAwPK8YAev981f2lTo=
X-Received: by 2002:a05:6870:970f:b0:1fb:37b5:12af with SMTP id
 n15-20020a056870970f00b001fb37b512afmr1034043oaq.17.1703161602392; Thu, 21
 Dec 2023 04:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6PeiV+ba0uLVzAnbrA3WtG8VSkvjA1_epfLCVyH-r-pJw@mail.gmail.com>
 <DBD9B468-6FF2-4806-8706-EE679BF69838@oracle.com> <CANH4o6MGLTCYuDBZfyrDn7OpD=HcUG9KcY8Qhhv5mzHj4Jr03Q@mail.gmail.com>
 <3DF544D4-EFBD-4C0B-9856-91A3092A26B0@oracle.com>
In-Reply-To: <3DF544D4-EFBD-4C0B-9856-91A3092A26B0@oracle.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 21 Dec 2023 13:26:31 +0100
Message-ID: <CANH4o6OQgAVVs8chSxgw9mWsn9SC9_B8tZzTNDPNvGnT4naeFQ@mail.gmail.com>
Subject: Re: NFSv4 alternate data streams?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 3:49=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
> > On Dec 18, 2023, at 3:33=E2=80=AFAM, Martin Wege <martin.l.wege@gmail.c=
om> wrote:
> >
> > On Thu, Nov 30, 2023 at 3:03=E2=80=AFPM Chuck Lever III <chuck.lever@or=
acle.com> wrote:
> >>
> >>> On Nov 29, 2023, at 10:59=E2=80=AFPM, Martin Wege <martin.l.wege@gmai=
l.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> does the Linux NFSv4 server has support for alternate data streams?
> >>> Solaris surely has, but we want to replace it. As our Windows
> >>> applications (DB) rely on alternate data streams the question is
> >>> whether the Linux NFSv4 server can fully replace the Solaris NFSv4
> >>> server in that respect.
> >>
> >> Hi Martin -
> >>
> >> Linux NFSD does not support alternate data streams because none of
> >> the underlying file systems on Linux implement them. Very much like
> >> the HIDDEN and ARCHIVE attributes.
> >>
> >> I believe Solaris and their storage appliance are the only
> >> implementations of NFS that do support them, since they have
> >> implemented streams in ZFS.
> >>
> >> Instead, Linux NFSD implements extended attributes (that's what
> >> our native file systems and user space support). I realize that
> >> the semantics of those are not the same as stream support.
> >
> > SMB server on Linux supports Alternate Data Streams -
>
> I was not aware of that support. I need more information about
> how that is done.
>
>
> > why can't the same be done for NFSv4?
>
> I mean, yes the standard NFSv4 protocol provides a way to access
> these, and NFSD can be made to support that. But where would it
> store that content?
>
> NFSD can support what is readily available from the VFS API. If
> alternate streams were to become a premier part of the Linux
> file system stack, it would be straightforward for NFSD to
> support them.
>
> IOW first NFSD needs the communities responsible for the VFS and
> file systems to implement them. Everyone has to agree on how
> these are stored, we can't just make something up. Otherwise
> there is no hope for interoperation between local applications
> and applications that access these via SMB or NFS.

Yeah, that's a good one(TM). Seriously? You try to pull on a 'John
Reiser' on me?
for those who do not remember, or are too young. Once upon a time
there was ReiserFS-NG, which had support for that, and the VFS people
dragged him and his project through the mud for religious reasons.

The 'religion' here being that Alternate Data Streams are from
WIndows, and therefore this is BAD(TM), EVIL(TM), and SATAN(TM).Even
if someone would come up with a serious, technical sound patch they
would just bicker at the patches so long and so often that they just
rot. Death by a thousand cuts (or nasty review comments). Remember,
for faith people will do anything, just look up the "dark ages" in
Europe.
And just the tip of the iceberg, I bet someone will deliver the
argument that John Reiser murdered his wife, children and family dog,
and that's why Alternate Data Streams will never be part of VFS.

So back to the topic: SAMBA people just support ADS by sticking a :
between filename and stream name on the SAMBA server side
("filename:adsname"), and are happy with that.
Why can't NFSv4 do the same?

Thanks,
Martin

