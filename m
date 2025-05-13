Return-Path: <linux-nfs+bounces-11698-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D5AB5A51
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 18:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EC717AA0F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2322BF3DF;
	Tue, 13 May 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua27yuub"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B912CD96
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154227; cv=none; b=dvLE0dTyBNsEI4+CJzVir2rnnuysfJoqyAjfiAVIwMYaue5Px0CET8NLBv6WAcK94uAxdEJKfBbbo0ihgKFnlFwQ7eTIWWzfuYKse/mfrAqYzCiIsIxX6MVuMMBruGxaV7DTtUYlYA1FXD7nSNY2WYcD6O7HZk5t5l24KQyF+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154227; c=relaxed/simple;
	bh=PJKTP81MddAsQ8u9cWCghG4yLkBephNZvq2TSZAvvvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ngC8AKZ8oLnU34lF8lgtNP39CZ4f1v9h9vDP0kYjBo7GgsVGXmth31Hm/xKv8+mbfmKFT8QqhsIGIq4EKXPY1fiZLteNtFWnSfZ9bGNMdfJ4zN0MEtIOQzf1yThBIYhVffeOwZYwTKg16tZi8gC/5jX+zrAez1M6tKA1ThBO6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua27yuub; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2db0217abe4so2693413fac.1
        for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747154225; x=1747759025; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRD9Fd1hmvHcj9OQzrXYd4Jo4QRuUdMY/tJXxXwGlms=;
        b=Ua27yuubDLN5jaQBEiXW1ioeXJh4GLvUyErmw6+yH13I2V9dAT7juZoP3MKQbd5E8u
         EOgEmAmGAtVOLOjfJaMRaPr8coCdopHGI6yls/Z/xwS+PIct3EQC9IS4URDH3rj0eA1f
         af2+x8BDBGxIQt6h4wOICViuBeJoXgqC1J2ibGnsqvnaba9ahNeiY4hB0u6EGzYkxBKa
         NK8RtwZREaQlrMu+2xCMITSV81fvFmoCgX0ZTmJnrOL9EGXwH6pKT7oBiMaVIVe4Gmjs
         /4qjg3GkmBQKpYY6bpKeHP1ybmqU+DssNXa8O+fXxOGRe6RcogEQOFmFUBNl5i03STdg
         CT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747154225; x=1747759025;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRD9Fd1hmvHcj9OQzrXYd4Jo4QRuUdMY/tJXxXwGlms=;
        b=bQbuQ2RvxEDWRiEhtXLoIIsNz6CYiGDUDQL0swic5NKGjReSM4gSasrsJY037BzVto
         HUPB6nGKYxMmPuzse9BV4y6kpqw5TDofJjT312NAEFemNtM/+oDT/Ot01yhIhXGhVOQA
         NwB6yAixijyAcctWnl+7vThbqEm/DT5hOJt2gQ3yUSS6kLieSBPK/89UoBj1fZvwJUfk
         FF6A0W3VlwzjW0PmHZ7WWH38/Pii6NfGCqmajj07HDr2XMpNO476N97TOr7hx1/jPaX3
         fQkxXlWH1bVv64kdq9rpNE/l9d8Ccn9qrHGrIEBXlnN/g8XOfvdoG6R6TeXPS0n23n7q
         MH6g==
X-Gm-Message-State: AOJu0YwDs982Vo9KmGD3GW6n/xjEswQLijZe/yoHZgwGOYZWe97guvOg
	AyTGmb7fpQwRUDyebRDNfvZOZmBrLOqPPedFai7Jk853ja5Bm3S3+JgQRIcKYFr+LKA8aTxQWj0
	BLH+cbjC8G27DdXR6XDwvCDoIMRBaAbp9
X-Gm-Gg: ASbGncshFP6QNA6W0apf+k6eY2/D/PcUmanZ1NiFpM8N071mzgjuDHyHU5e0HmTQQLT
	bfDGPySVnpphezOJTfsDibZkpXTKViXSBFPQQP5O7939zqUdhsVcndkUZupPB43hJd2aDqYqxye
	/JZeS4rZGioYqvLEcNSFzfvnQPBKMfxfXv
