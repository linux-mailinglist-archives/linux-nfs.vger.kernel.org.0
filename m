Return-Path: <linux-nfs+bounces-15808-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8575C22179
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 20:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B39422687
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A4A3148AD;
	Thu, 30 Oct 2025 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCT2ysZ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE52313270
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854148; cv=none; b=pgwsGm1P83Xv85GJS17tXb7eSVjHN5HZtf9femKxJYle/liNuXTpzTIOoUtLW+H3s261PJaZjQiz6OJWdLzuY/NlB0hfrbR1tTjFtUNaINeOxEe246iEDYmTBvb/1zBiDrvyCYYy8gKOnPAo64+I8ZwzyhDkZGekZGrW9c7ILig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854148; c=relaxed/simple;
	bh=7TWXYZfSpVgpNyv3YCFixoqWiVa25IIzW0lgycaJgB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFC2qfYqweACGnOHrDLDAUU9vfX1Tt1i8X0MtQUriVD03LbUsdxnlest9l9WDDyn0BDfElVjPbofeJbRusRNVgrYk4jQgdjI9xA5s75cLZnNdPKwUByABXXd+xi011Q5cHrk2+e64JIUS5YNwXivhYM8i9x2JdDz6SusiOYiv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCT2ysZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1525DC4CEF1;
	Thu, 30 Oct 2025 19:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761854146;
	bh=7TWXYZfSpVgpNyv3YCFixoqWiVa25IIzW0lgycaJgB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gCT2ysZ57g/g5YBjZVzHfera948zKHCZaobHteKFfZ3P19ApYykm2IDmx+g5cMR17
	 caW6jBhTgp01s6eLzOA4ajQSfbDeUSCOZhvvjEdVTF4+OK4E3JCviOVwbf+bOUOSzt
	 p1mByK6lpV6csYFfGxxtQ8t2qhuMdXvnUypU8MjEL9i4UXZjUDnnEcdGVh5VNo+z6i
	 WfudzxaUEo548ATaVJX54kcZHurynpRu6yy5nQKARjkcMSC4C5AXCjgrQBEKR2CYpc
	 S3onbq0ECGcqp9wIvCSruMrT5xTMkhrS74ZYPrenMRsZhwguXb3WbVUhyNpv+cQgC+
	 3jL3W/7TxxDrA==
Message-ID: <33b68105-e868-4a6a-86d4-c3ce8077f249@kernel.org>
Date: Thu, 30 Oct 2025 15:55:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/12] NFSD: Handle both offset and memory alignment
 for direct I/O
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251027154630.1774-1-cel@kernel.org>
 <20251027154630.1774-10-cel@kernel.org>
 <6dcab1145acd85e0d07c11ac09ba5d7e429a364e.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <6dcab1145acd85e0d07c11ac09ba5d7e429a364e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:52 PM, Jeff Layton wrote:
