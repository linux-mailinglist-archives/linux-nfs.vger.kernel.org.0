Return-Path: <linux-nfs+bounces-16196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA41C41011
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 18:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80BE24E1A5E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFF5224AF7;
	Fri,  7 Nov 2025 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d05mCLQk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8F1C3314
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535901; cv=none; b=N0B8ika7G60dNUg54egiG3O6eu6Y5Czd6zsclJod/BMkb37cEMbR9kI9vuuOvdr2cEuCsxQWE7xcVr4YN1hiuKEDXfXs2wTQxCXKevaqUeWy7DmI1K2TVEnCm3I106F6tpS63swi/0xvDkiKRlC+1x/aFnoe2CWPpMBSfFmDnek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535901; c=relaxed/simple;
	bh=k8kHbnrSEktISBtGLs/UNjhVoe1jeEodTjhEp5UgLo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN5Rz2JCRIlxLiPja+ltFXA1fhBadeHxmV7VP74XcAps45xsdtvJLILrRHVFPUPrm263qNtXklaDThTukzUotpPjZefe2nIFfuT+bBcn4tvrWlp+tiDjrCMQa+9UWgUtR0GNsBw3sw5YSEHF/shKebmcV80nr+VS8ENFaTclDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d05mCLQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9509CC19424;
	Fri,  7 Nov 2025 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762535900;
	bh=k8kHbnrSEktISBtGLs/UNjhVoe1jeEodTjhEp5UgLo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d05mCLQkCfxpLFhedZai8EoVPB8Wok6RLyawsAKpFywG0IBvW4+OS0YkS35tVXLwI
	 S4+uKJJcwo7IGhX6uzbQx1qjqlDHyfyLE4Ww9ztdkqwoyox3lduZwmnyyy+zzzbal4
	 Zzz4YrEDsoTOpEI+FQy3cbNAyroItFqM6IcKLblvwO4/Nj0YOMRKCghuncqVOfyN/E
	 VgEgLB2LyWP1JNpsDNW/kWtAwdlPhHhBGOk6lHO+tmlZgSHwtZZK514jmWLsOPQ/Wn
	 wh/xc+3yuK/mN7v5Pbv2RC0bE0Bc1LW84xjE5+gXC1scV6BPGqxZYHFLjzjekPAcoO
	 X9oT4JcJ35DcA==
Date: Fri, 7 Nov 2025 12:18:19 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ4p2xumOVlOxlkl@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107153422.4373-3-cel@kernel.org>

