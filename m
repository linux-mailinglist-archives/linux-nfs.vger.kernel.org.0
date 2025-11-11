Return-Path: <linux-nfs+bounces-16238-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF92C4C71D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 09:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD453B4D93
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162F2FA0F2;
	Tue, 11 Nov 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UaZJMSXw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59492773F4
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850705; cv=none; b=ARfL+HdYOOAkCnomOGrpA0UYFxIl3oFPO3DmNe8hjMHzSsUBb8hsKBXEnkGJwqJyUUAQ1kmzQPTrzKU/hxv9Nys4F2ls++DBobD/CFS53ZAKFexpb4ioToXor0WCL0QDeeYlnGC5ojXWc6M4YgseEBLpDSiVREQNaQaXXsxyHE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850705; c=relaxed/simple;
	bh=7UIv0REVMPsR6TeO6DtT3RXaZCq5vg2DTU2XtMGVAkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1kjTrf3FrDaZcd73ihbZgynawGeInp17qXSJYFJ2tFvPjiXbUeN4tQoqt18Ao1qHA7M+wM19V1SKO+pxZY3JcQdLWNtBuA+2PjlDOHcH2V6g+Tba1QRNg3T3JIxRd5Oh04G47HmgJORVKSWKWaTjWzgC2jf/tQ3GtR+6W8Lz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UaZJMSXw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=np4snkbLuZln5nv1QHe642a/ScNlfpDqyy8rcO6LL2o=; b=UaZJMSXw1mm+DV4HAgnOFoU42h
	Y8Ri6jQIYhZQl0r5OJIWQWOIeHS+gzhfJfXLIaeLUtVDQiW8hpZ1fJetpHzHvcsSxXDDG1K4IzAz6
	RXPp57fQ6fU3iyOD+XC8vDbFYmHP2fXxmpjfhyoNp6ULHdcHsQHsp+CxCI629vi5g9Jzpz3s9X+Ek
	EzlhhhooqiA4hkR1Xms++WWGVxKMCF5PjrNTW7GL+aVjmcxkLfzaHwBwYfl0Qui9ygXJNqq7sVz/f
	HF8fsvj/yEPJcbE2O8AfVYh5ZZkAAz2I2wK8ZEehkFdyCZUhyCMK9DYz8teMTKsa6LE9ZVin6JKI2
	DYulKv8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIjzm-00000006nco-2QoL;
	Tue, 11 Nov 2025 08:44:58 +0000
Date: Tue, 11 Nov 2025 00:44:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRL3imaw47ovSy7H@infradead.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>
 <aQ5vu47II-ZiFsmt@kernel.org>
 <aRGsgQPe6lktLG2W@infradead.org>
 <aRIH-ClvzCdoIaqz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRIH-ClvzCdoIaqz@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 10, 2025 at 10:42:48AM -0500, Mike Snitzer wrote:
> On Mon, Nov 10, 2025 at 01:12:33AM -0800, Christoph Hellwig wrote:
> > On Fri, Nov 07, 2025 at 05:16:27PM -0500, Mike Snitzer wrote:
> > > Those ends lend themselves to benefitting from more capable RMW
> > > if/when needed.
> > 
> > How are ends of a larger I/O inhently more benefits from cached
> > RMW then say a single tiny I/O?
> 
> Any unaligned WRITE, no matter the size of the WRITE, will benefit
> from RMW of its subpage ends if streaming unaligned WRITEs.

Yes.

> I saw below that even saying "unaligned WRITE" leaves you annoyed.

No, it doesn't.

> Every time I say stuff like "the entire reason for the patchset" I set
> myself up for a rebuttal from you.  You just did the same thing.  I'm
> going to try to be accomodating and cool but please lets dial back
> this weirdly caustic dynamic that is forming yet again.
> 
> Why is it that you cannot acknowledge that it isn't an all or nothing
> situation?

I'm actually arguing for that, not you.  You make claims of "the entire
reason", not me.


> Restating an important point underpinning my desire to handle this
> niche unaligned streaming WRITE case efficiently: it removes the one
> case I know of where NFSD_IO_DIRECT cannot compete with
> NFSD_IO_BUFFERED. Whereby making NFSD_IO_DIRECT a compelling
> alternative default IO mode.  To leave it to use DONTCACHE would be
> purposely compromising NFSD_IO_DIRECT to be less effective.
> 
> I'm also saying: there is very limited downside to using cached
> buffered for these subpage end segments.  But IF I'm proven wrong and
> they do show themselves to be a problem in the future then a code
> change will be needed.

So spell them out in a comment, and leave nuggets for future readers.
And explain why they don't apply for a single segment this is not
page aligned by either being smaller than a page or straddling two
pages.

> 
> > Also to go back to my previous mail:  How can an I/O that is aligned
> > in file offset and length, but not in the backing memory ever going
> > to benefit from this caching?
> 
> It wouldn't, because it would take the no_dio path and the entire IO
> would be issued using DONTCACHE.

Yes, I see that right now it does not.  But I want to hear from you
why you think it is worth treating different.  Because there is no
rationale that a small unaligned write won't benefit from it.  In fact
all conventional wisdom suggest it will benefit even more.  And I'm
trying to explain that for a few days now, but somehow it doesn't make
it across.

> 
> That I just had to point that out shows how absurd all this contrarian
> hand-wringing has gotten.

Can you please top these attacks?

> 
> > > Or is this something we make tunable?
> > > NFSD_IO_DIRECT_DONTCACHE_UNALIGNED?
> > 
> > Throwing in yet another tunable while not understanding the problem
> > at hand is about the worst possible outcome.
> 
> Just because you don't understand something: that isn't my failing.
> So your need to be the expert here is misplaced.  Please show you
> understand the problem before you project lack of understanding onto
> me.

Well, if you do understand it you failed to explain it, which means
there it no _collective_ understanding.  But to me this thread suggests
you don't understand it either, although I'd rather get to the bottom
of it then getting stuck on who understands what.


