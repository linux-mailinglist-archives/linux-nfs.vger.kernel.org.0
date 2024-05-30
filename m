Return-Path: <linux-nfs+bounces-3484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAC8D464B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 09:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA91C20AD8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4155897;
	Thu, 30 May 2024 07:44:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5C55886
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055046; cv=none; b=K1OpCl9ZZ5eiW+s+i4O7c6pWj4XXK3s/kvZQfghg71bpYwA/3FJpfPMdN6Gz8hH+Hr/DVSv9we67mkQQ8H3fLH+L6Q5p2Xh9ucKKpDWDtuotS5huI3dvP7CRr/UQ5ye4ljyOVO6x5BNxABV/KG6eT4EpCt3ovPzPTRbemqFhsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055046; c=relaxed/simple;
	bh=9fd1z/gGCHS6p0fSRVizfJnKVSjRe1ZCssrFGv6LRZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNhRYANj1EBQU7h/EEwo7ZeH7pnH8uJB6R9lwCImMVmtIZo2b+PRYKuaZH+tI4XvtJQNvCm5hIuxVYCm5haf+TxGhrmfuWrp2UNivMiGMnD03XGITsK+R01eCN8hB7CSKRw3hFCTka+Oic97rIuRtI0frv3/PYEem7wbcXypUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42115de211aso627365e9.2
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 00:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055042; x=1717659842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzeYVnsIZIURy/eNUobl8wcvhXt4Fx/dXp9zT93RltE=;
        b=ScYeUSf9H85ASpqF/SW/3pixdtdRzri5wcQM+vsQgdja3+aJxpOQj7VHv5EyJxghSv
         9/t8yPjr6HdMwxHsQCRWgxYPvYXYdk5P067G7BE6oL8X9jGN/renjRqzk4qgUP3Zn9gT
         xDIW8Z8F7KNxF7nwJ0htaenAcZRjmdkIL84fUEcaaNRJjLakF/vdlfZI6llI7P9X36Rs
         kf+EMstVLBb0BCDWgVi5+foqyuB8BNkN4j9oa6G56EeyLekgmyItg6/Mdb0jUMxdp/zj
         daXmdxyEwI8gPg98F9Z7SqkweKIwZ7k6bbfSxU+99M7ZBtU4DmK1eBi/thLM2OY7MrHo
         6Hdg==
X-Forwarded-Encrypted: i=1; AJvYcCW+3eHmGA6IYxlw3uPfzoPutHmaV8mZBsdt3wbbQK4gEB9CZGAW8n3rds1NeRv7VWEtZOHxVuYs9/FopSYVusECoQMZ2Go+29pP
X-Gm-Message-State: AOJu0YytrbHfv9/e598hpikUThHAGzx7sQsvbFZ87kTEEYugVfO1ucWd
	0r0J057WhfPb28+PEweOlGoL3LlPgYh34HuAaqrMdb0eFGJywP4s
X-Google-Smtp-Source: AGHT+IFkBOtmlxDQDROxG6jcL6joHVvijsxykaXQXfbpuRI1LU62/RaLZWI0KxLY9U4UmVoIOlgVng==
X-Received: by 2002:a05:600c:3b99:b0:418:1303:c3d1 with SMTP id 5b1f17b1804b1-4212793612bmr12551785e9.3.1717055042403;
        Thu, 30 May 2024 00:44:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270697b6sm16399575e9.24.2024.05.30.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 00:44:02 -0700 (PDT)
Message-ID: <440dcc5a-fdea-4677-9bad-b782e9801747@grimberg.me>
Date: Thu, 30 May 2024 10:44:01 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS write congestion size
To: Trond Myklebust <trondmy@hammerspace.com>, "jack@suse.cz" <jack@suse.cz>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: "anna@kernel.org" <anna@kernel.org>, "nfbrown@suse.com" <nfbrown@suse.com>
References: <20240529161102.5x3hhnbz32lwjcej@quack3>
 <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/05/2024 20:05, Trond Myklebust wrote:
> On Wed, 2024-05-29 at 18:11 +0200, Jan Kara wrote:
>> Hello,
>>
>> so I was investigating why random writes to a large file over NFS got
>> noticeably slower. The workload we use to test this is this fio
>> command:
>>
>> fio --direct=0 --ioengine=sync --thread --directory=/mnt --
>> invalidate=1 \
>>      --group_reporting=1 --runtime=300 --fallocate=posix --
>> ramp_time=10 \
>>      --name=RandomWrites-async-257024-4k-4 --new_group --rw=randwrite
>> \
>>      --size=32000m --numjobs=4 --bs=4k --fsync_on_close=1 --
>> end_fsync=1 \
>>      --filename_format='FioWorkloads.$jobnum'
>>
>> Eventually I've tracked down the regression to be caused by
>> 6df25e58532b
>> ("nfs: remove reliance on bdi congestion") which changed the
>> congestion
>> mechanism from a generic bdi congestion handling to NFS private one.
>> Before
>> this commit the fio achieved throughput of 180 MB/s, after this
>> commit only
>> 120 MB/s. Now part of the regression was actually caused by
>> inefficient
>> fsync(2) and the fact that more dirty data was cached at the time of
>> the
>> last fsync after commit 6df25e58532b. After fixing fsync [1], the
>> throughput got to 150 MB/s so better but still not quite the
>> throughput
>> before 6df25e58532b.
>>
>> The reason for remaining regression is that bdi congestion handling
>> was
>> broken and the client had happily ~8GB of outstanding IO against the
>> server
>> despite the congestion limit was 256 MB. The new congestion handling
>> actually works but as a result the server does not have enough dirty
>> data
>> to efficiently operate on and the server disk often gets idle before
>> the
>> client can send more.
>>
>> I wanted to discuss possible solutions here.
>>
>> Generally 256MB is not enough even for consumer grade contemporary
>> disks to
>> max out throughput. There is tunable
>> /proc/sys/fs/nfs/nfs_congestion_kb.
>> If I tweak it to say 1GB, that is enough to give the server enough
>> data to
>> saturate the disk (most of the time) and fio reaches 180MB/s as
>> before
>> commit 6df25e58532b. So one solution to the problem would be to
>> change the
>> default of nfs_congestion_kb to 1GB.
>>
>> Generally the problem with this tuning is that faster disks may need
>> even
>> larger nfs_congestion_kb, the NFS client has no way of knowing what
>> the
>> right value of nfs_congestion_kb is. I personally find the concept of
>> client throttling writes to the server flawed. The *server* should
>> push
>> back (or throttle) if the client is too aggressively pushing out the
>> data
>> and then the client can react to this backpressure. Because only the
>> server
>> knows how much it can handle (also given the load from other
>> clients). And
>> I believe this is actually what is happening in practice (e.g. when I
>> tune
>> nfs_congestion_kb to really high number). So I think even better
>> solution
>> may be to just remove the write congestion handling from the client
>> completely. The history before commit 6df25e58532b, when congestion
>> was
>> effectively ignored, shows that this is unlikely to cause any
>> practical
>> problems. What do people think?
> I think we do still need a mechanism to prevent the client from pushing
> more writebacks into the RPC layer when the server throttling is
> causing RPC transmission queues to build up. Otherwise we end up
> increasing the latency when the application is trying to do more I/O to
> pages that are queued up for writeback in the RPC layer (since the
> latter will be write locked).

Plus the server is likely serving multiple clients, so removing any type
of congestion handling from the client may overwhelm the server.

