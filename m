Return-Path: <linux-nfs+bounces-2352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F6387DA42
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Mar 2024 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F78F1C20AE1
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Mar 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43817722;
	Sat, 16 Mar 2024 13:16:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3F2F28
	for <linux-nfs@vger.kernel.org>; Sat, 16 Mar 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710594994; cv=none; b=HI4PAyJB0TOI5XsMuK8cCYKSa2U2fM+0qfNNBWf98FC2YhQC6OQDvW8eO5gVfh4dJw/pnkWqZ89EGN1wbcbdc2cqgHryO6C6U0GKy6MkL5LOHEhNojNndAZFjelYf35Yr+9cyyDNn4OJ+ePViHdVI6s1VuFudDECI2UCBEg+YgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710594994; c=relaxed/simple;
	bh=bqDBRIfu76MYGBAuyLr7sbpJxHAFws3zgRxiGWaIy8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iKSLD/gJtkFzL2p4kID2wPcDtpUeAkqMt9EdmOb7zE3bRGgRvBXUlMUiCgJay5lkZYISKQETUHK7Y00WwWPnOVzmRV0WRdF7nLiot9O6G4TCjgiXycZNdgz1L8VDuE3NfJUdBru4n4QcnorLz9KKpqF0Y4ugTURUFvVYMwF6oM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36683ec014dso10505335ab.0
        for <linux-nfs@vger.kernel.org>; Sat, 16 Mar 2024 06:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710594991; x=1711199791;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4WX/p5mi3jg1RU67rMiHxqlbkaU6dpoldZXS0LldsA=;
        b=rJD8EHpG3eFNI7LbUcP2PDbUjDHDNHO3lyFfhPgnnonw4lKMjmoLl8irRLVUC5tyXH
         Z/CVjyPbVVP4rOq5AqwVtNNzhtNTawGtNAUpLx1Xm8bMMcxRiIfTWqtZQdX+jB3zrs7U
         OszgTkQNL4n/0n/VabI/rJ2Z22L0eYsZf8juU+iNiCCar2iOqWZ3N7srBOO4pzqEVUz1
         TdgbtrMdlOxs5c6sDZN1OLSYr/NJXHaIUsL03rJCx88iyWKhfG602d7r4p60iYmRJtt0
         IQ1D2pmyoPsMxXbFsuD2hb4e0jrll55znebftTO/Ju9DFK9zvBgxn+T9weGWbDqdiNoB
         aSIQ==
X-Gm-Message-State: AOJu0Yya3Vv27cky9IpWJm+ME6ZKFv+V0tJofev0tEKD+pTGLPtmCWiI
	L9nz/tJICbMIS/s7gDOktEm3S6McIicLhvA5PFVHKVYOaBpiJM/07+94gGghs1eqlHcSEZnowNw
	CoIzIfqs3Dxzt1jA7ZlPMYGaBib29p/l8
X-Google-Smtp-Source: AGHT+IHn9owEXoQI6NW4EExT3JXp9casA/ctawJhisM/seyqS5uG6PCkuQ6ypPMCkmNwu/TR7tFE759yy3xdu8JKX3M=
X-Received: by 2002:a5d:9a16:0:b0:7cb:81c5:a8a8 with SMTP id
 s22-20020a5d9a16000000b007cb81c5a8a8mr6144530iol.20.1710594991118; Sat, 16
 Mar 2024 06:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com> <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
 <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com> <CAKAoaQny6G=JcKpJTYeLmNBEMgNkkc--T0Uvs1YbEX+JUD-PoA@mail.gmail.com>
 <CANH4o6NcMbcNKxARcqhthXWkKk6_r31iKGjnS-RhFBB_AJFaJg@mail.gmail.com>
 <470318C6-3252-445F-94F3-DDB7727F84C7@oracle.com> <CAKAoaQ=6nGHD0uA+9EaQQPWBk8dvq0XVUPPgPAhbh=XPk+ecSg@mail.gmail.com>
In-Reply-To: <CAKAoaQ=6nGHD0uA+9EaQQPWBk8dvq0XVUPPgPAhbh=XPk+ecSg@mail.gmail.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, 16 Mar 2024 14:16:04 +0100
Message-ID: <CAKAoaQ=K7wQoZD7LAsYm2OCB-AU-0yyhJcch8voLr5_LC721CA@mail.gmail.com>
Subject: Re: |ca_maxoperations| - tuneable ? / was: Re: RFE: Linux nfsd's
 |ca_maxoperations| should be at *least* |64| ... / was: Re: kernel.org list
 issues... / was: Fwd: Turn NFSD_MAX_* into tuneables ? / was: Re: Increasing
 NFSD_MAX_OPS_PER_COMPOUND to 96
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 12:55=E2=80=AFPM Roland Mainz <roland.mainz@nrubsig=
.org> wrote:
> On Thu, Jan 18, 2024 at 3:52=E2=80=AFPM Chuck Lever III <chuck.lever@orac=
le.com> wrote:
> > > On Jan 18, 2024, at 4:44=E2=80=AFAM, Martin Wege <martin.l.wege@gmail=
.com> wrote:
> > > On Thu, Jan 18, 2024 at 2:57=E2=80=AFAM Roland Mainz <roland.mainz@nr=
ubsig.org> wrote:
> > >> On Sat, Jan 13, 2024 at 5:10=E2=80=AFPM Chuck Lever III <chuck.lever=
@oracle.com> wrote:
> > >>>> On Jan 13, 2024, at 10:09=E2=80=AFAM, Jeff Layton <jlayton@kernel.=
org> wrote:
> > >>>> On Sat, 2024-01-13 at 15:47 +0100, Roland Mainz wrote:
> > >>>>> On Sat, Jan 13, 2024 at 1:19=E2=80=AFAM Dan Shelton <dan.f.shelto=
n@gmail.com> wrote:
[snip]
> Question is... should the values for |ca_*| be a tuneable, or just
> increase the limit to |80| ([1]) ?

Actually a tuneable (which defaults to |80|) would be good, since we
have to test against different configs/kernels anyway, and a tuneable
would help...

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

