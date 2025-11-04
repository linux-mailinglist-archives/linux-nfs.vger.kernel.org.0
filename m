Return-Path: <linux-nfs+bounces-16022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07393C325F2
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 18:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB16E3A5D0E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30524DCE2;
	Tue,  4 Nov 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpEQc0R4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161012F1FF6
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277718; cv=none; b=RCA69qsMgqnkYRPhUnq9nuYvIsOpMRA2X/OBss3td5H5x53S4RuzJGIeMllHySu7iScvKqojMQ0kVHGsskldOHlqpqOVgdCBXeOCGGMYp6E1WmIUc7hGiXjhhjBH3KxNfERyXi7+/UMqIQBs+JcUi0bvvcYEqCkuXLUL0R0DOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277718; c=relaxed/simple;
	bh=mFJYgV+xHY3c2SdMe3HijvkZ14uUGqa93ZZUtVTlRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VklD7fzUpxmmwMtymEeDOhIyabnGqNC1KQ+c7qmLzxkXVJVIa91RKDoWOqJTZwZW0VjkV4jN41VgE14PLL/frq/nqNF2sU7dtCuam+vnzuVoQQBQ89VQ0pKqvrUdC3y8Js3HIY1WHoRMSAu7mAJeyWhhL0eZAFMNmuxbDIJGIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpEQc0R4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A25C4CEF7;
	Tue,  4 Nov 2025 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762277717;
	bh=mFJYgV+xHY3c2SdMe3HijvkZ14uUGqa93ZZUtVTlRKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpEQc0R4tNtsQFWcwVeQ+Rvh5MS2A7dQ15vYbFCghh2pRs39IxCGJODh+qZu3WPkE
	 +nLKJExzlo5P0O15ydNu3oIuAfx+h0NACPYkyVJziVMBFjGpylBnGEeZSxz636q9Lu
	 PynFz49x0ZcZu5EZwBIt1gH0CHuRusBg2K5RDPQMXZqoRQlJGur305tl0srCMfFWng
	 AgA4n3Fi4d0QxhIH1+rQSRnJTdKs6K6sPWLw4151SK+qR5OJ6gMzEdADLrASTt/H5I
	 33XvA/76XL94wacHQwdkg3Y+xLjNU3/+4t0dC7xhyIMpvfIFbldRlLkkejasQV+ASc
	 OsR4YQAmMPCaw==
Date: Tue, 4 Nov 2025 12:35:16 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: avoid using DONTCACHE for misaligned DIO's
 buffered IO fallback
Message-ID: <aQo5VOxRpr-HORf3@kernel.org>
References: <20251104164229.43259-1-snitzer@kernel.org>
 <20251104164229.43259-2-snitzer@kernel.org>
 <038374d0-6f09-4440-bd99-fbeef8f6d683@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038374d0-6f09-4440-bd99-fbeef8f6d683@oracle.com>

On Tue, Nov 04, 2025 at 12:23:02PM -0500, Chuck Lever wrote:
> On 11/4/25 11:42 AM, Mike Snitzer wrote:
> > Also, use buffered IO (without DONTCACHE) if READ is less than 32K.
> > But do use DONTCACHE if an entire WRITE is misaligned, this preserves
> > intent of NFSD_IO_DIRECT.
> 
> These two changes need to be separate patches.

They are linked, otherwise if READ uses DONTCACHE for the small IO
it'll kill any benefit to RMW.

Unless I'm misunderstanding which two changes you're referring to?

The "But do use DONTCACHE if an entire WRITE is misaligned" just
amounts to a comment tweak in nfsd_direct_write (last hunk below)

> > The misaligned ends of a misaligned DIO WRITE will use buffered IO
> > (without DONTCACHE) but the middle DIO-aligned segment with use direct
> > IO.  This provides ideal performance for streaming misaligned DIO
> > (e.g. IO500's IOR_HARD) because buffered IO is used to benefit RMW.
> > 
> > On one capable testbed, this commit improved IOR_HARD WRITE
> > performance from 0.3433GB/s to 1.26GB/s.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> > ---
> >  fs/nfsd/vfs.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 701dd261c252..9403ec8bb2da 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -104,6 +104,7 @@ nfserrno (int errno)
> >  		{ nfserr_perm, -ENOKEY },
> >  		{ nfserr_no_grace, -ENOGRACE},
> >  		{ nfserr_io, -EBADMSG },
> > +		{ nfserr_eagain, -ENOTBLK },
> >  	};
> >  	int	i;
> >  
> > @@ -1099,13 +1100,18 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	size_t len;
> >  
> >  	init_sync_kiocb(&kiocb, nf->nf_file);
> > -	kiocb.ki_flags |= IOCB_DIRECT;
> >  
> >  	/* Read a properly-aligned region of bytes into rq_bvec */
> >  	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
> >  	dio_end = round_up((u64)offset + *count, nf->nf_dio_read_offset_align);
> >  
> > +	/* Don't use expanded DIO READ for IO less than 32K */
> > +	if ((*count < (32 << 10)) &&
> > +	    (((offset - dio_start) > 0) || ((dio_end - (offset + *count)) > 0)))
> > +		return nfserrno(-ENOTBLK); /* fallback to buffered */
> 
> Why not just return a specific nfserr code here? No need to go through
> nfserrno.

Could, I just tethered it to ENOTBLK given the history of such things
elsewhere for direct to buffered fallback.  But yes, could just as
easily simply return nfserr_eagain (or some other better suggestion).

> > +
> >  	kiocb.ki_pos = dio_start;
> > +	kiocb.ki_flags |= IOCB_DIRECT;
> >  
> >  	v = 0;
> >  	total = dio_end - dio_start;
> > @@ -1184,10 +1190,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		break;
> >  	case NFSD_IO_DIRECT:
> >  		/* When dio_read_offset_align is zero, dio is not supported */
> > -		if (nf->nf_dio_read_offset_align && !rqstp->rq_res.page_len)
> > -			return nfsd_direct_read(rqstp, fhp, nf, offset,
> > +		if (nf->nf_dio_read_offset_align && !rqstp->rq_res.page_len) {
> > +			__be32 nfserr = nfsd_direct_read(rqstp, fhp, nf, offset,
> >  						count, eof);
> > -		fallthrough;
> > +			if (nfserr != nfserr_eagain)
> > +				return nfserr;
> > +		}
> > +		break; /* fallback to buffered */
> >  	case NFSD_IO_DONTCACHE:
> >  		if (file->f_op->fop_flags & FOP_DONTCACHE)
> >  			kiocb.ki_flags = IOCB_DONTCACHE;
> > @@ -1347,6 +1356,15 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
> >  		++args->nsegs;
> >  	}
> >  
> > +	/*
> > +	 * Don't use IOCB_DONTCACHE if misaligned DIO WRITE (args->nsegs > 1),
> > +	 * because it compromises unaligned segments' RMW IO being able to
> > +	 * benefit from buffered IO (especially important for streaming
> > +	 * misaligned DIO WRITE performance).
> > +	 */
> > +	if (args->nsegs > 1 && (args->flags_buffered & IOCB_DONTCACHE))
> > +		args->flags_buffered &= ~IOCB_DONTCACHE;
> > +
> >  	return;
> >  
> >  no_dio:
> > @@ -1400,7 +1418,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  
> >  	/*
> >  	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
> > -	 * writing unaligned segments or handling fallback I/O.
> > +	 * falling back to buffered IO if entire WRITE is unaligned.
> >  	 */
> >  	args.flags_buffered = kiocb->ki_flags;
> >  	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> 
> 
> -- 
> Chuck Lever

