Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0008119FD1
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2019 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEJPHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 May 2019 11:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJPHU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 10 May 2019 11:07:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E52C307D852;
        Fri, 10 May 2019 15:07:20 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3021461983;
        Fri, 10 May 2019 15:07:20 +0000 (UTC)
Subject: Re: [PATCH] nfs-utils: Change /var/run -> /run in systemd service
 files
From:   Steve Dickson <SteveD@RedHat.com>
To:     Orion Poplawski <orion@nwra.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <6a9ffa7d-f711-026f-d9f7-a680a86c553a@nwra.com>
 <29ea93aa-9f20-9d09-c135-99f5976704db@RedHat.com>
 <c32f477e-4389-6c97-573d-1faa45c2bcff@nwra.com>
 <f53b3ed0-0489-2b94-9f8d-d0120db0c0da@RedHat.com>
Message-ID: <6e64dc54-b230-b513-c3cd-06ec8710d5d5@RedHat.com>
Date:   Fri, 10 May 2019 11:07:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f53b3ed0-0489-2b94-9f8d-d0120db0c0da@RedHat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 10 May 2019 15:07:20 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/9/19 1:25 PM, Steve Dickson wrote:
> 
> 
> On 5/8/19 12:02 PM, Orion Poplawski wrote:
>> On 5/8/19 9:54 AM, Steve Dickson wrote:
>>>
>>>
>>> On 5/8/19 10:58 AM, Orion Poplawski wrote:
>>>> This fixes:
>>>>
>>>> /usr/lib/systemd/system/nfs-blkmap.service:10: PIDFile= references path below
>>>> legacy directory /var/run/, updating /var/run/blkmapd.pid → /run/blkmapd.pid;
>>>> please update the unit file accordingly.
>>> Shouldn't the apps also be updated? I know there is a symbolic 
>>> link... but just for completeness the pid files in both apps 
>>> should be updated as well. 
>>>
>>> steved.
>>
>> I thought about that - but was concerned about legacy systems that still use
>> /var/run.
> Any idea how long the symlink will be around? But I do see your point.
> 
> steved.
> 
>>
>>>>
>>>> Signed-off-by: Orion Poplawski <orion@nwra.com>
>>>> ---
>>>>  systemd/nfs-blkmap.service | 2 +-
>>>>  systemd/rpc-statd.service  | 2 +-
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
Committed.... 

steved.

>>>>
>>>> diff --git a/systemd/nfs-blkmap.service b/systemd/nfs-blkmap.service
>>>> index 2bbcee6..6aa45ba 100644
>>>> --- a/systemd/nfs-blkmap.service
>>>> +++ b/systemd/nfs-blkmap.service
>>>> @@ -9,7 +9,7 @@ PartOf=nfs-utils.service
>>>>
>>>>  [Service]
>>>>  Type=forking
>>>> -PIDFile=/var/run/blkmapd.pid
>>>> +PIDFile=/run/blkmapd.pid
>>>>  ExecStart=/usr/sbin/blkmapd
>>>>
>>>>  [Install]
>>>> diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
>>>> index 3e92cf7..095629f 100644
>>>> --- a/systemd/rpc-statd.service
>>>> +++ b/systemd/rpc-statd.service
>>>> @@ -13,5 +13,5 @@ IgnoreOnIsolate=yes
>>>>  [Service]
>>>>  Environment=RPC_STATD_NO_NOTIFY=1
>>>>  Type=forking
>>>> -PIDFile=/var/run/rpc.statd.pid
>>>> +PIDFile=/run/rpc.statd.pid
>>>>  ExecStart=/usr/sbin/rpc.statd
>>>> --
>>>> 1.8.3.1
>>>>
>>
>>
