Return-Path: <linux-nfs+bounces-17734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629FD0E212
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 08:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF42E3004403
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3612D5432;
	Sun, 11 Jan 2026 07:46:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4F285056
	for <linux-nfs@vger.kernel.org>; Sun, 11 Jan 2026 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768117611; cv=none; b=rDHZz/Utwor2N0z28dmgRu/IAhx2pTIF324T94NT0ahQMAX4YL4s2KGXSmwFUsw8LT22jAm2ZzMVMRHhP3xYpSxY8P4hbWhpdp/G2/GM14fFPYKYS+JltjYMUQiFY540m1ArbZQV4OYaSYzX/hEBf5Of1EGT2teiHRRQCjz4tFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768117611; c=relaxed/simple;
	bh=u+N0Cj3T1mjGx7DZPKVURX/1BC8y5ScGbF0Aat8fMIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VllIf7CCAXUJj6ROg7unlJVucv+Wiw2NU3w4ltvGik2oBhnrjxJpbpWsHxdVdFZvCcVX62ex2hfhUX48zw2UCBnvlwfV566CQO6ooQi7Nf4XroqtmvK7fu6U0tjYFN5NXeZGCJUea80QR05YlyDRpstYwrco7P2QKFGXgSAI/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so50139475e9.3
        for <linux-nfs@vger.kernel.org>; Sat, 10 Jan 2026 23:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768117608; x=1768722408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHex1ROU70P4fXX0pMSOXqcnXAZAa5hNamI9rCPnzsU=;
        b=cs9BeuAvSxUp7oBlXDlaZKDa6WNsoC3H1lE6LM+s1BOwDdCCReH+7A+U55BYAtA2WY
         /gGoFmhdXBfj33Ov26hUCkENorGC/2DwArICjsEgj97f+3zVbYv8fV3FDO9eSCuBvR3K
         dirv5yv5sz/CUVeZ1Ris+GywpCQGjBvo0YTtUWDwpK5G7oh9zwUenAhwXYLYn5e+Fghc
         ikN7XZPgS5KOXOBn8nYRmWPmXAbXKRHw2DRulNYPVgJ0v3h8PKOwPO5mJRDrBwmGl9HM
         a4q4ATef9xT7XRLGS/EI3QAlee8sYDEr25G12+qaIYgpANgUjscFU6bOoe6bzzifiYck
         OyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJxovLzVdDqBgP13USGUdPduusFgB7Ga0MPOIFxtfWrkB55JEFY3XyEk8sdDXRU+vhacVF94jmCEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1WerAnTRQI8vEhmXYPzW4mrTzvm/bpi5RY0Q7RsxUpym3Yvt
	bRmh6xGF11tb3Yw1/aJWSkbFFNafGl3POnEDoh2oNRPlgvxHCzaaDM3fduCcHw==
X-Gm-Gg: AY/fxX6EeWpxzVY/23LNi+i/gLysOYTzyrIhIvM6YFD28+5MAu7h3SB/yPDjzHvdZwC
	4XBMcTuJTWtgGAGAlVFt5EvowaxHfKpy2N2FNPPm1P/AsCRuIYX2aVun6qRhG2V9M+qGJDrYn/e
	YGdxVZ2nP9IFNgKetI/3x2Q4zopIkJTdYiZTTd+4AhZkK6n7PeboUwNOdXCwojVWNgKKg32W3EC
	bcasURYBTvS0E1WXnxUEym9cJMH+Sm53sWxirJ3Eikwf48D4/AJFFtdNCTW26zrgg4kef/IU9Yu
	XzhlekBeGCVfMBhEag3nmJHGAA4yJQu8dPTV+86AhzvLTTgCSy4KJGPu0D3VAApdRfmIHMJCBrn
	F7Yqd4E2okqy8gDEAJqzGWgQZhkTlFS/Mjg5YmRrca0O4jjaoUlShAfk5UqOUFy5LoAGvVW+gzQ
	Po2Yij84jodxtZK5hn4ZY7FHRIMtbrM1ffTXtGKX+CLtG+RQOjHA==
X-Google-Smtp-Source: AGHT+IFQy6BIcUW8msfdUdmQtRfNtGM1NPFpHGwie+tcyyLQOcEJyO66v4tQP4DENZn5w8zQeEsIIg==
X-Received: by 2002:a05:600c:45ca:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-47d84b39832mr142200215e9.28.1768117607606;
        Sat, 10 Jan 2026 23:46:47 -0800 (PST)
Received: from [10.50.5.3] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f7035f2sm278894505e9.12.2026.01.10.23.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 23:46:47 -0800 (PST)
Message-ID: <2b1e83fc-4765-4e8c-93dd-a74698a3fe03@grimberg.me>
Date: Sun, 11 Jan 2026 09:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add a LRU for delegations
To: Trond Myklebust <trondmy@kernel.org>, Chuck Lever <cel@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20260107072720.1744129-1-hch@lst.de>
 <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
 <20260107162202.GA23066@lst.de>
 <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
 <45ba87f3-2322-424b-95b1-9129a2537545@app.fastmail.com>
 <5ae5ed3a-5351-4dc1-98e4-0f31653ee2b6@grimberg.me>
 <8598e161ce18337022eefce71e7b8d35753cc735.camel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8598e161ce18337022eefce71e7b8d35753cc735.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Yes, I agree to some extent. However arguably the client may want
>> keep
>> delegation
>> states around for as long as it can "just in case" the application
>> opens
>> the file again (the client
>> doesn't know the nature of the workload) assuming they fit in client
>> memory. It doesn't know
>> anything about other clients nor the server resources.
>>
>> The server on the other hand, has the knowledge of what delegations
>> conflict (or may conflict)
>> and act accordingly (not grant or recall).

Hey Trond,

> You can't just assume this: it really depends heavily on the workload.
> Imagine an 'rm -rf' operation if you have to recall delegations from
> various clients on all the files in the tree because they are caching
> read delegations 'just in case'.

I don't disagree that this can happen, but the scenario you are 
describing can happen regardless no?
Isn't that a concern of the server though? IMO the server should be the 
one that
can both track and account for other clients. Seems to me that giving up the
delegation just because some other client may modify the file is an 
assumption that the nfs client
takes without basing it on real data.

I'd think that the client should rely on the server to account cross 
clients state since
it has the awareness of what other clients are doing.

>
> The current behaviour is based on the assumption that if your
> application has not locally reopened the file for several minutes, then
> that RPC call to reopen it on the server is by comparison not
> particularly expensive.

That is reasonable, I agree. The use-case where I think this assumption does
not hold is when the client does not open the file, but rather stat it. 
Perhaps that case can
be mitigated if the client can add an opportunistic WANT_DELEG in the 
GETATTR compound
to ask for a read delegation. The server can always choose not to grant 
one...

> Yes, there are some exceptions to that rule too, but by and large it is
> a reasonable expectation, particularly so since the clients can all
> still cache the file data for as long as the change attribute remains
> the same. Any attempts to change the file would in any case trigger
> delegation recalls, with delays to the writer while the server waits
> for those recalls to complete.

Yes.

>
> IOW: Before agreeing to change the delegation expiration times, I'd
> like to see actual data that justifies caching for longer as a general
> rule, rather than just relying on peoples' assumptions that this is the
> case.

That makes perfect sense to me Trond.

