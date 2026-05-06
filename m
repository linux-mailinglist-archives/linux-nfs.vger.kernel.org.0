Return-Path: <linux-nfs+bounces-21408-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HDdKGQb+2mtWgMAu9opvQ
	(envelope-from <linux-nfs+bounces-21408-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 12:43:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3AF4D96F6
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 12:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 193BD300A134
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74211242D72;
	Wed,  6 May 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uUno8sSZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I/nJMp1g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uUno8sSZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I/nJMp1g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CC3F23AD
	for <linux-nfs@vger.kernel.org>; Wed,  6 May 2026 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064226; cv=none; b=MctwtsQD4IOkFhQ5fJ5n8ftLGBvbEiaxXNfi0HXcb42Zz1WSA2DHJYEp/sEM9cwqD7IIdPPufdG5KVouERXoMInGh821bJTym93dL/RTP7pF7LzD8c8Fe+hpXqygaMGM5/WfI/WrL1VZqEAUWj721MmSMncEt7o+wPqMx8RJKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064226; c=relaxed/simple;
	bh=x79tElgG/HQY8d0sEhjwdDb1d4y/GUIKL1wHtqruqq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnyJngek5exdbXbawBLpTyDhAilOZThvmllrSKmId520OfebKFW4m/rm0bUsTuD/YkY1WM3a6f4Cfo2ZWDZ4hQgiWiJ/SesvdR3pZmIpNCCEpKoqrZ751p9jrWZVEb25mJt4i95+MP7UJRwLM6Mbn1ZbAX8tT6+Ph765irEPImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uUno8sSZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I/nJMp1g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uUno8sSZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I/nJMp1g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 915256BC44;
	Wed,  6 May 2026 10:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778064222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKJJpKo4selPgwo4u799sd/7fHc43w/Qqia5bTZ5JMs=;
	b=uUno8sSZwIpQbbKuT+Tn7b/O5N5bNyYny+2bMvjIX6zVv/42mcjR2UYMIGvd3SO/eaFE1H
	WWXI7+vBtlqejaCFS8ps8lC90puyicZ2Zs8X5jrwIy25FeGV02rqxd8ywtnNZ0uaLE1zDM
	Q1lVLz4etWtyXWcF8Qxy5ov+4V7iyQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778064222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKJJpKo4selPgwo4u799sd/7fHc43w/Qqia5bTZ5JMs=;
	b=I/nJMp1g4XU8KNu25pVJlQSo2ySwu5a9X+yT6JssYpfQlbpODY8P3DdLglkXEAwAyfI97T
	V3YUrDF3rSFSQNBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778064222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKJJpKo4selPgwo4u799sd/7fHc43w/Qqia5bTZ5JMs=;
	b=uUno8sSZwIpQbbKuT+Tn7b/O5N5bNyYny+2bMvjIX6zVv/42mcjR2UYMIGvd3SO/eaFE1H
	WWXI7+vBtlqejaCFS8ps8lC90puyicZ2Zs8X5jrwIy25FeGV02rqxd8ywtnNZ0uaLE1zDM
	Q1lVLz4etWtyXWcF8Qxy5ov+4V7iyQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778064222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKJJpKo4selPgwo4u799sd/7fHc43w/Qqia5bTZ5JMs=;
	b=I/nJMp1g4XU8KNu25pVJlQSo2ySwu5a9X+yT6JssYpfQlbpODY8P3DdLglkXEAwAyfI97T
	V3YUrDF3rSFSQNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73C28593A3;
	Wed,  6 May 2026 10:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iL/GG14b+2kQSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 May 2026 10:43:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8142A0790; Wed, 06 May 2026 12:43:41 +0200 (CEST)
Date: Wed, 6 May 2026 12:43:41 +0200
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
Subject: Re: [PATCH v6 2/2] mm: kick writeback flusher for IOCB_DONTCACHE
 with targeted dirty tracking
Message-ID: <yz5zorwpe5vunerb6wn4jv7sdumrkfe2jcvo6cnknk465kn4wa@g6fw43s7qb4a>
References: <20260505-dontcache-v6-0-66463805dd6a@kernel.org>
 <20260505-dontcache-v6-2-66463805dd6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505-dontcache-v6-2-66463805dd6a@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Rspamd-Queue-Id: 1D3AF4D96F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21408-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Tue 05-05-26 20:59:49, Jeff Layton wrote:
> The IOCB_DONTCACHE writeback path in generic_write_sync() calls
> filemap_flush_range() on every write, submitting writeback inline in
> the writer's context.  Perf lock contention profiling shows the
> performance problem is not lock contention but the writeback submission
> work itself — walking the page tree and submitting I/O blocks the writer
> for milliseconds, inflating p99.9 latency from 23ms (buffered) to 93ms
> (dontcache).
> 
> Replace the inline filemap_flush_range() call with a flusher kick that
> drains dirty pages in the background.  This moves writeback submission
> completely off the writer's hot path.
> 
> To avoid flushing unrelated buffered dirty data, add a dedicated
> WB_start_dontcache bit and wb_check_start_dontcache() handler that uses
> the per-wb WB_DONTCACHE_DIRTY counter to determine how many pages to
> write back.  The flusher writes back that many pages from the oldest dirty
> inodes (not restricted to dontcache-specific inodes). This helps
> preserve I/O batching while limiting the scope of expedited writeback.
> 
> Like WB_start_all, the WB_start_dontcache bit coalesces multiple
> DONTCACHE writes into a single flusher wakeup without per-write
> allocations.  Use test_and_clear_bit to atomically consume the kick
> request before reading the dirty counter and starting writeback, so that
> concurrent DONTCACHE writes during writeback can re-set the bit and
> schedule a follow-up flusher run.
> 
> Read the dirty counter with wb_stat_sum() (aggregating per-CPU batches)
> rather than wb_stat() (which reads only the global counter) to ensure
> small writes below the percpu batch threshold are visible to the flusher.
> 
> In filemap_dontcache_kick_writeback(), set the WB_start_dontcache bit
> inside the unlocked_inode_to_wb_begin/end section for correct cgroup
> writeback domain targeting, but defer the wb_wakeup() call until after
> the section ends, since wb_wakeup() uses spin_unlock_irq() which would
> unconditionally re-enable interrupts while the i_pages xa_lock may still
> be held under irqsave during a cgroup writeback switch.
> 
> Also add WB_REASON_DONTCACHE as a new writeback reason for tracing
> visibility.
> 
> dontcache-bench results (same host, T6F_SKL_1920GBF, 251 GiB RAM,
> xfs on NVMe, fio io_uring):
> 
> Buffered and direct I/O paths are unaffected by this patchset. All
> improvements are confined to the dontcache path:
> 
> Single-stream throughput (MB/s):
>                         Before    After    Change
>   seq-write/dontcache      298      897    +201%
>   rand-write/dontcache     131      236     +80%
> 
> Tail latency improvements (seq-write/dontcache):
>   p99:    135,266 us  ->  23,986 us   (-82%)
>   p99.9: 8,925,479 us ->  28,443 us   (-99.7%)
> 
> Multi-writer (4 jobs, sequential write):
>                                 Before    After    Change
>   dontcache aggregate (MB/s)     2,529    4,532     +79%
>   dontcache p99 (us)             8,553    1,002     -88%
>   dontcache p99.9 (us)         109,314    1,057     -99%
> 
>   Dontcache multi-writer throughput now matches buffered (4,532 vs
>   4,616 MB/s).
> 
> 32-file write (Axboe test):
>                                 Before    After    Change
>   dontcache aggregate (MB/s)     1,548    3,499    +126%
>   dontcache p99 (us)            10,170      602     -94%
>   Peak dirty pages (MB)          1,837      213     -88%
> 
>   Dontcache now reaches 81% of buffered throughput (was 35%).
> 
> Competing writers (dontcache vs buffered, separate files):
>                                 Before    After
>   buffered writer                  868      433 MB/s
>   dontcache writer                 415      433 MB/s
>   Aggregate                      1,284      866 MB/s
> 
>   Previously the buffered writer starved the dontcache writer 2:1.
>   With per-bdi_writeback tracking, both writers now receive equal
>   bandwidth. The aggregate matches the buffered-vs-buffered baseline
>   (863 MB/s), indicating fair sharing regardless of I/O mode.
> 
>   The dontcache writer's p99.9 latency collapsed from 119 ms to
>   33 ms (-73%), eliminating the severe periodic stalls seen in the
>   baseline. Both writers now share identical latency profiles,
>   matching the buffered-vs-buffered pattern.
> 
> The per-bdi_writeback dirty tracking dramatically reduces peak dirty
> pages in dontcache workloads, with the 32-file test dropping from
> 1.8 GB to 213 MB. Dontcache sequential write throughput triples and
> multi-writer throughput reaches parity with buffered I/O, with tail
> latencies collapsing by 1-2 orders of magnitude.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c                | 59 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/backing-dev-defs.h |  2 ++
>  include/linux/fs.h               |  6 ++--
>  include/trace/events/writeback.h |  3 +-
>  4 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a65694cbfe68..faf15cf84c68 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2373,6 +2373,27 @@ static long wb_check_start_all(struct bdi_writeback *wb)
>  	return nr_pages;
>  }
>  
> +static long wb_check_start_dontcache(struct bdi_writeback *wb)
> +{
> +	long nr_pages;
> +
> +	if (!test_and_clear_bit(WB_start_dontcache, &wb->state))
> +		return 0;
> +
> +	nr_pages = wb_stat_sum(wb, WB_DONTCACHE_DIRTY);
> +	if (nr_pages) {
> +		struct wb_writeback_work work = {
> +			.nr_pages	= nr_pages,
> +			.sync_mode	= WB_SYNC_NONE,
> +			.range_cyclic	= 1,
> +			.reason		= WB_REASON_DONTCACHE,
> +		};
> +
> +		nr_pages = wb_writeback(wb, &work);
> +	}
> +
> +	return nr_pages;
> +}
>  
>  /*
>   * Retrieve work items and do the writeback they describe
> @@ -2394,6 +2415,11 @@ static long wb_do_writeback(struct bdi_writeback *wb)
>  	 */
>  	wrote += wb_check_start_all(wb);
>  
> +	/*
> +	 * Check for dontcache writeback request
> +	 */
> +	wrote += wb_check_start_dontcache(wb);
> +
>  	/*
>  	 * Check for periodic writeback, kupdated() style
>  	 */
> @@ -2468,6 +2494,39 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>  	rcu_read_unlock();
>  }
>  
> +/**
> + * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
> + * @mapping:	address_space that was just written to
> + *
> + * Kick the writeback flusher thread to expedite writeback of dontcache dirty
> + * pages. Queue writeback for the inode's wb for as many pages as there are
> + * dontcache pages, but don't restrict writeback to dontcache pages only.
> + *
> + * This significantly improves performance over either writing all wb's pages
> + * or writing only dontcache pages.  Although it doesn't guarantee quick
> + * writeback and reclaim of dontcache pages, it keeps the amount of dirty pages
> + * in check. Over longer term dontcache pages get written and reclaimed by
> + * background writeback even with this rough heuristic.
> + */
> +void filemap_dontcache_kick_writeback(struct address_space *mapping)
> +{
> +	struct inode *inode = mapping->host;
> +	struct bdi_writeback *wb;
> +	struct wb_lock_cookie cookie = {};
> +	bool need_wakeup = false;
> +
> +	wb = unlocked_inode_to_wb_begin(inode, &cookie);
> +	if (wb_has_dirty_io(wb) &&
> +	    !test_bit(WB_start_dontcache, &wb->state) &&
> +	    !test_and_set_bit(WB_start_dontcache, &wb->state))
> +		need_wakeup = true;
> +	unlocked_inode_to_wb_end(inode, &cookie);
> +
> +	if (need_wakeup)
> +		wb_wakeup(wb);
> +}
> +EXPORT_SYMBOL_GPL(filemap_dontcache_kick_writeback);
> +
>  /*
>   * Wakeup the flusher threads to start writeback of all currently dirty pages
>   */
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index cb660dd37286..4f1084937315 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -26,6 +26,7 @@ enum wb_state {
>  	WB_writeback_running,	/* Writeback is in progress */
>  	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
>  	WB_start_all,		/* nr_pages == 0 (all) work pending */
> +	WB_start_dontcache,	/* dontcache writeback pending */
>  };
>  
>  enum wb_stat_item {
> @@ -56,6 +57,7 @@ enum wb_reason {
>  	 */
>  	WB_REASON_FORKER_THREAD,
>  	WB_REASON_FOREIGN_FLUSH,
> +	WB_REASON_DONTCACHE,
>  
>  	WB_REASON_MAX,
>  };
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 11559c513dfb..df72b42a9e9b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2624,6 +2624,7 @@ extern int __must_check file_write_and_wait_range(struct file *file,
>  						loff_t start, loff_t end);
>  int filemap_flush_range(struct address_space *mapping, loff_t start,
>  		loff_t end);
> +void filemap_dontcache_kick_writeback(struct address_space *mapping);
>  
>  static inline int file_write_and_wait(struct file *file)
>  {
> @@ -2657,10 +2658,7 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>  		if (ret)
>  			return ret;
>  	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
> -		struct address_space *mapping = iocb->ki_filp->f_mapping;
> -
> -		filemap_flush_range(mapping, iocb->ki_pos - count,
> -				iocb->ki_pos - 1);
> +		filemap_dontcache_kick_writeback(iocb->ki_filp->f_mapping);
>  	}
>  
>  	return count;
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index bdac0d685a98..13ee076ccd16 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -44,7 +44,8 @@
>  	EM( WB_REASON_PERIODIC,			"periodic")		\
>  	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
>  	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
> -	EMe(WB_REASON_FOREIGN_FLUSH,		"foreign_flush")
> +	EM( WB_REASON_FOREIGN_FLUSH,		"foreign_flush")	\
> +	EMe(WB_REASON_DONTCACHE,		"dontcache")
>  
>  WB_WORK_REASON
>  
> 
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

