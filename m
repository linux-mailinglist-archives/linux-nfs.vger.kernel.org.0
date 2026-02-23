Return-Path: <linux-nfs+bounces-19126-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EBMNp4inGn4/wMAu9opvQ
	(envelope-from <linux-nfs+bounces-19126-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 10:49:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB61742C5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 10:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4378D3007675
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906434FF45;
	Mon, 23 Feb 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsjZlfRu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A034EF12
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840155; cv=pass; b=hM//IOKdHmitwpFHVQzYO0vMvKlls4SoUBV8ugM7k2Oqc5r+52NPmXcaBtD0jsAajUnVbQ6Nl2DfbbCr9H8QJi1jbhQ2UN3IsJBpUZVq+jcf/mtYFFDycOBga04S+sk0o6TgGNTp9L/hXq3i4PiXQzZcORe8qdKwYCqW4CPSklY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840155; c=relaxed/simple;
	bh=Xh4bjPWHtF+IO6/pJTbboimYkYntcuZV8mtoP+YljlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWC+AWq7kiRmY3H5MfyasWnrXoUdmtYhb/AjRhTlTbQf+BYpNtlTuvI+kQZYCYt4FyODu+pWdOZeNoyjrHl49AGAI5ukEAeF6IyotrKDu29ITQNUyF9MwOOIoCLJHPjIJHX5jLbYA52EZW6oUbFEj90BM8FK4FgARlxMnNHX+cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsjZlfRu; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362507f0bcso2886756f8f.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 01:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771840152; cv=none;
        d=google.com; s=arc-20240605;
        b=aAaEPJMfaYW10x+xpvHFgXi49aaXqQY3tIeAVHmir67NSMXz5Nj7xhmq+ziN1Mrveu
         lkQ5uT9jbiXJNSrvURo7K5WSMR03qrOlDO+/k/9TKgNVTlxTHNd1kFdD0nxixx9n8ytD
         Jkhx0mW8tPgWWrluZ72l9jz8LNVRtxwUGp/8v52TxjTv5q67zOH4U0Dqeavc8y18Zm1S
         LmcA3MuENZhvzZ+VRQlzZDPfqr+7GQKj/U4CWR9AQl52sDZta6h4s6pEzhSypAWh0vfW
         22iK9S6ZiU2eGNdPPgNUyok0dUzhiB5mcWMNm1qyVi7cJjA5jbGV9gP+k4LwMTBRzSrU
         VJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        fh=+Iwy1LSMwsX/3xzn2ikkaxpBQNiaVGZS5CXIT4AC/j0=;
        b=ktIEFqiTXwjcfmh0JUNDjYOJ9lNvU6UglPAmjy7RY5w8usXyWFDgfJ2jXCg46e47bT
         kyzSze8KQ/kmQ/3zoFxUsruGXJ93MeI/auRbLfHnZt0pfn05nN9SvoRm3tgscsFbaSvq
         sZBt91uqmb8FM51RvcCEuY3weBIOIrpPO6vbTuMbaUzU5OnNaPn0iQUOxDsjJhqQVcYD
         CRVYS8jxUFXUp8v1o+aAO9FSa3XOoayREWGw1DyKHI5keOaWgWU/47tB/m5QJSWs921+
         91lejjKLwxZJKPTo95iJHsaSwzTsJ8iCza8EtcRixqUE/4QiqTBV4xUpfeFR8OyaAtNS
         iKxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771840152; x=1772444952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        b=VsjZlfRucprXXOxcNuewJuffOlegZKKI002qWZs6ZknVE5gsDu7XvFbdD5dYC0pBHF
         hYL4t9/tAM4Ib47GjXqtmt1+txReBN2DP219k3nvQ58w/bzLOsKfBpZjvSqR75boT8f9
         l+9GG23LZCTKykPI9++AyA0AG0BF9yl5B0HKfazfIfR+B9QAaUXlw2yg1KK7EwCHKbro
         JpHGhiGOxZcrJ+a+weU45TKUUDyC2y/I5985HYfX8JLsIxEsVfU5Em8XgO6/ZZ2VzSmf
         m+KZ5Xz8wLZqWkRdq6LqW0MPFKwCBu21z91i8tk3RhrOlHD3gF2z9uT7Kjk50oW693rW
         dBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771840152; x=1772444952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        b=mZRB0hQyZYXDaVGQElu9fvMbyX/i/u+UVPvIbu8Ipe8Zl9j0DdI9kKdHvMq35MQJ6B
         +Oaqhb/c1HhPu8DGg/ZdKF4rElMRkgtF9bROrodc5ImLgebtF4vEAqNz1ioOThVFBR/2
         +WtmbXlvdqumfqitYCVi2xpuPCNSgwLHXazxPXnBDVteCqk/YcRgtvEWVAg/l/UlbCCM
         U17RKBhGw1E1t/CnhnIjP2JCbhe4L3gp65iLxpH/EN6e1iGKMwLANklIPHGQCWMzfU73
         JdGeatHviwMvPlHVnZde7ovuZIY3tu0KyqQAP/r9DhrFnVw2vZhbeGvzIbyrbln6Mg1f
         89ug==
X-Forwarded-Encrypted: i=1; AJvYcCVDgyWkbdeVZlWPsyYyKXzWezO3jUdHsR0AC+A00R0Zul2V77NMNL2U5x0lSq8GcTKJ5og1pV9veLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CPzgfBO9LPV62CyR9POOiZRorYpN+ujclNnLC5ZdZTT1FeTO
	FQKU6C9+IJHDE8OQiKTF39ssJDi/msIKypv2p79R3R759rCD+v+zjYnbWddRTxwEPnYa5jIvU8p
	3fQrWcqaZbbr1QGM1iGH4mvwa209ypjQ=
X-Gm-Gg: ATEYQzxzuCa6TJTLhQZHheXKpCoHnISTnvxUyuhBQWgqare1hmQePejLpZjKMbi4+Bm
	YW9nlfEKtGnvUEQbLqeriJScLk82pJ9r2N0zTpJ63/DYIIvkxsnB5WGkZHTRh3XZGIyVE0yVVFG
	PaM+2UCdlChfVQ7WyOg900ekOKIvKLCk2o2qg07RJwjxFF/mN3KcVwNZTRwF4o5uxhKxNDclZrO
	KcoMcXGuNaYvXwhjhRsm2NtltDF2nPANaJEMGgM9JNH7BCgK6F0PKYQP1pVopYakNzv8WsE2/TZ
	vcYY46eBUOur2aoUpZD8oRTMiRNxC7yrBoHl5U+5oA==
X-Received: by 2002:a05:6000:4014:b0:437:6aa8:b7eb with SMTP id
 ffacd0b85a97d-4396fd9b885mr14177751f8f.5.1771840152054; Mon, 23 Feb 2026
 01:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-10-neilb@ownmail.net>
In-Reply-To: <20260223011210.3853517-10-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 11:49:00 +0200
X-Gm-Features: AaiRm53oCa-QOult778vTlpI836VKQ_vX_Rm7xdLmLP8dTvXCc4lfRf1Ct2RZiU
Message-ID: <CAOQ4uxjtedA8B1QZDddRtsSP0XgFZCuBTD1VGvN4wawRyoox=A@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] ovl: Simplify ovl_lookup_real_one()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19126-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,brown.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:email]
X-Rspamd-Queue-Id: 50CB61742C5
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:13=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> The primary purpose of this patch is to remove the locking from
> ovl_lookup_real_one() as part of centralising all locking of directories
> for name operations.
>
> The locking here isn't needed.  By performing consistency tests after
> the lookup we can be sure that the result of the lookup was valid at
> least for a moment, which is all the original code promised.
>
> lookup_noperm_unlocked() is used for the lookup and it will take the
> lock if needed only where it is needed.
>
> Also:
>  - don't take a reference to real->d_parent.  The parent is
>    only use for a pointer comparison, and no reference is needed for
>    that.
>  - Several "if" statements have a "goto" followed by "else" - the
>    else isn't needed: the following statement can directly follow
>    the "if" as a new statement
>  - Use a consistent pattern of setting "err" before performing a test
>    and possibly going to "fail".
>  - remove the "out" label (now that we don't need to dput(parent) or
>    unlock) and simply return from fail:.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/export.c | 71 ++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 38 deletions(-)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb1567..b448fc9424b6 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -349,69 +349,64 @@ static struct dentry *ovl_dentry_real_at(struct den=
try *dentry, int idx)
>         return NULL;
>  }
>
> -/*
> - * Lookup a child overlay dentry to get a connected overlay dentry whose=
 real
> - * dentry is @real. If @real is on upper layer, we lookup a child overla=
y
> - * dentry with the same name as the real dentry. Otherwise, we need to c=
onsult
> - * index for lookup.
> +/**
> + * ovl_lookup_real_one -  Lookup a child overlay dentry to get an overla=
y dentry whose real dentry is given
> + * @connected: parent overlay dentry
> + * @real: given child real dentry
> + * @layer: layer in which @real exists
> + *
> + *
> + * Lookup a child overlay dentry in @connected with the same name as the=
 @real
> + * dentry.  Then check that the parent of the result is the real dentry =
for
> + * @connected, and @real is the real dentry for the result.
> + *
> + * Returns:
> + *   %-ECHILD if the parent of @real is no longer the real dentry for @c=
onnected.
> + *   %-ESTALE if @real is no the real dentry of the found dentry.
> + *   Otherwise the found dentry is returned.
>   */
>  static struct dentry *ovl_lookup_real_one(struct dentry *connected,
>                                           struct dentry *real,
>                                           const struct ovl_layer *layer)
>  {
> -       struct inode *dir =3D d_inode(connected);
> -       struct dentry *this, *parent =3D NULL;
> +       struct dentry *this;
>         struct name_snapshot name;
>         int err;
>
>         /*
> -        * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> -        * from racing with overlay rename. If the overlay dentry that is=
 above
> -        * real has already been moved to a parent that is not under the
> -        * connected overlay dir, we return -ECHILD and restart the looku=
p of
> -        * connected real path from the top.
> -        */
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> -       err =3D -ECHILD;
> -       parent =3D dget_parent(real);
> -       if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> -               goto fail;
> -
> -       /*
> -        * We also need to take a snapshot of real dentry name to protect=
 us
> +        * We need to take a snapshot of real dentry name to protect us
>          * from racing with underlying layer rename. In this case, we don=
't
>          * care about returning ESTALE, only from dereferencing a free na=
me
>          * pointer because we hold no lock on the real dentry.
>          */
>         take_dentry_name_snapshot(&name, real);
> -       /*
> -        * No idmap handling here: it's an internal lookup.
> -        */
> -       this =3D lookup_noperm(&name.name, connected);
> +       this =3D lookup_noperm_unlocked(&name.name, connected);
>         release_dentry_name_snapshot(&name);
> +
> +       err =3D -ECHILD;
> +       if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent=
)
> +               goto fail;
> +
>         err =3D PTR_ERR(this);
> -       if (IS_ERR(this)) {
> +       if (IS_ERR(this))
>                 goto fail;
> -       } else if (!this || !this->d_inode) {
> -               dput(this);
> -               err =3D -ENOENT;
> +
> +       err =3D -ENOENT;
> +       if (!this || !this->d_inode)
>                 goto fail;
> -       } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> -               dput(this);
> -               err =3D -ESTALE;
> +
> +       err =3D -ESTALE;
> +       if (ovl_dentry_real_at(this, layer->idx) !=3D real)
>                 goto fail;
> -       }
>
> -out:
> -       dput(parent);
> -       inode_unlock(dir);
>         return this;
>
>  fail:
>         pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
>                             real, layer->idx, connected, err);
> -       this =3D ERR_PTR(err);
> -       goto out;
> +       if (!IS_ERR(this))
> +               dput(this);
> +       return ERR_PTR(err);
>  }
>
>  static struct dentry *ovl_lookup_real(struct super_block *sb,
> --
> 2.50.0.107.gf914562f5916.dirty
>

