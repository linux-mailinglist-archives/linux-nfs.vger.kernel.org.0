Return-Path: <linux-nfs+bounces-3177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC20D8BD531
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 21:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881FF2830C9
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEECC4AECA;
	Mon,  6 May 2024 19:10:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402F158DC4
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022618; cv=none; b=ZdCMtGQ2HFVwJFhuUi4teQCx4u3e70EM8GETFnxbKwHBfudcMRzkdvYLouGPK4wgRSv30zom9/vRwHJFwL6Td24ghrhrUcJqUjgLgbK0uccCEYi1nTF3OUlUgRsH+E4ZC6POzIIqjF5vsWr4CUbvQ+YtKtL5BZf7rwXKXzI4ciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022618; c=relaxed/simple;
	bh=Gtb9tpN0LIANMRHNsl+r+75Q7C1XbWalX/mvlibW31Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7eZas1vf9jDqUFeqQnA0/dRkiRR2qzCzJMQrS43Agmqfq1qbFFMEVDWbAi6LC/smEAYBX5JQ69o1mb4jAT8vk/0OvVQXlDkHJIAU6UCK4w+QnhkcCTnfxoMZH3pqpj9balW1+e9o1brHau/SnWMHdTQkcDYTfrXuspxjbRcilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34cba0d9a3eso178785f8f.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 May 2024 12:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715022615; x=1715627415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKhhqmcB6kKZRFj8xgGS8Qgus/pZJx55xM0HlwwgoBs=;
        b=Z03JiI0xCXl9jxVy4SxZgzgKcHgxR6Wx0w5ZbyRU/gtTPxvg0/XY2lvJoNHeFfrUW7
         61+n9YZinAOaVu5y3OAEpwyxTIXN/TY7Ty55hRkIF0lab7D90j+BTiPM8r5JMY9WAmIz
         5HstastVWEKU03nbz9Zy3dYWhaZcbwsEKQZtHGxbli6DMkhlPKtW8XZuaHFoKz1ARnco
         sxQoGACbjUNHku/ksizUdzKnzH+TY9gwUred2HuafC8WIrP1ZVyUwwwRatsdwxWRw+FB
         8Oxa0sWPnfKJjs/fy68sL81G0NnfCJlstZKxE635Yh2PhpoLtVDoexsLy3HoOKoZZycS
         wqVw==
X-Forwarded-Encrypted: i=1; AJvYcCVN4HhbCrqDbgn6hOO3Y0KnSRoSbrQdeP/8tvNjeIqD7hQdyxJT4ZxRO3/JebpObIm5UYw7RCNiPbVp41YQtLVAGw8v0y5XrN3h
X-Gm-Message-State: AOJu0YxAPZRpNXxokPK7WnkYMublrXSJoGmhB1nbMKmuxP0IXSsAqUMf
	bA5DON9leMgQl4BdiLljjxPToF+AuDjCqbj18iUemP9pZgMGwOr5QD/klg==
X-Google-Smtp-Source: AGHT+IG8G9pReHR2KdwgS1Gv6Fb3IQsRSyhFfES86eGBiTS06QMw8AoiQobCddUo8O5zCTbuPvsSUA==
X-Received: by 2002:a05:600c:1c0f:b0:419:f241:6336 with SMTP id j15-20020a05600c1c0f00b00419f2416336mr7693282wms.1.1715022614931;
        Mon, 06 May 2024 12:10:14 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b0041b43d2d745sm17028868wmq.7.2024.05.06.12.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 12:10:14 -0700 (PDT)
Message-ID: <bb1f1604-8b3f-4fc4-ac31-1f365c1fe257@grimberg.me>
Date: Mon, 6 May 2024 22:10:12 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dan Aloni <dan.aloni@vastdata.com>, linux-nfs@vger.kernel.org,
 Sagi Grimberg <sagi.grimberg@vastdata.com>
References: <20240506093759.2934591-1-dan.aloni@vastdata.com>
 <be4563e5-caa6-4085-98a9-a86e24c99186@grimberg.me>
 <Zjj9iOOJ0px+Lvin@tissot.1015granger.net>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zjj9iOOJ0px+Lvin@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/05/2024 18:55, Chuck Lever wrote:
> On Mon, May 06, 2024 at 06:09:51PM +0300, Sagi Grimberg wrote:
>> On 06/05/2024 12:37, Dan Aloni wrote:
>>> Under the scenario of IB device bonding, when bringing down one of the
>>> ports, or all ports, we saw xprtrdma entering a non-recoverable state
>>> where it is not even possible to complete the disconnect and shut it
>>> down the mount, requiring a reboot. Following debug, we saw that
>>> transport connect never ended after receiving the
>>> RDMA_CM_EVENT_DEVICE_REMOVAL callback.
>>>
>>> The DEVICE_REMOVAL callback is irrespective of whether the CM_ID is
>>> connected, and ESTABLISHED may not have happened. So need to work with
>>> each of these states accordingly.
>>>
>>> Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')
>> Is this actually the offending commit ?
>>
>> commit bebd031866ca ("xprtrdma: Support unplugging an HCA from under an NFS
>> mount")
>> is the one assuming DEVICE_REMOVAL triggers a disconnect not accounting that
>> the
>> cm_id may not be ESTABLISHED (where we need to wake the connect waiter?
> I'd be OK with discussing possible culprits in the patch description
> but leaving off a Fixes: tag for now.
Agreed.
>
> It would be reasonable to demand that the proposed fix be applied
> to each LTS kernel and tested individually to ensure there are no
> side-effects or pre-requisites.
>
>
>> Question though, in DEVICE_REMOVAL the device is going away as soon as the
>> cm handler callback returns. Shouldn't nfs release all the device resources
>> (related to this
>> cm_id)? afaict it was changed in:
>> e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
> In the case where a DEVICE_REMOVAL event fires and a connection
> hasn't yet been established, my guess is the ep reference count will
> go to zero when rpcrdma_ep_put() is called.

Yes, I was actually referring to the case where the connection was 
established.
It looks like rpcrdma_force_disconnect -> xprt_force_disconnect 
schedules async
work to tear things down no?

>
>
>> The patch itself looks reasonable (although I do think that the rdma stack
>> expects the
>> ulp to have the rdma resources released when the callback returns).
> Thanks for the review! Should we add:
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Yes.

>
>
>> FWIW in nvme we avoided the problem altogether by registering an ib_client
>> that is
>> called on .remove() and its a separate context that doesn't have all the
>> intricacies with
>> rdma_cm...
> I looked at ib_client, years ago, and thought it would be a lot of
> added complexity. With a code sample (NVMe host) maybe I can put
> something together.
>
>

The plus is that there is no need to handle the DEVICE_REMOVAL cm event, 
which is
always nice...

