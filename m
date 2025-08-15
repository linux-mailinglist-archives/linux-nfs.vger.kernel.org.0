Return-Path: <linux-nfs+bounces-13677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56260B282D2
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A1416271B
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E41E51EB;
	Fri, 15 Aug 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX5dGb5B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBCF319844
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271262; cv=none; b=lClPkbr6EZXtJqoDoz1JlvUzyHWRNZhmqcQyN0kbpwY4NiD43jsXYTFcyJ+9nTi19RivYc1JAlMQZF0l3pDn2RTWXWQ5Tbi1hqkwqRk2b/mnhtdqHdQLeyWNFp2YLo/4HKExC4UY8FVFbk4T5ETZKEUfAQLx3G29054+jqyeS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271262; c=relaxed/simple;
	bh=AIKq9RRz3/NQBCtuwVWwNCfu5OwlQD/rMTsIZRoZN3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dSGT/1ULqHRAKQKeDfOiB0/4J+NL5TvRX31QsOOABNNutdqDhTQkwQ8AnmfI6RL/RiznGRgurs+QOCvvt7Nnein9HmID/CGXys5KMRBycVRbOxKR2sGacerEAQWHSCTcClhsDm73WlwHoEbuU+v0gRjm+2PAXIfNqipnrLz5IYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX5dGb5B; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb78d5e74so333550766b.1
        for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271259; x=1755876059; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds7vWRs3ae0FYggHp6P3i/EE92Jw2MJUQMfiJoX9zO4=;
        b=WX5dGb5BSkNQvgtv8vnoGz+JraP26LmZfS1tHXh+YMwk3/SSfgA0tMcx9iTGZrTvDa
         yNuqKlpuNQYsSqnbBIK44TzjHOe8Kb2E9A6mVqsAQiwmuxp0ZZggYFq8y6uwKYo3gF5E
         gMja4H+tjUbo08YFQXGKaNHEZ//gOgb+mHtNVWplDUF8DBm2c/K1ynRuegCe0QvffrMG
         i9vW83c9CNwo4rEF8oQQYfVjB6RT56VTyyG6OOsOIJkXl7Ct19bC/xSWwt3DZDP1KbAL
         UkK4xV03g1WJxKElHWAQsOLymka80m7ud+yEigWA71aWhDD/CikmsBPzITY9qTSULoeW
         k+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271259; x=1755876059;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds7vWRs3ae0FYggHp6P3i/EE92Jw2MJUQMfiJoX9zO4=;
        b=lGHQSP6HYxXMfGuPQtmLa2n6oT6962aRBiWxE1MBPLa/JdGDLh5NtZn53jYsXucoKd
         vbPLJOTOLxG0CI/RYey3bIn2rIQVaNcjGUQIQLqxcU5CU3qRtT4U6lvZKZFBdFRpyY16
         6f7B561tHoltf0KGZHN+f5y7U7/Oyj/QAaZtVIFMOq+wnEnuH+M/uE1GslrawgmYEO4c
         dH99aU4x0kr5YZWHK9QKkOK34vkbdiO+cdeyB/AChjMvpVlSEmpf7v0SluCHlte3DA9f
         sOZGP2N/rWgdTbPcvYHndUBwk8lI4Kl3PEgCvqO5lDTqHRQpA1sJMZPF3sTGk1HxXD5a
         Sb/w==
X-Gm-Message-State: AOJu0YyvSo3ePTvfYvBMSv1bPMAui+fdCP/MA8EaCSO/XsUcAEDTY1Dj
	R5YyCbMFmdiJ9ddOyRzg8cgL9OrY01MgrTSgpbcQQCNEt3yLpiHKkzhx+njsWcbAXVXZnpJTsut
	oV8udnEn13/149NYBlXkRQjRUqnggAYqQdjHyPH0=
X-Gm-Gg: ASbGnctfrL1aZ4CB0MTrodSdRehNtk8h3LjWTBcFy0/+vBgVrD/3RjZugBwYUsv0l+x
	XzO2HYYKkBiscpPLvyodRTY3TN+B/EqEQHZ3ukuN+3e26vGg6CMgAdccYYta8UF+nKmhvoYSUD1
	4RhA4EVgpqYA6i0D1+gtUjDgOsxATL93YEHsT4szpA+JGt0l7irlasmKZizpRteVIssi99AMq27
	2zfLY0=
X-Google-Smtp-Source: AGHT+IGp7yyGOKmktNzAAxTAVhcTjmYP6vUs5Z8106FEhuZJOwXg7O7J0zfngO2LfiSFBoqsZU4ysnWwfZdO9qXZG/I=
X-Received: by 2002:a17:907:788:b0:ad5:74cd:1824 with SMTP id
 a640c23a62f3a-afcdc35dff2mr233804566b.38.1755271258704; Fri, 15 Aug 2025
 08:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com> <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com>
In-Reply-To: <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Fri, 15 Aug 2025 17:20:22 +0200
X-Gm-Features: Ac12FXyOZLG98uArxaF3_uVb08BgTVyh8XZ17PJKaHtUb0EK22DYOar_QNDd-q4
Message-ID: <CA+1jF5pHpXHMOv_gRf_en2uX9jfwcCNhoDhYoq5butAFiiMsxg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What is the status of this patch? did it ever made it into the Linus
mainline kernel?

Aur=C3=A9lien

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
>
> Ben
>
>


--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

