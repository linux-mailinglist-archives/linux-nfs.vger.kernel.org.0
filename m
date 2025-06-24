Return-Path: <linux-nfs+bounces-12680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB46AE5960
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 03:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB2B1B65419
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 01:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E55464E;
	Tue, 24 Jun 2025 01:45:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 029F135946;
	Tue, 24 Jun 2025 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729551; cv=none; b=cUsHTSsc4iD4fbx8whdMBmltzE5zv+lkgC9hZqF5tbgoUnPxnyje69dOYItDiaRKq+HE29L+ssVQH7It9gWppvrPW1DPjMttBPP3yx745UzL0Ugvy1wuzCtWa8hUdlRqknTvpCbD9NBn66bX093OkxAKwha2lq7R/7E/Bt/zNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729551; c=relaxed/simple;
	bh=0KsG6VEkfuLsV8DfBKaGxYfpc6BQCqoyEyq5ihFr1q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=rBs9NCjojuzUYpgvL1djPv/iDFMVq5MxOy90Xp8jgjH0CySWGJqCloGFkeMeMkh2ojNmm31qdkrmtqGL2TYDu8CPnCHjsVlttbwFDVOoMJN2NQ0KoowVpkGGcBsPxmHtSJ65gmeIpZVtpXlLgkvjyNfNKtpZZgPhGhePNgo45KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 3866B60105F15;
	Tue, 24 Jun 2025 09:45:28 +0800 (CST)
Message-ID: <7975be21-045e-4b2b-9c73-79aba5b683db@nfschina.com>
Date: Tue, 24 Jun 2025 09:45:27 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <148c69b4-4cf7-4112-97e8-6a5c23505638@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/6/23 23:47, Dan Carpenter wrote:
> On Mon, Jun 23, 2025 at 08:22:27PM +0800, Su Hui wrote:
>> Using guard() to replace *unlock* label. guard() makes lock/unlock code
>> more clear. Change the order of the code to let all lock code in the
>> same scope. No functional changes.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
>>   1 file changed, 48 insertions(+), 51 deletions(-)
>>
>> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
>> index ba9d326b3de6..2d92adf3e6b0 100644
>> --- a/fs/nfsd/nfscache.c
>> +++ b/fs/nfsd/nfscache.c
>> @@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
>>   
>>   	if (type == RC_NOCACHE) {
>>   		nfsd_stats_rc_nocache_inc(nn);
>> -		goto out;
>> +		return rtn;
>>   	}
>>   
>>   	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
>> @@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
>>   	 */
>>   	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
>>   	if (!rp)
>> -		goto out;
>> +		return rtn;
>>   
>>   	b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
>> -	spin_lock(&b->cache_lock);
>> -	found = nfsd_cache_insert(b, rp, nn);
>> -	if (found != rp)
>> -		goto found_entry;
>> -	*cacherep = rp;
>> -	rp->c_state = RC_INPROG;
>> -	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>> -	spin_unlock(&b->cache_lock);
>> +	scoped_guard(spinlock, &b->cache_lock) {
>> +		found = nfsd_cache_insert(b, rp, nn);
>> +		if (found == rp) {
>> +			*cacherep = rp;
>> +			rp->c_state = RC_INPROG;
>> +			nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>> +			goto out;
> It took me a while to figure out why we've added a goto here.  In the
> original code this "goto out;" was a "spin_unlock(&b->cache_lock);".
> The spin_unlock() is more readable because you can immediately see that
> it's trying to drop the lock where a "goto out;" is less obvious about
> the intention.

Does "break;" be better in this place?  Meaning Break this lock guard scope.

But as NeillBrown suggestion[1], this patch will be replaced by several 
patches.

No matter what, this "goto out;" will be removed in the next v2 patchset.

> I think this patch works fine, but I'm not sure it's an improvement.

Got it, thanks for your suggestions!

[1] 
https://lore.kernel.org/all/175072435698.2280845.12079422273351211469@noble.neil.brown.name/

regards,
Su Hui

