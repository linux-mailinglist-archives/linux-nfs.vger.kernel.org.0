Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555A365984
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 15:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhDTNJd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 09:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230408AbhDTNJd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 09:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618924141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NxVNW6sFezox+6Bs83zQ3f65fUmafm9+q3WEF4me7Og=;
        b=h6YjQb/Yg7NS+0S+LHGRGvwSDdsjd5G58piyBpB0sSgeUSr6nZRFEy12BGUyCd46KnDrUZ
        kEAdzyigm45CvgwhzOCDNN3LbZLwBBFemzRJ0HCVcnNUe00wlCbBxLlWw//Fd6G8qNO2my
        Q1vFlJGLhJtRtHmazRvv0HR9cQspxNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-_aq_HI4eN1-ypjauk_Ke8g-1; Tue, 20 Apr 2021 09:08:54 -0400
X-MC-Unique: _aq_HI4eN1-ypjauk_Ke8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EC2B79EC0;
        Tue, 20 Apr 2021 13:08:53 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-232.phx2.redhat.com [10.3.113.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1281610F1;
        Tue, 20 Apr 2021 13:08:52 +0000 (UTC)
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Alice J Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
 <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
 <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
 <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
 <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
 <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
 <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <f0525973-a32c-32d4-4ccc-827acaa3c125@RedHat.com>
Date:   Tue, 20 Apr 2021 09:11:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/18/21 12:51 PM, Chuck Lever III wrote:
> 
> 
>> On Apr 17, 2021, at 1:50 PM, Steve Dickson <SteveD@RedHat.com> wrote:
>>
>>
>>
>> On 4/17/21 12:36 PM, Chuck Lever III wrote:
>>>
>>>
>>>> On Apr 17, 2021, at 12:18 PM, Steve Dickson <SteveD@RedHat.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/15/21 12:37 PM, Chuck Lever III wrote:
>>>>>
>>>>>
>>>>>> On Apr 15, 2021, at 11:33 AM, Steve Dickson <SteveD@RedHat.com> wrote:
>>>>>>
>>>>>> Hey Chuck! 
>>>>>>
>>>>>> On 4/14/21 7:26 PM, Chuck Lever III wrote:
>>>>>>> Hi Steve-
>>>>>>>
>>>>>>>> On Apr 14, 2021, at 2:10 PM, Steve Dickson <SteveD@redhat.com> wrote:
>>>>>>>>
>>>>>>>> ﻿This is a tweak of the patch set Alice Mitchell posted last July [1].
>>>>>>>
>>>>>>> That approach was dropped last July because it is not container-aware.
>>>>>>> It should be simple for someone to write a udev script that uses the
>>>>>>> existing sysfs API that can update nfs4_client_id in a namespace. I
>>>>>>> would prefer the sysfs/udev approach for setting nfs4_client_id,
>>>>>>> since it is container-aware and makes this setting completely
>>>>>>> automatic (zero touch).
>>>>>> As I said in in my cover letter, I see this more as introduction of
>>>>>> a mechanism more than a way to set the unique id.
>>>>>
>>>>> Yep, I got that.
>>>>>
>>>>> I'm not addressing the question of whether adding a
>>>>> mechanism to set a module parameter in nfs.conf is good
>>>>> or not. I'm saying nfs4_client_id is not an appropriate
>>>>> parameter to add to nfs.conf. Can you pick another
>>>>> module parameter as an example for your mechanism?
>>>> The request was to set that parameter...
>>>
>>> The cover letter and the quoted e-mail above state that
>>> you are just demonstrating a mechanism to set module
>>> parameters via nfs.conf. I guess that statement was not
>>> entirely accurate, then. Thanks for clarifying.
>> I was trying to keep the conversation off of what
>> was being set to how it was being set... 
>>
>> I had no idea the entire "options nfs" API is compromised
>> when it comes to containers... Not sure why... but I will
>> believe you...
> 
> Module parameters take effect for all namespaces. It's
> not just nfs.ko that has this issue.
Right... 
> 
> 
>>> If there's a bug report somewhere that requests a
>>> feature, it's normal practice to include a URL pointing
>>> to that report in the patch description.
>> I just assumed, since it had a customer case, the bz was 
>> private... it turns out not to be the case
>> https://bugzilla.redhat.com/show_bug.cgi?id=1801326
> 
>>>>>> Actual I have customers asking for this type
>>>>>> of functionality
> 
> Hrm. The reporter of 1801326 is dwyso, a Red Hat employee,
> not a customer.
> 
> Also, I see nothing that requires it to be set in nfs.conf.
> So what actual functionality is being requested, and why
> can't it be addressed with a udev script, which has been
> the design already in the works for many months?
The bz was open by a request of a customer... There is a
lot of info in bzs that are not public... 

Having a one, centralized place to configure NFS
I thought was a good idea... 

> 
> 
>>>>> Ask yourself why they might want it. It's probably because
>>>>> we don't set it correctly currently. If we have a way to
>>>>> automatically get it right every time, there's really no
>>>>> need for this setting to be exposed.
>>>> If we shouldn't expose it... Lets get rid of it...
>>>> You added the param in the fall 2012... If it hasn't
>>>> been used correctly or can't be used correctly for
>>>> all theses years... why does it exist?
>>>
>>> Because back then we didn't care about container awareness
>>> enough to make it an initial part of the feature. We were
>>> trying to address the problem of how to ensure that the
>>> nfs4_client_id is unique. But clearly it was only half a
>>> solution.
>> Right... I was just trying to build a mechanism to
>> set the value, and not worrying (yet) about what the
>> value is set to... 
>>
>> So at this point, all of the nfs kernel module parameter
>> can be set through the sysfs/udev interface?
> 
> The only module parameter that has been explicitly replaced
> is the one that sets nfs4_client_id, as far as I am aware.
> There might be some other settings available in /sys:
> 
> # ls /sys/module/nfsv4/parameters
> delegation_watermark  layoutstats_timer
> #
> 
> [cel@manet linux]$ git grep MODULE_PARM -- fs/nfs/
> fs/nfs/cache_lib.c:MODULE_PARM_DESC(cache_getent, "Path to the client cache upcall program");
> fs/nfs/cache_lib.c:MODULE_PARM_DESC(cache_getent_timeout, "Timeout (in seconds) after which "
> fs/nfs/dir.c:MODULE_PARM_DESC(nfs_access_max_cachesize, "NFS access maximum total cache length");
> fs/nfs/filelayout/filelayoutdev.c:MODULE_PARM_DESC(dataserver_retrans, "The  number of times the NFSv4.1 client "
> fs/nfs/filelayout/filelayoutdev.c:MODULE_PARM_DESC(dataserver_timeo, "The time (in tenths of a second) the "
> fs/nfs/flexfilelayout/flexfilelayout.c:MODULE_PARM_DESC(io_maxretrans, "The  number of times the NFSv4.1 client "
> fs/nfs/flexfilelayout/flexfilelayoutdev.c:MODULE_PARM_DESC(dataserver_retrans, "The  number of times the NFSv4.1 client "
> fs/nfs/flexfilelayout/flexfilelayoutdev.c:MODULE_PARM_DESC(dataserver_timeo, "The time (in tenths of a second) the "
> fs/nfs/namespace.c:MODULE_PARM_DESC(nfs_mountpoint_expiry_timeout,
> fs/nfs/super.c:MODULE_PARM_DESC(callback_nr_threads, "Number of threads that will be "
> fs/nfs/super.c:MODULE_PARM_DESC(nfs4_disable_idmapping,
> fs/nfs/super.c:MODULE_PARM_DESC(max_session_slots, "Maximum number of outstanding NFSv4.1 "
> fs/nfs/super.c:MODULE_PARM_DESC(max_session_cb_slots, "Maximum number of parallel NFSv4.1 "
> fs/nfs/super.c:MODULE_PARM_DESC(send_implementation_id,
> fs/nfs/super.c:MODULE_PARM_DESC(nfs4_unique_id, "nfs_client_id4 uniquifier string");
> fs/nfs/super.c:MODULE_PARM_DESC(recover_lost_locks,
> [cel@manet linux]$ git grep MODULE_PARM -- fs/nfsd/
> fs/nfsd/nfs4idmap.c:MODULE_PARM_DESC(nfs4_disable_idmapping,
> fs/nfsd/nfs4proc.c:MODULE_PARM_DESC(inter_copy_offload_enable,
> fs/nfsd/nfs4recover.c:MODULE_PARM_DESC(cltrack_prog, "Path to the nfsdcltrack upcall program");
> fs/nfsd/nfs4recover.c:MODULE_PARM_DESC(cltrack_legacy_disable,
> [cel@manet linux]$
> 
> Each of the above has to be considered on a case-by-case
> basis, IMO.
> 
> 
>> If that is the cause... have the variables in 
>> nfs.conf create sysfs/udev file would work better?
> 
> Seems to me we have the same argument for a separate file
> to store the nfs4_unique_id that we have for breaking
> /etc/exports into a directory of individual files: no
> parsing is necessary. Scripts and applications can simply
> read the string right out of the file, or update it just
> by writing the string into that file.
I'm sure I'm following this analogy with the export...
but being able to set things up from one configuration 
file and command is key. 

nfsconf does an excellent job parsing nfs.conf and I would
like to build on that... 

I understand we have to work well in containers which 
is one of the reason I was trying to come up with a
nfsv4 only nfs-utils... That went over like a lead balloon ;-) 

What I don't understand is why we can't come up with a 
solution that uniquely set a param that is set by 
nfsconf using nfs.conf.

steved.  
> 
> Conversely, there's no clear need for administrators to be
> aware of the setting, once it is being set properly.
> 
> 
> --
> Chuck Lever
> 
> 
> 

