Return-Path: <linux-nfs+bounces-13079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824AB061FB
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21C95066AD
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07079186294;
	Tue, 15 Jul 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goeVrDr5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EE1E1DEC
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591011; cv=none; b=MNlT6u86/YgiTkm3jiqNyn2sYHzYUCEJCZbm0eYyBonrDOyRX/vd7fM+v26/WG0KW2l+Eb/+tBGMRPUFggoeU2R/4qS0IYrr0L+IzWSNrKOUX6Vt16IMYtGua6gssvHYScitAaxQn9N3mwKzcuJSKu9BBisPz41gmIUk1CI9s2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591011; c=relaxed/simple;
	bh=Xqv/Iu44Xm0Nb7KWV8KjXAJrWIm1ZMAcQF5lpPdBW5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKRiI/SBbv/N3HRF4GgHtot1BVOT9nBSo8Q7+HpxQcouQQrvrV69kLo6I7r1iw2v4Jmx3ouf25FdBwi5iVW9urG2kl7GsSPdq2ERz62uH6wUhRNAcUcQz4PiobvwogKWOam4dvUx+oA9RfcbeXfxQnDM/ihXm/NIYLorJ0RXhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goeVrDr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B27BC4CEE3;
	Tue, 15 Jul 2025 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591011;
	bh=Xqv/Iu44Xm0Nb7KWV8KjXAJrWIm1ZMAcQF5lpPdBW5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goeVrDr5qA/tKHkClNmcDUu8HtjQKZbAXsDeJ93kCeEPZlwwnGYSF5aPCMixz6tP8
	 FAlpmOn4OFP3msDPSeRyvpgCLZQHaat72KCVoMNkz9zl59VtlkI4elJgaPpMmgqkd9
	 Y99HcRD4viujwfj2oNe635txt2kKlWk8OQZ3KJ4jPOITQm3gqDDEERczynGoXijbpI
	 +pDqJcvzf1bvTqyhFHJ/leZ2vS2LGoymgLtt1tofcoRtJQmXZltIfF+LvG9XAB81wT
	 juNDbjegtY6jqlexg+nzxEvUn7CcuM+0oS20Gzr5NZM//mZ7qgyztwytT3ZkA3AbcN
	 OidxdvFRllgvg==
Date: Tue, 15 Jul 2025 10:50:10 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO
 modes
Message-ID: <aHZqouReZXmD-ql6@kernel.org>
References: <20250714224216.14329-1-snitzer@kernel.org>
 <ef2837a6-1551-4878-a6da-99e9bc6d1935@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2837a6-1551-4878-a6da-99e9bc6d1935@oracle.com>

On Tue, Jul 15, 2025 at 09:59:05AM -0400, Chuck Lever wrote:
> Hi Mike,
> 
> There are a lot of speculative claims here. I would prefer that the
> motivation for this work focus on the workload that is actually
> suffering from the added layer of cache, rather than making some
> claim that "hey, this change is good for all taxpayers!" ;-)

Really not sure what you're referring to.  I didn't make any
speculative claims...

> On 7/14/25 6:42 PM, Mike Snitzer wrote:
> > Hi,
> > 
> > Summary (by Jeff Layton [0]):
> > "The basic problem is that the pagecache is pretty useless for
> > satisfying READs from nfsd.
> 
> A bold claim like this needs to be backed up with careful benchmark
> results.
> 
> But really, the actual problem that you are trying to address is that,
> for /your/ workloads, the server's page cache is not useful and can be
> counter productive when the server's working set is larger than its RAM.
> 
> So, I would replace this sentence.

Oh, you are referring to Jeff's previous summary.  Noted! ;)

> > Most NFS workloads don't involve I/O to
> > the same files from multiple clients. The client ends up having most
> > of the data in its cache already and only very rarely do we need to
> > revisit the data on the server.
> 
> Maybe it would be better to say:
> 
> "Common NFS workloads do not involve shared files, and client working
> sets can comfortably fit in each client's page cache."
> 
> And then add a description of the workload you are trying to optimize.

Sure, certainly can/will do for v4 (if/when v4 needed).
 
