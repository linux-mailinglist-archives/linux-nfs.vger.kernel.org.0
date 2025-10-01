Return-Path: <linux-nfs+bounces-14841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4085BB1280
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 17:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDF92A3CD4
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0EF281375;
	Wed,  1 Oct 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArBQ8+Dn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFD28134D
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333377; cv=none; b=If4cenqFRWRrOaF8J/ZkW1VdqydCU6B+7PbDK2EnrrUSJG7sDNlphgqdw/+p45FCPS19ERPCSTK/4lPC8qKHZH9ba340XomENNmYukqW4zdDKo2nPDy6ZlF4Pf7pmxekQfeFJRaqL8u9f38kxgICrXeWntx7HLaXO+hQYZ3ZxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333377; c=relaxed/simple;
	bh=TJKXoZsCAumITdTgoU4akysu7Elmi+aj2MXmfhgAq3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=G7W284Ut43LGdyNoQcS3EW/OKt81NjOhZNUKvLVXS7k4ztgjdh1z9cTqcemHDz8iJp6zW2q/daioknyksJamH2rRp5LUJYv/PFaGJ4HuNbinLvJ81e9xiM0n2A/OorDTo9XoNPJnGyPgR4rjNmofjQXnMCBhwCqpfYrbYhcCwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArBQ8+Dn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-634a4829c81so38235a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 01 Oct 2025 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759333374; x=1759938174; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/yByfLtgCYsvHpBcE9XnPczhiQSiJ6h8P9CQ/V8sFM=;
        b=ArBQ8+Dn0yUQV+jxH+OfuQHYoCkeIFvhFjFNwcVjgUDt09TEkF0nlfeCl7BwVdvwzn
         mJCRY7ZKv6ZWuyS/BAch9OHxAkTP/TK9sN3ba5L7Ip96wT3/EHQls7qY7iPejKeDrE6I
         0CwH0lWnfs4Q2L1Nr5zWkmXZuA2dxMwOzVgaNSXUz78cLcNo8/qrnjJ8P5mwtU0EaNH2
         ffWcHwDTDJxHiFH2saCb4Up4GWzHvSHQq5LhPD448SwyQqvIRr+ME2pXf7zRk/x4FqIp
         sx45coEI87vnX0ssm+hh1buZw2+MnKhfkfkYhO2sPaeQHdUznUMxNxb08Z0ze2xK2Y3d
         jnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759333374; x=1759938174;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/yByfLtgCYsvHpBcE9XnPczhiQSiJ6h8P9CQ/V8sFM=;
        b=ps/e+FKzeyFbvNGjLY9pAABnwM8kxj0tbPMFT364tYAhD4e2ZU116Y9QmxFn9m/T1d
         hDkFwgvYa9SddO0tSl9jl6bUwEqwZLi1y+hpxN4HZnBHW9SsQzpkVHUseF66cU/+Sa+C
         INx5Nm/s0jRdrfYRvd4zzrZMTTd9wVqimNieNmQzAEc9BqN8xu7NKDYPiJl8K+41oc2F
         XLS7dZhURS/6ymyYofjlRCmPBaYTEFne0Yw0WW6ZpT0a5cj/kwRHVZXMPK5Bhzys4Prl
         afb/YqXllD6+13SznORgQsJVZF99h0sJOvujQTShcQYBBNJku1ey8V3e0ah6HPnYXNKy
         J1gg==
X-Gm-Message-State: AOJu0YyjuwLv43FkKWwcY4ukOL8kEt8gJGu1l5gqluDecT3kuZE0VqmC
	82c3roW+omDXNzW31TxCALAI8X+004i3OGUNSUPNv31OnWSZTRUH9LKbKeBUuj3hdb3EcXF3+a3
	8I/RV7LQ7x959Z/65/ZTKytMKlaBRlOXnefOG
X-Gm-Gg: ASbGnct7JHvnqRRqQcMg9PXAhtHvOM7ny1v6FO65nszL8LvA/5JiAl15sO8iQqLaxy8
	MSyLOAtvSsAL/esXoPPyJB6RFF6hSBRuacuLUST3o9wAFr6sIVqCqvylodLswZbfvUiIVKY3wED
	T2wnitY+vCxpdQU36IQ7LHK/1EGJbBsmt9h/Zn6UFbacLjDtJSEm4A+50BBeiZiPP/OPfDP1U1d
	j+rCNtX+ULFuKfXjj1T3A8lxQQ961g=
