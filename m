Return-Path: <linux-nfs+bounces-17582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62ACFFB68
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 20:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FD5F3003049
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743FC22A4FE;
	Wed,  7 Jan 2026 19:22:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A21FF61E
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813774; cv=none; b=nl/7J9WGM9FHcp/VbDX0wTyUmHbPz8BsEASuNVFcISogqE1i+SNlI7OwhCAoItfjo+XCDGw9lfWxtu8Urx2o9/Gmjc117nTtJAqstidkWoF2EPoiICMBhkuenFEcUrzaxT1P/YYFDN8vmP1CaeQpyAsPsFDwuCg+mxITULCELY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813774; c=relaxed/simple;
	bh=chyjaCGxnGaM66u9P0XSY3UWXDEyj6bX6hk/INSLftw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dELgNMwYTZEU0jE42PVopOINxF5bFviQSkuPm/bUPb+O2FL6F3vsB/G1Nib1o/lYFi4ceyBWfNxpo4lFrxplGYgfYdfKW2w2MyOrqCD815n9B8/rGVKatJFWUEpuePr3DJ05z8BLIQ+MEGbiHFKw5bY/rhJsgzVHUt4zzlHyU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43260a5a096so1658170f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 Jan 2026 11:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767813771; x=1768418571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuw9nf/VoEkA3ylatJD9fwOpKh17LWcamfj+ezm8eIo=;
        b=h+7blJcfVrGchTak8uDCm3IF0k0e+TVpq/Wu+G5uvXtO67E81MsYI3z9ArTQ2IMVp5
         vHDPflWvu7VPGqeocMSe1rmKdfuc0YDWxY1AKBZXNVLK1D6IU6/dW7Gb6WT0E63t/KTx
         ROlrl3sVCSR6zXUB03jty1xk9PV3HjqwRcEEAgHcNG/OTEgQeB9lkrMStopoRMn0Zd+Z
         9sRj9AN7jY8tAcM4K16af3M4lTwpYZguwpvIRwbNlhw7Rme6giw82YkO/z3WRK3/KcCy
         b/bN5lTfWhI3C1UymKozv9bLiJp1BtEwmOk8M1MbqvkFnZZYYrUAquZDeW4joq59ts2Y
         zBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbO6wGYR8tHC0hv8tqxDNF4LqxE6ygLxm9iE8Sf6u/yPQUv9IbzXl/mtu/9yHDVwWvqmOfWWmrFac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze67cEzlrRmA2wy5aBqf1DygwTfwwXjq57n3Tu16gQWGcSmohk
	1QOYQGPswfarFjOLj48C4+7M0CbASYbeJhE4U8yWMMKa3hYGu9gLPc98
X-Gm-Gg: AY/fxX4mktHn+mU3l1hp3LE4/ua/ccwAFL2LM0bp95AatsOWnErerobhFELfOs/YZ2y
	/8Mly7YIPoDvh1+fxSa+GBKSU9vvCMqnbk+MAKIfXON+RiNiLuYM+cLMiSsuoP9JElNPZw1JCRX
	vo4Nrz+tgk9eXs73GmvGQdnB73MBenCfISRv8W8+eMdl8YksdTt3w2Vy6zMvo0mtr0+m5Wa6zVv
	Veic54htShJf8FkmmXZz9aimCnTnC3Oympw3p6fZrjjHsZidCV/pioxqFXJfQ3s6xJ+ej6yYmGD
	k9dgGgHOSMtky/4C/U3SPmHDu9jRwy+Hyja0CNK6nfSQCy7VnL7NAGDgrhV/aLdZSeKAZrSx/vA
	/3krPQwPWMGb2zyMjbDZgqrMrn85vDjNcZGovpfN1+BE7HTnCKv9YS8bPfo5igInUXRhaB1BGJ1
	bveLrBWbekw3UtlrxeqIZZz/W9LeD+QpXr/HsQRZ2GT83adA+G2B5nVg==
X-Google-Smtp-Source: AGHT+IHUjGt+8cIqcHXo3hGiVbDNwvV2+V/4+bukXPi1UA15XV5mlK85ncp0otrfxvZ05HJ/6mcEIw==
X-Received: by 2002:a5d:5f43:0:b0:430:f3fb:35fa with SMTP id ffacd0b85a97d-432c38d22fbmr4607037f8f.57.1767813770762;
        Wed, 07 Jan 2026 11:22:50 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dade5sm12215907f8f.9.2026.01.07.11.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 11:22:50 -0800 (PST)
Message-ID: <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
Date: Wed, 7 Jan 2026 21:22:49 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add a LRU for delegations
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
References: <20260107072720.1744129-1-hch@lst.de>
 <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
 <20260107162202.GA23066@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260107162202.GA23066@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/01/2026 18:22, Christoph Hellwig wrote:
> On Wed, Jan 07, 2026 at 10:18:04AM -0500, Chuck Lever wrote:
>>> currently the NFS client is rather inefficient at managing delegations
>>> not associated with an open file.  If the number of delegations is above
>>> the watermark, the delegation for a free file is immediately returned,
>>> even if delegations that were unused for much longer would be available.
>>> Also the periodic freeing marks delegations as not referenced for return,
>>> even if the file was open and thus force the return on close.
>>>
>>> This series reworks the code to introduce an LRU and return the least
>>> used delegations instead.
>> I'm curious if you tried other methodologies like LFU to decide which
>> delegation to return?
> Not really.  LFU I guess means least frequently used.  That would
> imply tracking usage frequency, and rotating a list of other lookup
> structure a lot.  The first is something not really provided in the
> delegation code, and the latter tends to be really horrible for in
> terms of cache dirtying.

Hey Chuck, Christoph,

I think that there is merit for tracking file usage frequency and 
accounting it for deleg return
policy, and I don't necessarily think that it would not be worth the 
overhead (compared to sending rpcs to the server)...
but I agree that its a much heavier lift (it can always be done 
incrementally to this patchset).

I do think that there are some potential heuristics that the client can 
use to utilize delegations better. For example, perhaps
read delegations can be held longer than write delegations. The 
benchmark that Christoph
ran shows a 97% reduction in rpc calls for python venv/conda like 
workloads (as well as bash imports etc) which
represent shared files that are likely to be updated very rarely, yet 
accessed frequently by lots of clients.
I think that as a general heuristics, read delegations are much more 
useful when held longer. Maybe even indefinitely?

Another idea for a heuristic could be to take into account the mtime 
when opening the file with a delegation, if the mtime is far in the past,
perhaps it can be an indication of a longer period can the client hold 
on to the delegation with "low risk" of a conflict.

And, in genenral, I think that the server is in a much better position 
to solicit preemptive delegation recalls as opposed
to the client voluntarily return delegations when crossing a somewhat 
arbitrary delegation_watermark.

Thoughts?

