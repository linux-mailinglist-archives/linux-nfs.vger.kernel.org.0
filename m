Return-Path: <linux-nfs+bounces-12951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E1AFD9AC
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 23:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9BC7A8CC5
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BFF241661;
	Tue,  8 Jul 2025 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jotjHuGy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E023D298
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009742; cv=none; b=rX0PdB/G86w/R5vpMyiCTna3eZRFOrXeU7InL63XSyhTDOJ2uaVRJDVLhq2WWYG2mr05SPamP3nnQKyi7RsZ8K9ir/OghVQvmt2dyD4c0e0KDbPUG48GuR0HS9rPFpSw2Cqh1rxhUSxxNM2msNOS0gVX5i+8tpqCiUGLly0AWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009742; c=relaxed/simple;
	bh=kGYg6/CHmlAUDooptJZnnwJ5gJH1vLEcK8lQFctgook=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPGMArTZhfcDUW4ogPXc0/FJIUw/swxK2LKshYtWDEyK48dRYK5Nrnf3ggSVXb0kezLcZxDMbAsR4RR+4ug+d025IR0a1dAYb9tiebBko4kbduTYE0ZMwu4JjbJ/DLBaPjnxMwYkqe8FFXMzGvOaebXGpegqND9tEgWCcUvmBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jotjHuGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC3DC4CEF1;
	Tue,  8 Jul 2025 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752009742;
	bh=kGYg6/CHmlAUDooptJZnnwJ5gJH1vLEcK8lQFctgook=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jotjHuGyKarLSxp5a3+GZFciuYznK54C2HxTEZY6tuhehLujlhvFNj3T2d1gJhATt
	 tNTz3R0qBie2HKHdlkTqs7OAJgVO83Ns17OB323ZYNaRPpT8bpnizXUJ2VHHRIW24E
	 TZJZlalvkgzB1pUv2OK410oSn3KRZmBUNcDBJYYRmnH5q2sdpWZ1ySXAk5dAMoCbsh
	 FKEi8gv9HpP7ujcrX6hTzd54kguug8xn4cML6KHQI6TLagB79ioNPH/6dRhcb8GAXy
	 jdSa48tbAw+yjVJrfyvcEs+K5hgKQjpB3EHVof0IJCuCp44jdZYOoYYhGCnKN0mD3O
	 qoVu4FC4ZPfUg==
Date: Tue, 8 Jul 2025 17:22:21 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linus-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 8/8] NFSD: issue READs using O_DIRECT even if IO
 is misaligned
Message-ID: <aG2MDVyyCbjTpgOv@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-9-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708160619.64800-9-snitzer@kernel.org>