X-Google-Smtp-Source: AGHT+IEOkfEiJM+MLuhnq3ozG2ThBP1sjFSCkTeWkksEtfo6G0znTwEzG46m7d6TLJq7yJuaVuu6IhC948MPLUK73Kw=
X-Received: by 2002:a05:6402:1ece:b0:634:5381:530b with SMTP id
 4fb4d7f45d1cf-63678bb7adfmr4722300a12.13.1759333373747; Wed, 01 Oct 2025
 08:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
 <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com> <CA+1jF5pHpXHMOv_gRf_en2uX9jfwcCNhoDhYoq5butAFiiMsxg@mail.gmail.com>
In-Reply-To: <CA+1jF5pHpXHMOv_gRf_en2uX9jfwcCNhoDhYoq5butAFiiMsxg@mail.gmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Wed, 1 Oct 2025 17:42:17 +0200
X-Gm-Features: AS18NWBm_DwSSQloRQQ9MCc9fFQcPbSGMAgLjbaLllSuUQvLysYupAtGmWk-5P4
Message-ID: <CA+1jF5pWue5xoRWWecTa95Fuk-qTtBCsTSrVqp6D=_6YSO8+rw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What is the status of this patch? did it ever made it into the Linus
mainline kernel?

Aur=C3=A9lien

