Return-Path: <linux-nfs+bounces-22000-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB9wAJelFmoOoAcAu9opvQ
	(envelope-from <linux-nfs+bounces-22000-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 10:04:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6563E5E0CFE
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF1A300BDBC
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945B369D41;
	Wed, 27 May 2026 08:01:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091663B585F;
	Wed, 27 May 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868864; cv=none; b=rrc8NIrX7OGR3SEeliVP90/upwxXFcLO8qT9vOdm1IVzUrHMXrVI5ik6k4XGY13jljby0uaJFH+qUMRyM2ulcM4ZXucIWWvwV0L+m0JJjZQ3DxgCzRk86d1JxMLhpFS5yk60iJCYbeaVRYZ1yUSB1HwJwo/CPMgyUBZbKlfNN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868864; c=relaxed/simple;
	bh=F69w9UmNLfy5ME7NLHXHvQo2/PSBjpuhKVnxiZ/zj4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WML4P6NLnXbo9dgIvE5nX8V37XZ0z3k/oGMIdBWe3kcG+KjgAoJ9s1SFfROo0Ms7t2NO6r9Tj1fuDf1rHjegAKBHHLl1SGNrZlQ/9CIKua2LsWg+B/Q8g4pmGNvsRJd0UgtXlwemrIRRWdXEoKzSwi3oVeyY+gbAP5yhaT5sgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFF7668C4E; Wed, 27 May 2026 10:00:56 +0200 (CEST)
Date: Wed, 27 May 2026 10:00:56 +0200
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
Message-ID: <20260527080056.GA20040@lst.de>
References: <20260527071816.GA17632@lst.de> <A68C1B33-053C-4406-B78E-871ECD7293B3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A68C1B33-053C-4406-B78E-871ECD7293B3@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-0.36 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22000-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:mid]
X-Rspamd-Queue-Id: 6563E5E0CFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 03:53:53PM +0800, Zi Yan wrote:
> > 1) early fail semantics
> >
> > alloc_pages_bulks can do partial allocations for some reasons, and
> > users usually have a fallback by either looping and calling it again
> > or falling back to single page allocations.  This sucks!  Why can't
> > we get our usual try as hard as you can semantics, requiring
> > GFP_NORETRY or similar to relax it?
> 
> IIUC, current alloc_pages_bulks() tries to get free pages without doing
> compaction or reclaim unless none can be allocated.

Yes, which is really odd, as other page/folio allocators make that an
opt-in through GFP flags.

> Does your “usual try”
> mean possible invocation of compaction and/or reclaim for every page
> allocation?

If you look at most callers in tree, and my recently merged or to be
merged work isn't any different, they just bloody want the pages just
as any other allocator.  Failing under grave memory pressure is fine
of course, but just failing because getting the memory requires effort
is not.

> I guess it also relates to the order > 0 bulk allocation
> below? My gut feeling is that if one “usual try” fails, the following
> “usual try” might not work. So making alloc_pages_bulks() do heavy
> allocation might not buy you much.

Well, we need to centralize this.  Right now there is lots of divering
cargo culting in the callers.

> But can you elaborate on why looping alloc_pages_bulks() does not work
> well? That is essentially triggering compaction/reclaim repeatedly
> like your proposed “usual try” idea.

I'm not even sure if it works well.  There are some callers that do that,
some use individual fallbacks.  I don't really want to think about that
when all I need is a few folios.

> > The bulk allocator is limited to order 0 which limits it's usefulness
> > these days.  It would be really helpful to do bulk allocations for
> > the pagecache or bounce buffering.
> 
> Sounds reasonable to me, but when under memory pressure, I wonder
> how many > order 0 folios you can get in the end. And that might
> cause a storm of compaction and/or reclaim if combined with Idea 1.

Well, I really want them.  In some cases I might be fine falling down
to smaller sizes, but I also really don't want the logic in every
caller.

> For > order 0 bulk allocations, are you thinking about 1)
> a try and bail-out early model or 2) a keep-trying model?

Both are useful and as with other allocators should depend on the
passed in GFP flags.

> For the latter, I wonder how large the allocation latency can be
> and if that is tolerable or even makes sense, since for THP
> allocations, we have seen >30s allocation latency when under
> memory pressure. Is waiting minutes for bulk > order 0 allocation
> making sense in your use cases?

The allocations I have in mind would only require try hard allocations
for typical file system blocks sizes (64k at most), while eveything
larger is fair game for falling back.


