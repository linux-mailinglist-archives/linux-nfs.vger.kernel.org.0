Return-Path: <linux-nfs+bounces-3493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD138D51A6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 20:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF71F23A02
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F81481A4;
	Thu, 30 May 2024 18:14:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B81CD0C
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092875; cv=none; b=YJwdLihQGPxCtuEFelgjthRwwCKAsbt/EUj7Cs9IqjylwFrsHbHEGZjNCR7KY/o20fIrZN1KyKcG8px/y+Kr/BsAo608c3Mq8oOXBgTuPqqrSsA3nYqav+hr3+sBx20NsuVrmWv4Z6vP2w6FZJ2yWQ86hbR9I1BbRMNw56TBsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092875; c=relaxed/simple;
	bh=NqQkCe0gCk0hCpKBZhkBYdHgz/OjKLlPjAefSLZwl38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWeEdVtZ+k/BBUBqhOM44MnL+mKL85QpYdB+zeblzXEY3HnKenbMAhcha1QftMJ+F9D8LHaPup5CSUQIkRetJVjQWIA1eDPegYbH06CKxRcF6omajB/adBNIvm2K3Cl1z4SOn2+x5+EPFjDu1/bMFPftU68T0Py/zu2zg6gtSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so1769725e9.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 11:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717092869; x=1717697669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24OZHU4wNm875bZnGwQMLkp9Hs/7i2sO6uFGBppheOo=;
        b=Ay1R9D148dPJHSnIH5RwpdbEgn6PtsFyUbT7Q8tEGy6My33JD5/IeYlXR03wiVLuAE
         xIRSl09Rs+/0tI6WQKNJ3b3ZFwuiiWM3uXRqPpfel9aE2KnSbc9ErPshnrncWcZk1van
         1/KQW5UqL1yYoC5Qm1g/2kVAhSUR71Qec9lEerPjfkwcwMLOj68b9VVIA0TFSufP0aJ/
         6+G3bb0mDWdByp2mxNu43+uESPG8SRbZ9/JGygcf7bK9iLmBKohjKvjrOhhh/b+jq1Tx
         MJT1M0BdTvMYzP66qqAnLZOouyw7EbXDjfUy+iGDJvHAG4luvAL/6z2ZaRyfhrsWmbi3
         8rjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcu1kgi9Mk7d9wyF9OYgDKU0XdGpGtatmoGomNrTb42PjsWgCPOuGRRFk/+iYiWJAd/6f5VsqlV8j1sKcqalYzX+nXRRH9hHIQ
X-Gm-Message-State: AOJu0Yx/rsvr1T5mqpdYZW0DSFPsIM1LO9RcmP+FSXzO8VmRyjrDR3im
	LuTjWEzxycSaU0Fr59uTE27gTvjQANFxpoc4VXHP1xuHVhLkJiStboLKRg==
X-Google-Smtp-Source: AGHT+IEQib2Za4ybKNZlq8ROGJtEafZ9M6SgaCToYGqm5FAdBPqRogBUJDZswLZcWus8AEyN+tkGWA==
X-Received: by 2002:adf:e751:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35dc00cc21bmr2002078f8f.4.1717092869401;
        Thu, 30 May 2024 11:14:29 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d96f6sm96174f8f.61.2024.05.30.11.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 11:14:29 -0700 (PDT)
Message-ID: <7ec9d81e-288a-4187-b79e-a4e616578580@grimberg.me>
Date: Thu, 30 May 2024 21:14:27 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS write congestion size
To: Trond Myklebust <trondmy@hammerspace.com>, "jack@suse.cz" <jack@suse.cz>
Cc: "anna@kernel.org" <anna@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "nfbrown@suse.com" <nfbrown@suse.com>
References: <20240529161102.5x3hhnbz32lwjcej@quack3>
 <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
 <440dcc5a-fdea-4677-9bad-b782e9801747@grimberg.me>
 <20240530083151.vwxw3sqzrfhglaed@quack3>
 <a86fdd86-7c3a-44e9-9d49-4b3edfab66e6@grimberg.me>
 <dfec543c411bf054d20f0e32971a98e174ed4c12.camel@hammerspace.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <dfec543c411bf054d20f0e32971a98e174ed4c12.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/05/2024 14:13, Trond Myklebust wrote:
