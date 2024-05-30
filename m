Return-Path: <linux-nfs+bounces-3486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB78D491C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 12:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F841F24593
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 10:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A5818398E;
	Thu, 30 May 2024 10:02:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A118396D
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063325; cv=none; b=Czl0n2CffONEnYHxxG+loTtp61l8j2VDMzFgYkziT1HRb/r3QPAM2ZTTRk/AmE+ZsoVJGyS2OPZ1cpxokJXPTxgPonFnWlSiqhosgjtyc1ZYYu9ccMsdmFVKOsihx8eTg45J3xjI6J/CYzGMgPupARhYhs3ewg9XU5qkgSj83CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063325; c=relaxed/simple;
	bh=fJK8a/Rd8GieLOJlnF8Vfg8WQZeiQ8sKEW5i6epu8KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfAMSJvdfvemTl6W7drlU9AMCc9J553DeRNFlU6j4vPVSmxt62h8XVvOAuO2IA3teeHXdysepkz4xud0rs7uD3+YWEc848Hm5GzzXkkCvfKd3WfanRtXyW0KcWctkePDuv+J4LTSMM7eNHBClHB6jV5OAXpkFKnnGRoBQUePLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42110872bf9so1093305e9.3
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 03:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717063321; x=1717668121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUmFYVfwhSbqrZXzDN5DY2uilJbb1xhr53+bn9mXf+c=;
        b=tjygssi0GTtIaZ11iV9IMmXdoWyDUHMFtcAzVLqqwstU7MuzwJXmUeVGFfrj4QVjMy
         gJS5TgdXgdOVgLm34zbWqNzvVXVSMSPtVwSseUG8ndsDm/ZG+3ZXvwDUV6wPse16LTYx
         qJTc3iErnEaRdPvOI3ff/r+UzxUsuhkQe1Eavc7ngKNz86EgCgrnvukQUQnKUBq9aeg7
         nzZEwtKwMNu37jpKPQbWVvXXuSJjqeGmxdFokUGiHFcf1vvwl/ZWka6y9h5MXzE1Pv1Y
         +TrrvJRvmHSlfDAuZQuVL+cinudgevyFr4gEqH1StI7h3g9hVq2ywpwYrJYHCOgZudvP
         B/mA==
X-Forwarded-Encrypted: i=1; AJvYcCVUTzQFcHoCq+rysKAgh2KhNNKfjrPomCDut2sfd07QcbHihE4zINDFlJhWnSgBqazRvKNTsGGFFPxD0l/XRYcTmUExSl8S2v8y
X-Gm-Message-State: AOJu0YxVMcbtM6Lld1Dae166SSQAPkn7H5yGnmCo2EvCD0Q8k6IrIicH
	QxTIMd9PUgxPFMRuauALjAIH/SkoqeZJ7VpJWml3t9MaGSfKNpWT
X-Google-Smtp-Source: AGHT+IG8+I7/P1A+sRBDGAffx8g6m8t3NLnL+tanI6B+5IHP/vdOYBN2mCDQk7UxoLhz7JHstgY3JA==
X-Received: by 2002:a05:600c:5121:b0:41f:cfe6:3648 with SMTP id 5b1f17b1804b1-42127816969mr14429365e9.1.1717063321233;
        Thu, 30 May 2024 03:02:01 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706a135sm20057245e9.28.2024.05.30.03.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 03:02:00 -0700 (PDT)
Message-ID: <a86fdd86-7c3a-44e9-9d49-4b3edfab66e6@grimberg.me>
Date: Thu, 30 May 2024 13:01:58 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS write congestion size
To: Jan Kara <jack@suse.cz>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "anna@kernel.org" <anna@kernel.org>, "nfbrown@suse.com" <nfbrown@suse.com>
References: <20240529161102.5x3hhnbz32lwjcej@quack3>
 <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
 <440dcc5a-fdea-4677-9bad-b782e9801747@grimberg.me>
 <20240530083151.vwxw3sqzrfhglaed@quack3>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240530083151.vwxw3sqzrfhglaed@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/05/2024 11:31, Jan Kara wrote:
