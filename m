Return-Path: <linux-nfs+bounces-22164-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CeaNOFvHWqWawkAu9opvQ
	(envelope-from <linux-nfs+bounces-22164-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 13:41:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8761E7B1
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 13:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CEEF300EF9B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35BF33BBCD;
	Mon,  1 Jun 2026 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="WLKWznjL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A7361656
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jun 2026 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313723; cv=none; b=su4eZAE4TDD/jS2FxL2lR+tl5dwHYpcQ00Fe1+h0ouV+8wBYNvTU63sF57BoPvwBhb8vUqesfFI+Sj4skucJaxLiW03jv8tKpTXmHleu3adSR40jdj2yyVxOg+N5dgy4HmuVHvEP4ZpzPrcs4PIhT0UsVjDiGyqcTXLlQWDoZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313723; c=relaxed/simple;
	bh=OicXyuT4vkZDuoN7/61UrX0pf2aS6A+eoCjPyFkCOUo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Iqo8cF7dt3tNjO03sXV+j5xUdC/kFjS8spc5h/XrjqYVLVlGCWpPKdYtwYTsM8ofu45wI//l/aUXOacR4AyA99X7MTG/EnmqE0KRc9WeGGbdsH1KPstbrJdqnD6cYxs1HGYaixmU4fh9tKSTDz2iHuEVzzGD+fW8Gl4CFuFchHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=WLKWznjL; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: f8566cc4-5dad-11f1-8ff7-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f8566cc4-5dad-11f1-8ff7-005056999439;
	Mon, 01 Jun 2026 13:35:20 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id f84abb29-5dad-11f1-99d0-0050569977a2;
	Mon, 01 Jun 2026 13:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=KVOB3fnhFQ+WKBJGKuBQYYn8XjpTBubyu6FUksgvAQ4=;
	b=WLKWznjLSD0ACOQEsbQhMTFxJKV/Fd44Fk8FTkT7bbiYl3GciNNyRb7DvdOPDJI8mpo7M1/hrULW7
	 banl6KojaVa5qmhXg/sNrZ5k1cAHeRH0/gjzsdM3XKhEhAPh+Z5p9sBMYUJN4jpgHONU5h28rMG45r
	 vr6GgI0VwyKH+4/g49Uw51DpjJGuu/ngGVDZ59r6MWsKz9zplIRWYJ31bPuruz3pmlUzk6n2Hvj52S
	 53Jq9r8kKIC1YryRoNVgqRFAUKWMQe6M48Cw/xXuXvJDS87XmmbVLRoEdB2zQsaVQe3x8PHoyJY0tu
	 gTpc+a3aAU+IoB75WahJ3zaXYUfzkoA==
X-KPN-MID: 33|BjQvz1U+N6s7p5fX9BTjw6ws8XB3/Uxw8e17u2s6Cc9al5QYaX9AZI2Xykf7XTG
 KCBz8B38RswC3opKCgNl4eeMIH+Gxa8eoHu9T2lc1ulY=
X-CMASSUN: 33|4s+clbjMAe4s69QW+E84byfAEO+vNrpyfGRYMn21TWS80wFuO089Wns+NZ/zK//
 TbIDeiI/veNZGxAQmZnnr5Q==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id f83cc4e4-5dad-11f1-b8d7-005056995d6c;
	Mon, 01 Jun 2026 13:35:20 +0200 (CEST)
Date: Mon, 1 Jun 2026 13:35:20 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Message-ID: <468562950.51964.1780313720060@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260601070042.249432-4-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
 <20260601070042.249432-4-neilb@ownmail.net>
Subject: Re: [PATCH 03/18] VFS: replace nameidata and open_flag args to
 lookup_open()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22164-lists,linux-nfs=lfdr.de];
	HAS_X_PRIO_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,hammerspace.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[brown.name,ownmail.net,kernel.org,zeniv.linux.org.uk];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:email,xs4all.nl:email,xs4all.nl:dkim]
