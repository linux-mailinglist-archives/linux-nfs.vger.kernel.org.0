Return-Path: <linux-nfs+bounces-21165-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIZHFYAv72mb8wAAu9opvQ
	(envelope-from <linux-nfs+bounces-21165-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 11:42:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE034700E4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F59301BCEA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348413B2FF2;
	Mon, 27 Apr 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR7926+g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782E3B0AD6
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282825; cv=pass; b=sPkJPNmg5VrzarmPze8B9CkcWGXrP7a9qzFtRW9dCyTGrlI7bKdCns9B4Ov1JdDBRUn4cJPCcE2PHzqFLczbFUtqQ79TvAaGCA+ZEwaZAb8TVTBi9ndWPWpmbCv3tgkYjvx3z+uiYuKfm2Zc8x7dFFUbra/PXGsr1ZJQWeBaPTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282825; c=relaxed/simple;
	bh=QxjxYdcjttugdX8q9bsC/IDcAbQVs1MJeJaBjC5gmvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpPu0UIPi0fG2ckQndwmo6ik/h5Ej6zSFngG5dmuNbBhp2wXDj+/4MS6z/I/Vce//5WCYQeYu5efcC2cMLc434O+GDfWcdQN5P4mXmhSqQuXu6gBlNhGMyK9HCfnK+iMET+cp9DT40QjVFrCkW4Zvsm4lLBEHbzTBKYghbXCmPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qR7926+g; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8f97c626aaso712650266b.2
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 02:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282821; cv=none;
        d=google.com; s=arc-20240605;
        b=D/k0upa/svH+9Lmekhzus8U4D7PPTVPow7Quk0tw4WxO67IaP8IodYFwP8ePTYlwzk
         4HMxTdA/+xuw1rjyOmrry4k07c9I5hgSxMJEIrPzQhTUtUZZeKxeZOu/fi1HElsU/qnA
         2UZjzTkbz/6KqYIMffXSbaWOLWpaS1ocshPY+3f0GKj4+Ah2ZWUk0o/kVa3fi+p+o7wD
         xUVLkj1bztt23KwZJTJlat0uAK8xSUVJEZ5qlquRNpO46qe2rbpktL5nExgV+ys8LG8j
         wyGIVrADwvlNlZ36yMuKRtS5cGbMS4eYt20xnqFIox6PWUJVFEci+SIiTsx+oEm4rbEH
         h0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eJPntPFRD6O40TV+kw1mFLfFz9WnpFXdrxU/541rVbo=;
        fh=WI7j1eUl/d1dWh+ZeDpt87prVtoPNjux6vWvtMQo2A4=;
        b=JwDYpsg0PwqqiDeKkBvs+uHRxHmOo8qKUU/i4Y40EXqJJ8bnprkqrlT0RUql2aiTYN
         1Zrq4V9YLS6RcWJs+aCMOQo6xXe+WlB+08U5qFvYndYbIhvSbxEspT1o6MIelb8Se8h8
         DVf3Qn3ohrN4siEHhaicp49CFZUAnAnsAHT3NenwBMUtpJ0sEaCUqmiIGw0KULGgUOLH
         M4QN5kAbD5la4CVea74N/ZxzeZG2G23V8/tOMPDsH1ZY53f8cDKxCtcLH6x8dyU8KXjL
         7M8yGzb0M8d+880QCfz0lOCY6uDmmt4ThlCWHX35zSwSqUz6au6YF6xM2r/Gs2DRY9NL
         8ZWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282821; x=1777887621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJPntPFRD6O40TV+kw1mFLfFz9WnpFXdrxU/541rVbo=;
        b=qR7926+gI5Rjc3lstYAMzrMjqGywpZ3iiFQbJLJV7dAmZe1DujXErD9OxX7uW/So+8
         rC2iIBoSUvCuij+eDq7H/oC+lkn4irs3U2K1facE3XR/kU+zhANhJ/nJkqAs4wc7Y4EX
         Sgc7pdtLUoMsZrRFyc073idnYPJhXupV5uF3mMp7xROI/MYeJxLePoF0BE/pmdOf/40y
         HbqBxcKIWGLHVlW4LXMSRJw2ik6wMvpd+iDAXnxYN3+GxtxVWS5FTIVm+k64VjxOBHDd
         WsY8F859X/+oEfi0VNnn8+vNxVL8z4MsEom/vpT64M5hLGa/rOwAR9Gvp5x+Lz03DRq4
         IeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282821; x=1777887621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eJPntPFRD6O40TV+kw1mFLfFz9WnpFXdrxU/541rVbo=;
        b=bhqFsLid2DOtCASvsXGMQiQE+shHV7pU/ltIucKdqtEswwwfiKhI4U7766icMDbxDY
         h2g3U9FzwZx29At7XWrUO0vxRz1Hl2QEgF4dEro8yeObLa/STLDOIyhFAKR+4Rb5E+n+
         04eSdYCvKC5uz0SYjzmEtIiietnMplG+uy8/5ZaGHwgK6OG6Nj8Uwb56H8kug3bGLfnY
         3XAX1/6xK1kwfqCaWj5KK/S8lBgdDlyUKhsrF3bwqARDElcFbQLE6WteGPacE3SYF4YT
         aTGDAp8uSrQjjsq/DtThcEzjAo4aBTLuDFkw5AHtRrc1nHy81HrT95ndoO3rBHHAX/JT
         nHAw==
X-Forwarded-Encrypted: i=1; AFNElJ+Dv3B5VHf5Iy4t4fzP/rNLOlM68Q+iHGnDqxbNtelvay6qsSEQ52UH49WxTd3nwwqt9m+TGCABwm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtZwejqdhYmoo/cjGyTApaD+KpnEBYauJoo/nxMokyMCQGEu9
	tVwvqA+KylxHJrX0M/z7IFcClzTLlzK0f3BQU1V2LeRpds3NxQJrBrpGs7o4MX8jrzUH7CmVqPh
	wGxn8XRwiziy3ExlNABNA/dEPeKqVmQ0=
X-Gm-Gg: AeBDiesF1Yc74001VFRR9eANzbAdy6Rs9xtj2kC0g1bEUkVDCICZR1zh06c15QV+URK
	WIl4fZ7HynLAlSaioLjGrvAEq2vYgLpcdvs5HgoY0CY50uaJrH1dT4NS2254zZnzJ6qgXgLzMJH
	UWKVYFnn/pfP+fES4M4IJrxeQDm4Myv+FTgJ+2CzAyKUn6rlT34sv5IjVn/YXk6z/QxbW8pNoez
	8Y6ZzCd/SgXOz3sL4SsPS6w71LTVkjWtfGfk7SpQGhyNvfwrEM5aqnla8zKr1Pw38VJP8Rvb1hw
	1WekdaZZEUZBtwLDus12yTFCKfTcpi0kRNtIBEBrMDyJvAh9jm/x
X-Received: by 2002:a17:906:794a:b0:bae:642a:8712 with SMTP id
 a640c23a62f3a-bae642a8acamr610964266b.26.1777282820632; Mon, 27 Apr 2026
 02:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-11-neilb@ownmail.net>
In-Reply-To: <20260427040517.828226-11-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 11:40:09 +0200
X-Gm-Features: AVHnY4J3KNER9PTYdOScy1O62XxZbu1ceyhpVX-P8SPS4H3ApKZi7SEKX41AuMQ
Message-ID: <CAOQ4uxiZF0_dGtHY0x7T0oh=3jhDC7-THH_ANt-Ha5kfdRe4QQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/19] VFS/ovl: add d_alloc_noblock_return()
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EFE034700E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21165-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ownmail.net:email,brown.name:email]

