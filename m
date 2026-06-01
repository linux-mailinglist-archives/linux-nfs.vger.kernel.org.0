Return-Path: <linux-nfs+bounces-22165-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPCDJvl5HWrEbAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22165-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 14:24:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4B561F375
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5BFF300B9C6
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7735AC17;
	Mon,  1 Jun 2026 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QalWFf+a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0F374725
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jun 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316658; cv=none; b=oaKaHH5a5q60FFh8vgoTNRP7YIcIi0dga9fZmJ2UIYnEliW6lCFP8pHbHwfFBh8lRbR+sOfho0ZvhYoUcuU7s56mJNymaxhSOuHIwKjrUI/whaslHBI4i31Tm/ip6DISbezaqoJMfbFXGUITIrg6indWqwcPGU6ef9rZ2elTzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316658; c=relaxed/simple;
	bh=+smLjtGx5oF9ylDiGpO7GFzShSyCfPEfdLQIeCgyKTg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oPakTWvEuvgjdNvzoeaOP/vTsXYYdR9PsKljzkEFD2KKoTGiPtE36/WnbQMnxoQjoCAUlOAzV42oYRWs6nv5sBG78GZLkrm/RrJ9na+c8wk+WswqGiLT/rIFs/Nx/hpdrsF/HlWx0Ypl+UKRKvpZr9YpwmVkQ/9V5IoqozoKC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=QalWFf+a; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: a54dc046-5db4-11f1-beaa-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a54dc046-5db4-11f1-beaa-005056992ed3;
	Mon, 01 Jun 2026 14:23:07 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id a5519007-5db4-11f1-99d0-0050569977a2;
	Mon, 01 Jun 2026 14:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=KVj390ANGSXumb5q2+oPQP2xokNZ6mT7VbPZWGjH3Rg=;
	b=QalWFf+aiB7lhngLJUBBBaPUC7G6ZIlaz9N9NP01u1yhpktwybkmM0VBRX64iWWvJhfQphaTBwRv8
	 i2i4dR3+GZB9DiFs3xcLZYRcAAzyDxDZRVCYB5xH5Bk4+fsJiMmUNSpSLRDBzpvtgCghEPnwgz3+fb
	 esYXV/1pwgK1DbrGP/8wrzhANzTqxVIqnl2ydlqEGMytfodJ9DRwzIdbUjUpxDnbuA1B9kC3B5LGzH
	 eoSZukyvXhC/R5QQaEhk2224VWOJHpsvG3zY4L3OUKZbdPKAg6bWJ94paeuZaHzHUz65/iIIge4zAv
	 EDjVFvFaUoXPSABXZnt93w9lkJpxlgw==
X-KPN-MID: 33|0hXWF57/7TMWBeT7xRW/BlboLEGeN2rXrXz+u+NNgcWPHmMqNoyErUskdXrIL4l
 pIAsYMYIMnQKo+dIWpbXc2F7JWjih+mweBp7NQOfaWws=
X-CMASSUN: 33|iaCF3JmTOlV+bTSvYgumxlQMjb18zQa6ZLknb4/kbUBxltUm+QBeoXzpwPdBiJn
 sUh29lEP8AakzSZCOr4vcrg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id a543c62b-5db4-11f1-94b1-00505699eff2;
	Mon, 01 Jun 2026 14:23:07 +0200 (CEST)
Date: Mon, 1 Jun 2026 14:23:07 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Message-ID: <1651506692.61058.1780316587334@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260601070042.249432-5-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
 <20260601070042.249432-5-neilb@ownmail.net>
Subject: Re: [PATCH 04/18] VFS: add vfs_lookup_open()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22165-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,xs4all.nl:dkim,ownmail.net:email]
X-Rspamd-Queue-Id: 8D4B561F375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 01-06-2026 08:37 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> From: NeilBrown <neil@brown.name>
> 
> vfs_lookup_open() is a limited version of lookup_open() which is
> exported for nfsd to use - to replace dentry_create().
> 
> It is limited in that no filename is given (thus no auditing) and no
> LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> the open flags.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 54 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  3 +++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 18a43c24d7f1..db3fddbccd21 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4571,6 +4571,60 @@ static struct dentry *lookup_open(const struct path *path, struct file *file,
>  	goto out;
>  }
>  
> +/**
> + * vfs_lookup_open - open and possibly create a regular file
> + * @parent: directory to contain file
> + * @last: final component of file name
> + * @open_flag: O_flags
> + * @mode: initial permissions for file
> + *
> + * Open a file after lookup and/or create.  This provides similar
> + * functionality open_last_lookups() for in-kernel users, particularly
> + * nfsd.
> + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> + *
> + * Returns: the opened struct file, or an error.
> + */
> +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> +			     int open_flag, umode_t mode)
> +{
> +	struct file *file __free(fput) = NULL;
> +	unsigned int lookup_flags = LOOKUP_OPEN;
> +	struct dentry *dentry;
> +	int error = 0;
> +
> +	error = lookup_noperm_common(last, parent->dentry);
> +	if (error)
> +		return ERR_PTR(error);
> +
> +	file = alloc_empty_file(open_flag, current_cred());
> +	if (IS_ERR(file))
> +		return file;
> +
> +	if (open_flag & O_CREAT) {
> +		lookup_flags |= LOOKUP_CREATE;
> +		if (open_flag & O_EXCL)
> +			lookup_flags |= LOOKUP_EXCL;

Is O_EXCL enforced anywhere in this call path? I don't really know nfsd, but
for the standard O_CREAT call chain, this happens in do_open(), and EEXIST is
returned.

Also, maybe warn when nonsensical bits here, like __O_TMPFILE, are set in
open_flag?

> +	}
> +	dentry = lookup_open(parent, file, last, lookup_flags, NULL,
> +			     open_flag, S_IFREG | mode);
> +	if (IS_ERR(dentry))
> +		return ERR_CAST(dentry);
> +
> +	if (d_really_is_negative(dentry)) {
> +		error = -ENOENT;
> +	} else if (!(file->f_mode & FMODE_OPENED)) {
> +		struct path path = {.mnt = parent->mnt, .dentry = dentry };
> +
> +		error = vfs_open(&path, file);

Ah, good, this fixes the bug in dentry_create() where on failing the open
part of atomic_open() no other attempt was done by the vfs to do the open.

> +	}
> +	dput(dentry);
> +
> +	if (error)
> +		return ERR_PTR(error);
> +	return no_free_ptr(file);
> +}
> +
>  static inline bool trailing_slashes(struct nameidata *nd)
>  {
>  	return (bool)nd->last.name[nd->last.len];
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 2ad6dd9987b9..8c048c97a7f7 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -103,6 +103,9 @@ struct dentry *start_creating_dentry(struct dentry *parent,
>  struct dentry *start_removing_dentry(struct dentry *parent,
>  				     struct dentry *child);
>  
> +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> +			     int open_flag, umode_t mode);
> +
>  /* end_creating - finish action started with start_creating
>   * @child: dentry returned by start_creating() or vfs_mkdir()
>   *
> -- 
> 2.50.0.107.gf914562f5916.dirty

