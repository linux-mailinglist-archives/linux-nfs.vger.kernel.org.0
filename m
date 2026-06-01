Return-Path: <linux-nfs+bounces-22162-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CF7GbxkHWqwaAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22162-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 12:53:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4AC61DEAB
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 12:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBEF3028F31
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B8399340;
	Mon,  1 Jun 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="cMzHNuIW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E461371056
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jun 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310879; cv=none; b=IxokIMYWinBPs8kWczixDy0vujgOwduFAjRk2bolDl87gPSv20dlOTJ84rauS4urLB6nQ7IQ/RKRv7iIFPQQbMwCf4fIMK+Epc9/hKCueKcdhmbv16pJ6sgfAJ1XayoE6geewFhB03/jsGJcggwK9xeAZ2VSWvv0vsL1enHXs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310879; c=relaxed/simple;
	bh=dr83epYbEC0O4eIbkzvPW9x8F0QHlZQvcIUA3JUmkIE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PUgj4m+/AEEmKKlJGMrCxUp8X2pv5P9jVR7+a3vtZXgjMAsNYgCwHDcaYZ19a2zR0VKY+mDQ6X5OCk7kSL52RB1yEuT7S7wiIO4K/ac939SiDare3DDwJhNOLd0k4D9yD8/mnpfLBWDb1pKyWsHzBesbthrgfEZOMCrNyTivbrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=cMzHNuIW; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 54bf57c9-5da7-11f1-8ff7-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 54bf57c9-5da7-11f1-8ff7-005056999439;
	Mon, 01 Jun 2026 12:47:48 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 54bc4521-5da7-11f1-99d0-0050569977a2;
	Mon, 01 Jun 2026 12:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Ld5L1Sm+i8NgI0DY+ycerm75tnKnP2C4Iz+0R3TMP/o=;
	b=cMzHNuIW9174LoTUiqby+NEDtbblxwzIqLsQwXJPvED2KI8CmA68SUvtbjCxyYj5XUJOrbC8j+dty
	 hK8FXcpEDtR263Khdq1rofmjVT2vpjWxg+BEZ0eHpcxdpPd70qZbMx7lbR4Ez9BVMj+ziXCiOHGYtH
	 Erk6CHHkY+GGgFB3jN2lxOmcPnmDQhv/nQ7pbklhtFRVShecSiqOmSDvtqAvPnrE9EbVlLt4NM/Ggg
	 KSt2K2tHNlnn/wpaysYqS1j+sgqzRQpcQ1hQ+/Kj+zENbygmuv8kz+h1+MGC2n1G3wvbGYS9y8np6L
	 /gm2hpX/UmJ8g/mUrmzsD1G+NaAhseQ==
X-KPN-MID: 33|AC3WzUmDrLv1xs5vyp84paDNhbE1ERHtz0A8hwWnRUsx0k6VWDg1xY7ZGSJjRam
 o1EwlT2OUmmjVLvgZUOL9BfHniEybgZE5zQecj4c7N6U=
X-CMASSUN: 33|Am0Tbtl8G2WQELvZK2ZwhVK0UwLsyCcyZ+jORZ/ALvU2dgLd1eOdwEtY1ISVJLL
 JaV45qySfhTLrNVlCtsaKBQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 54ac629f-5da7-11f1-b8d7-005056995d6c;
	Mon, 01 Jun 2026 12:47:48 +0200 (CEST)
Date: Mon, 1 Jun 2026 12:47:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Message-ID: <1841736563.45811.1780310868666@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260601070042.249432-2-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
 <20260601070042.249432-2-neilb@ownmail.net>
Subject: Re: [PATCH 01/18] VFS: move mnt_want_write() and locking into
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
	TAGGED_FROM(0.00)[bounces-22162-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:email,kpc.webmail.kpnmail.nl:mid]
X-Rspamd-Queue-Id: BF4AC61DEAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 01-06-2026 08:37 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> From: NeilBrown <neil@brown.name>
> 
> The mnt_want_write() call and the parent inode locking in
> open_last_lookups() are only needed for lookup_open().  So we can move
> them and all the got_write handling into lookup_open().
> 
> Note that we need to also check create_error when determining whether to
> unlock shared or not, as O_CREAT can be cleared.
> 
> The fsnotify calls come too as they must be in the locked region.
> 
> Also use the existing dir_inode uniformly for dir->d_inode.
> 
> This is a step towards exporting an better "open/create" interface to nfsd.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
> +	if (open_flag & O_CREAT)
> +		inode_lock(dir_inode);
> +	else
> +		inode_lock_shared(dir_inode);
> +

