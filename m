Return-Path: <linux-nfs+bounces-16031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD5C33049
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 22:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B0421516
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 21:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892242F746F;
	Tue,  4 Nov 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE5btky1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABE2EFDA2
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291269; cv=none; b=FcZyWnhApKUZ4+A/Qk3nzCuox5ZPjU4lPM8v1vsRGB3O0Y8TtdieFaSzCGVzuIXUOGffLlA6uonGzMabNaRx+/cT6jF0QJAfrUbg72Xs+o8j8RSH8LM0laJH72lH4KpZctLme9Zl4ecKEfng6bMTlTmgGFcYa5WWkW+J83ErexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291269; c=relaxed/simple;
	bh=heSCjsxbUKEwOjiHT7HkOv8lo3GiaOQsrFfxZKPGsKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQxvbCONkFc0RPpb7ZkDTPJwdP+cgKySar0TtrjRTk+1Mh3z1xJlQOBhH0LWYc/l8p5MsunROUh1yRhTB6w9RE4sSnpdQI4EpwOSKOz3KrIEeSOE3D22QF8ADP9O5kP0pDbWZpgHKwhEGwcTMpDR3fF17ZUhUpnJfYyopS6Cbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE5btky1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C075C4CEF7;
	Tue,  4 Nov 2025 21:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291264;
	bh=heSCjsxbUKEwOjiHT7HkOv8lo3GiaOQsrFfxZKPGsKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YE5btky1mNSc8J3RDO92q6bxnaoGl8NIss0U/m/fUN7PeAghIuU405tuVpTghOxLT
	 sTNOsRNvew0GtCcBLBp/1ujbB8DqICqANdaK7uz3UgK5QKhKe4iAyWUTEI+6mkvbXU
	 aIX0AaypqtfnvL5KE+XUmTv4kIiJDwxXv+jLaV+gRg0J2jg5yvmKIpkUN5Qvbj2r3X
	 IRGTMzEYM292tk7oiGXk2vhHtPsSqI2f6niDgVODR7pZ9SdlMFIKRt0XNw6R9/RPFn
	 A60fPv5nbzRTyVi4aaJd6KNaMa3vsotTDwNvkLpKdSO+aQvBh2U+E4sAgCOOnWsVfa
	 1ZAFUBkQbrmuQ==
Message-ID: <5907db3b-818a-470e-932a-db494dc15402@kernel.org>
Date: Tue, 4 Nov 2025 16:21:03 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Prevent a NULL pointer dereference in fh_getattr()
To: NeilBrown <neil@brown.name>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Snitzer <snitzer@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20251104160550.39212-1-cel@kernel.org>
 <176229107621.1793333.11409972513367324811@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <176229107621.1793333.11409972513367324811@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 4:17 PM, NeilBrown wrote:
> On Wed, 05 Nov 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> In general, fh_getattr() can be called after the target dentry has
>> gone negative. For a negative dentry, d_inode(p.dentry) will return
>> NULL. S_ISREG() will dereference that pointer.
> 
> That isn't correct.  While a reference to a dentry is held the inode
> cannot become NULL asynchronously.
> It can change from NULL to non-NULL if another thread "creates".
> It can become NULL if *this* thread calls unlink and no other thread has
> a reference.
> But it cannot suddenly become NULL.
> 
> I like the patch as it avoids a dereference and so puts less pressure on
> the dcache, but it does not change correctness.

I think the steps I'm worried about is if NFSD unlinks the file, and
then something subsequently invokes fh_getattr() assuming that is
safe to do.

How should I update the patch description?


> Sorry if I implied otherwise when I suggested it.
> 
> NeilBrown
> 
> 
>>
>> Avoid this potential regression by using the d_is_reg() helper
>> instead.
>>
>> Suggested-by: NeilBrown <neil@brown.name>
>> Fixes: d11f6cd1bb4a ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfsfh.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> Hi Anna -
>>
>> nfsd-fixes is still based on v6.17-rc, so this patch does not apply
>> to it. Can you take it for v6.18-rc ?
>>
>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> index ed85dd43da18..16182936828f 100644
>> --- a/fs/nfsd/nfsfh.c
>> +++ b/fs/nfsd/nfsfh.c
>> @@ -696,10 +696,9 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
>>  		.mnt		= fhp->fh_export->ex_path.mnt,
>>  		.dentry		= fhp->fh_dentry,
>>  	};
>> -	struct inode *inode = d_inode(p.dentry);
>>  	u32 request_mask = STATX_BASIC_STATS;
>>  
>> -	if (S_ISREG(inode->i_mode))
>> +	if (d_is_reg(p.dentry))
>>  		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
>>  
>>  	if (fhp->fh_maxsize == NFS4_FHSIZE)
>> -- 
>> 2.51.0
>>
>>
> 
> 


-- 
Chuck Lever

