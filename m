Return-Path: <linux-nfs+bounces-13351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA77AB17754
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 22:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FF8548E37
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB101D52B;
	Thu, 31 Jul 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WThTpgfL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0382135AC
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994967; cv=none; b=cPFOYUTHBI5cgZlOb+lc9rIDQC2cj/aua5q2FPFT62XtCuTV0NqJm3Ui2A13IvzZfnPrq8phhJ5ghSkis1K3Wsw4M46lYp7XNI87gv37eZ9LIoQTTx1+7VPdbIoTxnZL9psl9SrwgAsA3j45MdZM9TS1U44eQEVxFWje4KEI6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994967; c=relaxed/simple;
	bh=lYCWaldKA/oLlOeqhcNXG+Lo2tPLxppDugaRnc28NdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bls1knNvGNRgqrLw1YR1l3WlNaFOv0BixmQ7rRcNbnF2kTSIBkLKKAwAcUUqnh4cNo2DQmyc/n/dRVhMb0Q2dV6Zx06H5gsg4xWxOyNQBdfcoiuQUtbzC57f4Ex6q31UGxZZpO6GfXAtcXvUBPLb0jOKL9Esivu4gAaEWIp1LTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WThTpgfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68260C4CEEF;
	Thu, 31 Jul 2025 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753994967;
	bh=lYCWaldKA/oLlOeqhcNXG+Lo2tPLxppDugaRnc28NdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WThTpgfLNYRmRyLjUP3ExA/JsD9v/oGnWtpTScliU02Zyj+T7Zd49YkCal45OvHKd
	 bKKU3mgI+YuClv6AYFOsiqQjtMrK6/GcnBRBENHtqB2lGBLl5kDMdcEMIfVMdu+EYK
	 ZXaNsu7Jhj9J6L7byn4d13GjpFaoQTv257aLzkbSUfTOowHv/3MLwggvGZlJum6+pO
	 FxKQn6MKANLsYS8qEU0NxIOiUga6o/R7GMo82zj1vZgn0nf2INfOyBMHREx5DlOwLO
	 m75KcTKsyYea1hAK1jIHrfYifL4FZ5jpf1xB7LsovdkqcDPJWY2pYS9tziV5ZeW0sH
	 uOtrrWrhYTv3Q==
Date: Thu, 31 Jul 2025 16:49:25 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] NFSD: prepare nfsd_vfs_write() to use O_DIRECT on
 misaligned WRITEs
Message-ID: <aIvW1bIpgWAnHCZR@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
 <20250731194448.88816-3-snitzer@kernel.org>
 <f5cf9ee0567c3971323412d6384da5d3f80e6b5d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5cf9ee0567c3971323412d6384da5d3f80e6b5d.camel@kernel.org>

On Thu, Jul 31, 2025 at 04:28:13PM -0400, Jeff Layton wrote:
> On Thu, 2025-07-31 at 15:44 -0400, Mike Snitzer wrote:
> > Refactor nfsd_vfs_write() to support splitting a WRITE into parts
> > (which will be either misaligned or DIO-aligned).  Doing so in a
> > preliminary commit just allows for indentation and slight
> > transformation to be more easily understood and reviewed.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/vfs.c | 50 ++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 30 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 35c29b8ade9c3..e4855c32dad12 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1341,7 +1341,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	struct super_block	*sb = file_inode(file)->i_sb;
> >  	struct kiocb		kiocb;
> >  	struct svc_export	*exp;
> > -	struct iov_iter		iter;
> >  	errseq_t		since;
> >  	__be32			nfserr;
> >  	int			host_err;
> > @@ -1349,6 +1348,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	unsigned int		pflags = current->flags;
> >  	bool			restore_flags = false;
> >  	unsigned int		nvecs;
> > +	struct iov_iter		iter_stack[1];
> > +	struct iov_iter		*iter = iter_stack;
> > +	unsigned int		n_iters = 0;
> >  
> >  	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
> >  
> > @@ -1378,14 +1380,15 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		kiocb.ki_flags |= IOCB_DSYNC;
> >  
> >  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> > -	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > +	iov_iter_bvec(&iter[0], ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > +	n_iters++;
> >  
> >  	switch (nfsd_io_cache_write) {
> >  	case NFSD_IO_DIRECT:
> >  		/* direct I/O must be aligned to device logical sector size */
> >  		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
> >  		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0) &&
> > -		    iov_iter_is_aligned(&iter, nf->nf_dio_mem_align - 1,
> > +		    iov_iter_is_aligned(&iter[0], nf->nf_dio_mem_align - 1,
> >  					nf->nf_dio_offset_align - 1))
> >  			kiocb.ki_flags = IOCB_DIRECT;
> >  		break;
> > @@ -1396,25 +1399,32 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		break;
> >  	}
> >  
> > -	since = READ_ONCE(file->f_wb_err);
> > -	if (verf)
> > -		nfsd_copy_write_verifier(verf, nn);
> > -	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
> > -	if (host_err < 0) {
> > -		commit_reset_write_verifier(nn, rqstp, host_err);
> > -		goto out_nfserr;
> > -	}
> > -	*cnt = host_err;
> > -	nfsd_stats_io_write_add(nn, exp, *cnt);
> > -	fsnotify_modify(file);
> > -	host_err = filemap_check_wb_err(file->f_mapping, since);
> > -	if (host_err < 0)
> > -		goto out_nfserr;
> > +	*cnt = 0;
> > +	for (int i = 0; i < n_iters; i++) {
> > +		since = READ_ONCE(file->f_wb_err);
> 
> The above assignment can stay outside the loop. No need to resample it
> on every pass, and doing that could cause you to miss errors.
> 
> > +		if (verf)
> > +			nfsd_copy_write_verifier(verf, nn);
> >  
> 
> The verf doesn't need to be copied every time either.

OK, ack to both, will fix.
 
> > -	if (stable && fhp->fh_use_wgather) {
> > -		host_err = wait_for_concurrent_writes(file);
> > -		if (host_err < 0)
> > +		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
> > +		if (host_err < 0) {
> >  			commit_reset_write_verifier(nn, rqstp, host_err);
> > +			goto out_nfserr;
> > +		}
> > +		*cnt += host_err;
> > +		nfsd_stats_io_write_add(nn, exp, host_err);
> > +
> > +		fsnotify_modify(file);
> > +		host_err = filemap_check_wb_err(file->f_mapping, since);
> > +		if (host_err < 0)
> > +			goto out_nfserr;
> > +
> > +		if (stable && fhp->fh_use_wgather) {
> > +			host_err = wait_for_concurrent_writes(file);
> > +			if (host_err < 0) {
> > +				commit_reset_write_verifier(nn, rqstp, host_err);
> > +				goto out_nfserr;
> > +			}
> > +		}
> >  	}
> >  
> >  out_nfserr:
> 
> The rest looks good though.

Thanks for the review!

