Return-Path: <linux-nfs+bounces-14450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B161B5813C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6BC188331A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498362192F9;
	Mon, 15 Sep 2025 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXB+XS6A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B7921146C
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951227; cv=none; b=L/y6B8QdqjfjIVjNxb1aeiMKzygyIKnZEMRPq6SvGXjim2BhMRibMfjxmPmGgMECX0YhS5o5EXg666oQgP+JvTIuCSf0RVBAUVcJL/om+oWMC5OApE+L84GFIalGj/gYx8pdYOtrHZFP5y3SfsOAvStI+Y2K3sNUH597lHgXGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951227; c=relaxed/simple;
	bh=R0y3cFM+qJRc8lRV73KCDmsdJPGSlTxXGex/hXFdt5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W52ZcdXCiOn/jTo1fhtvGtjd4U6X7YGExyKNEwxEeDOtUJHsqkzlxUuZ2N28vBz5Ss814CXlkin/vgxbZi3iZM1J0P5raYofvzg4rhz+4nme5Wvx++yNqfAKYi6ZkXoobbNs72jAZANSH7iKg6+mYoddACNUcVP6NG6bC0/qdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXB+XS6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EF3C4CEF1;
	Mon, 15 Sep 2025 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951226;
	bh=R0y3cFM+qJRc8lRV73KCDmsdJPGSlTxXGex/hXFdt5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXB+XS6AY8WGWQUm1dqT9wleArTOnGCV9ixpsK/QMMsImBCwmhC9X7c5GU850F4/W
	 IuAaeNM/Sn/+kpqiZ1/cNYcVWr4llirOKV5uG+oeZ0Fk7NLbcmiYwkIYUqFBpnS9uY
	 SDs05TIi96/1DcveF4K1eLJHZexwH097Vo69ySMSHaBRtyG/80YNa9/a9O4rFOdIZ0
	 7ixvSSbC0p8iIkZt1mkFbcxjSDxo8DoORSgbGNuPfFtpceXxDQQdsOqIiFnQBo6WmV
	 d46+rokQsbzZ6YyhOUhy7WXreFHCew648/uLTNpOf/zykr/iUdpkzyrR8sT+lvL1B1
	 GPCTiRi/bTVrQ==
Date: Mon, 15 Sep 2025 11:47:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 5/7] nfs/localio: add proper O_DIRECT support for READ and
 WRITE
Message-ID: <aMg0-Q4-BNbor2XR@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
 <20250915154115.19579-6-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915154115.19579-6-snitzer@kernel.org>

