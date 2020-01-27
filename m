Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB14714A8E6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 18:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgA0R1u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 12:27:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43202 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0R1t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 12:27:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so5470993pgc.10
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2020 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=excelero-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=omQ/TDE9e/B26RqVa4ziK4+mtGeVsRP1bbaRrDKAuNA=;
        b=XmTirus0XCf9acSKrm4AjUjTm2uaJ0woFNj9F7+URRgw8I3kS4jLtsUBOCgKMp2lg7
         t0vuB7uOKltR8v8+hBspfAfOFrC6Csqk8gZkTJclPKoRQJH4G3QwO24eZwSJCH/i+4ut
         DClJ0h58ZvB5gOrFQM7TcJ50hRGpaStn05H/ff6r7tUqy5x74t8mh6/aWbDyeIeqqHq+
         4LBrS1i0o/z/FpxUvRNDXYiv3FHzw8j9sDhlWzz57PyzIuo0xSsvyLXmoFfSoVOQ+kUl
         jTxfYgkkEUNfcwxRh5G9yN5DHvgC9u2p7J7Y6KXeZg1EmGeWRHAB+SG9KsSAHuAXzEvB
         orKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=omQ/TDE9e/B26RqVa4ziK4+mtGeVsRP1bbaRrDKAuNA=;
        b=Dwluc9+PHkNdPtn6Zh3BXHyzk8XfYnd/rhPbnigbBN/HdFsv6cDZX76xaY5yWaWJeX
         y7924NPQZumIQ5Of3q8fh38e/n49GARcBRx4QraWQI5AjrwUCk34pA2Pmbx2AMiGvsq2
         tNILOsU+cUtcz2YONsIYGyFWY9ep0GQoesRuSKKqACl3pBMQslFe1jMiXBr4sg97ChaP
         BEHAr3t4mjbAobZ74ahUNQaYvzfAv9aMe8SKtemXu9nRyJZxRC8wpFpQ1gGe20UWNPqR
         zmAJnrkEr2WGOwihmJORZyCJuZ/2alkOKD/ArTpeZi9Ehu6T3nimBXkwHMdF5aDXV+2X
         K1Fg==
X-Gm-Message-State: APjAAAWhvJgff6Kdln9T9ekWS5s+b6LJMicvD6K4H1MtXh/INq9zNxiX
        HOEXoHJcS/O4JFTszNUjZ+CvKIe6sEE=
X-Google-Smtp-Source: APXvYqw21HPpiVF2k9XQjy8cN9oT6IDGrknWIeTcLUwzwVF4ltp/ZCGJ6K1I5NP4v4zmxNMq1xNu8w==
X-Received: by 2002:a62:7b54:: with SMTP id w81mr17100575pfc.127.1580146068383;
        Mon, 27 Jan 2020 09:27:48 -0800 (PST)
Received: from [192.168.0.41] (dslb-088-078-158-079.088.078.pools.vodafone-ip.de. [88.78.158.79])
        by smtp.gmail.com with ESMTPSA id b1sm16365976pjw.4.2020.01.27.09.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 09:27:47 -0800 (PST)
Subject: Re: Remove single NFS client performance bottleneck: Only 4 nfsd
 active
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <a8a528c7-80bd-befc-59f8-00135d85a2bf@excelero.com>
 <F82F3FA8-4E2A-4014-A052-A0367562A956@oracle.com>
 <2D125E5E-F97D-4F52-89A9-C499CC7E7A5D@oracle.com>
From:   Sven Breuner <sven@excelero.com>
Message-ID: <0474b0f7-ec6d-9a02-2cd0-a69339e7cae5@excelero.com>
Date:   Mon, 27 Jan 2020 18:27:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <2D125E5E-F97D-4F52-89A9-C499CC7E7A5D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

thanks for looking into this. (Answers inline...)

