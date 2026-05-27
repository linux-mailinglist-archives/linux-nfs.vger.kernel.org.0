Return-Path: <linux-nfs+bounces-22005-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIn/KnngFmo9uQcAu9opvQ
	(envelope-from <linux-nfs+bounces-22005-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 14:15:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494425E3FCA
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 14:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E857302D195
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FD53A8741;
	Wed, 27 May 2026 12:15:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672D369985;
	Wed, 27 May 2026 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884121; cv=none; b=fe5VxYg/MaxqgLOlwLHXCvVGbIXKL6mGPRQBqmOC95jtB5ecSIT4tMNzLWJq3yrHK5XQEBeJXZtnYnelg8DYwZo75WSXDIY2l0SW7sRCY8nprts+PA4ASqoueOFDtS2TxAS/9Jvy8kaUgeGjzo+XzAV85jqJNoQG+7emC3E0yUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884121; c=relaxed/simple;
	bh=N8F0SDC93Sd1AUmPlfRcn5p6y3asul968Ud3/vvAM/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixaIJZpZAtCV23nseidSzls50MSB4UVEbmwq0VXBBlH38ah4Xt1kC5RZExd0gKaNIZR9rprErUh+Wpfb5f+XekZM6PmieDMwzg+IVU7tdjC6YaWY2rRu50z4LVf9rKY4CNorOLmPL9wgErOPChxcNJEgegFDNdM4wu/sguKV3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6183B68BEB; Wed, 27 May 2026 14:15:09 +0200 (CEST)
Date: Wed, 27 May 2026 14:15:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zi Yan <ziy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: revisiting alloc_pages_bulks semantics?
Message-ID: <20260527121508.GA6079@lst.de>
References: <20260527071816.GA17632@lst.de> <A68C1B33-053C-4406-B78E-871ECD7293B3@nvidia.com> <20260527080056.GA20040@lst.de> <2759BB06-005F-41EF-815F-C9F96E822DE1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2759BB06-005F-41EF-815F-C9F96E822DE1@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-0.36 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22005-lists,linux-nfs=lfdr.de];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 494425E3FCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 04:31:24PM +0800, Zi Yan wrote:
> > Yes, which is really odd, as other page/folio allocators make that an
> > opt-in through GFP flags.
> 
> Based on my understanding of the code, the GFP flags are respected at
> the __alloc_pages_noprof() in alloc_pages_bulk().

As __alloc_pages_noprof is the core of the regular page/folio allocator
I'd expect that as well.

> The loop of
> rmqueue_pcplist() is just a quick try of getting free pages.
> And I suspect it might be quicker than calling __alloc_pages_noprof()
> in a loop, since other preparation work in __alloc_pages_noprof()
> is only done once.

Possibly.  But that means a whole bunch of callers have the wrong
assumption.

> > Well, I really want them.  In some cases I might be fine falling down
> > to smaller sizes, but I also really don't want the logic in every
> > caller.
> 
> Based on your answers above, it sounds like a wrapper of
> __alloc_pages_bulk() that doing allocation in a loop until all requested
> pages are filled might be good enough for your case.
> 
> But let me know if I miss something.

Or just allocate all pages using a loop when alloc_pages_bulk_noprof
doesn't get enough pages from the PCP list?

> > The allocations I have in mind would only require try hard allocations
> > for typical file system blocks sizes (64k at most), while eveything
> > larger is fair game for falling back.
> 
> Sure. In MM, PAGE_ALLOC_COSTLY_ORDER is 3, so pages bigger than that
> would take more effort to get and the allocation latency can be longer.
> So it might take a long time to allocate the last 64KB page in
> a bulk allocation.

Based on the LSF/MM session on lage folios and MM fragmentation session
it seems like we should raise it to 4 for 4k page size platforms,
as this seems to be a proble for 64k folio allocations.


