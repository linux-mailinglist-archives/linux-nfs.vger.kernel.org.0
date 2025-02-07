Return-Path: <linux-nfs+bounces-9943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF7CA2CC52
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 20:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52B53A5B67
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D880192B6D;
	Fri,  7 Feb 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GKim8lt4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BFC10E5
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955410; cv=none; b=su9lMVClNiqUIGRx1whH00wNbplP6zfcAzCM/Yi9VYBTplB95M+Ji4piYbWIrTqVaeof4oca5PJ6H1QQ8M0ZeChCuq78VOvuRENc31Ad9wPIlr2Dr2IFdKiuz3AamMy2u2D9iJBCJp3erJ0aQXWDlnZz26E7Z2bXRRRW1GIEE3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955410; c=relaxed/simple;
	bh=L3hBF+iQrBKTRIa3wKiXJJ/OQyIh4KsyTMz0Xy+5S4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtKR52/rkp/CPfFCHSbuGeFUW+U8Lc9qyqold1xPbFK2w96n4AcItWT3t9ipkV3PGpPj41hFxULO+uMw7urse7BVe1Z2NkxiEBrxr7Q7aw6Zt6FQCgtdGwJvu2I43EVn0TYc37qW5U/IKdtqI9+o4kGFubJEdHb1/dJ22bCN63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GKim8lt4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6715734d9so22297127b3.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Feb 2025 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738955406; x=1739560206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om2VSE738EF+Gy11pRhlx9VqvfBmWOXzuPiTJvCwuz4=;
        b=GKim8lt4SXP5kCoh/4cTxGCOS0NFKc37s/H8tESJs+gNOMv7ToQFj9aCC6gXDOyZFW
         HLxSttUGftYuYAnyZLRg40Zjxvlf+AWJp8XZhkFbbWk1U2XHw2B6BMJCaOy4FE3fPdpW
         Unfpfmv2KhLrQ0n6jpymXy/CUq2x15XKxIBQ0mhxWAURjkNVKfJwfsEDRlZ88+bThbLy
         S7h6oS6qz2gkxd30lZv9rMUCNFRCH6fquC2+bZCWmiLNNARvDStxMgbCi1NfsA9chIbC
         +jyROlyUVDutZjFEJL45IVc2NMcmVq07hYptArEUCcGxbrzeWHvGJD2J5f1lTQrXqPxp
         7fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738955406; x=1739560206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om2VSE738EF+Gy11pRhlx9VqvfBmWOXzuPiTJvCwuz4=;
        b=w4C1GafR5my2ozxpnGtSiOSNKrwsralxwyWoQ9m9F84U0tHwJhV0ClA4OXohr5pyAi
         52iOPr7wEdj+iUfycixgaROxKTJmuHD9RL7Vp/FK71R/EpYet2WhxzILo/Azvf7EXyvT
         FWGSlzKLfao+fDs4sUorVXD/g16KTMKcabdLpNg2FlgCPrtwk6niGqstp/i03yal3gI4
         gk0dcGEGEnCK5cI9Ya6PXP/BI9jEBv5XpFiOukimXlivap2OG5v179u+993CzsF8jhCl
         o/PVYslXguFiOYeEuzJhK/1YEB1pjIniRBT/DjVtK7s5w/Ax/25gb2uyOi/o4IoSOEwp
         hz5w==
X-Forwarded-Encrypted: i=1; AJvYcCVuZA4JF8lCIs5sQr/HIteX6Bcbvu5D0DJURKlFaR/J3rvoJgUY5+Ol0cscNdtAhJRsxtykWYg3BmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SkqJQfxgMlLYpdsULJeudeYm7cEGrFsM7gqcmpzl0JOHW6/n
	wA+SmCH5hpQry8RQOLY/XWr5KW3iqss6Lqz0DJ89ssNG1SpqkAJPdlSv6869Zto1b5NOXLSq1DB
	mMzaf5qQ3spe6hQlwEJt8LasWzfbuBKB8jmia
