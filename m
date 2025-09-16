Return-Path: <linux-nfs+bounces-14492-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47273B59CFB
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 18:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281391B26463
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720920DD42;
	Tue, 16 Sep 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvPX6OkZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE42BCF4C
	for <linux-nfs@vger.kernel.org>; Tue, 16 Sep 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038627; cv=none; b=ixYnbajnCQEjqXiwUqklXoZDCszfWq+l7WxreHgR30ig9ItwS1BekaatMY6tgaSBibAKMcabnngbKZBQoNDqN4ohaLTMN0OAyPoaFRvbGoIkujM84VYLEKxDXTbugl30bUpk83KFsS6dN9MkzDJYk7JpmPQac7TEJ45n0DN/R9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038627; c=relaxed/simple;
	bh=U1PCgjahn9zEO27vBYmN3IZe2U9qz6UkmdtSm1Pr+Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=theY5+BJhJHEUT9saATtG8zznrrbBfa4gbL6AVkNyeDDekE62230yXZIgcZeLquePg1qGfn8D41faTSP/a1egl8GHurBeiqmeIV/fb+ki8XLhFaxoEhuwPD6MLRWT3hDbwd3Un1N2e1LP3x4hJuJJbcFW+ZVkKT8eAFOqNPrVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvPX6OkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5DDC4CEEB;
	Tue, 16 Sep 2025 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758038626;
	bh=U1PCgjahn9zEO27vBYmN3IZe2U9qz6UkmdtSm1Pr+Io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EvPX6OkZgznqSg5Ys277BktIeUxoZsY45o4l3qTgx7ffVlDO+tJRBMLuhqLvvVIvq
	 Wu3kHF7RMjQz87uiHtpK50jbpjpxRfU2H4tjUZ8+gkfrVqJS5HVllZWzXI6bC8PCG7
	 PBmUCOybatMuYFmFR83ObmZDcTOnyfBO1xG99g810tLNSItuaspGOFCyc0/vSx/yxz
	 e9+HyWdMRfGa8D4vUqui+lg/YE/t/hwfgBtsMYrjEciuf9Kqu60dbbJM8GrRpgGe3b
	 sxpHSg3EOJjvLidhtacLOzjz9QHRjqRKhvMinyUCTQ8qHiilVAKeX2p4JATaiWG++G
	 2sNCvlXnIt7GQ==
Message-ID: <ec014c3d-1182-4d47-b10d-b67da5623dcb@kernel.org>
Date: Tue, 16 Sep 2025 09:03:45 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSD: Add array bounds-checking in nfsd_iter_read()
To: Mike Snitzer <snitzer@kernel.org>
Cc: neil@brown.name, jlayton@kernel.org, okorniev@redhat.com,
 dai.ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
References: <175803617610.13710.7007300747292684854.stgit@oracle-102.nfsv4bat.org>
 <aMmJ31N8QKqw-YsT@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aMmJ31N8QKqw-YsT@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 9:01 AM, Mike Snitzer wrote:
> On Tue, Sep 16, 2025 at 11:24:19AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The *count parameter does not appear to be explicitly restricted
>> to being smaller than rsize, so it might be possible to overrun
>> the rq_bvec or rq_pages arrays.
>>
>> Rather than overrunning these arrays (damage done!) and then WARNING
>> once, let's harden the loop so that it terminates before the end of
>> the arrays are reached. This should result in a short read, which is
>> OK -- clients recover by sending additional READ requests for the
>> remaining unread bytes.
>>
>> Reported-by: NeilBrown <neil@brown.name>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Looks even better.

If Neil agrees, I will fold a similar change into the direct read
patch.


> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> 
> 
>> ---
>>  fs/nfsd/vfs.c |   12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> Changes since v1:
>> - Check for overrunning rq_pages as well
>> - Move bounds checking to top of the loop
>> - Move incrementing to the bottom of the loop
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 714777c221ed..2026431500ec 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1115,18 +1115,20 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  
>>  	v = 0;
>>  	total = *count;
>> -	while (total) {
>> +	while (total && v < rqstp->rq_maxpages &&
>> +	       rqstp->rq_next_page < rqstp->rq_page_end) {
>>  		len = min_t(size_t, total, PAGE_SIZE - base);
>> -		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
>> +		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
>>  			      len, base);
>> +
>>  		total -= len;
>> +		++rqstp->rq_next_page;
>>  		++v;
>>  		base = 0;
>>  	}
>> -	WARN_ON_ONCE(v > rqstp->rq_maxpages);
>>  
>> -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>> -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
>> +	trace_nfsd_read_vector(rqstp, fhp, offset, *count - total);
>> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count - total);
>>  	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>  }
>>
>>
>>


-- 
Chuck Lever

