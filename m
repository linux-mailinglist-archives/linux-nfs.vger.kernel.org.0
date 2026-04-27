Return-Path: <linux-nfs+bounces-21158-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NHKM6YV72kv6AAAu9opvQ
	(envelope-from <linux-nfs+bounces-21158-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 09:52:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 930DF46E9EC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 09:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28C3F301DC1E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5D3976AE;
	Mon, 27 Apr 2026 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf5ppi9A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAC3976A7
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276193; cv=pass; b=GUSc40ka++IIuqTOjevbFOlrEmmAA6GQ86P/mJIzOldPmG6z7W2Bel9vDv7IFiyOaJM+qzE4SdEqyYWmEE8SB4OrECHVb6ThBQelxmZwNfPt27aZlIJyU01dMVTHErOcubbPbfdMon4b7w0xcCWq7DVrtX+N1GBx63T99Ux3X5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276193; c=relaxed/simple;
	bh=f7OgKalAyVt5gmyU2LJSzNsZnB4DtET7GNZ8+Zt9tWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seD5uKLa4oTua4W+oKEzNpy7uDv1MPKL85/l2naPnumkHH5h12lDlntWPIsM48Wq4cL9R23JLgQbBKmpMHaa16iBaRW+6oiksnCfFLQ5jRrMBoxscKUW4yFmvIPCMq1bBgUi15RWdE4IgxahiZ5zomomtmpu92H3Q90m5GjLvgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf5ppi9A; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba545100a13so1050956166b.2
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 00:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777276190; cv=none;
        d=google.com; s=arc-20240605;
        b=MfGCnnOF7hsbWyc08l2EVbH3zXX87wjwc8Tb970R69QWUqjUgssMbddXLKEVeLiPtm
         grCZvuB4H+CosPQFb7qXCgoDZyeB/8fasZEPA9amLk2gQ3YvQymPjqM33ZY2bGSw2Nta
         X9EahZpOGQEIE9nD7aK6VsSiGeyWybxYNuOL+y2pLU9y261c0j2hIlqVkjxna7FSNxFA
         sj45RkbjZMkBtRm4CLiVyGeL38H5mww8eciYK94O2ADuYrtjnNv45q27NaWdW9W0Dxqk
         1lo8X1uC0UQXcP0t9Sb3Tx8ei9fwgDYNEHHam5yLS47Q67b0wUfmiFjrrRRtJebWdQcS
         Ps5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+JJEH7a7ZgWwJ+BUNcwUv/jdbyBTQx+IMzVRjmXkV4=;
        fh=HfFOq6bhdcpMAIijDmW71UchxgI7lwOYNgntblqo+Ls=;
        b=UHtNnc+OppijRHPjEh/JDinSoNP8HM1hor5ai3qaZz+szS2UiTXSatAS4cJykpMq6c
         toHE2xRu2Qhmd8acx2U5hfi8GeL9J25UIvZqYF5tWLIIAi1GYTvfdOAM82bR0/Fcx2cB
         MFUQp/uvDDyqVztM8KFV80HL49jbKJfJxOxRAn2HWrVF3qKU3BIrxGKMGZzVgxIF0SCh
         ST1Nt2fzPa+mR8KvJ6xKB8b9qK778rJD58M4FkiFO9HLugNhnSlMkVBitT7pcmeJQGtY
         P/JYvaw+e72c+YFxsZCVTpjlQR/e6iIc/GvfNbgxJEKnMmG5AVKN8EgXVokC2vrrUyeK
         h2SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777276190; x=1777880990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+JJEH7a7ZgWwJ+BUNcwUv/jdbyBTQx+IMzVRjmXkV4=;
        b=Lf5ppi9ArV3tMF4TQI1tAC9lpKfF6UauWPDSK4QmAzWkDz445wbNgYCno88v7X0XbD
         VT4/2UAahAj7BPtuPfPIDzL7dOadMKIyWTCT6rF/ukqMZAIGIckYT4HDod6oSGb2zDNv
         j3GQddJ5sDWomFGzwAmORYvdN8WC+CI+iQipilmJ6w/tMAVoXA8I3hjFRx159tHzYZnH
         hRp/l1FOVr6KBn4F4SiNWO6slthc373Hi9zhjcsloCwYmG8oiu9zTNbfegZCB8p7dV++
         VmVGiNU4Vs4aNhireAP3YhcditlXAX0/zuSWuMJEZ+f2idZ962Yk1+Zx6eB8ZgEQ1HBf
         i6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777276190; x=1777880990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M+JJEH7a7ZgWwJ+BUNcwUv/jdbyBTQx+IMzVRjmXkV4=;
        b=Hn73HKimkmILVij9WJqrufQ9KloS7S7HyGL1etHzdSHkR9/ynBIB4NCtY8I9tbPakd
         JdWq7sqWkfq8WmzFFJHfusaS+lEzqjXvKO1owO5H5/PNB4BGP6aXJJgBPGjnds4+K3lq
         pNJ/V3ynyXA+zUC7o7oJ859bqqCEqMmhmvCf0XBVdBkStSJqXzzgwn2xRZEW1fDs73Is
         elMub0EB9JfTxPjJvz9mSvIyxuaYPgY3GqZTTEK7j/EXhRgwKTxDgoiXmbhkpDWdO+wX
         zyfe26tmY50HDwn8BirdS7858oy5ZMbo8R3Qv+LxZNtLshaYRR6dyEpikNHBDWsKJoBI
         zlbw==
X-Forwarded-Encrypted: i=1; AFNElJ9Vn29LTLTFAaGKYok+zDV6H9eFY93EX8JwFVQ/8CgTQnlltDScYNsgfhzSoxTulSUkPXZQ9fW4WsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOe2xDOMtjL3NFVfx3KC45iQvRQu6kOFmGT4Usey2qt6wVOVL
	gseXpdTDh3IUV1mzMC1tzmMoUUdjMmH/MvvRfpX0YfwfBc5ATBty49yqxbK5R4cPsxKVqu42XOo
	xMUJBCIYcX5iMcfPyOTPls+VmFobkASA=
X-Gm-Gg: AeBDiesQnTjWnBGftiUmUBhE1TnewyI20ux/8LLLJ59UzH7yjKEZxaI1BSN2nLSYKxV
	ExqVX4wEoJ3i8vvrmKHMEJ64jxtrwKwO8nkfpMsYeKnyW9Ba78ZWmceENf0yKlsM0NE0K7kZlOD
	uY6AFlxN18eIZpMNqr1okyohkZEBNvd36AYYEnPNPDoo6WnEzTh4GAxujIrtUr446o+TM/xc7mn
	z8+rxTEMlpCavUaYSVd9Nqa7ILgv1h5e/4jyTz7FbBgbGwVRY27rLMJ4Vd+F2Nxf6XEiJeKPrED
	HOJpINL3b1j6QkhqYj5FxK6ttJ6RbuKu0/sbIJWUUzdtihHrXEtl
X-Received: by 2002:a17:907:a604:b0:b9d:6a05:64ab with SMTP id
 a640c23a62f3a-ba41828cbb9mr1910538866b.8.1777276189333; Mon, 27 Apr 2026
 00:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-9-neilb@ownmail.net>
In-Reply-To: <20260427040517.828226-9-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 09:49:36 +0200
X-Gm-Features: AVHnY4KLQlNudAoMusC5eQkonz2WBnBqsh6v2a9sQQCshqNF5gfekEomngG1TZA
Message-ID: <CAOQ4uxjj6iJNnwUqV+cRtqo4qRD4v-f-ct92=ofCZWPDATXM7g@mail.gmail.com>
Subject: Re: [PATCH v3 08/19] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 930DF46E9EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21158-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:email,brown.name:email,dname.name:url]