X-Gm-Gg: ASbGnctnuKDdFmzYYWWpcboSj+ZJOfV4vV4MGwR2G/75UdWJZKLHUY8bd8skhsa7e2i
	9Bg0X3kiakvb3BrbjO+oFDVYRyL57om612VFbplZjDgxrsPCiv4N8ikDaAu1KBTEN6rExEQk=
X-Google-Smtp-Source: AGHT+IGK+1YaMF/yB5tZ88LHxwIuQM3/Gj8AOscWWTmOeYR+q9GoKPuGwr2TcabPJS4LqujSyvfXsbiPIUAyuUzPzSo=
X-Received: by 2002:a05:690c:3804:b0:6f9:97bd:5a63 with SMTP id
 00721157ae682-6f9b2844e3cmr39923927b3.4.1738955406214; Fri, 07 Feb 2025
 11:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207034040.3402438-1-neilb@suse.de> <20250207034040.3402438-2-neilb@suse.de>
In-Reply-To: <20250207034040.3402438-2-neilb@suse.de>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 7 Feb 2025 14:09:55 -0500
X-Gm-Features: AWEUYZl_WdQaatK919wx4Q8t6Nn6ccb6OCvCp4tV_BELcL0JYxwXteOCsEvAF2g
Message-ID: <CAHC9VhTnVg-5C75qY8NkfKs4tjbVz62Vk=SVXS2mwH0f3ftLhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <sfrench@samba.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:41=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> No callers of kern_path_locked() or user_path_locked_at() want a
> negative dentry.  So change them to return -ENOENT instead.  This
> simplifies callers.
>
> This results in a subtle change to bcachefs in that an ioctl will now
> return -ENOENT in preference to -EXDEV.  I believe this restores the
> behaviour to what it was prior to
>  Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/base/devtmpfs.c | 65 +++++++++++++++++++----------------------
>  fs/bcachefs/fs-ioctl.c  |  4 ---
>  fs/namei.c              |  4 +++
>  kernel/audit_watch.c    | 12 ++++----
>  4 files changed, 40 insertions(+), 45 deletions(-)

...

> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 7f358740e958..e3130675ee6b 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -350,11 +350,10 @@ static int audit_get_nd(struct audit_watch *watch, =
struct path *parent)
>         struct dentry *d =3D kern_path_locked(watch->path, parent);
>         if (IS_ERR(d))
>                 return PTR_ERR(d);
> -       if (d_is_positive(d)) {
> -               /* update watch filter fields */
> -               watch->dev =3D d->d_sb->s_dev;
> -               watch->ino =3D d_backing_inode(d)->i_ino;
> -       }
> +       /* update watch filter fields */
> +       watch->dev =3D d->d_sb->s_dev;
> +       watch->ino =3D d_backing_inode(d)->i_ino;
> +
>         inode_unlock(d_backing_inode(parent->dentry));
>         dput(d);
>         return 0;
> @@ -419,7 +418,7 @@ int audit_add_watch(struct audit_krule *krule, struct=
 list_head **list)
>         /* caller expects mutex locked */
>         mutex_lock(&audit_filter_mutex);
>
> -       if (ret) {
> +       if (ret && ret !=3D -ENOENT) {
>                 audit_put_watch(watch);
>                 return ret;
>         }
> @@ -438,6 +437,7 @@ int audit_add_watch(struct audit_krule *krule, struct=
 list_head **list)
>
>         h =3D audit_hash_ino((u32)watch->ino);
>         *list =3D &audit_inode_hash[h];
> +       ret =3D 0;

If you have to respin this patch for any reason I'd prefer to move the
'ret =3D 0' up to just after the if block you're modifying in the chunk
above, but that's a trivial nitpick so please don't respin only for
that.  Otherwise it looks fine to me from an audit perspective.

Acked-by: Paul Moore <paul@paul-moore.com> (Audit)

>  error:
>         path_put(&parent_path);
>         audit_put_watch(watch);
> --
> 2.47.1

--=20
paul-moore.com

