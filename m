Return-Path: <linux-nfs+bounces-13378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33111B18565
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 18:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4461016AF75
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97D827AC37;
	Fri,  1 Aug 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyGLUfdY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534A26B756
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064365; cv=none; b=mIXjRzCyIS/P91Ry3S9RUoQsnt4ziki85rAV5eDKD1nS5a2dGFBbibfh9yZTEPurEYR81bt3aiaCmDCMRUY1mg91JOi0RUkhWnWfbcvG28yp3hch6xs74Y+u9CRXQZw6jpfwiI+klPV2lQ/JGaKv03rN6m4EF/YnlVg+yAsje14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064365; c=relaxed/simple;
	bh=WVYNstoB79S2xMCkPi/3Z7bAxX6yGSNe/oJR6r3VGdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o30IGIpF3yP3NnWk1a1n/1ag/CT32cwSVIgw9mXbwJhXehjzZoo+Pyp0PHy5EWtvgT/V7/cwU1DeyiNDA5lviNMhBH5t9C/Zfou1DbmQRbwTZUzihHkoIjw1Q8+dREMQknojvBIs7U8QEwXURcPNJXJ6g8CFfOU8A5ce76Xpxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyGLUfdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CADCC4CEE7;
	Fri,  1 Aug 2025 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754064365;
	bh=WVYNstoB79S2xMCkPi/3Z7bAxX6yGSNe/oJR6r3VGdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EyGLUfdYLWr7UQSZlF2QXBr8hr+CLJaQN1JNn8noF6945CBS+Gi0GSnqw9vYL5x7E
	 Eb3YyFhIHZKlPmysXPcR2EKglRpD3o79q6dtTGRgv+mK09P+6e8FnmyLBntIYLE7l5
	 8F9yJHEwooHC+2FaRlYji4OHu22QarOq/AACkrY5v/tkELSBy31UgtIvXC8f7EDHo9
	 Ig2+iG1NFeML7OsA3808MKrreDImyd7DWuYjgS4aJ6Do32GD3ylcInENT7OLOYhBZO
	 AW9R3sGthTQPEIZaffr/nU+jnEt9hBV+9U0wivDagZdt9DzmuaEtArUI8lNMLTWLIs
	 PHXOnaNM5gObQ==
Date: Fri, 1 Aug 2025 12:06:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH v2 4/4] NFSD: handle unaligned DIO for NFS reexport
Message-ID: <aIzl65wycTj99AOJ@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
 <20250731194448.88816-5-snitzer@kernel.org>
 <b5e2e433e70189b4ed05417f8bdb2ff98a82881e.camel@kernel.org>
 <aIvf7VqSeNE3Ma1m@kernel.org>
 <aIvkm_O4ff3vIKAM@kernel.org>
 <f430725a-600c-44da-8062-1b45b17537ce@oracle.com>
 <2006e3616903dd0f6db5653675d5741289e7e06b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2006e3616903dd0f6db5653675d5741289e7e06b.camel@kernel.org>