> On Thu, 2024-05-30 at 13:01 +0300, Sagi Grimberg wrote:
>>
>> On 30/05/2024 11:31, Jan Kara wrote:
>>> On Thu 30-05-24 10:44:01, Sagi Grimberg wrote:
>>>> On 29/05/2024 20:05, Trond Myklebust wrote:
>>>>> On Wed, 2024-05-29 at 18:11 +0200, Jan Kara wrote:
>>>>>> Hello,
>>>>>>
>>>>>> so I was investigating why random writes to a large file over
>>>>>> NFS got
>>>>>> noticeably slower. The workload we use to test this is this
>>>>>> fio
>>>>>> command:
>>>>>>
>>>>>> fio --direct=0 --ioengine=sync --thread --directory=/mnt --
>>>>>> invalidate=1 \
>>>>>>        --group_reporting=1 --runtime=300 --fallocate=posix --
>>>>>> ramp_time=10 \
>>>>>>        --name=RandomWrites-async-257024-4k-4 --new_group --
>>>>>> rw=randwrite
>>>>>> \
>>>>>>        --size=32000m --numjobs=4 --bs=4k --fsync_on_close=1 --
>>>>>> end_fsync=1 \
>>>>>>        --filename_format='FioWorkloads.$jobnum'
>>>>>>
>>>>>> Eventually I've tracked down the regression to be caused by
>>>>>> 6df25e58532b
>>>>>> ("nfs: remove reliance on bdi congestion") which changed the
>>>>>> congestion
>>>>>> mechanism from a generic bdi congestion handling to NFS
>>>>>> private one.
>>>>>> Before
>>>>>> this commit the fio achieved throughput of 180 MB/s, after
>>>>>> this
>>>>>> commit only
>>>>>> 120 MB/s. Now part of the regression was actually caused by
>>>>>> inefficient
>>>>>> fsync(2) and the fact that more dirty data was cached at the
>>>>>> time of
>>>>>> the
>>>>>> last fsync after commit 6df25e58532b. After fixing fsync [1],
>>>>>> the
>>>>>> throughput got to 150 MB/s so better but still not quite the
>>>>>> throughput
>>>>>> before 6df25e58532b.
>>>>>>
>>>>>> The reason for remaining regression is that bdi congestion
>>>>>> handling
>>>>>> was
>>>>>> broken and the client had happily ~8GB of outstanding IO
>>>>>> against the
>>>>>> server
>>>>>> despite the congestion limit was 256 MB. The new congestion
>>>>>> handling
>>>>>> actually works but as a result the server does not have
>>>>>> enough dirty
>>>>>> data
>>>>>> to efficiently operate on and the server disk often gets idle
>>>>>> before
>>>>>> the
>>>>>> client can send more.
>>>>>>
>>>>>> I wanted to discuss possible solutions here.
>>>>>>
>>>>>> Generally 256MB is not enough even for consumer grade
>>>>>> contemporary
>>>>>> disks to
>>>>>> max out throughput. There is tunable
>>>>>> /proc/sys/fs/nfs/nfs_congestion_kb.
>>>>>> If I tweak it to say 1GB, that is enough to give the server
>>>>>> enough
>>>>>> data to
>>>>>> saturate the disk (most of the time) and fio reaches 180MB/s
>>>>>> as
>>>>>> before
>>>>>> commit 6df25e58532b. So one solution to the problem would be
>>>>>> to
>>>>>> change the
>>>>>> default of nfs_congestion_kb to 1GB.
>>>>>>
>>>>>> Generally the problem with this tuning is that faster disks
>>>>>> may need
>>>>>> even
>>>>>> larger nfs_congestion_kb, the NFS client has no way of
>>>>>> knowing what
>>>>>> the
>>>>>> right value of nfs_congestion_kb is. I personally find the
>>>>>> concept of
>>>>>> client throttling writes to the server flawed. The *server*
>>>>>> should
>>>>>> push
>>>>>> back (or throttle) if the client is too aggressively pushing
>>>>>> out the
>>>>>> data
>>>>>> and then the client can react to this backpressure. Because
>>>>>> only the
>>>>>> server
>>>>>> knows how much it can handle (also given the load from other
>>>>>> clients). And
>>>>>> I believe this is actually what is happening in practice
>>>>>> (e.g. when I
>>>>>> tune
>>>>>> nfs_congestion_kb to really high number). So I think even
>>>>>> better
>>>>>> solution
>>>>>> may be to just remove the write congestion handling from the
>>>>>> client
>>>>>> completely. The history before commit 6df25e58532b, when
>>>>>> congestion
>>>>>> was
>>>>>> effectively ignored, shows that this is unlikely to cause any
>>>>>> practical
>>>>>> problems. What do people think?
>>>>> I think we do still need a mechanism to prevent the client from
>>>>> pushing
>>>>> more writebacks into the RPC layer when the server throttling
>>>>> is
>>>>> causing RPC transmission queues to build up. Otherwise we end
>>>>> up
>>>>> increasing the latency when the application is trying to do
>>>>> more I/O to
>>>>> pages that are queued up for writeback in the RPC layer (since
>>>>> the
>>>>> latter will be write locked).
>>>> Plus the server is likely serving multiple clients, so removing
>>>> any type
>>>> of congestion handling from the client may overwhelm the server.
>>> I understand this concern but before commit 6df25e58532b we
>>> effectively
>>> didn't do any throttling for years and nobody complained.
>
> Commit 6df25e58532b doesn't add throttling. It just converts from using
> the bdi based mechanism to using a NFS-specific one.
> That bdi based throttling mechanism dates at least back to 2007,
> although there was code before that dating back to pre-git history.
>
>> don't know about the history nor what people could have attributed
>> problems.
>>
>>>    So servers
>>> apparently know how to cope with clients sending too much IO to
>>> them.
>> not sure how an nfs server would cope with this. nfsv4 can reduce
>> slots,
>> but not
>> sure what nfsv3 server would do...
>>
>> btw, I think you meant that *slower* devices may need a larger queue
>> to
>> saturate,
>> because if the device is fast, 256MB inflight is probably enough...
>> So
>> you are solving
>> for the "consumer grade contemporary disks".
>>
> It is hard to do server side congestion control with UDP, since it does
> not have a native congestion mechanism to leverage.
>
> However connection based transports are essentially a queuing mechanism
> as far as the server is concerned. It can trivially push back on the
> client by slowing down the rate at which it pulls RPC calls from the
> transport (or stopping them altogether). That's a mechanism that works
> just fine for both TCP and RDMA.

Yes, I agree. tcp throttling works. Just has some downsides. I was 
referring to a higher-level
credit based flow control.

>
> Additionally, NFSv4 has the session slot mechanism, and while that can
> be used as a throttling mechanism, it is more about providing safe
> only-once replay semantics.

OK, that is good to know. I assumed that it is designed to be used for 
throttling.

>   A prudent server implementation would not rely on it to replace transport level throttling.
>

Oh, definitely not replace. But I get your point.

