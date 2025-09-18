Return-Path: <linux-nfs+bounces-14570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B17B86089
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98B334E1ADE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECA5311C01;
	Thu, 18 Sep 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4yU9S5m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57B2F5A08
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212949; cv=none; b=l2ppLaM6d9hInWs3LnkluiLIlGi+5uA7N7M7PmdBz7D4y37HbV0O+fOAFoBCglHXuzOMd6YwhLf6VVIoewU5EHdrvpaUe7PoakZczf4Nev50sCWfeTedHxfcaUKWE+rQCLkqOIQaM3waqX53SSJCIvq+63mhf68OJ+dqavUFEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212949; c=relaxed/simple;
	bh=cq+OFhox+1LrUWNAQDhNWj0ccq7969zcxIIjv/N4cW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXxkIg63U8P/uCMBzB+fpykmEDTfHeUjcmjuuzX8eF0gDqN7qfaTDdDc2wRbJ6EnAc0oOH2NaeZ+RtpTEVtZ+8PigypkK2gB1AFgw7X6huLUygUe7+yKG47J6IMGANpXOE2V4aJhLMM9Dqj9mqAXmEvyd+/vDVDULD4tud0d4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4yU9S5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664FEC4CEE7;
	Thu, 18 Sep 2025 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758212948;
	bh=cq+OFhox+1LrUWNAQDhNWj0ccq7969zcxIIjv/N4cW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4yU9S5mfmGNwtN+SXQCJq1EJ1wc6cixtHTysdT7Rn2Of+xcYxy+KacUO0xxjNSVH
	 r1Ler5Muamyvmg/42BoSx98487dvyKVePs5glR0WSbJLhnA8a4TsdP5rqTBpA1N54B
	 rnhpwQeK0t2knCmVp6xecE/SM3nl57JnqbFH1fCVF1IbvkE57HMQ2DG3pxhEUTqgi+
	 wcBPQVHup81tyF/OBvyc71IrCLFYsACB5Es5fdDlzh5YqqdV4dDTq2jXxjRFIi6Od2
	 GCf4WHfyukMsA8icw7uv5iD6VaavbJlnHKTqQ/IBrP1wecqHlmSf2fwyw43ORhrQSK
	 80nPj42FkQBIA==
Date: Thu, 18 Sep 2025 12:29:07 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: neil@brown.name, jlayton@kernel.org, okorniev@redhat.com,
	dai.ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aMwzU50fiZSN00JP@kernel.org>
References: <175811882632.19474.8126763744508709520.stgit@91.116.238.104.host.secureserver.net>
 <175811952039.19474.5813875056701985362.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175811952039.19474.5813875056701985362.stgit@91.116.238.104.host.secureserver.net>

