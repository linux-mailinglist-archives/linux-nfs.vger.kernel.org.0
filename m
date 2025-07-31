Return-Path: <linux-nfs+bounces-13358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE590B17869
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 23:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED35417C823
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233625FA00;
	Thu, 31 Jul 2025 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/lW3Ats"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD820B22
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753998492; cv=none; b=Pl9w7HcgEqALQ+ntZUvL3clnFaEj8AMJaTYChbBhbM6tHkNVAt1A51SZjVdXqVn/2rSxhUe8Ae808WqIAhsp6D/AQFFxxb9Wi5YkAORQBWS/hzIO0CDD8JQi8u266MgsYyLcmS086WmN2cq3j6rWNY7B8/ia+TmxTRV8ldViHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753998492; c=relaxed/simple;
	bh=tELZM6tfOd/6jmTCh0tHaqQ/JCcqKOnMMiMExedqeDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeCboECdzvgdRITRPrCwNEsU6NswnDrRQryKVTKVnrBP99v7vqFuJvUykrWCthFxprt5c2hgjwBnkeVJXMdSk3U4Txh13YLmCzjd7PNopx7b+wmMDv8VsPCBedT3GeobtYWXYQ7m0uAPk6yunYhgFV7d8Q2XPz7nCW/itVbEdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/lW3Ats; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A5BC4CEEF;
	Thu, 31 Jul 2025 21:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753998492;
	bh=tELZM6tfOd/6jmTCh0tHaqQ/JCcqKOnMMiMExedqeDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/lW3Atswxi6i6nGt1xsgpDBfQIfj4VSSPTqyFj8htoN15hLzdcd6Y3HISYJ6qwii
	 MbBOjUshyh3JWmeJUNzQa0Et9gVKgCb9DgrF7VrC/YmuCBF0CTwRwEN1Ui2jnpzsop
	 jIHTyZ0nOACYUxQPWj84v3UNbJ8cxABVezwVCHt5bJKlxtj3jpSpYEoGV6yzgGm33d
	 JFkVZ89xjZHnWCjKCSbmb3R+OfwYUupRbNgSXEy8OQSjC5fBOcAHCohowATp51m3c8
	 0qaQA9smRkJFLtWmxSZE+hInKiV+3UXQOJfcSb2T9HsvekaZoFLPu8KwW96a2FeJWW
	 L4laqZ99tCtwA==
Date: Thu, 31 Jul 2025 17:48:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH v2 4/4] NFSD: handle unaligned DIO for NFS reexport
Message-ID: <aIvkm_O4ff3vIKAM@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
 <20250731194448.88816-5-snitzer@kernel.org>
 <b5e2e433e70189b4ed05417f8bdb2ff98a82881e.camel@kernel.org>
 <aIvf7VqSeNE3Ma1m@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIvf7VqSeNE3Ma1m@kernel.org>

On Thu, Jul 31, 2025 at 05:28:13PM -0400, Mike Snitzer wrote:
> On Thu, Jul 31, 2025 at 04:58:00PM -0400, Jeff Layton wrote:
> > On Thu, 2025-07-31 at 15:44 -0400, Mike Snitzer wrote:
> > > NFS doesn't have any DIO alignment constraints but it doesn't support
> > > STATX_DIOALIGN, so update NFSD such that it doesn't disable the use of
> > > NFSD_IO_DIRECT if it is reexporting NFS.
> > > 
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfs/export.c          |  3 ++-
> > >  fs/nfsd/filecache.c      | 11 +++++++++++
> > >  include/linux/exportfs.h | 13 +++++++++++++
> > >  3 files changed, 26 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > > index e9c233b6fd209..2cae75ba6b35d 100644
> > > --- a/fs/nfs/export.c
> > > +++ b/fs/nfs/export.c
> > > @@ -155,5 +155,6 @@ const struct export_operations nfs_export_ops = {
> > >  		 EXPORT_OP_REMOTE_FS		|
> > >  		 EXPORT_OP_NOATOMIC_ATTR	|
> > >  		 EXPORT_OP_FLUSH_ON_CLOSE	|
> > > -		 EXPORT_OP_NOLOCKS,
> > > +		 EXPORT_OP_NOLOCKS		|
> > > +		 EXPORT_OP_NO_DIOALIGN_NEEDED,
> > >  };
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 5601e839a72da..ea489dd44fd9a 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -1066,6 +1066,17 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
> > >  	     nfsd_io_cache_write != NFSD_IO_DIRECT))
> > >  		return nfs_ok;
> > >  
> > > +	if (exportfs_handles_unaligned_dio(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
> > > +		/* Underlying filesystem doesn't support STATX_DIOALIGN
> > > +		 * but it can handle all unaligned DIO, so establish
> > > +		 * DIO alignment that is accommodating.
> > > +		 */
> > > +		nf->nf_dio_mem_align = 4;
> > > +		nf->nf_dio_offset_align = PAGE_SIZE;
> > > +		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
> > > +		return nfs_ok;
> > > +	}
> > > +
> > >  	status = fh_getattr(fhp, &stat);
> > >  	if (status != nfs_ok)
> > >  		return status;
> > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > index 9369a607224c1..626b8486dd985 100644
> > > --- a/include/linux/exportfs.h
> > > +++ b/include/linux/exportfs.h
> > > @@ -247,6 +247,7 @@ struct export_operations {
> > >  						*/
> > >  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
> > >  #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
> > > +#define EXPORT_OP_NO_DIOALIGN_NEEDED	(0x80) /* fs can handle unaligned DIO */
> > >  	unsigned long	flags;
> > >  };
> > >  
> > > @@ -262,6 +263,18 @@ exportfs_cannot_lock(const struct export_operations *export_ops)
> > >  	return export_ops->flags & EXPORT_OP_NOLOCKS;
> > >  }
> > >  
> > > +/**
> > > + * exportfs_handles_unaligned_dio() - check if export can handle unaligned DIO
> > > + * @export_ops:	the nfs export operations to check
> > > + *
> > > + * Returns true if the export can handle unaligned DIO.
> > > + */
> > > +static inline bool
> > > +exportfs_handles_unaligned_dio(const struct export_operations *export_ops)
> > > +{
> > > +	return export_ops->flags & EXPORT_OP_NO_DIOALIGN_NEEDED;
> > > +}
> > > +
> > >  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> > >  				    int *max_len, struct inode *parent,
> > >  				    int flags);
> > 
> > 
> > Would it not be simpler (better?) to add support for STATX_DIOALIGN to
> > NFS, and just have it report '1' for both values?
> 
> I suppose adding NFS support for STATX_DIOALIGN, that doesn't actually
> go over the wire, does make sense.
> 
> But I wouldn't think setting them to 1 valid.  Pretty sure they need
> to be a power-of-2 (since they are used as masks passed to
> iov_iter_is_aligned).
> 
> In addition, we want to make sure NFS's default DIO alignment (which
> isn't informed by actual DIO alignment advertised by NFSD's underlying
> filesystem and hardware, e.g. XFS and NVMe) is able to be compatible
> with both finer (512b) and coarser (4096b) grained DIO alignment.
> Only way to achieve that would be to skew toward the coarse-grained
> end of the spectrum, right?
> 
> More conservative but more likely to work with everything.

Thinking/looking further: I really do prefer the approach I took in
this patch (over the suggestion to implement STATX_DIOALIGN for NFS).

Otherwise NFS would forced to needlessly issue an RPC via fh_getattr()
even though we're talking about NFS faking its STATX_DIOALIGN response
(so it doesn't need to do the work to do a full-blown GETATTR).

This would be wasteful for the NFS reexport usecase.

