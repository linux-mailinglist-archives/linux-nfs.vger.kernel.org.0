Return-Path: <linux-nfs+bounces-3211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD688C02BC
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 19:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326441F231EF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF561CD25;
	Wed,  8 May 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtXfsIYo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2058828
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188414; cv=none; b=g7U80CDW4h+k77Ax50aX9K0/pUA9Mwk5ivDSsoeFo4D95KduwAeJLI5w2JW2mZo2udc474DUqbjn8gwJh86csMLyxZiwm1HMOdhOnk1Qqywrw38KeZT/+rDQ4+onLeMnjYmArNFxnAuoBTxA1gaxdkvtRnlxCu2KxLq84ftf4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188414; c=relaxed/simple;
	bh=jbC0deGrh1mX2nBbGJgbymNMhiVcONf9P4/vgL4Eb1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPf4n727ukPuOHWc8ynEPrjLAjYnvJo1SCe8GeWHWXCy33KQmjohO40xxP73DvI02PtGAKIJwh6Mssqvb1RxIeRz26m3hKl0U0Lx8kG+3AzUmqiyS9wVvrfOE1VOWoILcE33URyPAh/DADPegUzWHq1nX7IEXCn5xBky+8fm2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtXfsIYo; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e20a4e9d96so1734081fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2024 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715188411; x=1715793211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRjKbfUWxByuhM30dA+5QXkVVC8R2zWlFHP5VmzbL9A=;
        b=PtXfsIYo7/acAvslI7HE+J0Z/MLa/1ESQ6rAUyKtJaTDmAavnJ4PcEUyfYJcqaAm2l
         lluuDquHwJD2gxzun8+wrot0YV7nfue3pF8G3akEIx4yE9d56gihTLWHCUOYAzb5qFhR
         74JO3jULUu0BuJdeHSVwe1aFqmuxokNMfnfNd3hGM3bWMF4QWG1t8WCQ2r9remmPW/fd
         f35MfWt1xhk1Z0X3NV+nXj9z0eJXfidPqQQ75ETSFUloVXSZI+6hsT3aTN4AmzyKsBya
         EfSbN1imEV19Q6tOdgMRD0qqpzAlEZw6e16Zn3HexjyC2/4tEyh5bS8mTastIClJRTwz
         6JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188411; x=1715793211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRjKbfUWxByuhM30dA+5QXkVVC8R2zWlFHP5VmzbL9A=;
        b=uf8r3AYX+BNJxwCVZyCI1ypieQ7X0qWVd6F4hlrDSqzrvBtlU89z5KbLSa60ud9HMZ
         7CH7g3JVMGMKsCtEnoHS1nTDnAo4TdGTFeEoD+8Go+SnRqx8XZGLmj4vhEncxItn1MFC
         egPnfiDoOM1qCnv6dY0lD4bDqI04GOJ5DFQ+4ThnkZSuzgmkPHn0hkiN1BItKumn87FX
         EBOTICi6xGDp81S4LqF+hDOhv6mZ4GDR2lUdaJtHKPBnrDPrVpEvlok3aMgdMpBkX4DS
         /DkJMCvAwOS5MCDaCdAlbux17GVZrSlZF7U9NzqdgilzU3gqry3PmVCrcPdlC1kUFcpu
         Wj8A==
X-Forwarded-Encrypted: i=1; AJvYcCUX8fnfk4wIKMmisFOMeIfFu9xNxnFpBw+IMXebmltjeViIR++EOW8wsdXhFn/CukI4aF/mWBYQEzfxEhXOZGsIpkMDuRBMOr7l
X-Gm-Message-State: AOJu0YylvVnQ5x44JupKFvcg/heaiSxNjRewrgyWC5U0PMLOKb4CZpwQ
	Ku+1oQnbS3Ocf6lBNc5hNGKajF4EkIrUbmbfLsdV34dRyDCaLn9yFMTZNSc7lzbs4kNI1VmKsPY
	IkmV+sjuBU2Kws10rHbDpOUJT6Eo=
X-Google-Smtp-Source: AGHT+IHuJpZ66Q0IiLP+a2BVV4SVy+ix1rPdyLyNA39yN1oUzAea3cBNqoycrtkzMxIzfMBesxZPRDX8ZPzCahC1a9g=
X-Received: by 2002:a2e:9610:0:b0:2e2:1647:8308 with SMTP id
 38308e7fff4ca-2e446e7ff6amr19553421fa.2.1715188410589; Wed, 08 May 2024
 10:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507151545.26888-1-olga.kornievskaia@gmail.com> <35158E21-2724-4C1A-950F-5A6A616C862A@redhat.com>
In-Reply-To: <35158E21-2724-4C1A-950F-5A6A616C862A@redhat.com>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Wed, 8 May 2024 13:13:18 -0400
Message-ID: <CAN-5tyGNaWsfxo0dCGc+hW36Q9jSZXaQZgvHTOw5gGQ_HDxFqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pNFS/filelayout: fixup pNfs allocation modes
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 11:25=E2=80=AFAM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 7 May 2024, at 11:15, Olga Kornievskaia wrote:
>
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Change left over allocation flags.
> >
> > Fixes: a245832aaa99 ("pNFS/files: Ensure pNFS allocation modes are cons=
istent with nfsiod")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/filelayout/filelayout.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelay=
out.c
> > index cc2ed4b5a4fd..85d2dc9bc212 100644
> > --- a/fs/nfs/filelayout/filelayout.c
> > +++ b/fs/nfs/filelayout/filelayout.c
> > @@ -875,7 +875,7 @@ filelayout_pg_init_read(struct nfs_pageio_descripto=
r *pgio,
> >                                                     req->wb_bytes,
> >                                                     IOMODE_READ,
> >                                                     false,
> > -                                                   GFP_KERNEL);
> > +                                                   nfs_io_gfp_mask());
> >               if (IS_ERR(pgio->pg_lseg)) {
> >                       pgio->pg_error =3D PTR_ERR(pgio->pg_lseg);
> >                       pgio->pg_lseg =3D NULL;
> > @@ -899,7 +899,7 @@ filelayout_pg_init_write(struct nfs_pageio_descript=
or *pgio,
> >                                                     req->wb_bytes,
> >                                                     IOMODE_RW,
> >                                                     false,
> > -                                                   GFP_NOFS);
> > +                                                   nfs_io_gfp_mask());
> >               if (IS_ERR(pgio->pg_lseg)) {
> >                       pgio->pg_error =3D PTR_ERR(pgio->pg_lseg);
> >                       pgio->pg_lseg =3D NULL;
> > --
> > 2.39.1
>
> Looks fine, but I didn't think you could get here from rpciod/nfsiod
> context.  I might be missing something, how did you get here from there?

I have to admit I don't fully understand (if at all) the implications
of having the wrong flags. I also don't follow what you mean by this
code not being executed by the rpciod/nfsiod context. This code is
done while doing (buffered) IO and performed by the rpciod context?

In truth I was making it consistent with what flexfiles is doing for
their pnfs_update_layout() usage.

>
> Ben
>

