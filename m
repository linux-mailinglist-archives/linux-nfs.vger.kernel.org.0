Return-Path: <linux-nfs+bounces-5405-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF4953F21
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 03:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6CC1C21C53
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8941D69E;
	Fri, 16 Aug 2024 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h8qKUBzp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7829CEF
	for <linux-nfs@vger.kernel.org>; Fri, 16 Aug 2024 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773189; cv=none; b=hTNTwbG0LZcf4X9IrmbGzcOWluqjqxZFbqL+kS7Rv2t+DlB31PDb+aeRCMvpV3kYhVP58xCzWB79U61pjPEKu+nFnRtCPMo48FeQN/Fk7RjwzTR2BoPMLmDHEwySGW9binvN2xuY+famFTzFgJL0DG4h0BkdLadL7fLb7/V9lPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773189; c=relaxed/simple;
	bh=tNvSG2qi/Vms8GKiFMc5zZLxko1a99mjyAniXm2u8kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fntQ/YLDRb8MMI/sMNC9HVSH0sj68cFbyAiJrWmgdSez0LffQp0s26AF21YMM8u9FE+NiQ68EpX4JeUmIgKAjexLSaZE3XnGSdW4cfm/z/raHRcVPnLB4cgBISMEtITVw5wR4R02oRidqtc+OPkoHfSthZ8/27G2qkEGH2KU0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h8qKUBzp; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <59d78829-6744-420c-bb8e-f015ca76ecae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723773183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivala+vb4qzVTVVyFC1nWTgHgxHExBS2dPPK5Wr9eR8=;
	b=h8qKUBzp2R5/INg4/Be9oikxzV1SnHdFz5FdzWUFhpcp/MZxWpRpsiPiWiVhxyCkoJZFSZ
	mhC4+pTTXp5Vv6mnpS0GySKUHLQUXhfhC7yqHr7CgriMSH6yqJdJSryXi2Y5DtGooL5FMj
	qVuwkuy9cnTODv9DCmCqrNc+HpAGg4o=
Date: Fri, 16 Aug 2024 09:52:56 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] SUNRPC: Fix -Wformat-truncation warning
To: NeilBrown <neilb@suse.de>
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
References: <> <0282be6f-e8ac-4428-a2ac-1ea6b7c25f4a@linux.dev>
 <172372194692.6062.4519803974558688969@noble.neil.brown.name>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <172372194692.6062.4519803974558688969@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for your reply.

On 2024/8/15 19:39, NeilBrown wrote:
> On Thu, 15 Aug 2024, Kunwu Chan wrote:
>> Thanks for your reply.
>>
>> On 2024/8/14 18:28, NeilBrown wrote:
>>> On Wed, 14 Aug 2024, kunwu.chan@linux.dev wrote:
>>>> From: Kunwu Chan <chentao@kylinos.cn>
>>>>
>>>> Increase size of the servername array to avoid truncated output warning.
>>>>
>>>> net/sunrpc/clnt.c:582:75: error：‘%s’ directive output may be truncated
>>>> writing up to 107 bytes into a region of size 48
>>>> [-Werror=format-truncation=]
>>>>     582 |                   snprintf(servername, sizeof(servername), "%s",
>>>>         |                                                             ^~
>>>>
>>>> net/sunrpc/clnt.c:582:33: note:‘snprintf’ output
>>>> between 1 and 108 bytes into a destination of size 48
>>>>     582 |                     snprintf(servername, sizeof(servername), "%s",
>>>>         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>     583 |                                          sun->sun_path);
>>>>
>>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>>> ---
>>>>    net/sunrpc/clnt.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>> index 09f29a95f2bc..874085f3ed50 100644
>>>> --- a/net/sunrpc/clnt.c
>>>> +++ b/net/sunrpc/clnt.c
>>>> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
>>>>    		.connect_timeout = args->connect_timeout,
>>>>    		.reconnect_timeout = args->reconnect_timeout,
>>>>    	};
>>>> -	char servername[48];
>>>> +	char servername[108];
>>> If we choose this approach to removing the warning, then we should use
>>> UNIX_PATH_MAX rather than 108.
>> My negligence.
>>> However the longest server name copied in here will in practice be
>>>      /var/run/rpcbind.sock
>>>
>>> so the extra 60 bytes on the stack is wasted ...  maybe that doesn't
>>> matter.
>> I'm thinking  about use a dynamic space alloc method like kasprintf to
>> avoid space waste.
>>> The string is only used by xprt_create_transport() which requires it to
>>> be less than RPC_MAXNETNAMELEN - which is 256.
>>> So maybe that would be a better value to use for the array size ....  if
>>> we assume that stack space isn't a problem.
>> Thank you for the detailed explanation. I read the
>> xprt_create_transport,  the RPC_MAXNETNAMELEN
>>
>> is only use to xprt_create_transport .
>>
>>> What ever number we use, I'd rather it was a defined constant, and not
>>> an apparently arbitrary number.
>> Whether we could check the sun->sun_path length before using snprintf?
>> The array size should smaller
>>
>> than  the minimum of sun->sun_path and RPC_MAXNETNAMELEN.
>>
>> Or use the dynamic space allocate method to save space.
> I think that dynamically allocating space is not a good idea.  It means
> you have to handle failure which is just a waste of code.
>
> I'd suggest simply changing the array to RPC_MAXNETNAMELEN.
I'll follow your suggestion and change it in v2.
>
> NeilBrown
>
>
>
>>> Thanks,
>>> NeilBrown
>>>
>>>
>>>>    	struct rpc_clnt *clnt;
>>>>    	int i;
>>>>    
>>>> -- 
>>>> 2.40.1
>>>>
>>>>
>> -- 
>> Thanks,
>>     Kunwu.Chan
>>
>>
-- 
Thanks,
   Kunwu.Chan


