Return-Path: <linux-nfs+bounces-21922-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKefCWB0FGokNgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21922-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:10:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B07275CC9E1
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 260C330071CB
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153E233F8CA;
	Mon, 25 May 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fO4rShwn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8CuABOSu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/5mq3v3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePm/y7Ab"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67F371068
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725406; cv=none; b=AfkA0YyO8O53qRHiWr9TzBsup/pl6qT0cvuF9ob5q1IyV38JWuJsOPR7xlWP46jsHm6rot9wfCO7wN8TYJv5ryTZGGIaiM7DAcWm0DCJXVwZ+ltd+WdovYcfQncyl6aI0OFCdUGEl+XXWNlXoEr9EYAsaZJqJoErI+tzg4eGRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725406; c=relaxed/simple;
	bh=LvkqacNHqa0yNV+l1XvGYAx4+tIi7P/ocAJeqA6BNpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIfT73cV8NbsKsCoXBeOJmUN4ls20Q6SaSyU+dOxg0YXzCZVVEUyApg4kk8oYSMOgr9x4tWOjQaUWWq4ltTfTCiA9DO0h13nQ1kH5l8Z8l3YRfcHiqMiyfbleItPrTnr2fq6YC2gJVzAh78bOwoZ5GlHI5cI8t5v+qa1j6S/68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fO4rShwn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8CuABOSu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/5mq3v3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePm/y7Ab; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF4BE67348;
	Mon, 25 May 2026 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzQMwNuzcTyDWDBbrPJPk+oWqpbFufgu+tYxwJzuBcA=;
	b=fO4rShwnpRca/Qq5O5dxQ0BFI4I7JU8ZvchsxsYB2KOnAHYByNilhFy7ZhQmPdse2qBgxr
	1EJdV6hae2L3Q2wFNfmlzmlMqdCDBUmuYcAsTvw0e7hEOeO/oASDzBJmlh8N0cUO6qkv/D
	u/VTU/tIoYlYjbzA6JqzmS3QJkei470=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzQMwNuzcTyDWDBbrPJPk+oWqpbFufgu+tYxwJzuBcA=;
	b=8CuABOSukBh/JOGoxdhoaM6XBagg0YJ4CgJiNPWcgimpcpAHRDawAfN6EsFSfMjXWRl/9H
	fQS3Dit/JgMtZyBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="U/5mq3v3";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ePm/y7Ab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzQMwNuzcTyDWDBbrPJPk+oWqpbFufgu+tYxwJzuBcA=;
	b=U/5mq3v3OCXAkr6Sjo6oRmqrs0tOQEwI5lkKi618l1AhAqyBkmorllMpPseqWOS0et5fHv
	ovfPAMkU8QK34zrEPC5YWj3ZO3pym0SHQxLtDufibCoit05OiVufj9a80rYcRFqLG9XwEf
	MZcxcPxZaybt//fplWyDTNqSi7HPLnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzQMwNuzcTyDWDBbrPJPk+oWqpbFufgu+tYxwJzuBcA=;
	b=ePm/y7Ab8Y6GajHNFTPHGNLubf7O6wf3vduHG1/Gag7Bjb3cUucL32Ipd0cybpnJns+YVi
	CKubuBr2EdjSLsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E05359D1D;
	Mon, 25 May 2026 16:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YBHzJVl0FGqXFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 16:10:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D01BAA08D7; Mon, 25 May 2026 18:10:00 +0200 (CEST)
Date: Mon, 25 May 2026 18:10:00 +0200
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
Subject: Re: [PATCH 01/17] quota: allocate dquot_hash with kmalloc()
Message-ID: <xsmgh26s23da43wv6jza3dqrzhbxuetupiykjis2gkaq53yx3j@kttd6p2ba7f6>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-1-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-b4-fs-v1-1-275e36a83f0e@kernel.org>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21922-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B07275CC9E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat 23-05-26 20:54:13, Mike Rapoport (Microsoft) wrote:
> dquot_init() allocates a single page for dquot_hash with
> __get_free_pages().
> 
> kmalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
> 
> Replace use of __get_free_pages() with kmalloc() and get rid of the order
> variable that remained 0 for more than 20 years.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks! I've added this patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 64cf42721496..9850de3955d3 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -3022,7 +3022,7 @@ static const struct ctl_table fs_dqstats_table[] = {
>  static int __init dquot_init(void)
>  {
>  	int i, ret;
> -	unsigned long nr_hash, order;
> +	unsigned long nr_hash;
>  	struct shrinker *dqcache_shrinker;
>  
>  	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
> @@ -3035,8 +3035,7 @@ static int __init dquot_init(void)
>  				SLAB_PANIC),
>  			NULL);
>  
> -	order = 0;
> -	dquot_hash = (struct hlist_head *)__get_free_pages(GFP_KERNEL, order);
> +	dquot_hash = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!dquot_hash)
>  		panic("Cannot create dquot hash table");
>  
> @@ -3046,7 +3045,7 @@ static int __init dquot_init(void)
>  		panic("Cannot create dquot stat counters");
>  
>  	/* Find power-of-two hlist_heads which can fit into allocation */
> -	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
> +	nr_hash = PAGE_SIZE / sizeof(struct hlist_head);
>  	dq_hash_bits = ilog2(nr_hash);
>  
>  	nr_hash = 1UL << dq_hash_bits;
> @@ -3054,8 +3053,8 @@ static int __init dquot_init(void)
>  	for (i = 0; i < nr_hash; i++)
>  		INIT_HLIST_HEAD(dquot_hash + i);
>  
> -	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
> -		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
> +	pr_info("VFS: Dquot-cache hash table entries: %ld (%ld bytes)\n",
> +		nr_hash, PAGE_SIZE);
>  
>  	dqcache_shrinker = shrinker_alloc(0, "dquota-cache");
>  	if (!dqcache_shrinker)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

