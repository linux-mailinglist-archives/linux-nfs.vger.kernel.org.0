Return-Path: <linux-nfs+bounces-15801-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3990C21208
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 17:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AA514ED842
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BB3366FCB;
	Thu, 30 Oct 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1TL2tOj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCFB366FC7
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840988; cv=none; b=qF5+B04szutjxGB/Wog3WjAm8cNEltYJDkvWlwiZTnSB/KJmo8Z9XqPe5kjRUuOzuI+jfJv0nAmduzILNZE4T/xSayk7CSrMBlCbcE4/onm1/Xj6hrFyxxhKHHCB4Vq8sjvbq2qOW21BGczF/NRHaC4QYoqApHkBQaCbskUiA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840988; c=relaxed/simple;
	bh=Ae/G1Qkh+5WZGdivEopx6GEFs0bp0GzCFzdt7E7LJlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo7ZXjc8wtFCnoMEFquL4nLhtWJkAN5lh0eYf6sKFmd/bwCiKNkABltqnFOAJ2uFS4UCTIoYAdVuyeoQUJ4K1n0yf0hOXRECxGcxuti41/7Ai56UYypcIc68iIu1xHH/hn0v06qRUM61WcFT/1ONHJLn8VOV0wqGh9pexy5j8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1TL2tOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1191C4CEF1;
	Thu, 30 Oct 2025 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761840988;
	bh=Ae/G1Qkh+5WZGdivEopx6GEFs0bp0GzCFzdt7E7LJlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1TL2tOjAS1/RT2YepzFODj8Fg1itPhrgyBzkKlZ6dFAtkTaGlOwfic8vMYF7s/q3
	 P5uK5ffLIG2RIu7pLgnDH24rnu8Pl69gJIMgAsUKsk3mlld/9rQPrQJMtNR0x641lq
	 hR3wEzX6KOHP3Jw8mJGGCl35M4930aJ3C4t8DO1SbLApz6Dt3XfhXU7is3JkrSj5Ii
	 oWeh6A55bAzpPwrhb2tMUGK5tERjs4/Ka/yr7WwyP2fhwkmaZGT1DtkedqDuI3Ih4L
	 mh+4sRdEaX3CLZWOZu+krG+sPoJByuXG4eqfLjFc/BLN4s9d6HKi7m60JVWgo8/aMW
	 lWePI7MtmwguA==
Date: Thu, 30 Oct 2025 12:16:26 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Add a "file_sync" export option
Message-ID: <aQOPWnL7pvQUSFCD@kernel.org>
References: <20251030125638.128306-1-cel@kernel.org>
 <aQN0Er33HIVmhBWh@infradead.org>
 <aQOFLMJzUZuwj_K7@kernel.org>
 <aQOIJtjQvLjBNk3G@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQOIJtjQvLjBNk3G@infradead.org>

On Thu, Oct 30, 2025 at 08:45:42AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 30, 2025 at 11:33:00AM -0400, Mike Snitzer wrote:
> > Sure, but not all modern networks have the same level of performance
> > either.  When the NVMe is faster than the network we don't see nearly
> > as much MM pressure.  But that implies the network is the bottleneck, so
> > reducing network operations (like COMMIT) should reduce network
> > traffic (even if marginally).
> 
> There is a lot of code between the network and the storage, and they
> tend to be slower than either for many common workloads :)

I've been pretty impressed with how NFS, and surrounding Linux IO
stacks (network and storage), is able to keep up with really fast
hardware.

> > Once the network is as fast or faster than the NVMe devices, that's
> > when we've seen VM writeback/reclaim with buffered IO become
> > detrimental (when the working set exceeds system memory by a factor of
> > 3:1).  And that's where NFSD_IO_DIRECT mode has proven best.
> 
> I bet that getting VM writeback out of the stack helps at lot.  But as
> mentioned I doubt forcing stable writes helps, and in fact for most
> workloads will actually make it slower.  But that's just my experience
> from similar but not the same things, so I'd love to see numbers if
> you suspect something else.  Either way we're much better off changing
> one variable at a time instead of forcing two totally unrelated changes
> to go together.

Yeah.  I'd have split them out to new variants of NFSD_IO_DIRECT,
e.g.:
NFSD_IO_DIRECT_DATA_SYNC
NFSD_IO_DIRECT_FILE_SYNC

But using a proper export option to control stable_how entirely
independent of the chosen NFSD_IO mode is more useful.

> > Christoph, if you have canned benchmarks that do a solid job of
> > showcasing overwrites (which you expect to really benefit from _not_
> > having DSYNC or DSYNC|SYNC set) please let me know.
> 
> None with nfs in the loop.  For an older benchmark with purely
> local I/O, 3460cac1ca76215a60acb086ebe97b3e50731628 has an example,
> which should be pretty representative for modern workloads, even if
> the overall numbers for each case would improve a lot.

Even if not for NFS, we can run NFS client using O_DIRECT which
should drive the IO so NFSD receives it much like the application
issued it (albeit wrapped in XDR and NFS protocol).  And if using
NFSD_IO_DIRECT we should then be able to assess how/if changing
stable_how impacts performance.

