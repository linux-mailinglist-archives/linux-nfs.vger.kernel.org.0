Return-Path: <linux-nfs+bounces-15055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3937EBC5863
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA14F34AC
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1024287505;
	Wed,  8 Oct 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOjJVkYo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52C286413
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936110; cv=none; b=CRPWgKFKtQowkLW9NtVSLADGMhIFmkEEm0IICvCKauOtbDflI+N7qkVUlwUOzylBu7hEyNo1MtQk3Nac55V2SHB1dKxEo8GOr98NAq4OlT32rmJeI2h+H9TxrtK8RkBWWzjv4yHhXzmzXeamMSCVAkiDKf70LB3w6jwCqoIcB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936110; c=relaxed/simple;
	bh=s9lLv0kuVSkQblGgrhJdX39k+mV9F+1zp+RB7kTSMH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRQZ7V4NpedWj8uAenepEs3g5TT4WJ+roNMlsT6TUtFNsoIA3wmkMdKgZZ6FEzawD4QR3tugMpJhcQXxdCdRjc5l/0fIsokclWhzSEDYPA4afi1gI5MoBbrr+HG9ZizEUKfWzKL5CtKYPu4rGvUg0D1CKIcgpE9kI5wGVoBp4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOjJVkYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCB2C4CEE7;
	Wed,  8 Oct 2025 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759936110;
	bh=s9lLv0kuVSkQblGgrhJdX39k+mV9F+1zp+RB7kTSMH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nOjJVkYoAk7Le6LbA618OxtG6pN45TJUm3JHPec5DFLuRANQf2OOZCjqI4yPZvtLR
	 LZzR0y+ghNj7pjP2DGEV5dz8xKlzEojqImLTbx52fGMZIP//9RsBhV4QhBaL2x6KRF
	 6opG/u5WcgxI80N2oHtlLfHdHBUdXtXJd3qaKSsIEwMp5FrGt6cHaNcpWRGiaLfSSC
	 2fJau8pFjcHFrhF3sylDTx7BlqKd1iJtJrZgkud2XYeBkJcFm3xDEtxYQwuk14hRyp
	 VJB9j8goy2N5/vtV8Vw7Od1gPnFLWym0pCluenqx1I1s6hmydWF/eQgYDDjtTYHcQI
	 0/0D9suzDmBAg==
Message-ID: <4038262f-88e9-4611-bbbd-0dd0e26d4237@kernel.org>
Date: Wed, 8 Oct 2025 11:08:28 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] NFSD: Recover from vfs_getattr() failure in
 nfsd_file_get_dio_attrs()
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251008135230.2629-1-cel@kernel.org>
 <20251008135230.2629-4-cel@kernel.org>
 <c8ad0a617abedab46e2ca369cddaa1823a439d33.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <c8ad0a617abedab46e2ca369cddaa1823a439d33.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 11:03 AM, Jeff Layton wrote:
> On Wed, 2025-10-08 at 09:52 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> A vfs_getattr() failure is rare but not totally impossible. It
>> typically means nfsd_do_file_acquire() raced with the file system
>> being shut down. Ensure the nfsd_file is not leaked in this case.
>>
> 
> nit: I'm not sure we can say what typically causes vfs_getattr() to
> fail. It really depends on the fs.
> 
>> Fixes: d11f6cd1bb4a ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/filecache.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index a238b6725008..482feb0b55ad 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -1198,8 +1198,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>>  			}
>>  			status = nfserrno(ret);
>>  			trace_nfsd_file_open(nf, status);
>> -			if (status == nfs_ok)
>> +			if (status == nfs_ok) {
>>  				status = nfsd_file_get_dio_attrs(fhp, nf);
>> +				if (status != nfs_ok)
>> +					goto construction_err;
>> +			}
>>  		}
>>  	} else
>>  		status = nfserr_jukebox;
> 
> Is there really a leak here? It looks to me that when status != nfs_ok,
> it's going to fall through to construction_err anyway.

I wondered about that. Then there is probably nothing here to fix.


> What this does
> do is cause nfsd_file_unhash() to not be called. Do we want to leave
> the file hashed in this case?


-- 
Chuck Lever

