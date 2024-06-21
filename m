Return-Path: <linux-nfs+bounces-4225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1009130D9
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 01:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D511C20ACC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F576F2F1;
	Fri, 21 Jun 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5Rq7++V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E63208C4
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719012490; cv=none; b=Tv5FgcIoou2GdXqkvupkD1WC59UhKGyllPGvisYQeE9xiJfoaqj9mFHnwZSdizLXX057gMHS/K2RqpRrcnqWH3ktBkTjbIVaRPIklQN1MQPgL2Df1dbJcyF6HOTMJCLgyn/S4hWRnYfQ0PQBbh5HNQxkkGHhY46vf6B/9EAFJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719012490; c=relaxed/simple;
	bh=EytdXjeKYcrHKEXQwVoIm/R1BDm3HmA4ToKjF9StW5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuIkrSeMGTXhJdhc+XCm0vPZUhOqPphe150o64CADgPfwisZYzbdPvFGjrrMrRpaWKFJWwQgPdFgnVbp1Ys+IzY0GgEaWp5oDfAUkoafRROSkpZR1snhN6xJo/Ge8Prbq4pY1I9YckJULdRKSuKKL43P425Lp+AW+oS3UFeVI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5Rq7++V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E172BC2BBFC;
	Fri, 21 Jun 2024 23:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719012489;
	bh=EytdXjeKYcrHKEXQwVoIm/R1BDm3HmA4ToKjF9StW5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5Rq7++V5bwF95BjaTUO+GW5achufHMBLWcqIYn53h/+VoMHY/RukH2DDj0qUV7i1
	 vUXTnhAl3Jaa0k1FXc5CIVgTlZA3GRs+cdNukRk2c2ifDiBwijDrj2uO9AJzzfijPc
	 flkdi8VGOv7BAUIfz0AgsyFlx29KMb2wifk0VV6KbPo9UayLAdyP9/hxU8fb40CJVd
	 TPNv483HojUkxeeUDrwuSqy5hfLk4IjPBMvIWfdRL8oLUBxUk8JeEqPK6nc1cpqOGV
	 r9b6M/ZVWe8SQ4pAVfSXHaRIGHj6zc8B3472ChtvCLf7fuYNrpZQW6IdBJ5GT32fIP
	 mHx/zVXwmifAw==
Date: Fri, 21 Jun 2024 19:28:07 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 06/18] nfs/nfsd: add "localio" support
Message-ID: <ZnYMh35G6WC1YgCA@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
 <20240619204032.93740-7-snitzer@kernel.org>
 <171895010008.14261.5871139607400580149@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171895010008.14261.5871139607400580149@noble.neil.brown.name>

On Fri, Jun 21, 2024 at 04:08:20PM +1000, NeilBrown wrote:
> On Thu, 20 Jun 2024, Mike Snitzer wrote:
> > From: Weston Andros Adamson <dros@primarydata.com>
> > 
> > Add client support for bypassing NFS for localhost reads, writes, and
> > commits. This is only useful when the client and the server are
> > running on the same host.
> > 
> > nfs_local_probe() is stubbed out, later commits will enable client and
> > server handshake via a Linux-only LOCALIO auxiliary RPC protocol.
> > 
> > This has dynamic binding with the nfsd module (via nfs_localio module
> > which is part of nfs_common). Localio will only work if nfsd is
> > already loaded.
> > 
> > The "localio_enabled" nfs kernel module parameter can be used to
> > disable and enable the ability to use localio support.
> > 
> > Tracepoints were added for nfs_local_open_fh, nfs_local_enable and
> > nfs_local_disable.
> > 
> > Also, pass the stored cl_nfssvc_net from the client to the server as
> > first argument to nfsd_open_local_fh() to ensure the proper network
> > namespace is used for localio.
> > 
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/Makefile           |   1 +
> >  fs/nfs/client.c           |   3 +
> >  fs/nfs/inode.c            |   4 +
> >  fs/nfs/internal.h         |  51 +++
> >  fs/nfs/localio.c          | 722 ++++++++++++++++++++++++++++++++++++++
> >  fs/nfs/nfstrace.h         |  61 ++++
> >  fs/nfs/pagelist.c         |   3 +
> >  fs/nfs/write.c            |   3 +
> >  fs/nfsd/Makefile          |   1 +
> >  fs/nfsd/filecache.c       |   2 +-
> >  fs/nfsd/localio.c         | 244 +++++++++++++
> >  fs/nfsd/nfssvc.c          |   1 +
> >  fs/nfsd/trace.h           |   3 +-
> >  fs/nfsd/vfs.h             |   9 +
> >  include/linux/nfs.h       |   2 +
> >  include/linux/nfs_fs.h    |   2 +
> >  include/linux/nfs_fs_sb.h |   1 +
> >  include/linux/nfs_xdr.h   |   1 +
> >  18 files changed, 1112 insertions(+), 2 deletions(-)
> >  create mode 100644 fs/nfs/localio.c
> >  create mode 100644 fs/nfsd/localio.c
> > 

