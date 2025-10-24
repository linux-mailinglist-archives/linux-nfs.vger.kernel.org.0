Return-Path: <linux-nfs+bounces-15611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB992C07002
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9A8A4E148E
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57025A2B4;
	Fri, 24 Oct 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qca5m57h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925D202F71
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320277; cv=none; b=bLzsU0vC6dgOiKUSrRY1Z+8IwjYXaCu/FrRd6/73i5ggHCJzSaC6ywhlFhtITHXWMvmJOm0Vi46guptxzNupD+dmQM/fEXv4bvtRUpQe5zIoW87ciuaXZmCJaPFZ4wMs+SBl6xzzJRz8yPMIbuadLx4XLklB1XsnDnBmG67xOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320277; c=relaxed/simple;
	bh=GVvRXS9mmJB6vaQTPpxmkOI+xEGgE0/YxlEviSv3bsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmI+j7WbKp6hwFbZg+sySI30rWq2pun0BKbTHxXfNraT84fp0IYJWtHWJwWiEMsw57wI/FbQ5DuL/qHosArjvZJqF/LYUNaw4prmkUwCBkd72EU9+FjdPGq1YADfZlVhRVj5tkDfDqJbM4fACqQeRbSuzC4zFFFtrPUFoeanRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qca5m57h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9152C4CEF1;
	Fri, 24 Oct 2025 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320277;
	bh=GVvRXS9mmJB6vaQTPpxmkOI+xEGgE0/YxlEviSv3bsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qca5m57hwAQWWTeKox1Yxr6Yq1RE7+5rt40L9kTNSbC/5Ysi6bGgy9rRpBS/fW/wG
	 w6IHqytVEjYd2QUDk2UCdpScjV0HQOfj6o2Rj45cJH7/Mwop/8Dga8TjxlZwBfTHrW
	 Fw88jWmrApKkIww62QTR4vLZ41lhyHPScYHje2oNwetAca//1uoR21xMut9OSuRaKo
	 JChiRH0BXthnCqpw6zpZfvRMdqLzUQklQtNpBIzMtSJHUvMpmQ8BtPMt7/hrkLYGqN
	 iElVAKsVNYRgW9vJ+fNZDYBbaE5CANz8yu6baLaQLmfUcs92wxEy0XzYyMNV35gh3s
	 fdba8bMeegwRQ==
Message-ID: <ea1a7c8a-75fc-47ef-af90-b8074d3853c7@kernel.org>
Date: Fri, 24 Oct 2025 11:37:55 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/14] NFSD: Introduce struct nfsd_write_dio_seg
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-13-cel@kernel.org>
 <4777b7bbc2e2da0add9e1a3e58af87498613b198.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <4777b7bbc2e2da0add9e1a3e58af87498613b198.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 11:30 AM, Jeff Layton wrote:
> On Fri, 2025-10-24 at 10:43 -0400, Chuck Lever wrote:
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
>> Each segment has its own length. The loop that iterates over the
>> segment array can simply skip over the segments of zero length.
>> A count of segments is not needed.
>>
> 
> True, but it's easy to get that sort of accounting wrong, and if we do
> we're looking at a buffer overrun.

All three segment lengths are initialized for each request.


> Maybe it'd be reasonable to keep a
> number of segments in this struct too, if only for defensive coding
> reasons, and to enable proper bounds checking?

Christoph also suggested that. I'll look into it.


