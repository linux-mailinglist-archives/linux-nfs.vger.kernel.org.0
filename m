Return-Path: <linux-nfs+bounces-14630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A7B97B62
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98077AB28E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CD30DD0D;
	Tue, 23 Sep 2025 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQD4K1bS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F106A48
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666382; cv=none; b=aFE2F0wjxLzenUtleFr/zMM8Of+JWp+gLWkjNihLRSDvTy29QJO6YLPuDrIy3IVeShxrFCBvO3jReQZAh37wYu1TrrA1sI87DvHHFWPSg2N1KHe2fRRJURJ5JN0jz+7ZVP5raR31wFms3dxTyeDdaJBZjoUYXGREuEPFcIELysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666382; c=relaxed/simple;
	bh=9X+oP8gCrPAk7mUPSedZI89Et/0vxtJ4BFvVeZBt2LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f04rsTi7V+mIPKhvmPb4eMtsETKHXxBfk3oO+/bZMIe6H+WcoyNFKkdFzVWA3gHb4GBbwSDajgfJ0r6xHvS54w+ygGb3tpfDo8OmZ6SLuBn3kCoQAZNYiaRI+6MJMyiC+A/9GgxtDH72zw7UNTJdLT7l8WgdzllWbKjKoQJTbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQD4K1bS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3C7C4CEF5;
	Tue, 23 Sep 2025 22:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666381;
	bh=9X+oP8gCrPAk7mUPSedZI89Et/0vxtJ4BFvVeZBt2LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQD4K1bSYdjCJNv/tqfxflZiRiQpFCdzpD7h9oKohFjotictRv5/DUU+bk1vw4/w6
	 oeVv5LovF53YJlD32erY6Nyb/7ADU3yEI8YQOan6UeU6RNwCGkO1utHr/5ywUy2S/j
	 UKuOJ6F9A/eAvW+3mhKhxnPFXTkJJyNintiJzz8+l7Zw/l5OUQxYU2Z7e9ZhFOiqze
	 xBFptmwzomBsqIq6l58hc0aVX0IpJ+aGmO4hQXnFzskW1c5IgKYdRMWSORj3o4QU1N
	 3K5/BEMkgNYIyckeMi9GDYcF25qUZ2GFtsE1wGlyA9qFSgrHXYvxJmoxmDhTivH3Sh
	 4mASv/XY7gERg==
Date: Tue, 23 Sep 2025 18:26:19 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aNMei7Ax5CbsR_Qz@kernel.org>
References: <20250922141137.632525-1-cel@kernel.org>
 <20250922141137.632525-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922141137.632525-4-cel@kernel.org>

On Mon, Sep 22, 2025 at 10:11:37AM -0400, Chuck Lever wrote:
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
>  fs/nfsd/debugfs.c |  2 ++
>  fs/nfsd/nfsd.h    |  1 +
>  fs/nfsd/trace.h   |  1 +
>  fs/nfsd/vfs.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+)
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
> index 35880d3f1326..ddcd812f0761 100644
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

So this ^ comment (and the related conversation with Neil in a
different thread) says page_len should be 0 on entry to
nfsd_direct_read.

> @@ -1106,6 +1182,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	switch (nfsd_io_cache_read) {
>  	case NFSD_IO_BUFFERED:
>  		break;
> +	case NFSD_IO_DIRECT:
> +		if (nf->nf_dio_read_offset_align &&
> +		    rqstp->rq_res.page_len && !base)
> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> +						count, eof);
> +		fallthrough;

Yet the nfsd_iter_read is only calling nfsd_direct_read() if
rqstp->rq_res.page_len is not zero, shouldn't it be
!rqstp->rq_res.page_len ?

(testing confirms it should be !rqstp->rq_res.page_len)

Hopefully with this fix you can have more confidence in staging this
in your nfsd-testing?

Thanks,
Mike

