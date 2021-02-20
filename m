Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7351532071D
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 21:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBTUe3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Feb 2021 15:34:29 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:45452 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhBTUe0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Feb 2021 15:34:26 -0500
X-Greylist: delayed 1192 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Feb 2021 15:34:25 EST
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lDYdP-0001Ob-Ez; Sat, 20 Feb 2021 20:13:47 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lDYdN-0007Q5-1O; Sat, 20 Feb 2021 20:13:47 +0000
Subject: Re: NFS Caching broken in 4.19.37
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        940821@bugs.debian.org, linux-nfs@vger.kernel.org,
        bfields@fieldses.org, chuck.lever@oracle.com
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
 <YDFrN0rZAJBbouly@eldamar.lan>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <af5cebbd-74c9-9345-9fe8-253fb96033f6@cambridgegreys.com>
Date:   Sat, 20 Feb 2021 20:13:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDFrN0rZAJBbouly@eldamar.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 20/02/2021 20:04, Salvatore Bonaccorso wrote:
> Hi,
>
> On Mon, Jul 08, 2019 at 07:19:54PM +0100, Anton Ivanov wrote:
>> Hi list,
>>
>> NFS caching appears broken in 4.19.37.
>>
>> The more cores/threads the easier to reproduce. Tested with identical
>> results on Ryzen 1600 and 1600X.
>>
>> 1. Mount an openwrt build tree over NFS v4
>> 2. Run make -j `cat /proc/cpuinfo | grep vendor | wc -l` ; make clean in a
>> loop
>> 3. Result after 3-4 iterations:
>>
>> State on the client
>>
>> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>>
>> total 8
>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>>
>> State as seen on the server (mounted via nfs from localhost):
>>
>> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>> total 12
>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
>>
>> Actual state on the filesystem:
>>
>> ls -laF /exports/work/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>> total 12
>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
>>
>> So the client has quite clearly lost the plot. Telling it to drop caches and
>> re-reading the directory shows the file present.
>>
>> It is possible to reproduce this using a linux kernel tree too, just takes
>> much more iterations - 10+ at least.
>>
>> Both client and server run 4.19.37 from Debian buster. This is filed as
>> debian bug 931500. I originally thought it to be autofs related, but IMHO it
>> is actually something fundamentally broken in nfs caching resulting in cache
>> corruption.
> According to the reporter downstream in Debian, at
> https://bugs.debian.org/940821#26 thi seem still reproducible with
> more recent kernels than the initial reported. Is there anything Anton
> can provide to try to track down the issue?
>
> Anton, can you reproduce with current stable series?

100% reproducible with any kernel from 4.9 to 5.4, stable or backports. 
It may exist in earlier versions, but I do not have a machine with 
anything before 4.9 to test at present.

 From 1-2 make clean && make  cycles to one afternoon depending on the 
number of machine cores. More cores/threads the faster it does it.

I tried playing with protocol minor versions, caching options, etc - it 
is still reproducible for any nfs4 settings as long as there is client 
side caching of metadata.

A.

>
> Regards,
> Salvatore
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

