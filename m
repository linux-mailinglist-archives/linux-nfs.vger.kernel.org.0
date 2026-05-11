Return-Path: <linux-nfs+bounces-21463-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHBhOUzaAWoDlgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21463-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 15:31:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF75D50EFA0
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 15:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D58CD303297E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 13:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E5F3E92B6;
	Mon, 11 May 2026 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozKRNnPS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7083E63A4;
	Mon, 11 May 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505877; cv=none; b=sncTt8ejItkd+GtLrOakNJMWUBuviOjhhCEm+pjmMz9A13THI1geMYUVPgxUrp2FTZPX6/PUYnDPjD1Xbips9AM9gBJPhs8oDL8xvKNi06dMk8YqNaD/x8colZ5E0RgcrjoK5QqLA+0v36ithqlnKqBVYRjCvWmikBkiSQFBw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505877; c=relaxed/simple;
	bh=45Jm/PhkxV5J5go2T8hXkU65Az6gpJJzXMVog7W1o6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlNzKEtBjgxw43lQS0tC2cCcvaw54N9YYUzGkcy/iX5fUmDvjxu8RVe8kBDOilZ4mhJfqBt9zzc7FQxePWQcykm279kVCVg2yHVYpTlg6VRSn955bODzfscN817qa/bHmuOBtk/4hl/0x7725kjxLrKagSSCiHDo2n6/sHJksXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozKRNnPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8D1C2BCB0;
	Mon, 11 May 2026 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778505876;
	bh=45Jm/PhkxV5J5go2T8hXkU65Az6gpJJzXMVog7W1o6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozKRNnPSby6dVKr1OyOOJp34eF/PUQ8m2BzMnJ3UDjBp3qh6WIVAD0AfZSzokF8vv
	 iusOSSnCgeqQu/uiPKo8dUf/W5HXUepK2cjSA+lvfAg4adXt4btHWV19kZzxFXc1iK
	 66oJSJK8g2l4uJSvQsHxw6ct7Ju1Ost5dAhb0KXLomY82vQncGzhZbPJETTHpNsRFC
	 JNQ+iYrHR7KgIVBNUuwRlfKMhM6iPqFkz26EryuL8OruTNDtNRrhl8gFhCK0bVF71e
	 W8erm/gQ+BE9YczlLPDqyQ+eL14u0K4PUpwPgXEHLe/G9H1jLbqW6wFqj0PTzOmaas
	 k7mb4m0tAWahg==
Date: Mon, 11 May 2026 15:24:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v7 3/3] mm: kick writeback flusher for IOCB_DONTCACHE
 with targeted dirty tracking
Message-ID: <20260511-zusieht-amputation-efe8b5058cb7@brauner>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
 <20260511-dontcache-v7-3-2848ddce8090@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511-dontcache-v7-3-2848ddce8090@kernel.org>
X-Rspamd-Queue-Id: DF75D50EFA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21463-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,infradead.org,linux-foundation.org,kernel.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:58:29AM -0400, Jeff Layton wrote:
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
> be held under irqsave during a cgroup writeback switch. Pin the wb with
> wb_get() inside the RCU critical section before calling wb_wakeup()
> outside it, since cgroup bdi_writeback structures are RCU-freed and the
> wb pointer could become invalid after unlocked_inode_to_wb_end() drops
> the RCU read lock.
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
> ---
>  fs/fs-writeback.c                | 63 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/backing-dev-defs.h |  2 ++
>  include/linux/fs.h               |  6 ++--
>  include/trace/events/writeback.h |  3 +-
>  4 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 32ecc745f5f7..77d53df97cc3 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2377,6 +2377,27 @@ static long wb_check_start_all(struct bdi_writeback *wb)
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
> @@ -2398,6 +2419,11 @@ static long wb_do_writeback(struct bdi_writeback *wb)
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
> @@ -2472,6 +2498,43 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
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
> +	    !test_and_set_bit(WB_start_dontcache, &wb->state)) {

Doesn't test_and_set_bit() return the old value? IOW, if it sees that
WB_start_dontcache was already set it'll return true? So you can remove
the test_bit() call, right?

> +		wb_get(wb);
> +		need_wakeup = true;
> +	}

Actually, I think you can rewrite this function quite a bit:


> +	unlocked_inode_to_wb_end(inode, &cookie);
> +
> +	if (need_wakeup) {
> +		wb_wakeup(wb);
> +		wb_put(wb);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(filemap_dontcache_kick_writeback);

void filemap_dontcache_kick_writeback(struct address_space *mapping)
{
	struct inode *inode = mapping->host;
	struct bdi_writeback *wb;
	struct wb_lock_cookie cookie = {};

	wb = unlocked_inode_to_wb_begin(inode, &cookie);
	if (wb_has_dirty_io(wb) && !test_and_set_bit(WB_start_dontcache, &wb->state))
		wb_get(wb);
	else
		wb = NULL;
	unlocked_inode_to_wb_end(inode, &cookie);

	if (wb) {
		wb_wakeup(wb);
		wb_put(wb);
	}
}

No?

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

