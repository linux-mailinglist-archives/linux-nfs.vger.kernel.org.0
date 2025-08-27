Return-Path: <linux-nfs+bounces-13916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E719B38A65
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 21:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C45C7B99F2
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 19:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F812EE5FF;
	Wed, 27 Aug 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihx/KgFq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A52EE60A
	for <linux-nfs@vger.kernel.org>; Wed, 27 Aug 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323687; cv=none; b=tKm5OAhlA5iVvZvAEwDG/MmmiYbbY1pCDjMliewCC9RCpO1Z/SB5GRn4rS5s0cYyABRQ5ziJ4hTIbDv4kgwt71AsZCVx1zedd0W/2NRaVof4dsxZAGCFI57vHBR63f2AtXRmyc49huGdxkxgTg1j+tHljS/a6er+5+14W9D1VC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323687; c=relaxed/simple;
	bh=TfDbSAD/a/CcnTj5F0LIUXFVCmgPMMkLsjXMcERKxtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U96azeG4cOnjTHBKRBIWpKh34vnKaMRK50loUFR8DUf7JTeEGnlR9R/E5TVGn+6XxblEQelacSY+NZsJcfB3W3xoanfjBM3qJQTINo3xJnODvcpK/LiOLfJEvgQcUgLk80BvqI6wV/eENE5MW9/SNjAszC1Yqfb468sszI2pOsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihx/KgFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A900C4CEEB;
	Wed, 27 Aug 2025 19:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756323687;
	bh=TfDbSAD/a/CcnTj5F0LIUXFVCmgPMMkLsjXMcERKxtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ihx/KgFqdLAnqSw9WMcmEX7g2FaKNb6a3+1Q9y/lvyhA4/Er5/doLfUA4iP1N9Avs
	 Oahc69FQOMDFfEurMrW9vNpDHdOOblHjjo2zmFP9AYNB2XjOYzo6t3xkVYAhaT8dM4
	 bVUDerS9O8yEpaZEhbQH/yJeuvw52YnpVcqJqzjVB4RuekMMkHV5mTbzsBECgMHgAn
	 r9R4aon2HC8fXaweuLJ3mDAKx8UU/Ord+ZTg360ofYjjXC/7Oe8OUpCphoDm8E5eZJ
	 +2WPnO/ONTC8igVmchTe48VFpheCzGEAiQQnCElZDkFhUVo0rjRRZRCYAo+kdbmmEu
	 a5eVImVCI26nA==
Date: Wed, 27 Aug 2025 15:41:25 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
Message-ID: <aK9fZR7pQxrosEfW@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>

On Wed, Aug 27, 2025 at 11:34:03AM -0400, Chuck Lever wrote:
> On 8/26/25 2:57 PM, Mike Snitzer wrote:
> > If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> > DIO-aligned block (on either end of the READ). The expanded READ is
> > verified to have proper offset/len (logical_block_size) and
> > dma_alignment checking.
> > 
> > Must allocate and use a bounce-buffer page (called 'start_extra_page')
> > if/when expanding the misaligned READ requires reading extra partial
> > page at the start of the READ so that its DIO-aligned. Otherwise that
> > extra page at the start will make its way back to the NFS client and
> > corruption will occur. As found, and then this fix of using an extra
> > page verified, using the 'dt' utility:
> >   dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
> >      iotype=sequential pattern=iot onerr=abort oncerr=abort
> > see: https://github.com/RobinTMiller/dt.git
> > 
> > Any misaligned READ that is less than 32K won't be expanded to be
> > DIO-aligned (this heuristic just avoids excess work, like allocating
> > start_extra_page, for smaller IO that can generally already perform
> > well using buffered IO).
> > 
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/vfs.c              | 200 +++++++++++++++++++++++++++++++++++--
> >  include/linux/sunrpc/svc.h |   5 +-
> >  2 files changed, 194 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index c340708fbab4d..64732dc8985d6 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/splice.h>
> >  #include <linux/falloc.h>
> >  #include <linux/fcntl.h>
> > +#include <linux/math.h>
> >  #include <linux/namei.h>
> >  #include <linux/delay.h>
> >  #include <linux/fsnotify.h>
> > @@ -1073,6 +1074,153 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> >  }
> >  
> > +struct nfsd_read_dio {
> > +	loff_t start;
> > +	loff_t end;
> > +	unsigned long start_extra;
> > +	unsigned long end_extra;
> > +	struct page *start_extra_page;
> > +};
> > +
> > +static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
> > +{
> > +	memset(read_dio, 0, sizeof(*read_dio));
> > +	read_dio->start_extra_page = NULL;
> > +}
> > +
> > +#define NFSD_READ_DIO_MIN_KB (32 << 10)
> > +
> > +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > +				  struct nfsd_file *nf, loff_t offset,
> > +				  unsigned long len, unsigned int base,
> > +				  struct nfsd_read_dio *read_dio)
> > +{
> > +	const u32 dio_blocksize = nf->nf_dio_read_offset_align;
> > +	loff_t middle_end, orig_end = offset + len;
> > +
> > +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
> > +		      "%s: underlying filesystem has not provided DIO alignment info\n",
> > +		      __func__))
> > +		return false;
> > +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> > +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> > +		      __func__, dio_blocksize, PAGE_SIZE))
> > +		return false;
> 
> IMHO these checks do not warrant a WARN. Perhaps a trace event, instead?