X-Google-Smtp-Source: AGHT+IEyr4PO4SuHQy73w9X31L3Gd7WCMk37Z74LkZ7jp8yzne65QMWjzmxViN2e5J+InSRi8mjoWb/EuIR1roiitrI=
X-Received: by 2002:a05:6870:c08b:b0:2b8:3c87:b491 with SMTP id
 586e51a60fabf-2dba44e36acmr10621697fac.26.1747154224539; Tue, 13 May 2025
 09:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com> <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com>
In-Reply-To: <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 13 May 2025 18:36:28 +0200
X-Gm-Features: AX0GCFteCTqpudBiAn__BM7G1Xe7RV7jDvIU6KyiyZa5yIfqOmSul4VWvRpIEr4
Message-ID: <CA+1jF5puYFtPJ+sdUxHEy9JrOeq13VW-ROXpj8UwOZz4b4hsLw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 6:08=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> I'm interested in this work, Chen are you still interested in moving this
> forward?   I have another question below --
>
> On 1 Sep 2023, at 4:34, Chen Hanxiao wrote:
>
> > nfsd already support btime by commit e377a3e698.
> >
> > This patch enable nfs to report btime in nfs_getattr.
> > If underlying filesystem supports "btime" timestamp,
> > statx will report btime for STATX_BTIME.
> >
> > Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> >
> > ---
> > v1.1:
> >       minor fix
> > v2:
> >       properly set cache validity
> >
> >  fs/nfs/inode.c          | 28 ++++++++++++++++++++++++----
> >  fs/nfs/nfs4proc.c       |  3 +++
> >  fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
> >  include/linux/nfs_fs.h  |  2 ++
> >  include/linux/nfs_xdr.h |  5 ++++-
> >  5 files changed, 56 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 8172dd4135a1..cfdf68b07982 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -196,7 +196,8 @@ void nfs_set_cache_invalid(struct inode *inode, uns=
igned long flags)
> >               if (!(flags & NFS_INO_REVAL_FORCED))
> >                       flags &=3D ~(NFS_INO_INVALID_MODE |
> >                                  NFS_INO_INVALID_OTHER |
> > -                                NFS_INO_INVALID_XATTR);
> > +                                NFS_INO_INVALID_XATTR |
> > +                                NFS_INO_INVALID_BTIME);
> >               flags &=3D ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZ=
E);
> >       }
> >
> > @@ -515,6 +516,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh=
, struct nfs_fattr *fattr)
> >               memset(&inode->i_atime, 0, sizeof(inode->i_atime));
> >               memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
> >               memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
> > +             memset(&nfsi->btime, 0, sizeof(nfsi->btime));
> >               inode_set_iversion_raw(inode, 0);
> >               inode->i_size =3D 0;
> >               clear_nlink(inode);
> > @@ -538,6 +540,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *f=
h, struct nfs_fattr *fattr)
> >                       inode->i_ctime =3D fattr->ctime;
> >               else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
> >                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIM=
E);
> > +             if (fattr->valid & NFS_ATTR_FATTR_BTIME)
> > +                     nfsi->btime =3D fattr->btime;
> > +             else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> > +                     nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIM=
E);
> >               if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
> >                       inode_set_iversion_raw(inode, fattr->change_attr)=
;
> >               else
> > @@ -835,6 +841,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const stru=
ct path *path,
> >  {
> >       struct inode *inode =3D d_inode(path->dentry);
> >       struct nfs_server *server =3D NFS_SERVER(inode);
> > +     struct nfs_inode *nfsi =3D NFS_I(inode);
> >       unsigned long cache_validity;
> >       int err =3D 0;
> >       bool force_sync =3D query_flags & AT_STATX_FORCE_SYNC;
> > @@ -845,7 +852,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const stru=
ct path *path,
> >
> >       request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_U=
ID |
> >                       STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTI=
ME |
> > -                     STATX_INO | STATX_SIZE | STATX_BLOCKS |
> > +                     STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTI=
ME |
> >                       STATX_CHANGE_COOKIE;
> >
> >       if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
> > @@ -920,6 +927,10 @@ int nfs_getattr(struct mnt_idmap *idmap, const str=
uct path *path,
> >               stat->attributes |=3D STATX_ATTR_CHANGE_MONOTONIC;
> >       if (S_ISDIR(inode->i_mode))
> >               stat->blksize =3D NFS_SERVER(inode)->dtsize;
> > +     if (!(server->fattr_valid & NFS_ATTR_FATTR_BTIME))
> > +             stat->result_mask &=3D ~STATX_BTIME;
> > +     else
> > +             stat->btime =3D nfsi->btime;
> >  out:
> >       trace_nfs_getattr_exit(inode, err);
> >       return err;
> > @@ -1803,7 +1814,7 @@ static int nfs_inode_finish_partial_attr_update(c=
onst struct nfs_fattr *fattr,
> >               NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
> >               NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
> >               NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
> > -             NFS_INO_INVALID_NLINK;
> > +             NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
> >       unsigned long cache_validity =3D NFS_I(inode)->cache_validity;
> >       enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)->change_at=
tr_type;
> >
> > @@ -2122,7 +2133,8 @@ static int nfs_update_inode(struct inode *inode, =
struct nfs_fattr *fattr)
> >       nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
> >                       | NFS_INO_INVALID_ATIME
> >                       | NFS_INO_REVAL_FORCED
> > -                     | NFS_INO_INVALID_BLOCKS);
> > +                     | NFS_INO_INVALID_BLOCKS
> > +                     | NFS_INO_INVALID_BTIME);
> >
> >       /* Do atomic weak cache consistency updates */
> >       nfs_wcc_update_inode(inode, fattr);
> > @@ -2161,6 +2173,7 @@ static int nfs_update_inode(struct inode *inode, =
struct nfs_fattr *fattr)
> >                                       | NFS_INO_INVALID_BLOCKS
> >                                       | NFS_INO_INVALID_NLINK
> >                                       | NFS_INO_INVALID_MODE
> > +                                     | NFS_INO_INVALID_BTIME
> >                                       | NFS_INO_INVALID_OTHER;
> >                               if (S_ISDIR(inode->i_mode))
> >                                       nfs_force_lookup_revalidate(inode=
);
> > @@ -2189,6 +2202,12 @@ static int nfs_update_inode(struct inode *inode,=
 struct nfs_fattr *fattr)
