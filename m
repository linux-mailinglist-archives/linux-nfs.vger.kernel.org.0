Return-Path: <linux-nfs+bounces-8148-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC09D36EC
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 10:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD4F281047
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069C19F118;
	Wed, 20 Nov 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4PVS5oL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A91A08CC
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094313; cv=none; b=kOLvvEzMqAuFMDwC9S0COW75usYQsv2dBx263A0B8HknWHo7s7EG2Izhts6O+w878+XC/zc1lbE298jF66VN3GZWQQnpuTNexSKyGHalyB+DLniiZHWLjBQ4zGuFv5Tk3cGASnLDXCLuBgSFUeJRSy0zsz0ytQ72dhYlbClOHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094313; c=relaxed/simple;
	bh=1R48pHdaLZsTH7rRbY0P8eQVmjjGGtJcJ7MxF9/9pkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAjDTN2hn7L7SN3otkhgeIIttwHtlkkTe8zNeqtvyoJdMbnxxqmhq3uRgriHbDuHj59oNYLiQiuDx5sUBMJ9Hlf+qmwMO11D3TqV1G6BzpO7B/ZBEKkfSYAs/WMpxN/3sXK28DmbK+X/Z+6WmhmDXEowAH04DdYinAIobeem18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4PVS5oL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732094309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHPc+PxzRd4jrPrVq3hCuz9IE5t5fIPgWOv/lgMmQxg=;
	b=a4PVS5oLvyksqmAWYeUZiGPPfmnDBRMVZB9Z/LeITyKnTrVyST0H0emcvK2vuFeqL1lAlu
	ac5AhXV3KUxIF2zmrX7x2V/MTn9hsiUiCt/SKu62ylJV0Uk6vlLXHecAgiGWVCFIjhsYM/
	3IHcaZCJ9BJX+Nq1Hz8+U8Jgbp5pIaI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-2wjJ6XycOOOq56RqsT6kpQ-1; Wed, 20 Nov 2024 04:18:27 -0500
X-MC-Unique: 2wjJ6XycOOOq56RqsT6kpQ-1
X-Mimecast-MFC-AGG-ID: 2wjJ6XycOOOq56RqsT6kpQ
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ae0af926dso410561039f.2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 01:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732094307; x=1732699107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHPc+PxzRd4jrPrVq3hCuz9IE5t5fIPgWOv/lgMmQxg=;
        b=sIQLClJ6cbk7FQBW80QehSyqdZjqPUUYDWTL40e9U5Z7tKgVP3EWSS6ul0bF0Kp/Ym
         EXXsaiBi5xyLPHOLs1pNhbewn1KLQVDvLy9aLafKCYMnQMGZMEJ5qXLUnPX6hILazYf2
         ElfdYf1uI+ytN1wdpVe/oGV8M5FXTh1J6Ool/XE9VfZnLSW5WfA4URyvae0GXJIB+H3l
         e0+nmJoFWR/MC6D/xt4pq+CFZ8SqAfz/TAGI2kdwj2gVXPEe7JgwD1c1wS4rB5jreyZk
         RVtl7AJgcgoUDOnZ6LPqN82FK+0sr/b3fT4eQXoXZqqq6fqTlTkTrzH3QFUcXsMnFjHz
         u9ZQ==
X-Gm-Message-State: AOJu0Yz5Uj297ON9NMtUeZfFbIIG+ONCxWyHezPZPIslyKBsxqqEBBWj
	FBPGtp80DJ85sIoWl6YckzwXlF/CFySegf1wqtBPbl2em9tI/QPRrotAVxOw8jr4OxrHsM1sK2N
	db86LCp7H5oTeyZdXQy7r5uLJXsprWsjYdruXOgBrga+Yu5QNVn8xjFuu+g==
X-Received: by 2002:a05:6602:26c5:b0:83a:c4e1:7d50 with SMTP id ca18e2360f4ac-83eb5f94148mr288099739f.2.1732094307220;
        Wed, 20 Nov 2024 01:18:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZRi1lcNX8oLAC3TmJ2rI0wDosB6/1qwB4sXYxoC+8cJJoVvlxiNvAW6SLsA0gJt3iRF8QNQ==
