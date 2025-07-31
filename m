Return-Path: <linux-nfs+bounces-13361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43CB17901
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 00:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BD516DCE6
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9932676DF;
	Thu, 31 Jul 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3ttLe2a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863201FDA8C
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000097; cv=none; b=CD++YwwUb/wzfE/GXdWvZBPEyS7EP5KcKc/vWsjARNlg3C6xlRMG+ZYJq04jnVxXR5lwH7pxyBK0gCOKh12MYQLfdapZnBTdS3fpPhTGVN2b/xMo/rhGYhV6uiHfjXczu4Yf9HqoCYZeYMr6BJgvtg1Wscu/4X0tZcaqVj+tqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000097; c=relaxed/simple;
	bh=CFKHbIWftn1AHIQcByhZSJQ1Z4Va3KN3kaSQ8j+R6DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoIKUQbY9uN5C1fJKsxoj8Mb+e/7NFBNhHhjObuMeXcMXlRBg0d5KN1mZqvYSfSdCQEnv6B20ddz6Dkfa21twNTsKwbw17dVEP7zLG1dF2FKvaqvRg+k/dt6EGAqzjxskcs2l94bKqnSEBrVCXWAOHFKmi012PnZmbN/aHHqxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3ttLe2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD88BC4CEF4;
	Thu, 31 Jul 2025 22:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000097;
	bh=CFKHbIWftn1AHIQcByhZSJQ1Z4Va3KN3kaSQ8j+R6DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3ttLe2acafq/C2ipJssW4QvT4ShyePPMIAeaPI8Jq2+pGbXK2aS/cxzLh3iNlZ4w
	 j+Bz0bVOw3mfxYKrN6YVCJLaINUB7/UHkVnE7UcL1iwxBH8f+ZNGZjuK8Sq/Uuze6f
	 hwf4htVJOHHE77U+hXYMjT5Yxt+cIPETvJlfSRrECiGcL7dnVebaPKA3xKW9XT6zUP
	 XoonB60zHsqztcETBxIbugzW52fUQlb+wIjVF6f4bNHUyjFHP7nypfPNUvwVSLwkcS
	 UBibOo8wneTxKdXAivBXNjFJFyee0qwt7Fi7v7YoyBmdSOy3lSeTNFv2BaDKwZhF6i
	 dLAJTQiN+vnbQ==
Date: Thu, 31 Jul 2025 18:14:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH v2 4/4] NFSD: handle unaligned DIO for NFS reexport
Message-ID: <aIvq36wplMN_Rsu7@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
 <20250731194448.88816-5-snitzer@kernel.org>
 <b5e2e433e70189b4ed05417f8bdb2ff98a82881e.camel@kernel.org>
 <aIvf7VqSeNE3Ma1m@kernel.org>
 <4f12862ab8560f788210b0c2d0c7b13a5dffcd70.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f12862ab8560f788210b0c2d0c7b13a5dffcd70.camel@kernel.org>