> > At the same time, it's really easy to overwhelm the storage with
> > pagecache writeback with modern memory sizes.
> 
> Again, perhaps this isn't quite accurate? The problem is not only the
> server's memory size; it's that the server doesn't start writeback soon
> enough, writes back without parallelism, and does not handle thrashing
> very well. This is very likely due to the traditional Linux design
> that makes writeback lazy (in the computer science sense of "lazy"),
> assuming that if the working set does not fit in memory, then you should
> simply purchase more RAM.
> 
> 
> > Having nfsd bypass the
> > pagecache altogether is potentially a huge performance win, if it can
> > be made to work safely."
> 
> Then finally, "Therefore, we provide the option to make I/O avoid the
> NFS server's page cache, as an experiment." Which I hope is somewhat
> less alarming to folks who still rely on the server's page cache.

I can tighten it up respecting/including your feedback.  0th patch
header aside, are you wanting this included somewhere in Documentation?

(if it were to be part of Documentation you'd then be welcome to
refine it as you see needed, but I can take a stab at laying down a
starting point)

> > The performance win associated with using NFSD DIRECT was previously
> > summarized here:
> > https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> > This picture offers a nice summary of performance gains:
> > https://original.art/NFSD_direct_vs_buffered_IO.jpg
> > 
> > This v3 series was developed ontop of Chuck's nfsd_testing which has 2
> > patches that saw fh_getattr() moved, etc (v2 of this series included
> > those patches but since they got review during v2 and Chuck already
> > has them staged in nfsd-testing I didn't think it made sense to keep
> > them included in this v3).
> > 
> > Changes since v2 include:
> > - explored suggestion to use string based interface (e.g. "direct"
> >   instead of 3) but debugfs seems to only supports numeric values.
> > - shifted numeric values for debugfs interface from 0-2 to 1-3 and
> >   made 0 UNSPECIFIED (which is the default)
> > - if user specifies io_cache_read or io_cache_write mode other than 1,
> >   2 or 3 (via debugfs) they will get an error message
> > - pass a data structure to nfsd_analyze_read_dio rather than so many
> >   in/out params
> > - improved comments as requested (e.g. "Must remove first
> >   start_extra_page from rqstp->rq_bvec" was reworked)
> > - use memmove instead of opencoded shift in
> >   nfsd_complete_misaligned_read_dio
> > - dropped the still very important "lib/iov_iter: remove piecewise
> >   bvec length checking in iov_iter_aligned_bvec" patch because it
> >   needs to be handled separately.
> > - various other changes to improve code
> > 
> > Thanks,
> > Mike
> > 
> > [0]: https://lore.kernel.org/linux-nfs/b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org/
> > 
> > Mike Snitzer (5):
> >   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
> >   NFSD: pass nfsd_file to nfsd_iter_read()
> >   NFSD: add io_cache_read controls to debugfs interface
> >   NFSD: add io_cache_write controls to debugfs interface
> >   NFSD: issue READs using O_DIRECT even if IO is misaligned
> > 
> >  fs/nfsd/debugfs.c          | 102 +++++++++++++++++++
> >  fs/nfsd/filecache.c        |  32 ++++++
> >  fs/nfsd/filecache.h        |   4 +
> >  fs/nfsd/nfs4xdr.c          |   8 +-
> >  fs/nfsd/nfsd.h             |  10 ++
> >  fs/nfsd/nfsfh.c            |   4 +
> >  fs/nfsd/trace.h            |  37 +++++++
> >  fs/nfsd/vfs.c              | 197 ++++++++++++++++++++++++++++++++++---
> >  fs/nfsd/vfs.h              |   2 +-
> >  include/linux/sunrpc/svc.h |   5 +-
> >  10 files changed, 383 insertions(+), 18 deletions(-)
> > 
> 
> The series is beginning to look clean to me, and we have introduced
> several simple but effective clean-ups along the way.

Thanks.

> My only concern is that we're making the read path more complex rather
> than less. (This isn't a new concern; I have wanted to make reads
> simpler by, say, removing splice support, for quite a while, as you
> know). I'm hoping that, once the experiment has "concluded", we find
> ways of simplifying the code and the administrative interface. (That
> is not an objection. call it a Future Work comment).

Yeah, READ path does get more complex but less so than before my
having factored code out to a couple methods... open to any cleanup
suggestions to run with as "Future Work".  I think the pivot from
debugfs to per-export controls will be perfect opportunity to polish.

> Also, a remaining open question is how we want to deal with READ_PLUS
> and holes.

Hmm, not familiar with this.. I'll have a look.  But if you have
anything further on this point please share.

Thanks,
Mike

