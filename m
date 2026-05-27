Return-Path: <linux-nfs+bounces-21998-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIclIyubFmq1ngcAu9opvQ
	(envelope-from <linux-nfs+bounces-21998-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 09:20:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 468655E05CD
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 09:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CD623006946
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C53B7B7A;
	Wed, 27 May 2026 07:18:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78464280A56;
	Wed, 27 May 2026 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866311; cv=none; b=q7IU9fTT+e7rJi3cGUfhl39BsVMODljdnxDD23gDlSE/IQ+yz/K8nJwQWvJPz13LVLcxlqlOTPiJhQewEDYQZQ+uIT+H7sRG9e3nmPIvsR1ZYbjoj17uJGg/H6mXySNM5GPOrwl5WxZAp04BZ/9eDDbmV2riN/qbmmxj4gf0hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866311; c=relaxed/simple;
	bh=axyWWVV7cCi1HwzLCJypw/4N02YCRqRXU1DFbd/Hw+Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AOXCLtkN88cfiZ6V1JSftf5Kgj3mWSQNSFRnx7SmeC8ynjCZxZWxtL6gEHyb7Qu1P0DeB4HY+G5KdcxvXmGAH2/34Ca0wqmuZXmXjm0SWjqvol+wGlA7kgyh0j2/wLhxZvNiqox4cKdTmRtmcYwOIlRxQQAWipuF19KIztSLs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8295768C4E; Wed, 27 May 2026 09:18:17 +0200 (CEST)
Date: Wed, 27 May 2026 09:18:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: revisiting alloc_pages_bulks semantics?
Message-ID: <20260527071816.GA17632@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-0.36 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21998-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:mid]
X-Rspamd-Queue-Id: 468655E05CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I've been looking into using alloc_pages_bulks in a few places lately,
and have run into issues with the API.  Here is my suggestions for how
to make this more useful, although only some of them are something
I'd feel comfortable to do myself:

1) early fail semantics

alloc_pages_bulks can do partial allocations for some reasons, and
users usually have a fallback by either looping and calling it again
or falling back to single page allocations.  This sucks!  Why can't
we get our usual try as hard as you can semantics, requiring
GFP_NORETRY or similar to relax it?

2) pre-zeroed page array 

There is one single user (svc_fill_pages in sunrpc) that relies on it.
For everyone else it creates extra burden and is very error prone
(speaking from experience).

3) page instead of folio

We're allocating folios, so we should have a folio API.

4) > order 0 support

The bulk allocator is limited to order 0 which limits it's usefulness
these days.  It would be really helpful to do bulk allocations for
the pagecache or bounce buffering.