On Thu, Jul 31, 2025 at 05:45:31PM -0400, Jeff Layton wrote:
> On Thu, 2025-07-31 at 17:28 -0400, Mike Snitzer wrote:
> > On Thu, Jul 31, 2025 at 04:58:00PM -0400, Jeff Layton wrote:
> > > On Thu, 2025-07-31 at 15:44 -0400, Mike Snitzer wrote:
> > > > NFS doesn't have any DIO alignment constraints but it doesn't support
> > > > STATX_DIOALIGN, so update NFSD such that it doesn't disable the use of
> > > > NFSD_IO_DIRECT if it is reexporting NFS.
> > > > 
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  fs/nfs/export.c          |  3 ++-
> > > >  fs/nfsd/filecache.c      | 11 +++++++++++
> > > >  include/linux/exportfs.h | 13 +++++++++++++
> > > >  3 files changed, 26 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > > > index e9c233b6fd209..2cae75ba6b35d 100644
> > > > --- a/fs/nfs/export.c
> > > > +++ b/fs/nfs/export.c
> > > > @@ -155,5 +155,6 @@ const struct export_operations nfs_export_ops = {
> > > >  		 EXPORT_OP_REMOTE_FS		|
> > > >  		 EXPORT_OP_NOATOMIC_ATTR	|
> > > >  		 EXPORT_OP_FLUSH_ON_CLOSE	|
> > > > -		 EXPORT_OP_NOLOCKS,
> > > > +		 EXPORT_OP_NOLOCKS		|
> > > > +		 EXPORT_OP_NO_DIOALIGN_NEEDED,
> > > >  };
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index 5601e839a72da..ea489dd44fd9a 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -1066,6 +1066,17 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
> > > >  	     nfsd_io_cache_write != NFSD_IO_DIRECT))
> > > >  		return nfs_ok;
> > > >  
> > > > +	if (exportfs_handles_unaligned_dio(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
> > > > +		/* Underlying filesystem doesn't support STATX_DIOALIGN
> > > > +		 * but it can handle all unaligned DIO, so establish
> > > > +		 * DIO alignment that is accommodating.
> > > > +		 */
> > > > +		nf->nf_dio_mem_align = 4;
> > > > +		nf->nf_dio_offset_align = PAGE_SIZE;
> > > > +		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
> > > > +		return nfs_ok;
> > > > +	}
> > > > +
> > > >  	status = fh_getattr(fhp, &stat);
> > > >  	if (status != nfs_ok)
> > > >  		return status;
> > > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > > index 9369a607224c1..626b8486dd985 100644
> > > > --- a/include/linux/exportfs.h
> > > > +++ b/include/linux/exportfs.h
> > > > @@ -247,6 +247,7 @@ struct export_operations {
> > > >  						*/
> > > >  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
> > > >  #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
> > > > +#define EXPORT_OP_NO_DIOALIGN_NEEDED	(0x80) /* fs can handle unaligned DIO */
> > > >  	unsigned long	flags;
> > > >  };
> > > >  
> > > > @@ -262,6 +263,18 @@ exportfs_cannot_lock(const struct export_operations *export_ops)
> > > >  	return export_ops->flags & EXPORT_OP_NOLOCKS;
> > > >  }
> > > >  
> > > > +/**
> > > > + * exportfs_handles_unaligned_dio() - check if export can handle unaligned DIO
> > > > + * @export_ops:	the nfs export operations to check
> > > > + *
> > > > + * Returns true if the export can handle unaligned DIO.
> > > > + */
> > > > +static inline bool
> > > > +exportfs_handles_unaligned_dio(const struct export_operations *export_ops)
> > > > +{
> > > > +	return export_ops->flags & EXPORT_OP_NO_DIOALIGN_NEEDED;
> > > > +}
> > > > +
> > > >  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> > > >  				    int *max_len, struct inode *parent,
> > > >  				    int flags);
> > > 
> > > 
> > > Would it not be simpler (better?) to add support for STATX_DIOALIGN to
> > > NFS, and just have it report '1' for both values?
> > 
> > I suppose adding NFS support for STATX_DIOALIGN, that doesn't actually
> > go over the wire, does make sense.
> > 
> 
> The NFS protocol doesn't have any alignment restrictions. The NFS
> client supports DIO, but doesn't enforce any sort of alignment
> restriction on userland.
> 
> > But I wouldn't think setting them to 1 valid.  Pretty sure they need
> > to be a power-of-2 (since they are used as masks passed to
> > iov_iter_is_aligned).
> > 
> 
> 2^0 == 1   :-)
> 
> This might be a good thing to bring up to the greater fsdevel
> community. What should filesystems that support DIO but don't enforce
> any alignment restrictions report for that attribute?
> 
> '1' would seem to be the natural thing to return in that case. Maybe we
> need to special case that in some of the helpers?
> 
> > In addition, we want to make sure NFS's default DIO alignment (which
> > isn't informed by actual DIO alignment advertised by NFSD's underlying
> > filesystem and hardware, e.g. XFS and NVMe) is able to be compatible
> > with both finer (512b) and coarser (4096b) grained DIO alignment.
> > Only way to achieve that would be to skew toward the coarse-grained
> > end of the spectrum, right?
> > 
> > More conservative but more likely to work with everything.
> > 
> 
> 
> I don't think NFS has ever enforced a particular alignment on userland,
> at least not with regular network transport. Does RDMA change this?

Not _exactly_ sure what you're asking.  But no, as you mentioned, NFS
doesn't have any DIO alignment constraints -- so it certainly isn't
imposing any.  I'm not looking to impose any either.  I'm just trying
to have NFSD and NFS offer a sane response in the reexport case ;)

One that doesn't limit the utility of NFSD doing work to shape the IO
so that it is compatible with the remote NFSD(s) by the time it gets
to an NFSD that _actually_ sits ontop of a local filesystem like XFS.
 
> In any case, I'm fine with taking this for now as a stopgap fix, but we
> should aim to plumb proper support for STATX_DIOALIGN in the client
> sometime soon. Applications are going to start using that attribute,
> and if they get back that it's unsupported, some may fail or fall back
> on buffered I/O on NFS.

That is a valid concern, maybe we'd do well to make it possible for
both NFSD _and_ NFS to avoid going over the wire if all that it is
asked to provide is STATX_DIOALIGN | STATX_DIO_READ_ALIGN (via
request_mask).

Currently, fh_getattr() is used (which expects to be querying a local
filesystem) so it is heavier than we need it to be given we're just
looking to populate the nfsd_file's DIO alignment attrs in
nfsd_file_getattr().

Mike

