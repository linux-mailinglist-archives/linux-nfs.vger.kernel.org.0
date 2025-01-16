Return-Path: <linux-nfs+bounces-9310-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF0A13DBF
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7DE1886081
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46D022AE55;
	Thu, 16 Jan 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXqjU318"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3C24A7F6
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041696; cv=none; b=suiwD5Lte16nVECprhXbivqdQckSzEqG1bFVzXhwL+HjsMOZCcE3kwibs9EtnmTmsWkf1er6AuWw0CxWssfBjJKKVeNLV3Mvpurv8vJlVlvEai13V09gCQDMSYSaf0srH9/syQtChIElExwkswpOc6rz2S1J+mor2sGRNApsN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041696; c=relaxed/simple;
	bh=9NQd9bOSgxd64gIMirq2tNi2m+/vB6+CfDFhCH/AWBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVle0Y4/0447MuLPD7C0MA0bzSwnTIO/LKcEeARPG/i5y6jXY5SDWZYfmvjE5opV12Jvh4wjEphraKebvFI5V+dnUlLTj+Nd5jxSot6zr8EpFPVqpUJVylRXeC5yk42+0mNUoavY3LHHNViZXImWiBq4zCIKAgbyKPxI4wNWit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXqjU318; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737041694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko1b+1xrU9oCU28xHm68XjLRBtyEbHCEKh42MNQqM+s=;
	b=BXqjU318btcvJYubMD60psMC/STrwMYP5niM6l3AAG6HLKWaH4f0PEWyN8kaH2SfWa2RCf
	o1Q+iINDGOle/kb/UI40xFUuozel6rTu75Hk1vkZW8ryNkHPVBX5mVVRwpmsngMDgT4y11
	rgz3CE6gMX9AsXNP0PFBoZbRRqJ5Els=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-YsCDQzewNpWasqW0tCf6vQ-1; Thu, 16 Jan 2025 10:34:52 -0500
X-MC-Unique: YsCDQzewNpWasqW0tCf6vQ-1
X-Mimecast-MFC-AGG-ID: YsCDQzewNpWasqW0tCf6vQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so967264a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 07:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041691; x=1737646491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko1b+1xrU9oCU28xHm68XjLRBtyEbHCEKh42MNQqM+s=;
        b=Td85OVyaJqgEbza6PBQJiIqhwGJzHWJfcg1nWljp3gqLbZHE30gpQSnpAOffuEAQw1
         vZLs/EIolgQp3sAwRvro4ti5EzNow701kjiuz4sCFS4bPXpdDWlAVLyIjiI6lwaOvXu3
         K5EwPHBzV1Pxv89I4O3ht/8jucpf1zqv6kHObWU3V52IVUyUMdehpki/67fT3puMgIey
         QMkK8epG3jFbsQ0bEQY4wjqFMiUbVw/t9MKNa/F2zg50DxCtVMqPY2uMJD8yFCrYOSNL
         pb0bnvtbp2c9UtR43EHx0ep8twN9rISvrsORFF9P5uYDVc4O/o22PITd5HipdaK/oBy7
         1k+g==
X-Forwarded-Encrypted: i=1; AJvYcCWCPo0pXVtVy1HvaIkc9dZ7u+2xzX3+8VEWUJ6SZG/i8IdS2c6Cu9SgMqCSDA0GSChHselnIZZb/o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAyC+FyughqZn5ETs+cSelBwMmn13VEz9mlkDpKCKGephRal7
	P4oI9Gfh+smu9dfhCE1ws7hE/6Z6nvp+erFQLoTdOdwKrcYQm9xiiZTv9n+2CP+3fHcqg4hzbds
	+zWP9QIKFaVeuvnwquLagEp2w84cbInCnBga99ypAo8ZudCehY9vysGxLOHCDywpup8g2ABAf6m
	zCDpVVR82hO/EEplrJPcbewdkRGkXtdqAD
X-Gm-Gg: ASbGncvOKtMMb3MJD78G1OmkoRbipcILp4lKKYoKAtBL9AGZNgBqsUNpLx+N+cArjY8
	6WMZR8ir0p4s09NuhHFuYJd3XNM7a6WQRrLa4CVwSL0WHMwfCV954fWAXkcIFKbP9IbOE+bfV
X-Received: by 2002:a05:6402:3549:b0:5d0:e73c:b7f0 with SMTP id 4fb4d7f45d1cf-5d972e70945mr79260367a12.28.1737041691401;
        Thu, 16 Jan 2025 07:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJRYk4/NKDK1eVNxtvOhaLg9OArdR29GCXOGAkC/7aiRl2+00cTR6oJ8XBMkKNbkFxTMLUhVsdc+g0zI2t08c=
