Return-Path: <linux-nfs+bounces-21368-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL0JFpqR92lhjAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21368-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 03 May 2026 20:19:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E664E4B6F5C
	for <lists+linux-nfs@lfdr.de>; Sun, 03 May 2026 20:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5944730238F7
	for <lists+linux-nfs@lfdr.de>; Sun,  3 May 2026 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24FA3D091A;
	Sun,  3 May 2026 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNnOtsfd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uwx1gS/O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNnOtsfd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uwx1gS/O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5C3D0938
	for <linux-nfs@vger.kernel.org>; Sun,  3 May 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777832265; cv=none; b=oHHqcyRY27haUfjNq+kfKy7AQJNXaetIW7qLsdsSJuqWlRKexg7hwooROlC9V5CVG8/Pgl81bns/woDboOftmHul4TkPsGnwC+1qReD7XIHeeWCQ3S0daf9XsCb5M6IXqanHXU2WaCjmpCQevox35g+gkmvDVIB6cpbTyNECpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777832265; c=relaxed/simple;
	bh=5TgfBJ0IxjwpjqpQOZ3WEZ0rUmg5+iXP8rXV4luShdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMulJHDAsuVNNPjm1Hq+MKq4f7s0IwRrRdAQZO1g7aBSjMi1+LJ+Io5uOBat51lNAyR2msR5HwX3oaLsHL4RYP77m/7SL5ajNwSKPs1qPregdfhrySg+rLtj/FYuhq+UwdQgBHExmH1/KO61ZVBTBc6U+rjNwcLCZpz3LLUWHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JNnOtsfd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uwx1gS/O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JNnOtsfd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uwx1gS/O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AF546AC14;
	Sun,  3 May 2026 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777832255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vejb/G9cClvZHxy5gifEMwQcvS/7NoCZj9V2DWPTf+Y=;
	b=JNnOtsfdia6KNeiWF/zx6UmGMlyd7MovighKfDpbipWcdICHWOyAWdUdIHnNg26ISosfcE
	1vhhhQx0enMHLf8gCDJ3U3A1PI1//jmY4yLWHBCi6uzrihaeCN/zDu5G6bMuodmAEBTytD
	sywVPBV32c+X721DpOigCPrJerl7mWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777832255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vejb/G9cClvZHxy5gifEMwQcvS/7NoCZj9V2DWPTf+Y=;
	b=Uwx1gS/Og/X2yT7c6rFcHwYxYjc3O5eZU/ab3xJaQ8s0HkzspghdERq4rp30NfBiSRzyTZ
	mp+GNFSRN3hluyCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JNnOtsfd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Uwx1gS/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777832255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vejb/G9cClvZHxy5gifEMwQcvS/7NoCZj9V2DWPTf+Y=;
	b=JNnOtsfdia6KNeiWF/zx6UmGMlyd7MovighKfDpbipWcdICHWOyAWdUdIHnNg26ISosfcE
	1vhhhQx0enMHLf8gCDJ3U3A1PI1//jmY4yLWHBCi6uzrihaeCN/zDu5G6bMuodmAEBTytD
	sywVPBV32c+X721DpOigCPrJerl7mWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777832255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vejb/G9cClvZHxy5gifEMwQcvS/7NoCZj9V2DWPTf+Y=;
	b=Uwx1gS/Og/X2yT7c6rFcHwYxYjc3O5eZU/ab3xJaQ8s0HkzspghdERq4rp30NfBiSRzyTZ
	mp+GNFSRN3hluyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8177E593A6;
	Sun,  3 May 2026 18:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X9weHz+R92kjFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sun, 03 May 2026 18:17:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5645A078F; Sun, 03 May 2026 16:37:03 +0200 (CEST)
Date: Sun, 3 May 2026 16:37:03 +0200
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
Subject: Re: [PATCH v4 1/4] mm: track DONTCACHE dirty pages per bdi_writeback
Message-ID: <7awcgzgxkpav4krxe4qtyfzzlhfpziw56ptfchuai5r4txz4ib@hzycmy5syvjo>
References: <20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org>
 <20260501-dontcache-v4-1-5d5e6dc71cb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-dontcache-v4-1-5d5e6dc71cb3@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: E664E4B6F5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21368-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Fri 01-05-26 10:49:35, Jeff Layton wrote:
> Add a per-wb WB_DONTCACHE_DIRTY counter that tracks the number of dirty
> pages with the dropbehind flag set (i.e., pages dirtied via RWF_DONTCACHE
> writes).
> 
> Increment the counter alongside WB_RECLAIMABLE in folio_account_dirtied()
> when the folio has the dropbehind flag set, and decrement it in
> folio_clear_dirty_for_io() and folio_account_cleaned(). Also decrement it
> when a non-DONTCACHE lookup clears the dropbehind flag on a dirty folio in
> __filemap_get_folio_mpol(), using proper writeback domain locking.
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
>  include/linux/backing-dev-defs.h |  1 +
>  mm/filemap.c                     | 13 ++++++++++++-
>  mm/page-writeback.c              |  6 ++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
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
> index 4e636647100c..1c9c0d5f495f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2052,8 +2052,19 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
>  	if (!folio)
>  		return ERR_PTR(-ENOENT);
>  	/* not an uncached lookup, clear uncached if set */
> -	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
> +	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE)) {
> +		if (folio_test_dirty(folio)) {
> +			struct inode *inode = mapping->host;
> +			struct bdi_writeback *wb;
> +			struct wb_lock_cookie cookie = {};
> +
> +			wb = unlocked_inode_to_wb_begin(inode, &cookie);
> +			wb_stat_mod(wb, WB_DONTCACHE_DIRTY,
> +				    -folio_nr_pages(folio));
> +			unlocked_inode_to_wb_end(inode, &cookie);
> +		}
>  		folio_clear_dropbehind(folio);
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

