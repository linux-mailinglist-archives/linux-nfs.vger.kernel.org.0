Return-Path: <linux-nfs+bounces-3839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6AE909068
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474C31F21B24
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523A519CD07;
	Fri, 14 Jun 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOhoWccc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DFF503
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382776; cv=none; b=qKs7I//aqse+epsTLmr+chstDflt0+L38UVpZlzKJiZSJ4tHUkGd5zp7avcKBtdqm+FRxiCy0Va6lYdbai1x9NAQvwDUM0iNCPt1n5IDshqwEBTDUA95dAIb4c4B52PLwmygJmalstphGHo2tmAxHOJyhCIYokiH3/lC+StoXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382776; c=relaxed/simple;
	bh=C7pGa29c3UJQPU+oRVXy87+T1wudpAy0PNfQZrcHlPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXieBDxPULeW2qji7CC/duesaWl6Fr6uVZy/yVjH3h1K0BaSlkS1hgiEMrriF+geVDzvOIazRnlnc+1W+4z6rpJFAyXT8mIfVJmEFNCg/jR5M2W98nethYdRhDQRRycuU1Y7o4dlcsQ7cC2i/gGk81VJs4qsLBAZCBt/b1va18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOhoWccc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43ff9d1e0bbso12795591cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718382773; x=1718987573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsaX8JplKRwyUTrUkFXo//5qONmSRfVNORPk4eeZ/m4=;
        b=GOhoWccc8rGG2cPYelEHHq8h0dtj/q7GEglLn4ho1f13srMd/jvuW3cX0Hbd3kf0Sl
         PsiaTWr968vzN7G7K8NGFlrN9q7A4+irto8xnA+bJ1f3F0ON6IsjOv9mKvq9VvAg534o
         s9h5TnMtKYSr8q2jV+LR8X47/jMNymVNS3+5AU9AXXwGwpprNO3B3zl2F4nxbqe/3QHT
         dpXRYRq0aWVY8ufmhdwE5ImFFDQh6PcXANkywwykg/zUWWWCiz2ggWlPcJQecIkv/Vuf
         55JY3HlJ4HOqOuY5zCczokUO2dHVKCIRYhaN5At0dY5ZZvhKd+6UT/szPpX7F/yAb5LB
         Lbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382773; x=1718987573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsaX8JplKRwyUTrUkFXo//5qONmSRfVNORPk4eeZ/m4=;
        b=nv2LcdyXh3VvjQGd8L2GKJYFtD3CUJyhyaFB/iNcf88JVwZTfVrX2vSiVw3rJ8oK+E
         o//fjZdrzXAKLaTC9dS1bt06zH2OI/a7OBSYTg1JyAG1F9sr3/mpirNU2SigyQqsRcWJ
         vZq3OPz2kz6Eh9WfRzjJvAA3I/ks76WdeGIlKJQJNrG2KlG9r+AwXzmeWY4NMp8o8iSq
         7KHbga8joQ9/8C6bBkNQDsqd940I8/Biul2IVESEuGskGgB2Yt7oPMb3LkZyNojUJ9tW
         fC7XmGg8uw5GcSgzS+WBtsEj0RB3ILdA9RLHBMowag7/LPufI6WdJBKwWk7J795NGz0T
         Zkpw==
X-Gm-Message-State: AOJu0Yy+T3cfwO70Im4kZaOaZ3Zp1g83FMIvIayHzqrxoB8bO/pUFKgN
	UXHlMXqvYxJ+JehDYdAE4r8AZOPb4eUHdegufSZqg2Gm0puQZmCmqvHzVoOdDv3yTzbn2ZEAYW7
	ezsHZeVqQBhY2LlVWR11/Z9LaQUS5jg==
X-Google-Smtp-Source: AGHT+IHrcf4EJwfx2cGSTvN1tpZMLAzIgOwl67Gv9sZju0NFQB6c+R1XnqUB94nZsYwfYqHcyjEVCPU3A3wyAmen8T8=
X-Received: by 2002:a05:622a:1449:b0:441:78:4e01 with SMTP id
 d75a77b69052e-44216b37ad6mr38737311cf.56.1718382773587; Fri, 14 Jun 2024
 09:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com> <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com> <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com> <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com> <20240613041136.506908-9-trond.myklebust@hammerspace.com>
 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
 <20240613041136.506908-12-trond.myklebust@hammerspace.com> <20240613041136.506908-13-trond.myklebust@hammerspace.com>
