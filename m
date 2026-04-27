Return-Path: <linux-nfs+bounces-21166-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMzeEbY372nV+QAAu9opvQ
	(envelope-from <linux-nfs+bounces-21166-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 12:17:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B0470C6E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2F8F3074423
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157D83B4E8A;
	Mon, 27 Apr 2026 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWxtLhyu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD63002BD
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284644; cv=pass; b=CBoC7TZFRz3NXOjy2CGBpIPrYg4LsG4IhpnK/4gJe2b9QdT2ftpCwjsmvXQS5M1rroh8Iev+cFOZ7yFrpEAkMcYl2KV8kC1y/Jgez+M7b4JHsdTQFY6SLXMWhNDLVztiLG0FZcnIRglGYqU24h0hOyr67KjGpEaFK7ll25R3DvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284644; c=relaxed/simple;
	bh=UE+DJnE2oj0vFOXp+m3XTb9AY/fwBqMnmmO9cLxXoJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpgPCwBAGNWeXiJ4GZINDMZy/ROHx8c72bfABsE4XscDYyyjdqAp4q0UMiWoyCUanodsWpwugMSXbgzD1qI7Cv8zQ4sbbW7t+/0jqLgAWMnTDSyMD8giWFsm/N9Y9Ly782+mcjt2DfyEGC3yU+5Ygx+hoLhmc56BX0G/NKnHjXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWxtLhyu; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so10026686a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 03:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777284641; cv=none;
        d=google.com; s=arc-20240605;
        b=IQe+ynY6iQFXaEhbGgx5jOLrkJpm048+tlK8GrLpoeR+q5hZUTh2sbY+YSq+CkV76F
         gDdzwUiyfwVUSnbMvg/JEYIDrwLerHVF1ZdPaDqO8VkqYzlUAA770L+NiL1tR2OX8MQb
         rK84/AH7/+f2AKN6GDtbiFXkkb/tTM41Rrrkpa0WAjCVLs3i5fLQCY1xRM8w6OjkhDt4
         3jpSLtorjCvWALS6Q6vFD41FzrsbnuKTFLs1np5lxvo2b8KJJvzFsA7OBMQAKMzo2l59
         t/Htz/uuOyWYhahMc9YdzEJG6aUQVyCosgs6IzA//VVHMHsCg+/14+nTGhGUlUnq43yU
         pJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iKRwDoHSf2+oXdi49CMbzE7n/0K7hTCuX9atPHgXxI0=;
        fh=Rdb2aLBg0MkkQ/aKjDmelOpmpK04mN+9BpUkihj6ZCg=;
        b=UzmYXahWhRQpGsqbOcHMzM4GRMMA7YY+y/kqx1ndcYnt0sl9NUaTmz1tK8mi4le4IF
         Sgudy93sNh4K+qilXVaqH/YneVurjVpQWHtqAk3vIUphN2BinT5wUYJktmRBFn6fHq4A
         rYSuMseM5e+oSVSrTtF0PdXW0TQCkj7bO8tjpredc798ybi63767iTRvdyLYj5PZUbd1
         3y75i4JYL48dyuYj6ai94aWymwfMVIS3i2YTzgauzeM5OTpn6YTpPZC5fhx6ezGemhhs
         yHTc3KqKUrvBPpZ8uySaUVsnLfu4eC0OdEELW7I7gFeuD26i03iAfbOXXye0Jpo6hf0v
         MqWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284641; x=1777889441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKRwDoHSf2+oXdi49CMbzE7n/0K7hTCuX9atPHgXxI0=;
        b=XWxtLhyuTrbLekIie5/rVrfuMytoMDSx8Qf7TMBgHSgE8ZB91RgoGWETMZ048CaOvO
         zRby5VgYxvDRqlC0slSCp3xUOQxKpIpyraTPDWyx4j7pKgMz+X4AIJe9p9bu/QmT0pa9
         hWMF6BwqTU/VU8Qve9jQjiWu/fAcHnNguwdWLxWqzOTTdVOjgaX1HfSfYCuK9xKuMoKW
         TSVHQqM/r/E2cJF/sJ/iEgAEQ5Z7dK9oi20/j53FD/iTBpQflplhY8FzOHUYOXm/lfyI
         oK+uT/qR4V0TA1NmHHiYV+LB9zaCzZbTvgs80IfFEkkhO0kMwcoE6NYUbd1kO3Jljq2V
         u1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284641; x=1777889441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKRwDoHSf2+oXdi49CMbzE7n/0K7hTCuX9atPHgXxI0=;
        b=m6b78ihVJpECDSa7UbYB3Q5JAEnOE+CBJVSjrllP1zjPpbVulL6tcoH3S6GFUH7Zrt
         yEvyoZJ6/v6rYstD2V47E+2GtFaLO1G4dMZ4p/70Ulq7qu1BH8pwRmLWNRQjw/fKqar2
         Rcl1p0/Tm5E8MRuG6vYKnUE6a+FOlBL6VWzT/e5/QAhJVuXUuJXRPN/cUfhrn8NYJkd9
         u6DPmnRaSV6SZgVIcUCBlKey2YQdaTnJIA60l0FUbofZj1x+wEHsMdtDwXWME3W7u5RU
         Y/O3BhcJ/B+wuOOhBFl7Ynuc/K/AYY5B9ZpkJfsI/Fvp4f+h3zlA291zuwGyjA6JXEAO
         ZNig==
X-Forwarded-Encrypted: i=1; AFNElJ/h+z8y0PY4YJopZeXFLi1P2hmUV3VukMmtQtXM1exduRT+qfnjUDZ2AijQs29mJj0h0six6nWM/24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx987hFgtn9eD4gbzZNVyvm3vPPgVGgdklVHDENGJ3ChDObkxBa
	bBiSc4Z8HBL4ESXpe+PPifsnPyU4C4lNHcC4nAMsR1TKztXQWnplr1OwJlDrq6kvNCJkGHglI7B
	V0TD9VLrO57dlNaGNefckSR5BvODZIqw=
X-Gm-Gg: AeBDietwb3HtKpvTSrKCHqLqeedatnJv4znqmml1UjjOKwnZgSUeOjm9vDDBincvL7f
	ku4lMQkJcWtudBfRvuR2Vj9t8sv0LzczTJFMnWsyp42wxhxpWDdmDWo+//plnGNODRI5bkCYpNv
	HVGUG1Xbumgc6hiQEKFFRKWTBbp6tb0TClPGg6Pli02IlqaNT6yKWn+Kt2zznl0UTkR0JlqKhyS
	otiFI8WWFP0+UDLq6XUZUcW3CwgWNLFG0A6mohDki48pOSS0ddlWWp+Ny2q4a1qLjvZY6f9mCHN
	yx6rN8GfVBfUdy4c2WSfRFsvk4ARwvBhq3k9cvYYxxyHYd6uiL8yOmB292tEOhA=
X-Received: by 2002:a17:907:806:b0:b9b:4519:7914 with SMTP id
 a640c23a62f3a-ba41a82618emr2176151966b.33.1777284640148; Mon, 27 Apr 2026
 03:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-10-neilb@ownmail.net>
In-Reply-To: <20260427040517.828226-10-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 12:10:28 +0200
X-Gm-Features: AVHnY4JedWd56CMn-KycBPWg0ncqD2_jbR4uqG29qEFrdNMohyhNrM6UW-jNm2o
Message-ID: <CAOQ4uxidCcGpABkCtkn94i3U_u3OWK16zeAVDG2xuhh5e+ws9g@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] ovl: stop using lookup_one() in iterate_shared() handling.
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8E3B0470C6E
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
	TAGGED_FROM(0.00)[bounces-21166-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email]

