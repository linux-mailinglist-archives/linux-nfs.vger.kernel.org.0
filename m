Return-Path: <linux-nfs+bounces-4863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E692FB8A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7A31C222C7
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63BB16F289;
	Fri, 12 Jul 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6MpcMno"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F440EAC7;
	Fri, 12 Jul 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791433; cv=none; b=JMFl1jVfLTyyzeOCBWd8Q5kHFKPfDLHP2+roOTQV0uSfLQVM6E1YUQ3mXYR0tlJ1XLArGTkrUKj9nPtAKNFY8kfgJq/rgX93WP5vFDmeNDCf9pvGd7xxhsorBeG0HU6LrfPm8tJtTL2fYAW0RHZ9kSdyOdHnHismdtFqmStQoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791433; c=relaxed/simple;
	bh=CttNrZht+0JWLLFPnxN+4SUbc/HK7zu2FkWGFYiybN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAgTeWbw/gDnY9Qe4iuI4MWZl6bKjGTP8CJpy6PzDEjW2OUIX5bxm6xEtKQ/vNjkDmqe4MN4+pvTmE/5KdsTYJ9MSwZCUhOEyKzgXIWlfEUEkTvoplGyTEyWFYLrhGt2Jlw2krRQYZmQ5zHYOIMs/Pi4cYXs2PlY0cjpg4yAEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6MpcMno; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-659f781270dso25024837b3.1;
        Fri, 12 Jul 2024 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720791431; x=1721396231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBoU4/4ywJVwICkPeNb2aSx71mVRdrTpb1q0jnEr4MM=;
        b=O6MpcMnoOvv7vn5aDy7iVF1Fa2eQOj1U+j0EaigFZTC1WfXsp8gCi5SarP5aH46/zs
         d9uSl4SkmgBJlPlhiEXFDQ+ir/I7co+YqtbzQCjcjj4ozK9idCx1bBeBmzTRraflBzP8
         IKQ4QXn+E2VTFCuVsVxOmFZfw+1nJoBIzOOc0/P6wz7jZW404w7UJuBKr/TOY3MqX5li
         CIMVerl5kO+f2TFkgRSlnrsP5xXUfGbDxy2HGFgwXDBGM3cuqAPjgFAQmXJgbzo/sVsD
         9K77jGoLqwhMEUvU3Yze8L0c6Nr10/8auHgayqYA622nicRRUSZKR49Tjlhr3jhFQrEC
         LRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720791431; x=1721396231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBoU4/4ywJVwICkPeNb2aSx71mVRdrTpb1q0jnEr4MM=;
        b=G/Dx+/7E15PrYVX3tW7m1UXrz19HIGHMIWeiKFuVi/GMica7hxJ5SlewZX83LOt7Dr
         k1eeglvF4SMx5YhyGXc0Utw8TfiGkZFgNZlLa11zmh4uNsPsFfedKfQnNdK8gu58gML2
         1VCcxyGRs3hFJ2t8o32eV/YK7svFzEHFjeQQMVfuSd72rYsW/2oGKy9H7fK7KPc1DAqp
         F3l/utgTRYHCbn/Wcx0uqO/Wsds1xIgZcvnL6wEnD6e08wQoPuDiIf0tyKmBFsP7zXv3
         OnWgGmCEkTIpkULmIndecVVBzZtLE/GA9IGvyuMv74GOhA1Gp00dHKa5kPVwvkbbNtEC
         DkWg==
X-Forwarded-Encrypted: i=1; AJvYcCXCYdLq17klyro9/+PFT7AdTq/zrFrdp5wXFiUBojCChutI18syablT3hrUwz8bmF7c0WBXWAMpNkMtA3CN2cU74TTH91yNkPBY9rfVqWh9sFeIr4o1p+wQNjXWCOXLdYKIlgfYTSXI
X-Gm-Message-State: AOJu0Yw38LHZwORzrJU3p5Z9zUWjKIk+UFazjA3+VEHSt2uIBDAVvbAE
	CA951KWWNhrQHopOdPJKzrmYmFUWYMDw8lguTHO3TdnVzCu6aOTEmAQ7vx4Cz7yAepTvBaGXjxJ
	5tZ5fjBrypl/V0aAoOSMLf4359QE=
X-Google-Smtp-Source: AGHT+IFwAi6Ri0R8cmMFookaOb9j9MT0hOsxwl+Lbn/pltM+GfT7/u/HbU+Y1GiDNrqZS299N2O7JLlTBPLKm+hn7tw=
X-Received: by 2002:a0d:fec1:0:b0:640:aec2:101c with SMTP id
 00721157ae682-65dfc9bd4a9mr18951227b3.2.1720791431298; Fri, 12 Jul 2024
 06:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org> <ZpEwdJuoPFRE+sJ9@tissot.1015granger.net>
In-Reply-To: <ZpEwdJuoPFRE+sJ9@tissot.1015granger.net>
From: Youzhong Yang <youzhong@gmail.com>
Date: Fri, 12 Jul 2024 09:37:00 -0400
Message-ID: <CADpNCvZb+QZFErdeYt9v2QGXCqioRwJ9vjJf_ZCaypgUaOjQ8g@mail.gmail.com>
Subject: Re: [PATCH] nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's in progress, I will report back once it's done, most likely late
this afternoon. This time it will have much more nfs load on the
server.

On Fri, Jul 12, 2024 at 9:32=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Thu, Jul 11, 2024 at 03:11:13PM -0400, Jeff Layton wrote:
> > Given that we do the search and insertion while holding the i_lock, I
> > don't think it's possible for us to get EEXIST here. Remove this case.
> >
> > Cc: Youzhong Yang <youzhong@gmail.com>
> > Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease brea=
k error")
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This is replacement for PATCH 1/3 in the series I sent yesterday. I
> > think it makes sense to just eliminate this case.
> > ---
> >  fs/nfsd/filecache.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index f84913691b78..b9dc7c22242c 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1038,8 +1038,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> >       if (likely(ret =3D=3D 0))
> >               goto open_file;
> >
> > -     if (ret =3D=3D -EEXIST)
> > -             goto retry;
> >       trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
> >       status =3D nfserr_jukebox;
> >       goto construction_err;
> >
> > ---
> > base-commit: ec1772c39fa8dd85340b1a02040806377ffbff27
> > change-id: 20240711-nfsd-next-c9d17f66e2bd
> >
> > Best regards,
> > --
> > Jeff Layton <jlayton@kernel.org>
>
> Youzhong, can you replace 1/3 in Jeff's file cache series and
> test again please?
>
> --
> Chuck Lever

