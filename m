Return-Path: <linux-nfs+bounces-5244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A363948C95
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2024 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F64288EBA
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2024 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09FA1BDA86;
	Tue,  6 Aug 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV1QbQtP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70A16D4DD;
	Tue,  6 Aug 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938875; cv=none; b=PAfNOI0MKN4Ap1VyvB4e35+uD1toBF4rAcBnrVlFT2HR8a9jZGVGtcoK4zMB73SgeLUEjvM5OJoyrYDdQd5xG109IEO6eSMaMYSJDm4FJMgkJqW5u03fsXFflf69yR562vRe+rEdoehGDtFcErMtTtTWkvuMGYnpiXUFUiZ5ABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938875; c=relaxed/simple;
	bh=sK85kbgAw7sPjYjWrTnMznbksYwDJ/Bd2yLkQD1OxZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmmThDWNGbM47WMSeun5d7RUzPeDzFZGafwHdb5gB4oFjWGUoI8XPpns/WnLAgaqzhNT9LNCMuQJxWY3t21se4r8WJrvVWFLr3TMEMWgPsHuLVQ1RNG1tPFkyQ1kIfbX+FyGOjaGuZCRNE2n6XTrIRzD2gSmEuQ2x808PCPBLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV1QbQtP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4281faefea9so2446635e9.2;
        Tue, 06 Aug 2024 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722938872; x=1723543672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYxPLaU7mwAXhPDbFU2y+09upc308Rf0b6DCO8oa4sw=;
        b=JV1QbQtP8gUgArjfke8azzOmmtu7Uu417RvUWtcQjdSDI1sYuv+Ya9ZrR98RmNf0wa
         XkkachichlcJViT0k/fVTK7YKk1LTcfxWa5+H0tPE/RC0hT+/CmCJQthqWwbvzAQUSms
         RXGRBGwX010Rw6a+vvW+SCGRAPdM2CXkQHYOkJD2EyV4ptKVocnDIHf+z5X8oL9TLJ5m
         MZutDWl3Fon2nY+Vlr3igFNDsuXBUfGeg1as/p2d6ZJAIQM40wFFpE/ajN9UuBy+J1c7
         V1a3G8DXtm8mE0ELbN2aCcTbAB0djELiOZKWKfVvMnk135YGDt9WjJay9MFjvEfGJI9w
         2QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722938872; x=1723543672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYxPLaU7mwAXhPDbFU2y+09upc308Rf0b6DCO8oa4sw=;
        b=V6zE03NgcFG76ePJLetIFtB4KWEIRkVlp7X0KKlEZHF/zOjD0UrrQZS+dRMoRfmsK1
         HKa+1xZIO50dZwtAHqF3AUePOZQL0WQ0s0LXNTJynwDHCaiICLqJYPP5suuQX9rGz3Up
         zIpi6MNRvSDzjEpRyuBk8VlqpZxUyhifymZE7Iq+NqFQtV4UkUOHGJrbAA3NikZZfsKc
         3z06xjPf+PysBpTuvyQRuwFgDTVj5xOM/3b3JNKUxvv7ipEoutZ4brfky+y/JYzeHIX0
         svzU4QPJ1Q73HkEurZbBUrxn0zkWWZw9562muW44r9pMn/rWhv1eSSxaf19sBt90HlLV
         yTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyp4WYNzQ9F9J/FFtCMO/m34rJjbrwolPO8r7xdaYxJu9qbMCwNraoz1UGZwXrGJ5LdRbR5dlNyzjtUVkJ+qxqKciZnYMpM7TitriVRilOy1ZJS+rxJZtflGxLPqFEZAsb6ylDU6sonwJgJKIzF9xPtCXH9uKXQ2omaRo+BF6S
X-Gm-Message-State: AOJu0YwVjvMoOTQeBbsx2M9k0/N1lfW8taG7Itnq66llIM6Ji6hxF1yy
	f6JuX8uPJ21QXXAomFiqTNk9YSbyVrMgyaTjiX4K8pZ1PhdxmB0L
X-Google-Smtp-Source: AGHT+IEUKgrp0oJniovGgcG0GF2mwV9MDFzAcUkYjvaWS9qG9Z9Oic74U14QQxrtC85SiRav34vj7A==
X-Received: by 2002:a05:600c:45cb:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-428e6a5f519mr113684085e9.0.1722938871730;
        Tue, 06 Aug 2024 03:07:51 -0700 (PDT)
Received: from [172.27.33.138] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baba5f2sm235224595e9.26.2024.08.06.03.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 03:07:51 -0700 (PDT)
Message-ID: <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com>
Date: Tue, 6 Aug 2024 13:07:47 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>,
 Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
 <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
 <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com>
 <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/08/2024 11:09, Sagi Grimberg wrote:
> 
> 
> 
> On 06/08/2024 7:43, Tariq Toukan wrote:
>>
>>
>> On 05/08/2024 14:43, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 05/08/2024 13:40, Tariq Toukan wrote:
>>>> Hi,
>>>>
>>>> A recent patch [1] to 'fs' broke the TX TLS device-offloaded flow 
>>>> starting from v6.11-rc1.
>>>>
>>>> The kernel crashes. Different runs result in different kernel traces.
>>>> See below [2].
>>>> All of them disappear once patch [1] is reverted.
>>>>
>>>> The issues appears only with "sendfile on and zerocopy on".
>>>> We couldn't repro with "sendfile off", or with "sendfile on and 
>>>> zerocopy off".
>>>>
>>>> The repro test is as simple as a repeated client/server 
>>>> communication (wrk/nginx), with sendfile on and zc on, and with 
>>>> "tls-hw-tx-offload: on".
>>>>
>>>> $ for i in `seq 10`; do wrk -b::2:2:2:3 -t10 -c100 -d15 --timeout 5s 
>>>> https://[::2:2:2:2]:20448/16000b.img; done
>>>>
>>>> We can provide more details if needed, to help with the analysis and 
>>>> debug.
>>>
>>> Does tls sw (i.e. no offload) also break?
>>>
>>
>> No it doesn't.
>> Only the "sendfile with ZC" flow of the TX device-offloaded TLS.
> 

Adding Maxim Mikityanskiy, he might have some insights.

> Not familiar with the TLS offload code, are there any assumptions on 
> PAGE_SIZE contig buffers? Or assumptions on individual
> page references/lifetime?
> 
> The sporadic panics you reported look like a result of memory corruption 
> or use-after-free conditions.

