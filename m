Return-Path: <linux-nfs+bounces-21517-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCMEDbE8A2oq2AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21517-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:44:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F5522CE5
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E87C305B875
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815B3A71BE;
	Tue, 12 May 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KtSb694V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="07i9D6CY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xtmy561O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PpfP8HUb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8E3A83AA
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594874; cv=none; b=hWm3VJ7UQNOJ7lppjk2gf57aNTiWOWYAm9DI9pm25cjq+sCoduCfuG16Xmwy19RAgc8OsEi/Mmos1SMmu3BS1y/Wl/k/OM28JP0amAHJSPZ4+qHsdVNGCDgRhcg6UKsvqVbfL5dJJwhKrYeWf6kcR5vOZxXeZjdBaIjKWDk2ZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594874; c=relaxed/simple;
	bh=RdByDkxXEyFzWFb0Es4rGvJhYgXZVFWA94It6nQHXBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9HhZ1rFjqBK+QWcBESGFXMVNOJ2tS52jYQGtWgtTCm7CU3pKyKVduiQORy8C30k+hCE1rQGE1DdWcIRxKgidNVvkPqoEIlzmaxXeVh6Qyih1FiBzc8ZuTqpMaxdMF/pXg1/opskAd0/D5mOCWm20iv3n62GPtgreqZHCxMzk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KtSb694V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=07i9D6CY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xtmy561O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PpfP8HUb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0401F6AA91;
	Tue, 12 May 2026 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778594868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myGkdDpGAqSiI3QSlhAm4i2daq28KmwVMURWssNipPI=;
	b=KtSb694VmCELXmqgZnPEngDMakMrNBERjnMeDodHXAGcR1VX270vKnWiShrPFfQN1o2txZ
	whmdsE147Tk0/6LqrWJFwEitO+pYJ6utGWhXfh9veEmD8OpICdKQTNJjT5hF1fmtTKPDwy
	4bT33pRnOXdwYf9LbvwQ7fBrxAcynqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778594868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myGkdDpGAqSiI3QSlhAm4i2daq28KmwVMURWssNipPI=;
	b=07i9D6CYmzIzsiMbTH5lPWkp/Giu/rOle1pHFnATcajbEchkGrLj9gR9taGZyoFk8qg6BH
	AA+7m7MnYhjKg9Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Xtmy561O;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PpfP8HUb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778594864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myGkdDpGAqSiI3QSlhAm4i2daq28KmwVMURWssNipPI=;
	b=Xtmy561OWIEx/0hUNMgGEB5yCeyA6eo7nwzyDR8Y6B6zw3EIWDohibr9IndC9YFAb0/p1O
	d2dFILmeQiD7g/u7WVcggmmMhgJEEYiN5iJjG5j1O41w/H7EGtwLAODky1phZIOz19pKzK
	Xed/0jhml+oU5s2CYopsOFhUUW7ueSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778594864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myGkdDpGAqSiI3QSlhAm4i2daq28KmwVMURWssNipPI=;
	b=PpfP8HUbJnFTzcmVurynbgcHfOnITcrYBRWcJZcHTZTMv2/HUe0aiAt2D2lXGDKbIWwDVZ
	oiGltw4Lpnp3ctDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D93FE593A9;
	Tue, 12 May 2026 14:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IMMCNS80A2oGfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 May 2026 14:07:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 83CD8A07B5; Tue, 12 May 2026 16:07:39 +0200 (CEST)
Date: Tue, 12 May 2026 16:07:39 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v7 2/3] mm: track DONTCACHE dirty pages per bdi_writeback
Message-ID: <6hh3mzfix2bpddij7zrhm7n3wcwt56vmuystjw4r7zfzj4ut4b@hsxatltdleka>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
 <20260511-dontcache-v7-2-2848ddce8090@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-dontcache-v7-2-2848ddce8090@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 2D5F5522CE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21517-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,vger.kernel.org,kvack.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 11-05-26 07:58:28, Jeff Layton wrote:
