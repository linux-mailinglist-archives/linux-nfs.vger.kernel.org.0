Return-Path: <linux-nfs+bounces-8174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D89D4B0B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 11:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B812868EB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E8227447;
	Thu, 21 Nov 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+y4EG4M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCE13AD20
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186047; cv=none; b=U1CryEVZdD8JvEJEAz8GNVDk3QeiySe1v7T7MB8rZxMu6fu1hG8WqbxD5AsNP0B8LIswn4bhaLvsyncb4VRUdHw3EXqETFLJRPaCK8lw3zbRPs4y0TKXZsVg8ofFQjAd4ObYKCuqOYrQJSiEmIcRYdj3tqZI8okMh4k4BoqQOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186047; c=relaxed/simple;
	bh=wGsSjmRw5351aQq0gy/hUuOB3L4yQnIQpXaTEv+3mxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QHi9Eqnppt3V6Ui2dkgktgoJkQx8/fk+PKVh/6ATcJW+NhwBImRYcCXiPtLsq7zY1hHXC+FGZJx7z8qDWkfCPK1oVPHSe8MUweNl1wYceqeq+NqPqxoseCrDY6m58fxRCIDPePyufkgUmLV+dfXi37E1QcJGyqYA9XaCcOYX+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+y4EG4M; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ed49edd41so137006166b.0
        for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 02:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732186043; x=1732790843; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGsSjmRw5351aQq0gy/hUuOB3L4yQnIQpXaTEv+3mxk=;
        b=g+y4EG4MHBQCWRf2sJpuBNCNtssy2CMmsRbZayuCDxFf5jOex2tUvlcPaSYUjZQm0k
         +NUgUr58xG+37tBXB5+st19ZtTkGFP9vndOmZ9S9dn1yq2VbjP/A4TKKCHAzQk/jPLqA
         nwg8rCRXUk2nqTdWlZ2QLA3BYDkYms0ujOPAVKyjxhG/9QgXQ5lM/cymAemAd16l8zGa
         PM5eg85Jd7Dji/8pWM7YCTnCPP0OVLrec6LYZOF3CZOP+U1smZVlhjD69Qo/fkiT1Dew
         lD7bcrIYt4+LtgVUExHM5f5EhZSafNg1SUTH+9ziAKbUTzRfvT34K7QyPc32+V7Iv6YS
         65tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732186043; x=1732790843;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGsSjmRw5351aQq0gy/hUuOB3L4yQnIQpXaTEv+3mxk=;
        b=BwTdTT8o6i2Omw+oUlFfbKv1VI3MhPKrmkDBvE7iBezPIMD6u/QKpgLSjTWrmAqwiq
         zUTw7It9PP4HW9sMYUI5a6/yV2uwH+g/1lSm0eq2bsLgAVVxlF9sE58aHHmE1IDFnBu9
         ooPeKH75/f+5e5hxyMi8mgTtoWJ5GMgVeK1fo2VUSRUQmIGNsc/hLE6eGpT8Rtw83AcD
         CJJcAsFkZotdKjTfSIE20coAWzp59CCtR5TR1gFJqEhxiI9ZMA1Y6YHIlob5ZGq3yw/J
         mzJRaj/8JiqoP3A+fbPJ8nv07fMcn/HKd8K0/ufQh8Z+sSo4DVD5wUvjVvhIVxbuiEbw
         BGNw==
X-Gm-Message-State: AOJu0Yzjy7VdsebvMc9SxxGpe7Ma20oH2ABvsVvGkIQUhNk/tS2F/4DR
	SUWRqJ/e8b3oxKJnlaRY8q6NBoPUGyi2QVGmlwZsKxFl6t6beDrGW63vqCSjofuXOfSaURQdenK
	eM7p1S3OXnE6Qs+s0r/oFh9Id1AnLCA==
X-Gm-Gg: ASbGncuTQDch/NTjZrZe0VH2+U3I3ZclcOyQfew/dZkpgOwB+2Fdghe26RyiHJjtL2m
	K3Ck+7MJk6Y639KbSxONwxxila4nIFfNj
