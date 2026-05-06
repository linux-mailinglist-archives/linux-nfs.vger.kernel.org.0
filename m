Return-Path: <linux-nfs+bounces-21407-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHTMKdcY+2mYWgMAu9opvQ
	(envelope-from <linux-nfs+bounces-21407-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 12:32:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 063614D954C
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 12:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 805D830125CB
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9D3F7AB2;
	Wed,  6 May 2026 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="klKNtHvk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1BhRSrv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="klKNtHvk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1BhRSrv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487973E8C72
	for <linux-nfs@vger.kernel.org>; Wed,  6 May 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063572; cv=none; b=aMHFZ28E1BlKbRAhIkKSxCIuIy9J6Zt7Qe8c5mDNEhSFDhMyBZHsF14rOMvX4c6spIA+Ie0U7iWhhlA/NbB/0gTzIcB209V5fSfhFsTaWQsK93Ek+KrLQ0iivqrQwIkNj1ovJQ7Ygn+J2fUi7IpK7XVVYMW/FMzrISpoSYh14v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063572; c=relaxed/simple;
	bh=obh9Fj5EmKroULAVu+Ct4dZOtarpHasNHQopM5IjWZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox0WOfJ5610iKpnNQpRdMdXzpnwzxE5btHXRYeklYbmUb3N/HfG/nzUeNp/t7S5Qz/6ytwOQL0rWI7cdZUFzaVzQr0QYc5bIbcKf8CiNs7NIPzBmDu0yi0pv4mwtILkYLF0A/hz3r546qOE+nIAyGzP+pPn/rZB6xJpJ3sg9uMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=klKNtHvk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1BhRSrv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=klKNtHvk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1BhRSrv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F6696B76A;
	Wed,  6 May 2026 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778063569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw3eLXGex+5o8NBWnWLhM6PbgiAEuMnx+2DUwT80UP4=;
	b=klKNtHvkoQwllFeb4OyEMdzQYB4K2bviAb0peUy0IQf5hlTahBTVrZvPt9qeXGA9r3Dwvp
	59CzZRFJOnB8+MdAEfbMLOMys/euI3+hWsZtmHHAduv9EpAmzAX2LKIqUs3qVllD0d9ZHb
	LcV0V/6kdVbzGb7bLP32YHjtSL0pbvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778063569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw3eLXGex+5o8NBWnWLhM6PbgiAEuMnx+2DUwT80UP4=;
	b=U1BhRSrvq252+rK80ZxleqvaebLnAA240N9G9oGajsc3OVrohCkoGHQ5rnHkK8STne9J2Y
	0iysZxfwH5VMsQBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778063569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw3eLXGex+5o8NBWnWLhM6PbgiAEuMnx+2DUwT80UP4=;
	b=klKNtHvkoQwllFeb4OyEMdzQYB4K2bviAb0peUy0IQf5hlTahBTVrZvPt9qeXGA9r3Dwvp
	59CzZRFJOnB8+MdAEfbMLOMys/euI3+hWsZtmHHAduv9EpAmzAX2LKIqUs3qVllD0d9ZHb
	LcV0V/6kdVbzGb7bLP32YHjtSL0pbvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778063569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw3eLXGex+5o8NBWnWLhM6PbgiAEuMnx+2DUwT80UP4=;
	b=U1BhRSrvq252+rK80ZxleqvaebLnAA240N9G9oGajsc3OVrohCkoGHQ5rnHkK8STne9J2Y
	0iysZxfwH5VMsQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39104593A3;
	Wed,  6 May 2026 10:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rqHrDdEY+2m6PQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 May 2026 10:32:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A23CA0790; Wed, 06 May 2026 12:32:48 +0200 (CEST)
Date: Wed, 6 May 2026 12:32:48 +0200
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
Subject: Re: [PATCH v6 1/2] mm: track DONTCACHE dirty pages per bdi_writeback
Message-ID: <zj7w24dm7qk64sp37ai7jvt54vyfftzmbvxwladwkoqhggi3d7@ivb4gkk5t6rj>
References: <20260505-dontcache-v6-0-66463805dd6a@kernel.org>
 <20260505-dontcache-v6-1-66463805dd6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-dontcache-v6-1-66463805dd6a@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 063614D954C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-21407-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim,suse.cz:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Tue 05-05-26 20:59:48, Jeff Layton wrote:
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
> The counter will be used by the writeback flusher to determine how many
> pages to write back when expediting writeback for IOCB_DONTCACHE writes,
> without flushing the entire BDI's dirty pages.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Yeah, good catch with the folio_test_clear_dropbehind(). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev-defs.h |  1 +
>  mm/filemap.c                     | 15 +++++++++++++--
>  mm/page-writeback.c              |  6 ++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
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
> index 4e636647100c..e706f5c4ece4 100644
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
> +
> +			wb = unlocked_inode_to_wb_begin(inode, &cookie);
> +			wb_stat_mod(wb, WB_DONTCACHE_DIRTY,
> +				    -folio_nr_pages(folio));
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