On Tue, Jul 08, 2025 at 12:06:19PM -0400, Mike Snitzer wrote:
> If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> DIO-aligned block (on either end of the READ).
> 
> Must allocate and use a bounce-buffer page (called 'start_extra_page')
> if/when expanding the misaligned READ requires reading extra partial
> page at the start of the READ so that its DIO-aligned. Otherwise those
> extra pages at the start will make their way back to the NFS client
> and corruption will occur (as found, and then this fix of using an
> extra page verified, with the 'dt' utility, using:
>   dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
>      iotype=sequential pattern=iot onerr=abort oncerr=abort
> see: https://github.com/RobinTMiller/dt.git )
> 
> Reserve an extra page in svc_serv_maxpages() because nfsd_iter_read()
> might need two extra pages when a READ payload is not DIO-aligned --
> but nfsd_iter_read() and nfsd_splice_actor() are mutually exclusive
> (so reuse page reserved for nfsd_splice_actor).
> 
> Also add nfsd_read_vector_dio trace event. This combination of
> trace events is useful:
> 
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector_dio/enable
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
>  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
> 
> Which for this dd command:
> 
>  dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct
> 
> Results in:
> 
>  nfsd-16580   [001] .....  5672.403130: nfsd_read_vector_dio: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47008 start=0+0 end=47104-96
>  nfsd-16580   [001] .....  5672.403131: nfsd_read_vector: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47104
>  nfsd-16580   [001] .....  5672.403134: xfs_file_direct_read: dev 253:0 ino 0x1c2388c1 disize 0x16f40 pos 0x0 bytecount 0xb800
>  nfsd-16580   [001] .....  5672.404380: nfsd_read_io_done: xid=0x5ccf019c fh_hash=0xe4dadb60 offset=0 len=47008
> 
>  nfsd-16580   [001] .....  5672.404672: nfsd_read_vector_dio: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=47008 len=47008 start=46592+416 end=94208-192
>  nfsd-16580   [001] .....  5672.404672: nfsd_read_vector: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=46592 len=47616
>  nfsd-16580   [001] .....  5672.404673: xfs_file_direct_read: dev 253:0 ino 0x1c2388c1 disize 0x16f40 pos 0xb600 bytecount 0xba00
>  nfsd-16580   [001] .....  5672.405771: nfsd_read_io_done: xid=0x5dcf019c fh_hash=0xe4dadb60 offset=47008 len=47008
> 
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/trace.h            |  37 ++++++++++
>  fs/nfsd/vfs.c              | 141 +++++++++++++++++++++++++++++++------
>  include/linux/sunrpc/svc.h |   5 +-
>  3 files changed, 161 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index a664fdf1161e..55055482f8a8 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -473,6 +473,43 @@ DEFINE_NFSD_IO_EVENT(write_done);
>  DEFINE_NFSD_IO_EVENT(commit_start);
>  DEFINE_NFSD_IO_EVENT(commit_done);
>  
> +TRACE_EVENT(nfsd_read_vector_dio,
> +	TP_PROTO(struct svc_rqst *rqstp,
> +		 struct svc_fh	*fhp,
> +		 u64		offset,
> +		 u32		len,
> +		 loff_t         start,
> +		 loff_t         start_extra,
> +		 loff_t         end,
> +		 loff_t         end_extra),
> +	TP_ARGS(rqstp, fhp, offset, len, start, start_extra, end, end_extra),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, fh_hash)
> +		__field(u64, offset)
> +		__field(u32, len)
> +		__field(loff_t, start)
> +		__field(loff_t, start_extra)
> +		__field(loff_t, end)
> +		__field(loff_t, end_extra)
> +	),
> +	TP_fast_assign(
> +		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> +		__entry->offset = offset;
> +		__entry->len = len;
> +		__entry->start = start;
> +		__entry->start_extra = start_extra;
> +		__entry->end = end;
> +		__entry->end_extra = end_extra;
> +	),
> +	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%llu end=%llu-%llu",
> +		  __entry->xid, __entry->fh_hash,
> +		  __entry->offset, __entry->len,
> +		  __entry->start, __entry->start_extra,
> +		  __entry->end, __entry->end_extra)
> +);
> +
>  DECLARE_EVENT_CLASS(nfsd_err_class,
>  	TP_PROTO(struct svc_rqst *rqstp,
>  		 struct svc_fh	*fhp,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 05a7ba383334..2d21b8ec2d32 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -19,6 +19,7 @@
>  #include <linux/splice.h>
>  #include <linux/falloc.h>
>  #include <linux/fcntl.h>
> +#include <linux/math.h>
>  #include <linux/namei.h>
>  #include <linux/delay.h>
>  #include <linux/fsnotify.h>
> @@ -1065,6 +1066,74 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +				  loff_t offset, __u32 len,
> +				  const u32 dio_blocksize,
> +				  loff_t *start, loff_t *end,
> +				  loff_t *start_extra, loff_t *end_extra)
> +{
> +	loff_t orig_end = offset + len;
> +
> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> +		      __func__, dio_blocksize, PAGE_SIZE))
> +		return false;
> +
> +	*start = round_down(offset, dio_blocksize);
> +	*end = round_up(orig_end, dio_blocksize);
> +	*start_extra = offset - *start;
> +	*end_extra = *end - orig_end;
> +
> +	/* Show original offset and count, and how it was expanded for DIO */
> +	trace_nfsd_read_vector_dio(rqstp, fhp, offset, len,
> +				   *start, *start_extra, *end, *end_extra);
> +
> +	return (*start_extra || *end_extra);
> +}

