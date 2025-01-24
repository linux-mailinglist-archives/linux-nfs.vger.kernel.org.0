Return-Path: <linux-nfs+bounces-9571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A45A1B3BE
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 11:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A2D3A1552
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6A23B0;
	Fri, 24 Jan 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5lToEX9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1A17FE
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715647; cv=none; b=f/rdgztRiptYVS1mTwrjM5W3LljQRL/OD1xPhT4kaKqFMXBgi1ErZdhQVBUbu+ZSj1jKVA0wfqbzgiovt7L1+0S6n2r0nNoMcDXbA7yAwQ45E+fv+dqGDS1PzVNyJ1AnK8c9XwmzhfqMSjIrelDiPBq0h0/FzTfxa8cnSuxfe08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715647; c=relaxed/simple;
	bh=RYmTT0r4uT5NE8nax7wNCaqb5cqJQp8qh/rv2Lnu7J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpJBhrCt2qQa5QRI6Zj9copBRayDSaM0/DBt5oTDI9w/1imbohmO4ggU+KHiyDU07DAyeuDpLZLfF+rixQiQgfpXyEqZyXobEmjdkU1ejqPRqQSa+Nw0dCdPVl9qGOGfGMoqf7jOLGPKq26h11H5fFn+sTQN0EXOYlMJogaj44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5lToEX9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so3616457a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 02:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737715644; x=1738320444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4GBuLkhv4jVWEGTfh7xan3AGSmg1wAWutHHDFlibm0=;
        b=I5lToEX91LJbKjMOS7P2qjnzFwz9mRD89A/Er7cdfjG+ohD3k6iJz9BNmMB2J/qkZT
         xkmMrnLYfpmzXWL6BErIrNBklP+OVx6OiyLt6XgFva62nLLPgdTbrTYIphAYgO52hw53
         ANUFRYdh4JFW4eXZ7Fvk5S2q7BEXb7qc4J/OXdq3M5WGw3Bppt0+Jlk0Ce484E5xQfu0
         39iKmJkFMR+u7VfGa0KqJbPg4UworH9FF9uaA7fSjbdR+fqIlUywKKxFWBqA66eDDbiW
         02Gns63GJlp4ev7uoB9gBsPFe9xj4Tn3dD6tOxznC4Nd1vKZUn4dtcUDcT8/m/wo3vDo
         JTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737715644; x=1738320444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4GBuLkhv4jVWEGTfh7xan3AGSmg1wAWutHHDFlibm0=;
        b=hUeKhX80ZAouqVU7IdGWJl5kNFfX1Okaekkg32Yl7rjCqMf+b42dZe0aTzpavVfb/W
         N5E6nCLegRCnKUtR9HUDvockApT5Nrn5RNQQpWMwoe0vcG7ip6dzZTmU7vkY71JOW1Il
         y3ytDF0TtgUg/ykJUPUqOD2KGSLYVJoJdIhTgUQ+jp3mSiG+7qIxMRZuNP2Vnic9iaDB
         zYl6CXihrsZMtgxWk9DGvYNd2gHkCCkoHZvvTeOmsvk79Rh33dm2kVEE29ek2Djn18rp
         W1L3AmCQPLI8mu3WsjXP+5MKJ7vUH/QJkf5mryebWEjeEnLrxFbvW6/ZPWDGukQk3l32
         NA7w==
X-Forwarded-Encrypted: i=1; AJvYcCUBccb6nzDRw/BGniS+1tFZ1M04spd1oPdbDVOUdwbXXHCtP1bkgNgBMtxvXf+d7hRPmcGxbs6tGV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUPuklyqbSeH+UbHa2dqbz0A9nGkXmKvg+gy+BxSM3ZrzWcNH
	U4Bpi+tfn9tLqu4DEdcS0EMj9FBvA2YVIxdrYUnLbwL1F1hOVFQaPHZHuEbOwfOAzM/a6178RvI
	zGQRfu7sMdtynf0oi914jns1fthc=
X-Gm-Gg: ASbGncsz77KnQ7AcGcTo6isP7w+6zAQ+ltqtdIfRTqEn5j0SIUNk2Dsx1FE1uutQiID
	lFDUMGQW/D3FDQFSYvsJZvhK8KgPlrEZ3kQTlNf8KhmW0Nfn9LVKYzi1D3n7zuQ==
