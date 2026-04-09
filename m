Return-Path: <linux-nfs+bounces-20786-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MfnM08+12mbLwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20786-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 07:51:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D783C6606
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 07:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C3583008D16
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219552EFDA6;
	Thu,  9 Apr 2026 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2jwv1M/T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DAA28640C;
	Thu,  9 Apr 2026 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775713866; cv=none; b=ZlfBt1yWylCRi9iHTw3zKn+jptaNkVlk2aRYAd4kr/ttzOizlm6SkDVwRdUWq9tMFbOa5DbvFaTZMyJbuWpUD5X0OXh2vCe5bQEx121rDD7RSEMCzAUp6d1BBFgB9yncZVrZtVMHKzWzg1O8SrRqK1PMtrgfP8sb3D0Q2hQNEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775713866; c=relaxed/simple;
	bh=B0pZF0M+Na0FsE5cmKSvTL5sl17QlJMKu5wgbAmElV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdjeVpH/3zjGJfB8xgGBerXvFHAnNmSBlLMru/RNhgjdi1AUIoH31yESgP7POPu36gthG0IfJxyZfZJXoDpnhvPv8EJGb7d6NIoh6PBhpDthy33vtgbRRQlcj2qv+Ai6LMCS/QDUT66euhmRBfnV44KpPvwNYivou3PRaQMqncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2jwv1M/T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SevTQiMUPxnzE7hB73BHC4x9bLPrhVzNNZ0TFANaSpM=; b=2jwv1M/TAmBmK5jU+sXOIOzevv
	5FsTHueWHde19wdB+LAf827ZaszQ0qO37U/NRQfwdy85NEJ9Sr68n7oGkdBAPLx6+OT9Azk9xzGAF
	PwGijCAQkymLFrwlWLQvwM+FvmlKmLnmOVXxNUF8PIg3mWAC0QitPNrHF3KJgmZAQTpvk+2KW/xSQ
	dfhW3OvCiJkfQYD0mddjkrEqm2Mt4iTaX7ZYAhdlugkPQL8UcOcYKGUZhLuvC/oKl1tHnW1mNNCnz
	sByYSlLk3+l7d01wRvp85DK6stgHw4yH8zvNB6/LqYU8osGmsVHTK4C/SJFxGc23xN/pB7evMA02t
	QIF0eABg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAiI7-00000009jXc-2g7T;
	Thu, 09 Apr 2026 05:50:59 +0000
Date: Wed, 8 Apr 2026 22:50:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: kick writeback flusher instead of inline
 flush for IOCB_DONTCACHE
Message-ID: <adc-Q1iDWHD5yxHH@infradead.org>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
 <20260408-dontcache-v2-1-948dec1e756b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-dontcache-v2-1-948dec1e756b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20786-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9D783C6606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:25:21AM -0400, Jeff Layton wrote:
> Replace the inline filemap_flush_range() call with a
> wakeup_flusher_threads_bdi() call that kicks the BDI's flusher thread
> to drain dirty pages in the background.  This moves writeback
> submission completely off the writer's hot path.  The flusher thread
> handles writeback asynchronously, naturally coalescing and rate-limiting
> I/O without any explicit skip-if-busy or dirty pressure checks.


Having numbers showing the benefit here would be very useful.

> +/**
> + * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
> + * @mapping:	address_space that was just written to
> + *
> + * Wake the BDI flusher thread to start writeback of dirty pages in the
> + * background.
> + */
> +void filemap_dontcache_kick_writeback(struct address_space *mapping)
> +{
> +	wakeup_flusher_threads_bdi(inode_to_bdi(mapping->host),
> +				   WB_REASON_DONTCACHE);
> +}

wakeup_flusher_threads_bdi ends up calling wb_start_writeback eventually,
which sets WB_start_all, pushes the reason to start_all_reason and then
does the actual wakeup.

The flusher thread then through wb_check_start_all does a WB_SYNC_NONE
writeback based on get_nr_dirty_pages.  Which seems wrong - we don't
want to do a huge writeback evertime the some DONTCACHE write finished.

So I think you'll want a new WB_start_dontcache bit, a new
get_nr_dontcache_pages() helper on a new node counter, etc.


> +EXPORT_SYMBOL(filemap_dontcache_kick_writeback);

EXPORT_SYMBOL_GPL, please.



