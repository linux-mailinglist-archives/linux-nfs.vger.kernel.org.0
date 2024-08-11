Return-Path: <linux-nfs+bounces-5303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009DF94E2AE
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 20:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F631F21268
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29D149C6D;
	Sun, 11 Aug 2024 18:33:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CB10979;
	Sun, 11 Aug 2024 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723401204; cv=none; b=Eg/C8gjHQIIDp8VHy5CZVVIoxw1Nu7F8kxoQS3f4Sv15igLx64RSvdpmaBF9wpoC9i+0tnemPjErMGy0vYfeUV/lszjqJqhuGKo3gj7QIoTB6zv681LbUnkX5DfWqy6PW+INJ6YRVfFgrgCi4Fcm3V1/fz3H10E2+ZBpUq308HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723401204; c=relaxed/simple;
	bh=FzgK3duK3L43dOKLwhC92aHwZTobswcT9RtcNbyPS4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QE5Ql5wYLDf9ohFQgRP9qczJMGsXbGO/IUEzTZAWScp0GwUzxPkRlFKlDKS0rg3CELeH2OKOG8hZIgybJw9E7vz95yWUOwSsxjJSj2Tb7H3c01PHu2mttoEEdXRUgoQDvdQkbAFCZte4jX8FkQrvJD9RiAEARznPN05uqfL6cDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281e715904so4674765e9.0;
        Sun, 11 Aug 2024 11:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723401201; x=1724006001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKHI+xdnlGN0j5kXphEMa/ln6onBMQQZ2ulnnXQyTGc=;
        b=m5hJBonPYCBl8mfmedUTK1IAMhwFc/bsDqArp6cixQeC6XYbxUEgdHnN5mUXZK/4Qc
         lLlooCahiuj37R3T0xVuGjTAcvgYSMWk2zvSHcIHDFUaN9dQdrQHfgt/vBDBWuysaEWP
         A0XPJts3WkrTaEXiklHbts/W7RFSsSmX1FIQVubDcdQpjEBCvw1lsnhwcMVnbboIXGDT
         rVy1K2InUDdhTx3HCZdgXgv6wOqdUbkyxHLfYlpN1Yy74BFeKHnCvBmoJKSfRi3iR9qs
         KCa3xERetb1oT5K34Zik+/B2AJjlyLVhPfucQ0H5ayUfn+a+ikkH0hX1y7aNu8Vo4163
         WNeA==
X-Forwarded-Encrypted: i=1; AJvYcCWWGAXpIrvXV+Qd7KyJA5HdZDwq9WJqiUbr8CieJdkFWXgR2PRptC2gamaYuqlKtNMORXUj3vowHlX/FeQ8Q47aVx4PlScyYuxUkti0K4LTZ4oZzj2amh08XPCNL2LeXmyS1CrlZEFX1JwT/UU2Vq2vBrHVpW+n9TNRv9D2V8in
X-Gm-Message-State: AOJu0Yz1anl7KLkrgc1iCmtIgGfL9rhZ7srhDuCZIK2BKBnlH1v2CVPQ
	Y7ScvSn2djSh28Aqz1/UxUxxlE+lwajGUoWVli3fAr9rT4SCM2pu
X-Google-Smtp-Source: AGHT+IEZRBUqIqST0bJ7neA5K6D61aBV6XJpWfKGa/lGOhAvUUfJ74XbrVYL20+uSQpqK1lGgj//Bg==
X-Received: by 2002:a05:6000:1868:b0:366:e4b4:c055 with SMTP id ffacd0b85a97d-36d6035504dmr3389835f8f.7.1723401200667;
        Sun, 11 Aug 2024 11:33:20 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.173.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3100sm5356118f8f.95.2024.08.11.11.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 11:33:20 -0700 (PDT)
Message-ID: <a11a0502-4174-48d3-a8ad-8584fd304fe1@grimberg.me>
Date: Sun, 11 Aug 2024 21:33:17 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
To: Tariq Toukan <ttoukan.linux@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>,
 Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxim Mikityanskiy <maxtram95@gmail.com>, David Howells
 <dhowells@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Mina Almasry <almasrymina@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
 <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
 <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com>
 <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me>
 <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com>
 <65a77bbb-b7dc-40d8-b09f-c0cf0cb01271@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <65a77bbb-b7dc-40d8-b09f-c0cf0cb01271@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 11/08/2024 14:21, Tariq Toukan wrote:
>
>
> On 06/08/2024 13:07, Tariq Toukan wrote:
>>
>>
>> On 06/08/2024 11:09, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 06/08/2024 7:43, Tariq Toukan wrote:
>>>>
>>>>
>>>> On 05/08/2024 14:43, Sagi Grimberg wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 05/08/2024 13:40, Tariq Toukan wrote:
>>>>>> Hi,
>>>>>>
>>>>>> A recent patch [1] to 'fs' broke the TX TLS device-offloaded flow 
>>>>>> starting from v6.11-rc1.
>>>>>>
>>>>>> The kernel crashes. Different runs result in different kernel 
>>>>>> traces.
>>>>>> See below [2].
>>>>>> All of them disappear once patch [1] is reverted.
>>>>>>
>>>>>> The issues appears only with "sendfile on and zerocopy on".
>>>>>> We couldn't repro with "sendfile off", or with "sendfile on and 
>>>>>> zerocopy off".
>>>>>>
>>>>>> The repro test is as simple as a repeated client/server 
>>>>>> communication (wrk/nginx), with sendfile on and zc on, and with 
>>>>>> "tls-hw-tx-offload: on".
>>>>>>
>>>>>> $ for i in `seq 10`; do wrk -b::2:2:2:3 -t10 -c100 -d15 --timeout 
>>>>>> 5s https://[::2:2:2:2]:20448/16000b.img; done
>>>>>>
>>>>>> We can provide more details if needed, to help with the analysis 
>>>>>> and debug.
>>>>>
>>>>> Does tls sw (i.e. no offload) also break?
>>>>>
>>>>
>>>> No it doesn't.
>>>> Only the "sendfile with ZC" flow of the TX device-offloaded TLS.
>>>
>>
>> Adding Maxim Mikityanskiy, he might have some insights.
>>
>>> Not familiar with the TLS offload code, are there any assumptions on 
>>> PAGE_SIZE contig buffers? Or assumptions on individual
>>> page references/lifetime?
>>>
>>> The sporadic panics you reported look like a result of memory 
>>> corruption or use-after-free conditions.
>
> You can find the original patch that implements it here:
> c1318b39c7d3 tls: Add opt-in zerocopy mode of sendfile()
>
> In this flow (sendfile + ZC), page is shared for kernel and userspace, 
> and the extra copy is skipped.
>
> There were a few code changes in this area since the feature was 
> introduced.
> Adding relevant ppl, including David Howells <dhowells@redhat.com>, 
> who removed the sendpage() routine and added MSG_SPLICE_PAGES support 
> to tls_device.

Tariq,

Can you explain where in your test is NFS used? Is the nginx server runs 
on an NFS mount?

