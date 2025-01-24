Return-Path: <linux-nfs+bounces-9572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D20A1B4A1
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 12:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A38118830EF
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193AE1CDA13;
	Fri, 24 Jan 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDyJt1e6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6611CDFC1
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717752; cv=none; b=tq8i4NLCRG5QIMuzmv3uOo62+VPuo0Tv8lXbGqzJrNgmL2V37uN57LbpbgeK5ll9+SvRpGNL2+S1/JP4WI3nX8buAETMTRtXuk20x4AV6apFcXLuPhfkrvkMJiJRsMpTJUH9h8fTlq8maWxEhbvZgj3+3Cw/B5303cqM+xb/GpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717752; c=relaxed/simple;
	bh=3IyxvvTlF/xFWKZat0DZ6cKJQKeklP3l7r2ye2hbHmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2mF5MhsyFCGPMGK45W4YldClB2cifyjf9QCDCfMPv4VsfNFSjJbecGhkudqMJIMUkvd+YM6hhCMlRdsYb2WliYywqqyketzawi9CIe3UzJGvhGgcEsn4+s1Up61VLQ2WaMsg3K0s/Wq0awp8RLjFru6dwlqVdHujOeTR6E0trA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDyJt1e6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so3223339a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 03:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737717748; x=1738322548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O67/2XtUkIjaADCgfQ/n+e6Ycp7RCChtlEq/6lPQ9z0=;
        b=dDyJt1e6TpdBQujdpziRn2T5eS22D7S7gocf6AruHwVCZk/o8UAXRHq3Amy6IHCLKL
         P53+m5cpRY1drFD8Q4S7B9YSOZFBNaw5xLVOTJV1YEzDfcPuEYi4/ooVUY6rQeM6TztZ
         2v3sqUjiIa5Fas4KN0jvBTtSxSuCihQMH9yOUZ5ctz4BfnGGnK95N2AwAxUzymVkQI83
         rH9JEbhZD2QvhoBx6OKNu8ujNU8dcUoFwzEXZUOavplWQYXX+IHhh3/PjtT4Mn0wRwJT
         6dEZTz/163vYC3DdqTF3Uo96TACFwNNK1R0rf8t0AUP4/YVoUNxma0k54zW1BQJJj8mw
         n1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717748; x=1738322548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O67/2XtUkIjaADCgfQ/n+e6Ycp7RCChtlEq/6lPQ9z0=;
        b=UWTntbpijScb0FMC0BB5QC1ppRB3OCATG1zBJKwVKlSJrPRCSMoYQT/sfKSL0WzkYT
         YfEzxyV7AY/qJnQS++1B2XPxth/Got8mNtEvu8I8DWhzD7Z9S9AQ4dKrA2K6Oxdy1pM1
         msY0TeJ6apJ9i6GDzCawahzkKM/8SdgraxlXw82vhUzX8WVgdDIJnvauI7AzfTFyxJZN
         gjexVWu9XIQ4xCYS7HeItMlG+p4o/DVOC8zfXHXRonZJtM+IC4XI8w/f5ma2SinQTMOB
         8Fp0bPcCHAP88zffFUruXd3XuDDr9WuoLF7j6nNfltOl7lnSy6l7nyONY2UKxYnFfipO
         tvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+59pPAPW5U48dm/QDf5oceFkzN6VgOdm38HVk+oDb70dQc1H+JczrFoqY+wUyBAwgXzLV2PKaRBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLYGjGCUOObw0d6x6hGQnk83iij9kNejgWWfyaF9IzhkE0ZUr
	LqV0lgvytSORlO56duhbHUHd1Ba9g8PEWNE+QZ2Td7idVg55e6vSqdiOLvZ7kfXfgHefeIZPN50
	+KrS1f8CabI/A93rah530d6Fy62M=
X-Gm-Gg: ASbGncvXmx5pOWepS8SnaPgOlsiRBmahLHtYiICQRn5MoWvjgPr1ddzOFH/uFFf6TY8
	MSinsvDBZfM5Errd7lOoyoEKDYAGFaGs4++DQAAPBoGC54HQlTptp6wCbrlXdHg==
X-Google-Smtp-Source: AGHT+IEll9vZWglck6zfmCT4Mu8BO/5G5GNYYDtFQQ/ac14gP7ryFhaoQ4sPjXKfXH/vGFQHjIrDO0GPormO5UNPTHU=
X-Received: by 2002:a05:6402:27c8:b0:5dc:100c:157f with SMTP id
 4fb4d7f45d1cf-5dc100c1834mr4775238a12.11.1737717747935; Fri, 24 Jan 2025
 03:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123195242.1378601-1-cel@kernel.org> <20250123195242.1378601-5-cel@kernel.org>
 <0a1607952bc35549c925da8599ce366feb951850.camel@kernel.org>
