Return-Path: <linux-nfs+bounces-21923-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NP5ObV0FGokNgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21923-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:11:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BDD5CCA19
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 127A13012278
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6425A37FF5F;
	Mon, 25 May 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ayzj3SuW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybhCdnVg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ayzj3SuW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybhCdnVg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A9371068
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725486; cv=none; b=pJn2ExU8C02o9eQ0q4lv6XNk3levClfBm10asnzuiqQ0cGJmnupFYoUghQpI57tHhJFYHQiHJTZfiW5BPD9jgyC+LMhB34mzLWEcYoKcd0DRih2dLO+iXCbEWaXUxiuO4V4OkWXF5yYoyeXQlx6qp6ld2B59bt+kRfdIHn9U9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725486; c=relaxed/simple;
	bh=3n29PJnXUJH9DBDNCKapRnTciaAccljRJ74En3pXtNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4IQ9sBsveWGX/EnSfYrXOaC/ZgECKpGsX4TQ4kl8oLlvvUZUxrwpY1maaLI0kkQtloEm+Z0aI3nhE3yHh9vMPmM5lxxH2XoINt/PcZx9XumzSvnTM9zhfJMXVhu7vTeetZr0dPitfKIYGDUjjmBfb5mpN4k8dAzqoV0ztlLo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ayzj3SuW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybhCdnVg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ayzj3SuW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybhCdnVg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2E946ACCF;
	Mon, 25 May 2026 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xgxRxiNUE5HU3devEoTx0VBvfHiB2nKkiOSuA+w4as=;
	b=ayzj3SuW52JzShVb2ROdtIG77ZdXnfvhnX42TgopSeq4xMSLtbN4yUekMMiGqi881CZWbi
	q2eiQevwCSeUVdySddJX2OScFR20uy/5Lhyq9DcFbOTFad0TgFrPrtVvNBEHAHWxFqqX9t
	YOwKp6KauNDumYmtzlQLt9RGLmS5t8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xgxRxiNUE5HU3devEoTx0VBvfHiB2nKkiOSuA+w4as=;
	b=ybhCdnVgVvfZWZ9Oo/GQyCY3fcO2TqFHEA4ZwghQ+1OSufjLnFSQo+nI8a9cfUeFPKeCWK
	LTm7dS5TDFNRFfAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ayzj3SuW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ybhCdnVg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xgxRxiNUE5HU3devEoTx0VBvfHiB2nKkiOSuA+w4as=;
	b=ayzj3SuW52JzShVb2ROdtIG77ZdXnfvhnX42TgopSeq4xMSLtbN4yUekMMiGqi881CZWbi
	q2eiQevwCSeUVdySddJX2OScFR20uy/5Lhyq9DcFbOTFad0TgFrPrtVvNBEHAHWxFqqX9t
	YOwKp6KauNDumYmtzlQLt9RGLmS5t8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xgxRxiNUE5HU3devEoTx0VBvfHiB2nKkiOSuA+w4as=;
	b=ybhCdnVgVvfZWZ9Oo/GQyCY3fcO2TqFHEA4ZwghQ+1OSufjLnFSQo+nI8a9cfUeFPKeCWK
	LTm7dS5TDFNRFfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8BAC59D1E;
	Mon, 25 May 2026 16:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id taj1MKp0FGrJGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 16:11:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB747A08D7; Mon, 25 May 2026 18:11:21 +0200 (CEST)
Date: Mon, 25 May 2026 18:11:21 +0200
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
Subject: Re: [PATCH 02/17] proc: replace __get_free_page() with kmalloc()
Message-ID: <hf7onlvom5jb4pmec2mlsjm4snzt34ghakzks44e2nixeg2d43@whbf3sswolhm>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-2-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-b4-fs-v1-2-275e36a83f0e@kernel.org>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
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
	TAGGED_FROM(0.00)[bounces-21923-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 38BDD5CCA19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat 23-05-26 20:54:14, Mike Rapoport (Microsoft) wrote:
> A few functions in fs/proc/base.c use __get_free_page() to allocate a
> temporary buffer.
> 
> kmalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
> 
> Replace use of __get_free_page() with kmalloc().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/base.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d9acfa89c894..e129dc509b79 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -261,7 +261,7 @@ static ssize_t get_mm_proctitle(struct mm_struct *mm, char __user *buf,
>  	if (pos >= PAGE_SIZE)
>  		return 0;
>  
> -	page = (char *)__get_free_page(GFP_KERNEL);
> +	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!page)
>  		return -ENOMEM;
>  
> @@ -284,7 +284,7 @@ static ssize_t get_mm_proctitle(struct mm_struct *mm, char __user *buf,
>  			ret = len;
>  		}
>  	}
> -	free_page((unsigned long)page);
> +	kfree(page);
>  	return ret;
>  }
>  
> @@ -347,7 +347,7 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  	if (count > arg_end - pos)
>  		count = arg_end - pos;
>  
> -	page = (char *)__get_free_page(GFP_KERNEL);
> +	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!page)
>  		return -ENOMEM;
>  
> @@ -371,7 +371,7 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  		count -= got;
>  	}
>  
> -	free_page((unsigned long)page);
> +	kfree(page);
>  	return len;
>  }
>  
> @@ -908,7 +908,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
>  	if (!mm)
>  		return 0;
>  
> -	page = (char *)__get_free_page(GFP_KERNEL);
> +	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!page)
>  		return -ENOMEM;
>  
> @@ -949,7 +949,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
>  
>  	mmput(mm);
>  free:
> -	free_page((unsigned long) page);
> +	kfree(page);
>  	return copied;
>  }
>  
> @@ -1016,7 +1016,7 @@ static ssize_t environ_read(struct file *file, char __user *buf,
>  	if (!mm || !mm->env_end)
>  		return 0;
>  
> -	page = (char *)__get_free_page(GFP_KERNEL);
> +	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!page)
>  		return -ENOMEM;
>  
> @@ -1062,7 +1062,7 @@ static ssize_t environ_read(struct file *file, char __user *buf,
>  	mmput(mm);
>  
>  free:
> -	free_page((unsigned long) page);
> +	kfree(page);
>  	return ret;
>  }
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