On Mon, Apr 27, 2026 at 6:07=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> ovl_lookup currently needs to check if a dentry with the same name has
> already been added to the dcache as readdir might need to do.  This
> is an unnecessary performance cost to manage a rare race.
>
> If ovl could know which in-lookup dentries raced with readdir, it could
> limit the extra lookup to just those.
>
> So add d_alloc_noblock_return() which provides the in-lookup dentry when
> it returns -EWOULDBLOCK.
>
> ovl_readdir() can use this this and flag the dentry such that
> ovl_lookup() and easily check if a repeat lookup is needed.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Very nice!

One nit about the API

> ---
>  fs/dcache.c              | 50 ++++++++++++++++++++++++++++++++++++----
>  fs/overlayfs/namei.c     | 23 ++++++++++--------
>  fs/overlayfs/overlayfs.h |  2 ++
>  fs/overlayfs/readdir.c   |  7 ++++--
>  include/linux/dcache.h   |  2 ++
>  5 files changed, 68 insertions(+), 16 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index a2ddfe811df3..2f11257b725b 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2749,7 +2749,8 @@ enum alloc_para {
>  static inline
>  struct dentry *__d_alloc_parallel(struct dentry *parent,
>                                   const struct qstr *name,
> -                                 enum alloc_para how)
> +                                 enum alloc_para how,
> +                                 struct dentry **dentryp)
>  {
>         unsigned int hash =3D name->hash;
>         struct hlist_bl_head *b =3D in_lookup_hash(parent, hash);
> @@ -2836,7 +2837,10 @@ struct dentry *__d_alloc_parallel(struct dentry *p=
arent,
>                         case ALLOC_PARA_FAIL:
>                                 spin_unlock(&dentry->d_lock);
>                                 dput(new);
> -                               dput(dentry);
> +                               if (dentryp)
> +                                       *dentryp =3D dentry;
> +                               else
> +                                       dput(dentry);
>                                 return ERR_PTR(-EWOULDBLOCK);
>                         case ALLOC_PARA_WAIT:
>                                 wait_var_event_spinlock(&dentry->d_flags,
> @@ -2899,7 +2903,7 @@ struct dentry *__d_alloc_parallel(struct dentry *pa=
rent,
>  struct dentry *d_alloc_parallel(struct dentry *parent,
>                                 const struct qstr *name)
>  {
> -       return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
> +       return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT, NULL);
>  }
>  EXPORT_SYMBOL(d_alloc_parallel);
>
> @@ -2931,11 +2935,49 @@ struct dentry *d_alloc_noblock(struct dentry *par=
ent,
>
>         de =3D try_lookup_noperm(name, parent);
>         if (!de)
> -               de =3D __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
> +               de =3D __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL, =
NULL);
>         return de;
>  }
>  EXPORT_SYMBOL(d_alloc_noblock);
>
> +/**
> + * d_alloc_noblock_return() - find or allocate a new dentry
> + * @parent - dentry of the parent
> + * @name   - name of the dentry within that parent.
> + * @dentryp - place to store the blocking dentry
> + *
> + * A new dentry is allocated and, providing it is unique, added to the
> + * relevant index.
> + * If an existing dentry is found with the same parent/name that is
> + * not d_in_lookup() then that is returned instead.
> + * If the existing dentry is d_in_lookup(), d_alloc_noblock()
> + * returns with error %-EWOULDBLOCK and the blocking dentry is passed
> + * in @dentryp.  The dentry must be dput() by the caller.

This contract is a bit subtle.
We have plenty of contracts where the caller must dput() in case of success
or in case of error, but must dput in case of a specific error that
sounds fragile.

How about:
* If the existing dentry is d_in_lookup(), d_alloc_noblock()
 * returns with error %-EWOULDBLOCK and the blocking dentry is passed
 * in @dentryp. Regardless of the returned error, if @dentryp is set by thi=
s
 * function, the returned dentry must be dput() by the caller.

Thanks,
Amir.

> + *
> + * Thus if the returned dentry is d_in_lookup() then the caller has
> + * exclusive access until it completes the lookup.
> + * If the returned dentry is not d_in_lookup() then a lookup has
> + * already completed.
> + *
> + * The @name need not already have ->hash set.
> + *
> + * Returns: the dentry, whether found or allocated, or an error
> + *    %-ENOMEM, %-EWOULDBLOCK, and anything returned by ->d_hash().
> + */
> +struct dentry *d_alloc_noblock_return(struct dentry *parent,
> +                                     struct qstr *name,
> +                                     struct dentry **dentryp)
> +{
> +       struct dentry *de;
> +
> +       de =3D try_lookup_noperm(name, parent);
> +       if (!de)
> +               de =3D __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL,
> +                                       dentryp);
> +       return de;
> +}
> +EXPORT_SYMBOL(d_alloc_noblock_return);
> +
>  /*
>   * - Unhash the dentry
>   * - Retrieve and clear the waitqueue head in dentry
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 69032eb2b1e2..524e661c3c8d 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1400,16 +1400,19 @@ struct dentry *ovl_lookup(struct inode *dir, stru=
ct dentry *dentry,
>         if (dentry->d_name.len > ofs->namelen)
>                 return ERR_PTR(-ENAMETOOLONG);
>
> -       /*
> -        * The existance of this in-lookup dentry might have forced
> -        * readdir to do the lookup with a new dentry.  If so we must
> -        * return that one.
> -        */
> -       alias =3D try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
> -                                           dentry->d_name.len),
> -                                 dentry->d_parent);
> -       if (alias && !IS_ERR(alias))
> -               return alias;
> +       if (ovl_dentry_test_flag(OVL_E_RACED_READDIR, dentry)) {
> +               ovl_dentry_clear_flag(OVL_E_RACED_READDIR, dentry);
> +               /*
> +                * The existance of this in-lookup dentry might have
> +                * forced readdir to do the lookup with a new dentry.
> +                * If so we must return that one.
> +                */
> +               alias =3D try_lookup_noperm(&QSTR_LEN(dentry->d_name.name=
,
> +                                                   dentry->d_name.len),
> +                                         dentry->d_parent);
> +               if (alias && !IS_ERR(alias))
> +                       return alias;
> +       }
>
>         with_ovl_creds(dentry->d_sb)
>                 err =3D ovl_lookup_layers(&ctx, &d);
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index b75df37f70ac..bd6f1a25aca1 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -71,6 +71,8 @@ enum ovl_entry_flag {
>         OVL_E_CONNECTED,
>         /* Lower stack may contain xwhiteout entries */
>         OVL_E_XWHITEOUTS,
> +       /* dentry was found in-lookup during readdir */
> +       OVL_E_RACED_READDIR,
>  };
>
>  enum {
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index e03b32491941..e483bd939a8c 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -553,7 +553,7 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
>  {
>         struct dentry *dir =3D path->dentry;
>         struct ovl_fs *ofs =3D OVL_FS(dir->d_sb);
> -       struct dentry *this =3D NULL;
> +       struct dentry *this =3D NULL, *in_lookup;
>         enum ovl_path_type type;
>         u64 ino =3D p->real_ino;
>         int xinobits =3D ovl_xino_bits(ofs);
> @@ -574,7 +574,8 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
>                 }
>         }
>         /* This checks also for xwhiteouts */
> -       this =3D d_alloc_noblock(dir, &QSTR_LEN(p->name, p->len));
> +       this =3D d_alloc_noblock_return(dir, &QSTR_LEN(p->name, p->len),
> +                                     &in_lookup);
>         if (this =3D=3D ERR_PTR(-EWOULDBLOCK)) {
>                 /*
>                  * Some other thead is looking up this name and will
> @@ -583,6 +584,8 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
>                  * lookup gets a turn it will find and return this
>                  * dentry.
>                  */
> +               ovl_dentry_set_flag(OVL_E_RACED_READDIR, in_lookup);
> +               dput(in_lookup);
>                 this =3D d_alloc_name(dir, p->name);
>         }
>         if (!IS_ERR(this) && !d_unhashed(this)) {
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 662b98185337..db7cdcbac775 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -258,6 +258,8 @@ extern struct dentry * d_alloc(struct dentry *, const=
 struct qstr *);
>  extern struct dentry * d_alloc_anon(struct super_block *);
>  extern struct dentry * d_alloc_parallel(struct dentry *, const struct qs=
tr *);
>  extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
> +extern struct dentry * d_alloc_noblock_return(struct dentry *, struct qs=
tr *,
> +                                             struct dentry **);
>  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
>  struct dentry *d_duplicate(struct dentry *dentry);
>  /* weird procfs mess; *NOT* exported */
> --
> 2.50.0.107.gf914562f5916.dirty
>

