Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03849B8D95
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408463AbfITJZV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 05:25:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35346 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408445AbfITJZV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 05:25:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so6020080wrt.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uzBemiGSPMgCYulSrEhBIs2KR1WrhvL59odhojpz0BU=;
        b=BF2hy+yuf5PYaf2rawh7EBYi6TfMoY3FVZSWfs2qFzJlIK+sBZRQYI4dkFBBa/hDOx
         uRILHpi0H4JvQrs+CtnmbvhS/vzLo8IaRvLNYhHZRruF4X0tXvrLn6Qr2GExdurnO5tY
         WYnYWtrvZOAsjoslAWjvhGLnNC6z+cxIVCGVc+sQ1FH4YLRo441PrPJ8LslSaaDOWemO
         jOtFz0CTYotrcgW/zWaj2n7PZ/5O8vMhC1XhsFVzEPpsFvIrVy8C3saF2b0U82w31vsq
         sK85eap59/Yb3OJkjNduSf2nFxTWEl2FIPmhzQqK6angKRnHgjy6tOlSVkQMx9BbBvBJ
         v8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uzBemiGSPMgCYulSrEhBIs2KR1WrhvL59odhojpz0BU=;
        b=JTEdz1pcUdrnCXEGBAsamQjVZ44A59xeAYV5Yv4Dqtb+Dd1r0rFFm9xucGSnHoZvY3
         2UJE9stGHxvSZmmzRyOFRcLOdQ8a3AOvtdEgr2KfI2F/GO4yvDxwKD3+SBlROIoJHr5C
         5Bn6jAuJOUJO14s7pu2GDYuLdeX5aKH1Act9Db52RkYIPgypivC2xdosxGBSRxZtoCJa
         NOlsz0lho14DoVklGZrvCimygd/jzyqwt3tohaAEUh0GDN6TiuGz4HvFJ5vHwDOJ0cWd
         rqKGOWytLIWt+oZRrpWixM+R6LBN83C/cw44+JLbMog1pwyfxpPJGLusioROEM4TERyn
         E5/w==
X-Gm-Message-State: APjAAAUSU4VV2sTMHu4OLWkZZvTxniSAkL1zccpIDL2i8bh+6WJZWszW
        twdtI4n1ctWsIQw9mKrnziy8/5Mk
X-Google-Smtp-Source: APXvYqw0yXDX0KayAT2UXBh7Zw1g1MG4UzlbA/3NK0/h/gyBtco7F5w4WkiaEEnbeqq7EOYEW4ZNng==
X-Received: by 2002:adf:ecc6:: with SMTP id s6mr11003209wro.333.1568971518748;
        Fri, 20 Sep 2019 02:25:18 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id s12sm1675642wrn.90.2019.09.20.02.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 02:25:18 -0700 (PDT)
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
To:     Trond Myklebust <trondmy@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
 <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
 <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
 <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
 <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
 <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
 <5601db40-ee2f-262d-7d01-5c589c9a07eb@gmail.com>
 <d7ea48b4cd665eced45783bf94d6b1ff1f211960.camel@hammerspace.com>
 <20190919211912.GA21865@cosmos.ssec.wisc.edu>
 <503c22ad34b3f3a15015b7384bcad469b2899cb4.camel@hammerspace.com>
 <20190919221601.GA30751@cosmos.ssec.wisc.edu>
From:   Alkis Georgopoulos <alkisg@gmail.com>
Message-ID: <0213704b-3930-5be6-bd3d-dbaabc24a270@gmail.com>
Date:   Fri, 20 Sep 2019 12:25:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919221601.GA30751@cosmos.ssec.wisc.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/20/19 1:16 AM, Daniel Forrest wrote:
>>> What may be happening here is something I have noticed with glibc.
>>>
>>> - statfs reports the rsize/wsize as the block size of the filesystem.
>>>
>>> - glibc uses the block size as the default buffer size for
>>> fread/fwrite.
>>>
>>> If an application is using fread/fwrite on an NFS mounted file with
>>> an rsize/wsize of 1M it will try to fill a 1MB buffer.
>>>
>>> I have often changed mounts to use rsize/wsize=64K to alleviate this.
>>
>> That sounds like an abuse of the filesystem block size. There is
>> nothing in the POSIX definition of either fread() or fwrite() that
>> requires glibc to do this:
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/fread.html
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/fwrite.html
>>
> 
> It looks like this was fixed in glibc 2.25:
> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=4099


This is likely not the exact issue I'm experiencing, as I'm testing e.g.
with glibc 2.27-3ubuntu1 on Ubuntu 18.04 and kernel 5.0.

New benchmark, measuring the boot time of a netbooted client,
from right after the kernel is loaded to the display manager screen:

1) On 10 Mbps:
a) tcp,timeo=600,rsize=32K: 304 secs
b) tcp,timeo=600,rsize=1M: 618 secs

2) On 100 Mbps:
a) tcp,timeo=600,rsize=32K: 40 secs
b) tcp,timeo=600,rsize=1M: 84 secs

3) On 1000 Mbps:
a) tcp,timeo=600,rsize=32K: 20 secs
b) tcp,timeo=600,rsize=1M: 24 secs

32K is always faster, even on full gigabit.
Disk access on gigabit was *significantly* faster to result in 4 seconds 
lower boot time. In the 10/100 cases, rsize=1M is pretty much unusable.
There are no writes involved, they go in a local tmpfs/overlayfs.
Would it make sense for me to measure the *boot bandwidth* in each case, 
to see if more things (readahead) are downloaded with rsize=1M?

I can do whatever benchmarks and test whatever parameters you tell me 
to, but I do not know the NFS/kernel internals to be able to explain why 
this happens.

The reason I investigated this is because I developed the new version of 
ltsp.org (GPL netbooting software), where we switched from 
squashfs-over-NBD to squashfs-over-NFS, and netbooting was extremely 
slow until I lowered rsize to 32K, so I thought I'd share my findings in 
case it makes a better default for everyone (or reveals a problem 
elsewhere).
With rsize=32K, squashfs-over-NFS is as speedy as squashfs-over-NBD, but 
a lot more stable.

Of course the same rsize findings apply for NFS /home too (without 
nfsmount), or for just transferring large or small files, not just for /.

Btw, 
https://www.kernel.org/doc/Documentation/filesystems/nfs/nfsroot.txt 
says the kernel nfsroot defaults are timeo=7,rsize=4096,wsize=4096. This 
is about the internal kernel netbooting support, not using klibc 
nfsmount; but I haven't tested it as it would involve compiling a kernel 
with my NIC driver.

Thank you,
Alkis Georgopoulos
LTSP developer
