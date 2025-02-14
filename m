Return-Path: <linux-nfs+bounces-10122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE0A361F1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC1E189173D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C91262D23;
	Fri, 14 Feb 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fbM3lcCO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA212753E5
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547523; cv=none; b=IPa79C1tM+sF1Wqz8EYW3QqUorP6MtPjox6cqpJEbGqsBBRATtmyDk77KuLs12gAR3m51saPIcyG3qm4BvCDrO0DDUiQ6HVnWbbC3mDu8kCyc6LziNUO1traQuy3oxPiUcs9H8ydxbkdwgkz/+SMUgtbPlnXw3aU3IIc3RyArY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547523; c=relaxed/simple;
	bh=qw31TBSAyhB0vzn065+b5wfgo+0zHEHpsAzSAvP7IBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJGIG5+WiFsGlv6Q8rsw4DyH4Fng+AXp0ZW4ZC9VV8MQjgSunXwGtEtRjQAb25rzh9Mlqw1aYv6GePnSGiE3Q8w68MnmuemErl5BSbbNAFEvHt9kk7Hl+9J58ML8lOX1ho85jfGcuqoBGIBaQhaGntZKI3jPF8onwpv5XrnQS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=fbM3lcCO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so22020911fa.3
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 07:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1739547520; x=1740152320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5mhxiRmMl60UU6RLLWyEr8+tWdymKFPZeGAsI0kU9M=;
        b=fbM3lcCODgBnq52Wxy6w8robmRUz0qbcBLilrR5cUevCBccsp9KPI/H5afSDvTtvzp
         6vswDz/P81QwPy+NYC5YcXE7UxnWYeG3qTh3fZCha0LcQ1YaXyaezhlXP8ncpNH9uiSm
         ZNo6PXxa2gcr2hYeCwCV7RH44OQsJUVWHzCCfjJHLELBYOAPyvooEbYYO2QoxHnYvgZv
         lRE4/yjsLxXu5MEz81KyLqw7d/dsgDuLqWjPlWyu6KF+4l8dgmznR8JAkn2+bqcVkbR6
         s1uESHFfS6EVXSsSW46P6QK5gn6+F9Vu8YVOkqf+0BB6uG0+p9YxW9ToENcmkYnuZ2WP
         QRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547520; x=1740152320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5mhxiRmMl60UU6RLLWyEr8+tWdymKFPZeGAsI0kU9M=;
        b=i5rcMmnIszkApZpaddf12IQCOHZU9yWor/teENU+25vdP9e/YpKHPDnD+59vadnV5X
         tMdibEg/lctnGCxhIQ8kRrjY1bMb3u/DibUiwluaMbaJqE/cmpel5DqHo/9+vZuLpmKU
         F7lYEUvQRtCc4/HRIkxX9/PF5FJ+mvZd9mfeJ5Z/kz7PfRtDG13rt+OMdBuq9xbuUF76
         FWj/kHvg80AaeuyE5rncEUsQib23Vmy65CiTiU2Xfy3LdC1cFKuyWIlkcc3Qsd6ou5xW
         vtRrX9lBOaec9akfOZbKq3I5k+3cXvUJx125+hjSaLYeZqUnO9lfWj1tLcx+xh5D95OR
         3yXg==
X-Forwarded-Encrypted: i=1; AJvYcCWLBYizJFiLTuXdpZCN8DNm3rm69P0wPoV45fJRidBax+kZfIZuHsTar2TIYOAqnCM/dppKOvwJjkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIpx4uzI4kl94Gy98pEshSwxD4qz4qh7z/qHIKs3SPqqXaXWH
	hpA9DoQwQBRhCinxDHbfbsf8smQ+t7ZDjOrqveWdyyYOGbLeKs8tlqN0pKTJYgnXlrLQ3LMHZrb
	UbxfiP+yB08HXV6unto5E6Dq64/I=
X-Gm-Gg: ASbGnctPaEys0ZNfEhCLszJNjivFWpGVT7nFvdeuGOX+z1I+Lo0LXHeQb2DqxamczJP
	Y8eXJ9lbPgg3YO/iTebagd2AMXwWQNqFijlqElK9qQEim/cAI25u3FDUBpveHyzPB3X/8Q0tK7a
	m8TmM9zmHQhCVDA4CPbxof7Vorw0W3TQ==
