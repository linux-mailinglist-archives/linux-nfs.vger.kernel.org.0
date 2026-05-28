Return-Path: <linux-nfs+bounces-22030-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDcXLMUFGGqdZggAu9opvQ
	(envelope-from <linux-nfs+bounces-22030-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 11:07:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8455EF391
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D650630856E2
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B430AAD8;
	Thu, 28 May 2026 09:01:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41A35F5F1;
	Thu, 28 May 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958861; cv=none; b=pQ6XJAdQwk2cdoAksAykQm91R4iZnDd2WhptUDGPX+OH2Ii39et4p+2GXQHUIQIN8Mw2M9ClFJLPvRY+SLhOUwDmMzFv0/8id0Vb9vFA14UXi0QUuZR/gK96kW2cmc3Osnd6yDBtiqeIsN6na8bUnBZh0ee6Jx+44LQBK5k/H9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958861; c=relaxed/simple;
	bh=Y91Yw8igsjV1pZB/LglYf6ZbSznDGNjtrEvnXdMnbKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUwvyunksyYqdKJOu2aXHLNhPYOBOByI7tc0RvLviHXt70uvFkWCirfBsgVbDUza75Nd0/rRGORYAeCd/ziBpZ7IR7Mpeyi/MdBvzEBIR5D55rdJlprHB37Q+anygFZkuiRp/6Ejaj/iG9G6kemyrrZWf6Od0V01Yk+KvOAqB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA31868B05; Thu, 28 May 2026 11:00:54 +0200 (CEST)
Date: Thu, 28 May 2026 11:00:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: revisiting alloc_pages_bulks semantics?
Message-ID: <20260528090054.GA8376@lst.de>
References: <20260527071816.GA17632@lst.de> <df21e8b0-a67b-4b71-8178-91221b596949@kernel.org> <20260527121920.GB6079@lst.de> <276835c4-78d4-411d-8097-93cdfb000648@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276835c4-78d4-411d-8097-93cdfb000648@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-0.36 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22030-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A8455EF391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 09:58:11AM -0400, Chuck Lever wrote:
> On 5/27/26 8:19 AM, Christoph Hellwig wrote:
> > On Wed, May 27, 2026 at 12:06:08PM +0200, Vlastimil Babka (SUSE) wrote:
> >>> alloc_pages_bulks can do partial allocations for some reasons, and
> >>> users usually have a fallback by either looping and calling it again
> >>> or falling back to single page allocations.  This sucks!  Why can't
> >>> we get our usual try as hard as you can semantics, requiring
> >>> GFP_NORETRY or similar to relax it?
> >>
> >> If we do that, do we keep the possibility of partial success, i.e. return
> >> how many were allocated? Seems wasteful to suceed N-1 and then throw all
> >> away, if the caller can use a fallback only for the last one.
> >> Do some callers need all-or-nothing semantics? Should a flag indicate which
> >> one to use?
> > 
> > A lot of callers (but not all) need all or nothing semantics.  But
> > freeing already allocated pages is the not a major problem - the caller
> > just has to add a release_pages call if it didn't already have one
> > for cleaning up later failures.
> 
> What the svc/nfsd thread is trying to avoid is sleeping uninterruptibly
> waiting for memory resources. That stalls server shutdown, among other
> things.

I'm not fully understanding the sentence.  I guess you mean that
you want svc_thread_should_stop to intercept some memory allocation
waits?

> > I've added Chuck to the Cc list, but from memory sunrpc actually does
> > make use of this feature and he objected to previous attempts to
> > change it.  So a first step would be to have a lower-level helper
> > that works as-is and a wrapper that zeroes the array, even if that
> > doesn't feel as efficient as it could be.
> If sunrpc is the only user, it might be sensible to hoist the "zero
> fill" capability into sunrpc.ko.

As far as I can tell it is the only one.  But I don't really see
how you could implement that functionality outside the core, except
by falling back to single allocations, or looking for empty slots.

I'm curious what you think about willy's comment, or if there is
indeed a way to always use the pages from the beginning or end in
sunrpc.

>     svc_rqst_release_pages() NULLs only the range
> 
>       [rq_respages, rq_next_page)
> 
>     after each RPC, so only that range contains NULL entries. Limit the
>     rq_respages fill in svc_alloc_arg() to that range instead of
>     scanning the full array.

Does it NULL the entire range, or part of it?  Because if it is the
entire above range, you don't really need the check for NULL behavior
at all but just point the bulk allocation to this range.


