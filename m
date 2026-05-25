Return-Path: <linux-nfs+bounces-21926-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM3BDkR2FGokNgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21926-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:18:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A27885CCB35
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13A6A3006510
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C63F20E4;
	Mon, 25 May 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NnTuw9Qf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9yAYd8D0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NnTuw9Qf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9yAYd8D0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E653AD52D
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725867; cv=none; b=pc89AM8UtLgfymdxgQ1HflnorK+ZVKn93a/M8TQLieqdf+hfyQfriB0nh1UvGTpNYSh0oExDUkVht7u2kXw6CfG2lNGfa6nrBD0FaAholstdJj8TEuf3iVyOniD6jxo15vIIA4SDKJR41YpBrHNJBU4z1xIxOqJ5bc5tFh8RDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725867; c=relaxed/simple;
	bh=oMyVHJUpSpeQgkkhRO5IRWXWHc0rrJ5CAF/yLvmozYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjcvyTaJnJKm8P2E9rfOMOLfGidtdTgPHYIyOsqLBxh4HSlJuwhSWFxcWyhBLA3UoQkaqWZD80qX/s9UiYU/vzAQCV0vsA70XjLcW+bNrsynpPLDsf5om9fkXIUeBNgrIK2BkVmqJHgaAs2cUI9dPeo1AGegCNohasn+obYfnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NnTuw9Qf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9yAYd8D0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NnTuw9Qf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9yAYd8D0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE9D06B9D6;
	Mon, 25 May 2026 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LiOhrDB5Siu3BTzKB3ll2nZPIejX17ixL8z+kYTNnLc=;
	b=NnTuw9QfP7qRtu2Fcp2vHUcRpfCDPlfel0Odrx2m+0NDQPjck4mgVNMbs4uoYUGxzZoO0v
	5V1kkbw+CDrwdCjYTS8Fo1NSl84SIozibO6xqnzX29Rpc4y9FeVI7ssusljL01vgsGrBK+
	aP58bM5ofqnG+wnRmVQOK/6ypGlJUWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LiOhrDB5Siu3BTzKB3ll2nZPIejX17ixL8z+kYTNnLc=;
	b=9yAYd8D0/oNcJBhN5rQ5AnAGQq7z/4JSzQDJidYmuem9vnfeYzSvD7oWP7sni9eRMOLXwp
	EIxPW5DxVLeI+5Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LiOhrDB5Siu3BTzKB3ll2nZPIejX17ixL8z+kYTNnLc=;
	b=NnTuw9QfP7qRtu2Fcp2vHUcRpfCDPlfel0Odrx2m+0NDQPjck4mgVNMbs4uoYUGxzZoO0v
	5V1kkbw+CDrwdCjYTS8Fo1NSl84SIozibO6xqnzX29Rpc4y9FeVI7ssusljL01vgsGrBK+
	aP58bM5ofqnG+wnRmVQOK/6ypGlJUWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LiOhrDB5Siu3BTzKB3ll2nZPIejX17ixL8z+kYTNnLc=;
	b=9yAYd8D0/oNcJBhN5rQ5AnAGQq7z/4JSzQDJidYmuem9vnfeYzSvD7oWP7sni9eRMOLXwp
	EIxPW5DxVLeI+5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B08C659D25;
	Mon, 25 May 2026 16:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fbEXKyh2FGpqHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 16:17:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D2D7A08D7; Mon, 25 May 2026 18:17:44 +0200 (CEST)
Date: Mon, 25 May 2026 18:17:44 +0200
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
Subject: Re: [PATCH 11/17] isofs: replace __get_free_page() with kmalloc()
Message-ID: <wxxq23pmklhklkmp6a6i4wfrzb4sn2wnvqlmmfeefbpbj4pmj6@y2k3f56igj3u>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-11-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-b4-fs-v1-11-275e36a83f0e@kernel.org>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21926-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A27885CCB35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat 23-05-26 20:54:23, Mike Rapoport (Microsoft) wrote:
> isofs_readdir() allocates a temporary buffer with __get_free_page().
> 
> kmalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
> 
> Replace use of __get_free_page() with kmalloc().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks. Added to my tree.

								Honza

> ---
>  fs/isofs/dir.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index 2fd9948d606e..6d220eab531e 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -13,6 +13,7 @@
>   */
>  #include <linux/gfp.h>
>  #include <linux/filelock.h>
> +#include <linux/slab.h>
>  #include "isofs.h"
>  
>  int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
> @@ -255,7 +256,7 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
>  	struct iso_directory_record *tmpde;
>  	struct inode *inode = file_inode(file);
>  
> -	tmpname = (char *)__get_free_page(GFP_KERNEL);
> +	tmpname = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (tmpname == NULL)
>  		return -ENOMEM;
>  
> @@ -263,7 +264,7 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
>  
>  	result = do_isofs_readdir(inode, file, ctx, tmpname, tmpde);
>  
> -	free_page((unsigned long) tmpname);
> +	kfree(tmpname);
>  	return result;
>  }
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

