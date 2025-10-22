Return-Path: <linux-nfs+bounces-15541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE31BFE403
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 23:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2311A06ADA
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752C30148A;
	Wed, 22 Oct 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKy+LK2f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A5275B16
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167377; cv=none; b=ojRbr/Fjqi/uuhgB+0pk4DTtL+/uBmec86cAfrZWpwFMuAone7ZOfIqUlN8+JDEFYmgZZogHMjaVflTfxyRttG17bABDxsc0ytMq79B7wdore2Z8luuC6ZjTOV4pWJwYO73wzYKGYox7cdPdExFS+DSUWZ2ZE/Kd9M1i8xFqWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167377; c=relaxed/simple;
	bh=VAXLSwwbpEO51FtePrCZuImuy7S4yDVAgb2GrrJ7ojc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezXamUq9DUuisQU79jJH8m+sZ1A5EyaLz70R5Rvk3MnH/KkMFU9IJW6Uy36b59BTVUGG4DFA6ZAuHNxPvdHfGHXDRETUUM9B+H1rLzAd39/2+QaFRmXYDRkcHjek/Wxp6t35JPHv0xH1eWVL1+Uh84XWgoBGxCo+qn77OyYTZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKy+LK2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8DDC4CEE7;
	Wed, 22 Oct 2025 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761167377;
	bh=VAXLSwwbpEO51FtePrCZuImuy7S4yDVAgb2GrrJ7ojc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NKy+LK2f8DIRm45CZDn/gSZRiG0bAT+NDZRgHp5x4M2iYlLgyu6Pfu0+3z1mixfC3
	 PmWnalP/4nbLBF/qiHIQufdJ/bje4IpFh2BVIM+BnSN5YfmJ4FOqVehtHtyUuwgQ+O
	 +/W8dN4XCzZze4JBI9aLOfug1HLJkVGCmCNwE/tgQJTASVHR69LwufMM8LNjLzdWMC
	 Xsox41TabJDAM5TQ4jElVrts+ojIyO79VETVzwMR8Er5jLOF2lGtRSHV00pt+7bgfX
	 B72k8bAwIqD8ggDHCzu9he+IJzUw7FvvOs/ygEn1xgNg5jL40+V1+LB95TzPLat5/b
	 Yd8+dmg7m6Y3g==
Message-ID: <ba83af9b-fd11-46d5-b63e-c6be0c989803@kernel.org>
Date: Wed, 22 Oct 2025 17:09:35 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-5-cel@kernel.org> <aPlFdJHa98jfc3m_@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPlFdJHa98jfc3m_@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 4:58 PM, Mike Snitzer wrote:
> On Wed, Oct 22, 2025 at 03:22:07PM -0400, Chuck Lever wrote:
>> From: Mike Snitzer <snitzer@kernel.org>
>>
>> If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
>> middle and end as needed. The large middle extent is DIO-aligned and
>> the start and/or end are misaligned. An O_SYNC buffered write (with
>> preference towards using DONTCACHE) is used for the misaligned extents
>> and O_DIRECT is used for the middle DIO-aligned extent.
>>
>> nfsd_issue_write_dio() promotes @stable_how to NFS_FILE_SYNC, which
>> allows the client to drop its dirty data and avoid needing an extra
>> COMMIT operation.
>>
>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/debugfs.c |   1 +
>>  fs/nfsd/trace.h   |   1 +
>>  fs/nfsd/vfs.c     | 181 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 183 insertions(+)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 41cd2b53d803..29c29a5111f8 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1254,6 +1254,105 @@ static int wait_for_concurrent_writes(struct file *file)
>>  	return err;
>>  }
>>  
>> +struct nfsd_write_dio {
>> +	ssize_t	start_len;	/* Length for misaligned first extent */
>> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>> +	ssize_t	end_len;	/* Length for misaligned last extent */
>> +};
>> +
>> +static bool
>> +nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
>> +			   struct nfsd_file *nf,
>> +			   struct nfsd_write_dio *write_dio)
>> +{
>> +	const u32 dio_blocksize = nf->nf_dio_offset_align;
>> +	loff_t start_end, orig_end, middle_end;
>> +
> 
> I see you removed this check:
> 
> -       if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
> -               return false;
> 
> Curious why. Seems unsafe because they can be 0.

Hm. I might have removed the wrong check. Will fix that up for the next
round.


> 
>> +	if (unlikely(dio_blocksize > PAGE_SIZE || len < dio_blocksize))
>> +		return false;
>> +
>> +	start_end = round_up(offset, dio_blocksize);
>> +	orig_end = offset + len;
>> +	middle_end = round_down(orig_end, dio_blocksize);
>> +
>> +	write_dio->start_len = start_end - offset;
>> +	write_dio->middle_len = middle_end - start_end;
>> +	write_dio->end_len = orig_end - middle_end;
>> +
>> +	return true;
>> +}
> 
> Otherwise, your other changes all seem fine.
> 
> Thanks,
> Mike


-- 
Chuck Lever