I won't die on this hill, I just don't see the risk of these given
they are highly unlikely ("famous last words").

But if they trigger we should surely be made aware immediately.  Not
only if someone happens to have a trace event enabled (which would
only happen with further support and engineering involvement to chase
"why isn't O_DIRECT being used like NFSD was optionally configured
to!?").

> > +	/* Return early if IO is irreparably misaligned (len < PAGE_SIZE,
> > +	 * or base not aligned).
> > +	 * Ondisk alignment is implied by the following code that expands
> > +	 * misaligned IO to have a DIO-aligned offset and len.
> > +	 */
> > +	if (unlikely(len < dio_blocksize) || ((base & (nf->nf_dio_mem_align-1)) != 0))
> > +		return false;
> > +
> > +	init_nfsd_read_dio(read_dio);
> > +
> > +	read_dio->start = round_down(offset, dio_blocksize);
> > +	read_dio->end = round_up(orig_end, dio_blocksize);
> > +	read_dio->start_extra = offset - read_dio->start;
> > +	read_dio->end_extra = read_dio->end - orig_end;
> > +
> > +	/*
> > +	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
> > +	 * to be DIO-aligned (this heuristic avoids excess work, like allocating
> > +	 * start_extra_page, for smaller IO that can generally already perform
> > +	 * well using buffered IO).
> > +	 */
> > +	if ((read_dio->start_extra || read_dio->end_extra) &&
> > +	    (len < NFSD_READ_DIO_MIN_KB)) {
> > +		init_nfsd_read_dio(read_dio);
> > +		return false;
> > +	}
> > +
> > +	if (read_dio->start_extra) {
> > +		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
> 
> This introduces a page allocation where there weren't any before. For
> NFSD, I/O pages come from rqstp->rq_pages[] so that memory allocation
> like this is not needed on an I/O path.

NFSD never supported DIO before. Yes, with this patch there is
a single page allocation in the misaligned DIO READ path (if it
requires reading extra before the client requested data starts).

I tried to succinctly explain the need for the extra page allocation
for misaligned DIO READ in this patch's header (in 2nd paragraph
of the above header).

I cannot see how to read extra, not requested by the client, into the
head of rq_pages without causing serious problems. So that cannot be
what you're saying needed.

> So I think the answer to this is that I want you to implement reading
> an entire aligned range from the file and then forming the NFS READ
> response with only the range of bytes that the client requested, as we
> discussed before.

That is what I'm doing. But you're taking issue with my implementation
that uses a single extra page.

> The use of xdr_buf and bvec should make that quite
> straightforward.

Is your suggestion to, rather than allocate a disjoint single page,
borrow the extra page from the end of rq_pages? Just map it into the
bvec instead of my extra page?

> This should make the aligned and unaligned cases nearly identical and
> much less fraught.

Regardless of which memory used to read the extra data, I don't see
how the care I've taken to read extra but hide that fact from the
client can be avoided. So the pre/post misaligned DIO READ code won't
change a whole lot. But once I understand your suggestion better
(after a clarifying response to this message) hopefully I'll see what
you're saying.

All said, this patchset is very important to me, I don't want it to
miss v6.18 -- I'm still "in it to win it" but it feels like I do need
your or others' help to pull this off.

And/or is it possible to accept this initial implementation with
mutual understanding that we must revisit your concern about my
allocating an extra page for the misaligned DIO READ path?

> > +		if (WARN_ONCE(read_dio->start_extra_page == NULL,
> > +			      "%s: Unable to allocate start_extra_page\n", __func__)) {
> > +			init_nfsd_read_dio(read_dio);
> > +			return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
> > +						 struct nfsd_read_dio *read_dio,
> > +						 ssize_t bytes_read,
> > +						 unsigned long bytes_expected,
> > +						 loff_t *offset,
> > +						 unsigned long *rq_bvec_numpages)
> > +{
> > +	ssize_t host_err = bytes_read;
> > +	loff_t v;
> > +
> > +	if (!read_dio->start_extra && !read_dio->end_extra)
> > +		return host_err;
> > +
> > +	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
> > +	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
> > +	 */
> > +	if (read_dio->start_extra_page) {
> > +		__free_page(read_dio->start_extra_page);
> > +		*rq_bvec_numpages -= 1;
> > +		v = *rq_bvec_numpages;
> > +		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
> > +			v * sizeof(struct bio_vec));
> > +	}
> > +	/* Eliminate any end_extra bytes from the last page */
> > +	v = *rq_bvec_numpages;
> > +	rqstp->rq_bvec[v].bv_len -= read_dio->end_extra;
> > +
> > +	if (host_err < 0) {
> > +		/* Underlying FS will return -EINVAL if misaligned
> > +		 * DIO is attempted because it shouldn't be.
> > +		 */
> > +		WARN_ON_ONCE(host_err == -EINVAL);
> > +		return host_err;
> > +	}
> > +
> > +	/* nfsd_analyze_read_dio() may have expanded the start and end,
> > +	 * if so adjust returned read size to reflect original extent.
> > +	 */
> > +	*offset += read_dio->start_extra;
> > +	if (likely(host_err >= read_dio->start_extra)) {
> > +		host_err -= read_dio->start_extra;
> > +		if (host_err > bytes_expected)
> > +			host_err = bytes_expected;
> > +	} else {
> > +		/* Short read that didn't read any of requested data */
> > +		host_err = 0;
> > +	}
> > +
> > +	return host_err;
> > +}
> > +
> > +static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
> > +		unsigned addr_mask, unsigned len_mask)
> > +{
> > +	const struct bio_vec *bvec = i->bvec;
> > +	unsigned skip = i->iov_offset;
> > +	size_t size = i->count;
> 
> checkpatch.pl is complaining about the use of "unsigned" rather than
> "unsigned int".

OK.

> > +
> > +	if (size & len_mask)
> > +		return false;
> > +	do {
> > +		size_t len = bvec->bv_len;
> > +
> > +		if (len > size)
> > +			len = size;
> > +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> > +			return false;
> > +		bvec++;
> > +		size -= len;
> > +		skip = 0;
> > +	} while (size);
> > +
> > +	return true;
> > +}
> > +
> >  /**
> >   * nfsd_iter_read - Perform a VFS read using an iterator
> >   * @rqstp: RPC transaction context
> > @@ -1094,7 +1242,8 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		      unsigned int base, u32 *eof)
> >  {
> >  	struct file *file = nf->nf_file;
> > -	unsigned long v, total;
> > +	unsigned long v, total, in_count = *count;
> > +	struct nfsd_read_dio read_dio;
> >  	struct iov_iter iter;
> >  	struct kiocb kiocb;
> >  	ssize_t host_err;
> > @@ -1102,13 +1251,34 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  
> >  	init_sync_kiocb(&kiocb, file);
> >  
> > +	v = 0;
> > +	total = in_count;
> > +
> >  	switch (nfsd_io_cache_read) {
> >  	case NFSD_IO_DIRECT:
> > -		/* Verify ondisk and memory DIO alignment */
> > -		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
> > -		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0) &&
> > -		    (base & (nf->nf_dio_mem_align - 1)) == 0)
> > -			kiocb.ki_flags = IOCB_DIRECT;
> > +		/*
> > +		 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
> > +		 * the next DIO-aligned block (on either end of the READ).
> > +		 */
> > +		if (nfsd_analyze_read_dio(rqstp, fhp, nf, offset,
> > +					  in_count, base, &read_dio)) {
> > +			/* trace_nfsd_read_vector() will reflect larger
> > +			 * DIO-aligned READ.
> > +			 */
> > +			offset = read_dio.start;
> > +			in_count = read_dio.end - offset;
> > +			total = in_count;
> > +
> > +			kiocb.ki_flags |= IOCB_DIRECT;
> > +			if (read_dio.start_extra) {
> > +				len = read_dio.start_extra;
> > +				bvec_set_page(&rqstp->rq_bvec[v],
> > +					      read_dio.start_extra_page,
> > +					      len, PAGE_SIZE - len);
> > +				total -= len;
> > +				++v;
> > +			}
> > +		}
> >  		break;
> >  	case NFSD_IO_DONTCACHE:
> >  		kiocb.ki_flags = IOCB_DONTCACHE;
> > @@ -1120,8 +1290,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  
> >  	kiocb.ki_pos = offset;
> >  
> > -	v = 0;
> > -	total = *count;
> >  	while (total) {
> >  		len = min_t(size_t, total, PAGE_SIZE - base);
> >  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> > @@ -1132,9 +1300,21 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	}
> >  	WARN_ON_ONCE(v > rqstp->rq_maxpages);
> >  
> > -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> > -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> > +	trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
> > +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
> > +
> > +	if ((kiocb.ki_flags & IOCB_DIRECT) &&
> > +	    !nfsd_iov_iter_aligned_bvec(&iter, nf->nf_dio_mem_align-1,
> > +					nf->nf_dio_read_offset_align-1))
> > +		kiocb.ki_flags &= ~IOCB_DIRECT;
> > +
> >  	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
> > +
> > +	if (in_count != *count) {
> > +		/* misaligned DIO expanded read to be DIO-aligned */
> > +		host_err = nfsd_complete_misaligned_read_dio(rqstp, &read_dio,
> > +					host_err, *count, &offset, &v);
> > +	}
> >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> >  }
> >  
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index e64ab444e0a7f..190c2667500e2 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
> >   * pages, one for the request, and one for the reply.
> >   * nfsd_splice_actor() might need an extra page when a READ payload
> >   * is not page-aligned.
> > + * nfsd_iter_read() might need two extra pages when a READ payload
> > + * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
> > + * are mutually exclusive (so reuse page reserved for nfsd_splice_actor).
> >   */
> >  static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
> >  {
> > -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> > +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
> >  }
> >  
> >  /*
> 
> To properly evaluate the impact of using direct I/O for reads with real
> world user workloads, we will want to identify (or construct) some
> metrics (and this is future work, but near-term future).
> 
> Seems like allocating memory becomes difficult only when too many pages
> are dirty. I am skeptical that the issue is due to read caching, since
> clean pages in the page cache are pretty easy to evict quickly, AIUI. If
> that's incorrect, I'd like to understand why.

The much more problematic case is heavy WRITE workload with a working
set that far exceeds system memory.

But I agree it doesn't make a whole lot of sense that clean pages in
the page cache would be getting in the way.  All I can tell you is
that in my experience MM seems to _not_ evict them quickly (but more
focused read-only testing is warranted to further understand the
dynamics and heuristics in MM and beyond -- especially if/when
READ-only then a pivot to a mix of heavy READ and WRITE or
WRITE-only).

NFSD using DIO is optional. I thought the point was to get it as an
available option so that _others_ could experiment and help categorize
the benefits/pitfalls further?

I cannot be a one man show on all this. I welcome more help from
anyone interested.

Thanks,
Mike

