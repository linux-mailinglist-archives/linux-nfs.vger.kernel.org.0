Return-Path: <linux-nfs+bounces-14081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B4B46360
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 21:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455FD1C85165
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3929B77E;
	Fri,  5 Sep 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1to1YLu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC728D8E8
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099712; cv=none; b=h3INSb2nWI2uVePyv03uRS6d0f3RE3yhQ+nbzYnZ7Kbhx+OJ9/wIl13RkZG0ApXIKSNcSRDRDCYGAsWhWVfjpkfUCZf8vWrCKlwYfJWDl7PVu0GpILiwJ36pJIe/NO4G+G0is99t6oBd3nz0BN9fP9uiGiXc5HEuYkcFtmeYHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099712; c=relaxed/simple;
	bh=5dBOJyQsuHLDJpfFHMKDaBRpVQpzTkAcUADM/oWh7fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3QFPjH9VtQbWUtUBkHH5gPll/pl+mSoMzSVoEeeY3auEhUG2GAVeUryVM+Yg/sSGPlE2EXz8cON57qvxjg/7VxoyhZGAE8qucjSDoPT2lTmiTw8gVUGy/c/xS0Y+LLnT9/AcgnuRupYrg9WGj+kpnULKmTHENIIULuTTRDSQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1to1YLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A82C4CEF8;
	Fri,  5 Sep 2025 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757099711;
	bh=5dBOJyQsuHLDJpfFHMKDaBRpVQpzTkAcUADM/oWh7fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1to1YLuFvMWIqo33ScskI3U5XtpyAJTtSGQjmbIqNP3tj3JXAWnzqQia0AfpRBAR
	 t5SVrMH37Ua7TLt5JqDzgHKmTNYrMPxI0KD5RgNT7QHOMn9TwZN0JwBf4V/g9wrJ6T
	 Uzw+kD/mCa3GwPK5MoVUE4KBHZidN6wHSdHdSK7wf5dP6sKWzTB19E2nfYhk85+Kse
	 yL+f8ig/RhWBzrzM+r+KVb+0HQRA7ON8YuvBvnLCJRQ8GfnmRxAm9ZK6vMVINNbVqb
	 i6HzPmxNhGVhYR+u+Bkrqgte2cxxkX3VgMc6Kdna7/c9cKsr/ZFoppafKZyXu0NgHI
	 36VCywm67hMsQ==
Date: Fri, 5 Sep 2025 15:15:10 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: NFSD: Add io_cache_{read,write} controls to debugfs
Message-ID: <aLs2vtN-MU_Rrmn7@kernel.org>
References: <20250905145509.8678-1-cel@kernel.org>
 <aLseneIE3Mubr5uV@kernel.org>
 <4a24c9a1-a56d-46db-90f9-b626c05f027c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a24c9a1-a56d-46db-90f9-b626c05f027c@kernel.org>

On Fri, Sep 05, 2025 at 02:45:37PM -0400, Chuck Lever wrote:
> On 9/5/25 1:32 PM, Mike Snitzer wrote:
> > On Fri, Sep 05, 2025 at 10:55:09AM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Aside from attribution, which I suspect you didn't intend to switch
> > these changes from being attributed to me, this looks good (one small
> > nit below).
> 
> I didn't intend to change the attribution, you're right. My tool
> chain's squashing always changes the patch authorship and I don't
> always remember to catch it.
> 
> I will fix that up.

Ack.

> >> Add 'io_cache_read' to NFSD's debugfs interface so that any data
> >> read by NFSD will either be:
> >> - cached using page cache (NFSD_IO_BUFFERED=0)
> >> - cached but removed from the page cache upon completion
> >>   (NFSD_IO_DONTCACHE=1).
> >>
> >> io_cache_read may be set by writing to:
> >>   /sys/kernel/debug/nfsd/io_cache_read
> >>
> >> Add 'io_cache_write' to NFSD's debugfs interface so that any data
> >> written by NFSD will either be:
> >> - cached using page cache (NFSD_IO_BUFFERED=0)
> >> - cached but removed from the page cache upon completion
> >>   (NFSD_IO_DONTCACHE=1).
> >>
> >> io_cache_write may be set by writing to:
> >>   /sys/kernel/debug/nfsd/io_cache_write
> >>
> >> The default value for both settings is NFSD_IO_BUFFERED, which is
> >> NFSD's existing behavior for both read and write. Changes to these
> >> settings take immediate effect for all exports and NFS versions.
> >>
> >> If NFSD_IO_DONTCACHE is specified, all exported filesystems must
> >> implement FOP_DONTCACHE, otherwise IO flagged with RWF_DONTCACHE
> >> will fail with -EOPNOTSUPP.
> 
> Btw, I'd like NFSD to fall back to buffered I/O if the file system's
> FOP_DONTCACHE flag is not set. Do you have an objection to that?

Ah yes, now that you mention it I recall you suggesting that before.
Got lost in the shuffle but I agree that it makes sense.  Just that
like the NFSD_IO_DIRECT case, doing negative checks for every IO is
excessive. SO I left sorting out the best way to implement it as TBD,
but forgot about it.

The challenge is really that the global debugfs knobs are so
coarse-grained. Handling this type of thing will be much easier once
per-export configuration is possible.

> >> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/nfsd/debugfs.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  fs/nfsd/nfsd.h    |  9 +++++
> >>  fs/nfsd/vfs.c     | 19 ++++++++++
> >>  3 files changed, 121 insertions(+)
> >>
> >> Changes from Mike's v9:
> >> - Squashed the "io controls" patches together
> >> - Removed NFSD_IO_DIRECT for the moment
> >> - Addressed a few more checkpatch.pl nits
> >>
> >> This gives a cleaner platform on which to build the direct I/O code
> >> paths, and does not expose partially implemented I/O modes to users.
> >>
> >> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> >> index 84b0c8b559dc..2b1bb716b608 100644
> >> --- a/fs/nfsd/debugfs.c
> >> +++ b/fs/nfsd/debugfs.c
> >> @@ -44,4 +131,10 @@ void nfsd_debugfs_init(void)
> >>  
> >>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
> >>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> >> +
> >> +	debugfs_create_file("io_cache_read", 0644, nfsd_top_dir, NULL,
> >> +			    &nfsd_io_cache_read_fops);
> >> +
> >> +	debugfs_create_file("io_cache_write", 0644, nfsd_top_dir, NULL,
> >> +			    &nfsd_io_cache_write_fops);
> >>  }
> > 
> > Relative to checkpatch warnings, this ^ code is what I'm aware of.
> > For consistency I stuck with "S_IWUSR | S_IRUG", whereas you honored
> > checkpatch's suggestion to use 0644.
> > 
> > Maybe update disable-splice-read to also use 0644 too? But your call!
> 
> Still debating that myself. It's a change that is not related to the
> purpose of this patch, so I probably should do that kind of clean-up
> separately.

Ack.

