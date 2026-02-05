Return-Path: <linux-nfs+bounces-18738-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CItvIBaNhGl43QMAu9opvQ
	(envelope-from <linux-nfs+bounces-18738-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 13:29:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2314F27CF
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 13:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60E89302C65D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA93ACA50;
	Thu,  5 Feb 2026 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ/kpL9h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FE3ACA5B
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294398; cv=pass; b=rpKGK1GcYk5d/zkI0kEQk0CvxPk2xaHYTgd/aQ6Zrq/QXdF/O3G+TTZ9Ke7Hg+IyUmO5H2ijTWpizta97F8gkZpask9yrcSbg7+2gk1aD/s72JTqabjbnxn0qgR7gNiD+YZQiqKkysrtgS8sdhiWBhkro51pqiRHJw+AxKqTUTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294398; c=relaxed/simple;
	bh=C5vOLxPnRhY6qi4kHmtoIzIplBE7B/w6zl9ie5PvVMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQkQPE9Gwl7T5yBxjGp1xW7t7moC8+5Nz/LcoUXyitXrjz/k2Zd0RHBQnE9lTZ+R0FavZ4mqlTGQ3oXbv1iOA/abZXeOI1I4U9TqBvelIWmDzKmKAvgJDKo3IhFypTCDTmLnqngq0oAHxVW2MTR6ahMWLp9utK2ctCSFCGtnqTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ/kpL9h; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65832e566edso1231878a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 05 Feb 2026 04:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770294396; cv=none;
        d=google.com; s=arc-20240605;
        b=Xynf7qnYFDS4z4kcb6H8nMWALJzh5czelBNUjGvgGABCPVWRp+ek4mv9FvNbX0VCJ1
         3QHuY7N++60I7adyjYCOuhdqQZ55KfKFpUg63GacHDT1AoSUs1b3J8bnL00USK3ETeK0
         DgHwvg5f57UlieDwsYOkDurBJALVT7s32ZNsxv3nNcSID4T4bdGfqaGPb0wbo5nT+PpO
         2YByShb930LEh4yT7DYk/3V7Ppt3cjlTEh6Ar4c2T1nkbFF1yYbp0z61gY0ryp0MMoG1
         8JPHi5Tcn1NPo4hcpPW//9oasgP/tp5RtBT+2K2XTGW9RF1/GQpb2+ApoxKJr1C9iJGb
         Cjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        fh=0KFSAwNMFhckdkqsJBYai7Zx+sq7U4NP2Q8INRsr88c=;
        b=Z92jFTAXersKKu73/TXYeTN/N4ZSwVFMEgyFrRsR64RUAhl7+DNo8LeZYV6QZeMR3A
         lzCaufIYFzYXOjFVv4bRA1eTJHMrDQhuKAVBncKLFMMZcpFfsisABOUHNMOt6b3lwWXV
         sMU0BwFuf7uY/1NVHAtO6Hmxykg4y3bQxIGGvCKqdGMcpxGza34NO9fnm0FszgGjHgz3
         WgScQvoLq74DYXanDe+YMCYazVQhUiICGmVp7zmkqQovIYmqZKeLbgivYMW1NIX48zK8
         /6Umuyt/X0LUzCSoLN0NMO13T46AbZcOiOK9+tkvLfP2Vuyb1Bio0H1s+eKF6H53DQx8
         U8VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770294396; x=1770899196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        b=fZ/kpL9hZrFuXxqlS1kf2FfrnO/ztwaBbfZ/BlG0wBhoFgNZEsapLLAefnFQgMqkq1
         XXvGhaSwnWhmNbZikkTCHoBgcVDl2axU+pJ+wlbZMXdx4fHUB2xuMNyZ261p+ZgJ3qup
         xhcqU3iR0u6y7+u8IPd2D9FCJgEmXsQnr6SFDs7c5/IrEwrqYFAmk7SLoD1I3Z6hudiw
         NfL9PkCt9G1fmewoD7gqXVEV006stKo16cyVFIJ9soAxUyxzATAbArOcRxmZNb3v95iw
         yt7t3Qf5K7kDqDaPrewJLZ+f2OmdX8RJOgo7zjinRhCbBk6sG+ARRxe6RSVg9Pg5Zh8N
         Yk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294396; x=1770899196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        b=KewUrfH2gznoj+b3Np4Cby0HAt5DqoMeTu+kzBUI+KLKc7xa8/FooJ2wNjDTE6Flds
         p7mDkrZvYnGcFvaAnnHvYwPoEpTRSS2yx579qQJc4v5N6O9LvDXyIEUZNf1+yZA30UlV
         Vw9Wov0/CwIM1VKOPG+zO0fKLAbRLxocSeXHXm+/5sHllcvBNU5lO3DluUjNcBsaqP4f
         PKYpoAjXxj/Nax+mIGsGsCSJv9+4W/lNetHsn0Pqz5r0nyf+SY1atJeN6TYiqD28Jykl
         eo6pGeXbwURhvHitCbrSZcSOWfJf19jPtg+Fx9K5OKy0EKQXky9zlPTt/f5b+t2ec5Ar
         NUFg==
X-Forwarded-Encrypted: i=1; AJvYcCXgZIUwzz6p6ah2jVNAgRtafc/C2euTkUVUdKbDRHq1dy8N7KTBICbyfvmk8bYdW1ejNWit4C4zUjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlaKpYvv9Cn27AhbrC72jWLjrwp8XxRwPIoD2FGdbvVUq6lhJ
	9wKx8bDCYiEP7f/ggsSi7+GNhw2GiSTVZjYRZd/px1AtgpoQDnRvw6B+kC7O46nn/vdGlhsaNHw
	5/hkHWi+azXZg0db91hVWwgjX724av9E=
X-Gm-Gg: AZuq6aJ5DVaQlnPZwnQesqfA7irxhg22asXOfcIG5K0W3tyHO0u/IFIkJ+BNayUuEer
	HUPvtBOVqFbg2/Svu6EfQPePmWQet4atWmO8DoCuUW5N4x+3lfkbF7XMdf/WXSG/u/nXcZ9DG8j
	LFtvy+XT/uIANkgNNc1JdQ79f1yERd7H4P9bSm6JhUSZWNgNIphFPN7U0nZ+B0jLvPdz77skHPH
	8PSoLduJ6iGexJyWrNASiwTP4ya2ZOqk8hHZdoCe/aqSF0twUx29eqsXJfQniqc4YqL6XcYxFUQ
	fdq7hpQnVuxHD1BK5wY8LmSWe9mMoA==
X-Received: by 2002:a05:6402:2711:b0:658:da9:787d with SMTP id
 4fb4d7f45d1cf-65949dc2762mr3243637a12.21.1770294396096; Thu, 05 Feb 2026
 04:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-11-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-11-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 13:26:24 +0100
X-Gm-Features: AZwV_QhSomAYq3e-9LVlkwiUvLVwnQqEgYbdyasP4aBJdb_z_a8NyX57euMmGhk
Message-ID: <CAOQ4uxh-MLgwZCstwr6HyPXHVRmtj2F_=xS8pE3FN6Ex-wex4w@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: change ovl_create_real() to get a new lock
 when re-opening created file.
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-18738-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F2314F27CF
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> When ovl_create_real() is used to create a file on the upper filesystem
> it needs to return the resulting dentry - positive and hashed.
> It is usually the case the that dentry passed to the create function
> (e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
> filesystem may unhash that dentry forcing a repeat lookup next time the
> name is wanted.
>
> So ovl_create_real() must be (and is) aware of this and prepared to
> perform that lookup to get a hash positive dentry.
>
> This is currently done under that same directory lock that provided
> exclusion for the create.  Proposed changes to locking will make this
> not possible - as the name, rather than the directory, will be locked.
> The new APIs provided for lookup and locking do not and cannot support
> this pattern.
>
> The lock isn't needed.  ovl_create_real() can drop the lock and then get
> a new lock for the lookup - then check that the lookup returned the
> correct inode.  In a well-behaved configuration where the upper
> filesystem is not being modified by a third party, this will always work
> reliably, and if there are separate modification it will fail cleanly.
>
> So change ovl_create_real() to drop the lock and call
> ovl_start_creating_upper() to find the correct dentry.  Note that
> start_creating doesn't fail if the name already exists.
>
> This removes the only remaining use of ovl_lookup_upper, so it is
> removed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c       | 24 ++++++++++++++++++------
>  fs/overlayfs/overlayfs.h |  7 -------
>  2 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..ec08904d084d 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -219,21 +219,33 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct dentry *parent,
>                 err =3D -EIO;
>         } else if (d_unhashed(newdentry)) {
>                 struct dentry *d;
> +               struct name_snapshot name;
>                 /*
>                  * Some filesystems (i.e. casefolded) may return an unhas=
hed
> -                * negative dentry from the ovl_lookup_upper() call befor=
e
> +                * negative dentry from the ovl_start_creating_upper() ca=
ll before
>                  * ovl_create_real().


According to the new locking rules, if the hashed dentry itself is
the synchronization object, is it going to be allowed to
filesystem to unhash the dentry while the dentry still in the
"creating" scope? It is hard for me to wrap my head around this.

Or do we need this here because some filesystems (casefold in
particular) are not going to support parallel creations?

>                  * In that case, lookup again after making the newdentry
>                  * positive, so ovl_create_upper() always returns a hashe=
d
>                  * positive dentry.
> +                * As we have to drop the lock before the lookup a race
> +                * could result in a lookup failure.  In that case we ret=
urn
> +                * an error.
>                  */
> -               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, paren=
t,
> -                                    newdentry->d_name.len);
> -               dput(newdentry);
> -               if (IS_ERR_OR_NULL(d))
> +               take_dentry_name_snapshot(&name, newdentry);
> +               end_creating_keep(newdentry);
> +               d =3D ovl_start_creating_upper(ofs, parent, &name.name);
> +               release_dentry_name_snapshot(&name);

OK. not saying no to this (yet) but I have to admit that it is pretty
ugly that the callers of ovl_create_real() want to create a specific
stable name, which is could be passed in as const char *name
and yet we end up doing this weird dance here just to keep the name
from newdentry.

Thanks,
Amir.

