Return-Path: <linux-nfs+bounces-21924-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHbMJ0p1FGokNgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21924-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:14:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 157DD5CCA7D
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5504301CFFA
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80FE3F44D7;
	Mon, 25 May 2026 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TjBJNAzB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CBlBCazy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TjBJNAzB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CBlBCazy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EE36DA02
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725625; cv=none; b=kIGelSJ+fo5yap9LnNum6KdgyZrSXz59yTYOQcCOZGBMrQCAgBNmDPN0/zvNAnUxlRwi7TryZGTa7O4B1TtdlpGBC8eDSeQHsxwTXF0wWnBYepyG2N/bpyuq8s0VqL2gBN1jdjrJ4LvJreANLCEJeBVHQIK5Qej8tNtUXC7ykl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725625; c=relaxed/simple;
	bh=ucnG5Eh7JbD9oD0J7LKUp30lRO5P8r0nohI0ROylQ5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL+ob4E5Vf01HgHlMN/m37ipucXB9iR1I4RvZ8XYwVt+/7g5LKVQl4WFQN7qv0SQDxU2NWMFrgmrA2IcW9T2ySD6+WabLOq+wX1hG76pWAplHZpOxRQPh7EdQX1mlPHr0A3UQQ/wa/zaVpZui4oFkwoCynJrab9Pcv1zT63h6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TjBJNAzB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CBlBCazy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TjBJNAzB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CBlBCazy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65D4D67980;
	Mon, 25 May 2026 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27RqMrsc/HyYpcKKC895GgpS6rD7RsFIOjFaMcayYkU=;
	b=TjBJNAzBA+cavyzS9h4Ksm50NiBUq6prYAiJSxscFaJoQOPK+1LWzQJcVWdcQbiD6lGcln
	MED/W+RtqFyxc4AxW0iXhY65+ope8eAKQMBwkvzfow+daKjZYQM/FJiaJsDRiNyo5ncYgd
	mV6yitDH05w7rg2MJ2Lbx3mM0OhI1Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27RqMrsc/HyYpcKKC895GgpS6rD7RsFIOjFaMcayYkU=;
	b=CBlBCazybZJb5mYghpd9dcVMD47k/+oTvUbOccSM7j5/exZQpOfRJmSj9CSBVb+RrQBGlP
	DdyANGP/XVbIhMBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TjBJNAzB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CBlBCazy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27RqMrsc/HyYpcKKC895GgpS6rD7RsFIOjFaMcayYkU=;
	b=TjBJNAzBA+cavyzS9h4Ksm50NiBUq6prYAiJSxscFaJoQOPK+1LWzQJcVWdcQbiD6lGcln
	MED/W+RtqFyxc4AxW0iXhY65+ope8eAKQMBwkvzfow+daKjZYQM/FJiaJsDRiNyo5ncYgd
	mV6yitDH05w7rg2MJ2Lbx3mM0OhI1Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27RqMrsc/HyYpcKKC895GgpS6rD7RsFIOjFaMcayYkU=;
	b=CBlBCazybZJb5mYghpd9dcVMD47k/+oTvUbOccSM7j5/exZQpOfRJmSj9CSBVb+RrQBGlP
	DdyANGP/XVbIhMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52CA959D20;
	Mon, 25 May 2026 16:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W8EyFDV1FGr5GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 16:13:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5405A08D7; Mon, 25 May 2026 18:13:36 +0200 (CEST)
