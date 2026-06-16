Return-Path: <linux-nfs+bounces-22643-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VKOQCt6GMWrPlgUAu9opvQ
	(envelope-from <linux-nfs+bounces-22643-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 19:24:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580F1693195
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 19:24:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VWHqpnon;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22643-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22643-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1609330449F4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1501478E55;
	Tue, 16 Jun 2026 17:23:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918A44BCBE
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 17:23:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630637; cv=none; b=Ume5SmZ3ewMKMfksKbiqtH24T6/rhDvAxkWZ1NkgfqYK5CQdpho4+a3TMhNci4jbhOgJwwyGprwOL9bYmKIzMkBGY71Kp/QcmHT3u3boNnoITwzisPUs6OcQndw4XQZZBpFZssLLP6m59ZMuZGmtb38N6DtXQzIMEsidK9jVFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630637; c=relaxed/simple;
	bh=i+WbFc8oXeqZ8g6etYEgar6SYCtupkUgENLQBPqXj7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBAEuUTEFuxov05ye+hnF/DCrZUcOoMhAwUr8TuqvJZ5NrSlORG2FJY3odR3NFKOEgZXcmJ3UTEWP9wbVLO2YZBzxGLLfyNkotFfgvulwO+Agw/wn1QIuPOWvlKjGRU3bZ8nVdejqGmAUouex3wZxICKQ0/l07dBGpexSYy4N8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWHqpnon; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2d865383so3545ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781630635; x=1782235435; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RrCESOvkqMUaxHUUKJn7oH5lBKk+75kt7fC/anmZiUQ=;
        b=VWHqpnonj3kY71GZ18xjLuAp7WZNcZQVsUjB3zQiIWIZLYA+HKQJjPH9NiKA5XSi03
         l8IAh7x9167UML69LNYjNP5JQyt/nUlMogiQJetQ0x0uiQ9i+JXFvY/yYvFLZpuwqbja
         wVq8+zXzlTfYO/bR9XMfcXl/RDIg0P7lx5Yl4vfZUDKbaVZ1yQ0HSeeIVkH9iHLnrnC0
         XubHseU23W8th4kuIHSbkfgjwhiOpo6ieSsk71DkKgdSTX3XX0uHayb7m8qXgqKR9IbF
         zP0rS0hDSJjN+XWZyuv2pVq5Wzm3mEyOa9GJFHoNCOJ2IvK4IaEKfG+bEqcxDlkWSCwi
         lBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630635; x=1782235435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrCESOvkqMUaxHUUKJn7oH5lBKk+75kt7fC/anmZiUQ=;
        b=sCSta4OAlULcfQpUcWPYd8HsmLq1IvLX9EnpAlb3ieiP5bBINQGAAFvPmpB5OxA0YP
         6esQVs+EfCsQwdX2RHBUh6ZJxbLIcgbWSi4NNLk+Og5A1w/vMwLtkhDcGAOaUDQGLFgU
         sGlJtvQF+g4sNUXrWyfLhk19OwHYYZA03XBWS7pj8MqV2ANMhrr5P+4ERPEnNfqxX7UX
         VhaMvdL838ZgEldFSM0HN3QjQCRmX6Gk4JvJsUcgpn8Od5aYXN5XKfUsl23sySw7Ali8
         tQqy7uMtUDcaK+/R4D3sJZ4tm3L7xMw8rZ7RoqSxdGY/JpFG0wknTR77HpeOMeFsMWp/
         q5yg==
X-Gm-Message-State: AOJu0YzMrlDafiOPI7jJ1He+toaPXhXKxGlhNjW4NaRQGMcPYcDH3/I5
	B+eZBtgn8BaJ08/eBfcT0P3JzKyPWWIjbum3aomvGDr5rsrRFYkx74d2qKsef0mFIg==
X-Gm-Gg: AfdE7cn2sOJTRrtMhC1tvn6mcdzjpMTbhPoy5B6arrwCqYWFdN2cbFdRO5Wu8ocKYV3
	j/VFAlpVKswjDQrX8g5FT9L5d08+OwiPpoZ7oGoqlF6Cf6g9BgqDk0YcCkhVWD808OmfKTD2HnZ
	8PtZfiLJiCwPMBmUp4dh7vBc/+z7qfOJQjwHabf/+5Lyq5Ugh0IJw8F5uLykjJGdJZzpz1FKOdf
	hSPYYKp8K/I+Doqqqyk8IRHmX70oIYSr/rQgI8QMXKzUkNdkoHvp/Sc53mwqPkrlDaEuulz8Lsb
	Vtj/jko7sa+krlWuXxGKLZA+/4fQebbOo4lSSZIXPL0zWiQhggOnJxKQXtq70PNXPGcTuimkgL7
	8SK9cV8u0TH31Ow3Bo61Sk86uZv47FhmROPNENI7TzHTinci7jXtvK2oD98yLmxrqxQs0nwxErq
	9Flp8BsGV/Q4tXaUQbJDl9oFhK4e2d/b61UGnFqYz46JDz+FyWUIwpxkgojjsA
X-Received: by 2002:a17:902:f64d:b0:2bd:6dad:7cca with SMTP id d9443c01a7336-2c6bbb0fe8emr58175ad.22.1781630634250;
        Tue, 16 Jun 2026 10:23:54 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf039fsm13306261b3a.20.2026.06.16.10.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:23:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 17:23:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <ajGGpDvzZdkGtSbN@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-22643-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 580F1693195

On Tue, Jun 16, 2026 at 11:29:13AM -0400, Trond Myklebust wrote:

Hi Trond

> On Tue, 2026-06-16 at 13:39 +0000, Pranjal Shrivastava wrote:
> > Optimize nfs_direct_extract_pages() to group contiguous pages from
> > the
> > same folio into single nfs_page structures. This effectively migrates
> > NFS Direct I/O from being page-based to being folio-based.
> > 
> > Reduce the number of nfs_page allocations and subsequent iterations
> > by utilizing nfs_page_create_from_folio() to create aggregated
> > requests.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  fs/nfs/direct.c | 47 +++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 37 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> > index e2a93cfb6c72..ddc6b27f5315 100644
> > --- a/fs/nfs/direct.c
> > +++ b/fs/nfs/direct.c
> > @@ -194,23 +194,45 @@ static ssize_t nfs_direct_extract_pages(struct
> > nfs_direct_req *dreq,
> >  		return result;
> >  
> >  	npages = (result + pgbase + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > -	for (i = 0; i < npages; i++) {
> > +	for (i = 0; i < npages; ) {
> > +		unsigned int chunk_len, folio_offset;
> > +		unsigned int nr_to_add = 1;
> >  		struct nfs_page *req;
> > -		unsigned int req_len = min_t(size_t, result - bytes,
> > PAGE_SIZE - pgbase);
> > +		struct folio *folio;
> >  
> > -		req = nfs_page_create_from_page(dreq->ctx,
> > pagevec[i],
> > -						pinned, pgbase,
> > *pos,
> > -						req_len);
> > +		folio = page_folio(pagevec[i]);
> 
> I'm clearly missing something. The memory pointed to by these pages can
> be any arbitrary user space (or kernel space) memory region. It could
> be mapped device memory, for instance.
> 
> So why can you assume that page_folio() will resolve to a valid folio
> here?

AFAIU, the MM subsystem explicitly ensures that every valid struct page
is part of a folio. The documentation for page_folio() explicitly 
states [1]:

     "Every page is part of a folio. This function cannot be called on a
      NULL pointer."

Since iov_iter_extract_pages() only returns pages that are successfully
pinned and tracked by the kernel, we are guaranteed that pagevec[i] 
points to a valid struct page and thus a valid folio.

Regarding device-mapped memory, ZONE_DEVICE pages have also been
refactored to support folios recently (e.g. free_zone_device_folio() [2])
If the memory is not part of a large compound page, page_folio() simply
returns the struct page pointer cast to a struct folio * [3]. In this 
case, the folio size is effectively 1, and our extraction loop correctly
handles it as a single-page request unless it identifies physical 
contiguity within the same folio.

The only other thing to take care was folio_split which applies 
specifically when the caller does not hold a reference on the page. 
However, in our case (NFS) the iov_iter_extract_pages() has already
pinned the folio via GUP by this point which ensures that the folio 
cannot be split or freed under us, making the page_folio() call and the
subsequent aggregation logic safe.

Finally, in cases where device memory is NOT backed by struct page
(e.g. dmabuf or PFN-based mappings via remap_pfn_range), the buffers
are already unsupported for NFS Direct I/O today. The underlying page
pinning (GUP) would fail with -EFAULT in check_vma_flags() [4] even
before reaching this point.

Given the above guarantees by the kernel, we can ensure that this
resolves to a valid folio at this point in the file-system.

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc6/source/include/linux/page-flags.h#L291
[2] https://elixir.bootlin.com/linux/v7.1-rc6/source/mm/memremap.c#L416
[3] https://elixir.bootlin.com/linux/v7.1-rc6/source/include/linux/page-flags.h#L234
[4] https://elixir.bootlin.com/linux/v7.1-rc6/source/mm/gup.c#L1208

