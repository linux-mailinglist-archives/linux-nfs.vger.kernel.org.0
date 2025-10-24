Return-Path: <linux-nfs+bounces-15605-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A299C06F21
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591F81C08799
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BB231B818;
	Fri, 24 Oct 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejv6irFg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD8317710
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319404; cv=none; b=nP2BSGdhVBDmIvKXW0jxkdYofoF6nAcsoIs+YlrktTRzJPncdv5AX1C3hKZ/nQKwjwGEICbnnWxu5lUtFmPLmCkfXGBJpeVpayr1YJWbsvRMfBu1HXySjD6TpkNAPcyFBCAheVJogRwk8bWQiBVa4EzO9/5bjyEtRMVhVUFpCys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319404; c=relaxed/simple;
	bh=WIDo+LYAKLoSsYwUdZ1IramkLTrZ6aljs0qDqw2VOIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1YX6lWQ4i4kKiSDDNXGBLcpJf8DcWDp04LYP/08D3gmlE+DaMq68sI3NUV/bKZ0vk2RkoVVuVOe4sMvsRcCJRKYosSOwNuJC7lgaLcYZwd9hwVms1TXNVRkDWMXTte4XnqCMxXm5b/zYAO3eDyMCXI37vklBf0c6LEZjIONKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejv6irFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10124C4CEF1;
	Fri, 24 Oct 2025 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761319403;
	bh=WIDo+LYAKLoSsYwUdZ1IramkLTrZ6aljs0qDqw2VOIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ejv6irFgYEkQWippg6hpZCuHBVnGBB1zvgaW2RrbM159TaU3/9sFVm29l3dHYXxMX
	 mSBHieA4/Udp0ZLMegXp/k9wLEviXqpZoxhac1s/w8QFnxZgYK/ZCNfkNbNvKjiqoz
	 70tA6dn945olKHzH+Z3lSRSKJgGBMSDI+iuCd+E7qcDKTsU1KjFj8bkfbD1FdDAB7f
	 FGwDwUMIut6xxWd/+NrMc5aEbvyLOc/DCMPIFLtm/jAOG1p0DILDWDH+RN9R/L+WBq
	 BvyUKoyHe+elZx6M0JNtH0WOjQezLOSCzmpgqjyUhG2xq0e8WzVjvJQ/25rRbUh1nT
	 5xYMRu56Ze6vA==
Message-ID: <e1f12d60-7194-4073-9842-c5310405d377@kernel.org>
Date: Fri, 24 Oct 2025 11:23:22 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org>
 <00759cf60e8549aa882968f83aa2885e69b44664.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <00759cf60e8549aa882968f83aa2885e69b44664.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 11:22 AM, Jeff Layton wrote:
> On Fri, 2025-10-24 at 10:42 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Clean up: The helpers in the nfsd_direct_write() code path don't set
>> stable_how to anything else but NFS_FILE_SYNC. All data writes in
>> this code path result in immediately durability.
>>
>> Instead of passing it through the stack of functions, just set it
>> after the call is done.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/vfs.c | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 2832a66cda5b..cd2c99e450fb 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1374,9 +1374,10 @@ nfsd_iocb_write(struct file *file, struct bio_vec *bvec, unsigned int nvecs,
>>  }
>>  
>>  static int
>> -nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>> -		     u32 *stable_how, unsigned int nvecs, unsigned long *cnt,
>> -		     struct kiocb *kiocb, struct nfsd_write_dio *write_dio)
>> +nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		     struct nfsd_file *nf, unsigned int nvecs,
>> +		     unsigned long *cnt, struct kiocb *kiocb,
>> +		     struct nfsd_write_dio *write_dio)
>>  {
>>  	struct file *file = nf->nf_file;
>>  	bool iter_is_dio_aligned[3];
>> @@ -1399,10 +1400,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_fil
>>  	/*
>>  	 * Any buffered IO issued here will be misaligned, use
>>  	 * sync IO to ensure it has completed before returning.
>> -	 * Also update @stable_how to avoid need for COMMIT.
>>  	 */
>>  	kiocb->ki_flags |= IOCB_DSYNC;
>> -	*stable_how = NFS_FILE_SYNC;
>>  
>>  	*cnt = 0;
>>  	for (int i = 0; i < n_iters; i++) {
>> @@ -1442,7 +1441,7 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_fil
>>  
>>  static noinline_for_stack int
>>  nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
>> +		  struct nfsd_file *nf, unsigned int nvecs,
>>  		  unsigned long *cnt, struct kiocb *kiocb)
>>  {
>>  	struct nfsd_write_dio write_dio;
>> @@ -1456,8 +1455,8 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  		kiocb->ki_flags |= IOCB_DONTCACHE;
>>  
>>  	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
>> -		return nfsd_issue_write_dio(rqstp, fhp, nf, stable_how, nvecs,
>> -					    cnt, kiocb, &write_dio);
>> +		return nfsd_issue_write_dio(rqstp, fhp, nf, nvecs, cnt, kiocb,
>> +					    &write_dio);
>>  
>>  	return nfsd_iocb_write(nf->nf_file, rqstp->rq_bvec, nvecs, cnt, kiocb);
>>  }
>> @@ -1539,9 +1538,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  
>>  	switch (nfsd_io_cache_write) {
>>  	case NFSD_IO_DIRECT:
>> -		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
>> -					     nvecs, cnt, &kiocb);
>> -		stable = *stable_how;
>> +		host_err = nfsd_direct_write(rqstp, fhp, nf, nvecs, cnt,
>> +					     &kiocb);
>> +		stable = *stable_how = NFS_FILE_SYNC;
>>  		break;
>>  	case NFSD_IO_DONTCACHE:
>>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
> 
> I assume you're going to squash some of these changes into the original
> patches?

As the cover letter mentions, they can be squashed, rejected, or updated
individually... yes, squashing may occur. ;-)


> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