X-Google-Smtp-Source: AGHT+IHq6Ktz50wkrziEoY+s6bpo2yvc19tSl7IUl6mT5hroELVcXDNSIvoyBdglQOHEOtKQBQd4I83nfKx7ReJ4FQI=
X-Received: by 2002:a05:6402:2813:b0:5db:731d:4456 with SMTP id
 4fb4d7f45d1cf-5db7db07839mr30306325a12.28.1737715644041; Fri, 24 Jan 2025
 02:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123195242.1378601-1-cel@kernel.org> <20250123195242.1378601-4-cel@kernel.org>
In-Reply-To: <20250123195242.1378601-4-cel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Jan 2025 11:47:13 +0100
X-Gm-Features: AWEUYZlEE5m-k2-KlRCdqw2dCWtmNTwMlwV6DDF5rMON4lM4imDT3y1YFsDsbLk
Message-ID: <CAOQ4uxhww-==KTaN-81XF5ke+D18=yLL6BjoSM9oQYJhB9DA3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] NFSD: Return NFS4ERR_FILE_OPEN only when renaming
 over an open file
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 8:52=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> RFC 8881 Section 18.26.4 paragraphs 1 - 3 tell us that RENAME should
> return NFS4ERR_FILE_OPEN only when the target object is a file that
> is currently open. If the target is a directory, some other status
> must be returned.
>
> Generally I expect that a delegation recall will be triggered in
> some of these circumstances. In other cases, the VFS might return
> -EBUSY for other reasons, and NFSD has to ensure that errno does
> not leak to clients as a status code that is not permitted by spec.
>
> There are some error flows where the target dentry hasn't been
> found yet. The default value for @type therefore is S_IFDIR to return
> an alternate status code in those cases.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 3ead7fb3bf04..5cfb5eb54c23 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1795,9 +1795,19 @@ nfsd_has_cached_files(struct dentry *dentry)
>         return ret;
>  }
>
> -/*
> - * Rename a file
> - * N.B. After this call _both_ ffhp and tfhp need an fh_put
> +/**
> + * nfsd_rename - rename a directory entry
> + * @rqstp: RPC transaction context
> + * @ffhp: the file handle of parent directory containing the entry to be=
 renamed
> + * @fname: the filename of directory entry to be renamed
> + * @flen: the length of @fname in octets
> + * @tfhp: the file handle of parent directory to contain the renamed ent=
ry
> + * @tname: the filename of the new entry
> + * @tlen: the length of @tlen in octets
> + *
> + * After this call _both_ ffhp and tfhp need an fh_put.
> + *
> + * Returns a generic NFS status code in network byte-order.
>   */
>  __be32
>  nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, in=
t flen,
> @@ -1805,6 +1815,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>  {
>         struct dentry   *fdentry, *tdentry, *odentry, *ndentry, *trap;
>         struct inode    *fdir, *tdir;
> +       int             type =3D S_IFDIR;
>         __be32          err;
>         int             host_err;
>         bool            close_cached =3D false;
> @@ -1867,6 +1878,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>         host_err =3D PTR_ERR(ndentry);
>         if (IS_ERR(ndentry))
>                 goto out_dput_old;
> +       type =3D d_inode(ndentry)->i_mode & S_IFMT;
>         host_err =3D -ENOTEMPTY;
>         if (ndentry =3D=3D trap)
>                 goto out_dput_new;
> @@ -1904,7 +1916,17 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
*ffhp, char *fname, int flen,
>   out_dput_old:
>         dput(odentry);
>   out_nfserr:
> -       err =3D nfserrno(host_err);
> +       if (host_err =3D=3D -EBUSY) {
> +               /*
> +                * See RFC 8881 Section 18.26.4 para 1-3: NFSv4 RENAME
> +                * status distinguishes between reg file and dir.
> +                */
> +               if (type !=3D S_IFDIR)

Maybe (type =3D=3D S_IFREG) here as well?

> +                       err =3D nfserr_file_open;
> +               else
> +                       err =3D nfserr_acces;
> +       } else
> +               err =3D nfserrno(host_err);
>

if {} else ; is a code smell with high potential for human
misreading of code.

Thanks,
Amir.

