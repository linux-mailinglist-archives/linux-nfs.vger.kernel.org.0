Return-Path: <linux-nfs+bounces-3230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28728C2371
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445181F256EC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF07178CE7;
	Fri, 10 May 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L46Mt0g+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9FC177990
	for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340462; cv=none; b=THdMCNiMwClyRVUdraYXaCblWKutfxOt+G5PIUDMV9C6ZzbhEsWxT44iPS98ZO3bVr7Im4AxEAsRHOVkbpzqacQNuFTkxUyxWP733plj3YZ+I1nTdkfrj28d6Bm/7qMPryCfTj+Kz3wyuxqEPoo/z5uw/Svd1VeQncttOVM4dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340462; c=relaxed/simple;
	bh=0+OdTvAPqGbeMkeDymU2uI+YdIhrXjJN+i9w4SW30k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtFGsqdYZqUs5QAJQrIlyLfgDrDmlJzY3VmPL+OnxZke2rWF3hT/Xv382Xo7ktrtQjxQKb4UkrCLDBhTLn3mrNHy2rpJROAWpjDdvZDOa4Lzra4Ivbey4t1NB6Yf6ahj68RB6YxsjGkcSgFsugL3K40uDuyKM3+f14lnjwo6+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L46Mt0g+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715340460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTYu0Mxy7AmY/5UhYgHcXMBL9iO7jLRkQEyOoifsz1A=;
	b=L46Mt0g+o4qLoiRzK7GyXCRmK2iU/Lk9Pk8koaSB9ziRdir06lvy612gxrKFhj0rf1icCa
	ZTsQT5cEGOODXnKXJH+kgehvT80aaybaRGw+XYovUhoPVRnx+Ou8BTno2LYBZ2Tm28Gvd0
	Cc3zKKXlaGbDlUaSsJm82TY7aYllu4Y=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-DfqKGGAAOUei6zVQaRFVGg-1; Fri, 10 May 2024 07:27:38 -0400
X-MC-Unique: DfqKGGAAOUei6zVQaRFVGg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5b23e93f5d0so539879eaf.2
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 04:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340458; x=1715945258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTYu0Mxy7AmY/5UhYgHcXMBL9iO7jLRkQEyOoifsz1A=;
        b=PKUwIyuL9G/5ooYEX4tbpxEr3YlOFeSyFgAc/g0g5p8AwT+uYsx/7eT6X+rkqlBY60
         Io4nJgLHix5kvSnf/hJZwgK91ZT0zAN3N5Ge5/0dDUl4XAVLXWOlsz/JK+j25VabFCwN
         n0Gj9vK4Xu/A5I/OyaMnMzjFXWlVL4j41lwFPHvN3sKUoKUO2pvpNXlI+gBRp7pMocCc
         FXAuVfRRHGmwnacurqnE9l1xh88Mug+Kk4kZzDU/KW1N9KdFm2J335TAHuxMgrNasG9b
         3sA0qWbgp3J7ovQBqmOgMHg7Srs73wg5l0NT68ltwSgxu7YY2eBM1JbfCRhg8fkp+TQx
         kwRA==
X-Gm-Message-State: AOJu0Yw+jEqk0tSZOKNxepe+XHNGll+2aVlTAIMSKjhnA6TeIZU1xSVs
	OtN7S/w6Ib1kzF5ZHqaSSBgzV4iu30SV5Rx/FiMtZH99TpxOzGuXl1v59B5/8XAxKDFmw09b4Ka
	KjpZG7I6cmcNCAazqvMHs7qLBMIq+KMnE/Lt6RIx6EOWr14ohCiPUYUTLsQ==
X-Received: by 2002:a4a:d10e:0:b0:5af:be60:ccdc with SMTP id 006d021491bc7-5b2815e1c94mr2310801eaf.0.1715340458039;
        Fri, 10 May 2024 04:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPlmCVlS9AqPtFs1m2lYKYeWApo3IWaL9Vi8kTHXA1JnBqtgPvjlKOfAJl/a7evduww4LLCA==
X-Received: by 2002:a4a:d10e:0:b0:5af:be60:ccdc with SMTP id 006d021491bc7-5b2815e1c94mr2310792eaf.0.1715340457621;
        Fri, 10 May 2024 04:27:37 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.245.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df553c92fsm20219191cf.55.2024.05.10.04.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 04:27:37 -0700 (PDT)
Message-ID: <985974b1-2ed2-4f26-be0f-b0abfbaaea99@redhat.com>
Date: Fri, 10 May 2024 07:27:35 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: allow more than 64 backlogged connections
To: Jeff Layton <jlayton@poochiereds.net>, trondmy@gmail.com
Cc: linux-nfs@vger.kernel.org
References: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
 <17b06a56223ab70ccf79a0e6b79eef54eddc6c2e.camel@poochiereds.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <17b06a56223ab70ccf79a0e6b79eef54eddc6c2e.camel@poochiereds.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/9/24 9:31 AM, Jeff Layton wrote:
> On Fri, 2024-03-08 at 13:02 -0500, trondmy@gmail.com wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> When creating a listener socket to be handed to
>> /proc/fs/nfsd/portlist,
>> we currently limit the number of backlogged connections to 64. Since
>> that value was chosen in 2006, the scale at which data centres
>> operate
>> has changed significantly. Given a modern server with many thousands
>> of
>> clients, a limit of 64 connections can create bottlenecks,
>> particularly
>> at at boot time.
>> Let's use the POSIX-sanctioned maximum value of SOMAXCONN.
>>
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>> v2: Use SOMAXCONN instead of a value of -1.
>>
>>   utils/nfsd/nfssvc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
>> index 46452d972407..9650cecee986 100644
>> --- a/utils/nfsd/nfssvc.c
>> +++ b/utils/nfsd/nfssvc.c
>> @@ -205,7 +205,8 @@ nfssvc_setfds(const struct addrinfo *hints, const
>> char *node, const char *port)
>>   			rc = errno;
>>   			goto error;
>>   		}
>> -		if (addr->ai_protocol == IPPROTO_TCP &&
>> listen(sockfd, 64)) {
>> +		if (addr->ai_protocol == IPPROTO_TCP &&
>> +		    listen(sockfd, SOMAXCONN)) {
>>   			xlog(L_ERROR, "unable to create listening
>> socket: "
>>   				"errno %d (%m)", errno);
>>   			rc = errno;
> 
> Steve,
> 
> Is there some reason you've not committed this patch? It seems fairly
> straightforward. I think I sent this earlier, but:
> 
> Reviewed-by: Jeffrey Layton <jlayton@kernel.org>
> 
Thanks for the poke... The patch was not on my todo list.

I'm on it...

steved.


