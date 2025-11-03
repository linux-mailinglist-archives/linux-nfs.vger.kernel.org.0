Return-Path: <linux-nfs+bounces-15979-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDBAC2E503
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A8F1882F4C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46EB2BE631;
	Mon,  3 Nov 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjx4vzGR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE131A9F82
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210091; cv=none; b=l0m7diGATFUcFhXfyBwoR/ljbgX1wRShWyu2WuzZJanZpfWPOs4+YwWod3cgjMJPL7geb1RRCUTEyQ0i00v8jYQTD+HIx8BZnf4dP6MBwwVNqPcoOPrZx4JXsSo4ViDtO+7M/bhklE1DYM4sVVnRETCD9qlKrDfS/Q/S39feK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210091; c=relaxed/simple;
	bh=UKH8pKkn/abBu57dT7meRnM57daldXyVMaR7d11cR3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8/Y/2jyRxQF1PG9POoETFavV2Xiwq+aGc6zcPkVsw31x+XrnVjLGYSSH2byi677EXYVv3bKFZL6/DUGWh0mtBSFBhmb/qJhAUGnymyn0CfJSvuCKhEO0CMhUvqC80waPfUf/Ba3rPijJ69+W0m+XFfLk3H4rJRf8/eyZJxAdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjx4vzGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A5EC4CEE7;
	Mon,  3 Nov 2025 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762210089;
	bh=UKH8pKkn/abBu57dT7meRnM57daldXyVMaR7d11cR3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pjx4vzGRpa6+IwpNmDPEe8hB9GuZfrMDg+y2b16Kv9HJGVktWA5A0uEC22CeX1yLT
	 IXsCn52E+3b3alEA3bDljVZpVyvWFv20TW0uRMSrXvHE+GpiPXIhurx+o/70AjZzR0
	 BD/amCg8HqgA6nNPEWheAIAD47RVmyMDkRQrNGxn/dzXxPlLoPcSt1eqL0Z1YERDAy
	 03zBLq9Bs8bhpRFeIH7gDYjYGjT+/NbqdbLyAO81T5uWfQfAnW2TT+MZjxySoUXMf5
	 xGgYtN6afmrlPyspb3c+o4Kds5Iu6Hw6Ef1Ly5YXzxxPxKsU+uREHHQ3rVIEVOrMGh
	 EElyTH6BAqOiA==
Message-ID: <f264b861-5c98-423e-88e1-ac6bb8bb51d5@kernel.org>
Date: Mon, 3 Nov 2025 17:48:07 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/12] NFSD: Introduce struct nfsd_write_dio_seg
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>,
 Mike Snitzer <snitzer@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-8-cel@kernel.org>
 <176220993570.1793333.17159889042261464805@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <176220993570.1793333.17159889042261464805@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 5:45 PM, NeilBrown wrote:
