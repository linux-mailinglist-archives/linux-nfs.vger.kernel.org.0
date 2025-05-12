Return-Path: <linux-nfs+bounces-11666-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F0AB42D2
	for <lists+linux-nfs@lfdr.de>; Mon, 12 May 2025 20:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69121188C1A3
	for <lists+linux-nfs@lfdr.de>; Mon, 12 May 2025 18:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B9F2C2FBC;
	Mon, 12 May 2025 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhln8eq4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BF299A84;
	Mon, 12 May 2025 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073349; cv=none; b=kM/IYfs7bfOoGb84Ulw4uW/7YvptiKm401c3Bu0Ukv303cwMg2HA+3LdxD64Ch8GHAfkuQhVkuj1HxOJXSnT9n0oCfvkKRFb8SkZkRHF/x2DjeVDoR5A7YemAftBzsBo7HOUQ5ViANKg/HMyzisX2Gw4zs8/ocqXPZkPey6PRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073349; c=relaxed/simple;
	bh=aIF0vYnSxPcvUct+hsuRa9CLhT+BCPsD0lf/2g/ocYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpa7IverskvGtgNBAjrNE/r5G6XU5UeNxQ5TPSym9OMzudnFJKk6hzN31HzqBC2rLeCxwFoekGbBlPSNu+DfDYosHwAq3CQeQcKh5Upowl14w+vS9t6VvshcKEqvWTXH/1t15tYwBapKAh3S5fqY4le8naDNlK4PfY9/czbTVYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhln8eq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB4C4CEE7;
	Mon, 12 May 2025 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073349;
	bh=aIF0vYnSxPcvUct+hsuRa9CLhT+BCPsD0lf/2g/ocYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qhln8eq4T3zMVYD2AAgbiF4Rs7pP0I9zYgdOOaZ/Mpvg9SZ9rIstfGvfDCNOol3XI
	 SESvXV/xQcLBEeXZOFrKA3843DogRX3jFkNEu2UjAy75kuSrd6wgbP3966v2cz8KiA
	 EAAL8ClSZ2AqQOtXXnRI8nOmAl9QvOPw00QQsX7B0xGAQnw2IziZeiBqG6afIQWycY
	 8zQIj7b2SxZNTX9BOdnCiHQVHQFEIG009gQ946QRdZ793oLD43uevCGCl08aYfF6U+
	 4ScEmDCInOLw7qC38bylmPVteKa10dENVBqaN9//tKGtIeI9wi1Ku3QRIXehdTTbWu
	 VMoximdZrDk/A==
Message-ID: <8179372a-1d5a-42b7-b84d-72a8dcefbdd1@kernel.org>
Date: Mon, 12 May 2025 14:09:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/19] SUNRPC: Bump the maximum payload size for the
 server
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250509190354.5393-1-cel@kernel.org>
 <20250509190354.5393-20-cel@kernel.org>
 <CA+1jF5pLds8XYfsBqVsJOmr4b+YaXPdHzUNWmtx8aQLec6UKZQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CA+1jF5pLds8XYfsBqVsJOmr4b+YaXPdHzUNWmtx8aQLec6UKZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 12:44 PM, Aurélien Couderc wrote:
> Could this patch series - minus the change to the default of 1MB - be
> promoted to Linux 6.6 LongTermSupport, please?

It has to be merged upstream first.

But, new features are generally not backported to stable. At this time,
this feature is intended only for future kernels.


> Aurélien
> 
> On Fri, May 9, 2025 at 9:06 PM <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Increase the maximum server-side RPC payload to 4MB. The default
>> remains at 1MB.
>>
>> An API to adjust the operational maximum was added in 2006 by commit
>> 596bbe53eb3a ("[PATCH] knfsd: Allow max size of NFSd payload to be
>> configured"). To adjust the operational maximum using this API, shut
>> down the NFS server. Then echo a new value into:
>>
>>   /proc/fs/nfsd/max_block_size
>>
>> And restart the NFS server.
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Reviewed-by: NeilBrown <neil@brown.name>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/linux/sunrpc/svc.h | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index d57df042e24a..48666b83fe68 100644
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
>> -#define RPCSVC_MAXPAYLOAD      (1*1024*1024u)
>> -#define RPCSVC_MAXPAYLOAD_TCP  RPCSVC_MAXPAYLOAD
>> -#define RPCSVC_MAXPAYLOAD_UDP  (32*1024u)
>> +enum {
>> +       RPCSVC_MAXPAYLOAD       = 4 * 1024 * 1024,
>> +       RPCSVC_MAXPAYLOAD_TCP   = RPCSVC_MAXPAYLOAD,
>> +       RPCSVC_MAXPAYLOAD_UDP   = 32 * 1024,
>> +};
>>
>>  extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>>
>> --
>> 2.49.0
>>
>>
> 
> 


-- 
Chuck Lever