> Add a per-wb WB_DONTCACHE_DIRTY counter that tracks the number of dirty
> pages with the dropbehind flag set (i.e., pages dirtied via RWF_DONTCACHE
> writes).
> 
> Increment the counter alongside WB_RECLAIMABLE in folio_account_dirtied()
> when the folio has the dropbehind flag set, and decrement it in
> folio_clear_dirty_for_io() and folio_account_cleaned(). Also decrement it
> when a non-DONTCACHE lookup atomically clears the dropbehind flag on a
> dirty folio in __filemap_get_folio_mpol(), using folio_test_clear_dropbehind()
> to prevent concurrent lookups from double-decrementing the counter, and
> guarding the decrement with mapping_can_writeback() to match the increment
> path.
> 
> Transfer the counter alongside WB_RECLAIMABLE in inode_do_switch_wbs() so
> that the stat is properly migrated when an inode switches cgroup writeback
> domains.
> 
> The counter will be used by the writeback flusher to determine how many
> pages to write back when expediting writeback for IOCB_DONTCACHE writes,
> without flushing the entire BDI's dirty pages.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c                |  4 ++++
>  include/linux/backing-dev-defs.h |  1 +
>  mm/filemap.c                     | 15 +++++++++++++--
>  mm/page-writeback.c              |  6 ++++++
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a65694cbfe68..32ecc745f5f7 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -432,6 +432,10 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  			long nr = folio_nr_pages(folio);
>  			wb_stat_mod(old_wb, WB_RECLAIMABLE, -nr);
>  			wb_stat_mod(new_wb, WB_RECLAIMABLE, nr);
> +			if (folio_test_dropbehind(folio)) {
> +				wb_stat_mod(old_wb, WB_DONTCACHE_DIRTY, -nr);
> +				wb_stat_mod(new_wb, WB_DONTCACHE_DIRTY, nr);
> +			}
>  		}
>  	}
>  
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index a06b93446d10..cb660dd37286 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -33,6 +33,7 @@ enum wb_stat_item {
>  	WB_WRITEBACK,
>  	WB_DIRTIED,
>  	WB_WRITTEN,
> +	WB_DONTCACHE_DIRTY,
>  	NR_WB_STAT_ITEMS
>  };
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e636647100c..179f2886f8c0 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2052,8 +2052,19 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
>  	if (!folio)
>  		return ERR_PTR(-ENOENT);
>  	/* not an uncached lookup, clear uncached if set */
> -	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
> -		folio_clear_dropbehind(folio);
> +	if (!(fgp_flags & FGP_DONTCACHE) && folio_test_clear_dropbehind(folio)) {
> +		if (folio_test_dirty(folio) &&
> +		    mapping_can_writeback(mapping)) {
> +			struct inode *inode = mapping->host;
> +			struct bdi_writeback *wb;
> +			struct wb_lock_cookie cookie = {};
> +			long nr = folio_nr_pages(folio);
> +
> +			wb = unlocked_inode_to_wb_begin(inode, &cookie);
> +			wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -nr);
> +			unlocked_inode_to_wb_end(inode, &cookie);
> +		}
> +	}
>  	return folio;
>  }
>  EXPORT_SYMBOL(__filemap_get_folio_mpol);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 88cd53d4ba09..8e520717d1f6 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2630,6 +2630,8 @@ static void folio_account_dirtied(struct folio *folio,
>  		wb = inode_to_wb(inode);
>  
>  		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
> +		if (folio_test_dropbehind(folio))
> +			wb_stat_mod(wb, WB_DONTCACHE_DIRTY, nr);
>  		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
>  		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
>  		wb_stat_mod(wb, WB_RECLAIMABLE, nr);
> @@ -2651,6 +2653,8 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
>  	long nr = folio_nr_pages(folio);
>  
>  	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
> +	if (folio_test_dropbehind(folio))
> +		wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -nr);
>  	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
>  	wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
>  	task_io_account_cancelled_write(nr * PAGE_SIZE);
> @@ -2920,6 +2924,8 @@ bool folio_clear_dirty_for_io(struct folio *folio)
>  		if (folio_test_clear_dirty(folio)) {
>  			long nr = folio_nr_pages(folio);
>  			lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
> +			if (folio_test_dropbehind(folio))
> +				wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -nr);
>  			zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
>  			wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
>  			ret = true;
> 
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