>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/vfs.c | 121 ++++++++++++++++++++++++--------------------------
>>  1 file changed, 57 insertions(+), 64 deletions(-)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 429f5fc61ead..b7f217aa4994 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1254,12 +1254,15 @@ static int wait_for_concurrent_writes(struct file *file)
>>  	return err;
>>  }
>>  
>> +struct nfsd_write_dio_seg {
>> +	struct iov_iter			iter;
>> +	size_t				len;
>> +	bool				use_dio;
>> +};
>> +
>>  struct nfsd_write_dio_args {
>>  	struct nfsd_file		*nf;
>> -
>> -	ssize_t	start_len;	/* Length for misaligned first extent */
>> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>> -	ssize_t	end_len;	/* Length for misaligned last extent */
>> +	struct nfsd_write_dio_seg	segment[3];
>>  };
>>  
>>  static bool
>> @@ -1267,21 +1270,19 @@ nfsd_is_write_dio_possible(struct nfsd_write_dio_args *args, loff_t offset,
>>  			   unsigned long len)
>>  {
>>  	const u32 dio_blocksize = args->nf->nf_dio_offset_align;
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
>> -
>> -	args->start_len = start_end - offset;
>> -	args->middle_len = middle_end - start_end;
>> -	args->end_len = orig_end - middle_end;
>> -
>> +	args->segment[0].len = first_end - offset;	/* first segment */
>> +	args->segment[1].len = middle_end - first_end;	/* middle segment */
>> +	args->segment[2].len = orig_end - middle_end;	/* last segment */
>>  	return true;
>>  }
>>  
>> @@ -1308,47 +1309,42 @@ nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
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
>> +nfsd_setup_write_dio_seg(struct nfsd_write_dio_seg *segment,
>> +			 struct bio_vec *bvec, unsigned int nvecs,
>> +			 unsigned long total, size_t start)
>>  {
>> -	int n_iters = 0;
>> -	struct iov_iter *iters = *iterp;
>> +	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
>> +	if (start)
>> +		iov_iter_advance(&segment->iter, start);
>> +	iov_iter_truncate(&segment->iter, segment->len);
>> +	segment->use_dio = false;
>> +}
>>  
>> -	/* Setup misaligned start? */
>> -	if (args->start_len) {
>> -		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>> -		iters[n_iters].count = args->start_len;
>> -		iter_is_dio_aligned[n_iters] = false;
>> -		++n_iters;
>> -	}
>> +static bool
>> +nfsd_setup_write_dio_iters(struct nfsd_write_dio_args *args,
>> +			   struct bio_vec *bvec, unsigned int nvecs,
>> +			   unsigned long total)
>> +{
>> +	/* first segment */
>> +	if (args->segment[0].len)
>> +		nfsd_setup_write_dio_seg(&args->segment[0],
>> +					 bvec, nvecs, total, 0);
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
>> +	/* middle segment */
>> +	nfsd_setup_write_dio_seg(&args->segment[1], bvec, nvecs, total,
>> +				 args->segment[0].len);
>> +	if (!nfsd_iov_iter_aligned_bvec(args->nf, &args->segment[1].iter))
>> +		return false; /* no DIO-aligned IO possible */
>> +	args->segment[1].use_dio = true;
>>  
>> -	/* Setup misaligned end? */
>> -	if (args->end_len) {
>> -		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>> -		iov_iter_advance(&iters[n_iters],
>> -				 args->start_len + args->middle_len);
>> -		iter_is_dio_aligned[n_iters] = false;
>> -		++n_iters;
>> -	}
>> +	/* last segment */
>> +	if (args->segment[2].len)
>> +		nfsd_setup_write_dio_seg(&args->segment[2], bvec, nvecs,
>> +					 total, args->segment[0].len +
>> +					 args->segment[1].len);
>>  
>> -	return n_iters;
>> +	return true;
>>  }
>>  
>>  static int
>> @@ -1373,36 +1369,33 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  		     unsigned int nvecs, unsigned long *cnt)
>>  {
>>  	struct file *file = args->nf->nf_file;
>> -	bool iter_is_dio_aligned[3];
>> -	struct iov_iter iter_stack[3];
>> -	struct iov_iter *iter = iter_stack;
>> -	unsigned int n_iters = 0;
>> -	unsigned long in_count = *cnt;
>> -	loff_t in_offset = kiocb->ki_pos;
>> +	struct nfsd_write_dio_seg *segment;
>>  	ssize_t host_err;
>> +	size_t i;
>>  
>> -	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
>> -					     rqstp->rq_bvec, nvecs, *cnt,
>> -					     args);
>> -	if (unlikely(!n_iters))
>> +	if (!nfsd_setup_write_dio_iters(args, rqstp->rq_bvec, nvecs, *cnt))
>>  		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
>>  				       cnt, kiocb);
>>  
>> -	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
>> -
>>  	*cnt = 0;
>> -	for (int i = 0; i < n_iters; i++) {
>> -		if (iter_is_dio_aligned[i])
>> +	segment = args->segment;
>> +	for (i = 0; i < ARRAY_SIZE(args->segment); i++) {
>> +		if (segment->len == 0)
>> +			continue;
>> +		if (segment->use_dio) {
>>  			kiocb->ki_flags |= IOCB_DIRECT;
>> -		else
>> +			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
>> +						segment->len);
>> +		} else
>>  			kiocb->ki_flags &= ~IOCB_DIRECT;
>>  
>> -		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
>> +		host_err = vfs_iocb_iter_write(file, kiocb, &segment->iter);
>>  		if (host_err < 0)
>>  			return host_err;
>>  		*cnt += host_err;
>> -		if (host_err < iter[i].count) /* partial write? */
>> +		if (host_err < segment->iter.count)
>>  			break;
>> +		++segment;
>>  	}
>>  
>>  	return 0;
> 


-- 
Chuck Lever