<snip>

> > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > new file mode 100644
> > index 000000000000..38d0832442b2
> > --- /dev/null
> > +++ b/fs/nfs/localio.c

<snip>

> > +static void
> > +nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
> > +{
> > +	struct nfs_pgio_header *hdr = iocb->hdr;
> > +
> > +	if (hdr->args.pgbase != 0) {
> > +		iov_iter_bvec(i, dir, iocb->bvec,
> > +				hdr->page_array.npages,
> > +				hdr->args.count + hdr->args.pgbase);
> > +		iov_iter_advance(i, hdr->args.pgbase);
> > +	} else
> > +		iov_iter_bvec(i, dir, iocb->bvec,
> > +				hdr->page_array.npages, hdr->args.count);
> 
> Both branches of this if() do exactly the same thing.  iov_iter_advance
> is a no-op if the size arg is zero.

iov_iter_advance doesn't look to be a no-op if the size arg is zero.
 
> Is it really worth increasing the code size to sometimes avoid a
> function call?
>
> At least we should for the iov_iter_bvec() inconditionally, then maybe
> call _advance().

For v7, I've fixed it so we do what you suggest.

> > +/*
> > + * Complete the I/O from iocb->kiocb.ki_complete()
> > + *
> > + * Note that this function can be called from a bottom half context,
> > + * hence we need to queue the fput() etc to a workqueue
> 
> fput() is not a good excuse for a workqueue - the work is always
> deferred either to a workqueue or to a process return-from-syscall
> context.
> However the ->rpc_call_done() and vfs_fsync_range() calls are excellent
> justification for a workqueue.
> So I think the comment should be improved, but the code looks sensible.

OK.

> > +static void
> > +nfs_get_vfs_attr(struct file *filp, struct nfs_fattr *fattr)
> > +{
> > +	struct kstat stat;
> > +
> > +	if (fattr != NULL && vfs_getattr(&filp->f_path, &stat,
> > +					 STATX_INO |
> > +					 STATX_ATIME |
> > +					 STATX_MTIME |
> > +					 STATX_CTIME |
> > +					 STATX_SIZE |
> > +					 STATX_BLOCKS,
> > +					 AT_STATX_SYNC_AS_STAT) == 0) {
> > +		fattr->valid = NFS_ATTR_FATTR_FILEID |
> > +			NFS_ATTR_FATTR_CHANGE |
> > +			NFS_ATTR_FATTR_SIZE |
> > +			NFS_ATTR_FATTR_ATIME |
> > +			NFS_ATTR_FATTR_MTIME |
> > +			NFS_ATTR_FATTR_CTIME |
> > +			NFS_ATTR_FATTR_SPACE_USED;
> > +		fattr->fileid = stat.ino;
> > +		fattr->size = stat.size;
> > +		fattr->atime = stat.atime;
> > +		fattr->mtime = stat.mtime;
> > +		fattr->ctime = stat.ctime;
> > +		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
> 
> This looks wrong for NFSv4.  I think we should use
> nfsd4_change_attribute().
> Maybe it isn't important, but if it isn't I'd like to see an explanation
> why.
> 
> > +		fattr->du.nfs3.used = stat.blocks << 9;
> > +	}
> > +}

Not following, this is client code so it doesn't have access to
nfsd4_change_attribute().

Pending clarification, and further review on my part, leaving this
item to one side (so won't be addressed in v7).

Thanks,
Mike

