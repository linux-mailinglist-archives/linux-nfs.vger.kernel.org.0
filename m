Return-Path: <linux-nfs+bounces-3856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8E7909AA9
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jun 2024 02:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB11F21B5B
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jun 2024 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9221843;
	Sun, 16 Jun 2024 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS+5SbTP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78387E9;
	Sun, 16 Jun 2024 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718496984; cv=none; b=m54HqdJk/k3yTGxCJECFi62MWPUBKUN2h8sd+vs54K9uZX+HhFFofBr8QHZl7N3pl5KH7zuM/7D5nvV98zSuTYDVj1BWK8MEIIgVa4QkeyoFUwxCtBm9aPZ3hjzI7pgw9aHD6DKm0f83PXxALeENWohjAMOXQXEYzYXyXS/0Yvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718496984; c=relaxed/simple;
	bh=dkkZk5Lo3ZMwCnI5+EQ/sbfq9CY8aBBxsIc2OW2/aKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWu5gK2VwN8uv7FkHk46LQvvkrmJ73B675pzC1f72PQ3/zBRsw1B73tO++WTlwmMeSnbwsevMCnl/26iDILOv2kFBab230aFx/VGF5fEKxaEWJ/NvSNyF+bgk0xa2aHabF5o9DZ50jxXqYy5qsBTKoF9mXFmDDOwRFjEeCFt9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS+5SbTP; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4ed0ab952b0so1135655e0c.3;
        Sat, 15 Jun 2024 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718496981; x=1719101781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePwlJhT+ySjqTc7dIZoR+hHEU/OIMFdQjcBXDYeBNtQ=;
        b=GS+5SbTPog6N23f7X72MIi05qvsZ7r7E8twO52fnfUlQOWrKczMUGa/vLDP4ur+mfR
         1Qpyw5vL2WhUpbBr8ilEMGYCvDItOer5Y+bg0s1F/OIOCkLjDzDgYE7liudlzuRjSK0a
         pxOLfSlldcBC4G9gQ30UPMsHMuFweecxfrlUsCG1iDXKz9zuFvzdc0vAEPaF02i/K11p
         vNbvTPippC6yN8osxz92f2sONiXrAo/ifU//93SZsfZLLW6MZJovTczmd9tsnz/AQQhh
         uYnuDJZd0o1T4nYUH9+t6zgGg7d+Pel231mKbCyFZJVfdgjXuO9A+xFEc1pkfUwgZnHz
         CjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718496981; x=1719101781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePwlJhT+ySjqTc7dIZoR+hHEU/OIMFdQjcBXDYeBNtQ=;
        b=xQWGS4xRnHRX4KeWNef+HC+ZboEVI70kEk5ACU0/35iIN/vtrF6q8KZlIHPPhg4stX
         nbEzbE7GPE+Bq4/rAp6vA7hEfagb//qQHGmGu97HAwfmsWqAvQ53OMpZYBqDpuf1v0pP
         safnyUE+L2A1gGxSXVm5zllYLK0lWeUTOJ0PDYS80UYBl7QzDwBxWEgX5E1mnEVYnxLL
         eL4Qd5AR9YyKwub1x1FZ784i+9kacTzbsWTBePdaIhbnRyH239QDvo/bSsGUORd70F+3
         OmyfYA2ZEKTWFYJvkXbLAVeQSecek4xbOv+MBqMeO/y3EpzmgZbPjJllwN+Dz8Ea9dK+
         U4AA==
X-Forwarded-Encrypted: i=1; AJvYcCWKRe3dli1bTXq8U8lv0hv/0hiuI50Z1L3uda2chsd8RY6D7WqzDzlop3UjD0KFDgta2s6++Gip/7J/1ODmwtMEN7oPYUufGthG59LpOICGxa+HDf8fAxgKue2FUzdUyo3x15X1qA==
X-Gm-Message-State: AOJu0Yw/GoDJELCqYFpMqJMTzThxK9SCFGWEwK/efOTFlBuxo+RR6//z
	7djzYA84vtljfCaH/DgqVF4oD1E0j9SrGDjP10DwHGiKcrcpZZ3uWum9VRcJesI3kjbK1+MuwSg
	rVWgUYc4kZQdYbrt2X6wsIlhlUH0=
X-Google-Smtp-Source: AGHT+IG8OxLtjJZHfDzg2QJET9BBfk6lzEyPAHXgCfW/CIFgXdBcYsVJSJqryy8hAtVksa+xpQ+I6ZfWk3+grrx4sbQ=
X-Received: by 2002:a05:6122:4590:b0:4ec:fb8e:fc33 with SMTP id
 71dfb90a1353d-4ee3e198a54mr6340153e0c.2.1718496981478; Sat, 15 Jun 2024
 17:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de>
 <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
In-Reply-To: <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 16 Jun 2024 12:16:10 +1200
Message-ID: <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-mm@kvack.org, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 5:55=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 14 Jun 2024 12:03:25 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> > As of Linux 6.10-rc the MM can swap out larger than page size chunks.
> > NFS has all code ready to handle this, but has a VM_BUG_ON that
> > triggers when this happens.  Simply remove the VM_BUG_ON to fix this
> > use case.

As I understand it, this isn't happening because we don't support
mTHP swapping out to a swapfile, whether it's on NFS or any
other filesystem.
static int scan_swap_map_slots(struct swap_info_struct *si,
                               unsigned char usage, int nr,
                               swp_entry_t slots[], int order)
{
        ...
        if (order > 0) {
                ...

                /*
                 * Swapfile is not block device or not using clusters so un=
able
                 * to allocate large entries.
                 */
                if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
                        return 0;
        }
}

However, I'm pleased to see this patch, as we might need it someday.

> >
> > ...
> >
> > --- a/fs/nfs/direct.c
> > +++ b/fs/nfs/direct.c
> > @@ -141,8 +141,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter=
 *iter)
> >  {
> >       ssize_t ret;
> >
> > -     VM_BUG_ON(iov_iter_count(iter) !=3D PAGE_SIZE);
> > -
> >       if (iov_iter_rw(iter) =3D=3D READ)
> >               ret =3D nfs_file_direct_read(iocb, iter, true);
> >       else
>
> I'm thinking this should precede "mm: swap: entirely map large folios
> found in swapcache", or be a part of it.
>
> Barry/Chuanhua, any opinions?

The patch =E2=80=9Cmm: swap: entirely map large folios found in swapcache=
=E2=80=9D does not
perform any I/O operations; it only maps the accessed large folio within th=
e
swapcache. Therefore, this patch can be considered independent.

BTW, we haven't supported swapping out mTHP to nfs swapfile.

So, this patch is future-proof and can serve as a precedent if we
want to extend mthp swapout/swpin to non-blkdev systems.
Please correct me if I'm wrong, Ryan.

Thanks
Barry

