Return-Path: <linux-nfs+bounces-22680-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1HaSLYk3NGpORwYAu9opvQ
	(envelope-from <linux-nfs+bounces-22680-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 20:23:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB936A21F8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 20:23:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=YfOhqeQz;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22680-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22680-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729C3302DF94
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66136C5A9;
	Thu, 18 Jun 2026 18:20:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38E369225;
	Thu, 18 Jun 2026 18:20:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806813; cv=none; b=LEcmQVawoCyDBffXZCjKyjHgeCbqN+ZdloGNkEkIHDT/9CRTtayudR+Zo2dWiGQVstPEM2j+RcuOFxy8pGZFVcFUv2Q6q2wmOYzzVBApJ0tHJfcA491MKhQfBu41Oyz6ixemmTTz8N0B7WPB/aLB0ZwB4qFsywSn0KxIPrhB18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806813; c=relaxed/simple;
	bh=xLHdRZoLD2+fYkct+eQOAuBYheYtdoRKbERsKRxzOJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPcOp4LYk51gLMZOZZm1CbtPhd4jzDqDXnP7hHEvPunWus1peKNycjt+/XdYDlaXmcHn8GpaR6Toaf38Z2cIUxRPNh3oX3/71cMegI9qbtqMmb9HZM55NgLIYxOWtwogMRE+vtvj2NpbfFQ7YLsjbrQBtif811b6oQr1x9SthHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YfOhqeQz; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nl4WGWLHU2nDZWMLWrJ7XgtTVp0Yzn1ezTw1CgqCOi8=; b=YfOhqeQzj9WoV+oRg3QwFhQ9jt
	CpxcX52Y91jRDKTVtVrVV8WoNUJsjKYKuhxKCWQ5IJ3VDaIvT86OqGZqrhfV0zIbNUby5ohaanAM9
	veHKDsx3ZOnsyW2V/+aBR9G/Y1SGWz24Tv7KvWmsPt8p4GORTJB0oHktohjR7Z1MnUCusjuWbkuYn
	MGTRDgJQ+xZWwgzh4rJ1O+vFXf564efpRh/HOq0YZiiH6kHYxIABUusbolD3azapkziAnrVx2/dXY
	KboJcKuC4N08JqIjCzHahTrThmMXu+TrRqSQsKx8QWMdjy8qQkAIAY2YD8lHQ4v+k7M4vfUmyEW1r
	F0simKYg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waHLS-0000000Etdk-2he3;
	Thu, 18 Jun 2026 18:20:06 +0000
Date: Thu, 18 Jun 2026 19:20:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <ajQ21kH1ZVajS2Y7@casper.infradead.org>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajP8ZTTLYkICFTO_@infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22680-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:praan@google.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:shivajikant@google.com,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[willy@infradead.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAB936A21F8

On Thu, Jun 18, 2026 at 07:10:45AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 16, 2026 at 05:23:48PM +0000, Pranjal Shrivastava wrote:
> > AFAIU, the MM subsystem explicitly ensures that every valid struct page
> > is part of a folio.
> 
> It is definitively not what the vision for the folio is, although if
> I'm not mistaken it actually is still true right now.

It's not true, eg, for slab.  While there's still a struct page there
for slab, there's no refcount and flags like PG_locked have different
meanings.  You'll get into a lot of trouble trying to treat slabs as
folios (and that will include assertions tripping).

> This whole
> area is a minefield unfortunately, and we also ran into it with
> iov_iter_extract_bvecs and the earlier block code it was extracted
> from.  Adding the relevant people and lists, but for now your best
> bet is to stick to what the block code does or even better reuse
> as much as possible of that code.

Yes.  Fundamentally, it is no business of the filesystem what the iov_iter
refers to.  We can do direct io to slab memory, vmalloc memory, memory
that doesn't have a struct page (eg iomem), or whatever we choose.