> >               nfsi->cache_validity |=3D
> >                       save_cache_validity & NFS_INO_INVALID_MTIME;
> >
> > +     if (fattr->valid & NFS_ATTR_FATTR_BTIME) {
> > +             nfsi->btime =3D fattr->btime;
> > +     } else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
> > +             nfsi->cache_validity |=3D
> > +                     save_cache_validity & NFS_INO_INVALID_BTIME;
> > +
> >       if (fattr->valid & NFS_ATTR_FATTR_CTIME)
> >               inode->i_ctime =3D fattr->ctime;
> >       else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
> > @@ -2332,6 +2351,7 @@ struct inode *nfs_alloc_inode(struct super_block =
*sb)
> >  #endif /* CONFIG_NFS_V4 */
> >  #ifdef CONFIG_NFS_V4_2
> >       nfsi->xattr_cache =3D NULL;
> > +     memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>
>
> ^^ is this redundant if we're going to do it anyway in nfs_fhget for I_NE=
W?
>
> .. actually, I don't understand why were doing /any/ nfsi member
> initialization here.. am I missing something?
>
> Otherwise, this gets
>
> Tested-by: Benjamin Coddington <bcodding@redhat.com>
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Reviewed-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>

I am astonished that birth timestamp support in the Linux NFS client
wasn't implemented... earlier.

Just curious: What happens with this functionality if one filesystem
exported by nfsd supports birth timestamps, and another filesystem
does not support birth timestamps?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