On Fri, Nov 07, 2025 at 10:34:21AM -0500, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> When NFSD_IO_DIRECT is selected via the
> /sys/kernel/debug/nfsd/io_cache_write experimental tunable, split
> incoming unaligned NFS WRITE requests into a prefix, middle and
> suffix segment, as needed. The middle segment is now DIO-aligned and
> the prefix and/or suffix are unaligned. Synchronous buffered IO is
> used for the unaligned segments, and IOCB_DIRECT is used for the
> middle DIO-aligned extent.
> 
> Although IOCB_DIRECT avoids the use of the page cache, by itself it
> doesn't guarantee data durability. For UNSTABLE WRITE requests,
> durability is obtained by a subsequent NFS COMMIT request.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Co-developed-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c |   1 +
>  fs/nfsd/trace.h   |   1 +
>  fs/nfsd/vfs.c     | 140 ++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 138 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 00eb1ecef6ac..7f44689e0a53 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -108,6 +108,7 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
>  	switch (val) {
>  	case NFSD_IO_BUFFERED:
>  	case NFSD_IO_DONTCACHE:
> +	case NFSD_IO_DIRECT:
>  		nfsd_io_cache_write = val;
>  		break;
>  	default:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 85a1521ad757..8047a6d97b81 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -469,6 +469,7 @@ DEFINE_NFSD_IO_EVENT(read_io_done);
>  DEFINE_NFSD_IO_EVENT(read_done);
>  DEFINE_NFSD_IO_EVENT(write_start);
>  DEFINE_NFSD_IO_EVENT(write_opened);
> +DEFINE_NFSD_IO_EVENT(write_direct);
>  DEFINE_NFSD_IO_EVENT(write_io_done);
>  DEFINE_NFSD_IO_EVENT(write_done);
>  DEFINE_NFSD_IO_EVENT(commit_start);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5333d49910d9..7e56be190170 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1254,6 +1254,131 @@ static int wait_for_concurrent_writes(struct file *file)
>  	return err;
>  }
>  
> +struct nfsd_write_dio_seg {
> +	struct iov_iter			iter;
> +	int				flags;
> +};
> +
> +static unsigned long
> +iov_iter_bvec_offset(const struct iov_iter *iter)
> +{
> +	return (unsigned long)(iter->bvec->bv_offset + iter->iov_offset);
> +}
> +
> +static void
> +nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
> +			struct bio_vec *bvec, unsigned int nvecs,
> +			unsigned long total, size_t start, size_t len,
> +			struct kiocb *iocb)
> +{
> +	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
> +	if (start)
> +		iov_iter_advance(&segment->iter, start);
> +	iov_iter_truncate(&segment->iter, len);
> +	segment->flags = iocb->ki_flags;
> +}
> +
> +static unsigned int
> +nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
> +			  unsigned int nvecs, struct kiocb *iocb,
> +			  unsigned long total,
> +			  struct nfsd_write_dio_seg segments[3])
> +{
> +	u32 offset_align = nf->nf_dio_offset_align;
> +	loff_t prefix_end, orig_end, middle_end;
> +	u32 mem_align = nf->nf_dio_mem_align;
> +	size_t prefix, middle, suffix;
> +	loff_t offset = iocb->ki_pos;
> +	unsigned int nsegs = 0;
> +
> +	/*
> +	 * Check if direct I/O is feasible for this write request.
> +	 * If alignments are not available, the write is too small,
> +	 * or no alignment can be found, fall back to buffered I/O.
> +	 */
> +	if (unlikely(!mem_align || !offset_align) ||
> +	    unlikely(total < max(offset_align, mem_align)))
> +		goto no_dio;
> +
> +	prefix_end = round_up(offset, offset_align);
> +	orig_end = offset + total;
> +	middle_end = round_down(orig_end, offset_align);
> +
> +	prefix = prefix_end - offset;
> +	middle = middle_end - prefix_end;
> +	suffix = orig_end - middle_end;
> +
> +	if (!middle)
> +		goto no_dio;
> +
> +	if (prefix)
> +		nfsd_write_dio_seg_init(&segments[nsegs++], bvec,
> +					nvecs, total, 0, prefix, iocb);
> +
> +	nfsd_write_dio_seg_init(&segments[nsegs], bvec, nvecs,
> +				total, prefix, middle, iocb);
> +
> +	/*
> +	 * Check if the bvec iterator is aligned for direct I/O.
> +	 *
> +	 * bvecs generated from RPC receive buffers are contiguous: After
> +	 * the first bvec, all subsequent bvecs start at bv_offset zero
> +	 * (page-aligned). Therefore, only the first bvec is checked.
> +	 */
> +	if (iov_iter_bvec_offset(&segments[nsegs].iter) & (mem_align - 1))
> +		goto no_dio;
> +	segments[nsegs].flags |= IOCB_DIRECT;
> +	nsegs++;
> +
> +	if (suffix)
> +		nfsd_write_dio_seg_init(&segments[nsegs++], bvec, nvecs, total,
> +					prefix + middle, suffix, iocb);
> +
> +	return nsegs;
> +
> +no_dio:
> +	/*
> +	 * No DIO alignment possible - pack into single non-DIO segment.
> +	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
> +	 */
> +	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total, 0,
> +				total, iocb);
> +	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +		segments[nsegs].flags |= IOCB_DONTCACHE;

This needs to be: segments[0].flags |= IOCB_DONTCACHE;

Mike

