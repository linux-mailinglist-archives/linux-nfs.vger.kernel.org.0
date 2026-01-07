Return-Path: <linux-nfs+bounces-17583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F2CFFEDA
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 21:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774B83135CE4
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC5342CAD;
	Wed,  7 Jan 2026 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9FNnZdG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315EA327C19
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814855; cv=none; b=qRw9N+aVeiTtS9MyW9xmsB6tKOx8Gj8biO2DjgnLV5B7MfRpRDWW2MJKx9hdWIbIkBdqHey0QfqgavCdRlH8fukLTzFXeIXrQKWz15hN8yEP4xNeoM59oaRX1PLU7dggLz0DVC0dweClGJna+C7J/91u+Ps69dykpegs1XkHrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814855; c=relaxed/simple;
	bh=qRtWmWqx16YvB31e07lKlGV9NR1dsgpHTNlz3eQIZcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0Ql3nISb6Phz00eyZfeQ7wU9gnOg5O7exVrFQCB6ZJlRABRNdDQ50UU/mxcKxplQKctyxQBBQ5SpnYOCUI+5ssDZvbpOK8pQ3zobjR3A6KwVyjKYcJru1Ia5ujtSMsHaezyTOCE5Wu+jwIxBVQvWANRvdrQo8f2R/b1vRhQJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9FNnZdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB8CC19422;
	Wed,  7 Jan 2026 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767814854;
	bh=qRtWmWqx16YvB31e07lKlGV9NR1dsgpHTNlz3eQIZcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9FNnZdGNMadrWmXcutouRFrm6A7CJTvDO6HQIsCL45Ep8EuJ7/gLbm8hFqfAW924
	 yjDX7QYuNJlkSpXPG+Z4t32YkHvr8a6o+cFAiPqXzLrsl651gCgkn23BaTlpS668ro
	 lB7iIm1Pf03qxVsbV/dWIx5XtXGQoz/pjYr+5FUaawRkWEOxk+5KdCDtdC1cGU+zhM
	 EkTinDdLsz5DypM8HHAP9+puoYCU6vBH8exsVieN5oJWr63/HVw6Y4BCMS1gd6rmVD
	 CMI4GJhLVL4uMXKB84cejv8RjhNugmba9z5e8vIMjA7ZGgwtxPTsmNuzCTkFiQYxqj
	 mNkpQyGQVL22w==
Date: Wed, 7 Jan 2026 14:40:53 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	jonathan.flynn@hammerspace.com
Subject: Re: [RFC PATCH 2/2] NFSD: Add asynchronous write throttling support
Message-ID: <aV62xd40mPWF6-_e@kernel.org>
References: <20251219141105.1247093-1-cel@kernel.org>
 <20251219141105.1247093-3-cel@kernel.org>
 <20260107080057.GB19005@lst.de>
 <cc3a3e80-7b2b-4652-811b-c2a126daf9c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3a3e80-7b2b-4652-811b-c2a126daf9c7@kernel.org>

On Wed, Jan 07, 2026 at 09:42:58AM -0500, Chuck Lever wrote:
> On 1/7/26 3:00 AM, Christoph Hellwig wrote:
> > On Fri, Dec 19, 2025 at 09:11:05AM -0500, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> When memory pressure occurs during buffered writes, the traditional
> >> approach is for balance_dirty_pages() to put the writing thread to
> >> sleep until dirty pages are flushed. For NFSD, this means server
> >> threads block waiting for I/O, reducing overall server throughput.
> >>
> >> Add support for asynchronous write throttling using the BDP_ASYNC
> >> flag to balance_dirty_pages_ratelimited_flags(). When enabled via:
> >>
> >>   /sys/kernel/debug/nfsd/write_async_throttle
> > 
> > Let me reiterate that I really, really hate all this magic debugs-fs
> > enabled features.  Either they are gnuinely useful (think this would
> > be such a thing) and they should be enabled unconditionally, or they
> > are tradeoffs and should have a proper tunable not hidden in debugfs.
> 
> The use of debugfs here is because we don't yet have a coherent design
> in mind -- this new facility is entirely experimental, and we need a
> way to enable and disable it to make good comparisons, without making
> immutable changes to the actual NFSD administrative interface.
> 
> "The RFC sign out front should have told ya."
> 
> But I agree, in the long term I most prefer no new administrative
> controls -- it should just work if at all possible.
> 
> 
> >> NFSD checks memory pressure before attempting buffered writes. If
> >> balance_dirty_pages_ratelimited_flags() returns -EAGAIN (indicating
> >> memory exhaustion), NFSD returns NFS4ERR_DELAY (or NFSERR_JUKEBOX for
> >> NFSv3) to the client instead of blocking.
> >>
> >> This allows clients to back off and retry rather than having server
> >> threads tied up waiting for writeback. The setting defaults to 0
> >> (synchronous throttling) and can be combined with write_throttle for
> >> layered throttling strategies.
> >>
> >> Note: NFSv2 does not support NFSERR_JUKEBOX, so async throttling is
> >> automatically disabled for NFSv2 requests regardless of the setting.
> > 
> > This all seems very useful to me.  But it really needs to show numbers
> > on how it helps.
> 
> Well if I can get this into operational shape, perhaps J. Flynn would
> be interested in trying it out for us.
> 
> I'm happy to run with this one and drop (or postpone) 1/2, if that is
> your assessment.

Probably a good start.  Definitely looks useful and worth measuring to
see if buffered IO improves.

I can include it in a test kernel for Jon Flynn once you're happy with
the patch and would like further testing (fyi I've rebased to latest
6.18-stable but Jon hasn't done baseline testing of it yet, so we
could kill 2 birds once ready).

Thanks,
Mike

ps. Jon, for further context see Chuck's original 2/2 patch:
https://lore.kernel.org/linux-nfs/20251219141105.1247093-3-cel@kernel.org/

And his cover letter:
https://lore.kernel.org/linux-nfs/20251219141105.1247093-1-cel@kernel.org/
Also patch 1/2, but consensus seems to be "focus on 2/2 first":
https://lore.kernel.org/linux-nfs/20251219141105.1247093-2-cel@kernel.org/

