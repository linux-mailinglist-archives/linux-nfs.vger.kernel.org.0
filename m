Return-Path: <linux-nfs+bounces-22006-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEbHDyzjFmpIvAcAu9opvQ
	(envelope-from <linux-nfs+bounces-22006-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 14:27:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B04515E4295
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE9C53017C13
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C83D6CAE;
	Wed, 27 May 2026 12:19:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4903D79FE;
	Wed, 27 May 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884371; cv=none; b=nZMS+tXVBKJJwTRC1u3UQlHilVUuRHV7hPEvSy7MLIJdDjsLoer+j2Bce77nAN8hSV3jIXdj2ZqLjz17ILd69GcHH9eJmDnQSlTgVoneMuHmsImLsZxG/Mw/Y6szXVKND8ZIvgShVObTvDIvnouHkrRUX2gmj/vr+mKt3AxOigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884371; c=relaxed/simple;
	bh=0FuMLgw2lr+Iy23/AEj2LtX8dG/FJBNF3MwSIBQAZFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFU5wRPErs/0U4VQRtCoy9+twfiOKbEnUY+4er2r0PdwODaS4iQe1lc8V7M02+TkhNI1e0JaZLicaO4B+bxK9l88mD6JoYLVR52bQQeUI4mJULDKNCLR0stG/uqD3id0kaiAXAqi0EJdzAfzTK6+WbiR+lA1WWN4fmTTHnhrFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88C4468BEB; Wed, 27 May 2026 14:19:20 +0200 (CEST)
Date: Wed, 27 May 2026 14:19:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: revisiting alloc_pages_bulks semantics?
Message-ID: <20260527121920.GB6079@lst.de>
References: <20260527071816.GA17632@lst.de> <df21e8b0-a67b-4b71-8178-91221b596949@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df21e8b0-a67b-4b71-8178-91221b596949@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-0.36 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22006-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B04515E4295
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:06:08PM +0200, Vlastimil Babka (SUSE) wrote:
> > alloc_pages_bulks can do partial allocations for some reasons, and
> > users usually have a fallback by either looping and calling it again
> > or falling back to single page allocations.  This sucks!  Why can't
> > we get our usual try as hard as you can semantics, requiring
> > GFP_NORETRY or similar to relax it?
> 
> If we do that, do we keep the possibility of partial success, i.e. return
> how many were allocated? Seems wasteful to suceed N-1 and then throw all
> away, if the caller can use a fallback only for the last one.
> Do some callers need all-or-nothing semantics? Should a flag indicate which
> one to use?

A lot of callers (but not all) need all or nothing semantics.  But
freeing already allocated pages is the not a major problem - the caller
just has to add a release_pages call if it didn't already have one
for cleaning up later failures.

> > There is one single user (svc_fill_pages in sunrpc) that relies on it.
> > For everyone else it creates extra burden and is very error prone
> > (speaking from experience).
> 
> Sounds good to me. Will sunrpc be easy to convert, or should it be another
> flag to opt-in to the current behavior, that it would use?

I've added Chuck to the Cc list, but from memory sunrpc actually does
make use of this feature and he objected to previous attempts to
change it.  So a first step would be to have a lower-level helper
that works as-is and a wrapper that zeroes the array, even if that
doesn't feel as efficient as it could be.

> > 3) page instead of folio
> > 
> > We're allocating folios, so we should have a folio API.
> 
> Hm, folios initially started as "base or compound page" but then the
> semantics shifted and now they are also rmappable. See how
> folio_alloc_noprof() does page_rmappable_folio(). The differences might grow
> further with memdesc conversion I think.
> So do all the callers actually want folios? If not, we could have both
> alloc_pages_bulk() and folio_alloc_bulk()?

I can't speak for all of them, but many do.