Turns out there is a bug in the above final return, incremental fix
that will be in v3 (once others hopefully have a chance to review):

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2d21b8ec2d32..6336a5806f4c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1088,7 +1088,7 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	trace_nfsd_read_vector_dio(rqstp, fhp, offset, len,
 				   *start, *start_extra, *end, *end_extra);
 
-	return (*start_extra || *end_extra);
+	return true;
 }
 
 static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,

> +static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
> +						 loff_t start_extra, loff_t end_extra,
> +						 ssize_t bytes_read,
> +						 unsigned long bytes_expected,
> +						 loff_t *offset,
> +						 unsigned long *rq_bvec_numpages,
> +						 struct page *start_extra_page)
> +{
> +	ssize_t host_err = bytes_read;
> +	loff_t v;
> +
> +	/* Must remove first start_extra_page from rqstp->rq_bvec */
> +	if (start_extra_page) {
> +		__free_page(start_extra_page);
> +		*rq_bvec_numpages -= 1;
> +		v = *rq_bvec_numpages;
> +		for (int i = 0; i < v; i++) {
> +			struct bio_vec *bv = &rqstp->rq_bvec[i+1];
> +			bvec_set_page(&rqstp->rq_bvec[i], bv->bv_page,
> +				      bv->bv_offset, bv->bv_len);
> +		}
> +	}
> +	/* Then eliminate the end_extra bytes from the last page */
> +	v = *rq_bvec_numpages;
> +	rqstp->rq_bvec[v].bv_len -= end_extra;
> +
> +	if (host_err < 0)
> +		return host_err;
> +
> +	/* Must adjust returned read size to reflect original extent */
> +	*offset += start_extra;
> +	if (likely(host_err >= start_extra)) {
> +		host_err -= start_extra;
> +		if (host_err > bytes_expected)
> +			host_err = bytes_expected;
> +	} else {
> +		/* Short read that didn't read any of requested data */
> +		host_err = 0;
> +	}
> +
> +	return host_err;
> +}
> +

Also, I think its worth calling out this
nfsd_complete_misaligned_read_dio function for its remapping/shifting
of the READ payload reflected in rqstp->rq_bvec[].

Could easily be that a cleaner way exists to do this and I'm just
missing it.

>  /**
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
> @@ -1086,44 +1155,74 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		      unsigned int base, u32 *eof)
>  {
>  	struct file *file = nf->nf_file;
> -	unsigned long v, total;
> +	unsigned long v, total, in_count = *count;
> +	loff_t start_extra = 0, end_extra = 0;
> +	struct page *start_extra_page = NULL;
>  	struct iov_iter iter;
>  	struct kiocb kiocb;
> -	ssize_t host_err;
> +	ssize_t host_err = 0;
>  	size_t len;
>  
>  	init_sync_kiocb(&kiocb, file);
> +
> +	/*
> +	 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
> +	 * the next DIO-aligned block (on either end of the READ).
> +	 */
> +	if ((nfsd_io_cache_read == NFSD_IO_DIRECT) &&
> +	    nf->nf_dio_mem_align && (base & (nf->nf_dio_mem_align-1)) == 0) {
> +		loff_t start, end;
> +		if (nfsd_analyze_read_dio(rqstp, fhp, offset, in_count,
> +					  nf->nf_dio_read_offset_align,
> +					  &start, &end, &start_extra, &end_extra)) {
> +			/* trace_nfsd_read_vector() will reflect larger DIO-aligned READ */
> +			offset = start;
> +			in_count = end - start;
> +			kiocb.ki_flags = IOCB_DIRECT;
> +		}
> +	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
> +		kiocb.ki_flags = IOCB_DONTCACHE;
> +
>  	kiocb.ki_pos = offset;

<snip>

Just bringing the top fix home, nfsd_analyze_read_dio() was only
returning true if an READ IO requiring expanding the a misaligned IO
to be DIO-aligned (as reflected by start_extra or end_extra being
non-zero).  But if the READ was already DIO_aligned it wouldn't set
IOCB_DIRECT (because neither start_extra or end_extra set). 

I had been hyper-focused on handling misaligned IO and missed that the
basic case of IO already being DIO-aligned had regressed since my v1
patchset.

Mike

