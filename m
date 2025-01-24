Return-Path: <linux-nfs+bounces-9602-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B2A1BD8E
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 21:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7291162A13
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF9F7080A;
	Fri, 24 Jan 2025 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSAlmRTo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849861ADC88
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751000; cv=none; b=P5NJWT2FWfgxTZiUq18ezI1I8bdmWcA4+gY+NPP1wBtCG1I0zeNiCwu7CxWYt6uRmoP/Kx3Tk1rgLW+ZCP5kC6ple7TuRu9ti6tKGRJXB/GJwLx7g1vKcwPrCG+XXMrHFoDwtY47+FCDZyczTQBBHniICREywkyxVc9Y6RlAf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751000; c=relaxed/simple;
	bh=gOSQrD76uw+25XDKwp+ZbZwEuy24RISJ+VlabXMhqmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChcHdoMihVbKGev2rWJPRgYkT8FIA2OCyvUMNQ5Tex+xQBf3tKjs46VSavRNJz2iRNS3i62vQvddd+JuvYr6Qi73kyqZXlhSS44KyOAAFNiv+bXYQL+QdtcCkQEetIAgsT2JgzAGdaGbhasYGqexYYWSdZkPBxYvApRgNLfuYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSAlmRTo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dbfab8a2b0so4798915a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737750997; x=1738355797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9hjwi1bpXmT26p9EOWfXbSlmOGOdYmZ+f/jQDItkGE=;
        b=aSAlmRToU0EBm4SycpUmYHO8B8Xb5/3RzOA4EXwduHBHJHiMq6Vh308sMREke1Z+fi
         7WSVobCJ01K8o4+/v7jvM1YGKXcpuDaoK3EbwMTsuP5kPCeSNE7EI8SBez+Q/7pzTWln
         O6dsGyNDTTCuFp8k0N52n8InLaWZ04vH2Shm/UMHXJ/RQ/UbHb1xjy8nK51TLu/bKQ8w
         jaS0b19J6cUTGp55Gs0YM+Y7YHNlCYAG4aLydyIhcixxGetYyRNg3+KFWAzmBaulZ8M8
         bfkARQrBxLfA+OdY1khfmfW9kRvkpoW5Z3wilJDYBhrv0/vNjCQHNIZjV5MWGYo2ribA
         yQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737750997; x=1738355797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9hjwi1bpXmT26p9EOWfXbSlmOGOdYmZ+f/jQDItkGE=;
        b=nnoOqJ4UNd+8VdpNrur0Qh7xwQGWCx1l/XxX9pGW34Jtns0g/G89B5wiFP+EkfGxHf
         6Ckvg1AYjicihzyo2g2K+upCIoNq0c4UjBLDLzaKDj8KIvdEDKNgejEwJYJD8MdfHxE7
         hS+5bcYiNZQHNAeE5MricmB53jbzweusWys52Kae0AeNtqOo2k5Eh4fzIPV9hA/6KcdV
         sJxRpaM4NRNVZ7Rz+4mbMwk1b1YR4fRrExHE1kEDJyUf0Y6rac/QhhDvY/rAkLQYjwS8
         7mZXGEIRrKf89VHTJ8B5JdxZr4OXROEcckAYxO9BOBpdDBr6ouuokMfFJSYqh4CswbeE
         Zovg==
X-Forwarded-Encrypted: i=1; AJvYcCVkj4au2lcXDJwaV6HyfznlLhE/UGKKCjrKxM0kW95CvK360XnxPCRd+d2sF953LpNOP483tE5q1D4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Ul89Po6603KA1mwDZrxh5YlRuR4jwpUp5mCA1A/Rc+4vnatV
	bT5dy0Lr/dyN259KwF3FSdYnoonsXHbJ8n7nwtAZJAlfx2RH/heetvvnLKNLPQXoauF5LIoRrLn
	k77omyYN2W9QQIYXvg+fFaev5RD8=
X-Gm-Gg: ASbGncuomnRdAyKa8lg3g8f5Kgf5vmAesCr6q//BCWGGC6c81t/eZtexmV1CLZHcIhl
	OMAPvkdqH0xqZNch+hL8CWwkZ40O4L77ezKr8NUocusAXVay8DrvsKzIA3rNlhw==
X-Google-Smtp-Source: AGHT+IH9zQEtMtG1QbucoH53VXzlRCZT6/S5hq9jh+aCcDGe5vaqJGvCy7lBkEDoOyic6Kx9x0KwCfo3VyEaiBj8R5o=
X-Received: by 2002:a05:6402:4305:b0:5dc:4f4:74c3 with SMTP id
 4fb4d7f45d1cf-5dc04f47821mr8152204a12.4.1737750996527; Fri, 24 Jan 2025
 12:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123195242.1378601-1-cel@kernel.org> <20250123195242.1378601-5-cel@kernel.org>
 <0a1607952bc35549c925da8599ce366feb951850.camel@kernel.org>
 <CAOQ4uxgmucVZtOL=M=UEOaWuPaLoQusY+ux+JLP+n3V_PBq2Gw@mail.gmail.com> <3dc5971a-5fb0-4bb6-856f-ffb15d18bb4e@oracle.com>
