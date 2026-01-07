Return-Path: <linux-nfs+bounces-17553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCFECFC7D7
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A703057106
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E0C2253EF;
	Wed,  7 Jan 2026 08:01:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F726CE0A
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772863; cv=none; b=jtTyG2FyerPyrQ+yWiv7k8WSvV+Cy+OkvitTaEVAvGaLVxsSFM3pbhUkgRswuf4usPt1NsNZeNN14Yf3Fb0rLqAZG2ar74keWwLXRQABLQBT6lRB1/i9KjWUeUQ1Gjf0SMy/RDQCKObAxiHvZTsUXeuoX1STu28MMiGW8kMsYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772863; c=relaxed/simple;
	bh=TCSa8YG4IfJrnY1WhB4V7zwOe9f177OMkNr11MepGes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWaY8oAdU0k4i4gMFaTv879gjsn0TBiMsyylqjM2AFakR8pxBscnX2CxmMZcTLXWdXax6GDq28Zz0LsEGjE/CsHkWLce+815uTlzAd9Xfju1+ViJFfLMdaPNIwllSbc9XL6sDIx+3YaUgLy4q+YsvzQZTe6daLJFFvqXyxnYZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FDDD6732A; Wed,  7 Jan 2026 09:00:58 +0100 (CET)
Date: Wed, 7 Jan 2026 09:00:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 2/2] NFSD: Add asynchronous write throttling support
Message-ID: <20260107080057.GB19005@lst.de>
References: <20251219141105.1247093-1-cel@kernel.org> <20251219141105.1247093-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219141105.1247093-3-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 19, 2025 at 09:11:05AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When memory pressure occurs during buffered writes, the traditional
> approach is for balance_dirty_pages() to put the writing thread to
> sleep until dirty pages are flushed. For NFSD, this means server
> threads block waiting for I/O, reducing overall server throughput.
> 
> Add support for asynchronous write throttling using the BDP_ASYNC
> flag to balance_dirty_pages_ratelimited_flags(). When enabled via:
> 
>   /sys/kernel/debug/nfsd/write_async_throttle

Let me reiterate that I really, really hate all this magic debugs-fs
enabled features.  Either they are gnuinely useful (think this would
be such a thing) and they should be enabled unconditionally, or they
are tradeoffs and should have a proper tunable not hidden in debugfs.

> NFSD checks memory pressure before attempting buffered writes. If
> balance_dirty_pages_ratelimited_flags() returns -EAGAIN (indicating
> memory exhaustion), NFSD returns NFS4ERR_DELAY (or NFSERR_JUKEBOX for
> NFSv3) to the client instead of blocking.
> 
> This allows clients to back off and retry rather than having server
> threads tied up waiting for writeback. The setting defaults to 0
> (synchronous throttling) and can be combined with write_throttle for
> layered throttling strategies.
> 
> Note: NFSv2 does not support NFSERR_JUKEBOX, so async throttling is
> automatically disabled for NFSv2 requests regardless of the setting.

This all seems very useful to me.  But it really needs to show numbers
on how it helps.

> + * Contents:
> + *   %0: Synchronous throttling (default) - writes sleep in balance_dirty_pages()

Overly lone line.


