Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1299614C381
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 00:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA1XWw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 18:22:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42364 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1XWw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jan 2020 18:22:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so3389376wrd.9
        for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2020 15:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=excelero-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Flfvi1+bc4vLm57L8n/UMzIMQBHzjC7w6ndup3yZaUw=;
        b=pH4ENdqup69z7dopOiizgvvNxTRfn5+jU0ZVMYrGK+Yh112mak8Y0A6f0wuR1/ZFE4
         VfuNARnXmea1hBePTkdgWK+d/xIM5dx0jY0G1YU2FIPK9KD/OPZw1nfQuiPbtbRkcXNu
         yllDul87gUhvqLrubsFYLsyHSf2OgiWbo7+4XfFZRZE0IpnW5lAIw9lqgOwczSxK+7N5
         SFOgYsqYDM+G9/WwWvHVsOOYlgvIQ2YnRVwJw8Mah81Q3dX6ZsmcUfj6qg3VFV8CowUF
         OfwRZnWCIS4jS9wDXcRVHMd1aP4OrkqgrI67QKbCCj3D86TovEE6+1sbQ+JW5SuBM3BY
         Zeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Flfvi1+bc4vLm57L8n/UMzIMQBHzjC7w6ndup3yZaUw=;
        b=in2ofHXcUpD06uJ9rn+ifZ3OXYcs2B7r3IEA5y3m6GL1WY/qDzlxz5YXet3Gey/ddD
         O4XEoLCKNf1r317pHalF5/hQ0iexS1FVONl/UbbBBFtAz7+8OGZFf/op3Z8QIrNeb9pm
         5z8qxI3nsWKUYJ2izxZ117wEBEF09Vljx6ExxNcwE/JKYOV5nfYJAj2+amGHRA1fjBpZ
         Ykn+H5WQeqSa20vn1qxayN3Y8VawssQ22Fz2AmghFhFn1jnH/OTbTu7Z+f0DiTeRMOu2
         ojPrxJi36yBWsu542HNR07kWthhXDAG5uPXAnImOdMCTv0JH50y8fTYnplGMsR4Qlmze
         Cxow==
X-Gm-Message-State: APjAAAUBGKXJk4XBdOAqWnR/ABkplcpA6iBEI+lgRWcJ5MxxMvD26a4J
        /pf4gkP2kg0D8VFrL5gOUoFnC9/RU0Q=
X-Google-Smtp-Source: APXvYqzR6aPLjrbNe9Bf7sy9x5ocw3+i3fTFnlLYfWXkJBhqzdqI0OGMPdnYRLsvVZKoYjh32sZo4g==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr31198908wru.294.1580253768377;
        Tue, 28 Jan 2020 15:22:48 -0800 (PST)
Received: from [192.168.0.41] (dslb-088-078-158-079.088.078.pools.vodafone-ip.de. [88.78.158.79])
        by smtp.gmail.com with ESMTPSA id i11sm351592wrs.10.2020.01.28.15.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 15:22:47 -0800 (PST)
Subject: Re: Remove single NFS client performance bottleneck: Only 4 nfsd
 active
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <a8a528c7-80bd-befc-59f8-00135d85a2bf@excelero.com>
 <F82F3FA8-4E2A-4014-A052-A0367562A956@oracle.com>
 <2D125E5E-F97D-4F52-89A9-C499CC7E7A5D@oracle.com>
 <0474b0f7-ec6d-9a02-2cd0-a69339e7cae5@excelero.com>
 <DE46C289-9655-4E45-B89F-110E62F9F82D@oracle.com>