X-Received: by 2002:a05:6402:3549:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d972e70945mr79260312a12.28.1737041691060; Thu, 16 Jan 2025
 07:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115232406.44815-1-okorniev@redhat.com> <20250115232406.44815-4-okorniev@redhat.com>
 <62d3ced2-8c90-4699-b3c4-c58489ec9f19@oracle.com> <62694be2aea08c40af7b0cea9d8c1b67a7b2cbe7.camel@kernel.org>
 <1db5da8c-6608-4f0b-967b-a7ba564af6b0@oracle.com>
In-Reply-To: <1db5da8c-6608-4f0b-967b-a7ba564af6b0@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 16 Jan 2025 10:34:40 -0500
X-Gm-Features: AbW1kvaPcckh0KFtLKr6Y2ZnWFVgUrv7nMWvfVN1M9a7-2psuMI2EclG87oQXNQ
Message-ID: <CACSpFtAWK-JWY5T9FK1m+2+s4Jecy1nJOrCtTUFZL7D6YdyO6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] nfsd: fix management of listener transports
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 9:55=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/16/25 9:46 AM, Jeff Layton wrote:
> > On Thu, 2025-01-16 at 09:27 -0500, Chuck Lever wrote:
> >> On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
> >>> When a particular listener is being removed we need to make sure
> >>> that we delete the entry from the list of permanent sockets
> >>> (sv_permsocks) as well as remove it from the listener transports
> >>> (sp_xprts). When adding back the leftover transports not being
> >>> removed we need to clear XPT_BUSY flag so that it can be used.
> >>>
> >>> Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
> >>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>> ---
> >>>    fs/nfsd/nfsctl.c | 4 +++-
> >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> >>> index 95ea4393305b..3deedd511e83 100644
> >>> --- a/fs/nfsd/nfsctl.c
> >>> +++ b/fs/nfsd/nfsctl.c
> >>> @@ -1988,7 +1988,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *s=
kb, struct genl_info *info)
> >>>     /* Close the remaining sockets on the permsocks list */
> >>>     while (!list_empty(&permsocks)) {
> >>>             xprt =3D list_first_entry(&permsocks, struct svc_xprt, xp=
t_list);
> >>> -           list_move(&xprt->xpt_list, &serv->sv_permsocks);
> >>> +           list_del_init(&xprt->xpt_list);
> >>>
> >>>             /*
> >>>              * Newly-created sockets are born with the BUSY bit set. =
Clear
> >>> @@ -2000,6 +2000,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *s=
kb, struct genl_info *info)
> >>>
> >>>             set_bit(XPT_CLOSE, &xprt->xpt_flags);
> >>>             spin_unlock_bh(&serv->sv_lock);
> >>> +           svc_xprt_dequeue_entry(xprt);
> >>
> >> The kdoc comment in front of llist_del_entry() says:
> >>
> >> + * The caller must ensure that nothing can race in and change the
> >> + * list while this is running.
> >>
> >> In this caller, I don't see how such a race is prevented.
> >>
> >
> > This caller holds the nfsd_mutex, and prior to this, it does:
> >
> >          /* For now, no removing old sockets while server is running */
> >          if (serv->sv_nrthreads && !list_empty(&permsocks)) {
> >                  list_splice_init(&permsocks, &serv->sv_permsocks);
> >                  spin_unlock_bh(&serv->sv_lock);
> >                  err =3D -EBUSY;
> >                  goto out_unlock_mtx;
> >          }
> >
> > No nfsd threads are running and none can be started, so nothing is
> > processing the queue at this time. Some comments explaining that would
> > be a welcome addition here.
>
> So this would also block incoming accepts on another (active) socket?
>
> Yeah, that's not obvious.

I read these 2 comments as "more comments are needed" but I'm failing
to see what is not obvious about knowing that nothing can be running
because in the beginning of the function nfsd_mutex was acquired? And
there is already a comment in the quoted code.

I have contemplated that instead of introducing a new function into
code that isn't NFS (ie llist.h), perhaps we re-write the
nfsd_nl_listener_set_doit() to remove all from the existing transports
from lists (permsocks and sp_xprts) and create all new instead? But it
does seem an overkill for simply needing to remove something from the
list instead.

> >>>             svc_xprt_close(xprt);
> >>>             spin_lock_bh(&serv->sv_lock);
> >>>     }
> >>> @@ -2031,6 +2032,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *s=
kb, struct genl_info *info)
> >>>
> >>>             xprt =3D svc_find_listener(serv, xcl_name, net, sa);
> >>>             if (xprt) {
> >>> +                   clear_bit(XPT_BUSY, &xprt->xpt_flags);
> >>>                     svc_xprt_put(xprt);
> >>>                     continue;
> >>>             }
> >>
> >>
> >
>
>
> --
> Chuck Lever
>