In-Reply-To: <20240613041136.506908-13-trond.myklebust@hammerspace.com>
From: Anna Schumaker <schumaker.anna@gmail.com>
Date: Fri, 14 Jun 2024 12:32:37 -0400
Message-ID: <CAFX2Jfk7u37+AOX_o1ZRf-QX_abSDXpKaEpHt=iOvL5Bq6opTQ@mail.gmail.com>
Subject: Re: [PATCH 12/19] NFSv4: Fix up delegated attributes in nfs_setattr
To: trondmy@gmail.com
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trond,

On Thu, Jun 13, 2024 at 12:18=E2=80=AFAM <trondmy@gmail.com> wrote:
>
> From: Trond Myklebust <trond.myklebust@primarydata.com>
>
> nfs_setattr calls nfs_update_inode() directly, so we have to reset the
> m/ctime there.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/inode.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

After applying this patch I see a handful of new failures on xfstests:
generic/075, generic/086, generic/112, generic/332, generic/346,
generic/647, and generic/729. I see the first five on NFS v4.2, but
647 and 729 both fail on v4.1 in addition to v4.2.

I hope this helps!
Anna

>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 91c0aeaf6c1e..e03c512c8535 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -605,6 +605,46 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh,=
 struct nfs_fattr *fattr)
>  }
>  EXPORT_SYMBOL_GPL(nfs_fhget);
>
> +static void
> +nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
> +{
> +       unsigned long cache_validity =3D NFS_I(inode)->cache_validity;
> +
> +       if (!nfs_have_read_or_write_delegation(inode))
> +               return;
> +
> +       if (!(cache_validity & NFS_INO_REVAL_FORCED))
> +               cache_validity &=3D ~(NFS_INO_INVALID_ATIME
> +                               | NFS_INO_INVALID_CHANGE
> +                               | NFS_INO_INVALID_CTIME
> +                               | NFS_INO_INVALID_MTIME
> +                               | NFS_INO_INVALID_SIZE);
> +
> +       if (!(cache_validity & NFS_INO_INVALID_SIZE))
> +               fattr->valid &=3D ~(NFS_ATTR_FATTR_PRESIZE
> +                               | NFS_ATTR_FATTR_SIZE);
> +
> +       if (!(cache_validity & NFS_INO_INVALID_CHANGE))
> +               fattr->valid &=3D ~(NFS_ATTR_FATTR_PRECHANGE
> +                               | NFS_ATTR_FATTR_CHANGE);
> +
> +       if (nfs_have_delegated_mtime(inode)) {
> +               if (!(cache_validity & NFS_INO_INVALID_CTIME))
> +                       fattr->valid &=3D ~(NFS_ATTR_FATTR_PRECTIME
> +                                       | NFS_ATTR_FATTR_CTIME);
> +
> +               if (!(cache_validity & NFS_INO_INVALID_MTIME))
> +                       fattr->valid &=3D ~(NFS_ATTR_FATTR_PREMTIME
> +                                       | NFS_ATTR_FATTR_MTIME);
> +
> +               if (!(cache_validity & NFS_INO_INVALID_ATIME))
> +                       fattr->valid &=3D ~NFS_ATTR_FATTR_ATIME;
> +       } else if (nfs_have_delegated_atime(inode)) {
> +               if (!(cache_validity & NFS_INO_INVALID_ATIME))
> +                       fattr->valid &=3D ~NFS_ATTR_FATTR_ATIME;
> +       }
> +}
> +
>  void nfs_update_delegated_atime(struct inode *inode)
>  {
>         spin_lock(&inode->i_lock);
> @@ -2163,6 +2203,9 @@ static int nfs_update_inode(struct inode *inode, st=
ruct nfs_fattr *fattr)
>          */
>         nfsi->read_cache_jiffies =3D fattr->time_start;
>
> +       /* Fix up any delegated attributes in the struct nfs_fattr */
> +       nfs_fattr_fixup_delegated(inode, fattr);
> +
>         save_cache_validity =3D nfsi->cache_validity;
>         nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
>                         | NFS_INO_INVALID_ATIME
> --
> 2.45.2
>
>