> On Mon, 2025-10-27 at 11:46 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Currently, nfsd_is_write_dio_possible() only considers file offset
>> alignment (nf_dio_offset_align) when splitting an NFS WRITE request
>> into segments. This leaves accounting for memory buffer alignment
>> (nf_dio_mem_align) until nfsd_setup_write_dio_iters(). If this
>> second check fails, the code falls back to cached I/O entirely,
>> wasting the opportunity to use direct I/O for the bulk of the
>> request.
>>
>> Enhance the logic to find a beginning segment size that satisfies
>> both alignment constraints simultaneously. The search algorithm
>> starts with the file offset alignment requirement and steps through
>> multiples of offset_align, checking memory alignment at each step.
>> The search is bounded by lcm(offset_align, mem_align) to ensure that
>> it always terminates.
>>
>> Signed-off-by: Chuck Lever <cel@kernel.org>
>> ---
>>  fs/nfsd/filecache.c |   5 ++
>>  fs/nfsd/filecache.h |   1 +
>>  fs/nfsd/vfs.c       | 119 +++++++++++++++++++++++++++++---------------
>>  3 files changed, 86 insertions(+), 39 deletions(-)
>>
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index a238b6725008..89adc4ab5b24 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -40,6 +40,7 @@
>>  #include <linux/seq_file.h>
>>  #include <linux/rhashtable.h>
>>  #include <linux/nfslocalio.h>
>> +#include <linux/lcm.h>
>>  
>>  #include "vfs.h"
>>  #include "nfsd.h"
>> @@ -234,6 +235,7 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
>>  	nf->nf_dio_mem_align = 0;
>>  	nf->nf_dio_offset_align = 0;
>>  	nf->nf_dio_read_offset_align = 0;
>> +	nf->nf_dio_align_lcm = 0;
>>  	return nf;
>>  }
>>  
>> @@ -1071,6 +1073,9 @@ nfsd_file_get_dio_attrs(const struct svc_fh *fhp, struct nfsd_file *nf)
>>  	if (stat.result_mask & STATX_DIOALIGN) {
>>  		nf->nf_dio_mem_align = stat.dio_mem_align;
>>  		nf->nf_dio_offset_align = stat.dio_offset_align;
>> +		if (stat.dio_mem_align && stat.dio_offset_align)
>> +			nf->nf_dio_align_lcm = lcm(stat.dio_mem_align,
>> +						   stat.dio_offset_align);
>>  	}
>>  	if (stat.result_mask & STATX_DIO_READ_ALIGN)
>>  		nf->nf_dio_read_offset_align = stat.dio_read_offset_align;
>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>> index e3d6ca2b6030..2648aaab5a1b 100644
>> --- a/fs/nfsd/filecache.h
>> +++ b/fs/nfsd/filecache.h
>> @@ -58,6 +58,7 @@ struct nfsd_file {
>>  	u32			nf_dio_mem_align;
>>  	u32			nf_dio_offset_align;
>>  	u32			nf_dio_read_offset_align;
>> +	unsigned long		nf_dio_align_lcm;
>>  };
>>  
>>  int nfsd_file_cache_init(void);
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 37353fb48d58..a872be300c9f 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1261,49 +1261,73 @@ struct nfsd_write_dio_seg {
>>  
>>  struct nfsd_write_dio_args {
>>  	struct nfsd_file		*nf;
>> -	size_t				first, middle, last;
>>  	unsigned int			nsegs;
>>  	struct nfsd_write_dio_seg	segment[3];
>>  };
>>  
>> +/*
>> + * Find the minimum offset within the write request that aligns both
>> + * the file offset and memory buffer for direct I/O.
>> + *
>> + * Returns the size of the unaligned prefix, or SIZE_MAX if no alignment
>> + * is possible within reasonable bounds.
>> + */
>> +static size_t
>> +nfsd_find_dio_aligned_offset(struct nfsd_file *nf, loff_t file_offset,
>> +			     unsigned long mem_offset, size_t total_len)
>> +{
>> +	u32 offset_align = nf->nf_dio_offset_align;
>> +	u32 mem_align = nf->nf_dio_mem_align;
>> +	unsigned long search_limit;
>> +	size_t first;
>> +
>> +	/* Start with the file offset alignment requirement */
>> +	first = round_up(file_offset, offset_align) - file_offset;
>> +
>> +	/* Quick check: does this also satisfy memory alignment? */
>> +	if (((mem_offset + first) & (mem_align - 1)) == 0)
>> +		return first;
>> +
>> +	/*
>> +	 * Search for a value that satisfies both constraints by stepping
>> +	 * through multiples of offset_align. Limit search to one period
>> +	 * of the LCM. We need to check up through the search_limit to
>> +	 * cover all possible alignments within the LCM period.
>> +	 */
>> +	search_limit = min_t(unsigned long, nf->nf_dio_align_lcm, total_len);
>> +
>> +	for (; first <= search_limit && first < total_len; first += offset_align) {
>> +		if (((mem_offset + first) & (mem_align - 1)) == 0)
>> +			return first;
>> +	}
>> +
>> +	return SIZE_MAX;  /* No alignment found */
>> +}
>> +
>> +/*
>> + * Check if the underlying file system implements direct I/O.
>> + */
>>  static bool
>>  nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
>>  			   struct nfsd_write_dio_args *args)
>>  {
>> -	u32 dio_blocksize = args->nf->nf_dio_offset_align;
>> -	loff_t first_end, orig_end, middle_end;
>> +	u32 offset_align = args->nf->nf_dio_offset_align;
>> +	u32 mem_align = args->nf->nf_dio_mem_align;
>>  
>> -	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
>> -		return false;
>> -	if (unlikely(len < dio_blocksize))
>> +	if (unlikely(!mem_align || !offset_align))
>>  		return false;
>>  
>> -	first_end = round_up(offset, dio_blocksize);
>> -	orig_end = offset + len;
>> -	middle_end = round_down(orig_end, dio_blocksize);
>> +	/*
>> +	 * Need enough data to potentially find an aligned segment.
>> +	 * In the worst case, we might need up to
>> +	 * lcm(offset_align, mem_align) bytes for the prefix.
>> +	 */
>> +	if (unlikely(len < max(offset_align, mem_align)))
>> +		return false;
>>  
>> -	args->first = first_end - offset;
>> -	args->middle = middle_end - first_end;
>> -	args->last = orig_end - middle_end;
>>  	return true;
>>  }
>>  
>> -/*
>> - * Check if the bvec iterator is aligned for direct I/O.
>> - *
>> - * bvecs generated from RPC receive buffers are contiguous: After the first
>> - * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
>> - * Therefore, only the first bvec is checked.
>> - */
>> -static bool
>> -nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
>> -{
>> -	unsigned int addr_mask = nf->nf_dio_mem_align - 1;
>> -	const struct bio_vec *bvec = i->bvec;
>> -
>> -	return !((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask);
>> -}
>> -
>>  static void
>>  nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
>>  			struct bio_vec *bvec, unsigned int nvecs,
>> @@ -1318,29 +1342,45 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
>>  
>>  static bool
>>  nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
>> -			   unsigned long total,
>> +			   loff_t offset, unsigned long total,
>>  			   struct nfsd_write_dio_args *args)
>>  {
>> +	u32 offset_align = args->nf->nf_dio_offset_align;
>> +	unsigned long mem_offset = bvec->bv_offset;
>> +	loff_t prefix_end, orig_end, middle_end;
>> +	size_t prefix, middle, suffix;
>> +
>>  	args->nsegs = 0;
>>  
>> -	if (args->first) {
>> +	prefix = nfsd_find_dio_aligned_offset(args->nf, offset, mem_offset,
>> +					     total);
>> +	if (prefix == SIZE_MAX)
>> +		return false;	/* No alignment possible */
>> +
>> +	prefix_end = offset + prefix;
>> +	orig_end = offset + total;
>> +	middle_end = round_down(orig_end, offset_align);
>> +
>> +	middle = middle_end - prefix_end;
>> +	suffix = orig_end - middle_end;
>> +
>> +	if (prefix) {
>>  		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
>> -					nvecs, total, 0, args->first);
>> +					nvecs, total, 0, prefix);
>>  		++args->nsegs;
>>  	}
>>  
>> +	if (!middle)
>> +		return false;	/* No aligned region for DIO */
>> +
>>  	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
>> -				total, args->first, args->middle);
>> -	if (!nfsd_iov_iter_aligned_bvec(args->nf,
>> -					&args->segment[args->nsegs].iter))
>> -		return false;	/* no DIO-aligned IO possible */
>> +				total, prefix, middle);
>>  	args->segment[args->nsegs].use_dio = true;
>>  	++args->nsegs;
>>  
>> -	if (args->last) {
>> +	if (suffix) {
>>  		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
>> -					nvecs, total, args->first +
>> -					args->middle, args->last);
>> +					nvecs, total, prefix + middle, suffix);
>>  		++args->nsegs;
>>  	}
>>  
>> @@ -1373,7 +1413,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
>>  	ssize_t host_err;
>>  	unsigned int i;
>>  
>> -	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, *cnt, args))
>> +	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
>> +					*cnt, args))
>>  		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
>>  
>>  	/*
> 
> Not an easy patch to follow, but I think I get it.

Agreed, and that is certainly concerning.

"Kernighan's Law - Debugging is twice as hard as writing the code in the
first place. Therefore, if you write the code as cleverly as possible,
you are, by definition, not smart enough to debug it."


> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

