Return-Path: <linux-nfs+bounces-5300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D494E0F0
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659CA1F21445
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0463D55D;
	Sun, 11 Aug 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKXQr6db"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DD2595;
	Sun, 11 Aug 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723375296; cv=none; b=KZ4cJCGUhUyGBbPVnE9sgBoQdRKeUG3HsEItWdyptPiF33oYTx9obQgAPpsU7OWz/6zjTI4j779MvwICN0+sPRrkED2wywOe7n9mNwMbU4XWiOYIW9MVzuhnKl+0J8SbhqHMFoe5/0wME/RxTSyRwfx0onD0uPG335/dsRg9HD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723375296; c=relaxed/simple;
	bh=Gdr51COVieTY5mrVxCXKgCq+keQ1L5ijtxDnbxt0GyE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ioJf/j9Xk8eBWwS6hasEdOJsNsdJLrtcaHk2n09u37XRWPM04U2THabD8Vk/pAj/ZTXWsNjV6dWtm96vwn/WngOQcBBFiEQsogWy72EU7nKH/05EtGzMyKQPrXk8LXortlHzuL7tfYxoQUY6h86cWwf3rgFq+AFz/FK/pGvZEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKXQr6db; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso2282162f8f.1;
        Sun, 11 Aug 2024 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723375293; x=1723980093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZnLtP4Jlo5z6XBsoC2N73Rmmoe/0J8rH89644qOH5hI=;
        b=MKXQr6dbxB57UtsHICFIqziqczsybhpk5r2M3VyokzoRzJnyh5sXQXvYh8kp1Gljws
         EyXYojSHV3qjO6OzGvdPQZSn93rzYVkJVSzBdJEmb+oWbL3c+2W7yyTpCjEN7AcqT78m
         Hv1VcQ4d5zjQDanOM3tzVsUD4evRXvUQraqGZeOy1mru0ydKfDxU7wnfRcvRRs4UkU8i
         EfpTygRU+PfAwB2bD6E1tvNEqxNukH3er5wVHBz4EWOPYLhkU9QMsed9vRYg8jD2BsRc
         mpujJQY1bk9+b7eyh7oFBuIYRB47X5z3ZKvfdLjY450JzvzhtStchOxK0r5X76avBWGK
         AS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723375293; x=1723980093;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnLtP4Jlo5z6XBsoC2N73Rmmoe/0J8rH89644qOH5hI=;
        b=qSJ3jx6FpUODw+WYXvXMmu9TAcV/zQ8u4P2GfTsUkFAyrAz0tIXSmTiTqee7XEtrBz
         OYSD59voNI6x+Usowy3vqpHiILWetVZz2E/A3LckjiGDipooOy5fCe5Fdff8ZBE74CQM
         Gfy6rU4+LfY6JJjYB7+JXnBzyAEP0A/O6I6AdNgCYpWZfABzsaYdXzWBiV28MUwHouSR
         Q2zUIHUTWyo+gm7UeGEDKYvFL8Oz+pzVJ3feqsTUjUuJ6ZtPoDcBGHKyppdmxOP+EYAm
         DtfMjP3rcHPx9HNNg4gBFPqmrnswIGeSAM4EWOpJVaz+p/XOHm8xsgbIH9kjqinDAUXo
         mlJg==
X-Forwarded-Encrypted: i=1; AJvYcCX5OOpUon9JRdwZsI3OPvfLvG8LfGayxeRuuCnCpwARSODuiv33TmfJjmg/D9XdIqMXFxJQY0X9Ldmvqveqh0Z6aLET2gnNtLil6uHqHj+PkZy/VOlPr7mruAA1COV1OQ+/gJLgPKAE972fgBUDk/mwOG24wHhkhS8FKg5jV8B5
X-Gm-Message-State: AOJu0Yy6qi2076ExqnGgHOI5mIjUT69/MggOwwRHTMsooBjHnyRReu3c
	Ep6bfCfluScrR+ivoXtswYpMQNCHi8ssvYBvmoAhJh2tSuqdzE2z
X-Google-Smtp-Source: AGHT+IGlRFewMR/DsubRDOiLtPN6fIBeQb+cs4kiJBkyXCZVoDCG22xujgNipHgJBkzgCgVBPkHHMw==
X-Received: by 2002:a5d:6d84:0:b0:367:33f0:91c6 with SMTP id ffacd0b85a97d-36d621d98ddmr4287242f8f.62.1723375292219;
        Sun, 11 Aug 2024 04:21:32 -0700 (PDT)
Received: from [172.27.59.236] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36be8csm4662445f8f.4.2024.08.11.04.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 04:21:31 -0700 (PDT)
Message-ID: <65a77bbb-b7dc-40d8-b09f-c0cf0cb01271@gmail.com>
Date: Sun, 11 Aug 2024 14:21:26 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tariq Toukan <ttoukan.linux@gmail.com>
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
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
Content-Language: en-US
In-Reply-To: <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/08/2024 13:07, Tariq Toukan wrote:
> 
> 
> On 06/08/2024 11:09, Sagi Grimberg wrote:
>>
>>
>>
>> On 06/08/2024 7:43, Tariq Toukan wrote:
>>>
>>>
>>> On 05/08/2024 14:43, Sagi Grimberg wrote:
>>>>
>>>>
>>>>
>>>> On 05/08/2024 13:40, Tariq Toukan wrote:
>>>>> Hi,
>>>>>
>>>>> A recent patch [1] to 'fs' broke the TX TLS device-offloaded flow 
>>>>> starting from v6.11-rc1.
>>>>>
>>>>> The kernel crashes. Different runs result in different kernel traces.
>>>>> See below [2].
>>>>> All of them disappear once patch [1] is reverted.
>>>>>
>>>>> The issues appears only with "sendfile on and zerocopy on".
>>>>> We couldn't repro with "sendfile off", or with "sendfile on and 
>>>>> zerocopy off".
>>>>>
>>>>> The repro test is as simple as a repeated client/server 
>>>>> communication (wrk/nginx), with sendfile on and zc on, and with 
>>>>> "tls-hw-tx-offload: on".
>>>>>
>>>>> $ for i in `seq 10`; do wrk -b::2:2:2:3 -t10 -c100 -d15 --timeout 
>>>>> 5s https://[::2:2:2:2]:20448/16000b.img; done
>>>>>
>>>>> We can provide more details if needed, to help with the analysis 
>>>>> and debug.
>>>>
>>>> Does tls sw (i.e. no offload) also break?
>>>>
>>>
>>> No it doesn't.
>>> Only the "sendfile with ZC" flow of the TX device-offloaded TLS.
>>
> 
> Adding Maxim Mikityanskiy, he might have some insights.
> 
>> Not familiar with the TLS offload code, are there any assumptions on 
>> PAGE_SIZE contig buffers? Or assumptions on individual
>> page references/lifetime?
>>
>> The sporadic panics you reported look like a result of memory 
>> corruption or use-after-free conditions.

You can find the original patch that implements it here:
c1318b39c7d3 tls: Add opt-in zerocopy mode of sendfile()

In this flow (sendfile + ZC), page is shared for kernel and userspace, 
and the extra copy is skipped.

There were a few code changes in this area since the feature was introduced.
Adding relevant ppl, including David Howells <dhowells@redhat.com>, who 
removed the sendpage() routine and added MSG_SPLICE_PAGES support to 
tls_device.

Regards,
Tariq

