Return-Path: <linux-nfs+bounces-22854-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R/6DEKUiPmopAQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22854-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 08:56:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928306CAC62
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 08:56:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=oE0R1mHt;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22854-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22854-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C7D3055C20
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 06:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243E3D25D2;
	Fri, 26 Jun 2026 06:56:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C603C81B6;
	Fri, 26 Jun 2026 06:56:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456971; cv=none; b=spwMNL98zewhv+BndPSld4fIsPCiO1M7HkGm0LdUhyWAE4b8V2MQ6YgvmWKybLX3PyyF8rxjyJAfHmeM0DRsRHxcjOCoUFUYl7EX7pSZRU3THz4+eYOdw72vThTDOqQlQtHqAO2saJHV5AspWr+9yFAI+NfKjsAFJR4dso6s4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456971; c=relaxed/simple;
	bh=yezrCFzO71TPwm2h8+iILfzWV/U5Q1xUQS0/AfZR30E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcWgdwJR0bGUfXeHMBIVfhn5mn/RWTZ5SmbNwCFciDL5zv/4ftcUfKfhfrIU23Zh/BDrU7e+t5B0CjbHJ+RYMMZfSFLM2PlD43Z7mKkEWTSPyQF3K2sF8bRPX9Jl5yc1+DVX8je0MtTU5tw7Rtq3NA9v6G24vJduMskJVDROS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oE0R1mHt; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qIfqsHd8ihBL61AqZDeOTYBP79ZhHNbdbCAc3Fu49SM=; b=oE0R1mHtR3UXS9T7lQ20Rhwr2d
	20/URBEfimgv+uBo56GHhEJ11yy+9fctdNtV8gU9k9J5xa4+4MIc1BNhxCxFszd5dWAJV4v3ymPje
	hYfex1zfEszdXuwxfrvu2rFtP1DkuQbk88f7GvXL4eSR52I24d84YQaGmWQSUm6ahjnLHeBDc57eB
	MZqqsiQ8juwt6FJ+rnafE+VHGjfWhnffMAE88DJ8rqW+t1b8/LungKkSw9PmNzODQZmtpvzlftdsY
	RkUOEYZAQ4Rtc5WQIddP6zgUDWRqwVDxkWPCkUc1wjO9Kg9xESwCZnAHnFvrxwrbUTlvF5bdSHMqU
	AkcErr9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Tw-0000000AdCL-2EAR;
	Fri, 26 Jun 2026 06:56:08 +0000
Date: Thu, 25 Jun 2026 23:56:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <aj4iiD5C_yyLeb3U@infradead.org>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQ21kH1ZVajS2Y7@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22854-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:willy@infradead.org,m:hch@infradead.org,m:praan@google.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:shivajikant@google.com,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 928306CAC62

[sorry, dropped the ball a bit on this due to overload]

On Thu, Jun 18, 2026 at 07:20:06PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 18, 2026 at 07:10:45AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 16, 2026 at 05:23:48PM +0000, Pranjal Shrivastava wrote:
> > > AFAIU, the MM subsystem explicitly ensures that every valid struct page
> > > is part of a folio.
> > 
> > It is definitively not what the vision for the folio is, although if
> > I'm not mistaken it actually is still true right now.
> 
> It's not true, eg, for slab.  While there's still a struct page there
> for slab, there's no refcount and flags like PG_locked have different
> meanings.  You'll get into a lot of trouble trying to treat slabs as
> folios (and that will include assertions tripping).

True.  But also not relevant for direct I/O user pinning.  If we stopped
having valid folios for anything mapped into userspace,
iov_iter_extract_bvecs would run into problems, and we had the discussion
before that at least right now it would be hard to fix.

Also if iov_iter_extract_bvecs was used on kvec or bvec iters we could
run into the slab problem.  The block usage currently makes sure bvec
iters are not handed to iov_iter_extract_bvecs, but there is no such
thing for kvec vectors, although no one is using them for direct I/O
right now.  Not that I'd want to rely on that in the long run.


