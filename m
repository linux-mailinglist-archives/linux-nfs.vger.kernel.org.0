Return-Path: <linux-nfs+bounces-20609-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCEVEzn9zWmfkAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20609-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:23:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4890383F88
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE42E303793F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 05:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D14318EC7;
	Thu,  2 Apr 2026 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yr11Fpu6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096382DC357;
	Thu,  2 Apr 2026 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107305; cv=none; b=Y/AMinGzCnDqc4kA4N7QyWWltRkctshHY74CIBvSnPmyCjsho2FX48cnJl7AyQa4ZfpiIN/VmYfPi5RXIusiieRjsDjU5idRgAJlp0C8DO893V7JqC3Vge434KRAVQA+TkLkqLxbzGEnYr4kqaRTz2mJQ8h6t11/DdeugSA8G70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107305; c=relaxed/simple;
	bh=uqsYExntEu7voInGnB9t7fPXObZlfXDNPSo+6w322k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/jGvG2UvSy0/hvcZizMevPxb/j407ZyO8D4XQS8seCCtgLclsOTT/UjpHyHZUE/ioqHLtijbd2CmqipVD4gDSxQEu3FsxqhwpH99nQT7XbHU5EQ5LDWsrfr6r7igBSuRU43YUnYopTMTL33a+F+j0jxfkAn33DGCNtPynQo0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yr11Fpu6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kCTASolh/HHAKZfZX4Vdxe/7xfbsKFH4aqSmS0b3nPo=; b=yr11Fpu6FYIB0gkBujQ/3cI/ow
	yusMImjUDC/ox8LjAXPIaKbbc1Pvw+z/Pn77dW7GJdmFeJgXa+SwNmJcU06iqbjRwmt/XoL+IasqC
	fx3BpLLBamutD2gd16LTG3yitc0ythc2C+ei9CDMOaWoWlkU7Iq7dSR62PRgTQqizQ73jifgEYaz4
	JjlNUhETfHQM77crjIGx2pQtdEHTgNyXsW2PbJIHrQsnVDKSjsPaV8dUdadEZ0K3jIQphcMNXW2DB
	vaxRh/UD0TgnOUgxRpXh1g4pjka94XYL00h/JMC32NjTzEMWxWpcJcJSe1bxnkVeVCC07fxIGqcK5
	pl0lV7Kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8AUu-0000000GnzB-0dij;
	Thu, 02 Apr 2026 05:21:40 +0000
Date: Wed, 1 Apr 2026 22:21:40 -0700
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
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <msnitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: fix IOCB_DONTCACHE write performance with
 rate-limited writeback
Message-ID: <ac385Il8l-krKEOQ@infradead.org>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
 <20260401-dontcache-v1-1-1f5746fab47a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-dontcache-v1-1-1f5746fab47a@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20609-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: C4890383F88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 03:10:58PM -0400, Jeff Layton wrote:
> IOCB_DONTCACHE calls filemap_flush_range() with nr_to_write=LONG_MAX
> on every write, which flushes all dirty pages in the written range.
>
> Under concurrent writers this creates severe serialization on the
> writeback submission path, causing throughput to collapse to ~47% of
> buffered I/O with multi-second tail latency.  Even single-client
> sequential writes suffer: on a 512GB file with 256GB RAM, the
> aggressive flushing triggers dirty throttling that limits throughput
> to 575 MB/s vs 1442 MB/s with rate-limited writeback.

I'm not sure the first how you think the first paragraph relate to
the second.

> Replace the filemap_flush_range() call in generic_write_sync() with a
> new filemap_dontcache_writeback_range() that uses two rate-limiting
> mechanisms:
> 
>   1. Skip-if-busy: check mapping_tagged(PAGECACHE_TAG_WRITEBACK)
>      before flushing.  If writeback is already in progress on the
>      mapping, skip the flush entirely.  This eliminates writeback
>      submission contention between concurrent writers.

Makes sense.

>   2. Proportional cap: when flushing does occur, cap nr_to_write to
>      the number of pages just written.  This prevents any single
>      write from triggering a large flush that would starve concurrent
>      readers.

This doesn't make any sense at all.
filemap_flush_range/filemap_writeback always caps the number of written
pages to the range passed in.  What do you think is the change here?

> +	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, &nr,
> +			WB_REASON_BACKGROUND);

filemap_writeback only has 5 arguments in any tree I've looked at
including linux-next.


