Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39057320A0C
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 12:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhBULjm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 06:39:42 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:46468 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhBULjl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Feb 2021 06:39:41 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lDn4g-000440-JL; Sun, 21 Feb 2021 11:38:54 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lDn4e-0002LU-7v; Sun, 21 Feb 2021 11:38:54 +0000
Subject: Re: NFS Caching broken in 4.19.37
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "940821@bugs.debian.org" <940821@bugs.debian.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
 <YDFrN0rZAJBbouly@eldamar.lan>
 <af5cebbd-74c9-9345-9fe8-253fb96033f6@cambridgegreys.com>
 <BEBA9809-373A-4172-B4AD-E19D82E56DB1@oracle.com>
 <YDIkH6yVgLoALT6x@eldamar.lan>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <9305dc03-5557-5e18-e5c9-aaf886a03fff@cambridgegreys.com>
Date:   Sun, 21 Feb 2021 11:38:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDIkH6yVgLoALT6x@eldamar.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21/02/2021 09:13, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Sat, Feb 20, 2021 at 08:16:26PM +0000, Chuck Lever wrote:
>>
>>
>>> On Feb 20, 2021, at 3:13 PM, Anton Ivanov <anton.ivanov@cambridgegreys.com> wrote:
>>>
>>> On 20/02/2021 20:04, Salvatore Bonaccorso wrote:
>>>> Hi,
>>>>
>>>> On Mon, Jul 08, 2019 at 07:19:54PM +0100, Anton Ivanov wrote:
>>>>> Hi list,
>>>>>
>>>>> NFS caching appears broken in 4.19.37.
>>>>>
>>>>> The more cores/threads the easier to reproduce. Tested with identical
>>>>> results on Ryzen 1600 and 1600X.
>>>>>
>>>>> 1. Mount an openwrt build tree over NFS v4
>>>>> 2. Run make -j `cat /proc/cpuinfo | grep vendor | wc -l` ; make clean in a
>>>>> loop
>>>>> 3. Result after 3-4 iterations:
>>>>>
>>>>> State on the client
>>>>>
>>>>> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>>>>>
>>>>> total 8
>>>>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>>>>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>>>>>
>>>>> State as seen on the server (mounted via nfs from localhost):
>>>>>
>>>>> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>>>>> total 12
>>>>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>>>>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>>>>> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
>>>>>
>>>>> Actual state on the filesystem:
>>>>>
>>>>> ls -laF /exports/work/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>>>>> total 12
>>>>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>>>>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>>>>> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
>>>>>
>>>>> So the client has quite clearly lost the plot. Telling it to drop caches and
>>>>> re-reading the directory shows the file present.
>>>>>
>>>>> It is possible to reproduce this using a linux kernel tree too, just takes
>>>>> much more iterations - 10+ at least.
>>>>>
>>>>> Both client and server run 4.19.37 from Debian buster. This is filed as
>>>>> debian bug 931500. I originally thought it to be autofs related, but IMHO it
>>>>> is actually something fundamentally broken in nfs caching resulting in cache
>>>>> corruption.
>>>> According to the reporter downstream in Debian, at
>>>> https://bugs.debian.org/940821#26 thi seem still reproducible with
>>>> more recent kernels than the initial reported. Is there anything Anton
>>>> can provide to try to track down the issue?
>>>>
>>>> Anton, can you reproduce with current stable series?
>>>
>>> 100% reproducible with any kernel from 4.9 to 5.4, stable or backports. It may exist in earlier versions, but I do not have a machine with anything before 4.9 to test at present.
>>
>> Confirming you are varying client-side kernels. Should the Linux
>> NFS client maintainers be Cc'd?
> 
> Ok, agreed. Let's add them as well. NFS client maintainers any ideas
> on how to trackle this?

This is not observed with Debian backports 5.10 package

uname -a
Linux madding 5.10.0-0.bpo.3-amd64 #1 SMP Debian 5.10.13-1~bpo10+1 
(2021-02-11) x86_64 GNU/Linux

I left the testcase running for ~ 4 hours on a 6core/12thread Ryzen. It 
should have blown up 10 times by now.

So one of the commits between 5.4 and 5.10.13 fixed it.

If nobody can think of a particular commit which fixes it, I can try 
dissecting it during the week.

A.

> 
>>
>>>  From 1-2 make clean && make  cycles to one afternoon depending on the number of machine cores. More cores/threads the faster it does it.
>>>
>>> I tried playing with protocol minor versions, caching options, etc - it is still reproducible for any nfs4 settings as long as there is client side caching of metadata.
>>>
>>> A.
>>>
>>>>
>>>> Regards,
>>>> Salvatore
>>>>
>>>
>>> -- 
>>> Anton R. Ivanov
>>> Cambridgegreys Limited. Registered in England. Company Number 10273661
>>> https://www.cambridgegreys.com/
>>
>> --
>> Chuck Lever
> 
> Regards,
> Salvatore
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
