Return-Path: <linux-nfs+bounces-15544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD032BFE5B4
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 23:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970A03A3E51
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB08303A03;
	Wed, 22 Oct 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyUyoXTh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4530148B
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170217; cv=none; b=uC00zIQ6s10nz6b5OTB+AFw8LtZAncZftmTNpZsLf5//ouDA/+AjSTCKUqTqVY4tYifGv1CKe68UYF68ansxJMnHRZQtuSyhrrK11FHCFyAS9tg2kXWGPa2gtzQg/RLLTSSV/1R11GWppTr/66XGavBUR9OUHS/JAQu17llHTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170217; c=relaxed/simple;
	bh=ssKjokxumyrG1d80FCdlLy6Q8MPxY39u0Dz5BFiCWf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtxyNU80tr+tIcIM3huvrcAPvPS7nvRlGEH7GTnTp7myZGRJqpoKVF9T/k69omXj3z4wqcxpd9UAdLVRoUuLXHk2H5DhkWZkx/uj1bLWxJUO75FGz7R6F6FmGs/JsmDJIcPFHuyfu1WzTgn2hsjpoxSS2l1iXtBPYwvoqAKCuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyUyoXTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B5AC4CEE7;
	Wed, 22 Oct 2025 21:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761170216;
	bh=ssKjokxumyrG1d80FCdlLy6Q8MPxY39u0Dz5BFiCWf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyUyoXThhdagMUZfSlyD6za/fZstjBfmduQjLnLE0G8naFHr0FkdJPtvZS3IZOrRp
	 BP2+95X+S6tgVbUz7TZED5fjPY/4DKkOqDcPueQp2aZsalPpALPa6Njnj101Gp+f5n
	 HU8nX7rOU66J2nywL25h26AKwgrh7G2hemMwVXqrksTmheS2DRjbSS/JQSUJzcq3c4
	 5Kojw9O+9NfILCW0g6ah/mPJ0Nz707GBNBcQaG4Xw7FatysJLlwzbA6npJyc7yQz6Q
	 pSs0wFMS6A0lUL2sagoNlXRJwgiNJdVZa5zYW5KIiRWIE4FlS/qu7oCXVXpwvhpmS6
	 86/YJW+M0uQWg==
Date: Wed, 22 Oct 2025 17:56:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v6 0/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPlTJ6oxreVOihPc@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022192208.1682-1-cel@kernel.org>

On Wed, Oct 22, 2025 at 03:22:03PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Following on https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
> this series includes the patches needed to make NFSD Direct WRITE
> work.
> 
> The "large" piece of work left to do:
> > > > Wouldn't it make sense to track the alignment when building the bio_vec
> > > > array instead of doing another walk here touching all cache lines?
> > > 
> > > Yes, that is the conventional wisdom that justified Keith removing
> > > iov_iter_aligned.  But for NFSD's WRITE payload the bio_vec is built
> > > outside of the fs/nfsd/vfs.c code.  Could be there is a natural way to
> > > clean this up (to make the sunrpc layer to conditionally care about
> > > alignment) but I didn't confront that yet.
> > 
> > Well, for the block code it's also build outside the layer consuming it.
> > But Keith showed that you can easily communicate that information and
> > avoid extra loops touching the cache lines.

I had started to reply to the other thread relative to this point, but
I'll cherry pick it here:

On Wed, Oct 22, 2025 at 10:37:35AM -0400, Chuck Lever wrote:
> Again, is there a reason to push this suggestion out to a later merge
> window? It seems reasonable to tackle it now.

If you'd be OK with us tackling it as an incremental change attributed
to whoever takes the lead, then it can happen now or whenever someone
can get to it.

IMO it is worthy of incremental effort because it is genuinely
destabilizing line of development -- any -EINVAL that could result
from misaligned DIO being issued to the underlying filesystem can
cause serious problems with IO retry stalls.. at least in my
experience with pNFS flexfiles (as implemented by Hammerspace).
And that is why I was logging -EINVAL is important; now removed in
this v6. So you've removed checking that'd save us from bugs growing
to be way more painful _before_ optimization work that might expose us
to -EINVAL. To be clear: I am perfectly fine with removing that
seemingly heavy -EINVAL handling from nfsd_issue_write_dio like you
did _because_ nfsd_iov_iter_aligned_bvec() does a comprehensive job of
avoiding the possibility of misaligned DIO being issued to underlying
filesystem.

As cliche as "perfection is the enemy of good" is, it does genuinely
govern how I engineer solutions.

That doesn't mean I'm not seeking perfection, but for me: perfection
is accomplished iteratively by honing good to great to perfect.

Bounding each step towards perfection helps reach it.

Apologies if all that caused your eyes to roll into the back of your
head.  I have this additional optimization work on my TODO, I just
haven't been able to circle back to it.

> (Perhaps to get us started, Christoph, do you know of specific code that
> shows how this code could be reorganized?)

It is at the time of the write payload's bvec creation where alignment
would need to be assessed.

Keith's changes in these commits provide context (albeit opaque):

fec2e705729d block: check for valid bio while splitting
743bf2e0c49c block: add size alignment to bio_iov_iter_get_pages
20a0e6276edb block: align the bio after building it
5ff3f74e145a block: simplify direct io validity check
7eac33186957 iomap: simplify direct io validity check
9eab1d4e0d15 block: remove bdev_iter_is_aligned
69d7ed5b9ef6 blk-integrity: use simpler alignment check
b475272f03ca iov_iter: remove iov_iter_is_aligned

If you look at the entirety of those commits' changes with:
git diff fec2e705729d^..b475272f03ca

You can see that Keith removed calls to iov_iter_is_aligned and
bdev_iter_is_aligned by doing checking earlier at the time of creation
of "the thing" (for our case that'd be the bio_vec entries sunrpc adds
to the iov_iter that gets passed as write payload to vfs.c?).

Mike

> Changes since v5:
> * Add a patch to make FILE_SYNC WRITEs persist timestamps
> * Address some of Christoph's review comments
> 
> Changes since v4:
> * Split out refactoring nfsd_buffered_write() into a separate patch
> * Expand patch description of 1/4
> * Don't set IOCB_SYNC flag
> 
> Changes since v3:
> * Address checkpatch.pl nits in 2/3
> * Add an untested patch to mark ingress RDMA Read chunks
> 
> Chuck Lever (3):
>   NFSD: Make FILE_SYNC WRITEs comply with spec
>   NFSD: Enable return of an updated stable_how to NFS clients
>   svcrdma: Mark Read chunks
> 
> Mike Snitzer (2):
>   NFSD: Refactor nfsd_vfs_write()
>   NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
> 
>  fs/nfsd/debugfs.c                       |   1 +
>  fs/nfsd/nfs3proc.c                      |   2 +-
>  fs/nfsd/nfs4proc.c                      |   2 +-
>  fs/nfsd/nfsproc.c                       |   3 +-
>  fs/nfsd/trace.h                         |   1 +
>  fs/nfsd/vfs.c                           | 219 ++++++++++++++++++++++--
>  fs/nfsd/vfs.h                           |   6 +-
>  fs/nfsd/xdr3.h                          |   2 +-
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   5 +
>  9 files changed, 224 insertions(+), 17 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

