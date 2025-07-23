Return-Path: <linux-nfs+bounces-13216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF3B0FA64
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C766E1886239
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 18:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEF20B812;
	Wed, 23 Jul 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiyyGR9a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A7131E2D
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296020; cv=none; b=nCh1EXSxiiqD1SmjRq99eS7RwafY8kmDSbQSgIHW7PxpV0w0MEe7b2ilKKpHUi0BZIbw647Sr5h3P3TLKg0W4nnlvZN2i8GRfWJIQuuyOamHe2tqkyiUDJk0sSSr6Wt35AVh4dk2RpuRExSovOt2mwFhrCTT+nqATk87s3ygmyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296020; c=relaxed/simple;
	bh=wERmG9s8HTjJahycDcI9UFyqdYK7kPsoe88i2EDeRjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqH3vANKh6ADfMVm8ildP4/0Aty0Yml85Ak5Shbt4eil9PWt258V8NYBbQGKLVIKOI9DoUHDOFtEuvrqjJaDX1JwsHWk+0RCP2gmViuKJY65jAc5u0gX6mAGAQtNaJLFuSLFSaVRrxDONFC7vm/AWx6/QihiJyrd6zA1xDVLcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiyyGR9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13031C4CEF1;
	Wed, 23 Jul 2025 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753296020;
	bh=wERmG9s8HTjJahycDcI9UFyqdYK7kPsoe88i2EDeRjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiyyGR9akgJL8cqRu3Bp7CYW+0gyR1LuMkJ1driyLuS63l3hWourLzFpVVYj35gHf
	 pH5P0yNoLmWM1qW/tC9TPTZaSqFoZ62aJp0okGryv9YuqAogHFoCWSos7mcS18vdoO
	 /ujYZAZVkrRt/kX1yrxnsVcAS/Yr2+vTg6LnHSkbr1YXNkwBrY1Kr//rrZRm1zFYuM
	 aANkSBbiAKoTb3rkdjGE9I71+uIrCNdCoV0LqlA90FLl0N99bySn++tfaSsyVyIHWD
	 rlcucsZDo9ZdGzaJUySHSOxnAw9QOUK3mQOmlI4WgaVcqiQl2DkO5kFUuYDA2GneYu
	 j/AhNFBRvzpBA==
Date: Wed, 23 Jul 2025 14:40:19 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/7] NFS DIRECT: handle misaligned READ and WRITE for
 LOCALIO
Message-ID: <aIEskxZEnEq1qK80@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722024924.49877-1-snitzer@kernel.org>

On Mon, Jul 21, 2025 at 10:49:17PM -0400, Mike Snitzer wrote:
> Hi,
> 
> This "NFS DIRECT" series depends on the "NFSD DIRECT" series here:
> https://lore.kernel.org/linux-nfs/20250714224216.14329-1-snitzer@kernel.org/
> (for the benefit of nfsd_file_dio_alignment patch in this series)
> 
> The first patch was posted as part of a LOCALIO revert series I posted
> a week or so ago, thankfully that series isn't needed thanks to Trond
> and Neil's efforts.  BUT the first patch is needed, has Reviewed-by
> from Jeff and Neil and is marked for stable@.
> 
> The biggest change in v2 is the introduction of O_DIRECT misaligned
> READ and WRITE handling for the benefit of LOCALIO. Please see patches
> 6 and 7 for more details.

Turns out that these NFS client (fs/nfs/direct.c) changes that focused
on benefiting LOCALIO actually also benefit NFSD if/when it is
configured to use O_DIRECT [0].

Such that the NFS client's O_DIRECT code will split any misaligned
WRITE IO and NFSD will then happily issue the DIO-aligned "middle" of
a given misaligned WRITE IO down to the underlying filesystem.

Same goes for READ, NFS client will expand the front of any misaligned
READ such that the bulk of the IO becomes DIO-aligned (only the final
partial tail page is misaligned).

So with the NFS client changes in this series we actually don't _need_
NFSD to have the same type of misaligned IO analysis and handling to
expand READs or split WRITEs to be DIO-aligned.  Which reduces work
that NFSD needs to do by leaning on the NFS client having the
capability.

Which means that we _could_ drop the more complicated NFSD misaligned
READ change (last patch [1]) from the v4 NFSD DIRECT patchset I just
posted [2].  And just do the basic NFSD enablement for DIRECT and
DONTCACHE (so we'd still need the v4 NFSD patchest's patches 1-4).

Thanks,
Mike

[0]: https://lore.kernel.org/linux-nfs/20250723154351.59042-1-snitzer@kernel.org/
[1]: https://lore.kernel.org/linux-nfs/20250723154351.59042-6-snitzer@kernel.org/
[2]: https://lore.kernel.org/linux-nfs/20250723154351.59042-1-snitzer@kernel.org/

> 
> Changes since v1:
> - renamed nfs modparam from localio_O_DIRECT_align_misaligned_READ to
>   localio_O_DIRECT_align_misaligned_IO (is used for misaligned READ
>   and WRITE support in fs/nfs/direct.c)
> - added misaligned O_DIRECT handling for both READ and WRITE to
>   fs/nfs/direct.c which in practice obviates LOCALIO's need to
>   fallback to sending misaligned READs to NFSD.
> - But the 5th patch that adds LOCALIO support to fallback to NFSD is a
>   useful backup mechanism (that will hopefully never be needed unless
>   some fs/nfs/direct.c bug gets introduced in the future). Patch 5
>   also provides refactoring that is useful.
> 
> Thanks,
> Mike
> 
> Mike Snitzer (7):
>   nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
>   nfs/localio: make trace_nfs_local_open_fh more useful
>   nfs/localio: add nfsd_file_dio_alignment
>   nfs/localio: refactor iocb initialization
>   nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
>   nfs/direct: add misaligned READ handling
>   nfs/direct: add misaligned WRITE handling
> 
>  fs/nfs/direct.c                        | 262 +++++++++++++++++++++++--
>  fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
>  fs/nfs/internal.h                      |  17 +-
>  fs/nfs/localio.c                       | 231 ++++++++++++++--------
>  fs/nfs/nfstrace.h                      |  47 ++++-
>  fs/nfs/pagelist.c                      |  22 ++-
>  fs/nfsd/localio.c                      |  11 ++
>  include/linux/nfs_page.h               |   1 +
>  include/linux/nfslocalio.h             |   2 +
>  9 files changed, 485 insertions(+), 109 deletions(-)
> 
> -- 
> 2.44.0
> 
> 

