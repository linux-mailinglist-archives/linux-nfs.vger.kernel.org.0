Return-Path: <linux-nfs+bounces-11292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFDFA9DBB1
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 17:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CD6172BE6
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570B25C815;
	Sat, 26 Apr 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLz9WhwE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127F253F3D
	for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680111; cv=none; b=FN5hCX4teyxRM0W1gB0w4vdA8nxmLFqWyPLyCz30nvxAzfA+58Xh7kG/KPdyoA2ezq7V2VxLMLpOUphPm0dQbhePEEf5baUgdzrFFRO/hA0x71NLgP6zqoUBNhTKEAfhrFn4S85uJEntOfWCgxMmzegcwwr+ynJKeLgIvBVdPYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680111; c=relaxed/simple;
	bh=jdRQmtVu7YJSuJaqnCRAtbaU8SB+xviJGsE+0pWr19Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6dxpjDqaoQEMfSUT4Pb4IAGNToadf8YrdtsZ8C4u4WPTjlkUWxZSqcqVVY5dwxGLMceP7OWiUvNwli/zFOVqaOO2GE7CfmWl61VpYcEIOId04gk8ohPINlX3K10kGc/pQ7QVzGkF90w1fCXrnD6kt6uFLXoDXas8nVm33Os9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLz9WhwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D647CC4CEE2;
	Sat, 26 Apr 2025 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745680110;
	bh=jdRQmtVu7YJSuJaqnCRAtbaU8SB+xviJGsE+0pWr19Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LLz9WhwEVlIUTPikq/u4EHjm/QVDdPDG4erkEHWlAzsQOtPIX6HOT1sV9JeswsLU7
	 SmZN9IPmQrqZRTnHrXUxA7TcNVMXBpkpYbTqi7CkVRysUWBQ9u7SzeBcmKyjQuOOc7
	 I0ToSxC8Wd5YyyqyTV7yWETalcL1/GsSp+5No5K9x5vpqJrjhGUYTBt27lq6QZ1vR6
	 /ZJru95Se4Ze7y/zj90FOzcafuFSTrAZG5Z2h+dSr+STYUl8qpx+2QQGtf52y8IoC7
	 jwkJqn4J1spV2yQS3amedN3bUg/1v3TGvbvDLN3QbfN/p285hvSPaijnzrb57Ptw8O
	 etRRk175lkZtA==
Message-ID: <80975590-d320-4420-adfb-7e7e3ad25f6a@kernel.org>
Date: Sat, 26 Apr 2025 11:08:28 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] NFSD: Remove NFSSVC_MAXBLKSIZE from
 .pc_xdrressize
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250423152117.5418-1-cel@kernel.org>
 <20250423152117.5418-12-cel@kernel.org>
 <174564186264.500591.13673906323063582835@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <174564186264.500591.13673906323063582835@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/25 12:31 AM, NeilBrown wrote:
> On Thu, 24 Apr 2025, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The value in the .pc_xdrressize field is used to "reserve space in
>> the output queue". Relevant only to UDP transports, AFAICT.
>>
>> The fixed value of NFSSVC_MAXBLKSIZE is added to that field for
>> NFSv2 and NFSv3 read requests, even though nfsd_proc_read() is
>> already careful to reserve the actual size of the read payload.
>> Adding the maximum payload size to .pc_xdrressize seems to be
>> unnecessary.
> 
> I believe it is necessary.
> 
> svc_reserve() (and svc_reserve_auth) only ever reduces the size of the
> reservation.
> ->rq_reserved is initialised to serv->sv_max_mesg, then reduced to
> .pc_xdrressize once the proc is known, then possibly reduced further by
> code in the proc.
> So .pc_xdrressize must be (at least) the largest possible size.

Hrm. I instrumented this code path. It seemed to be doing exactly
what I expected. The behavior of xdr_reserve_space() is to /increase/
buffer space reservation, so svc_reserve() seems to behave in the
opposite way, then?

So if the maximum payload size is no longer a constant, these
pc_xdrressize values still have to add the largest payload size that
NFSD can support (probably will be 8MB), not the max-payload-size
setting in effect for that nfsd thread pool.


>> Also, instead of adding a constant 4 bytes for each payload's
>> XDR pad, add the actual size of the pad for better accuracy of
>> the reservation size.
> 
> Could we instead change svc_reserve() to add the pad, and remove all the
> manual padding?

The padding is needed only for a few certain operations; READ and
READLINK, I think that's it. NFSv4 GETATTR might need it too.

IOW the common case is that no padding is needed.

The largest payload, even if it needs an XDR pad, will be
NFSSVC_MAXBLKSIZE.


> But pc_xdrressize is in xdr units - it is multiplied by 4 before passing
> to svc_reserve.  So these changes don't do what you think they do...

Fair enough. I can drop "NFSD: Remove NFSSVC_MAXBLKSIZE from
.pc_xdrressize" and "NFSD: Remove NFSD_BUFSIZE".

I find the name NFSSVC_MAXBLKSIZE confusing, though. NFS is a file
protocol, so I'm not clear what a "block" is in this context.

Also, am I correct that the only transport that cares about this
send buffer reservation is UDP?


> NeilBrown
> 
> 
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs3proc.c | 4 ++--
>>  fs/nfsd/nfsproc.c  | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index 372bdcf5e07a..dbb750a7b5db 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -202,7 +202,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
>>  	 */
>>  	resp->count = argp->count;
>>  	svc_reserve_auth(rqstp, ((1 + NFS3_POST_OP_ATTR_WORDS + 3) << 2) +
>> -			 resp->count + 4);
>> +			 xdr_align_size(resp->count));
>>  
>>  	fh_copy(&resp->fh, &argp->fh);
>>  	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
>> @@ -921,7 +921,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
>>  		.pc_argzero = sizeof(struct nfsd3_readargs),
>>  		.pc_ressize = sizeof(struct nfsd3_readres),
>>  		.pc_cachetype = RC_NOCACHE,
>> -		.pc_xdrressize = ST+pAT+4+NFSSVC_MAXBLKSIZE/4,
>> +		.pc_xdrressize = ST+pAT+3,
>>  		.pc_name = "READ",
>>  	},
>>  	[NFS3PROC_WRITE] = {
>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>> index 6dda081eb24c..a95faf726e58 100644
>> --- a/fs/nfsd/nfsproc.c
>> +++ b/fs/nfsd/nfsproc.c
>> @@ -219,7 +219,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
>>  	/* Obtain buffer pointer for payload. 19 is 1 word for
>>  	 * status, 17 words for fattr, and 1 word for the byte count.
>>  	 */
>> -	svc_reserve_auth(rqstp, (19<<2) + argp->count + 4);
>> +	svc_reserve_auth(rqstp, (19<<2) + xdr_align_size(argp->count));
>>  
>>  	resp->count = argp->count;
>>  	fh_copy(&resp->fh, &argp->fh);
>> @@ -739,7 +739,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
>>  		.pc_argzero = sizeof(struct nfsd_readargs),
>>  		.pc_ressize = sizeof(struct nfsd_readres),
>>  		.pc_cachetype = RC_NOCACHE,
>> -		.pc_xdrressize = ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
>> +		.pc_xdrressize = ST+AT+1,
>>  		.pc_name = "READ",
>>  	},
>>  	[NFSPROC_WRITECACHE] = {
>> -- 
>> 2.49.0
>>
>>
> 
> 


-- 
Chuck Lever

