Return-Path: <linux-nfs+bounces-15620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624DC07AAA
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 20:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF63D1C43D74
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9E42DEA79;
	Fri, 24 Oct 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+ltJ39j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CD33EB16
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329592; cv=none; b=gx3aYwSPXGMTaKbJWwY92GyMsbih1bY+rPpUTKAWdWA024a3FmfS3MUJw1XFmY3PaNsfOuZhacsvpIM9K34noTZriNBWf8blzI5wTqoLA8wB2TWGioIOWiFTHLQPzU6NtzfNwhj2aLGhoZ4HyinqQidUaRdeZBV/xK7QPHvp09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329592; c=relaxed/simple;
	bh=9VqaujscySv4qPG+DhtiCQr7r+BPtA58spCV03SWyM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG7MmDovtNrF4JiSMuB8iKomI2OtmJ31EXi8gxH5eHtDBDKFEBOqX7BS4SriWkTfyV5Egsi2ghTzFpJLiskFOwd3kNXZzD9uwEDw8bS+cXDzxka5UE64Q4haH79r9Lxi9GRELWEumqSBH4jSFSFcZ/cK//9ExOaVV+GXMriqtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+ltJ39j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E862C4CEF1;
	Fri, 24 Oct 2025 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761329591;
	bh=9VqaujscySv4qPG+DhtiCQr7r+BPtA58spCV03SWyM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+ltJ39jw/peskqNw3FTPTcuFubDDfuGttFmUZSMsOdODNMCR/sUKlHZdtC8u4/YX
	 nof4eYR9kcV+qVHG0lRdMyd26W5dk3TkUIfQMbrKsqavCu9QSCpZaU6rrTBY+n152d
	 zLbHRfHs4TxRayqMinlvGCXDAo41q4dJ0EEeq5zh7z8l+LZmU0Va68evv6ECGLyNPk
	 k7DrZPABT5FtZ2673tAPv9i0gdcQyyWFsDylGQr2Bsl+XQdt/BcvyTl65a0xbnBFmN
	 ah8+eqMDOFaJhZVFqv9qyek1GvQCGwXTBEWQra30upRfxKLu2LSiC85egMkNSUe/o0
	 y+y1F2aSafNJQ==
Date: Fri, 24 Oct 2025 14:13:09 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aPvBtWOIe9hJBrKC@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-15-cel@kernel.org>

On Fri, Oct 24, 2025 at 10:43:06AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Christoph says:
> > > +	if (file->f_op->fop_flags & FOP_DONTCACHE)
> > > +		kiocb->ki_flags |= IOCB_DONTCACHE;
> > IOCB_DONTCACHE isn't defined for IOCB_DIRECT.  So this should
> > move into a branch just for buffered I/O.
> 
> Instead, let's set up separate ki_flags for buffered I/O and for
> direct I/O requests. Then we don't have to set a jumble of flag
> bits in a single flags field.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index b0e4105e0075..b7b9f8cf0452 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1262,6 +1262,8 @@ struct nfsd_write_dio_seg {
>  
>  struct nfsd_write_dio_args {
>  	struct nfsd_file		*nf;
> +	int				flags_buffered;
> +	int				flags_direct;
>  	struct nfsd_write_dio_seg	segment[3];
>  };
>  
> @@ -1379,11 +1381,11 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		if (segment->len == 0)
>  			continue;
>  		if (segment->use_dio) {
> -			kiocb->ki_flags |= IOCB_DIRECT;
> +			kiocb->ki_flags = args->flags_direct;
>  			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
>  						segment->len);
>  		} else
> -			kiocb->ki_flags &= ~IOCB_DIRECT;
> +			kiocb->ki_flags = args->flags_buffered;
>  		host_err = vfs_iocb_iter_write(file, kiocb, &segment->iter);
>  		if (host_err < 0)
>  			return host_err;
> @@ -1405,30 +1407,27 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	struct nfsd_write_dio_args args;
>  
>  	/*
> -	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
> -	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
> -	 * be ignored for any DIO issued here).
> +	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
> +	 * writing unaligned segments or handling fallback I/O.
>  	 */
> +	args.flags_buffered = kiocb->ki_flags | IOCB_SYNC | IOCB_DSYNC;
>  	if (file->f_op->fop_flags & FOP_DONTCACHE)
> -		kiocb->ki_flags |= IOCB_DONTCACHE;
> +		args.flags_buffered |= IOCB_DONTCACHE;
>  
>  	/*
> -	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should persist
> -	 * both written data and dirty time stamps.
> -	 *
> -	 * When falling back to buffered I/O or handling the unaligned
> -	 * first and last segments, the data and time stamps must be
> -	 * durable before nfsd_vfs_write() returns to its caller, matching
> -	 * the behavior of direct I/O.
> +	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should
> +	 * persist both written data and dirty time stamps.
>  	 */
> -	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
> +	args.flags_direct = kiocb->ki_flags | IOCB_SYNC | IOCB_DIRECT;

AFAIK we still need: IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC

IOCB_DIRECT | IOCB_DSYNC was recently put under a microscope relative
to XFS performance and the resulting improvement was merged for 6.18
with commit c91d38b57f ("xfs: rework datasync tracking and execution")

Otherwise, everything else looks good, thanks.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

