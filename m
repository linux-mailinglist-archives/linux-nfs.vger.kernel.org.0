Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD43264D4
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 16:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZPlJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 10:41:09 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:58668 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhBZPlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Feb 2021 10:41:08 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lFfDz-0002o5-PW; Fri, 26 Feb 2021 15:40:16 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lFfDx-0003yv-ES; Fri, 26 Feb 2021 15:40:15 +0000
Subject: Re: NFS Caching broken in 4.19.37
To:     Timo Rothenpieler <timo@rothenpieler.org>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "940821@bugs.debian.org" <940821@bugs.debian.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
 <YDFrN0rZAJBbouly@eldamar.lan>
 <af5cebbd-74c9-9345-9fe8-253fb96033f6@cambridgegreys.com>
 <BEBA9809-373A-4172-B4AD-E19D82E56DB1@oracle.com>
 <YDIkH6yVgLoALT6x@eldamar.lan>
 <9305dc03-5557-5e18-e5c9-aaf886a03fff@cambridgegreys.com>
 <20210221143712.GA15975@fieldses.org>
 <f0edfaf5-457d-2334-ee4f-a6bf9d13917b@cambridgegreys.com>
 <1b701f2b-d185-dd30-0aca-ba6d280221d5@rothenpieler.org>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <72e16f18-d4ae-f963-fd09-5f1fa6885a1d@cambridgegreys.com>
Date:   Fri, 26 Feb 2021 15:40:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1b701f2b-d185-dd30-0aca-ba6d280221d5@rothenpieler.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26/02/2021 15:03, Timo Rothenpieler wrote:
> I think I can reproduce this, or something that at least looks very 
> similar to this, on 5.10. Namely on 5.10.17 (On both Client and Server).

I think this is a different issue - see below.

>
> We are running slurm, and since a while now (coincides with updating 
> from 5.4 to 5.10, but a whole bunch of other stuff was updated at the 
> same time, so it took me a while to correlate this) the logs it writes 
> have been truncated, but only while they're being observed on the 
> client, using tail -f or something like that.
>
> Looks like this then:
>
> On Server:
>> store01 /srv/export/home/users/timo/TestRun # ls -l slurm-41101.out
>> -rw-r--r-- 1 timo timo 1931 Feb 26 15:46 slurm-41101.out
>> store01 /srv/export/home/users/timo/TestRun # wc -l slurm-41101.out
>> 61 slurm-41101.out
>
> On Client:
>> timo@login01 ~/TestRun $ ls -l slurm-41101.out
>> -rw-r--r-- 1 timo timo 1931 Feb 26 15:46 slurm-41101.out
>> timo@login01 ~/TestRun $ wc -l slurm-41101.out
>> 24 slurm-41101.out
>
> See https://gist.github.com/BtbN/b9eb4fc08ccc53bb20087bce0bf9f826 for 
> the respective file-contents.
>
> If I run the same test job, wait until its done, and then look at its 
> slurm.out file, it matches between NFS Client and Server.
> If I tail -f the slurm.out on an NFS client, the file stops getting 
> updated on the client, but keeps getting more logs written to it on 
> the NFS server.
>
> The slurm.out file is being written to by another NFS client, which is 
> running on one of the compute nodes of the system. It's being reads 
> from a login node.

These are two different clients, then what you see is possible on NFS 
with client side caching. If you have multiple clients reading/writing 
to the same files you usually need to tune the caching options and/or 
use locking. I suspect that if you leave it for a while (until the cache 
expires) it will sort itself out.

In my test-case it is just one client, it missed a file deletion and 
nothing short of an unmount and remount fixes that. I have waited for 30 
mins+. It does not seem to refresh or expire. I also see the opposite 
behavior - the bug shows up on 4.x up to at least 5.4. I do not see it 
on 5.10.

Brgds,


>
>
>
>
> Timo
>
>
> On 21.02.2021 16:53, Anton Ivanov wrote:
>> Client side. This seems to be an entirely client side issue.
>>
>> A variety of kernels on the clients starting from 4.9 and up to 5.10 
>> using 4.19 servers. I have observed it on a 4.9 client versus 4.9 
>> server earlier.
>>
>> 4.9 fails, 4.19 fails, 5.2 fails, 5.4 fails, 5.10 works.
>>
>> At present the server is at 4.19.67 in all tests.
>>
>> Linux jain 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 
>> (2019-11-11) x86_64 GNU/Linux
>>
>> I can set-up a couple of alternative servers during the week, but so 
>> far everything is pointing towards a client fs cache issue, not a 
>> server one.
>>
>> Brgds,
>>
>
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

