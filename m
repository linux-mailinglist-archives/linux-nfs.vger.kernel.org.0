Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3CDE57FA
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2019 04:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfJZCEc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Oct 2019 22:04:32 -0400
Received: from p3plsmtpa09-09.prod.phx3.secureserver.net ([173.201.193.238]:46806
        "EHLO p3plsmtpa09-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbfJZCEc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Oct 2019 22:04:32 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id OBRLiGCRVSBHuOBROiWWGQ; Fri, 25 Oct 2019 19:04:30 -0700
Subject: Re: [PATCH v1 6/6] xprtrdma: Pull up sometimes
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
 <20191017183152.2517.67599.stgit@oracle-102.nfsv4bat.org>
 <f5075a20-7c9a-773f-e76b-11cba1ab0f16@talpey.com>
 <E1BB2B60-6DE2-47FD-92BA-ED9011C51661@oracle.com>
 <3ef2c12c-cc88-6ac6-25cd-99ef162f70a1@talpey.com>
 <EC70F961-3062-4079-A1F0-54B53C6B861B@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <e3b603cd-d0ca-de38-0368-f760e7a24fe4@talpey.com>
Date:   Fri, 25 Oct 2019 22:04:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <EC70F961-3062-4079-A1F0-54B53C6B861B@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBpKGyAkOuUb8eQBV5AM/SJVhgTGFt4I8pj93JQAPsZiOWMbVh1tPZrwIsnRZ9+PQhfZ6wDxOioc2zSc0x2FsJBN4RuLaQEOqCA1lUXb/311Wb5sifCp
 o+o27grav9HO5E8rKEHKJEjk+ioHJVKNxJglFbUMOAIvRYoA1uvIND0Q+FKBj+eM38t06ENonFbntu6Am8D82vEB8OM9DUnrHhqCvb7r3mPnKfq0K5oOzJJf
 Qu5tyyi+d9KsBUEEeGJsBA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/22/2019 12:08 PM, Chuck Lever wrote:
> 
> 
>> On Oct 19, 2019, at 12:36 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 10/18/2019 7:34 PM, Chuck Lever wrote:
>>> Hi Tom-
>>>> On Oct 18, 2019, at 4:17 PM, Tom Talpey <tom@talpey.com> wrote:
>>>>
>>>> On 10/17/2019 2:31 PM, Chuck Lever wrote:
>>>>> On some platforms, DMA mapping part of a page is more costly than
>>>>> copying bytes. Restore the pull-up code and use that when we
>>>>> think it's going to be faster. The heuristic for now is to pull-up
>>>>> when the size of the RPC message body fits in the buffer underlying
>>>>> the head iovec.
>>>>> Indeed, not involving the I/O MMU can help the RPC/RDMA transport
>>>>> scale better for tiny I/Os across more RDMA devices. This is because
>>>>> interaction with the I/O MMU is eliminated, as is handling a Send
>>>>> completion, for each of these small I/Os. Without the explicit
>>>>> unmapping, the NIC no longer needs to do a costly internal TLB shoot
>>>>> down for buffers that are just a handful of bytes.
>>>>
>>>> This is good stuff. Do you have any performance data for the new
>>>> strategy, especially latencies and local CPU cycles per byte?
>>> Saves almost a microsecond of RT latency on my NFS client that uses
>>> a real Intel IOMMU. On my other NFS client, the DMA map operations
>>> are always a no-op. This savings applies only to NFS WRITE, of course.
>>> I don't have a good benchmark for cycles per byte. Do you have any
>>> suggestions? Not sure how I would account for cycles spent handling
>>> Send completions, for example.
>>
>> Cycles per byte is fairly simple but like all performance measurement
>> the trick is in the setup. Because of platform variations, it's best
>> to compare results on the same hardware. The absolute value isn't as
>> meaningful. Here's a rough sketch of one approach.
>>
>> - Configure BIOS and OS to hold CPU frequency constant:
>>   - ACPI C-states off
>>   - Turbo mode off
>>   - Power management off (OS needs this too)
>>   - Anything else relevant to clock variation
>> - Hyperthreading off
>>   - (hyperthreads don't add work linearly)
>> - Calculate core count X clock frequency
>>   - (e.g. 8 X 3GHz = 24G cycles/sec)
>>
>> Now, use a benchmark which runs the desired workload and reports %CPU.
>> For a given interval, record the total bytes transferred, time spent,
>> and CPU load. (e.g. 100GB, 100 sec, 20%).
>>
>> Finally, compute CpB (the 1/sec terms cancel out):
>> 20% x 24Gcps = 4.8G cps
>> 100GB / 100s = 1G bps
>> 4.8Gcps / 1 GBps = 4.8cpb
>>
>> Like I said, it's rough, but surprisingly telling. A similar metric
>> is cycles per IOP, and since you're focusing on small i/o with this
>> change, it might also be an interesting calculation. Simply replace
>> total bytes/sec with IOPS.
> 
> Systems under test:
> 
> 	• 12 Haswell cores x 1.6GHz = 19.2 billion cps
> 	• Server is exporting a tmpfs filesystem
> 	• Client and server using CX-3 Pro on 56Gbps InfiniBand
> 	• Kernel is v5.4-rc4
> 	• iozone -M -+u -i0 -i1 -s1g -r1k -t12 -I
> 
> The purpose of this test is to compare the two kernels, not to publish an absolute performance value. Both kernels below have a number of CPU-intensive debugging options enabled, which might tend to increase CPU cycles per byte or per I/O, and might also amplify the differences between the two kernels.
> 
> 
> 
> *** With DMA-mapping kernel (confirmed after test - total pull-up was zero bytes):
> 
> WRITE tests:
> 
> 	• Write test: CPU Utilization: Wall time  496.136    CPU time  812.879    CPU utilization 163.84 %
> 	• Re-write test: CPU utilization: Wall time  500.266    CPU time  822.810    CPU utilization 164.47 %

Ah, the math I suggested earlier needs a different approah for these
absolute utilizations. The >100% numbers indicate these are per-core,
so 164% means 1.64 cores' worth of load. The math I suggested is for
relative, where the core count is corrected to 100% total.

For these, ignore the core count, just take the frequency and multiply
by the percent. This means your cpb and cpio numbers are 12X the value.
It's no big deal since we're just comparing before/after though.

> Final mountstats results:
> 
> WRITE:
>      25161863 ops (50%)
>      avg bytes sent per op: 1172    avg bytes received per op: 136
>      backlog wait: 0.094913     RTT: 0.048245     total execute time: 0.213270 (milliseconds)
> 
> Based solely on the iozone Write test:
> 12 threads x 1GB file = 12 GB transferred
> 12 GB / 496 s = 25973227 Bps
> 19.2 billion cps / 25973227 Bps = 740 cpB @ 1KB I/O
> 
> Based on both the iozone Write and Re-write tests:
> 25161863 ops / 996 s = 25263 IOps
> 19.2 billion cps / 25263 IOps = 760004 cpIO

So, 62cpb and and 63Kcpio, corrected. Seems a bit high, but as I said
earlier, it's hard to compare across platforms.

> READ tests:
> 
> 	• Read test: CPU utilization: Wall time  451.762    CPU time  826.888    CPU utilization 183.04 %
> 	• Re-read test: CPU utilization: Wall time  452.543    CPU time  827.575    CPU utilization 182.87 %
> 
> Final mountstats results:
> 
> READ:
>      25146066 ops (49%)
>      avg bytes sent per op: 140    avg bytes received per op: 1152
>      backlog wait: 0.092140     RTT: 0.045202     total execute time: 0.205996 (milliseconds)
> 
> Based solely on the iozone Read test:
> 12 threads x 1GB file = 12 GB transferred
> 12 GB / 451 s = 28569627 Bps
> 19.2 billion cps / 28569627 Bps = 672 cpB @ 1KB I/O
> 
> Based on both the iozone Read and Re-read tests:
> 25146066 ops / 903 s = 27847 IOps
> 19.2 billion cps / 27847 IOps = 689481 cpIO
> 
> 
> 
> *** With pull-up kernel (confirmed after test - total pull-up was 25763734528 bytes):
> 
> WRITE tests:
> 	• Write test: CPU Utilization: Wall time  453.318    CPU time  839.581    CPU utilization 185.21 %
> 	• Re-write test: CPU utilization: Wall time  458.717    CPU time  850.335    CPU utilization 185.37 %
> 
> Final mountstats results:
> 
> WRITE:
>            25159897 ops (50%)
>          avg bytes sent per op: 1172     avg bytes received per op: 136
>          backlog wait: 0.080036  RTT: 0.049674   total execute time: 0.183426 (milliseconds)
> 
> Based solely on the iozone Write test:
> 12 threads x 1GB file = 12 GB transferred
> 12 GB / 453 s = 28443492 Bps
> 19.2 billion cps / 28443492 Bps = 675 cpB @ 1KB I/O
> 
> Based on both the iozone Write and Re-write tests:
> 25159897 ops / 911 s = 27617 IOps
> 19.2 billion cps / 27617 IOps = 695223 cpIO
> 
> 
> READ tests:
> 
> 	• Read test: CPU utilization: Wall time  451.248    CPU time  834.203    CPU utilization 184.87 %
> 	• Re-read test: CPU utilization: Wall time  451.113    CPU time  834.302    CPU utilization 184.94 %
> 
> Final mountstats results:
> 
> READ:
>      25149527 ops (49%)
>      avg bytes sent per op: 140    avg bytes received per op: 1152
>      backlog wait: 0.091011     RTT: 0.045790     total execute time: 0.203793 (milliseconds)
> 
> Based solely on the iozone Read test:
> 12 threads x 1GB file = 12 GB transferred
> 12 GB / 451 s = 28569627 Bps
> 19.2 billion cps / 28569627 Bps = 672 cpB @ 1KB I/O
> 
> Based on both the iozone Read and Re-read tests:
> 25149527 ops / 902 s = 27881 IOps
> 19.2 billion cps / 27881 IOps = 688641 cpIO
> 
> 
> 
> *** Analysis:
> 
> For both kernels, the READ tests are close. This demonstrates that the patch does not have any gross effects on the READ path, as expected.

Well, close, but noticably lower in the pullup approach. This bears
out your suspicion that the IOMMU is not a trivial cost. It's also
likely to be a single-threading point, which will cause queuing as
well as overhead. Of course, the cost may be worth it, for security,
or scatter/gather optimization, etc. But for small i/o, the pullup
is a simple and effective approach.

> The WRITE tests are more remarkable.
> 	• Mean total execute time per WRITE RPC decreases by about 30 microseconds. Almost half of that is decreased backlog wait.
> 	• Mean round-trip time increases by a microsecond and a half. My earlier report that RT decreased by a microsecond was based on a QD=1 direct latency measure.
> 	• For 1KB WRITE: IOPS, Cycles per byte written and Cycles per I/O are now within spitting distance of the same metrics for 1KB READ.

Excellent result. The backlog wait may be in part avoiding the IOMMU
programming, and queuing on it before mapping. Bringing the numbers
close to READ corroborates this. I assume you are using RoCE or IB,
which doesn't require remote registration of the source buffers? The
pullup would improve those even more.

Curious that the RTT goes up by such a large number. It seems really
high. This might become a noticable penalty on single-threaded
(metadata) workloads.

Tom.