> On Thu 30-05-24 10:44:01, Sagi Grimberg wrote:
>> On 29/05/2024 20:05, Trond Myklebust wrote:
>>> On Wed, 2024-05-29 at 18:11 +0200, Jan Kara wrote:
>>>> Hello,
>>>>
>>>> so I was investigating why random writes to a large file over NFS got
>>>> noticeably slower. The workload we use to test this is this fio
>>>> command:
>>>>
>>>> fio --direct=0 --ioengine=sync --thread --directory=/mnt --
>>>> invalidate=1 \
>>>>       --group_reporting=1 --runtime=300 --fallocate=posix --
>>>> ramp_time=10 \
>>>>       --name=RandomWrites-async-257024-4k-4 --new_group --rw=randwrite
>>>> \
>>>>       --size=32000m --numjobs=4 --bs=4k --fsync_on_close=1 --
>>>> end_fsync=1 \
>>>>       --filename_format='FioWorkloads.$jobnum'
>>>>
>>>> Eventually I've tracked down the regression to be caused by
>>>> 6df25e58532b
>>>> ("nfs: remove reliance on bdi congestion") which changed the
>>>> congestion
>>>> mechanism from a generic bdi congestion handling to NFS private one.
>>>> Before
>>>> this commit the fio achieved throughput of 180 MB/s, after this
>>>> commit only
>>>> 120 MB/s. Now part of the regression was actually caused by
>>>> inefficient
>>>> fsync(2) and the fact that more dirty data was cached at the time of
>>>> the
>>>> last fsync after commit 6df25e58532b. After fixing fsync [1], the
>>>> throughput got to 150 MB/s so better but still not quite the
>>>> throughput
>>>> before 6df25e58532b.
>>>>
>>>> The reason for remaining regression is that bdi congestion handling
>>>> was
>>>> broken and the client had happily ~8GB of outstanding IO against the
>>>> server
>>>> despite the congestion limit was 256 MB. The new congestion handling
>>>> actually works but as a result the server does not have enough dirty
>>>> data
>>>> to efficiently operate on and the server disk often gets idle before
>>>> the
>>>> client can send more.
>>>>
>>>> I wanted to discuss possible solutions here.
>>>>
>>>> Generally 256MB is not enough even for consumer grade contemporary
>>>> disks to
>>>> max out throughput. There is tunable
>>>> /proc/sys/fs/nfs/nfs_congestion_kb.
>>>> If I tweak it to say 1GB, that is enough to give the server enough
>>>> data to
>>>> saturate the disk (most of the time) and fio reaches 180MB/s as
>>>> before
>>>> commit 6df25e58532b. So one solution to the problem would be to
>>>> change the
>>>> default of nfs_congestion_kb to 1GB.
>>>>
>>>> Generally the problem with this tuning is that faster disks may need
>>>> even
>>>> larger nfs_congestion_kb, the NFS client has no way of knowing what
>>>> the
>>>> right value of nfs_congestion_kb is. I personally find the concept of
>>>> client throttling writes to the server flawed. The *server* should
>>>> push
>>>> back (or throttle) if the client is too aggressively pushing out the
>>>> data
>>>> and then the client can react to this backpressure. Because only the
>>>> server
>>>> knows how much it can handle (also given the load from other
>>>> clients). And
>>>> I believe this is actually what is happening in practice (e.g. when I
>>>> tune
>>>> nfs_congestion_kb to really high number). So I think even better
>>>> solution
>>>> may be to just remove the write congestion handling from the client
>>>> completely. The history before commit 6df25e58532b, when congestion
>>>> was
>>>> effectively ignored, shows that this is unlikely to cause any
>>>> practical
>>>> problems. What do people think?
>>> I think we do still need a mechanism to prevent the client from pushing
>>> more writebacks into the RPC layer when the server throttling is
>>> causing RPC transmission queues to build up. Otherwise we end up
>>> increasing the latency when the application is trying to do more I/O to
>>> pages that are queued up for writeback in the RPC layer (since the
>>> latter will be write locked).
>> Plus the server is likely serving multiple clients, so removing any type
>> of congestion handling from the client may overwhelm the server.
> I understand this concern but before commit 6df25e58532b we effectively
> didn't do any throttling for years and nobody complained.

don't know about the history nor what people could have attributed problems.

>   So servers
> apparently know how to cope with clients sending too much IO to them.

not sure how an nfs server would cope with this. nfsv4 can reduce slots, 
but not
sure what nfsv3 server would do...

btw, I think you meant that *slower* devices may need a larger queue to 
saturate,
because if the device is fast, 256MB inflight is probably enough... So 
you are solving
for the "consumer grade contemporary disks".

