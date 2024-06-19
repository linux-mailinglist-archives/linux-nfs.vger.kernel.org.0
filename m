Return-Path: <linux-nfs+bounces-4059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DC90E5E7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 10:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211171F22235
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04DC79B84;
	Wed, 19 Jun 2024 08:37:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DC87D071
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786277; cv=none; b=jtVDU4desYm8r3fKtsZ79DTzcQe2iFSmrN2PpRISUdZr2TKS3zxuQk8KmsLgh/SOCMjq/yPdQKjl3me6l2ZtQkIGNm0+KKj0MC+K/LGVXAh4d22jR9rsgP63n+3Ng6aFAVz4GrU8qPGKNKedMrwqNMtQQRCWN97K959RaLKSh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786277; c=relaxed/simple;
	bh=3nHxUuO9yUa7vxH3Kp/IvZeB9wJnsIfiOgwvVRlFTNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rK7XNmtNx3v4DpDg5FuJO64CLr4Ufxg8ci6K48TnyerV9FzmPthRjFshBs0X2jDlwPxsDktBppYpBBW+9G4oSI1n6LSwalg4331KNzQfky/Shee9+EwMZ0xbqq3kRLJL8yz7J52r1ajy02dlDkNAdB7zJBxd0tJXpOxo79a/r/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so6414565e9.1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 01:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718786274; x=1719391074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ube6FSne86GE5z2fnvXBFbtaksEs6jMUI0I4bGf6VE=;
        b=uINkT4V35C0DG5kwj8VGfIwfIXP9DaZEZoPFj8aHeQkgMOn9rfth4/GyZQwqzNxKpr
         9x9r5LfepcF1o2ltv+W3h7FRbnAFviaiOxryOCNKmL2HWJ5NyZsLCFxe/HRw170Feetc
         So8SWYMpn9j6KW2i7jR45MsbCVabM7RLXGYkkLi9eO/k8ayu2uvyNgwI+vzgE3aNH97u
         03HzinUkd7augBEKdhS00ns6HRjSHYR/FQiJXfw52ZK2kjAJp4sFEbHkN1f1v4Yz/8WA
         dDE4bBsbCe5Dt36uPfhY+CVtbhn2oEtZFrYikhsz+B71oiv8nKsGLJ4Hh76lXKXMr+sZ
         bshg==
X-Forwarded-Encrypted: i=1; AJvYcCU2TVcSdOWl6RnHhDjrNqrP5R5jkprEPKj/FBgGxyNvDOKNXIJxNcgBgTCfOhe9/9ToaQJ/ht4r4Fko0AT0Elw7lFYAZqNb4t49
X-Gm-Message-State: AOJu0Yx/yQuJifDaIz4p37cBOV31wu2FlyeWDfuT3F+r9qHYC1WFdhG5
	cTqTqshFmPRnawxlq2NJoLx3rOpVgYMDWsk7xMpx4pJldUK912Y4
X-Google-Smtp-Source: AGHT+IGxWTywv+BmFz+WyfhPaWb9XS6cwcxyW/gCHvpZ51/FjngtuMUHIDqQ1AE62W/zDdblkYLtlA==
X-Received: by 2002:a05:600c:4fc9:b0:421:bb51:d630 with SMTP id 5b1f17b1804b1-424752981b8mr12801485e9.2.1718786274069;
        Wed, 19 Jun 2024 01:37:54 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9184sm252070585e9.13.2024.06.19.01.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 01:37:53 -0700 (PDT)
Message-ID: <ae298053-bdee-4a8a-b6a9-e57de79abc97@grimberg.me>
Date: Wed, 19 Jun 2024 11:37:52 +0300
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d2f48ca233f85da80f2193cd92e6f97feb587a69.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/06/2024 21:59, Trond Myklebust wrote:
> Hi Dan,
>
> On Tue, 2024-06-18 at 18:33 +0300, Dan Aloni wrote:
>> There are some applications that write to predefined non-overlapping
>> file offsets from multiple clients and therefore don't need to rely
>> on
>> file locking. However, NFS file system behavior of extending writes
>> to
>> to deal with write fragmentation, causes those clients to corrupt
>> each
>> other's data.
>>
>> To help these applications, this change adds the `noextend` parameter
>> to
>> the mount options, and handles this case in `nfs_can_extend_write`.
>>
>> Clients can additionally add the 'noac' option to ensure page cache
>> flush on read for modified files.
> I'm not overly enamoured of the name "noextend". To me that sounds like
> it might have something to do with preventing appends. Can we find
> something that is a bit more descriptive?

nopbw (No page boundary writes) ?

>
> That said, and given your last comment about reads. Wouldn't it be
> better to have the application use O_DIRECT for these workloads?
> Turning off attribute caching is both racy and an inefficient way to
> manage page cache consistency. It forces the client to bombard the
> server with GETATTR requests in order to check that the page cache is
> in synch, whereas your description of the workload appears to suggest
> that the correct assumption should be that it is not in synch.
>
> IOW: I'm asking if the better solution might not be to rather implement
> something akin to Solaris' "forcedirectio"?

This access pattern represents a common case in HPC where different workers
write records to a shared output file which do not necessarily align to 
a page boundary.

This is not everything that the app is doing nor the only file it is 
accessing, so IMO forcing
directio universally is may penalize the application.