Date: Mon, 25 May 2026 18:13:36 +0200
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
Subject: Re: [PATCH 03/17] ocfs2/dlm: replace __get_free_page() with kmalloc()
Message-ID: <zozs55fvd3cifliymnyfo6uzakhhu4rerhiod6kpiix6hbn3an@ysj2ih7fuvqq>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-3-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-b4-fs-v1-3-275e36a83f0e@kernel.org>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21924-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 157DD5CCA7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat 23-05-26 20:54:15, Mike Rapoport (Microsoft) wrote:
> A few places in ocsfs2 allocate temporary buffers with __get_free_page() or
> get_zeroed_page().
> 
> kmalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
> 
> Replace use of __get_free_page() and get_zeroed_page() with kmalloc() and
> kzalloc() respectively.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/dlm/dlmdebug.c    | 24 +++++++++---------------
>  fs/ocfs2/dlm/dlmdomain.c   |  8 +++++---
>  fs/ocfs2/dlm/dlmmaster.c   |  5 ++---
>  fs/ocfs2/dlm/dlmrecovery.c |  4 ++--
>  4 files changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
> index fe4fdd09bae3..6ca8b3b68eef 100644
> --- a/fs/ocfs2/dlm/dlmdebug.c
> +++ b/fs/ocfs2/dlm/dlmdebug.c
> @@ -260,10 +260,10 @@ void dlm_print_one_mle(struct dlm_master_list_entry *mle)
>  {
>  	char *buf;
>  
> -	buf = (char *) get_zeroed_page(GFP_ATOMIC);
> +	buf = kzalloc(PAGE_SIZE, GFP_ATOMIC);
>  	if (buf) {
>  		dump_mle(mle, buf, PAGE_SIZE - 1);
> -		free_page((unsigned long)buf);
> +		kfree(buf);
>  	}
>  }
>  
> @@ -280,7 +280,7 @@ static struct dentry *dlm_debugfs_root;
>  /* begin - utils funcs */
>  static int debug_release(struct inode *inode, struct file *file)
>  {
> -	free_page((unsigned long)file->private_data);
> +	kfree(file->private_data);
>  	return 0;
>  }
>  
> @@ -327,17 +327,15 @@ static int debug_purgelist_open(struct inode *inode, struct file *file)
>  	struct dlm_ctxt *dlm = inode->i_private;
>  	char *buf = NULL;
>  
> -	buf = (char *) get_zeroed_page(GFP_NOFS);
> +	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!buf)
> -		goto bail;
> +		return -ENOMEM;
>  
>  	i_size_write(inode, debug_purgelist_print(dlm, buf, PAGE_SIZE - 1));
>  
>  	file->private_data = buf;
>  
>  	return 0;
> -bail:
> -	return -ENOMEM;
>  }
>  
>  static const struct file_operations debug_purgelist_fops = {
> @@ -384,17 +382,15 @@ static int debug_mle_open(struct inode *inode, struct file *file)
>  	struct dlm_ctxt *dlm = inode->i_private;
>  	char *buf = NULL;
>  
> -	buf = (char *) get_zeroed_page(GFP_NOFS);
> +	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!buf)
> -		goto bail;
> +		return -ENOMEM;
>  
>  	i_size_write(inode, debug_mle_print(dlm, buf, PAGE_SIZE - 1));
>  
>  	file->private_data = buf;
>  
>  	return 0;
> -bail:
> -	return -ENOMEM;
>  }
>  
>  static const struct file_operations debug_mle_fops = {
> @@ -775,17 +771,15 @@ static int debug_state_open(struct inode *inode, struct file *file)
>  	struct dlm_ctxt *dlm = inode->i_private;
>  	char *buf = NULL;
>  
> -	buf = (char *) get_zeroed_page(GFP_NOFS);
> +	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!buf)
> -		goto bail;
> +		return -ENOMEM;
>  
>  	i_size_write(inode, debug_state_print(dlm, buf, PAGE_SIZE - 1));
>  
>  	file->private_data = buf;
>  
>  	return 0;
> -bail:
> -	return -ENOMEM;
>  }
>  
>  static const struct file_operations debug_state_fops = {
> diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
> index dc9da9133c8e..97bb9400e24b 100644
> --- a/fs/ocfs2/dlm/dlmdomain.c
> +++ b/fs/ocfs2/dlm/dlmdomain.c
> @@ -63,7 +63,7 @@ static inline void byte_copymap(u8 dmap[], unsigned long smap[],
>  static void dlm_free_pagevec(void **vec, int pages)
>  {
>  	while (pages--)
> -		free_page((unsigned long)vec[pages]);
> +		kfree(vec[pages]);
>  	kfree(vec);
>  }
>  
> @@ -75,9 +75,11 @@ static void **dlm_alloc_pagevec(int pages)
>  	if (!vec)
>  		return NULL;
>  
> -	for (i = 0; i < pages; i++)
> -		if (!(vec[i] = (void *)__get_free_page(GFP_KERNEL)))
> +	for (i = 0; i < pages; i++) {
> +		vec[i] = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +		if (!vec[i])
>  			goto out_free;
> +	}
>  
>  	mlog(0, "Allocated DLM hash pagevec; %d pages (%lu expected), %lu buckets per page\n",
>  	     pages, (unsigned long)DLM_HASH_PAGES,
> diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
> index 93eff38fdadd..aee3b4c56dcc 100644
> --- a/fs/ocfs2/dlm/dlmmaster.c
> +++ b/fs/ocfs2/dlm/dlmmaster.c
> @@ -2548,7 +2548,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
>  
>  	/* preallocate up front. if this fails, abort */
>  	ret = -ENOMEM;
> -	mres = (struct dlm_migratable_lockres *) __get_free_page(GFP_NOFS);
> +	mres = kmalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!mres) {
>  		mlog_errno(ret);
>  		goto leave;
> @@ -2725,8 +2725,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
>  	if (wake)
>  		wake_up(&res->wq);
>  
> -	if (mres)
> -		free_page((unsigned long)mres);
> +	kfree(mres);
>  
>  	dlm_put(dlm);
>  
> diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
> index 128872bd945d..9b97bf73df22 100644
> --- a/fs/ocfs2/dlm/dlmrecovery.c
> +++ b/fs/ocfs2/dlm/dlmrecovery.c
> @@ -837,7 +837,7 @@ int dlm_request_all_locks_handler(struct o2net_msg *msg, u32 len, void *data,
>  	}
>  
>  	/* this will get freed by dlm_request_all_locks_worker */
> -	buf = (char *) __get_free_page(GFP_NOFS);
> +	buf = kmalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!buf) {
>  		kfree(item);
>  		dlm_put(dlm);
> @@ -933,7 +933,7 @@ static void dlm_request_all_locks_worker(struct dlm_work_item *item, void *data)
>  		}
>  	}
>  leave:
> -	free_page((unsigned long)data);
> +	kfree(data);
>  }
>  
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

