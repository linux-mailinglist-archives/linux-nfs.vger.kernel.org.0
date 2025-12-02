Return-Path: <linux-nfs+bounces-16847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D55C9B9D3
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 14:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A70F4E3321
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E102316197;
	Tue,  2 Dec 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf5wZiqz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A212C15AB
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682442; cv=none; b=RImdyUPLIHdZP0rxwXM6hE+8FPoa2bumbyf/dMIA7IArvCHs2lNsUuhCPf/Vi5Eoy/4HfOkxz+BhiyIPVNLzcn8m/VGnwzGBEctzlvIlKJcM1ELVGSUoAH82td2aKkKXsMTYnQFE5bMfCzZkmve0/NHVPTpfbG8VBzohNS+umNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682442; c=relaxed/simple;
	bh=OPmkAGn4auW8l1xzXu+Dq/ItMdkQ1LKNyO2HtZG35B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOUM5ok4ujxJy+FQZtZenEWd1v2h1ZEmH/LvdgQUNmfU4pnAhvffzB90+aDqFh5QBSJKkhvdIsEgQXloGjJFiBA2MHNJ5+W+YgzhNeIN2nocvYlijbLc4ecXOZfmJU64Lfxjl0JmDz//7aPy6lE1JL+wa8C38vgt8Olub3j//6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf5wZiqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08891C4CEF1;
	Tue,  2 Dec 2025 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764682441;
	bh=OPmkAGn4auW8l1xzXu+Dq/ItMdkQ1LKNyO2HtZG35B0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kf5wZiqzWIEGk2z+M8KN5WSqAOpvE25yt3CkX+yMVSgH7dTiF0C869ggGQNwBTQpj
	 3AOygI798r7Zneezw3D9CEYKkoaSGSwL+WUTxFVhjj3z+zyHfSsgKumpsSXweu9X5Q
	 9q9/bKb2NrOm8xCX1+HzXyvjHJYAjSqlXsmIuMqQvOvJvHvs3I5f+R/YMXLPrdnUPS
	 yMcwNmKeOnGpue7dWPB4QFhhc2f/XnEozkEQut8c0bABGFLMRj5HDczFxToIu590Y5
	 Cs5L12Mj3oOqWx7k9zq0nUCxuL2V+7dPQAueNGzZ21DyfLP+RIrmrHe28ALmFnVkdx
	 +KDFqYzx+UJEg==
Message-ID: <7c1f87c6-9eb1-4efd-832f-0bd0ec2aff0a@kernel.org>
Date: Tue, 2 Dec 2025 08:34:00 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nfsd: fix nfsd_file reference leak in
 nfsd4_add_rdaccess_to_wrdeleg()
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251201220955.1949-1-cel@kernel.org>
 <928e6aa79ece95012ce26d1341c930c3ffe4f7ae.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <928e6aa79ece95012ce26d1341c930c3ffe4f7ae.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 7:08 AM, Jeff Layton wrote:
> On Mon, 2025-12-01 at 17:09 -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> nfsd4_add_rdaccess_to_wrdeleg() unconditionally overwrites
>> fp->fi_fds[O_RDONLY] with a newly acquired nfsd_file. However, if
>> the file already has a READ open from a previous OPEN operation,
>> this overwrites the existing pointer without releasing its reference,
>> orphaning the previous reference.
>>
>> Additionally, the function originally stored the same nfsd_file
>> pointer in both fp->fi_fds[O_RDONLY] and fp->fi_rdeleg_file with
>> only a single reference. When put_deleg_file() runs, it clears
>> fi_rdeleg_file and calls nfs4_file_put_access() to release the file.
>>
>> However, nfs4_file_put_access() only releases fi_fds[O_RDONLY] when
>> the fi_access[O_RDONLY] counter drops to zero. If another READ open
>> exists on the file, the counter remains elevated and the nfsd_file
>> reference from the delegation is never released. This potentially
>> causes open conflicts on that file.
>>
>> But, on server shutdown, these leaks cause __nfsd_file_cache_purge()
>> to encounter files with an elevated reference count that cannot be
>> cleaned up, ultimately triggering a BUG() in kmem_cache_destroy()
>> because there are still nfsd_file objects allocated in that cache.
>>
>> Fixes: e7a8ebc305f2 ("NFSD: Offer write deleg for OPEN4_SHARE_ACCESS_WRITE")
>> X-Cc: stable@vger.kernel.org
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4state.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 35004568d43e..11877b96dc4c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1218,8 +1218,10 @@ static void put_deleg_file(struct nfs4_file *fp)
>>  
>>  	if (nf)
>>  		nfsd_file_put(nf);
>> -	if (rnf)
>> +	if (rnf) {
>> +		nfsd_file_put(rnf);
>>  		nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);
>> +	}
>>  }
>>  
>>  static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
>> @@ -6231,10 +6233,14 @@ nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>  		fp = stp->st_stid.sc_file;
>>  		spin_lock(&fp->fi_lock);
>>  		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>> -		fp = stp->st_stid.sc_file;
> 
> Weird. Just noticed the double assignment here.
> 
>> -		fp->fi_fds[O_RDONLY] = nf;
>> -		fp->fi_rdeleg_file = nf;
>> +		if (!fp->fi_fds[O_RDONLY]) {
>> +			fp->fi_fds[O_RDONLY] = nf;
>> +			nf = NULL;
>> +		}
>> +		fp->fi_rdeleg_file = nfsd_file_get(fp->fi_fds[O_RDONLY]);
>>  		spin_unlock(&fp->fi_lock);
>> +		if (nf)
>> +			nfsd_file_put(nf);
>>  	}
>>  	return true;
>>  }
> 
> I do so wish this refcounting were easier to get right, but I don't
> have any great ideas around it yet.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks for the R-b. Chris's review-prompts do generic navigation of
reference counting, so we have a little more of a back-stop now. I ran
the review-prompts against e7a8ebc305f2 on a lark, and they indeed found
this problem.


-- 
Chuck Lever

