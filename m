Return-Path: <linux-nfs+bounces-13356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F07B1782F
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 23:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBED7B572D
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 21:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5023ABB1;
	Thu, 31 Jul 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaTO/nmB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2921A433
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753997294; cv=none; b=fA+GBHdj5/XHns/S0QQjP4PVSKo0K/xOvfX+1pDJzVQR5MZqGf9OhYRHARwr4JYL041kORB6Qy4qUHyG6hiQy9CErTIf6BvobNRvB0t6By1txS/poP2tGNu2VZzjqcpV1SwCSHsBbNuAA3ky0DoWvBu+QAUJzXgz4aZtPD8MIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753997294; c=relaxed/simple;
	bh=jwre78cGeEaFb2cdecMUAhILPEw3OD56fe6I/bCzKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNv25kGHDlUeLZEPg5n3rAoj+CaLqUEGNRQzw4Kt52eWLkuJlIyPMLiiM63yf/MxlbrprRlPIjUh6Jcx96sOPczg/0mDVLSef/6jKANMJvLXjj58uSPqPiDqCONt2G2qPDP5d0rSE27A5LGp/iBcxPgDhYQ2zO60uo717rN7kOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaTO/nmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3619DC4CEEF;
	Thu, 31 Jul 2025 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753997294;
	bh=jwre78cGeEaFb2cdecMUAhILPEw3OD56fe6I/bCzKk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaTO/nmBWpY33fd1+IN8nteeDxZjL9pmsz2SdUmzTO3dcXKMuAeCde5pqXQJm3yIK
	 6ycs28sKlCol/aUK053X5Tg3ODhR3lYCASj1CC3dLl7XQbOdFKHIraip2en8M9y/Qb
	 EX456QDURP+foO/RsUQqveloSywuyrIb6quK45EFndboMt/YXyyVzCw+44uNPdeWzN
	 e/cwI6f3bhJc9267IFgBL0LAgHvYS8qXikI7jlX/FGx4XupGu4EIQU1NCQWCCMoHjl
	 ChpsVF+SQuq+kGUyG0Fw3/O9IcBsC6OzBBG1mvmH9xyJ4AnOpIA5IeV6CkPCSL4UU4
	 IhHefnz+SnsRw==
Date: Thu, 31 Jul 2025 17:28:13 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH v2 4/4] NFSD: handle unaligned DIO for NFS reexport
Message-ID: <aIvf7VqSeNE3Ma1m@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
 <20250731194448.88816-5-snitzer@kernel.org>
 <b5e2e433e70189b4ed05417f8bdb2ff98a82881e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5e2e433e70189b4ed05417f8bdb2ff98a82881e.camel@kernel.org>

On Thu, Jul 31, 2025 at 04:58:00PM -0400, Jeff Layton wrote:
> On Thu, 2025-07-31 at 15:44 -0400, Mike Snitzer wrote:
> > NFS doesn't have any DIO alignment constraints but it doesn't support
> > STATX_DIOALIGN, so update NFSD such that it doesn't disable the use of
> > NFSD_IO_DIRECT if it is reexporting NFS.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/export.c          |  3 ++-
> >  fs/nfsd/filecache.c      | 11 +++++++++++
> >  include/linux/exportfs.h | 13 +++++++++++++
> >  3 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > index e9c233b6fd209..2cae75ba6b35d 100644
> > --- a/fs/nfs/export.c
> > +++ b/fs/nfs/export.c
> > @@ -155,5 +155,6 @@ const struct export_operations nfs_export_ops = {
> >  		 EXPORT_OP_REMOTE_FS		|
> >  		 EXPORT_OP_NOATOMIC_ATTR	|
> >  		 EXPORT_OP_FLUSH_ON_CLOSE	|
> > -		 EXPORT_OP_NOLOCKS,
> > +		 EXPORT_OP_NOLOCKS		|
> > +		 EXPORT_OP_NO_DIOALIGN_NEEDED,
> >  };
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 5601e839a72da..ea489dd44fd9a 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1066,6 +1066,17 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
> >  	     nfsd_io_cache_write != NFSD_IO_DIRECT))
> >  		return nfs_ok;
> >  
> > +	if (exportfs_handles_unaligned_dio(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
> > +		/* Underlying filesystem doesn't support STATX_DIOALIGN
> > +		 * but it can handle all unaligned DIO, so establish
> > +		 * DIO alignment that is accommodating.
> > +		 */
> > +		nf->nf_dio_mem_align = 4;
> > +		nf->nf_dio_offset_align = PAGE_SIZE;
> > +		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
> > +		return nfs_ok;
> > +	}
> > +
> >  	status = fh_getattr(fhp, &stat);
> >  	if (status != nfs_ok)
> >  		return status;
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 9369a607224c1..626b8486dd985 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -247,6 +247,7 @@ struct export_operations {
> >  						*/
> >  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
> >  #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
> > +#define EXPORT_OP_NO_DIOALIGN_NEEDED	(0x80) /* fs can handle unaligned DIO */
> >  	unsigned long	flags;
> >  };
> >  
> > @@ -262,6 +263,18 @@ exportfs_cannot_lock(const struct export_operations *export_ops)
> >  	return export_ops->flags & EXPORT_OP_NOLOCKS;
> >  }
> >  
> > +/**
> > + * exportfs_handles_unaligned_dio() - check if export can handle unaligned DIO
> > + * @export_ops:	the nfs export operations to check
> > + *
> > + * Returns true if the export can handle unaligned DIO.
> > + */
> > +static inline bool
> > +exportfs_handles_unaligned_dio(const struct export_operations *export_ops)
> > +{
> > +	return export_ops->flags & EXPORT_OP_NO_DIOALIGN_NEEDED;
> > +}
> > +
> >  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> >  				    int *max_len, struct inode *parent,
> >  				    int flags);
> 
> 
> Would it not be simpler (better?) to add support for STATX_DIOALIGN to
> NFS, and just have it report '1' for both values?

I suppose adding NFS support for STATX_DIOALIGN, that doesn't actually
go over the wire, does make sense.

But I wouldn't think setting them to 1 valid.  Pretty sure they need
to be a power-of-2 (since they are used as masks passed to
iov_iter_is_aligned).

In addition, we want to make sure NFS's default DIO alignment (which
isn't informed by actual DIO alignment advertised by NFSD's underlying
filesystem and hardware, e.g. XFS and NVMe) is able to be compatible
with both finer (512b) and coarser (4096b) grained DIO alignment.
Only way to achieve that would be to skew toward the coarse-grained
end of the spectrum, right?

More conservative but more likely to work with everything.

Mike

