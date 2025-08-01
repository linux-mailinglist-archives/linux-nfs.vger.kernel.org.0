Return-Path: <linux-nfs+bounces-13389-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2EB1892E
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Aug 2025 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9D21C21097
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A3228CA9;
	Fri,  1 Aug 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWouBCVd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AC1A256E
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754087385; cv=none; b=cHu1MrgkeeTKGH9j2SAP1u5+UlqZ2v1RIJGg2hyGhVwX7ZvfR15d70dq5T7IcXV2hQEFYhv7F9XMw5uCBiTFm+bmkqbfuAZISUcOyd6eShyUkqeY03g2eyEyPzEl5P3rW44Bmq2zb0gF5i5ODcT/lGNFc7vvqfjkjXoOmgXyZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754087385; c=relaxed/simple;
	bh=SPP9ELR4Z92PLVrWdPG75YUgIhoA4h8VOau4vMWsMdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS3ndQOuW3cveG0r1dp9/6f/J4kGGdJvtHjjJ9X2seb/lbdCVNimd1A6JWr9yIS1ZxGX7YfYcn5T1yOKEHstzNNTaqN4bNCZnm9dgwU+BnqwoB5hqxNPz9zUEZ5DwfM7vQLbbdoMtWUKP6HLB+ekzeiwSxUB/NfO/MwnmiJgLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWouBCVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445F5C4CEE7;
	Fri,  1 Aug 2025 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754087384;
	bh=SPP9ELR4Z92PLVrWdPG75YUgIhoA4h8VOau4vMWsMdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWouBCVd8Lav+EhNlC83SK5EbutrIqUzuP3RTbWPkrtoT2Ujpwqm5Q/v1/4dHarEp
	 lpevrR5RbGDOCt4J6A1ZPf+OpTRQMy619o4yXXj7B3Y/WP3V+KCQlit2rr93qYkQGk
	 gn8x2g+rgc/leL4D0prGjfomEd4F8n1sZOJUmMnV3iKAN9njJelZZiCJ1YElN2rUUq
	 DtEv2WXz0BJ4DC5uUEAbZfiC1mz9xpqUN2l71lIriz9UGXrPF8X9IHzXq7fIVT92JE
	 5ceVm3H5aecs7G3tpBsqoSqDfY5PoWb2KljZiPUy+xSRCVkRTjB8BaVE+XjVY3gSaT
	 c3cQE5zQXnRWw==
Date: Fri, 1 Aug 2025 18:29:43 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3 2/4] NFSD: prepare nfsd_vfs_write() to use O_DIRECT on
 misaligned WRITEs
Message-ID: <aI0_12zwHYRPOS3t@kernel.org>
References: <20250731230633.89983-1-snitzer@kernel.org>
 <20250731230633.89983-3-snitzer@kernel.org>
 <27aecf85-059f-4789-bcfc-b518a2643e19@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27aecf85-059f-4789-bcfc-b518a2643e19@oracle.com>

On Fri, Aug 01, 2025 at 04:52:38PM -0400, Chuck Lever wrote:
> On 7/31/25 7:06 PM, Mike Snitzer wrote:
> > Refactor nfsd_vfs_write() to support splitting a WRITE into parts
> > (which will be either misaligned or DIO-aligned).  Doing so in a
> > preliminary commit just allows for indentation and slight
> > transformation to be more easily understood and reviewed.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/vfs.c | 45 +++++++++++++++++++++++++++------------------
> >  1 file changed, 27 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 35c29b8ade9c3..edac73349da0f 100644
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
> > @@ -1399,22 +1402,28 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	since = READ_ONCE(file->f_wb_err);
> >  	if (verf)
> >  		nfsd_copy_write_verifier(verf, nn);
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
> > -
> > -	if (stable && fhp->fh_use_wgather) {
> > -		host_err = wait_for_concurrent_writes(file);
> > -		if (host_err < 0)
> > +	*cnt = 0;
> > +	for (int i = 0; i < n_iters; i++) {
> > +		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
> > +		if (host_err < 0) {
> >  			commit_reset_write_verifier(nn, rqstp, host_err);
> > +			goto out_nfserr;
> > +		}
> 
> Does this loop wait after each iter is written? Would it be better to
> wait once after all the iters have been written?

It does, sorry about that. This incremental fixes it up and is easily
folded into this patch:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2eabcb5651ba..1590fc1fb420 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1533,19 +1533,17 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		}
 		*cnt += host_err;
 		nfsd_stats_io_write_add(nn, exp, host_err);
+	}
 
-		fsnotify_modify(file);
-		host_err = filemap_check_wb_err(file->f_mapping, since);
+	fsnotify_modify(file);
+	host_err = filemap_check_wb_err(file->f_mapping, since);
+	if (host_err < 0)
+		goto out_nfserr;
+
+	if (stable && fhp->fh_use_wgather) {
+		host_err = wait_for_concurrent_writes(file);
 		if (host_err < 0)
-			goto out_nfserr;
-
-		if (stable && fhp->fh_use_wgather) {
-			host_err = wait_for_concurrent_writes(file);
-			if (host_err < 0) {
-				commit_reset_write_verifier(nn, rqstp, host_err);
-				goto out_nfserr;
-			}
-		}
+			commit_reset_write_verifier(nn, rqstp, host_err);
 	}
 
 out_nfserr:

