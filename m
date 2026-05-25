Return-Path: <linux-nfs+bounces-21929-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ9KEF93FGokNgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21929-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:22:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52245CCC9E
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A18630054C3
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C13F411B;
	Mon, 25 May 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CROIlxN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1pampqlv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/kIQAQb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yxxr3rsI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4E3F167C
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726172; cv=none; b=FUA9sCcRocMKUyDAbtAOM9pXYrIRX2GGvYSGA9Kx2Uj00O48PaTEnfad/vaJcSFeNzf+Uy6c8Nh02isIMi3GBEHsqAB/XcOkV9/q4kvk2mR8+jWFbdA4IpIHrqy4wkhgMAZSqPA3FZ2LrZda5GkjHdbIwJoKtDKFsqV+EXW98IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726172; c=relaxed/simple;
	bh=joylWBpc+npP1kt2/jT00dsTQm3Kjy8To61Ke+Kze3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw2ECSZk2rgAvQa3VjgxtF8m4JogR6BiMcjvnmcYOKzcyQOJ6ruMA5dt1wc0sZyP8q+6J8z8cGse8pcNEQJKIRVU3s02qFaMVc72bh9inwLSz9qyJCqqlCkBQ9L2NX7WeB2jjuuJLpLsu0KssDRpdMRycfeGWKNCNlhvXNC3/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CROIlxN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1pampqlv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/kIQAQb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yxxr3rsI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6DBF759A8;
	Mon, 25 May 2026 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779726169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Rj6kZ0NZp1iUbs/A+rai1k6L44nNzXx4GMbHIbDpA=;
	b=CROIlxN3F0ObxWV/Iu/DxbyYO8fY1G/KsbUQjVbUZ7jNjGxq/axpM7Z6Hcrtp0J5kV95Os
	s69vQZu0pt0DWi79fEOAdoCyhdBxJrCrAru4VLMg0W8zEW/VGD6sRRpF41f3LIIGCX+b2A
	ELy2pw2Vs565hQN3S+A9+ISHXhrD26w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779726169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Rj6kZ0NZp1iUbs/A+rai1k6L44nNzXx4GMbHIbDpA=;
	b=1pampqlvhhCCMiFlEH4DgYdzfRSqFspW6orJv0PlK7a01gd8kl9Y1TDHGUZtqq7nL38yIC
	sqboCRZsUszSljBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779726167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Rj6kZ0NZp1iUbs/A+rai1k6L44nNzXx4GMbHIbDpA=;
	b=n/kIQAQbetBxxKWKB6ItGTA0HFXd4tac5/pOy5zzMmzts1tG/O6nlR6NxXk+nKchzZBjKk
	DMcMEzICYp0yyTtMb6X2ILX9D2jmehiUtkPCcd5+gsU4SgHzQz8y569zfIGMaZG+gu4DEK
	xTg9i/K/4IVCEWmy5UnZ72gXoIt+XHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779726167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Rj6kZ0NZp1iUbs/A+rai1k6L44nNzXx4GMbHIbDpA=;
	b=Yxxr3rsICOcg2IPAVwcgOH6KiMXLNJ6HUNyaDsFuA+/t13Z8MXxQPya+c8hsgablBldfKt
	dmDltR06SSFbbyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C977559D2A;
	Mon, 25 May 2026 16:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z8orMVZ3FGpbJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 16:22:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DCB17A08D7; Mon, 25 May 2026 18:22:45 +0200 (CEST)
Date: Mon, 25 May 2026 18:22:45 +0200
From: Jan Kara <jack@suse.cz>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/17] configfs: replace __get_free_pages() with kzalloc()
Message-ID: <cnxlypiisnshulqluro2maw5vjnmmkbnvbkflfld3cv6j4m2zl@z3kwuj5nxx2u>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-15-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-b4-fs-v1-15-275e36a83f0e@kernel.org>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21929-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D52245CCC9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat 23-05-26 20:54:27, Mike Rapoport (Microsoft) wrote:
> configfs allocates staging buffers __get_free_pages().
> 
> kmalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
> 
> Replace use of __get_free_pages() with kzalloc().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index ef8c3cd10cc6..a48cece775a3 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -59,7 +59,7 @@ static int fill_read_buffer(struct file *file, struct configfs_buffer *buffer)
>  	ssize_t count = -ENOENT;
>  
>  	if (!buffer->page)
> -		buffer->page = (char *) get_zeroed_page(GFP_KERNEL);
> +		buffer->page = kzalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!buffer->page)
>  		return -ENOMEM;
>  
> @@ -184,7 +184,7 @@ static int fill_write_buffer(struct configfs_buffer *buffer,
>  	int copied;
>  
>  	if (!buffer->page)
> -		buffer->page = (char *)__get_free_pages(GFP_KERNEL, 0);
> +		buffer->page = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!buffer->page)
>  		return -ENOMEM;
>  
> @@ -381,8 +381,7 @@ static int configfs_release(struct inode *inode, struct file *filp)
>  	struct configfs_buffer *buffer = filp->private_data;
>  
>  	module_put(buffer->owner);
> -	if (buffer->page)
> -		free_page((unsigned long)buffer->page);
> +	kfree(buffer->page);
>  	mutex_destroy(&buffer->mutex);
>  	kfree(buffer);
>  	return 0;
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