X-Rspamd-Queue-Id: 3CB8761E7B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 01-06-2026 08:37 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> From: NeilBrown <neil@brown.name>
> 
> lookup_open is currently given "struct nameiodata" and "struct
> open_flag" pointer args.  These structures are internal to VFS.  Replace
> these with the individual fields that lookup_open() actually needs.
> This will allow it be exported so it can be used to replace
> dentry_create().
> 
> As lookup_open() can change both open_flag and mode, we keep the local
> variable and create an arg with a different name which is assigned to
> the local variable.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index b00ff3f2faf7..18a43c24d7f1 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4402,12 +4402,15 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>   *
>   * An error code is returned on failure.
>   */
> -static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> -				  const struct open_flags *op)
> +static struct dentry *lookup_open(const struct path *path, struct file *file,
> +				  const struct qstr *last,
> +				  unsigned int lookup_flags,
> +				  struct filename *name,
> +				  int open_flag_arg, umode_t mode_arg)
>  {
>  	struct delegated_inode delegated_inode = { };
>  	struct mnt_idmap *idmap;
> -	struct dentry *dir = nd->path.dentry;
> +	struct dentry *dir = path->dentry;
>  	struct inode *dir_inode = dir->d_inode;
>  	int open_flag;
>  	struct dentry *dentry;
> @@ -4416,13 +4419,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	bool got_write;
>  
>  retry:
> -	open_flag = op->open_flag;
> +	open_flag = open_flag_arg;
>  	got_write = false;
> -	mode = op->mode;
> +	mode = mode_arg;
>  	create_error = 0;
>  
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> -		got_write = !mnt_want_write(nd->path.mnt);
> +		got_write = !mnt_want_write(path->mnt);
>  		/*
>  		 * do _not_ fail yet - we might not need that or fail with
>  		 * a different error; let lookup_open() decide; we'll be
> @@ -4440,17 +4443,17 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	}
>  
>  	file->f_mode &= ~FMODE_CREATED;
> -	dentry = d_lookup(dir, &nd->last);
> +	dentry = d_lookup(dir, last);
>  	for (;;) {
>  		if (!dentry) {
> -			dentry = d_alloc_parallel(dir, &nd->last);
> +			dentry = d_alloc_parallel(dir, last);
>  			if (IS_ERR(dentry))
>  				goto out;
>  		}
>  		if (d_in_lookup(dentry))
>  			break;
>  
> -		error = d_revalidate(dir_inode, &nd->last, dentry, nd->flags);
> +		error = d_revalidate(dir_inode, last, dentry, lookup_flags);
>  		if (likely(error > 0))
>  			break;
>  		if (error)
> @@ -4465,7 +4468,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	}
>  
>  	if (open_flag & O_CREAT)
> -		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> +		audit_inode(name, dir, AUDIT_INODE_PARENT);
>  
>  	/*
>  	 * Checking write permission is tricky, bacuse we don't know if we are
> @@ -4478,13 +4481,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	 */
>  	if (unlikely(!got_write))
>  		open_flag &= ~O_TRUNC;
> -	idmap = mnt_idmap(nd->path.mnt);
> +	idmap = mnt_idmap(path->mnt);
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
>  		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
>  		if (likely(got_write))
> -			create_error = may_o_create(idmap, &nd->path,
> +			create_error = may_o_create(idmap, path,
>  						    dentry, mode);
>  		else
>  			create_error = -EROFS;
> @@ -4492,9 +4495,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (create_error)
>  		open_flag &= ~O_CREAT;
>  	if (dir_inode->i_op->atomic_open) {
> -		if (nd->flags & LOOKUP_DIRECTORY)
> +		if (lookup_flags & LOOKUP_DIRECTORY)
>  			open_flag |= O_DIRECTORY;
> -		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
> +		dentry = atomic_open(path, dentry, file, open_flag, mode);
>  		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
>  			dentry = ERR_PTR(create_error);
>  		goto out;
> @@ -4502,7 +4505,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
> -							     nd->flags);
> +							     lookup_flags);
>  		d_lookup_done(dentry);
>  		if (unlikely(res)) {
>  			if (IS_ERR(res)) {
> @@ -4550,7 +4553,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		inode_unlock_shared(dir_inode);
>  
>  	if (got_write)
> -		mnt_drop_write(nd->path.mnt);
> +		mnt_drop_write(path->mnt);
>  
>  	if (is_delegated(&delegated_inode)) {
>  		/* Must have come through out_dput */
> @@ -4637,7 +4640,8 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		}
>  	}
>  
> -	dentry = lookup_open(nd, file, op);
> +	dentry = lookup_open(&nd->path, file, &nd->last,
> +			     nd->flags, nd->name, op->open_flag, op->mode);
>  	if (IS_ERR(dentry))
>  		return ERR_CAST(dentry);
>  
> -- 
> 2.50.0.107.gf914562f5916.dirty

Sure. I think the churn and pushing nd state through many arguments
would normally be too much to justify the improvement of scope reduction,
but for the goal of getting rid of dentry_create() this is fine.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

