Return-Path: <linux-nfs+bounces-22163-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HAzJOprHWrqaAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22163-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 13:24:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3184E61E45C
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 13:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B89730089AF
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD43A1CF3;
	Mon,  1 Jun 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="PPcVetUO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCEF3A382D
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jun 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313061; cv=none; b=hPRXvMsR6HUQHwM/lqO9Pp8S2WFlFwZ+EiHhPZOH6xnbxJTFq0m0qfqrjx1yUFkBuH5K1+JQfi5Q9B+JGNhFMlIEt6VHs08OGzY9Q2SWJq6jG/YhGKJEITz68hCcdVyGCjxl9MN2qgmmPPfQYwbmHc0jNiHjld2ucgAhH/tJj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313061; c=relaxed/simple;
	bh=Bp//2v2F+wzGcqy+nA1rXRyyK+ypEiBTiE/7TriASd0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Vqjq4pRQ7YpePqrxQ4QyyTBDqxYB+E7EL8qX4LcmlmjlStQ8o/HSqauuEBM5x4PxFDxAcfPFyZvHcmvmhXujLY16OOr0uAwwuchZqalQ2nYF6O6OFOPEq+k6uZYIGtK34O86tSp4rJQjbmQPduWtk0MuJIyDEKnWjqTzIpGuiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=PPcVetUO; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 6d082512-5dac-11f1-8ff7-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6d082512-5dac-11f1-8ff7-005056999439;
	Mon, 01 Jun 2026 13:24:17 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 6d00f621-5dac-11f1-83dd-00505699891e;
	Mon, 01 Jun 2026 13:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=k26QEFLlDESbHEKCcXByL8Imv6c2RPYDHSFDzDwsrf8=;
	b=PPcVetUOG6If10QpXww1oZ0TNmX1ZJ0n3AGMCdu5U6FWhH9P0Z5P9s5Iqh3TGmL25UqIRKPneUtSd
	 hY7qzIq5nGji5TQ8gtxS+anC3OSjlqW3ap/0NnW05SyCpOw5qXX0G/JE8qfGZG5Syfu5Mc9M90aGUR
	 BKj+KZQ2rT3V2jUJwySDKULrJ5OmG6L/qY/vzwUJEMCtLDWrLXTNh2XsJ+CRVnxQnprYn0GrllzwRP
	 fHJZRe99mUtnzcbnWpOLuamELDIf4xFjApYjVAlLBLzvYTazZk/XGk94eLhR+9Fm2/tBeMbZVvyNay
	 Mcryq8MiSY8v5zvKwcXX0D2oCx7cx8A==
X-KPN-MID: 33|LbUVlR5078hkgXNI/eAK0oSmm/AAVWprXRRqrgpIdbelqHjtu8Unkw4mJn65qiP
 Gwv9lkn6o+52kWYYeX7Rr9qeqNap2ULzqSWyC3mD52NY=
X-CMASSUN: 33|TUNyJCME+fAqQFjgUsgy8GF0GwZ9Qc5afRuzIdA67kNLQDHPSOQjpGhYUM5CkGC
 5grltvuLed7Zld7Hf/9UY9w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 6cf38d57-5dac-11f1-b8d7-005056995d6c;
	Mon, 01 Jun 2026 13:24:16 +0200 (CEST)
Date: Mon, 1 Jun 2026 13:24:16 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Message-ID: <1753137576.49821.1780313056882@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260601070042.249432-3-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
 <20260601070042.249432-3-neilb@ownmail.net>
Subject: Re: [PATCH 02/18] VFS: move delegated_inode retry loop into
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22163-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ownmail.net:email]
X-Rspamd-Queue-Id: 3184E61E45C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 01-06-2026 08:37 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> From: NeilBrown <neil@brown.name>
> 
> By moving this retry into lookup_open() we no longer need to pass around
> the delegated_inode pointer.
> 
> Various variable assignments need to be moved out of the declaration
> block so that they can still happen after the goto.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 998fde251fcf..b00ff3f2faf7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4403,17 +4403,23 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>   * An error code is returned on failure.
>   */
>  static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> -				  const struct open_flags *op,
> -				  struct delegated_inode *delegated_inode)
> +				  const struct open_flags *op)
>  {
> +	struct delegated_inode delegated_inode = { };
>  	struct mnt_idmap *idmap;
>  	struct dentry *dir = nd->path.dentry;
>  	struct inode *dir_inode = dir->d_inode;
> -	int open_flag = op->open_flag;
> +	int open_flag;
>  	struct dentry *dentry;
> -	int error, create_error = 0;
> -	umode_t mode = op->mode;
> -	bool got_write = false;
> +	int error, create_error;
> +	umode_t mode;
> +	bool got_write;
> +
> +retry:
> +	open_flag = op->open_flag;
> +	got_write = false;
> +	mode = op->mode;
> +	create_error = 0;
>  
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
>  		got_write = !mnt_want_write(nd->path.mnt);
> @@ -4511,7 +4517,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
>  		/* but break the directory lease first! */
> -		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
> +		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
>  		if (error)
>  			goto out_dput;
>  
> @@ -4546,6 +4552,14 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (got_write)
>  		mnt_drop_write(nd->path.mnt);
>  
> +	if (is_delegated(&delegated_inode)) {
> +		/* Must have come through out_dput */
> +		error = break_deleg_wait(&delegated_inode);
> +
> +		if (!error)
> +			goto retry;
> +	}
> +
>  	return dentry;
>  
>  out_dput:
> @@ -4593,7 +4607,6 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
>  static const char *open_last_lookups(struct nameidata *nd,
>  		   struct file *file, const struct open_flags *op)
>  {
> -	struct delegated_inode delegated_inode = { };
>  	int open_flag = op->open_flag;
>  	struct dentry *dentry;
>  	const char *res;
> @@ -4623,19 +4636,10 @@ static const char *open_last_lookups(struct nameidata *nd,
>  				return ERR_PTR(-ECHILD);
>  		}
>  	}
> -retry:
> -	dentry = lookup_open(nd, file, op, &delegated_inode);
> -
> -	if (IS_ERR(dentry)) {
> -		if (is_delegated(&delegated_inode)) {
> -			int error = break_deleg_wait(&delegated_inode);
>  
> -			if (!error)
> -				goto retry;
> -			return ERR_PTR(error);
> -		}
> +	dentry = lookup_open(nd, file, op);
> +	if (IS_ERR(dentry))
>  		return ERR_CAST(dentry);
> -	}
>  
>  	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
>  		dput(nd->path.dentry);
> -- 
> 2.50.0.107.gf914562f5916.dirty

It does make sense to me that we deal with the retry-loop in the function where
we call try_break_deleg(). That part is then dealt with on return to
open_last_lookups(). So I think, at least from a cognitive load perspective, this
change makes sense.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