On Mon, Apr 27, 2026 at 6:07=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> lookup_one() is expected to be removed as it does not fit well with
> proposed changes to directory locking.
> Specifically d_alloc_parallel() will be ordered outside of i_rwsem
> and as iterate_shared() is called with i_rwsem held it is not safe
> to call d_alloc_parallel().
>
> We can instead call d_alloc_noblock() and then call the ->lookup, but
> that can fail if there is a lookup attempt concurrent with the
> readdir().
>
> ovl cannot afford for the lookup to fail as that could produce incorrect
> results, and it cannot safely drop i_rwsem temporarily and that could
> introduce races with handling of the directory cache.
>
> Instead we rely on the fact that ovl_iterate() has an exclusive lock on
> the directory, so any concurrent lookup will wait for the ovl_iterate()
> call to complete.  We allocate a separate dentry and if the lookup is
> successful, it is hashed with the result.
>
> When the concurrent lookup gets i_rwsem it mustn't do its own lookup -
> it must use the existing dentry.  This is found, if it exists, using
> try_lookup_noperm().

Hi Niel,

One nit about the subject -
Please change it to "ovl: stop using lookup_one() in ovl_iterate()"

Apart from that, I let Claude do the review, because it has surpassed
my abilities in reviewing such subtle api changes.