On Fri, Aug 01, 2025 at 10:33:02AM -0400, Jeff Layton wrote:
> On Fri, 2025-08-01 at 10:07 -0400, Chuck Lever wrote:
> > On 7/31/25 5:48 PM, Mike Snitzer wrote:
> > > On Thu, Jul 31, 2025 at 05:28:13PM -0400, Mike Snitzer wrote:
> > > > On Thu, Jul 31, 2025 at 04:58:00PM -0400, Jeff Layton wrote:
> > > > > On Thu, 2025-07-31 at 15:44 -0400, Mike Snitzer wrote:
> > > > > > NFS doesn't have any DIO alignment constraints but it doesn't support
> > > > > > STATX_DIOALIGN, so update NFSD such that it doesn't disable the use of
> > > > > > NFSD_IO_DIRECT if it is reexporting NFS.
> > > > > > 
> > > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > > ---
> > > > > >  fs/nfs/export.c          |  3 ++-
> > > > > >  fs/nfsd/filecache.c      | 11 +++++++++++
> > > > > >  include/linux/exportfs.h | 13 +++++++++++++
> > > > > >  3 files changed, 26 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > > > > > index e9c233b6fd209..2cae75ba6b35d 100644
> > > > > > --- a/fs/nfs/export.c
> > > > > > +++ b/fs/nfs/export.c
> > > > > > @@ -155,5 +155,6 @@ const struct export_operations nfs_export_ops = {
> > > > > >  		 EXPORT_OP_REMOTE_FS		|
> > > > > >  		 EXPORT_OP_NOATOMIC_ATTR	|
> > > > > >  		 EXPORT_OP_FLUSH_ON_CLOSE	|
> > > > > > -		 EXPORT_OP_NOLOCKS,
> > > > > > +		 EXPORT_OP_NOLOCKS		|
> > > > > > +		 EXPORT_OP_NO_DIOALIGN_NEEDED,
> > > > > >  };
> > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > index 5601e839a72da..ea489dd44fd9a 100644
> > > > > > --- a/fs/nfsd/filecache.c
> > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > @@ -1066,6 +1066,17 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
> > > > > >  	     nfsd_io_cache_write != NFSD_IO_DIRECT))
> > > > > >  		return nfs_ok;
> > > > > >  
> > > > > > +	if (exportfs_handles_unaligned_dio(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
> > > > > > +		/* Underlying filesystem doesn't support STATX_DIOALIGN
> > > > > > +		 * but it can handle all unaligned DIO, so establish
> > > > > > +		 * DIO alignment that is accommodating.
> > > > > > +		 */
> > > > > > +		nf->nf_dio_mem_align = 4;
> > > > > > +		nf->nf_dio_offset_align = PAGE_SIZE;
> > > > > > +		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
> > > > > > +		return nfs_ok;
> > > > > > +	}
> > > > > > +
> > > > > >  	status = fh_getattr(fhp, &stat);
> > > > > >  	if (status != nfs_ok)
> > > > > >  		return status;
> > > > > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > > > > index 9369a607224c1..626b8486dd985 100644
> > > > > > --- a/include/linux/exportfs.h
> > > > > > +++ b/include/linux/exportfs.h
> > > > > > @@ -247,6 +247,7 @@ struct export_operations {
> > > > > >  						*/
> > > > > >  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
> > > > > >  #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
> > > > > > +#define EXPORT_OP_NO_DIOALIGN_NEEDED	(0x80) /* fs can handle unaligned DIO */
> > > > > >  	unsigned long	flags;
> > > > > >  };
> > > > > >  
> > > > > > @@ -262,6 +263,18 @@ exportfs_cannot_lock(const struct export_operations *export_ops)
> > > > > >  	return export_ops->flags & EXPORT_OP_NOLOCKS;
> > > > > >  }
> > > > > >  
> > > > > > +/**
> > > > > > + * exportfs_handles_unaligned_dio() - check if export can handle unaligned DIO
> > > > > > + * @export_ops:	the nfs export operations to check
> > > > > > + *
> > > > > > + * Returns true if the export can handle unaligned DIO.
> > > > > > + */
> > > > > > +static inline bool
> > > > > > +exportfs_handles_unaligned_dio(const struct export_operations *export_ops)
> > > > > > +{
> > > > > > +	return export_ops->flags & EXPORT_OP_NO_DIOALIGN_NEEDED;
> > > > > > +}
> > > > > > +
> > > > > >  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> > > > > >  				    int *max_len, struct inode *parent,
> > > > > >  				    int flags);
> > > > > 
> > > > > 
> > > > > Would it not be simpler (better?) to add support for STATX_DIOALIGN to
> > > > > NFS, and just have it report '1' for both values?
> > > > 
> > > > I suppose adding NFS support for STATX_DIOALIGN, that doesn't actually
> > > > go over the wire, does make sense.
> > > > 
> > > > But I wouldn't think setting them to 1 valid.  Pretty sure they need
> > > > to be a power-of-2 (since they are used as masks passed to
> > > > iov_iter_is_aligned).
> > > > 
> > > > In addition, we want to make sure NFS's default DIO alignment (which
> > > > isn't informed by actual DIO alignment advertised by NFSD's underlying
> > > > filesystem and hardware, e.g. XFS and NVMe) is able to be compatible
> > > > with both finer (512b) and coarser (4096b) grained DIO alignment.
> > > > Only way to achieve that would be to skew toward the coarse-grained
> > > > end of the spectrum, right?
> > > > 
> > > > More conservative but more likely to work with everything.
> > > 
> > > Thinking/looking further: I really do prefer the approach I took in
> > > this patch (over the suggestion to implement STATX_DIOALIGN for NFS).
> > > 
> > > Otherwise NFS would forced to needlessly issue an RPC via fh_getattr()
> > > even though we're talking about NFS faking its STATX_DIOALIGN response
> > > (so it doesn't need to do the work to do a full-blown GETATTR).
> > > 
> > > This would be wasteful for the NFS reexport usecase.
> > 
> > Jeff's point is that applications (and in particular, user space NFS
> > servers) will use statx() to discover these values. The NFS client has
> > to implement STATX_DIOALIGN.

I agree, I'll add it to my TODO.

Adding that support is now very important for the NFS reexport case.
But joining them is a choice. They don't _need_ to be tightly coupled.

We could just have NFS and NFSD call the same helper _and_ set the
EXPORT_OP_NO_DIOALIGN_NEEDED I proposed.

> > I don't buy the idea that using vfs_getattr() to call into the NFS
> > client is wasteful here. Isn't this done once when the nfsd_file
> > is opened? And, since these are emulated values that are not fetched
> > via the NFS protocol, wouldn't that mean the NFS client could respond
> > without sending an RPC?

Not if the request_mask includes more than simply asking for
(STATX_DIOALIGN | STATX_DIO_READ_ALIGN) -- which currently will always
be the case for fh_getattr().  But yes, fair point that it only
happens for nfsd_file open.

> > I prefer to not add the exception processing to NFSD if, in the medium
> > to long run, the NFS client has to get support for DIOALIGN anyway.
> > 
> 
> I too think this would be a better approach. We have other exportable
> filesystems that have no DIO alignment restrictions too (Ceph comes to
> mind, but there are others). It would be nice if they "just worked" and
> didn't have to do special EXPORT_* flag shenanigans.

Not trying to make this harder than it is, just stating my peace and
then acquiescing...

Each filesystem where this applicable just setting a single well
defined export flag is considerably simpler than the alternative (of
needing to construct an emulated STATX_DIOALIGN response that will
accomplish the goal of NFSD transforming misaligned DIO such that it
isn't too fine-grained to be useful once the rubber meets the road and
the DIO is issued to the local filesystem exported by the ultimate
NFSD endpoint).

Maybe for bonus points, not holding breath, I'll see about adding a
EXPORT_SYMBOL helper <handwave>somewhere</handwave> that will allow
other filesystems like Ceph to benefit too. But to my eyes, an export
flag provides that ;)

Anyway, we have agreement that:
1) You'll drop this 4th patch for NFS reexport
2) I'll work on implementing STATX_DIOALIGN support for NFS

Thanks,
Mike

