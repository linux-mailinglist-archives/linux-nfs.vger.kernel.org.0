Return-Path: <linux-nfs+bounces-20743-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uACjNYRe1mkfEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20743-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:56:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E53BD3FA
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE15C303E4B2
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82413D1703;
	Wed,  8 Apr 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rXEMWP6E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k34VD8+C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ve+vNuMJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMbTuJas"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817613939CE
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656406; cv=none; b=kbkUVaapXWLYY2pQWmzkJlR9s52b5IXobJ61ro6O46QL3YPuv7DgyEe6ptbdCGk8j4oceJkV3D0uFEd1P/8rwDeAt3FL43nWk+MwnJFFzkCCHRrjyBOzGdCaeQHt78mn1fP9NsBGuLtBc8TEkJt/DIGlPqNF9mg+5udPGfGQGLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656406; c=relaxed/simple;
	bh=P/W9FNxaT8oCl0C9P8gGMeoeXIMZOD0rzKXEA2zRV/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uya+2nLymFqmgQ2VPKwL+PY6eD1zOx6TJ6PbkhNRXrn/YBd1/hp77aNwfqQpPgHHJ/yADtQCYXyVtnhkN9svAaCqPxyzpJdf2XR2dtODx6Z0sWuUiBwc+42eQqi3Qd5cb4pkdeQnrrtehOwtIucTi3xfBDk2RIXEaUVtU+IQvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rXEMWP6E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k34VD8+C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ve+vNuMJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMbTuJas; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAB215BCC1;
	Wed,  8 Apr 2026 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775656403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ8uDr8vA7VVp6EukI8oWSdY8u+Kp1klfjdsLd4KFWc=;
	b=rXEMWP6EQ/YOqrizw0bLvI2IDREP2fe27oQ4o49bzyudcqyFfwsAisDknX/PyUx8ipNsJZ
	hQS2fodU+fHbWebWL8W/JRzt1jlMYdr+xL478BwUcNHpO34sel0JtNuDt5SGtxwOLdxdjo
	iX3d1lQOz3mIKbky0Nz5FBOvfW5gvZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775656403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ8uDr8vA7VVp6EukI8oWSdY8u+Kp1klfjdsLd4KFWc=;
	b=k34VD8+CP9hd1ZPo06dmTqJv2U00vqXIXunkfMMTHWpDL0PfdInxuCpJDraVglMLkTB343
	wAFq7VgDUUJmnzCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775656402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ8uDr8vA7VVp6EukI8oWSdY8u+Kp1klfjdsLd4KFWc=;
	b=Ve+vNuMJoPClVjiuYaI5vJ+Gs4rxZE7QxcKCxWzxA6IP+QB8/F8b9VLeNA2xk+UbG3ocRr
	mVkp2pO0TwlvLb7X81FmFkyt/cSWO2txvp9NLcwzmiMf7GwF0HML0YbQzRGbMDUMymsFNo
	TGGsaujxauCiyP63p+1owdAiY/iMqpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775656402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ8uDr8vA7VVp6EukI8oWSdY8u+Kp1klfjdsLd4KFWc=;
	b=QMbTuJasjO6W8JdjmNMTL6QrzUcFAHyOORzEy/tgtpZ/iemEwSqaqrSAEsDRlZZGl85QSL
	vqJOat/XDq6mnlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCB8F4A0B3;
	Wed,  8 Apr 2026 13:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zjrhNdJd1mlrPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Apr 2026 13:53:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2ED5A0A7E; Wed,  8 Apr 2026 15:53:18 +0200 (CEST)
Date: Wed, 8 Apr 2026 15:53:18 +0200
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
Subject: Re: [PATCH 03/24] filelock: add an inode_lease_ignore_mask helper
Message-ID: <6gdexrbcrpe64sy6ojjzujh2kk4pc4u2caz2gdeuodi6hcfytl@rgkc6k7izss3>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
 <20260407-dir-deleg-v1-3-aaf68c478abd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-dir-deleg-v1-3-aaf68c478abd@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
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
	TAGGED_FROM(0.00)[bounces-20743-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim,suse.cz:email];
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
X-Rspamd-Queue-Id: 2D0E53BD3FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 07-04-26 09:21:16, Jeff Layton wrote:
> Add a new routine that returns a mask of all dir change events that are
> currently ignored by any leases. nfsd will use this to determine how to
> configure the fsnotify_mark mask.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/locks.c               | 32 ++++++++++++++++++++++++++++++++
>  include/linux/filelock.h |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 5af6dca2d46c..04980b065734 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1597,6 +1597,38 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
>  	return false;
>  }
>  
> +#define IGNORE_MASK	(FL_IGN_DIR_CREATE | FL_IGN_DIR_DELETE | FL_IGN_DIR_RENAME)
> +
> +/**
> + * inode_lease_ignore_mask - return union of all ignored inode events for this inode
> + * @inode: inode of which to get ignore mask
> + *
> + * Walk the list of leases, and return the result of all of
> + * their FL_IGN_DIR_* bits or'ed together.
> + */
> +u32
> +inode_lease_ignore_mask(struct inode *inode)
> +{
> +	struct file_lock_context *ctx;
> +	struct file_lock_core *flc;
> +	u32 mask = 0;
> +
> +	ctx = locks_inode_context(inode);
> +	if (!ctx)
> +		return 0;
> +
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
> +		mask |= flc->flc_flags & IGNORE_MASK;
> +		/* If we already have everything, we can stop */
> +		if (mask == IGNORE_MASK)
> +			break;
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	return mask;
> +}
> +EXPORT_SYMBOL_GPL(inode_lease_ignore_mask);
> +
>  static bool
>  ignore_dir_deleg_break(struct file_lease *fl, unsigned int flags)
>  {
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 5a19cdb047da..416483b136f1 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -236,6 +236,7 @@ int generic_setlease(struct file *, int, struct file_lease **, void **priv);
>  int kernel_setlease(struct file *, int, struct file_lease **, void **);
>  int vfs_setlease(struct file *, int, struct file_lease **, void **);
>  int lease_modify(struct file_lease *, int, struct list_head *);
> +u32 inode_lease_ignore_mask(struct inode *inode);
>  
>  struct notifier_block;
>  int lease_register_notifier(struct notifier_block *);
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

