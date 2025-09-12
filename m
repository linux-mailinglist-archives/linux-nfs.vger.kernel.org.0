Return-Path: <linux-nfs+bounces-14374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85311B551FA
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420E83B8618
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1630103C;
	Fri, 12 Sep 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJazg50J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113712FF69
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688096; cv=none; b=aKSoQb7rJtRoJJlP30o1WJkFlZKR1FtqjlYcYK/kPt1URFBPffRryLJ7fi+wOr1XJ1L6duFb5py03v0LrU99I7Aro5t6XKNyDBQnQcK8/gPIUrfoZp+HyIvAvE0QNMt9DMNDcIyN7zp6p3IL7auuWNR4ePd+jYjX8VDgvEyjbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688096; c=relaxed/simple;
	bh=f9w6RQpGRrSj1jCrlT68lDdz9x3i9jQTbYmatUsi6So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dakj4WIar/5nd7RnXg1dlkSJGYRQUZtGzRXUmdW4htfSlb9A6arPYH7JBF6NabPEjkYfSXzHLirUr/gcUOXuneASB3GhaVsnfvlknhGRK8hyVHBFXn4FWlWbOZvtZUmG7IuNIhl9NSDVjOqGYvIRt1GkNm0cV3Tm72WbiMLsX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJazg50J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757688094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WONQcovQXnhRjbuKpxWLj25SjPkeRT8zfIG1E25ximE=;
	b=IJazg50JcIMpqyeqnGn+Spd2y4m6MuZ2OmeuMJ0lZB+fDHqcnWfuzIjtJagGr3mwYGv58E
	7YYEMLKdfJS4bGr59+j3s8d393PFLQGYiEZ6qHTakWS+KglJY54oSfD9XcvH+gRrz0MGIq
	9uyke/5W1/d5Lm4bYVh+1BX1PTXjjGo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-TYvoZB5_OaiNSwZC5__DQw-1; Fri, 12 Sep 2025 10:41:32 -0400
X-MC-Unique: TYvoZB5_OaiNSwZC5__DQw-1
X-Mimecast-MFC-AGG-ID: TYvoZB5_OaiNSwZC5__DQw_1757688091
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b03e76a4538so216682466b.2
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 07:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688091; x=1758292891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WONQcovQXnhRjbuKpxWLj25SjPkeRT8zfIG1E25ximE=;
        b=LHtH4Efaod2/RSWTagRusUual96j+wEBcrVJog7IwEef9P5zufjEFgTZSz7VrdwCFj
         DkPujX/Fqmn3CCRF5pz7aHIWmu1HwE81s53oaF7hg1DH3C1h8QvXGDqdw0TY+4w00JpF
         HJmtjo0rD8ZzCC3GLXTB8pYvK9lEuP7I9nsQYeTCJGF4L78I1u/kMjUHQeUgmTYMN/mC
         JmmBjRvb28gMvLHyHwWl9p2zNFsHrMLrAc5Hdt9uDi8jMa5XJ5u+FDj1/71V4eeX62UV
         yvkk4ZSIeG/2gG+ffq2xY91AOpY442T4ErtFr9vmoL2DsdpKn9vF8zIFrEC2ZYLDTrEk
         BIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhDmdORY/cggYzmmt8tLshevKUi7Fot+BM3izuUrflIRVWbG8EuJ5sLw7/ET5nNB8SNEG0Vzn83Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPsvsI7feWWy4QmB92m7EkZI0uP1TTQmxigriWG11W6PMEOpQ
	R0xdTVFZVnDnJePPvTkWEa6Bj3nttsq1+wIGVgXxdl6wuR4E/F7bWXmmhyYUmihVZIUxViRoitK
	tjuTPG34qu0tdVZeA2lLTSpWrYsn8vG5GpP+6UA/HHHeoGQ2skNVEqtnuNEfGLI9T7gHVicxWEp
	skNfO2JJfjT64KhXmPlS/Hb/evCvqCi6H2ywXX
X-Gm-Gg: ASbGnctzLpax3BjFYIaIEVrhH74MiGXTbjKEtqrK2nu/YbkeittZmJmfF4JYCuDoooW
	9hZ48UhSUE6xMehZaLdelr5GHuOZXlGFM2yiqJ2bfy2rpGUHYVHVq63wj9rJJxEr3UIJOyxGMb/
	jiA7zxrjpI/Ds1Q35CXrw3OxmJ6B4Dm1Obnm9+C0eY0oHqUGfi3WdA1eM=
X-Received: by 2002:a17:907:3c8d:b0:afe:23e9:2b4d with SMTP id a640c23a62f3a-b07c365d4c1mr342978266b.43.1757688091311;
        Fri, 12 Sep 2025 07:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN7Y0NQjnOvt5etBpJJOV0F+uC7uzPVwPCFjABF/hcNSWaZsZr0p8BYd6qcvy02NozrBKutfzSGi0eLyh4q9A=
X-Received: by 2002:a17:907:3c8d:b0:afe:23e9:2b4d with SMTP id
 a640c23a62f3a-b07c365d4c1mr342974466b.43.1757688090810; Fri, 12 Sep 2025
 07:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811181848.99275-1-okorniev@redhat.com> <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
 <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
In-Reply-To: <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Fri, 12 Sep 2025 10:41:19 -0400
X-Gm-Features: AS18NWD4bqUYN7DbmAsSAqw32AZgx9zpPamJQylWde3_V9qCCpX7pCW3zDoF-CM
Message-ID: <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Trond Myklebust <trondmy@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, anna.schumaker@oracle.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:29=E2=80=AFAM Trond Myklebust <trondmy@kernel.or=
g> wrote:
>
> On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> > Any comments on or objections to this patch? It does lead to possible
> > data corruption.
> >
>
> Sorry, I think was travelling when you originally sent this patch.
>
> > On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> > <okorniev@redhat.com> wrote:
> > >
> > > RFC7530 states that clients should be prepared for the return of
> > > NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> > >
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/nfs/nfs4proc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index 341740fa293d..fa9b81300604 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
> > > file_lock *fl, struct nfs4_state *state,
> > >                 return err;
> > >         do {
> > >                 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> > > NFS_LOCK_NEW);
> > > -               if (err !=3D -NFS4ERR_DELAY)
> > > +               if (err !=3D -NFS4ERR_DELAY && err !=3D -NFS4ERR_GRAC=
E)
> > >                         break;
> > >                 ssleep(1);
> > > -       } while (err =3D=3D -NFS4ERR_DELAY);
> > > +       } while (err =3D=3D -NFS4ERR_DELAY || err =3D=3D -NFSERR_GRAC=
E);
> > >         return nfs4_handle_delegation_recall_error(server, state,
> > > stateid, fl, err);
> > >  }
> > >
> > > --
> > > 2.47.1
> > >
> > >
>
> Should the server be sending NFS4ERR_GRACE in this case, though? The
> client already holds a delegation, so it is clear that other clients
> cannot reclaim any locks that would conflict.
>
> ..or is the issue that this could happen before the client has a chance
> to reclaim the delegation after a reboot?

The scenario was, v4 client had an open file and a lock and upon
server reboot (during grace) sends the reclaim open, to which the
server replies with a delegation. How a v3 client comes in and
requests the same lock. The linux server at this point sends a
delegation recall to v4 client, the client sends its local lock
request and gets ERR_GRACE.

And the spec explicitly notes as I mention in the commit comment that
the client is supposed to handle ERR_GRACE for non-reclaim locks. Thus
this patch.

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>