X-Google-Smtp-Source: AGHT+IHw4oE0HaMRwx5xArBj5hHlT34TxAaC6iUmo3iCp5DLb5HxWySezR0AvRWiX9pA5Zsrnc6YKugHujFFkRvWSFc=
X-Received: by 2002:a17:907:da7:b0:a9e:8574:e154 with SMTP id
 a640c23a62f3a-aa4dd749ec1mr612216666b.59.1732186043308; Thu, 21 Nov 2024
 02:47:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6P-jze6MB8yh3sWxhyHJWdj+JHK3vw58cYwQ0a7eVe_Vg@mail.gmail.com>
 <c397fb11a172be26111e1ad5cb17a92bceb065d3.camel@kernel.org>
 <CANH4o6O-Gcjc3eqiTd-KysZx-bpbzoh=CMTNixJ26cZQuRd=UQ@mail.gmail.com>
 <2e4760a87e1fc6906562442c27933e830635a929.camel@kernel.org>
 <CAENext6Zuv0pLgzp_vcBqdKmrH6Bg5GDV_hnUNOeFK2juoiJnw@mail.gmail.com>
 <7e499dd1deafcf043229973968920947453d4eba.camel@kernel.org> <CANH4o6OmdiGDUjQd25Mza_bZX6zq5Vw85cD9X4RexWSQqxY4NQ@mail.gmail.com>
In-Reply-To: <CANH4o6OmdiGDUjQd25Mza_bZX6zq5Vw85cD9X4RexWSQqxY4NQ@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 21 Nov 2024 11:46:00 +0100
Message-ID: <CANH4o6PSqzL001QdQCkQ6GgxyuX5tyO9-UZ48SenSuXk5C5CGw@mail.gmail.com>
Subject: Re: SELinux-Support in Linux NFSv4.1 impl?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

?

On Mon, Feb 26, 2024 at 8:30=E2=80=AFAM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> On Sun, Feb 18, 2024 at 3:35=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Sun, 2024-02-18 at 16:16 +0200, Guy Keren wrote:
> > > On Sun, Feb 18, 2024 at 3:55=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > >
> > > > On Sat, 2024-02-17 at 14:37 +0100, Martin Wege wrote:
> > > > > On Wed, Feb 14, 2024 at 12:28=E2=80=AFPM Jeff Layton <jlayton@ker=
nel.org> wrote:
> > > > > >
> > > > > > On Wed, 2024-02-14 at 10:46 +0100, Martin Wege wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > Does the Linux implementation server&client for NFSv4.1 suppo=
rt SELinux?
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > Labeled NFS is a NFSv4.2 feature. The Linux client and server d=
o support
> > > > >
> > > > > Is there documentation on how to set this up? Will this work if t=
he
> > > > > root fs ('/') is NFSv4.2?
> > > > >
> > > >
> > > > There isn't much to set up. If you mount using NFSv4.2, the client =
and
> > > > server should negotiate using SELinux (assuming both are SELinux
> > > > enabled) and the SELinux contexts should (mostly) be projected acro=
ss
> > > > the wire.
> > >
> > > Jeff - as far as i know, while it is possible for the client to
> > > get/set the secure labels of files on the server - there is no way fo=
r
> > > the client to tell the server which user is performing the specific
> > > access operation - so the 'FULL MODE' of nfs4.2 security labels canno=
t
> > > work - only the 'Limited Server Mode' mode (i.e. only the client
> > > verifies the security labels - the server does not). please correct m=
e
> > > if i'm wrong.
> > >
> > >
> >
> > (re-cc'ing the mailing list...)
> >
> > That is correct. I'm not aware of anyone having implented "Full mode" a=
s
> > of yet anywhere.
> >
> > The Linux server is a "dumb" labeled NFS server that just projects the
> > contexts to the clients and doesn't try to do any enforcement.
>
> Is this documented somehere? "NFSv4.2 SELinux HOWTO" maybe?
>
> Thanks,
> Martin

