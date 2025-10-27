Return-Path: <linux-nfs+bounces-15683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D693C0E801
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B12463C9B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179B30B522;
	Mon, 27 Oct 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Moj0/Bgs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DA30C621
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575517; cv=none; b=qwz8e+V121SdNaYzoausqRQADLXiq5cBBCga1/dDOg6cBwAbNIpdLtirYzPje1M0dc+s7gGPn4Q4Ulml2O0rTtUSXfs3Y78+ikbU2lQ0zqSRSpSt/dj8OTauQ9FHC5LXYapzfvSoJ8CVb58akbPYFKYjV0l18dhBWzBoj6E2BFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575517; c=relaxed/simple;
	bh=4Z5M3/hk5FTKz3THncxROW8GL3Jydnk9wnh3Tt/5Nag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/KkNNhYfXnLJZDzOimRF0LPXdYFUHCyUEPTCrQwWifkLT7i5lRG0RSOFo84iTJNLAkb++TvqkCOW7T5cnCWRsMm0HsgEV9/XqfWobdN3VgCoo3Ft3RjdgmLrAEYyTUpJqWqwHX5KjIhnMZCdgRiBiJAUHgbe2c5Y6aZ49I+BW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Moj0/Bgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B01C4CEF1;
	Mon, 27 Oct 2025 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761575516;
	bh=4Z5M3/hk5FTKz3THncxROW8GL3Jydnk9wnh3Tt/5Nag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Moj0/Bgs21858sJx/IuO/WyOEeA7E07Z7TP92WTd5Hln+hyNAlkp+2Kj/OGkCt6G4
	 /IBtLRav4sAlSWm+ai5/jfkVqxNRgeQSjIo02Q2RVctSBx5jTUPNWMLSNzKgP6n0/C
	 GwgsKLPPJIz2OiFQBTk5n56TVslYpqz/f5JGj98zY3iw2SRPD1YwsVt36uz9yfz/ZY
	 aSQqoh9vCEOz75fpiXirvuPxTtdxTzQqsG2PzCUPJkOliedAxLWhjnyKFJIvryvmpL
	 BFf+OAKfgDG7Tg/8VPnt0KYzpeOw0zUEfqxDhsGpRlICYVhWN5XywQxe5mW1UhIfe2
	 cwELbvIX1FGZg==
Date: Mon, 27 Oct 2025 10:31:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
Message-ID: <aP-CW5_egXzHS1jz@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org>
 <aP8n4iqMPie83nYy@infradead.org>
 <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
 <aP9zU_9e2VDw4G7I@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP9zU_9e2VDw4G7I@infradead.org>

On Mon, Oct 27, 2025 at 06:27:47AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 09:23:27AM -0400, Chuck Lever wrote:
> > Promoting all NFSD_IO_DIRECT writes to FILE_SYNC was my idea, based on
> > the assumption that IOCB_DIRECT writes to local file systems left
> > nothing to be done by a later commit. My assumption is based on the
> > behavior of O_DIRECT on NFS files.
> > 
> > If that assumption is not true, then I agree there is no technical
> > reason to promote NFSD_IO_DIRECT writes to FILE_SYNC, and I can remove
> > that built-in assumption for v8 of this series.
> 
> It is not true, or rather only true for a tiny subset of use cases
> (which NFS can't even query a head of time).
> 
> For devices that advertise a volatile write cache, commit has to flush
> that.  High-end enough device won't have one, but a lot of devices that
> people NFS-export do.  For pure overwrites the file system could
> optimize this way by using the FUA flag, and at least the iomap direct
> I/O code does implementation that optimization for that particular case.

NFSD_IO_DIRECT isn't meant to be uniformly better for all types of
storage.  Any storage that has a volatile write cache is probably best
served by existing NFSD default (NFSD_IO_BUFFERED).

> For any write that is not purely an overwrite, commit has to write out
> the metadata to track the newly allocated blocks.  Applications that
> do overwrite fully allocated blocks typically do that using the O_DSYNC
> flag to fully benefit from optimizations for that case.

Think there is a bit of disconnect here in that this new
NFSD_IO_DIRECT mode is admin configured purely on NFSD's side and
always-on once enabled.

The client doesn't control if/when NFSD would make use of O_DIRECT
(other than if it sends misaligned IO and NFSD must do what it can to
ensure it safely hits stable storage).

In addition, the use of NFSD_IO_DIRECT is intended to allow for
systems large _and_ small to get the advantage of lower memory
utilization.  Buffered IO is one extreme, but even using a model where
NFSD were to not impose NFS_FILE_SYNC would create a situation where
more memory needed batch IO and then wait for client to send COMMIT.

The current approach of using IOCB_DSYNC|IOCB_SYNC have performed
really well on modern NVMe servers.