X-Google-Smtp-Source: AGHT+IFpqPIelr+UIjTBMdBf9u7G3iUyrFaB3PLelxjTFUblmcZzBBTn73DH6dOS8rBHnKlbtj32IyUpoYYrtojCc/A=
X-Received: by 2002:a2e:a80d:0:b0:308:fa1d:d833 with SMTP id
 38308e7fff4ca-30903927fa9mr51168601fa.37.1739547519289; Fri, 14 Feb 2025
 07:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213154722.37499-1-okorniev@redhat.com> <c65ebd14-f7e1-45a8-9bc2-211440977ab0@oracle.com>
 <CACSpFtDjqhgmFO=pTY1ErZEhQZNgewo9ao+RuuGY3hm9CSqcqA@mail.gmail.com> <3966bb3b-50da-41e6-b097-704c56154f21@oracle.com>
In-Reply-To: <3966bb3b-50da-41e6-b097-704c56154f21@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 14 Feb 2025 10:38:27 -0500
X-Gm-Features: AWEUYZkyLwWiAj4JaUDHWyDXH_keqmF1aIyhZNEoOHVVlRwssgK098sxI1Bt2n4
Message-ID: <CAN-5tyG9Z0yuCTSpG+-RCXXijt0q32XiLYFOvwhJXxcb=npkkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfs-utils: nfsdctl: dont ignore rdma listener return
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, steved@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 9:24=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 2/13/25 12:30 PM, Olga Kornievskaia wrote:
> > On Thu, Feb 13, 2025 at 11:01=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>
> >> On 2/13/25 10:47 AM, Olga Kornievskaia wrote:
> >>> Don't ignore return code of adding rdma listener. If nfs.conf has ask=
ed
> >>> for "rdma=3Dy" but adding the listener fails, don't ignore the failur=
e.
> >>> Note in soft-rdma-provider environment (such as soft iwarp, soft roce=
),
> >>> when no address-constraints are used, an "any" listener is created an=
d
> >>> rdma-enabling is done independently.
> >>
> >> This behavior is confusing... I suggest that an nfs.conf man page
> >> update accompany the below code change.
> >
> > Do you find only the rdma=3Dy soft-rdma case confusing, or do you find
> > that when listeners fail and we shouldn't start knfsd threads in
> > general confusing?
> >
> > It was always the case that if rdma=3Dy is done, then any listener
> > created for it does not check whether or not the underlying interface
> > is already rdma-enabled. This hasn't changed. Nor does this patch
> > change it.
>
> Not saying the patch changes the behavior. But you have to admit the
> behavior is surprising and needs clear documentation.

Sure we can document the behavior of the any listener on a soft rdma
interface as it's used by the knfsd. But is it guaranteed not to
change, as the behaviour is controlled by the RDMA core not NFS?


> >> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> >>
> >>
> >>> Fixes: e3b72007ab31 ("nfs-utils: nfsdctl: cleanup listeners if some f=
ailed")
> >>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>> ---
> >>>  utils/nfsdctl/nfsdctl.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> >>> index 05fecc71..244910ef 100644
> >>> --- a/utils/nfsdctl/nfsdctl.c
> >>> +++ b/utils/nfsdctl/nfsdctl.c
> >>> @@ -1388,7 +1388,7 @@ static int configure_listeners(void)
> >>>                       if (tcp)
> >>>                               ret =3D add_listener("tcp", n->field, p=
ort);
> >>>                       if (rdma)
> >>> -                             add_listener("rdma", n->field, rdma_por=
t);
> >>> +                             ret =3D add_listener("rdma", n->field, =
rdma_port);
> >>>                       if (ret)
> >>>                               return ret;
> >>>               }
> >>> @@ -1398,7 +1398,7 @@ static int configure_listeners(void)
> >>>               if (tcp)
> >>>                       ret =3D add_listener("tcp", "", port);
> >>>               if (rdma)
> >>> -                     add_listener("rdma", "", rdma_port);
> >>> +                     ret =3D add_listener("rdma", "", rdma_port);
> >>>       }
> >>>       return ret;
> >>>  }
> >>
> >>
> >> --
> >> Chuck Lever
> >>
> >
>
>
> --
> Chuck Lever
>

