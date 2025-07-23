Return-Path: <linux-nfs+bounces-13223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D229B0FDC7
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 01:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1374D1C240E0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 23:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF3C220F5D;
	Wed, 23 Jul 2025 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5Y/RHXU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163171EF0A6
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753314786; cv=none; b=nP/6C+D0nQ3kPrppb4qnH4BkTknGSqZ0Z/my+8wc7SdE/Bes2tdrthLlxOjzq40bBnDY0EzgrJQ77HPv1zt6YUHE/Q/AWzvuB0qbg4a9yb0IUzmZHMOg9ev5dc9imBBtykuDXbiB783a5QlAeFu0x1lhCe1iPnIeJubD6KKOyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753314786; c=relaxed/simple;
	bh=WKOtLGVfrWFxGjR+56XQPmBDKeYzRz7QEyMKtp/rICI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwJBXlli4NHKOk1O4ww2ZKJ3h1pATjPlVFbYz23sQs4cSoVy44NzVyMTV0wa07V5eMsmwQNe1bOjkRzUEBEtq9RhIapYq/sJgvsK5jPriXfpeaO3gPku0jq0HA3NuQlZk4gbm5/F4fWZs1zjo0A7A0OJDNWHmiNRmH2Yxu+SHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5Y/RHXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEBFC4CEE7;
	Wed, 23 Jul 2025 23:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753314785;
	bh=WKOtLGVfrWFxGjR+56XQPmBDKeYzRz7QEyMKtp/rICI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5Y/RHXUUmVfn96J2/n7XSNUe8tKkNCXcDB1i3byfe8eYJTdJmHHp8T0AcAWXvdRQ
	 h+VQE0qtZOptuG4iQsO8zCizJdLl951Qq20msx3KRYvcNv6et+2wmbQFMZ9JfwmBmJ
	 xw47vWCSeiYATd3mgfwzZQ/I3Q9pfvYtgCD/HfyRepHo4LZUIXYtxMpC4aFzyL606a
	 0anV12sfLFb3MAVatIJmLStuvpE2T5z27d9CR+36U93aUpQ9ih1/1REFTMTlTVt6ns
	 7cIqk1fEbEjwTdV4GnIMgeTqpQJBhH24CJudvsp2nGMBGLIA16FFtrFc3KNBRUlLUM
	 Y0ul2iBSdm9cw==
Date: Wed, 23 Jul 2025 19:53:04 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/7] NFS DIRECT: handle misaligned READ and WRITE for
 LOCALIO
Message-ID: <aIF14KpfHWI2239c@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
 <aIEskxZEnEq1qK80@kernel.org>
 <db121b40-f3da-4ecc-9e07-e3c3c8979b91@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db121b40-f3da-4ecc-9e07-e3c3c8979b91@oracle.com>

On Wed, Jul 23, 2025 at 02:42:56PM -0400, Chuck Lever wrote:
> On 7/23/25 2:40 PM, Mike Snitzer wrote:
> > On Mon, Jul 21, 2025 at 10:49:17PM -0400, Mike Snitzer wrote:
> >> Hi,
> >>
> >> This "NFS DIRECT" series depends on the "NFSD DIRECT" series here:
> >> https://lore.kernel.org/linux-nfs/20250714224216.14329-1-snitzer@kernel.org/
> >> (for the benefit of nfsd_file_dio_alignment patch in this series)
> >>
> >> The first patch was posted as part of a LOCALIO revert series I posted
> >> a week or so ago, thankfully that series isn't needed thanks to Trond
> >> and Neil's efforts.  BUT the first patch is needed, has Reviewed-by
> >> from Jeff and Neil and is marked for stable@.
> >>
> >> The biggest change in v2 is the introduction of O_DIRECT misaligned
> >> READ and WRITE handling for the benefit of LOCALIO. Please see patches
> >> 6 and 7 for more details.
> > 
> > Turns out that these NFS client (fs/nfs/direct.c) changes that focused
> > on benefiting LOCALIO actually also benefit NFSD if/when it is
> > configured to use O_DIRECT [0].
> > 
> > Such that the NFS client's O_DIRECT code will split any misaligned
> > WRITE IO and NFSD will then happily issue the DIO-aligned "middle" of
> > a given misaligned WRITE IO down to the underlying filesystem.
> > 
> > Same goes for READ, NFS client will expand the front of any misaligned
> > READ such that the bulk of the IO becomes DIO-aligned (only the final
> > partial tail page is misaligned).
> > 
> > So with the NFS client changes in this series we actually don't _need_
> > NFSD to have the same type of misaligned IO analysis and handling to
> > expand READs or split WRITEs to be DIO-aligned.  Which reduces work
> > that NFSD needs to do by leaning on the NFS client having the
> > capability.
> 
> I'm not quite following. Does that apply to non-Linux NFS clients too?

No, old Linux clients without these changes or non-Linux clients
wouldn't have the capabilities offered (extending READs, splitting
WRITEs to be DIO-aligned).  The question is: do we care?  Long-term:
probably.

I'd be fine with the NFSD DIRECT's misaligned IO support (READ already
implemented/posted [0], WRITE partially implemented but not posted) to 
be land upstream so that we have the benefit of making the most of
NFSD's O_DIRECT support even if the client doesn't take steps to issue
IO that is DIO-aligned.

Whichever way we go, it is potentially convenient that the less
"involved" NFSD DIRECT patch 5 [0] could be withheld initially.  Let
the NFS client do the lifting for us assessing how well NFSD's
O_DIRECT works and yet have confidence that we can deploy support for
old Linux clients or non-Linux clients in the future by merging that
patch 5 (and NFSD misaligned WRITE support comparable to NFS's WRITE
splitting in this series [1]) in a secondary phase.

Good to have options.

Mike

[0]: https://lore.kernel.org/linux-nfs/20250723154351.59042-6-snitzer@kernel.org/
[1]: https://lore.kernel.org/linux-nfs/20250722024924.49877-8-snitzer@kernel.org/

