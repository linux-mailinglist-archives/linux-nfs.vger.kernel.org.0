Return-Path: <linux-nfs+bounces-16229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA72C47B90
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 16:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58A834F4165
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8727F313265;
	Mon, 10 Nov 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWfN1z0U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1D274B44
	for <linux-nfs@vger.kernel.org>; Mon, 10 Nov 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789370; cv=none; b=OBPLKykrrVN/p9pBsgz9UY1UMxnUA+vDn1+mOYq1TWU/4HkJcYlqz3e+quaW17btG6pbafoj8NvqB4Jj2KQKSt/NQma4KKPsjxTUen33Mqzn53flcDQUqb5WIqz+C+0a+9O+CTjBvW/WZs4BE7g79tLcJZTelhME/lA5kB7jAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789370; c=relaxed/simple;
	bh=vaICFfoDd4CY6H1Mvlf8Fun3GJrzUqXMbMipPP333tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIqD/Epi+olscUUY+ltI1WLymGsQkIKmDeDD16iyfYPn5rAcVB9sIswDTAU/187E005bYWjvMA9B8q8dZxvlwC2aWsEs7jYenqVflaGvz/mTGDTD3qOaFJOrQP17GnJ6Plby2zeKKLdQM+v88UP7inYPpoQtqUgWi/hPxcF3yQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWfN1z0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8B3C116D0;
	Mon, 10 Nov 2025 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789370;
	bh=vaICFfoDd4CY6H1Mvlf8Fun3GJrzUqXMbMipPP333tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWfN1z0URJh1Vu/IOIGRA9CAUpuKteyrj2qexwTwEgtRwaZLZEmH8dP9LMK2bkUMD
	 oQ6Pse53npuFCKWkKh0dqLW0VolSQfOKUpWWhgxrbLwhcTw/5wuabJnRu6E/izboyd
	 V2hXsdIDtxTGcAVSoxuwCT+unYgos/UuXu+AqvW/hzQdLwubYPawAEeKgQaBEFuMjh
	 OIbqZMOi1Xw/aQEsA+yERRFY3S4nUVLQLMt9AKo1+aQKUXt0CdZ+gxG+W4Fhk6f6Yk
	 UuSQxQBSn50n0nLH+2QL6m8oLkPeE51IyHaCPiBi2KCyrUe3atjWsn3IW7dS7AG0D9
	 S6kco9zQuqgKA==
Date: Mon, 10 Nov 2025 10:42:48 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRIH-ClvzCdoIaqz@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>
 <aQ5vu47II-ZiFsmt@kernel.org>
 <aRGsgQPe6lktLG2W@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGsgQPe6lktLG2W@infradead.org>

On Mon, Nov 10, 2025 at 01:12:33AM -0800, Christoph Hellwig wrote:
> On Fri, Nov 07, 2025 at 05:16:27PM -0500, Mike Snitzer wrote:
> > Those ends lend themselves to benefitting from more capable RMW
> > if/when needed.
> 
> How are ends of a larger I/O inhently more benefits from cached
> RMW then say a single tiny I/O?

Any unaligned WRITE, no matter the size of the WRITE, will benefit
from RMW of its subpage ends if streaming unaligned WRITEs.

I saw below that even saying "unaligned WRITE" leaves you annoyed.
And time subpage ends are being issued by this code then they are part
of a larger "unaligned WRITE" that was able to be split and have up to
3 segments: unaligned subpage ends and a DIO-aligned middle.

> > All it takes to justify not using DONTCACHE is one
> > workload that benefits (even if suboptimal by nature) given there is
> > no apparent downside (other than requiring we document/comment the
> > behavior).
> 
> Well, the entire reason for this patchset is the downside of cached
> buffered I/O, isn't it?  Now suddently there's no downsides?

Every time I say stuff like "the entire reason for the patchset" I set
myself up for a rebuttal from you.  You just did the same thing.  I'm
going to try to be accomodating and cool but please lets dial back
this weirdly caustic dynamic that is forming yet again.

Why is it that you cannot acknowledge that it isn't an all or nothing
situation?  This isn't hard to see, there is clear benefit from using
cached buffered for the misaligned subpage ends of an unaligned WRITE
that can be split into 3 segemnts.

I provided the benchmark result that shows significant performance
improvement and Chuck pointed it out to you in another thread:
https://lore.kernel.org/linux-nfs/aQrsWnHK1ny3Md9g@kernel.org/

And I do understand Chuck's point of "but do we care about streaming
misaligned WRITE"?  Given the code needs to simply use cached buffered 
IO instead of DONTCACHE for at most 2 individual pages I think it does
make sense to handle it.

Again, its niche but its easily handled and there certainly is benefit
to be had.

Restating an important point underpinning my desire to handle this
niche unaligned streaming WRITE case efficiently: it removes the one
case I know of where NFSD_IO_DIRECT cannot compete with
NFSD_IO_BUFFERED. Whereby making NFSD_IO_DIRECT a compelling
alternative default IO mode.  To leave it to use DONTCACHE would be
purposely compromising NFSD_IO_DIRECT to be less effective.

I'm also saying: there is very limited downside to using cached
buffered for these subpage end segments.  But IF I'm proven wrong and
they do show themselves to be a problem in the future then a code
change will be needed.

> Also to go back to my previous mail:  How can an I/O that is aligned
> in file offset and length, but not in the backing memory ever going
> to benefit from this caching?

It wouldn't, because it would take the no_dio path and the entire IO
would be issued using DONTCACHE.

That I just had to point that out shows how absurd all this contrarian
hand-wringing has gotten.

> > Or is this something we make tunable?
> > NFSD_IO_DIRECT_DONTCACHE_UNALIGNED?
> 
> Throwing in yet another tunable while not understanding the problem
> at hand is about the worst possible outcome.

Just because you don't understand something: that isn't my failing.
So your need to be the expert here is misplaced.  Please show you
understand the problem before you project lack of understanding onto
me.

> > Streaming misaligned WRITEs is the only workload I'm aware of where
> > NFSD_IO_DIRECT can be made noticably worse in comparison to
> > NFSD_IO_BUFFERED (but I haven't done a bucnh of small IO testing).
> > That's a pretty good place for NFSD_IO_DIRECT given the fix is a
> > really straightforward tradeoff decision.
> 
> Can we please stop talking about "misaligned" as a generic thing, when
> there is two very clearly different cases of misalignment.

Sure misaligned/unaligned WRITE is the NFS WTITE operation includes a
payload that is misaligned.  Further categorizaiton is done to
determine of a given WRITE can benefit from being split.

If the WRITE can be split such that the middle is DIO-aligned then it
benefits from using cached buffered for the subpage end segments.

