Return-Path: <linux-nfs+bounces-4074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5D90F095
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 16:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133C71F20FA1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3051EA84;
	Wed, 19 Jun 2024 14:31:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6A1DFCF
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807493; cv=none; b=ZqEC8cz1oWFpjG4TwBCVwy+Mx9dh2ZFvNqeizGVDLD66KYfl0MxByQWnJA27jozLpLw4ID1qjJOsBNCNZkhDJg6Ya3Hxwnm2bmWLOtIWwlpSuwE44+LApbuu1DoRHaythFoTGmrqXpSvzKqbG6Iy8b+6d7YqS+AxNKO7pBYdZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807493; c=relaxed/simple;
	bh=RZU5lORkNnORZpnCjfXUNotmWV9UatnF+GElG+A6Zbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZokjpbZ38MZGJwirTVLFluChaSTX3Lwz6e1kIPKDEhARx0jwKojN+uq3tC1ggSzGGGND/AaKwYs/OjzJnDmozvFCzNSmwcR0OaeNEy9hhSNRHyAYjGIEsub1AjEUe62swqB+PWkOgqP3aM3nCahrL600siDqh5OfKmpZswbEGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so6680195e9.1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 07:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807490; x=1719412290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/C0tGijynZTo3jaeD+eCQud0y8VVGQWBhwzk2KRK+U=;
        b=XrmVqNWuwSJdRYy6GyVw8Jii1F93sCnkUict2qY46MVKnC4LnHlgwXIYFDyGyahKMo
         0tk8iorTNBci3olFIXGnK3VH6T2XXhwZ9e6hbTSY/2pjqOH1jxaqm7h97L5bV3u92NjD
         2US8ZE/B0UfTU7acGLpC4XO9BLdBAGcO3u5FfM/5b6oLoLoP96EdoxLgAKmcEznhZ8F9
         P/IOvBIruqN3RWR0k+HXNNcoHb6mEfYRe3a21J4fQq08V74zlpse3rNLlDq8GM8KQ3Jw
         MKRAoLsy3sKx5sLA5sUAcP4yP8k1WrELtWs9beG4Gzn+s+VCJV6DXsHKeyEo/jDPz0zc
         B2Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWDAWGyQ+1UidthWca6Hg26iXyEw2VE3HoqJaUl+lMS3FuSMlxaah4Q8Gk1Q+y2rFvtpNcQplObw9R7/LazxG3mnqiakuxUSjEI
X-Gm-Message-State: AOJu0YxAKUZnGPvRgM5UZOcQCeNDCX+WF46dbnoyWT68l66G3hsAFlTS
	EXRTV/Jb3ScYiHg/0zR1/GDEbZEdIz0PwZi0xuk4q27cU0CCmsqQNZeejMrN
X-Google-Smtp-Source: AGHT+IEDHCiBSIu4GrQ2XzQiReM86yG+gK8jxbHXgF17mF9sk4ZKKIMQe2OKgBEPuA21nEPSxqgubA==
X-Received: by 2002:a5d:5f4e:0:b0:35f:2a75:91fd with SMTP id ffacd0b85a97d-36319990ef6mr1944690f8f.6.1718807469922;
        Wed, 19 Jun 2024 07:31:09 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de68asm271534975e9.29.2024.06.19.07.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:31:09 -0700 (PDT)
Message-ID: <50f63382-eeb1-4615-a0ac-987afee11902@grimberg.me>
Date: Wed, 19 Jun 2024 17:31:08 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
To: Trond Myklebust <trondmy@hammerspace.com>,
 "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
 <d2f48ca233f85da80f2193cd92e6f97feb587a69.camel@hammerspace.com>
 <ae298053-bdee-4a8a-b6a9-e57de79abc97@grimberg.me>
 <5366ff2a4f731dbd93a56e109d6809a5348cf080.camel@hammerspace.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5366ff2a4f731dbd93a56e109d6809a5348cf080.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/06/2024 17:15, Trond Myklebust wrote:
> On Wed, 2024-06-19 at 11:37 +0300, Sagi Grimberg wrote:
>>
>> On 18/06/2024 21:59, Trond Myklebust wrote:
>>> Hi Dan,
>>>
>>> On Tue, 2024-06-18 at 18:33 +0300, Dan Aloni wrote:
>>>> There are some applications that write to predefined non-
>>>> overlapping
>>>> file offsets from multiple clients and therefore don't need to
>>>> rely
>>>> on
>>>> file locking. However, NFS file system behavior of extending
>>>> writes
>>>> to
>>>> to deal with write fragmentation, causes those clients to corrupt
>>>> each
>>>> other's data.
>>>>
>>>> To help these applications, this change adds the `noextend`
>>>> parameter
>>>> to
>>>> the mount options, and handles this case in
>>>> `nfs_can_extend_write`.
>>>>
>>>> Clients can additionally add the 'noac' option to ensure page
>>>> cache
>>>> flush on read for modified files.
>>> I'm not overly enamoured of the name "noextend". To me that sounds
>>> like
>>> it might have something to do with preventing appends. Can we find
>>> something that is a bit more descriptive?
>> nopbw (No page boundary writes) ?
>>
>>> That said, and given your last comment about reads. Wouldn't it be
>>> better to have the application use O_DIRECT for these workloads?
>>> Turning off attribute caching is both racy and an inefficient way
>>> to
>>> manage page cache consistency. It forces the client to bombard the
>>> server with GETATTR requests in order to check that the page cache
>>> is
>>> in synch, whereas your description of the workload appears to
>>> suggest
>>> that the correct assumption should be that it is not in synch.
>>>
>>> IOW: I'm asking if the better solution might not be to rather
>>> implement
>>> something akin to Solaris' "forcedirectio"?
>> This access pattern represents a common case in HPC where different
>> workers
>> write records to a shared output file which do not necessarily align
>> to
>> a page boundary.
>>
>> This is not everything that the app is doing nor the only file it is
>> accessing, so IMO forcing
>> directio universally is may penalize the application.
> Worse than forcing an attribute revalidation on every read?

For this use-case, yes. Different workloads may or may not be interested 
in reading
this file.

>
> BTW: We've been asked about the same issue from some of our customers,
> and are planning on solving the problem by adding a new per-file
> attribute to the NFSv4.2 protocol.

Interesting, I recently joined the ietf mailing list but have not seen 
discussion
this as of yet. Would be interested to learn more.

>
> The detection of that NOCACHE attribute would cause the client to
> automatically choose O_DIRECT on file open, overriding the default
> buffered I/O model. So this would allow the user or sysadmin to specify
> at file creation time that this file will be used for purposes that are
> incompatible with caching.

user/sysadmin as in not the client? setting this out-of-band?
That does not work where the application and the sysadmin do not know about
each other (i.e. in a cloud environment).

The use-case that is described here cannot be mandated by the server because
the file usage pattern is really driven by the application.

