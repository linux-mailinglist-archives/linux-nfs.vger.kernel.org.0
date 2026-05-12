Return-Path: <linux-nfs+bounces-21516-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNw5Dug+A2qr2AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21516-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:53:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBB52301C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5578D314B5CF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF293A05FB;
	Tue, 12 May 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iU40lfBc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="59RRpz5u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iU40lfBc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="59RRpz5u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39783A2E33
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594313; cv=none; b=fVDRuy1o50bEiW4hcC19F/8KayqsgIR+I6A36QduP4xQVFBgKeRX4qj03psfO18TNX0jePPwPLeo4PZiSmE0lXD0+zFF1R2rHFaFg9ka7JQp4KgNaJMr4C/n0eT932QOVGNB3yG1OENeJ1NOt5zlifHPdyp9BxmHBYoRJ1IT0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594313; c=relaxed/simple;
	bh=fsnFS0ikE1KqojIl3XqYuHy4MH9fhox5imP2tGFFrlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=now5NhW7fqStwoadw+rLnyUGNBS+omPfAoZrJv2KPZVnpG+FSI2fkCW+5cQVR7rxCjyUkBHjFskFXTQnUJNgXDO1zB/Cje2k9p13N1ImHkv1DuAtVcQQFr5COT5CVKylShqnnaIGwV1XEPih6C/a5v8agmZ5R725C40fF8WOD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iU40lfBc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=59RRpz5u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iU40lfBc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=59RRpz5u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 306EF6A92B;
	Tue, 12 May 2026 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778594310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/WMKLvXTakOwtcQCPmwP1f7LuJLeIEf0/ngyLHcaDo=;
	b=iU40lfBcKYFLIF2OHmGSUAfvpl4nfAgf194chhYws9yDEb3DxOnb3xiRlbS7bQTusUdU2E
	ni01ZeqaJ+Y9zyZTRYP9ARLN+TshLHI2Jdx9WCJNsMCuxCion8XMzzt/YlNDCH9rRP3ySj
	xCzWegLpvRqZVVhL4JmfQelsXqMl4po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778594310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/WMKLvXTakOwtcQCPmwP1f7LuJLeIEf0/ngyLHcaDo=;
	b=59RRpz5uKRSwZuk3tmE0LVQS/rHnOlt1W7AHo63MzMrHcNg2Q+5Nbb5dRzHoGbOS/RA6d5
	XpjQh9LYr1JSaJBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778594310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/WMKLvXTakOwtcQCPmwP1f7LuJLeIEf0/ngyLHcaDo=;
	b=iU40lfBcKYFLIF2OHmGSUAfvpl4nfAgf194chhYws9yDEb3DxOnb3xiRlbS7bQTusUdU2E
	ni01ZeqaJ+Y9zyZTRYP9ARLN+TshLHI2Jdx9WCJNsMCuxCion8XMzzt/YlNDCH9rRP3ySj
	xCzWegLpvRqZVVhL4JmfQelsXqMl4po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778594310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/WMKLvXTakOwtcQCPmwP1f7LuJLeIEf0/ngyLHcaDo=;
	b=59RRpz5uKRSwZuk3tmE0LVQS/rHnOlt1W7AHo63MzMrHcNg2Q+5Nbb5dRzHoGbOS/RA6d5
	XpjQh9LYr1JSaJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23D7E593A9;
	Tue, 12 May 2026 13:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGAKCAYyA2q7cgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 May 2026 13:58:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B3EACA07B5; Tue, 12 May 2026 15:58:21 +0200 (CEST)
Date: Tue, 12 May 2026 15:58:21 +0200
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
Subject: Re: [PATCH v7 1/3] mm: preserve PG_dropbehind flag during folio split
Message-ID: <2lqxu3m6ueiiaqykqwgujxzddq7blcn2zmtntv742mvae3wqtd@ntr4mnzm6vic>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
 <20260511-dontcache-v7-1-2848ddce8090@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-dontcache-v7-1-2848ddce8090@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 97EBB52301C
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
	TAGGED_FROM(0.00)[bounces-21516-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Action: no action

On Mon 11-05-26 07:58:27, Jeff Layton wrote:
> __split_folio_to_order() copies page flags from the original folio to
> newly created sub-folios using an explicit allowlist, but PG_dropbehind
> is not included. When a large folio with PG_dropbehind set is split,
> only the head sub-folio retains the flag; all tail sub-folios silently
> lose it and will not be reclaimed eagerly after writeback completes.
> 
> Add PG_dropbehind to the flag copy mask so that the drop-behind hint
> is preserved across folio splits.
> 
> Fixes: a323281cdfec ("mm: add PG_dropbehind folio flag")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I'm not really very knowledgeable in this code but the change looks good to
me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/huge_memory.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 970e077019b7..e01917b14d1a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3642,6 +3642,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  				 (1L << PG_arch_3) |
>  #endif
>  				 (1L << PG_dirty) |
> +				 (1L << PG_dropbehind) |
>  				 LRU_GEN_MASK | LRU_REFS_MASK));
>  
>  		if (handle_hwpoison &&
> 
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