On Mon, Apr 27, 2026 at 6:07=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> A proposed change will invert the lock ordering between
> d_alloc_parallel() and inode_lock() on the parent.
> When that happens it will not be safe to call d_alloc_parallel() while
> holding the parent lock - even shared.
>
> We don't need to keep the parent lock held when d_add_ci() is run - the
> VFS doesn't need it as dentry is exclusively held due to
> DCACHE_PAR_LOOKUP and the filesystem has finished its work.
>
> So drop and reclaim the lock (shared or exclusive as determined by
> LOOKUP_SHARED) to avoid future deadlock.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/dcache.c            | 18 +++++++++++++++++-
>  fs/ntfs/namei.c        |  4 +++-
>  fs/xfs/xfs_iops.c      |  3 ++-
>  include/linux/dcache.h |  3 ++-
>  4 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 569a8ddf4c0d..a2ddfe811df3 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2294,6 +2294,7 @@ EXPORT_SYMBOL(d_obtain_root);
>   * @dentry: the negative dentry that was passed to the parent's lookup f=
unc
>   * @inode:  the inode case-insensitive lookup has found
>   * @name:   the case-exact name to be associated with the returned dentr=
y
> + * @bool:   %true if lookup was performed with LOOKUP_SHARED

I do not understand the choice of API.
Seems better to pass the lookup flags and avoid exposing this very internal
logic in the call sites...