This is not about a change in your patch, but I do wonder whether we should
also set the lockdep subclass here. We aren't taking any other locks, but
that is also true in the create path of mknod, which ultimately calls start_dirop
and there we do

		inode_lock_nested(dir, I_MUTEX_PARENT);


> +	if (unlikely(IS_DEADDIR(dir_inode))) {
> +		dentry = ERR_PTR(-ENOENT);
> +		goto out;
> +	}
>  
>  	file->f_mode &= ~FMODE_CREATED;
>  	dentry = d_lookup(dir, &nd->last);
> @@ -4423,7 +4439,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		if (!dentry) {
>  			dentry = d_alloc_parallel(dir, &nd->last);
>  			if (IS_ERR(dentry))
> -				return dentry;
> +				goto out;
>  		}
>  		if (d_in_lookup(dentry))
>  			break;
> @@ -4439,7 +4455,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	}
>  	if (dentry->d_inode) {
>  		/* Cached positive dentry: will open in f_op->open */
> -		return dentry;
> +		goto out;
>  	}
>  
>  	if (open_flag & O_CREAT)
> @@ -4460,7 +4476,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
> -		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
> +		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
>  		if (likely(got_write))
>  			create_error = may_o_create(idmap, &nd->path,
>  						    dentry, mode);
> @@ -4475,7 +4491,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
>  		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
>  			dentry = ERR_PTR(create_error);
> -		return dentry;
> +		goto out;
>  	}
>  
>  	if (d_in_lookup(dentry)) {
> @@ -4515,11 +4531,27 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		error = create_error;
>  		goto out_dput;
>  	}
> +out:
> +	if (!IS_ERR(dentry)) {
> +		if (file->f_mode & FMODE_CREATED)
> +			fsnotify_create(dir_inode, dentry);
> +		if (file->f_mode & FMODE_OPENED)
> +			fsnotify_open(file);
> +	}

We can move this later if my changes land to the vfs_* and atomic_open() functions.

> +	if ((open_flag & O_CREAT) || create_error)
> +		inode_unlock(dir_inode);
> +	else
> +		inode_unlock_shared(dir_inode);
> +
> +	if (got_write)
> +		mnt_drop_write(nd->path.mnt);
> +
>  	return dentry;
>  
>  out_dput:
>  	dput(dentry);
> -	return ERR_PTR(error);
> +	dentry = ERR_PTR(error);
> +	goto out;
>  }
>  
>  static inline bool trailing_slashes(struct nameidata *nd)
> @@ -4562,9 +4594,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		   struct file *file, const struct open_flags *op)
>  {
>  	struct delegated_inode delegated_inode = { };
> -	struct dentry *dir = nd->path.dentry;
>  	int open_flag = op->open_flag;
> -	bool got_write = false;
>  	struct dentry *dentry;
>  	const char *res;
>  
> @@ -4594,32 +4624,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		}
>  	}
>  retry:
> -	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> -		got_write = !mnt_want_write(nd->path.mnt);
> -		/*
> -		 * do _not_ fail yet - we might not need that or fail with
> -		 * a different error; let lookup_open() decide; we'll be
> -		 * dropping this one anyway.
> -		 */
> -	}
> -	if (open_flag & O_CREAT)
> -		inode_lock(dir->d_inode);
> -	else
> -		inode_lock_shared(dir->d_inode);
> -	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
> -	if (!IS_ERR(dentry)) {
> -		if (file->f_mode & FMODE_CREATED)
> -			fsnotify_create(dir->d_inode, dentry);
> -		if (file->f_mode & FMODE_OPENED)
> -			fsnotify_open(file);
> -	}
> -	if (open_flag & O_CREAT)
> -		inode_unlock(dir->d_inode);
> -	else
> -		inode_unlock_shared(dir->d_inode);
> -
> -	if (got_write)
> -		mnt_drop_write(nd->path.mnt);
> +	dentry = lookup_open(nd, file, op, &delegated_inode);
>  
>  	if (IS_ERR(dentry)) {
>  		if (is_delegated(&delegated_inode)) {
> -- 
> 2.50.0.107.gf914562f5916.dirty

I will say we are doing a lot in lookup_open(), but since open_last_lookups() is
its only caller, and there is no particular reason that I see for doing this work
there, this is fine by me if it helps your nfsd refactor.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