I will copy its output verbatim, if for nothing else, to encourage you
to start applying Claude review before sending out your patches...

>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/namei.c   | 12 ++++++++++++
>  fs/overlayfs/readdir.c | 24 ++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index ca899fdfaafd..69032eb2b1e2 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1385,6 +1385,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct ovl_entry *poe =3D OVL_E(dentry->d_parent);
>         bool check_redirect =3D (ovl_redirect_follow(ofs) || ofs->numdata=
layer);
> +       struct dentry *alias;
>         int err;
>         struct ovl_lookup_ctx ctx =3D {
>                 .dentry =3D dentry,
> @@ -1399,6 +1400,17 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>         if (dentry->d_name.len > ofs->namelen)
>                 return ERR_PTR(-ENAMETOOLONG);
>
> +       /*
> +        * The existance of this in-lookup dentry might have forced

"existance" should be "existence" in the namei.c comment

> +        * readdir to do the lookup with a new dentry.  If so we must
> +        * return that one.
> +        */
> +       alias =3D try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
> +                                           dentry->d_name.len),
> +                                 dentry->d_parent);
> +       if (alias && !IS_ERR(alias))
> +               return alias;
> +
>         with_ovl_creds(dentry->d_sb)
>                 err =3D ovl_lookup_layers(&ctx, &d);
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1dcc75b3a90f..e03b32491941 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -574,8 +574,28 @@ static int ovl_cache_update(const struct path *path,=
 struct ovl_cache_entry *p,
>                 }
>         }
>         /* This checks also for xwhiteouts */
> -       this =3D lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->l=
en), dir);
> -       if (IS_ERR_OR_NULL(this) || !this->d_inode) {
> +       this =3D d_alloc_noblock(dir, &QSTR_LEN(p->name, p->len));
> +       if (this =3D=3D ERR_PTR(-EWOULDBLOCK)) {
> +               /*
> +                * Some other thead is looking up this name and will

"thead" should be "thread" in the readdir.c comment

> +                * block on i_rwsem before it can complete the lookup.
> +                * We will do the lookup in a new dentry and when that
> +                * lookup gets a turn it will find and return this
> +                * dentry.
> +                */
> +               this =3D d_alloc_name(dir, p->name);

Claude suggests this as the simplest fix to NULL deref bug below:
                    if (!this)
                            this =3D ERR_PTR(-ENOMEM);

> +       }
> +       if (!IS_ERR(this) && !d_unhashed(this)) {
> +               /* Either we got an in-lookup or we made our own unhashed=
 */

The condition should be d_unhashed(this) (without !), matching the comment
which says "Either we got an in-lookup or we made our own unhashed".

d_alloc_name() calls d_alloc() which returns NULL on allocation failure.
The original code checked IS_ERR_OR_NULL(this), but the new code only
checks IS_ERR(this). A NULL this would pass the !IS_ERR(this) check and
then crash on !d_unhashed(this) (or d_unhashed(this) with the fix).

> +               struct dentry *alias =3D ovl_lookup(dir->d_inode, this, 0=
);
> +
> +               if (alias) {
> +                       d_lookup_done(this);
> +                       dput(this);
> +                       this =3D alias;
> +               }
> +       }
> +       if (IS_ERR(this) || !this->d_inode) {
>                 /* Mark a stale entry */
>                 p->is_whiteout =3D true;
>                 if (IS_ERR(this)) {
> --

Claude (Opus 4.6) review summary:

The patch has a critical condition inversion (!d_unhashed vs d_unhashed)
that would break impure readdir entirely and cause use-after-free corruptio=
n
in the dcache. It also has a missing NULL check for d_alloc_name() failure.

Thanks,
Amir.

