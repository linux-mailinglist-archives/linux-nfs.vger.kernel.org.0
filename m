Return-Path: <linux-nfs+bounces-21172-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OinN7Fa72llAgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21172-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 14:46:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EAF472B30
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0C3D3018C1A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A93B9D8C;
	Mon, 27 Apr 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6E9ltri";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0I9oYAuq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6E9ltri";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0I9oYAuq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1480305057
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293995; cv=none; b=aGtBhJdSOaJwhVsjYkFl++Ve2uUsD2CneegBvs8/6tV4WO5Fcp8NemMArbMTUS3//bEzbttAQR9GAtQHsa4WS94nyu7EZvPe7zmpmXoVRyaV2zdkpzjI7OEGn28DrePuG5XD3b18Pnljyn4+nOfOxDHhgSY7BasWTA6YdJFYRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293995; c=relaxed/simple;
	bh=v803Hy+eXmXsTRnc66SUY6m83HvnbJSjCcSxePscPBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqH8GfBnyBuQh5k9iqzJTvkpSwpKnJGChwfig/iOGWM+8sn+zmhN03joRnYjUjfB+BF0eblYVqMi0jvv9iIiuDhZYjmEf68nPItRIx9V3eM64GVifkf2kdrMnaD4tcUsS2v2YA2JHt00LgICOTjI0hL92SHnj1k+N7d+lHA3ZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6E9ltri; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0I9oYAuq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6E9ltri; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0I9oYAuq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 062F26A842;
	Mon, 27 Apr 2026 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777293992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PD32WU/9Tw1lL09UECl6fy32VpzfuwRNALZweCagXW8=;
	b=Y6E9ltrict6s8aFYhrzz3ERlVvuCGh8mxmOxpJT2FPmLppe9MeqnK7RvrGqG/i27NViWpQ
	Gt4styeM+URnFkTLTaxduh9YsvnjDY9wbk8fBRKoD/uq4VVbeG60IumaTYkZN4ivsBCYOV
	TSTh0U6oo7Yn9JE9OyaMpvJZGvlH5xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777293992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PD32WU/9Tw1lL09UECl6fy32VpzfuwRNALZweCagXW8=;
	b=0I9oYAuqjRzTzsl/t/DyRx8PNyEbpNgZmExj+2o9yz7U4IZyuh7mDwoTVhNTkxPMpOhAvD
	OkxSAQLbWvxErwBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y6E9ltri;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0I9oYAuq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777293992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PD32WU/9Tw1lL09UECl6fy32VpzfuwRNALZweCagXW8=;
	b=Y6E9ltrict6s8aFYhrzz3ERlVvuCGh8mxmOxpJT2FPmLppe9MeqnK7RvrGqG/i27NViWpQ
	Gt4styeM+URnFkTLTaxduh9YsvnjDY9wbk8fBRKoD/uq4VVbeG60IumaTYkZN4ivsBCYOV
	TSTh0U6oo7Yn9JE9OyaMpvJZGvlH5xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777293992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PD32WU/9Tw1lL09UECl6fy32VpzfuwRNALZweCagXW8=;
	b=0I9oYAuqjRzTzsl/t/DyRx8PNyEbpNgZmExj+2o9yz7U4IZyuh7mDwoTVhNTkxPMpOhAvD
	OkxSAQLbWvxErwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E934D593B0;
	Mon, 27 Apr 2026 12:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2pnpOKda72mjKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 12:46:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7D6FA0AFF; Mon, 27 Apr 2026 14:46:23 +0200 (CEST)
Date: Mon, 27 Apr 2026 14:46:23 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm: kick writeback flusher for IOCB_DONTCACHE
 with targeted dirty tracking
Message-ID: <7567kwydg2x7lp77xloxk5hjaar3k2xvbqqaro3k4hu4fncww5@yo2rmkrxlhkv>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
 <20260426-dontcache-v3-2-79eb37da9547@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426-dontcache-v3-2-79eb37da9547@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 56EAF472B30
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
	TAGGED_FROM(0.00)[bounces-21172-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,tencent.com,linux.dev,goodmis.org,efficios.com,vger.kernel.org,kvack.org];
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