>   *
>   * This is to avoid filling the dcache with case-insensitive names to th=
e
>   * same inode, only the actual correct case is stored in the dcache for
> @@ -2306,7 +2307,7 @@ EXPORT_SYMBOL(d_obtain_root);
>   * the exact case, and return the spliced entry.
>   */
>  struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
> -                       struct qstr *name)
> +                       struct qstr *name, bool shared)
>  {
>         struct dentry *found, *res;
>
> @@ -2319,6 +2320,17 @@ struct dentry *d_add_ci(struct dentry *dentry, str=
uct inode *inode,
>                 iput(inode);
>                 return found;
>         }
> +       /*
> +        * We are holding parent lock and so don't want to wait for a
> +        * d_in_lookup() dentry.  We can safely drop the parent lock and
> +        * reclaim it as we have exclusive access to dentry as it is
> +        * d_in_lookup() (so ->d_parent is stable) and we are near the
> +        * end ->lookup() and will shortly drop the lock anyway.
> +        */
> +       if (shared)
> +               inode_unlock_shared(d_inode(dentry->d_parent));
> +       else
> +               inode_unlock(d_inode(dentry->d_parent));
>         if (d_in_lookup(dentry)) {
>                 found =3D d_alloc_parallel(dentry->d_parent, name);
>                 if (IS_ERR(found) || !d_in_lookup(found)) {
> @@ -2332,6 +2344,10 @@ struct dentry *d_add_ci(struct dentry *dentry, str=
uct inode *inode,
>                         return ERR_PTR(-ENOMEM);
>                 }
>         }
> +       if (shared)
> +               inode_lock_shared(d_inode(dentry->d_parent));
> +       else
> +               inode_lock_nested(d_inode(dentry->d_parent), I_MUTEX_PARE=
NT);
>         res =3D d_splice_alias(inode, found);
>         if (res) {
>                 d_lookup_done(found);
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 10894de519c3..30dddef43300 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/exportfs.h>
>  #include <linux/iversion.h>
> +#include <linux/namei.h> // for LOOKUP_SHARED

... this won't be needed

>
>  #include "ntfs.h"
>  #include "time.h"
> @@ -310,7 +311,8 @@ static struct dentry *ntfs_lookup(struct inode *dir_i=
no, struct dentry *dent,
>                 }
>                 nls_name.hash =3D full_name_hash(dent, nls_name.name, nls=
_name.len);
>
> -               dent =3D d_add_ci(dent, dent_inode, &nls_name);
> +               dent =3D d_add_ci(dent, dent_inode, &nls_name,
> +                               !!(flags & LOOKUP_SHARED));
>                 kfree(nls_name.name);
>                 return dent;
>
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 325c2200c501..f03d832f1468 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -35,6 +35,7 @@
>  #include <linux/security.h>
>  #include <linux/iversion.h>
>  #include <linux/fiemap.h>
> +#include <linux/namei.h> // for LOOKUP_SHARED
>
>  /*
>   * Directories have different lock order w.r.t. mmap_lock compared to re=
gular
> @@ -369,7 +370,7 @@ xfs_vn_ci_lookup(
>         /* else case-insensitive match... */
>         dname.name =3D ci_name.name;
>         dname.len =3D ci_name.len;
> -       dentry =3D d_add_ci(dentry, VFS_I(ip), &dname);
> +       dentry =3D d_add_ci(dentry, VFS_I(ip), &dname, !!(flags & LOOKUP_=
SHARED));


... and this ugliness could be avoided.

Thanks,
Amir.

