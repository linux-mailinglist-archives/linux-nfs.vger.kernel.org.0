Return-Path: <linux-nfs+bounces-13445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6490BB1BA91
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F84518A0499
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9351E0DFE;
	Tue,  5 Aug 2025 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTBRT2Lv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9415ECCC
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420558; cv=none; b=YxRZVIQnuuZ7bl2JCJxUiE8tCXUu7kDdr+TM9A12gSRHNNF8Krp7bFMUr3Gcc0wcwfpi0I5twKOQAPdCRJQz3D7MR5bh+Om/Ru332kIrAD25Mi6KE0OltaHXp8wA5K30biFsPZQzmEuXHc/qroW6KdoNGHclxRsgVOPd9PcKPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420558; c=relaxed/simple;
	bh=d21Khm8jDhLj7if+RKh258aEECneDdrbB/48bM1/CFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7cCT8Q7i/WonB6m9piTRn8tSijH59D6r5FpLEq/Gch8rFlDes+HAKZotISuPYXnFy4ShIB06tMuKpGQPENjMw7OysovrufEi4nyzihCQC0EI3H0690RhvwebPLqClXztC90/Iz9kFdfdLGST18DCoGqFrO3wsKTeel/9ZRnZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTBRT2Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4600DC4CEF0;
	Tue,  5 Aug 2025 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754420557;
	bh=d21Khm8jDhLj7if+RKh258aEECneDdrbB/48bM1/CFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTBRT2LvUvvvD3Q3gIjNV2FdMv67HO3rW3cD7NhzCvU8EKyoogHwAYLQYKRNa5zOQ
	 b2p71gaSI68INNEF4hMEWgncAaU4iXVYyZNIQziDUgkrcnH2idSXXh8xmRHqE5Odor
	 Ix2mpE382OTdUnYh1ZLwVOKouTuly98KwSJIQaexpOQb9MgAs5Kr9yFM3IZdjKjT6y
	 nCPJEe68j4203Jma+w7ekoW6F2slm2nsygyMPhVZg+TGEFPYMGO2BK7aR5yl1XFtTk
	 IGcddKDT09qUamvqPqdcA4vwUbN++5d7A5ZcTkt31lKreE7THDIZl8P9kayHtEPU6l
	 UEY3PxB1xIzfw==
Date: Tue, 5 Aug 2025 15:02:36 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 3/4] NFSD: issue WRITEs using O_DIRECT even if IO is
 misaligned
Message-ID: <aJJVTFQ5JzUR_5va@kernel.org>
References: <20250731230633.89983-1-snitzer@kernel.org>
 <20250731230633.89983-4-snitzer@kernel.org>
 <04595f4b-750b-4b8e-a36b-f26c8939d2b1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04595f4b-750b-4b8e-a36b-f26c8939d2b1@oracle.com>

On Tue, Aug 05, 2025 at 10:55:06AM -0400, Chuck Lever wrote:
> On 7/31/25 7:06 PM, Mike Snitzer wrote:
> > If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> > middle and end as needed. The large middle extent is DIO-aligned and
> > the start and/or end are misaligned. Buffered IO is used for the
> > misaligned extents and O_DIRECT is used for the middle DIO-aligned
> > extent.
> > 
> > The nfsd_analyze_write_dio trace event shows how NFSD splits a given
> > misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
> > extent.
> > 
> > This combination of trace events is useful:
> > 
> >   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
> >   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
> >   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
> >   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
> > 
> > Which for this dd command:
> > 
> >   dd if=/dev/zero of=/mnt/share1/test bs=47008 count=2 oflag=direct
> > 
> > Results in:
> > 
> >   nfsd-55714   [043] ..... 79976.260851: nfsd_write_opened: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008
> >   nfsd-55714   [043] ..... 79976.260852: nfsd_analyze_write_dio: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008 start=0+0 middle=0+45056 end=45056+1952
> >   nfsd-55714   [043] ..... 79976.260857: xfs_file_direct_write: dev 259:12 ino 0x3e00008f disize 0x0 pos 0x0 bytecount 0xb000
> >   nfsd-55714   [043] ..... 79976.260965: nfsd_write_io_done: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008
> > 
> >   nfsd-55714   [043] ..... 79976.307762: nfsd_write_opened: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008
> >   nfsd-55714   [043] ..... 79976.307762: nfsd_analyze_write_dio: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008 start=47008+2144 middle=49152+40960 end=90112+3904
> >   nfsd-55714   [043] ..... 79976.307797: xfs_file_direct_write: dev 259:12 ino 0x3e00008f disize 0xc000 pos 0xc000 bytecount 0xa000
> >   nfsd-55714   [043] ..... 79976.307866: nfsd_write_io_done: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/vfs.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 124 insertions(+), 11 deletions(-)
> 
> The diffstat tells a worrying story.
> 
> For the READ path, nfsd_iter_read() is the fallback -- the hot path
> right now is splice reads. So adding instruction path length in
> nfsd_iter_read() is a concern, but it's not an immediate problem.
> 
> For the write side, there is only one path, which is ballooning with
> this set of patches. This is bound to have an impact on page cache
> writes, which are still the default write I/O mode.
> 
> This is why I'm hesitant to apply this series as it is currently.
> 
> If I might suggest a possible action/recourse: Perhaps the patches can
> be restructured so that the default cached write mechanism retains a
> short IPL. We can leave the de-duplication and other optimizations until
> we have field results from our experiments.

The default case has an extra memset() and some extra NULL pointer
checks, but otherwise I don't see anything that is reason for concern.

Can you be more specific?  Have you quantified something in practice
or this is purely from looking at the diffstat?  Avoiding needless
function calls (that should/could be inlined due to only one caller)
is your concern?

Or is wanting to somehow avoid any of this misaligned DIO support
until/unless the user enabled NFSD_IO_DIRECT via debugfs?  I've
(ab)used jump_labels in the past to micro-optimize away code that
should only be active if opt-in occurs.  But it ends up being pretty
gross, and I'm left unsure that jump_labels are sufficiently
light-weight to be worth it.

I've just posted v4... we can continue this discussion wherever you'd
like.

Thanks,
Mike

