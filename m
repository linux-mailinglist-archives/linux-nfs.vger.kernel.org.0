Return-Path: <linux-nfs+bounces-16226-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6273C4595F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 10:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A742218909FD
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D01E47C5;
	Mon, 10 Nov 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0i3vdgm5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539F222562
	for <linux-nfs@vger.kernel.org>; Mon, 10 Nov 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766243; cv=none; b=uHMn+kbU/DQcUQ7SiL8u4flzS9Y20fXIfh9H9CSC5se5DTt0NZsJaAWt/WoJMXQcZ3eADaT1yC+KVfAd2qQPGyC2Rc6sUhY9kO1uh0uby1IcXNmgSXl7kfQJExqWV5N16UnuQ0WaiTu/GS/z92suxiUnwUSj0hEk2iJkmQemx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766243; c=relaxed/simple;
	bh=CNjbvM6APabuTzXMto6cgW+w5NOKo5bis9v8acg7djA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGqPpg16jHUFazOxHC34LGVAQLMLASVBza8htBcQUN9rQq6uuUWfT0Jex5cekhvSN5Z7fuqJdH7U3OwknpvqHqeQPPTyJpSciXHwyLdSA1Ehh32HZtghy0i2dMTMWfX1c1WNCF7IH0b/mTuKmgc8OqO9NrAnKWVLGxFw552K8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0i3vdgm5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PrEM98sztzW4nZEjAScHMciMt8gLQlc7ke3NU+Iaro0=; b=0i3vdgm5fLtUY8ujbfwQlNotZK
	leru8TeuXIqmcowH2ZGOd8nq5HLKyB5U+HDhFv0+3//iE4+NwyeRlZuvAXbbGWMUznpExdAAsrwdK
	iHkSHklJPch0kpvZug0xAyxfvD2qE2bpSUa2ajLdV4sA/l0i09xKJGu2hERJc3qC1iswNzaCzN+gS
	dnjp8fQWM8rmm0QHa5TrHn5uDVrTnqhDLikiFDUY48w/sq9w2wr92ZkX2EDB75eNJ1C72kAa7Fb+N
	cANK6QXpMKUK7i50YrrlE6X7Pio0FHTjM7v+MTsq/L6jC0Uf29QYkdZhodtBsQsRkryMZdCwzOK30
	PUzg266Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIO1X-000000054Ys-1uuU;
	Mon, 10 Nov 2025 09:17:19 +0000
Date: Mon, 10 Nov 2025 01:17:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRGtn90M8ktOCOnv@infradead.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 07, 2025 at 03:28:06PM -0500, Chuck Lever wrote:
> +1 for an explanatory comment, but I'm not getting what is "counter-
> intuitive" about leaving the content of the end segments in the page
> cache. The end segments are small and simply cannot be handled by direct
> I/O.

The downside if of course extra page cache usage / pollution.  If these
segments are aligned to the file system minimum I/O size, but not to
the memory requirements there is not going to be any RMW cycle that
leaving them in the page cache for would be useful.

Similarly if the single segment is not aligned in the file logic space,
chances of having another RMW come in are the same as for a large
one with unaligned head and/or tail.