On Fri, Aug 15, 2025 at 5:20=E2=80=AFPM Aur=C3=A9lien Couderc
<aurelien.couderc2002@gmail.com> wrote:
>
> What is the status of this patch? did it ever made it into the Linus
> mainline kernel?
>
> Aur=C3=A9lien
>
> On Tue, May 13, 2025 at 6:08=E2=80=AFPM Benjamin Coddington <bcodding@red=
hat.com> wrote:
> >
> > I'm interested in this work, Chen are you still interested in moving th=
is
> > forward?   I have another question below --
> >
> > On 1 Sep 2023, at 4:34, Chen Hanxiao wrote:
> >
> > > nfsd already support btime by commit e377a3e698.
> > >
> > > This patch enable nfs to report btime in nfs_getattr.
> > > If underlying filesystem supports "btime" timestamp,
> > > statx will report btime for STATX_BTIME.
> > >
> > > Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> > >
> > > ---
> > > v1.1:
> > >       minor fix
> > > v2:
> > >       properly set cache validity
> > >
> > >  fs/nfs/inode.c          | 28 ++++++++++++++++++++++++----
> > >  fs/nfs/nfs4proc.c       |  3 +++
> > >  fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
> > >  include/linux/nfs_fs.h  |  2 ++
> > >  include/linux/nfs_xdr.h |  5 ++++-
> > >  5 files changed, 56 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > > index 8172dd4135a1..cfdf68b07982 100644
> > > --- a/fs/nfs/inode.c
> > > +++ b/fs/nfs/inode.c
> > > @@ -196,7 +196,8 @@ void nfs_set_cache_invalid(struct inode *inode, u=
nsigned long flags)
> > >               if (!(flags & NFS_INO_REVAL_FORCED))
> > >                       flags &=3D ~(NFS_INO_INVALID_MODE |
> > >                                  NFS_INO_INVALID_OTHER |
> > > -                                NFS_INO_INVALID_XATTR);
> > > +                                NFS_INO_INVALID_XATTR |
> > > +                                NFS_INO_INVALID_BTIME);
> > >               flags &=3D ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_S=
IZE);
> > >       }
> > >
> > > @@ -515,6 +516,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *=
fh, struct nfs_fattr *fattr)
> > >               memset(&inode->i_atime, 0, sizeof(inode->i_atime));
> > >               memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
> > >               memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
> > > +             memset(&nfsi->btime, 0, sizeof(nfsi->btime));
> > >               inode_set_iversion_raw(inode, 0);
> > >               inode->i_size =3D 0;
> > >               clear_nlink(inode);
> > > @@ -538,6 +540,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh =
*fh, struct nfs_fattr *fattr)
> > >                       inode->i_ctime =3D fattr->ctime;
> > >               else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
> > >                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_CT=
IME);
> > > +             if (fattr->valid & NFS_ATTR_FATTR_BTIME)
> > > +                     nfsi->btime =3D fattr->btime;
> > > +             else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> > > +                     nfs_set_cache_invalid(inode, NFS_INO_INVALID_BT=
IME);
> > >               if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
> > >                       inode_set_iversion_raw(inode, fattr->change_att=
r);
> > >               else
> > > @@ -835,6 +841,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const st=
ruct path *path,
> > >  {
> > >       struct inode *inode =3D d_inode(path->dentry);
> > >       struct nfs_server *server =3D NFS_SERVER(inode);
> > > +     struct nfs_inode *nfsi =3D NFS_I(inode);
> > >       unsigned long cache_validity;
> > >       int err =3D 0;
> > >       bool force_sync =3D query_flags & AT_STATX_FORCE_SYNC;
> > > @@ -845,7 +852,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const st=
ruct path *path,
> > >
> > >       request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX=
_UID |
> > >                       STATX_GID | STATX_ATIME | STATX_MTIME | STATX_C=
TIME |
> > > -                     STATX_INO | STATX_SIZE | STATX_BLOCKS |
> > > +                     STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_B=
TIME |
> > >                       STATX_CHANGE_COOKIE;
> > >
> > >       if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
> > > @@ -920,6 +927,10 @@ int nfs_getattr(struct mnt_idmap *idmap, const s=
truct path *path,
> > >               stat->attributes |=3D STATX_ATTR_CHANGE_MONOTONIC;
> > >       if (S_ISDIR(inode->i_mode))
> > >               stat->blksize =3D NFS_SERVER(inode)->dtsize;
> > > +     if (!(server->fattr_valid & NFS_ATTR_FATTR_BTIME))
> > > +             stat->result_mask &=3D ~STATX_BTIME;
> > > +     else
> > > +             stat->btime =3D nfsi->btime;
> > >  out:
> > >       trace_nfs_getattr_exit(inode, err);
> > >       return err;
> > > @@ -1803,7 +1814,7 @@ static int nfs_inode_finish_partial_attr_update=
(const struct nfs_fattr *fattr,
> > >               NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
> > >               NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
> > >               NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
> > > -             NFS_INO_INVALID_NLINK;
> > > +             NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
> > >       unsigned long cache_validity =3D NFS_I(inode)->cache_validity;
> > >       enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)->change_=
attr_type;
> > >
> > > @@ -2122,7 +2133,8 @@ static int nfs_update_inode(struct inode *inode=
, struct nfs_fattr *fattr)
> > >       nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
> > >                       | NFS_INO_INVALID_ATIME
> > >                       | NFS_INO_REVAL_FORCED
> > > -                     | NFS_INO_INVALID_BLOCKS);
> > > +                     | NFS_INO_INVALID_BLOCKS
> > > +                     | NFS_INO_INVALID_BTIME);
> > >
> > >       /* Do atomic weak cache consistency updates */
> > >       nfs_wcc_update_inode(inode, fattr);
> > > @@ -2161,6 +2173,7 @@ static int nfs_update_inode(struct inode *inode=
, struct nfs_fattr *fattr)
> > >                                       | NFS_INO_INVALID_BLOCKS
> > >                                       | NFS_INO_INVALID_NLINK
> > >                                       | NFS_INO_INVALID_MODE
> > > +                                     | NFS_INO_INVALID_BTIME
> > >                                       | NFS_INO_INVALID_OTHER;
> > >                               if (S_ISDIR(inode->i_mode))
> > >                                       nfs_force_lookup_revalidate(ino=
de);
> > > @@ -2189,6 +2202,12 @@ static int nfs_update_inode(struct inode *inod=
e, struct nfs_fattr *fattr)
> > >               nfsi->cache_validity |=3D
> > >                       save_cache_validity & NFS_INO_INVALID_MTIME;
> > >
> > > +     if (fattr->valid & NFS_ATTR_FATTR_BTIME) {
> > > +             nfsi->btime =3D fattr->btime;
> > > +     } else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> > > +             nfsi->cache_validity |=3D
> > > +                     save_cache_validity & NFS_INO_INVALID_BTIME;
> > > +
> > >       if (fattr->valid & NFS_ATTR_FATTR_CTIME)
> > >               inode->i_ctime =3D fattr->ctime;
> > >       else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
> > > @@ -2332,6 +2351,7 @@ struct inode *nfs_alloc_inode(struct super_bloc=
k *sb)
> > >  #endif /* CONFIG_NFS_V4 */
> > >  #ifdef CONFIG_NFS_V4_2
> > >       nfsi->xattr_cache =3D NULL;
> > > +     memset(&nfsi->btime, 0, sizeof(nfsi->btime));
> >
> >
> > ^^ is this redundant if we're going to do it anyway in nfs_fhget for I_=
NEW?
> >
> > .. actually, I don't understand why were doing /any/ nfsi member
> > initialization here.. am I missing something?
> >
> > Otherwise, this gets
> >
> > Tested-by: Benjamin Coddington <bcodding@redhat.com>
> > Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> >
> > Ben
> >
> >
>
>
> --
> Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> Big Data/Data mining expert, chess enthusiast



--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

