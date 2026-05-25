Return-Path: <linux-nfs+bounces-21925-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE2BFwt2FGokNgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21925-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:17:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9F5CCAE3
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5486B300899B
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605E3F410B;
	Mon, 25 May 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Hfg4OMV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TA5BDXsx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KZmdsyIb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gLGhTS17"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB673ECBFE
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725829; cv=none; b=ECKeJx73m1Z13Tsip3vsrRjXb+iCO2u1xoPBGTgsum1jQbXGE8k6HqBrqof7YMGI1k5plSHro1K0bZGnPZM4Vdb8zYcUXzTnLoPBnNf/MlnMkMZfdQK4kWl+vaKMdtQ/Nqtdf4IkaHyfW97lhBx+8PKQp3YVbTMHQvG0l/mxyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725829; c=relaxed/simple;
	bh=uuQtE1UNvuOk6XjdcxlL9xkRLqBbZIfBFgmyTHnmAgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3lT/EEbo30A9AZ2oE/j+Ssnezbb9IC5HYARETIoyl4V53yg+N5WhjCCx6Z7p5umbU/li8PMRzFRsIgEt84kQRQ0I142iyWcbfdcYOTJW9+TIh1mbIOqHJlLsnDksSeqy4yTUyU8qJzD67priCw8jj4fOBlzU+oWh9ClOvGJ/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Hfg4OMV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TA5BDXsx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KZmdsyIb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gLGhTS17; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E60E67348;
	Mon, 25 May 2026 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOqps2oswWC8BW2SBX1fhbQKL5egyliEPxPGdscg6ck=;
	b=0Hfg4OMVKiSiBQRJ0uXGtZ8Y2OWRXaeQiytwwLq/6j+xg3BIXhWCytD16vaK/ReUZN/NPL
	wTnrzYeH1IzgsLoBVI9X1BWRsL/wSZ1JqDbuMcaYTzAvC2hPneYfUoMZhYoWC16zjNTEwt
	xc2g2M2ArcMfdxzR1sP9fIsQFcoLI7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOqps2oswWC8BW2SBX1fhbQKL5egyliEPxPGdscg6ck=;
	b=TA5BDXsxnNOSpg7RYa0vh6dt4KKlarsqZlQ0apRfPWvWV3o6Ue9PynGK1BkRq5WOQXx4Xo
	pSUPkHkhVCFmbCCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779725825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOqps2oswWC8BW2SBX1fhbQKL5egyliEPxPGdscg6ck=;
	b=KZmdsyIbb7noi77UxqpJdYPIHUjs7CUvNMlTRqKv115xDDibEonWbBVtvQVV4YkJtvFrC4
	z7Lz26jmfDAdCWhRJwJ1k8Ri0rR84dk1fSkgSO7kvN0NeADynsPDw7dh649BfG8yV0PPaH
	lCnBK5xO9SgvpQR/Oy4GYVRCiDhLMhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779725825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOqps2oswWC8BW2SBX1fhbQKL5egyliEPxPGdscg6ck=;
	b=gLGhTS17boEqI8NdUfnjerwDCcLadne4B0nRBdAScThhuAk/POWYmSCZfGFAYNcsmqOPYv
	GicgUS4PiC6xT2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F37959D24;
	Mon, 25 May 2026 16:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0A1tDwF2FGqxHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 16:17:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5E1FA08D7; Mon, 25 May 2026 18:17:04 +0200 (CEST)
Date: Mon, 25 May 2026 18:17:04 +0200
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
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <2omm5gmnv2khshoxkrag5rusd3qzrsqyjgsef2syxgryrtg6vq@ao7oabqwebgo>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21925-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
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
X-Rspamd-Queue-Id: F1E9F5CCAE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat 23-05-26 20:54:22, Mike Rapoport (Microsoft) wrote:
> jbd2_alloc() falls back from kmem_cache_alloc() to __get_free_pages() for
> allocations larger than PAGE_SIZE.
> But kmalloc() can handle such cases with essentially the same fallback.
> 
> Replace use of __get_free_pages() with kmalloc() and simplify
> jbd2_free() as both kmem_cache_alloc() and kmalloc() allocations can be
> freed with kfree().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'll just note that we allocate here fs block size large buffer so the same
kind of allocator as we use for folios would be even better. But that's a
different cleanup I guess.

								Honza

> ---
>  fs/jbd2/journal.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 4f397fcdb13c..1137b471e490 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2784,7 +2784,7 @@ void *jbd2_alloc(size_t size, gfp_t flags)
>  	if (size < PAGE_SIZE)
>  		ptr = kmem_cache_alloc(get_slab(size), flags);
>  	else
> -		ptr = (void *)__get_free_pages(flags, get_order(size));
> +		ptr = kmalloc(size, flags);
>  
>  	/* Check alignment; SLUB has gotten this wrong in the past,
>  	 * and this can lead to user data corruption! */
> @@ -2795,10 +2795,7 @@ void *jbd2_alloc(size_t size, gfp_t flags)
>  
>  void jbd2_free(void *ptr, size_t size)
>  {
> -	if (size < PAGE_SIZE)
> -		kmem_cache_free(get_slab(size), ptr);
> -	else
> -		free_pages((unsigned long)ptr, get_order(size));
> +	kfree(ptr);
>  };
>  
>  /*
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

