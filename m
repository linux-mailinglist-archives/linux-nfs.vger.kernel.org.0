Return-Path: <linux-nfs+bounces-10363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465BBA45FAA
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 13:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429201667C9
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB017BA6;
	Wed, 26 Feb 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzbX4zXK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911B634
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573992; cv=none; b=l5tvZwXMW3qUY1maXWZOtqZoOVvVXalyRqhHSO6sAh8sPfgGyT5bDZagbtCEweGbJI5EHCBQhRQpEbWTfCx9G4iUOB3wOcRpEJJ3WQ+SCa5mMNGd5FBfLaQ4snsA+PQKLPuVY3mckSFsYavcq++lKRXR1rVUfiNljhPGoFXl42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573992; c=relaxed/simple;
	bh=qLd3g7ys5LnidPeIEKMfnB99gYuHtsR6RAastAruVXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hgbp6YQclyWCzHnKwQws3FLqQOyUp7ug8DzoGN8UfVJZSsAtEGKhxnX7eQmL0SSVWi6CZ5ezIXfpp8tafy+qS6eaV2r+qIulUBHAWu7AIxC90A4J4cHunOePGYgmn6k0ezkd1g32EKIWevQC0fVtiBqgka/B+lF+qc3zlOXVFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzbX4zXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B52C4CED6;
	Wed, 26 Feb 2025 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740573992;
	bh=qLd3g7ys5LnidPeIEKMfnB99gYuHtsR6RAastAruVXM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RzbX4zXKTouecvuVG0bhvK3zP8fZ0jc0SGqLhI7+TRL15cSZz83I0TAbfzaQfGtSR
	 Eu9c0ElJ2WmDcAtpk4DODrG9j492w4tRsOvxS3IJvLqxvKgl0bNDWGXDs1sgbe6i+I
	 eFvJjhPMaSPTrzl3RCyKqET/OK8xtHesZkgYV57RFkqBa2xQjY0cQstY/bs6schcVN
	 yPV/DCRgq6vNV0ga6v+N1dKJaKg3UeQ6Y7BQKQN9sbLqn2rAZIDLWDCZWsypBNUSt5
	 KyTqvaZX3GA7cPcu9Q1c5mfJf/0KtHN5FLWWgBqnxE3AcMgbb2MyIWghS0uN+Ti+e4
	 bH2ZbTjXJWeYg==
Message-ID: <afcbafcfa96927c158feb624c7122ec633d681a8.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfs/vfs: discard d_exact_alias()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@kernel.org>,  Anna Schumaker	 <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Date: Wed, 26 Feb 2025 07:46:29 -0500
In-Reply-To: <20250226062135.2043651-2-neilb@suse.de>
References: <20250226062135.2043651-1-neilb@suse.de>
	 <20250226062135.2043651-2-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-26 at 17:18 +1100, NeilBrown wrote:
> d_exact_alias() is a descendent of d_add_unique() which was introduced
> 20 years ago mostly likely to work around problems with NFS servers of
> the time.  It is now not used in several situations were it was
> originally needed and there have been no reports of problems -
> presumably the old NFS servers have been improved.  This only place it
> is now use is in NFSv4 code and the old problematic servers are thought
> to have been v2/v3 only.
>=20
> There is no clear benefit in reusing a unhashed() dentry which happens
> to have the same name as the dentry we are adding.
>=20
> So this patch removes d_exact_alias() and the one place that it is used.
>=20
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/dcache.c            | 46 ------------------------------------------
>  fs/nfs/nfs4proc.c      |  4 +---
>  include/linux/dcache.h |  1 -
>  3 files changed, 1 insertion(+), 50 deletions(-)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index e3634916ffb9..726a5be2747b 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2687,52 +2687,6 @@ void d_add(struct dentry *entry, struct inode *ino=
de)
>  }
>  EXPORT_SYMBOL(d_add);
> =20
> -/**
> - * d_exact_alias - find and hash an exact unhashed alias
> - * @entry: dentry to add
> - * @inode: The inode to go with this dentry
> - *
> - * If an unhashed dentry with the same name/parent and desired
> - * inode already exists, hash and return it.  Otherwise, return
> - * NULL.
> - *
> - * Parent directory should be locked.
> - */
> -struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
> -{
> -	struct dentry *alias;
> -	unsigned int hash =3D entry->d_name.hash;
> -
> -	spin_lock(&inode->i_lock);
> -	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
> -		/*
> -		 * Don't need alias->d_lock here, because aliases with
> -		 * d_parent =3D=3D entry->d_parent are not subject to name or
> -		 * parent changes, because the parent inode i_mutex is held.
> -		 */
> -		if (alias->d_name.hash !=3D hash)
> -			continue;
> -		if (alias->d_parent !=3D entry->d_parent)
> -			continue;
> -		if (!d_same_name(alias, entry->d_parent, &entry->d_name))
> -			continue;
> -		spin_lock(&alias->d_lock);
> -		if (!d_unhashed(alias)) {
> -			spin_unlock(&alias->d_lock);
> -			alias =3D NULL;
> -		} else {
> -			dget_dlock(alias);
> -			__d_rehash(alias);
> -			spin_unlock(&alias->d_lock);
> -		}
> -		spin_unlock(&inode->i_lock);
> -		return alias;
> -	}
> -	spin_unlock(&inode->i_lock);
> -	return NULL;
> -}
> -EXPORT_SYMBOL(d_exact_alias);
> -
>  static void swap_names(struct dentry *dentry, struct dentry *target)
>  {
>  	if (unlikely(dname_external(target))) {
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index df9669d4ded7..0a46b193f18e 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3153,9 +3153,7 @@ static int _nfs4_open_and_get_state(struct nfs4_ope=
ndata *opendata,
>  	if (d_really_is_negative(dentry)) {
>  		struct dentry *alias;
>  		d_drop(dentry);
> -		alias =3D d_exact_alias(dentry, state->inode);
> -		if (!alias)
> -			alias =3D d_splice_alias(igrab(state->inode), dentry);
> +		alias =3D d_splice_alias(igrab(state->inode), dentry);
>  		/* d_splice_alias() can't fail here - it's a non-directory */
>  		if (alias) {
>  			dput(ctx->dentry);
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 4afb60365675..8a63978187a4 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -253,7 +253,6 @@ extern struct dentry * d_splice_alias(struct inode *,=
 struct dentry *);
>  extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct =
qstr *);
>  extern bool d_same_name(const struct dentry *dentry, const struct dentry=
 *parent,
>  			const struct qstr *name);
> -extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
>  extern struct dentry *d_find_any_alias(struct inode *inode);
>  extern struct dentry * d_obtain_alias(struct inode *);
>  extern struct dentry * d_obtain_root(struct inode *);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