> On Tue, 04 Nov 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Passing iter arrays by reference is a little risky. Instead, pass a
>> struct with a fixed-size array so bounds checking can be done.
>>
>> Name each item in the array a "segment", as the term "extent"
>> generally refers to a set of blocks on storage, not to a buffer.
>> Each segment is processed via a single vfs_iocb_iter_write() call,
>> and is either IOCB_DIRECT or buffered.
>>
>> Introduce a segment constructor function so each segment is
>> initialized identically.
>>
>> Consensus is that allowing the code to build segment arrays that
>> are smaller than 3 is better than the I/O loop unconditionally
>> visiting all 3 segments, skipping the zero-length ones.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/vfs.c | 120 ++++++++++++++++++++++++--------------------------
>>  1 file changed, 58 insertions(+), 62 deletions(-)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 326c60eada65..5d6efcceb8c9 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1254,12 +1254,16 @@ static int wait_for_concurrent_writes(struct file *file)
>>  	return err;
>>  }
>>  
>> +struct nfsd_write_dio_seg {
>> +	struct iov_iter			iter;
>> +	bool				use_dio;
>> +};
>> +
>>  struct nfsd_write_dio_args {
>>  	struct nfsd_file		*nf;
>> -
>> -	ssize_t	start_len;	/* Length for misaligned first extent */
>> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>> -	ssize_t	end_len;	/* Length for misaligned last extent */
>> +	size_t				first, middle, last;
>> +	unsigned int			nsegs;
>> +	struct nfsd_write_dio_seg	segment[3];
>>  };
>>  
>>  static bool
>> @@ -1267,21 +1271,20 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
>>  			   struct nfsd_write_dio_args *args)
>>  {
>>  	u32 dio_blocksize = args->nf->nf_dio_offset_align;
>> -	loff_t start_end, orig_end, middle_end;
>> +	loff_t first_end, orig_end, middle_end;
>>  
>>  	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
>>  		return false;
>>  	if (unlikely(len < dio_blocksize))
>>  		return false;
>>  
>> -	start_end = round_up(offset, dio_blocksize);
>> +	first_end = round_up(offset, dio_blocksize);
>>  	orig_end = offset + len;
>>  	middle_end = round_down(orig_end, dio_blocksize);
>>  
>> -	args->start_len = start_end - offset;
>> -	args->middle_len = middle_end - start_end;
>> -	args->end_len = orig_end - middle_end;
>> -
>> +	args->first = first_end - offset;
>> +	args->middle = middle_end - first_end;
>> +	args->last = orig_end - middle_end;
> 
> The commit message didn't warn that "start" is being renamed to "first"
> and that "_len" is being dropped.
> I can understand the former (though I'd go for "head", "body", "tail"
> myself) but I would prefer to keep _len.

A subsequent patch renames these variables again to "prefix", "middle",
and "suffix". The series should probably just stick with one rename.


>>  	return true;
>>  }
>>  
>> @@ -1311,47 +1314,47 @@ nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
>>  	return true;
>>  }
>>  
>> -/*
>> - * Setup as many as 3 iov_iter based on extents described by @write_dio.
>> - * Returns the number of iov_iter that were setup.
>> - */
>> -static int
>> -nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
>> -			   struct bio_vec *rq_bvec, unsigned int nvecs,
>> -			   unsigned long cnt, struct nfsd_write_dio_args *args)
>> +static void
>> +nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
>> +			struct bio_vec *bvec, unsigned int nvecs,
>> +			unsigned long total, size_t start, size_t len)
>>  {
>> -	int n_iters = 0;
>> -	struct iov_iter *iters = *iterp;
>> +	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
>> +	if (start)
>> +		iov_iter_advance(&segment->iter, start);
> 
> To me, this would read better as
>      if (start_len)
>               iov_iter......
> 
> 
> But I don't see anything actually wrong with the patch, so
>  Reviewed-by: NeilBrown <neil@brown.name>
> 
> NeilBrown
> 
> 
> 
>> +	iov_iter_truncate(&segment->iter, len);
>> +	segment->use_dio = false;
>> +}
>>  
>> -	/* Setup misaligned start? */
>> -	if (args->start_len) {
>> -		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>> -		iters[n_iters].count = args->start_len;
>> -		iter_is_dio_aligned[n_iters] = false;
>> -		++n_iters;
>> +static bool
>> +nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
>> +			   unsigned long total,
>> +			   struct nfsd_write_dio_args *args)
>> +{
>> +	args->nsegs = 0;
>> +
>> +	if (args->first) {
>> +		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
>> +					nvecs, total, 0, args->first);
>> +		++args->nsegs;
>>  	}
>>  
>> -	/* Setup DIO-aligned middle */
>> -	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>> -	if (args->start_len)
>> -		iov_iter_advance(&iters[n_iters], args->start_len);
>> -	iters[n_iters].count -= args->end_len;
>> -	iter_is_dio_aligned[n_iters] =
>> -		nfsd_iov_iter_aligned_bvec(args->nf, &iters[n_iters]);
>> -	if (unlikely(!iter_is_dio_aligned[n_iters]))
>> -		return 0; /* no DIO-aligned IO possible */
>> -	++n_iters;
>> +	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
>> +				total, args->first, args->middle);
>> +	if (!nfsd_iov_iter_aligned_bvec(args->nf,
>> +					&args->segment[args->nsegs].iter))
>> +		return false;	/* no DIO-aligned IO possible */
>> +	args->segment[args->nsegs].use_dio = true;
>> +	++args->nsegs;
>>  
>> -	/* Setup misaligned end? */
>> -	if (args->end_len) {
>> -		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>> -		iov_iter_advance(&iters[n_iters],
>> -				 args->start_len + args->middle_len);
>> -		iter_is_dio_aligned[n_iters] = false;
>> -		++n_iters;
>> +	if (args->last) {
>> +		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
>> +					nvecs, total, args->first +
>> +					args->middle, args->last);
>> +		++args->nsegs;
>>  	}
>>  
>> -	return n_iters;
>> +	return true;
>>  }
>>  
>>  static int
>> @@ -1377,22 +1380,12 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
>>  		     struct nfsd_write_dio_args *args)
>>  {
>>  	struct file *file = args->nf->nf_file;
>> -	bool iter_is_dio_aligned[3];
>> -	struct iov_iter iter_stack[3];
>> -	struct iov_iter *iter = iter_stack;
>> -	unsigned int n_iters = 0;
>> -	unsigned long in_count = *cnt;
>> -	loff_t in_offset = kiocb->ki_pos;
>>  	ssize_t host_err;
>> +	unsigned int i;
>>  
>> -	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
>> -					     rqstp->rq_bvec, nvecs, *cnt,
>> -					     args);
>> -	if (unlikely(!n_iters))
>> +	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, *cnt, args))
>>  		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
>>  
>> -	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
>> -
>>  	/*
>>  	 * Any buffered IO issued here will be misaligned, use
>>  	 * sync IO to ensure it has completed before returning.
>> @@ -1402,18 +1395,21 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how
>>  	*stable_how = NFS_FILE_SYNC;
>>  
>>  	*cnt = 0;
>> -	for (int i = 0; i < n_iters; i++) {
>> -		if (iter_is_dio_aligned[i])
>> +	for (i = 0; i < args->nsegs; i++) {
>> +		if (args->segment[i].use_dio) {
>>  			kiocb->ki_flags |= IOCB_DIRECT;
>> -		else
>> +			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
>> +						args->segment[i].iter.count);
>> +		} else
>>  			kiocb->ki_flags &= ~IOCB_DIRECT;
>>  
>> -		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
>> +		host_err = vfs_iocb_iter_write(file, kiocb,
>> +					       &args->segment[i].iter);
>>  		if (host_err < 0)
>>  			return host_err;
>>  		*cnt += host_err;
>> -		if (host_err < iter[i].count) /* partial write? */
>> -			break;
>> +		if (host_err < args->segment[i].iter.count)
>> +			break;	/* partial write */
>>  	}
>>  
>>  	return 0;
>> -- 
>> 2.51.0
>>
>>
> 


-- 
Chuck Lever