Chuck Lever wrote on 27.01.2020 15:12:
>
>> On Jan 27, 2020, at 9:06 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> Hi Sven-
>>
>>> On Jan 26, 2020, at 6:41 PM, Sven Breuner <sven@excelero.com> wrote:
>>>
>>> Hi,
>>>
>>> I'm using the kernel NFS client/server and am trying to read as many small files per second as possible from a single NFS client, but seem to run into a bottleneck.
>>>
>>> Maybe this is just a tunable that I am missing, because the CPUs on client and server side are mostly idle, the 100Gbit (RoCE) network links between client and server are also mostly idle and the NVMe drives in the server are also mostly idle (and the server has enough RAM to easily fit my test data set in the ext4/xfs page cache, but also a 2nd read of the data set from the RAM cache doesn't change the result much).
>>>
>>> This is my test case:
>>> # Create 1.6M 10KB files through 128 mdtest processes in different directories...
>>> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d /mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -C
>>>
>>> # Read all the files through 128 mdtest processes (the case that matters primarily for my test)...
>>> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d /mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -E
>>>
>>> The result is about 20,000 file reads per sec, so only ~200MB/s network throughput.
>> What is the typical size of the NFS READ I/Os on the wire?
The application is fetching each full 10KB file in a single read op (so 
"read(fd, buf, 10240)" ) and NFS wsize/rsize is 512KB.
>> Are you sure your mpirun workload is generating enough parallelism?
Yes, MPI is only used to start the 128 processes and aggregate the performance 
results in the end. For the actual file read phase, all 128 processes run 
completely independent without any communication/synchronization. Each process 
is working in its own subdir with its own set of 10KB files.
(Running the same test directly on the local xfs of the NFS server box results 
in ~350,000 10KB file reads per sec after cache drop and >1 mio 10KB file reads 
per sec from page cache. Just mentioning this for the sake of completeness to 
show that this is not hitting a limit on the server side.)
> A couple of other thoughts:
>
> What's the client hardware like? NUMA? Fast memory? CPU count?

Client and server are dual socket Intel Xeon E5-2690 v4 @ 2.60GHz (14 cores per 
socket plus hyper threading), all 4 memory channels per socket populated with 
fastest possible DIMMs (DDR4 2400).

Also tried pool_mode auto/global/pernode on server side.

> Have you configured device interrupt affinity and used tuned
> to disable CPU sleep states, etc?

Yes, CPU power saving (frequency scaling) disabled. Tried tuned profiles 
latency-performance and and throughput-performance. Also tried irqbalance and 
mlnx_affinity.

All without any significant effect unfortunately.

> Have you properly configured your 100GbE switch and cards?
>
> I have a Mellanox SN2100 here and two hosts with CX-5 Ethernet.
> The configuration of the cards and switch is critical to good
> performance.
Yes, I can absolutely confirm that having this part of the config correct is 
critical for great performance :-) All configured with PFC and ECN and 
double-checked for packets to be tagged correctly and lossless in the RoCE case. 
The topology is simple: Client and server connected to same Mellanox switch, 
nothing else happening on the switch.
>
>
>>> I noticed in "top" that only 4 nfsd processes are active, so I'm wondering why the load is not spread across more of my 64 /proc/fs/nfsd/threads, but even the few nfsd processes that are active use less than 50% of their core each. The CPUs are shown as >90% idle in "top" on client and server during the read phase.
>>>
>>> I've tried:
>>> * CentOS 7.5 and 7.6 kernels (3.10.0-...) on client and server; and Ubuntu 18 with 4.18 kernel on server side
>>> * TCP & RDMA
>>> * Mounted as NFSv3/v4.1/v4.2
>>> * Increased tcp_slot_table_entries to 1024
>>>
>>> ...but all that didn't change the fact that only 4 nfsd processes are active on the server and thus I'm getting the same result already if /proc/fs/nfsd/threads is set to only 4 instead of 64.
>>>
>>> Any pointer to how I can overcome this limit will be greatly appreciated.
>>>
>>> Thanks in advance
>>>
>>> Sven
>>>
>> --
>> Chuck Lever
> --
> Chuck Lever
>
>
>