On Wed, Sep 17, 2025 at 10:32:00AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Add an experimental option that forces NFS READ operations to use
> direct I/O instead of reading through the NFS server's page cache.
> 
> There are already other layers of caching:
>  - The page cache on NFS clients
>  - The block device underlying the exported file system
> 
> The server's page cache, in many cases, is unlikely to provide
> additional benefit. Some benchmarks have demonstrated that the
> server's page cache is actively detrimental for workloads whose
> working set is larger than the server's available physical memory.
> 
> For instance, on small NFS servers, cached NFS file content can
> squeeze out local memory consumers. For large sequential workloads,
> an enormous amount of data flows into and out of the page cache
> and is consumed by NFS clients exactly once -- caching that data
> is expensive to do and totally valueless.
> 
> For now this is a hidden option that can be enabled on test
> systems for benchmarking. In the longer term, this option might
> be enabled persistently or per-export. When the exported file
> system does not support direct I/O, NFSD falls back to using
> either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> 
> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c |    2 +
>  fs/nfsd/nfsd.h    |    1 +
>  fs/nfsd/trace.h   |    1 +
>  fs/nfsd/vfs.c     |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+)
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index ed2b9e066206..00eb1ecef6ac 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
>   * Contents:
>   *   %0: NFS READ will use buffered IO
>   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> + *   %2: NFS READ will use direct IO
>   *
>   * This setting takes immediate effect for all NFS versions,
>   * all exports, and in all NFSD net namespaces.
> @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
>  		nfsd_io_cache_read = NFSD_IO_BUFFERED;
>  		break;
>  	case NFSD_IO_DONTCACHE:
> +	case NFSD_IO_DIRECT:
>  		/*
>  		 * Must disable splice_read when enabling
>  		 * NFSD_IO_DONTCACHE.
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index ea87b42894dd..bdb60ee1f1a4 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -157,6 +157,7 @@ enum {
>  	/* Any new NFSD_IO enum value must be added at the end */
>  	NFSD_IO_BUFFERED,
>  	NFSD_IO_DONTCACHE,
> +	NFSD_IO_DIRECT,
>  };
>  
>  extern u64 nfsd_io_cache_read __read_mostly;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 6e2c8e2aab10..bfd41236aff2 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
>  DEFINE_NFSD_IO_EVENT(read_start);
>  DEFINE_NFSD_IO_EVENT(read_splice);
>  DEFINE_NFSD_IO_EVENT(read_vector);
> +DEFINE_NFSD_IO_EVENT(read_direct);
>  DEFINE_NFSD_IO_EVENT(read_io_done);
>  DEFINE_NFSD_IO_EVENT(read_done);
>  DEFINE_NFSD_IO_EVENT(write_start);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 35880d3f1326..5cd970c1089b 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> +/*
> + * The byte range of the client's READ request is expanded on both
> + * ends until it meets the underlying file system's direct I/O
> + * alignment requirements. After the internal read is complete, the
> + * byte range of the NFS READ payload is reduced to the byte range
> + * that was originally requested.
> + *
> + * Note that a direct read can be done only when the xdr_buf
> + * containing the NFS READ reply does not already have contents in
> + * its .pages array. This is due to potentially restrictive
> + * alignment requirements on the read buffer. When .page_len and
> + * @base are zero, the .pages array is guaranteed to be page-
> + * aligned.
> + */
> +static noinline_for_stack __be32
> +nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
> +		 u32 *eof)
> +{
> +	loff_t dio_start, dio_end;
> +	unsigned long v, total;
> +	struct iov_iter iter;
> +	struct kiocb kiocb;
> +	ssize_t host_err;
> +	size_t len;
> +
> +	init_sync_kiocb(&kiocb, nf->nf_file);
> +	kiocb.ki_flags |= IOCB_DIRECT;
> +
> +	/* Read a properly-aligned region of bytes into rq_bvec */
> +	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
> +	dio_end = round_up(offset + *count, nf->nf_dio_read_offset_align);
> +
> +	kiocb.ki_pos = dio_start;
> +
> +	v = 0;
> +	total = *count;

Hi Chuck,

Looks like you introduced a copy-n-paste bug when updating
nfsd_direct_read's while loop to follow nfsd_iter_read's lead.

Should be:
	total = dio_end - dio_start;

[NOTE: this was the reason I saw a crash with my incremental patch
that handled 'base', see:
https://lore.kernel.org/linux-nfs/aMwcUdWdey69k2iK@kernel.org/
]

Thanks,
Mike

> +	while (total && v < rqstp->rq_maxpages &&
> +	       rqstp->rq_next_page < rqstp->rq_page_end) {
> +		len = min_t(size_t, total, PAGE_SIZE);
> +		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> +			      len, 0);
> +
> +		total -= len;
> +		++rqstp->rq_next_page;
> +		++v;
> +	}
> +
> +	trace_nfsd_read_direct(rqstp, fhp, offset, *count - total);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v,
> +		      dio_end - dio_start - total);
> +
> +	host_err = vfs_iocb_iter_read(nf->nf_file, &kiocb, &iter);
> +	if (host_err >= 0) {
> +		unsigned int pad = offset - dio_start;
> +
> +		/* The returned payload starts after the pad */
> +		rqstp->rq_res.page_base = pad;
> +
> +		/* Compute the count of bytes to be returned */
> +		if (host_err > pad + *count) {
> +			host_err = *count;
> +		} else if (host_err > pad) {
> +			host_err -= pad;
> +		} else {
> +			host_err = 0;
> +		}
> +	} else if (unlikely(host_err == -EINVAL)) {
> +		pr_info_ratelimited("nfsd: Unexpected direct I/O alignment failure\n");
> +		host_err = -ESERVERFAULT;
> +	}
> +
> +	return nfsd_finish_read(rqstp, fhp, nf->nf_file, offset, count,
> +				eof, host_err);
> +}
> +
>  /**
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
> @@ -1106,6 +1182,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	switch (nfsd_io_cache_read) {
>  	case NFSD_IO_BUFFERED:
>  		break;
> +	case NFSD_IO_DIRECT:
> +		if (nf->nf_dio_read_offset_align && !base)
> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> +						count, eof);
> +		fallthrough;
>  	case NFSD_IO_DONTCACHE:
>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
>  			kiocb.ki_flags = IOCB_DONTCACHE;
> 
> 
> 