From:   Sven Breuner <sven@excelero.com>
Message-ID: <3b63a0ea-cf3a-fcea-72e6-8d604b16455f@excelero.com>
Date:   Wed, 29 Jan 2020 00:22:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <DE46C289-9655-4E45-B89F-110E62F9F82D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Chuck Lever wrote on 27.01.2020 18:45:
>
>> On Jan 27, 2020, at 12:27 PM, Sven Breuner <sven@excelero.com> wrote:
>>
>> Hi Chuck,
>>
>> thanks for looking into this. (Answers inline...)
>>
>> Chuck Lever wrote on 27.01.2020 15:12:
>>>> On Jan 27, 2020, at 9:06 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> Hi Sven-
>>>>
>>>>> On Jan 26, 2020, at 6:41 PM, Sven Breuner <sven@excelero.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I'm using the kernel NFS client/server and am trying to read as many small files per second as possible from a single NFS client, but seem to run into a bottleneck.
>>>>>
>>>>> Maybe this is just a tunable that I am missing, because the CPUs on client and server side are mostly idle, the 100Gbit (RoCE) network links between client and server are also mostly idle and the NVMe drives in the server are also mostly idle (and the server has enough RAM to easily fit my test data set in the ext4/xfs page cache, but also a 2nd read of the data set from the RAM cache doesn't change the result much).
>>>>>
>>>>> This is my test case:
>>>>> # Create 1.6M 10KB files through 128 mdtest processes in different directories...
>>>>> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d /mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -C
>>>>>
>>>>> # Read all the files through 128 mdtest processes (the case that matters primarily for my test)...
>>>>> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d /mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -E
>>>>>
>>>>> The result is about 20,000 file reads per sec, so only ~200MB/s network throughput.
>>>> What is the typical size of the NFS READ I/Os on the wire?
>> The application is fetching each full 10KB file in a single read op (so "read(fd, buf, 10240)" ) and NFS wsize/rsize is 512KB.
> 512KB is not going to matter if every file contains only 10KB.
> This means 10KB READs. The I/O size is going to limit data
> throughput. 20KIOPS seems low for RDMA, but is about right for
> TCP.
RDMA is about 30% faster (26K file reads per sec), but I'm more hoping for an 
order of magnitude increase.
By the way: Is there an NFSoRDMA equivalent for tcp_slot_table_entries to 
increase or is there no such limit in case of RDMA transport?
> If you see wire operations, then the client's page cache is not
> being used at all?
I'm usually benchmarking after fresh client mount or "echo 3 > 
/proc/sys/vm/drop_caches", because the actual production data set will have many 
more files (multiple Terabytes) and thus won't fit in RAM.
>
>
>>>> Are you sure your mpirun workload is generating enough parallelism?
>> Yes, MPI is only used to start the 128 processes and aggregate the performance results in the end. For the actual file read phase, all 128 processes run completely independent without any communication/synchronization. Each process is working in its own subdir with its own set of 10KB files.
>> (Running the same test directly on the local xfs of the NFS server box results in ~350,000 10KB file reads per sec after cache drop and >1 mio 10KB file reads per sec from page cache. Just mentioning this for the sake of completeness to show that this is not hitting a limit on the server side.)
>>> A couple of other thoughts:
>>>
>>> What's the client hardware like? NUMA? Fast memory? CPU count?
>> Client and server are dual socket Intel Xeon E5-2690 v4 @ 2.60GHz (14 cores per socket plus hyper threading), all 4 memory channels per socket populated with fastest possible DIMMs (DDR4 2400).
> One recommendation: Disable HT in the BIOS.
Thanks for the recommendation. Tried, but no significant difference.
>> Also tried pool_mode auto/global/pernode on server side.
> NUMA seems to matter more on the client than on the server.
mpirun can also bind the mdtest processes to NUMA zones, but also no significant 
difference for that.
>
>
>>> Have you configured device interrupt affinity and used tuned
>>> to disable CPU sleep states, etc?
>> Yes, CPU power saving (frequency scaling) disabled. Tried tuned profiles latency-performance and and throughput-performance. Also tried irqbalance and mlnx_affinity.
>>
>> All without any significant effect unfortunately.
> And lspci -vvv confirms you are getting the right PCIe link
> settings on both systems?

Yes. I can also see >11GB/s network throughput between client and server through 
e.g. ib_send_bw.

Actually, the client and server each have two 100Gbit RoCE NICs, but it seems 
like there isn't a way currently to get the NFS client to spread the 
communication across two RDMA interfaces for a single mountpoint.

Assuming the hardware is not the limit, is there any software limit for 
parallelism in the NFS client? So if an application on an NFS client can 
generates 128 concurrent open/read/close (from 128 threads) to 128 different 
files in the NFS mountpoint, will the NFS client then actually send 128 
concurrent open/read/close over the wire or will it e.g. limit for some reason 
to only 4 or 8 concurrent requests and the rest will be queued until one of the 
first 4/8/... requests has received a reply - e.g. because there is only 1 
pending reply allowed per connection and a client does not establish more than 
4/8/... connections to the same server?
And same question on the NFS server side: If a client sends 128 concurrent reads 
over the wire and the knfsd has 128 threads, will it actually work on all those 
128 reads in parallel or is there a limit in the server that e.g. maps requests 
from the same client to a maximum of 4/8/... threads, no matter how many more 
threads the knfsd has available?

Thanks a lot for your help

Sven

>
>
>>> Have you properly configured your 100GbE switch and cards?
>>>
>>> I have a Mellanox SN2100 here and two hosts with CX-5 Ethernet.
>>> The configuration of the cards and switch is critical to good
>>> performance.
>> Yes, I can absolutely confirm that having this part of the config correct is critical for great performance :-) All configured with PFC and ECN and double-checked for packets to be tagged correctly and lossless in the RoCE case. The topology is simple: Client and server connected to same Mellanox switch, nothing else happening on the switch.
>>>
>>>>> I noticed in "top" that only 4 nfsd processes are active, so I'm wondering why the load is not spread across more of my 64 /proc/fs/nfsd/threads, but even the few nfsd processes that are active use less than 50% of their core each. The CPUs are shown as >90% idle in "top" on client and server during the read phase.
>>>>>
>>>>> I've tried:
>>>>> * CentOS 7.5 and 7.6 kernels (3.10.0-...) on client and server; and Ubuntu 18 with 4.18 kernel on server side
>>>>> * TCP & RDMA
>>>>> * Mounted as NFSv3/v4.1/v4.2
>>>>> * Increased tcp_slot_table_entries to 1024
>>>>>
>>>>> ...but all that didn't change the fact that only 4 nfsd processes are active on the server and thus I'm getting the same result already if /proc/fs/nfsd/threads is set to only 4 instead of 64.
>>>>>
>>>>> Any pointer to how I can overcome this limit will be greatly appreciated.
>>>>>
>>>>> Thanks in advance
>>>>>
>>>>> Sven
>>>>>
>>>> --
>>>> Chuck Lever
>>> --
>>> Chuck Lever
> --
> Chuck Lever
>
>
>