On Sun 26-04-26 07:56:08, Jeff Layton wrote:
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
> the new NR_DONTCACHE_DIRTY counter to determine how many pages to write
> back.  The flusher writes back that many pages from the oldest dirty
> inodes (not restricted to dontcache-specific inodes). This helps
> preserve I/O batching while limiting the scope of expedited writeback.
> 
> Like WB_start_all, the WB_start_dontcache bit coalesces multiple
> DONTCACHE writes into a single flusher wakeup without per-write
> allocations.
> 
> Also add WB_REASON_DONTCACHE as a new writeback reason for tracing
> visibility, and target the correct cgroup writeback domain via
> unlocked_inode_to_wb_begin().
> 
> dontcache-bench results on dual-socket Xeon Gold 6138 (80 CPUs, 256 GB
> RAM, Samsung MZ1LB1T9HALS 1.7 TB NVMe, local XFS, io_uring, file size
> ~503 GB, compared to a v6.19-ish baseline):
> 
>   Single-client sequential write (MB/s):
>                        baseline    patched     change
>   buffered              1449.8     1440.1      -0.7%
>   dontcache             1347.9     1461.5      +8.4%
>   direct                1450.0     1440.1      -0.7%
> 
>   Single-client sequential write latency (us):
>                        baseline    patched     change
>   dontcache p50         3031.0    10551.3    +248.1%
>   dontcache p99        74973.2    21626.9     -71.2%
>   dontcache p99.9      85459.0    23199.7     -72.9%
> 
>   Single-client random write (MB/s):
>                        baseline    patched     change
>   dontcache              284.2      295.4      +3.9%
> 
>   Single-client random write p99.9 latency (us):
>                        baseline    patched     change
>   dontcache             2277.4      872.4     -61.7%
> 
>   Multi-writer aggregate throughput (MB/s):
>                        baseline    patched     change
>   buffered              1619.5     1611.2      -0.5%
>   dontcache             1281.1     1629.4     +27.2%
>   direct                1545.4     1609.4      +4.1%
> 
>   Mixed-mode noisy neighbor (dontcache writer + buffered readers):
>                        baseline    patched     change
>   writer (MB/s)         1297.6     1471.1     +13.4%
>   readers avg (MB/s)     855.0      462.4     -45.9%
> 
> nfsd-io-bench results on same hardware (XFS on NVMe, NFSv3 via fio
> NFS engine with libnfs, 1024 NFSD threads, pool_mode=pernode,
> file size ~502 GB, compared to v6.19-ish baseline):
> 
>   Single-client sequential write (MB/s):
>                        baseline    patched     change
>   buffered              4844.2     4653.4      -3.9%
>   dontcache             3028.3     3723.1     +22.9%
>   direct                 957.6      987.8      +3.2%
> 
>   Single-client sequential write p99.9 latency (us):
>                        baseline    patched     change
>   dontcache            759169.0   175112.2     -76.9%
> 
>   Single-client random write (MB/s):
>                        baseline    patched     change
>   dontcache              590.0     1561.0    +164.6%
> 
>   Multi-writer aggregate throughput (MB/s):
>                        baseline    patched     change
>   buffered              9636.3     9422.9      -2.2%
>   dontcache             1894.9     9442.6    +398.3%
>   direct                 809.6      975.1     +20.4%
> 
>   Noisy neighbor (dontcache writer + random readers):
>                        baseline    patched     change
>   writer (MB/s)         1854.5     4063.6    +119.1%
>   readers avg (MB/s)     131.2      101.6     -22.5%
> 
> The NFS results show even larger improvements than the local benchmarks.
> Multi-writer dontcache throughput improves nearly 5x, matching buffered
> I/O. Dirty page footprint drops 85-95% in sequential workloads vs.
> buffered.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

One comment regarding how the writeback is started:

> +static long wb_check_start_dontcache(struct bdi_writeback *wb)
> +{
> +	long nr_pages;
> +
> +	if (!test_bit(WB_start_dontcache, &wb->state))
> +		return 0;
> +
> +	nr_pages = global_node_page_state(NR_DONTCACHE_DIRTY);
> +	if (nr_pages) {
> +		struct wb_writeback_work work = {
> +			.nr_pages	= wb_split_bdi_pages(wb, nr_pages),
> +			.sync_mode	= WB_SYNC_NONE,
> +			.range_cyclic	= 1,
> +			.reason		= WB_REASON_DONTCACHE,
> +		};
> +
> +		nr_pages = wb_writeback(wb, &work);
> +	}
> +
> +	clear_bit(WB_start_dontcache, &wb->state);
> +	return nr_pages;
> +}

So this will end up splitting NR_DONTCACHE_DIRTY folios among per-cgroup wb
structures based on their writeback bandwidth. This is a reasonable thing
for global writeback where the bandwidth more or less corresponds to the
amount of dirty folios. However with DONTCACHE I expect big differences in
among NR_DONTCACHE_DIRTY among different cgroups not necessarily
corresponding to wb throughput. In particular if you do DONTCACHE writes
from one cgroup and normal writes from another cgroup this will
systematically underestimate the amount needed to write by a factor of
about two.

So I think the stat should be a per bdi_writeback one (instead of a per node
one) which would avoid the need to split the value to wb here.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