In-Reply-To: <0a1607952bc35549c925da8599ce366feb951850.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Jan 2025 12:22:16 +0100
X-Gm-Features: AWEUYZkQ-EwrblQHV2N8LrEvGcqEWKEBTjNubzxgOldgnvD9qOSQdXFNksOsZ7g
Message-ID: <CAOQ4uxgmucVZtOL=M=UEOaWuPaLoQusY+ux+JLP+n3V_PBq2Gw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] NFSD: Return NFS4ERR_FILE_OPEN only when linking
 an open file
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 9:54=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2025-01-23 at 14:52 -0500, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > RFC 8881 Section 18.9.4 paragraphs 1 - 2 tell us that RENAME should
> > return NFS4ERR_FILE_OPEN only when the target object is a file that
> > is currently open. If the target is a directory, some other status
> > must be returned.
> >
> > Generally I expect that a delegation recall will be triggered in
> > some of these circumstances. In other cases, the VFS might return
> > -EBUSY for other reasons, and NFSD has to ensure that errno does
> > not leak to clients as a status code that is not permitted by spec.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/vfs.c | 44 +++++++++++++++++++++++++++++++-------------
> >  1 file changed, 31 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 5cfb5eb54c23..566b9adf2259 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1699,9 +1699,17 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> >       return err;
> >  }
> >
> > -/*
> > - * Create a hardlink
> > - * N.B. After this call _both_ ffhp and tfhp need an fh_put
> > +/**
> > + * nfsd_link - create a link
> > + * @rqstp: RPC transaction context
> > + * @ffhp: the file handle of the directory where the new link is to be=
 created
> > + * @name: the filename of the new link
> > + * @len: the length of @name in octets
> > + * @tfhp: the file handle of an existing file object
> > + *
> > + * After this call _both_ ffhp and tfhp need an fh_put.
> > + *
> > + * Returns a generic NFS status code in network byte-order.
> >   */
> >  __be32
> >  nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
> > @@ -1709,6 +1717,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
> >  {
> >       struct dentry   *ddir, *dnew, *dold;
> >       struct inode    *dirp;
> > +     int             type;
> >       __be32          err;
> >       int             host_err;
> >
> > @@ -1728,11 +1737,11 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp,
> >       if (isdotent(name, len))
> >               goto out;
> >
> > +     err =3D nfs_ok;
> > +     type =3D d_inode(tfhp->fh_dentry)->i_mode & S_IFMT;
> >       host_err =3D fh_want_write(tfhp);
> > -     if (host_err) {
> > -             err =3D nfserrno(host_err);
> > +     if (host_err)
> >               goto out;
> > -     }
> >
> >       ddir =3D ffhp->fh_dentry;
> >       dirp =3D d_inode(ddir);
> > @@ -1740,7 +1749,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
> >
> >       dnew =3D lookup_one_len(name, ddir, len);
> >       if (IS_ERR(dnew)) {
> > -             err =3D nfserrno(PTR_ERR(dnew));
> > +             host_err =3D PTR_ERR(dnew);
> >               goto out_unlock;
> >       }
> >
> > @@ -1756,17 +1765,26 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp,
> >       fh_fill_post_attrs(ffhp);
> >       inode_unlock(dirp);
> >       if (!host_err) {
> > -             err =3D nfserrno(commit_metadata(ffhp));
> > -             if (!err)
> > -                     err =3D nfserrno(commit_metadata(tfhp));
> > -     } else {
> > -             err =3D nfserrno(host_err);
> > +             host_err =3D commit_metadata(ffhp);
> > +             if (!host_err)
> > +                     host_err =3D commit_metadata(tfhp);
> >       }
> > +
> >       dput(dnew);
> >  out_drop_write:
> >       fh_drop_write(tfhp);
> > +     if (host_err =3D=3D -EBUSY) {
> > +             /*
> > +              * See RFC 8881 Section 18.9.4 para 1-2: NFSv4 LINK
> > +              * status distinguishes between reg file and dir.
> > +              */
> > +             if (type !=3D S_IFDIR)
> > +                     err =3D nfserr_file_open;
> > +             else
> > +                     err =3D nfserr_acces;
>
> I guess nothing in NFS protocol spec prohibits you from hardlinking a
> directory, but hopefully any Linux filesystem will be returning -EPERM
> when someone tries it! IOW, I suspect the above will probably be dead
> code, but I don't think it'll hurt anything.
>

Not to mention that unlike rmdir() and rename(), vfs does not return EBUSY
for link(), so this code is not really testable as is, is it?

I would drop this patch if I were you, but as you wish.

Thanks,
Amir.

