Return-Path: <linux-nfs+bounces-13466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB338B1C966
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 17:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C25B1696B4
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68D1B040B;
	Wed,  6 Aug 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FENhpd0j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0128C010
	for <linux-nfs@vger.kernel.org>; Wed,  6 Aug 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495864; cv=none; b=sQWIYPkTOnRHH+QKn4CRHkW6WM4rULtZLUZLQLIYp+KvrXCDguFNGCxrLkmhwZBqXJVAZmvlWWtM6ARlD6uX3N7Ln6l2rAftUuKDRqrj27gzJGVu28TtgjKpNpxFb0dDxUQcHxCV2/qhpHF4TqStANw9p2KLb6gMwUdDKlnijOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495864; c=relaxed/simple;
	bh=bwXjD7xXrLQU0UrJ8oLK9oXDlJB9v63FdwMvTi1jHos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFL9+/PhYXOvvUHwkirbXaF0rS1auL/N28noyO5f7oNK+JBrb/6reeGNsfv94UGAK/tUNRxxcaw2C3Zl9RrYF8/hasaB9rPc5NwWCt37zZzlJmqiSM1HJ2gVVjyi8ppifpydDR5PesMZo73AeZfYe3eaons0QTw79q9BF/AFtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FENhpd0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA620C4CEE7;
	Wed,  6 Aug 2025 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754495864;
	bh=bwXjD7xXrLQU0UrJ8oLK9oXDlJB9v63FdwMvTi1jHos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FENhpd0jwK5CeyouB6fdM93EyloJB5QGKeo40TdKa7ywGz8dztu2iCJXacWK+tnzm
	 lz8U8KTsHsPWa96aWqyREmveTta0GBTWiGsNW7NtHYeggaV+0+X6cRlfR3gxphy8Xf
	 glowB51bNCkXFkTe1MUC37B2mq8HdUFSoOBvkS+4SXOVDFRbA1jbJ9jUQ+7+0CYii3
	 Gmts7MjwBymMa4u7ixW9s32rtp7fuSbAKjNEWb9kToJZy+4xbCvfvFx/2CXN4PJ2FX
	 6sVW+hYMYbkYC1Fly1MKHq0nDmb4R+DPC7rCo3ED2ca2rsTOkc4ajYRXZvXMnYADcs
	 C6ngK+rxrTGog==
Date: Wed, 6 Aug 2025 11:57:42 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/4] NFSD: avoid using iov_iter_is_aligned() in
 nfsd_iter_read()
Message-ID: <aJN7dr37mo1LXkQx@kernel.org>
References: <20250805184428.5848-1-snitzer@kernel.org>
 <20250805184428.5848-2-snitzer@kernel.org>
 <d3249463-411d-4e0d-aa20-6489cd52c787@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3249463-411d-4e0d-aa20-6489cd52c787@oracle.com>

On Wed, Aug 06, 2025 at 09:18:51AM -0400, Chuck Lever wrote:
> On 8/5/25 2:44 PM, Mike Snitzer wrote:
> > From: Mike Snitzer <snitzer@hammerspace.com>
> > 
> > Check the bvec is DIO-aligned while creating it, saves CPU cycles by
> > avoiding iterating the bvec elements a second time using
> > iov_iter_is_aligned().
> > 
> > This prepares for Keith Busch's near-term removal of the
> > iov_iter_is_aligned() interface.  This fixes cel/nfsd-testing commit
> > 5d78ac1e674b4 ("NFSD: issue READs using O_DIRECT even if IO is
> > misaligned") and it should be folded into that commit so that NFSD
> > doesn't require iov_iter_is_aligned() while it is being removed
> > upstream in parallel.
> > 
> > Fixes: cel/nfsd-testing 5d78ac1e674b4 ("NFSD: issue READs using O_DIRECT even if IO is misaligned")
> > Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> > ---
> >  fs/nfsd/vfs.c | 29 +++++++++++++++--------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 46189020172fb..e1751d3715264 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1226,7 +1226,10 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  			 */
> >  			offset = read_dio.start;
> >  			in_count = read_dio.end - offset;
> > -			kiocb.ki_flags = IOCB_DIRECT;
> > +			/* Verify ondisk DIO alignment, memory addrs checked below */
> > +			if (likely(((offset | in_count) &
> > +				    (nf->nf_dio_read_offset_align - 1)) == 0))
> > +				kiocb.ki_flags = IOCB_DIRECT;
> >  		}
> >  	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
> >  		kiocb.ki_flags = IOCB_DONTCACHE;
> > @@ -1236,16 +1239,24 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	v = 0;
> >  	total = in_count;
> >  	if (read_dio.start_extra) {
> > -		bvec_set_page(&rqstp->rq_bvec[v++], read_dio.start_extra_page,
> > +		bvec_set_page(&rqstp->rq_bvec[v], read_dio.start_extra_page,
> >  			      read_dio.start_extra, PAGE_SIZE - read_dio.start_extra);
> > +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
> > +			     rqstp->rq_bvec[v].bv_offset & (nf->nf_dio_mem_align - 1)))
> > +			kiocb.ki_flags &= ~IOCB_DIRECT;
> >  		total -= read_dio.start_extra;
> > +		v++;
> >  	}
> >  	while (total) {
> >  		len = min_t(size_t, total, PAGE_SIZE - base);
> > -		bvec_set_page(&rqstp->rq_bvec[v++], *(rqstp->rq_next_page++),
> > -			      len, base);
> > +		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base);
> > +		/* No need to verify memory is DIO-aligned since bv_offset is 0 */
> > +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) && base &&
> > +			     (base & (nf->nf_dio_mem_align - 1))))
> > +			kiocb.ki_flags &= ~IOCB_DIRECT;
> >  		total -= len;
> >  		base = 0;
> > +		v++;
> >  	}
> >  	if (WARN_ONCE(v > rqstp->rq_maxpages,
> >  		      "%s: v=%lu exceeds rqstp->rq_maxpages=%lu\n", __func__,
> > @@ -1256,16 +1267,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	if (!host_err) {
> >  		trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
> >  		iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
> > -
> > -		/* Double check nfsd_analyze_read_dio's DIO-aligned result */
> > -		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
> > -			     !iov_iter_is_aligned(&iter,
> > -				nf->nf_dio_mem_align - 1,
> > -				nf->nf_dio_read_offset_align - 1))) {
> > -			/* Fallback to buffered IO */
> > -			kiocb.ki_flags &= ~IOCB_DIRECT;
> > -		}
> > -
> >  		host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
> >  	}
> >  
> 
> Hi Mike,
> 
> In cases where the SQUASHME patch is this large, I usually drop the
> patch (or series) in nfsd-testing and ask the contributor to rebase and
> repost. This gets the new version of the patch properly archived on
> lore, for one thing.

Yeah, make sense, I missed that iov_iter_is_aligned() was used early
on in the series too, so I'll fixup further back.
 
> Before reposting, please do run checkpatch.pl on the series.

Will do, will also ensure bisect safe and that sparse is happy.

Thanks,
Mike

