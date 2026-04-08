Return-Path: <linux-nfs+bounces-20745-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CUzCfRe1mkfEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20745-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:58:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392D3BD478
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7070306B398
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457693D0914;
	Wed,  8 Apr 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZpqarNN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="45S3zz8c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZpqarNN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="45S3zz8c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31653D1707
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656433; cv=none; b=Lkc+/WkZ2PHDjIfoZSTUyLAIQ4GI9tht7xDudqIldRjNR4Bbhr0cdalPvUw/rebyG/KstseCqM0y+W5h7H3AI7zVMOyJqYVWS3BAcy4Dz9ftAwnf0MJYZNFH7ZZ/qn0k032JfMYlBXumi87EiLyooW/O/34iJ5gXfdQz/osMFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656433; c=relaxed/simple;
	bh=rroQmESzhV8c9DWd5tZkVVfrrupA+slILBR9VDG7oaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2KEhH/2oNENFN/3p/NkySp4U9Ljb3CyEe6/KqSrimuT5O8Tfm7ZmqaColIZQO9xBi+kEiTqhmFlafh+4Q5eeYu8GcVtmmaVxOYXjWmzAvnTB+AxN0nMdabIwnC3DEmvYVBFS5MjV7AjHGTuko1aKOkA7+Xx/0Tc4Um3vvfiASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fZpqarNN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=45S3zz8c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fZpqarNN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=45S3zz8c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09B844E9F5;
	Wed,  8 Apr 2026 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775656429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8N6aXHtI40DfgX/faAcELwkLZiVOWJwDK9ISbaOf/Q=;
	b=fZpqarNNGFv2EHZyBtHd+Wfngbz2xKdEBjOYvU6Oxqyf+Z8ux2gUYHsD+9X8ISeEfH0mSv
	jPrIe0Y82Rr3wc+J+nbLI5K9njlRdRDvjz0wjPGCI8cd6jY8tpcZEMTzlDMCfa6hRnxQRx
	kPElBJVOtfkEahWGVjAzj3r/QChlSvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775656429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8N6aXHtI40DfgX/faAcELwkLZiVOWJwDK9ISbaOf/Q=;
	b=45S3zz8cToy6kS/Wppa9MPynSIOP7A693Bu0ZOI/9CT9U7VMf8GmyjXo750+JGsf2Mi2VH
	ZV0nxIS5G4C7xuDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fZpqarNN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=45S3zz8c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775656429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8N6aXHtI40DfgX/faAcELwkLZiVOWJwDK9ISbaOf/Q=;
	b=fZpqarNNGFv2EHZyBtHd+Wfngbz2xKdEBjOYvU6Oxqyf+Z8ux2gUYHsD+9X8ISeEfH0mSv
	jPrIe0Y82Rr3wc+J+nbLI5K9njlRdRDvjz0wjPGCI8cd6jY8tpcZEMTzlDMCfa6hRnxQRx
	kPElBJVOtfkEahWGVjAzj3r/QChlSvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775656429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8N6aXHtI40DfgX/faAcELwkLZiVOWJwDK9ISbaOf/Q=;
	b=45S3zz8cToy6kS/Wppa9MPynSIOP7A693Bu0ZOI/9CT9U7VMf8GmyjXo750+JGsf2Mi2VH
	ZV0nxIS5G4C7xuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F279A4A0B3;
	Wed,  8 Apr 2026 13:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q0AwO+xd1mk7PwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Apr 2026 13:53:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0BF4A0A7E; Wed,  8 Apr 2026 15:53:48 +0200 (CEST)
Date: Wed, 8 Apr 2026 15:53:48 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Calum Mackay <calum.mackay@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 08/24] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Message-ID: <3bxtqnifeutht7dmyp4svv5k2npk5e53ggegx7lzmj73vsspkx@icmnt57p7rhk>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
 <20260407-dir-deleg-v1-8-aaf68c478abd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-dir-deleg-v1-8-aaf68c478abd@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20745-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9392D3BD478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 07-04-26 09:21:21, Jeff Layton wrote:
> Add a new helper function that will update the mask on the nfsd_file's
> fsnotify_mark to be a union of all current directory delegations on an
> inode. Call that when directory delegations are added or removed.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nfsd/nfs4state.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c8fb84c38637..9a4cff08c67d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1258,6 +1258,37 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
>  	}
>  }
>  
> +static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
> +{
> +	struct fsnotify_mark *mark = &nf->nf_mark->nfm_mark;
> +	struct inode *inode = file_inode(nf->nf_file);
> +	u32 lease_mask, set = 0, clear = 0;
> +
> +	/* This is only needed when adding or removing dir delegs */
> +	if (!S_ISDIR(inode->i_mode))
> +		return;
> +
> +	/* Set up notifications for any ignored delegation events */
> +	lease_mask = inode_lease_ignore_mask(inode);
> +
> +	if (lease_mask & FL_IGN_DIR_CREATE)
> +		set |= FS_CREATE;
> +	else
> +		clear |= FS_CREATE;
> +
> +	if (lease_mask & FL_IGN_DIR_DELETE)
> +		set |= FS_DELETE;
> +	else
> +		clear |= FS_DELETE;
> +
> +	if (lease_mask & FL_IGN_DIR_RENAME)
> +		set |= FS_RENAME;
> +	else
> +		clear |= FS_RENAME;
> +
> +	fsnotify_modify_mark_mask(mark, set, clear);
> +}
> +
>  static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
>  {
>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
> @@ -1266,6 +1297,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
>  	WARN_ON_ONCE(!fp->fi_delegees);
>  
>  	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
> +	nfsd_fsnotify_recalc_mask(nf);
>  	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
>  	put_deleg_file(fp);
>  }
> @@ -9652,6 +9684,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
>  
>  	if (!status) {
>  		put_nfs4_file(fp);
> +		nfsd_fsnotify_recalc_mask(nf);
>  		return dp;
>  	}
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