In-Reply-To: <3dc5971a-5fb0-4bb6-856f-ffb15d18bb4e@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Jan 2025 21:36:24 +0100
X-Gm-Features: AWEUYZlXCDHWgQ-rghyKQLVIhsTCHNaqr0Zl1YN3-nywJU6ezwS_IedRI6R0xNE
Message-ID: <CAOQ4uxgyqfihdAFG8FSDYvHmBGzb-eJ=YaRX=Ou7uqzHsy1VzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] NFSD: Return NFS4ERR_FILE_OPEN only when linking
 an open file
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, cel@kernel.org, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 3:04=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/24/25 6:22 AM, Amir Goldstein wrote:
> > On Thu, Jan 23, 2025 at 9:54=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> >>
> >> On Thu, 2025-01-23 at 14:52 -0500, cel@kernel.org wrote:
> >>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>
> >>> RFC 8881 Section 18.9.4 paragraphs 1 - 2 tell us that RENAME should
> >>> return NFS4ERR_FILE_OPEN only when the target object is a file that
> >>> is currently open. If the target is a directory, some other status
> >>> must be returned.
> >>>
> >>> Generally I expect that a delegation recall will be triggered in
> >>> some of these circumstances. In other cases, the VFS might return
> >>> -EBUSY for other reasons, and NFSD has to ensure that errno does
> >>> not leak to clients as a status code that is not permitted by spec.
> >>>
> >>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>> ---
> >>>   fs/nfsd/vfs.c | 44 +++++++++++++++++++++++++++++++-------------
> >>>   1 file changed, 31 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >>> index 5cfb5eb54c23..566b9adf2259 100644
> >>> --- a/fs/nfsd/vfs.c
> >>> +++ b/fs/nfsd/vfs.c
> >>> @@ -1699,9 +1699,17 @@ nfsd_symlink(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> >>>        return err;
> >>>   }
> >>>
> >>> -/*
> >>> - * Create a hardlink
> >>> - * N.B. After this call _both_ ffhp and tfhp need an fh_put
> >>> +/**
> >>> + * nfsd_link - create a link
> >>> + * @rqstp: RPC transaction context
> >>> + * @ffhp: the file handle of the directory where the new link is to =
be created
> >>> + * @name: the filename of the new link
> >>> + * @len: the length of @name in octets
> >>> + * @tfhp: the file handle of an existing file object
> >>> + *
> >>> + * After this call _both_ ffhp and tfhp need an fh_put.
> >>> + *
> >>> + * Returns a generic NFS status code in network byte-order.
> >>>    */
> >>>   __be32
> >>>   nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
> >>> @@ -1709,6 +1717,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp,
> >>>   {
> >>>        struct dentry   *ddir, *dnew, *dold;
> >>>        struct inode    *dirp;
> >>> +     int             type;
> >>>        __be32          err;
> >>>        int             host_err;
> >>>
> >>> @@ -1728,11 +1737,11 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_=
fh *ffhp,
> >>>        if (isdotent(name, len))
> >>>                goto out;
> >>>
> >>> +     err =3D nfs_ok;
> >>> +     type =3D d_inode(tfhp->fh_dentry)->i_mode & S_IFMT;
> >>>        host_err =3D fh_want_write(tfhp);
> >>> -     if (host_err) {
> >>> -             err =3D nfserrno(host_err);
> >>> +     if (host_err)
> >>>                goto out;
> >>> -     }
> >>>
> >>>        ddir =3D ffhp->fh_dentry;
> >>>        dirp =3D d_inode(ddir);
> >>> @@ -1740,7 +1749,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp,
> >>>
> >>>        dnew =3D lookup_one_len(name, ddir, len);
> >>>        if (IS_ERR(dnew)) {
> >>> -             err =3D nfserrno(PTR_ERR(dnew));
> >>> +             host_err =3D PTR_ERR(dnew);
> >>>                goto out_unlock;
> >>>        }
> >>>
> >>> @@ -1756,17 +1765,26 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_=
fh *ffhp,
> >>>        fh_fill_post_attrs(ffhp);
> >>>        inode_unlock(dirp);
> >>>        if (!host_err) {
> >>> -             err =3D nfserrno(commit_metadata(ffhp));
> >>> -             if (!err)
> >>> -                     err =3D nfserrno(commit_metadata(tfhp));
> >>> -     } else {
> >>> -             err =3D nfserrno(host_err);
> >>> +             host_err =3D commit_metadata(ffhp);
> >>> +             if (!host_err)
> >>> +                     host_err =3D commit_metadata(tfhp);
> >>>        }
> >>> +
> >>>        dput(dnew);
> >>>   out_drop_write:
> >>>        fh_drop_write(tfhp);
> >>> +     if (host_err =3D=3D -EBUSY) {
> >>> +             /*
> >>> +              * See RFC 8881 Section 18.9.4 para 1-2: NFSv4 LINK
> >>> +              * status distinguishes between reg file and dir.
> >>> +              */
> >>> +             if (type !=3D S_IFDIR)
> >>> +                     err =3D nfserr_file_open;
> >>> +             else
> >>> +                     err =3D nfserr_acces;
> >>
> >> I guess nothing in NFS protocol spec prohibits you from hardlinking a
> >> directory, but hopefully any Linux filesystem will be returning -EPERM
> >> when someone tries it! IOW, I suspect the above will probably be dead
> >> code, but I don't think it'll hurt anything.
> >>
> >
> > Not to mention that unlike rmdir() and rename(), vfs does not return EB=
USY
> > for link(), so this code is not really testable as is, is it?
>
> You suggested that the VFS could return -EBUSY for just about anything
> for FuSE.
>

Yes, it is possible.

>
> > I would drop this patch if I were you, but as you wish.
>
> I can, but how do we know we'll never get -EBUSY here?
>

You are right.

Thanks,
Amir.