The subject for this patch got messed up (should've used
git-send-email's --dry-run like I generally always do).

Subject: nfs/localio: add proper O_DIRECT support for READ and WRITE

On Mon, Sep 15, 2025 at 11:41:13AM -0400, Mike Snitzer wrote:
> Because the NFS client will already happily handle misaligned O_DIRECT
> IO (by sending it out to NFSD via RPC) this commit's new capabilities
> are for the benefit of LOCALIO.
> 
> LOCALIO will make best effort to transform misaligned IO to
> DIO-aligned extents when possible.
> 
> LOCALIO's READ and WRITE DIO that is misaligned will be split into as
> many as 3 component IOs (@start, @middle and @end) as needed -- IFF
> the @middle extent is verified to be DIO-aligned, and then the @start
> and/or @end are misaligned (due to each being a partial page).
> Otherwise if the @middle isn't DIO-aligned the code will fallback to
> issuing only a single contiguous buffered IO.
> 
> The @middle is only DIO-aligned if both the memory and on-disk offsets
> for the IO are aligned relative to the underlying local filesystem's
> block device limits (@dma_alignment and @logical_block_size
> respectively).
> 
> The misaligned @start and/or @end extents are issued using buffered IO
> and the DIO-aligned @middle is issued using O_DIRECT. The @start and
> @end IOs are issued first using buffered IO and then the @middle is
> issued last using direct IO with async completion (AIO). This out of
> order IO completion means that LOCALIO's IO completion code
> (nfs_local_read_done and nfs_local_write_done) is only called for the
> IO's last associated iov_iter completion. And in the case of
> DIO-aligned @middle it completes last using AIO. nfs_local_pgio_done()
> is updated to handle piece-wise partial completion of each iov_iter.
> 
> This implementation for LOCALIO's misaligned DIO handling uses 3
> iov_iter that share the same backing pages in their bio_vecs (so
> unfortunately 'struct nfs_local_kiocb' has 3 instead of only 1).
> 
> [Reducing LOCALIO's per-IO (struct nfs_local_kiocb) memory use can be
> explored in the future. One logical progression to improve this code,
> and eliminate explicit loops over up to 3 iov_iter, is by extending
> 'struct iov_iter' to support iov_iter_clone() and iov_iter_chain()
> interfaces that are comparable to what 'struct bio' is able to support
> in the block layer. But even that wouldn't avoid the need to
> allocate/use up to 3 iov_iter]
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c | 249 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 203 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 82894962966e8..92e5378ad63c6 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -30,14 +30,23 @@
>  
>  #define NFSDBG_FACILITY		NFSDBG_VFS
>  
> +#define NFSLOCAL_MAX_IOS	3
> +
>  struct nfs_local_kiocb {
>  	struct kiocb		kiocb;
>  	struct bio_vec		*bvec;
>  	struct nfs_pgio_header	*hdr;
>  	struct work_struct	work;
>  	void (*aio_complete_work)(struct work_struct *);
> -	struct iov_iter		iter ____cacheline_aligned;
>  	struct nfsd_file	*localio;
> +	/* Begin mostly DIO-specific members */
> +	size_t                  end_len;
> +	short int		end_iter_index;
> +	short int		n_iters;
> +	bool			iter_is_dio_aligned[NFSLOCAL_MAX_IOS];
> +	loff_t                  offset[NFSLOCAL_MAX_IOS] ____cacheline_aligned;
> +	struct iov_iter		iters[NFSLOCAL_MAX_IOS];
> +	/* End mostly DIO-specific members */
>  };
>  
>  struct nfs_local_fsync_ctx {
> @@ -291,7 +300,7 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  {
>  	struct nfs_local_kiocb *iocb;
>  
> -	iocb = kmalloc(sizeof(*iocb), flags);
> +	iocb = kzalloc(sizeof(*iocb), flags);
>  	if (iocb == NULL)
>  		return NULL;
>  
> @@ -303,25 +312,72 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  	}
>  
>  	init_sync_kiocb(&iocb->kiocb, file);
> -	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
> -		iocb->kiocb.ki_flags = IOCB_DIRECT;
>  
> -	iocb->kiocb.ki_pos = hdr->args.offset;
>  	iocb->hdr = hdr;
>  	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
>  	iocb->aio_complete_work = NULL;
>  
> +	iocb->end_iter_index = -1;
> +
>  	return iocb;
>  }
>  
> +struct nfs_local_dio {
> +	u32 mem_align;
> +	u32 offset_align;
> +	loff_t middle_offset;
> +	loff_t end_offset;
> +	ssize_t	start_len;	/* Length for misaligned first extent */
> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> +	ssize_t	end_len;	/* Length for misaligned last extent */
> +};
> +
> +static bool
> +nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
> +			  size_t len, struct nfs_local_dio *local_dio)
> +{
> +	struct nfs_pgio_header *hdr = iocb->hdr;
> +	loff_t offset = hdr->args.offset;
> +	u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
> +	loff_t start_end, orig_end, middle_end;
> +
> +	nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
> +			&nf_dio_offset_align, &nf_dio_read_offset_align);
> +	if (rw == ITER_DEST)
> +		nf_dio_offset_align = nf_dio_read_offset_align;
> +
> +	if (unlikely(!nf_dio_mem_align || !nf_dio_offset_align))
> +		return false;
> +	if (unlikely(nf_dio_offset_align > PAGE_SIZE))
> +		return false;
> +	if (unlikely(len < nf_dio_offset_align))
> +		return false;
> +
> +	local_dio->mem_align = nf_dio_mem_align;
> +	local_dio->offset_align = nf_dio_offset_align;
> +
> +	start_end = round_up(offset, nf_dio_offset_align);
> +	orig_end = offset + len;
> +	middle_end = round_down(orig_end, nf_dio_offset_align);
> +
> +	local_dio->middle_offset = start_end;
> +	local_dio->end_offset = middle_end;
> +
> +	local_dio->start_len = start_end - offset;
> +	local_dio->middle_len = middle_end - start_end;
> +	local_dio->end_len = orig_end - middle_end;
> +
> +	return true;
> +}
> +
>  static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
> -		loff_t offset, unsigned int addr_mask, unsigned int len_mask)
> +		unsigned int addr_mask, unsigned int len_mask)
>  {
>  	const struct bio_vec *bvec = i->bvec;
>  	size_t skip = i->iov_offset;
>  	size_t size = i->count;
>  
> -	if ((offset | size) & len_mask)
> +	if (size & len_mask)
>  		return false;
>  	do {
>  		size_t len = bvec->bv_len;
> @@ -338,8 +394,68 @@ static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
>  	return true;
>  }
>  
> -static void
> -nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int rw)
> +/*
> + * Setup as many as 3 iov_iter based on extents described by @local_dio.
> + * Returns the number of iov_iter that were setup.
> + */
> +static int
> +nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
> +			  unsigned int nvecs, size_t len,
> +			  struct nfs_local_dio *local_dio)
> +{
> +	int n_iters = 0;
> +	struct iov_iter *iters = iocb->iters;
> +
> +	/* Setup misaligned start? */
> +	if (local_dio->start_len) {
> +		iov_iter_bvec(&iters[n_iters], rw, iocb->bvec, nvecs, len);
> +		iters[n_iters].count = local_dio->start_len;
> +		iocb->offset[n_iters] = iocb->hdr->args.offset;
> +		iocb->iter_is_dio_aligned[n_iters] = false;
> +		++n_iters;
> +	}
> +
> +	/* Setup misaligned end?
> +	 * If so, the end is purposely setup to be issued using buffered IO
> +	 * before the middle (which will use DIO, if DIO-aligned, with AIO).
> +	 * This creates problems if/when the end results in a partial write.
> +	 * So must save index and length of end to handle this corner case.
> +	 */
> +	if (local_dio->end_len) {
> +		iov_iter_bvec(&iters[n_iters], rw, iocb->bvec, nvecs, len);
> +		iocb->offset[n_iters] = local_dio->end_offset;
> +		iov_iter_advance(&iters[n_iters],
> +			local_dio->start_len + local_dio->middle_len);
> +		iocb->iter_is_dio_aligned[n_iters] = false;
> +		/* Save index and length of end */
> +		iocb->end_iter_index = n_iters;
> +		iocb->end_len = local_dio->end_len;
> +		++n_iters;
> +	}
> +
> +	/* Setup DIO-aligned middle to be issued last, to allow for
> +	 * DIO with AIO completion (see nfs_local_call_{read,write}).
> +	 */
> +	iov_iter_bvec(&iters[n_iters], rw, iocb->bvec, nvecs, len);
> +	if (local_dio->start_len)
> +		iov_iter_advance(&iters[n_iters], local_dio->start_len);
> +	iters[n_iters].count -= local_dio->end_len;
> +	iocb->offset[n_iters] = local_dio->middle_offset;
> +
> +	iocb->iter_is_dio_aligned[n_iters] =
> +		nfs_iov_iter_aligned_bvec(&iters[n_iters],
> +			local_dio->mem_align-1, local_dio->offset_align-1);
> +
> +	if (unlikely(!iocb->iter_is_dio_aligned[n_iters]))
> +		return 0; /* no DIO-aligned IO possible */
> +	++n_iters;
> +
> +	iocb->n_iters = n_iters;
> +	return n_iters;
> +}
> +
> +static noinline_for_stack void
> +nfs_local_iters_init(struct nfs_local_kiocb *iocb, int rw)
>  {
>  	struct nfs_pgio_header *hdr = iocb->hdr;
>  	struct page **pagevec = hdr->page_array.pagevec;
> @@ -360,26 +476,18 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int rw)
>  	}
>  	len = hdr->args.count - total;
>  
> -	iov_iter_bvec(i, rw, iocb->bvec, v, len);
> +	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
> +		struct nfs_local_dio local_dio;
>  
> -	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> -		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
> -		/* Verify the IO is DIO-aligned as required */
> -		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
> -						&nf_dio_offset_align,
> -						&nf_dio_read_offset_align);
> -		if (rw == ITER_DEST)
> -			nf_dio_offset_align = nf_dio_read_offset_align;
> -
> -		if (nf_dio_mem_align && nf_dio_offset_align &&
> -		    nfs_iov_iter_aligned_bvec(i, hdr->args.offset,
> -					      nf_dio_mem_align - 1,
> -					      nf_dio_offset_align - 1))
> +		if (nfs_is_local_dio_possible(iocb, rw, len, &local_dio) &&
> +		    nfs_local_iters_setup_dio(iocb, rw, v, len, &local_dio) != 0)
>  			return; /* is DIO-aligned */
> -
> -		/* Fallback to using buffered for this misaligned IO */
> -		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
>  	}
> +
> +	/* Use buffered IO */
> +	iocb->offset[0] = hdr->args.offset;
> +	iov_iter_bvec(&iocb->iters[0], rw, iocb->bvec, v, len);
> +	iocb->n_iters = 1;
>  }
>  
>  static void
> @@ -402,10 +510,12 @@ nfs_local_pgio_init(struct nfs_pgio_header *hdr,
>  static void
>  nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
>  {
> +	/* Must handle partial completions */
>  	if (status >= 0) {
> -		hdr->res.count = status;
> -		hdr->res.op_status = NFS4_OK;
> -		hdr->task.tk_status = 0;
> +		hdr->res.count += status;
> +		/* @hdr was initialized to 0 (zeroed during allocation) */
> +		if (hdr->task.tk_status == 0)
> +			hdr->res.op_status = NFS4_OK;
>  	} else {
>  		hdr->res.op_status = nfs_localio_errno_to_nfs4_stat(status);
>  		hdr->task.tk_status = status;
> @@ -447,14 +557,14 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
>  	struct file *filp = iocb->kiocb.ki_filp;
>  
>  	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		/* DIO is last to complete (via AIO) */
>  		if (status == -EINVAL) {
>  			/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
>  			pr_info_ratelimited("nfs: Unexpected direct I/O read alignment failure\n");
>  		}
> +		nfs_local_pgio_done(hdr, status);
>  	}
>  
> -	nfs_local_pgio_done(hdr, status);
> -
>  	/*
>  	 * Must clear replen otherwise NFSv3 data corruption will occur
>  	 * if/when switching from LOCALIO back to using normal RPC.
> @@ -496,12 +606,21 @@ static void nfs_local_call_read(struct work_struct *work)
>  
>  	save_cred = override_creds(filp->f_cred);
>  
> -	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> -		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
> -		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
> -	}
> +	for (int i = 0; i < iocb->n_iters ; i++) {
> +		if (iocb->iter_is_dio_aligned[i]) {
> +			iocb->kiocb.ki_flags |= IOCB_DIRECT;
> +			iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
> +			iocb->aio_complete_work = nfs_local_read_aio_complete_work;
> +		}
>  
> -	status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iter);
> +		iocb->kiocb.ki_pos = iocb->offset[i];
> +		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
> +		if (status != -EIOCBQUEUED) {
> +			nfs_local_pgio_done(iocb->hdr, status);
> +			if (iocb->hdr->task.tk_status)
> +				break;
> +		}
> +	}
>  
>  	revert_creds(save_cred);
>  
> @@ -632,13 +751,16 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
>  	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
>  
>  	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		/* DIO is last to complete (via AIO) */
>  		if (status == -EINVAL) {
>  			/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
>  			pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failure\n");
>  		}
> +		nfs_local_pgio_done(hdr, status);
>  	}
>  
>  	/* Handle short writes as if they are ENOSPC */
> +	status = hdr->res.count;
>  	if (status > 0 && status < hdr->args.count) {
>  		hdr->mds_offset += status;
>  		hdr->args.offset += status;
> @@ -646,11 +768,11 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
>  		hdr->args.count -= status;
>  		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
>  		status = -ENOSPC;
> +		/* record -ENOSPC in terms of nfs_local_pgio_done */
> +		nfs_local_pgio_done(hdr, status);
>  	}
> -	if (status < 0)
> +	if (hdr->task.tk_status < 0)
>  		nfs_reset_boot_verifier(inode);
> -
> -	nfs_local_pgio_done(hdr, status);
>  }
>  
>  static void nfs_local_write_aio_complete_work(struct work_struct *work)
> @@ -683,13 +805,48 @@ static void nfs_local_call_write(struct work_struct *work)
>  	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
>  	save_cred = override_creds(filp->f_cred);
>  
> -	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> -		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
> -		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
> -	}
> -
>  	file_start_write(filp);
> -	status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iter);
> +	for (int i = 0; i < iocb->n_iters ; i++) {
> +		if (iocb->iter_is_dio_aligned[i]) {
> +			iocb->kiocb.ki_flags |= IOCB_DIRECT;
> +			iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
> +			iocb->aio_complete_work = nfs_local_write_aio_complete_work;
> +		}
> +retry:
> +		iocb->kiocb.ki_pos = iocb->offset[i];
> +		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
> +		if (status != -EIOCBQUEUED) {
> +			if (unlikely(status >= 0 && status < iocb->iters[i].count)) {
> +				/* partial write */
> +				if (i == iocb->end_iter_index) {
> +					/* Must not account partial end, otherwise, due
> +					 * to end being issued before middle: the partial
> +					 * write accounting in nfs_local_write_done()
> +					 * would incorrectly advance hdr->args.offset
> +					 */
> +					status = 0;
> +				} else {
> +					/* Partial write at start or buffered middle,
> +					 * exit early.
> +					 */
> +					nfs_local_pgio_done(iocb->hdr, status);
> +					break;
> +				}
> +			} else if (unlikely(status == -ENOTBLK &&
> +					    (iocb->kiocb.ki_flags & IOCB_DIRECT))) {
> +				/* VFS will return -ENOTBLK if DIO WRITE fails to
> +				 * invalidate the page cache. Retry using buffered IO.
> +				 */
> +				iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
> +				iocb->kiocb.ki_complete = NULL;
> +				iocb->aio_complete_work = NULL;
> +				goto retry;
> +			}
> +			nfs_local_pgio_done(iocb->hdr, status);
> +			if (iocb->hdr->task.tk_status)
> +				break;
> +		}
> +	}
>  	file_end_write(filp);
>  
>  	revert_creds(save_cred);
> @@ -758,7 +915,7 @@ nfs_local_iocb_init(struct nfs_pgio_header *hdr, struct nfsd_file *localio)
>  	iocb->hdr = hdr;
>  	iocb->localio = localio;
>  
> -	nfs_local_iter_init(&iocb->iter, iocb, rw);
> +	nfs_local_iters_init(iocb, rw);
>  
>  	return iocb;
>  }
> -- 
> 2.44.0
> 
> 

