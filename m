Return-Path: <linux-nfs+bounces-11350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498EBAA10CA
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4E33B8C9D
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302A221F1A;
	Tue, 29 Apr 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx+3z4Qp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C88216E1B;
	Tue, 29 Apr 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941499; cv=none; b=dZ3IIhpV1eKHZtPuvQrlpFsZFE1C4aADVH9BTsu/8ciq+4DzAicgWgOQrG1Y9WEQqdIut5M6P56i+MqFnuZk8YRAFaLglExG4wEWsIhcnmc+tJIqHoHKsTnilgQeWN0YwvT0ANBEMpgzR0yPCcSUyDKcBMY+6ei4vJPwjnKB3uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941499; c=relaxed/simple;
	bh=8whp8rjZ7CmtFqXoCgJG9FBwkVQjQKD4vdlgxvXWbpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfDDmb6ng2+zW6IZtQ/Rk0793e4mYqiw3mdAxKAEKYsKZ2uW3bZFI1//31HGlWx0rWS8l9NI3kEt4yDvpoGDmgVxDVO5GR5vuBVmo1RyL60tgEmM5saV4vh2Id7q52jhUlJ8aexrUl4TQNOQWYwIcphafLidqLQF9oE0GhWv3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx+3z4Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4125CC4CEE3;
	Tue, 29 Apr 2025 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941499;
	bh=8whp8rjZ7CmtFqXoCgJG9FBwkVQjQKD4vdlgxvXWbpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hx+3z4QpetAlUFrikI5vx8i9HIjVP+n1pC92cvxiUvU57T60ZiqIRx3ggZyLTjAPK
	 /aAjwfkg4pr6pybQeVCJ+RE4LNHpXvsZ3Zlgis+SxRa7xD0mjLHAQZwRGtkX8Jomsl
	 45DpDNKbTmXK1C8xcAsW+yyRgSWx80QmjAe2AghIjs5wdpiQXykP5EByb+b/4pf69J
	 jhOggjgGkr8/fZD6TrvUHiSMZtaTjMyEAi82GqIILWensBrxuqafxXEiGrdLWPYInu
	 ERZylUdjhSixJkQ+drhnHzZxP03MUhJeLb0iq7LF9qRarIwIj++PV54eSV6zqGztiw
	 BzYnuRSGLeGNQ==
Message-ID: <dfc67da6-60a9-4636-a74a-eabad44eacde@kernel.org>
Date: Tue, 29 Apr 2025 11:44:57 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] SUNRPC: Bump the maximum payload size for the
 server
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-15-cel@kernel.org>
 <420d4c4285d7d2cf3528839408e19501abfbf82b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <420d4c4285d7d2cf3528839408e19501abfbf82b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 5:08 PM, Jeff Layton wrote:
> On Mon, 2025-04-28 at 15:37 -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Increase the maximum server-side RPC payload to 4MB. The default
>> remains at 1MB.
>>
>> To adjust the operational maximum, shut down the NFS server. Then
>> echo a new value into:
>>
>>   /proc/fs/nfsd/max_block_size
>>
>> And restart the NFS server.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/linux/sunrpc/svc.h | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index e27bc051ec67..b449eb02e00a 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -119,14 +119,14 @@ void svc_destroy(struct svc_serv **svcp);
>>   * Linux limit; someone who cares more about NFS/UDP performance
>>   * can test a larger number.
>>   *
>> - * For TCP transports we have more freedom.  A size of 1MB is
>> - * chosen to match the client limit.  Other OSes are known to
>> - * have larger limits, but those numbers are probably beyond
>> - * the point of diminishing returns.
>> + * For non-UDP transports we have more freedom.  A size of 4MB is
>> + * chosen to accommodate clients that support larger I/O sizes.
>>   */
>> -#define RPCSVC_MAXPAYLOAD	(1*1024*1024u)
>> -#define RPCSVC_MAXPAYLOAD_TCP	RPCSVC_MAXPAYLOAD
>> -#define RPCSVC_MAXPAYLOAD_UDP	(32*1024u)
>> +enum {
>> +	RPCSVC_MAXPAYLOAD	= 4 * 1024 * 1024,
>> +	RPCSVC_MAXPAYLOAD_TCP	= RPCSVC_MAXPAYLOAD,
>> +	RPCSVC_MAXPAYLOAD_UDP	= 32 * 1024,
>> +};
> 
> I guess the enum is so that the symbol names remain in debuginfo?

My impression is these days enum is preferred over #define for
this kind of symbolic constant. This part of the change is merely
clean up.


>>  extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>>  
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks for the review!

-- 
Chuck Lever

