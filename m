Return-Path: <linux-nfs+bounces-16225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13047C4589A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D58324E1EB8
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B941E492D;
	Mon, 10 Nov 2025 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eF5gF9fs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD312E8B8A
	for <linux-nfs@vger.kernel.org>; Mon, 10 Nov 2025 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765960; cv=none; b=BKEZazBWzGVtepyeOYG2apMM7zXXYl5GerajVs9Gnl3vJHYi5JOIrfFXbqY0OrzZ9oI+MrBL0POn/JdEl2OKPfhZ0HTSdBf4lE+dz4VSl43Xbr/8aIuSCGNLzvyj72xfngFV+7hOOdHaQXmJzYIavJaE2dzWYvQOZSE4bsu1Bt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765960; c=relaxed/simple;
	bh=LRbqX3SA+wdc8PYz+6Ulok5MLuFQWkoxeIrMrx0bAMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHtNuIW8G0D2if+pMKs7/dny/aU2WeW6wsM4GX9g3yDYy0uP/Kf+Z7DMxD9vDPx/o7Rd6dwhJ+BzCbPj9TPCDG++/eGh6HYXNfuGOl0eMrce+vtabOrsfZ0zLlTaVmvSVzpqsDiG0FeJDjRMzaxQ1c9Pl3amwjDDeN6ibG21Jic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eF5gF9fs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UGza+CfjZtVK7iMi4h3Cl5LhK9vV9rdmJuPIX5dMVqk=; b=eF5gF9fs91TBJKP/XnHRZKLvxs
	GAEdSItX5KAIZCH4jbIYfEB4zuoCS3WC+g6SSUe4fbdyuquSGY5YNHm0oMA6WMtzCwcyJl8lG1sG9
	kn9Ac/9LX41Tie2RmCEBV7YqXkB/TE6s5c8NC9gmm3Oq4cLsexAKhpVEin2NWE/4999nqppOdq5Uz
	zd6dRuh6b8TZaaac11ZI6KhI1DNBjGGaXVVpa8Pf8Hfb2PKUeJaXhCPxmpe8RKPtTRm1SCANa4rCr
	GvkiV2P5o2ETyH/KvGmi6+gIJAe2SJc9f9ghM267DdBymfbU2/6OXQiZOs1iQH1P4zbs7IQ1qvikC
	tfyYN2lA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vINww-000000053xE-05Vl;
	Mon, 10 Nov 2025 09:12:34 +0000
Date: Mon, 10 Nov 2025 01:12:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRGsgQPe6lktLG2W@infradead.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>
 <aQ5vu47II-ZiFsmt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ5vu47II-ZiFsmt@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 07, 2025 at 05:16:27PM -0500, Mike Snitzer wrote:
> Those ends lend themselves to benefitting from more capable RMW
> if/when needed.

How are ends of a larger I/O inhently more benefits from cached
RMW then say a single tiny I/O?

> All it takes to justify not using DONTCACHE is one
> workload that benefits (even if suboptimal by nature) given there is
> no apparent downside (other than requiring we document/comment the
> behavior).

Well, the entire reason for this patchset is the downside of cached
buffered I/O, isn't it?  Now suddently there's no downsides?

Also to go back to my previous mail:  How can an I/O that is aligned
in file offset and length, but not in the backing memory ever going
to benefit from this caching?

> Or is this something we make tunable?
> NFSD_IO_DIRECT_DONTCACHE_UNALIGNED?

Throwing in yet another tunable while not understanding the problem
at hand is about the worst possible outcome.

> Streaming misaligned WRITEs is the only workload I'm aware of where
> NFSD_IO_DIRECT can be made noticably worse in comparison to
> NFSD_IO_BUFFERED (but I haven't done a bucnh of small IO testing).
> That's a pretty good place for NFSD_IO_DIRECT given the fix is a
> really straightforward tradeoff decision.

Can we please stop talking about "misaligned" as a generic thing, when
there is two very clearly different cases of misalignment.