X-Received: by 2002:a05:6602:26c5:b0:83a:c4e1:7d50 with SMTP id ca18e2360f4ac-83eb5f94148mr288098839f.2.1732094306876;
        Wed, 20 Nov 2024 01:18:26 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6eb863sm3052988173.30.2024.11.20.01.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 01:18:25 -0800 (PST)
Message-ID: <c55330c9-6085-40fe-9472-45caaed98aa3@redhat.com>
Date: Wed, 20 Nov 2024 04:18:23 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nfs(5): Update rsize/wsize options
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20241119165942.213409-1-steved@redhat.com>
 <CALXu0UddnDfi1sF6W5Ca8a9Zzjxad3JNgCQXkmpVuoJyBPLGhw@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CALXu0UddnDfi1sF6W5Ca8a9Zzjxad3JNgCQXkmpVuoJyBPLGhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/20/24 2:57 AM, Cedric Blancher wrote:
> On Tue, 19 Nov 2024 at 18:07, Steve Dickson <steved@redhat.com> wrote:
>>
>> From: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
>>
>> The rsize/wsize values are not multiples of 1024 but multiples of the
>> system's page size or powers of 2 if < system's page size as defined
>> in fs/nfs/internal.h:nfs_io_size().
>>
>> Signed-off-by: Steve Dickson <steved@redhat.com>
> 
> REJECT. 
You mean NACK! :-)

> As discussed, this is the WRONG approach. The pagesize is not
> not easily determinable (/bin/pagesize not even being part of the
> default install), and the page size is flexible on many architectures.
Yes... /bin/pagesize is not needed only getconf PAGESIZE is which
is in all default installs.

> rsize/wsize depending on the page size makes this option non portable
> across platforms, or even same platforms with different default
> pagesize settings.
"rsize/wsize depending on the page size" is a kernel thing...
Nothing nfs-utils can do about it but accurately document
what is happening.

> In real life, this can prevent puppet from working for NFS root, if
> NFS root needs rsize/wsize, and someone switches the default page
> size.
Why is puppet evening messing with rsize/wsize? Just let the
kernel do the right thing...

> 
> I thought the correct fix would be to fix the NFS client to count in
> kbytes as documented, and round up/down to the pagesize.
Again this is a kernel thing... Patches are welcomed!

steved.

> 
> Ced
> 
>> ---
>>   utils/mount/nfs.man | 24 +++++++++++++++---------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> V2: Replaced PAGE_SIZE with "system's page size"
>>
>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>> index 233a7177..eab4692a 100644
>> --- a/utils/mount/nfs.man
>> +++ b/utils/mount/nfs.man
>> @@ -215,15 +215,18 @@ or smaller than the
>>   setting. The largest read payload supported by the Linux NFS client
>>   is 1,048,576 bytes (one megabyte).
>>   .IP
>> -The
>> +The allowed
>>   .B rsize
>> -value is a positive integral multiple of 1024.
>> +value is a positive integral multiple of
>> +system's page size
>> +or a power of two if it is less than
>> +system's page size.
>>   Specified
>>   .B rsize
>>   values lower than 1024 are replaced with 4096; values larger than
>>   1048576 are replaced with 1048576. If a specified value is within the supported
>> -range but not a multiple of 1024, it is rounded down to the nearest
>> -multiple of 1024.
>> +range but not such an allowed value, it is rounded down to the nearest
>> +allowed value.
>>   .IP
>>   If an
>>   .B rsize
>> @@ -257,16 +260,19 @@ setting. The largest write payload supported by the Linux NFS client
>>   is 1,048,576 bytes (one megabyte).
>>   .IP
>>   Similar to
>> -.B rsize
>> -, the
>> +.BR rsize ,
>> +the allowed
>>   .B wsize
>> -value is a positive integral multiple of 1024.
>> +value is a positive integral multiple of
>> +system's page size
>> +or a power of two if it is less than
>> +system's page size.
>>   Specified
>>   .B wsize
>>   values lower than 1024 are replaced with 4096; values larger than
>>   1048576 are replaced with 1048576. If a specified value is within the supported
>> -range but not a multiple of 1024, it is rounded down to the nearest
>> -multiple of 1024.
>> +range but not such an allowed value, it is rounded down to the nearest
>> +allowed value.
>>   .IP
>>   If a
>>   .B wsize
>> --
>> 2.47.0
>>
>>
> 
> 


