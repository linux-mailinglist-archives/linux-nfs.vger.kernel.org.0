Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4271A36319B
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Apr 2021 19:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhDQRs6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Apr 2021 13:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236643AbhDQRs6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Apr 2021 13:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618681710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxV2LgktqwQZ3E+00bqEjl+W102WA42UNNm+o0tuof0=;
        b=Qjqi1Jm1nZTtOHGRC2EEGVtCWkn/eSOvhEsAiuZkmy2jbgWMoZ5jYZmT1Ob1amfczoIYMn
        6MPLBC6DDFdVCm3M0wHUgsroeyw3GtlxfYnfRsk7MmXW4xZBkybNksEm6U1zgHOwdtvdyk
        2mFjlgRTAhfiXrOk6sQgsMFFJUnU2Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-LmsGIZXmNjq8PJyaizXQ-Q-1; Sat, 17 Apr 2021 13:48:28 -0400
X-MC-Unique: LmsGIZXmNjq8PJyaizXQ-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C02F818982AC;
        Sat, 17 Apr 2021 17:48:27 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-83.phx2.redhat.com [10.3.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46B0460C4A;
        Sat, 17 Apr 2021 17:48:27 +0000 (UTC)
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
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
Date:   Sat, 17 Apr 2021 13:50:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/17/21 12:36 PM, Chuck Lever III wrote:
> 
> 
>> On Apr 17, 2021, at 12:18 PM, Steve Dickson <SteveD@RedHat.com> wrote:
>>
>>
>>
>> On 4/15/21 12:37 PM, Chuck Lever III wrote:
>>>
>>>
>>>> On Apr 15, 2021, at 11:33 AM, Steve Dickson <SteveD@RedHat.com> wrote:
>>>>
>>>> Hey Chuck! 
>>>>
>>>> On 4/14/21 7:26 PM, Chuck Lever III wrote:
>>>>> Hi Steve-
>>>>>
>>>>>> On Apr 14, 2021, at 2:10 PM, Steve Dickson <SteveD@redhat.com> wrote:
>>>>>>
>>>>>> ﻿This is a tweak of the patch set Alice Mitchell posted last July [1].
>>>>>
>>>>> That approach was dropped last July because it is not container-aware.
>>>>> It should be simple for someone to write a udev script that uses the
>>>>> existing sysfs API that can update nfs4_client_id in a namespace. I
>>>>> would prefer the sysfs/udev approach for setting nfs4_client_id,
>>>>> since it is container-aware and makes this setting completely
>>>>> automatic (zero touch).
>>>> As I said in in my cover letter, I see this more as introduction of
>>>> a mechanism more than a way to set the unique id.
>>>
>>> Yep, I got that.
>>>
>>> I'm not addressing the question of whether adding a
>>> mechanism to set a module parameter in nfs.conf is good
>>> or not. I'm saying nfs4_client_id is not an appropriate
>>> parameter to add to nfs.conf. Can you pick another
>>> module parameter as an example for your mechanism?
>> The request was to set that parameter...
> 
> The cover letter and the quoted e-mail above state that
> you are just demonstrating a mechanism to set module
> parameters via nfs.conf. I guess that statement was not
> entirely accurate, then. Thanks for clarifying.
I was trying to keep the conversation off of what
was being set to how it was being set... 

I had no idea the entire "options nfs" API is compromised
when it comes to containers... Not sure why... but I will
believe you... But is the API  compromised in a 
non-container env? Other than the cloud, isn't non-containers
envs the majority of our install based? 

> 
> If there's a bug report somewhere that requests a
> feature, it's normal practice to include a URL pointing
> to that report in the patch description.
I just assumed, since it had a customer case, the bz was 
private... it turns out not to be the case
https://bugzilla.redhat.com/show_bug.cgi?id=1801326

> 
> 
>>>> The mechanism being
>>>> a way to set kernel module params from nfs.conf. The setting of
>>>> the id is just a side effect... 
>>>>
>>>> Why spread out the NFS configuration?  Why not
>>>> just keep it in one place... aka nfs.conf?
>>>
>>> We need to understand whether a module parameter is not
>>> going to work in nfs.conf because that setting needs to
>>> be namespace-aware. In this case, this setting does indeed
>>> need to be namespace-aware. nfs.conf is not aware of
>>> network namespaces.
>> You probably can say that for every /etc/*.conf file...  
>> not being namespace aware... how can they be...
>>
>> In the kernel document you say "Specifying a uniquifier string is 
>> not support for NFS clients running in containers."
>>
>> Why isn't that enough?
> 
> Because that statement is noting a limitation which is a
> bug that has to be addressed to support NFSv4 properly in
> containers.
It seems to me we could use similar documentation when 
setting the id from nfs.conf.
 
> 
> 
>>>> As far as not being container-aware... that might true
>>>> but it does not mean its not useful to set the id from
>>>> nfs.conf...
>>>
>>> Yes, it does mean that in that case. It's completely
>>> broken to use the same nfs4_client_id in every network
>>> namespace.
>> How does this break? If all the clients have unique ids
>> what breaks?
>>
>> Or are you saying setting the unique id like this:
>>
>> options nfs nfs4_unique_id="64fd26280451566d648ab0e0b7384421"
>>
>> in modprobe.d/nfs.conf is not namespace safe?
> 
> Setting the client_id via module parameter is not
> namespace-aware. That's the bug that the sysfs/udev
> contraption is designed to fix.
Fair enough... So we know the sysfs/udev is
actually setting the id? 

> 
> 
>>>> Actual I have customers asking for this type
>>>> of functionality
>>>
>>> Ask yourself why they might want it. It's probably because
>>> we don't set it correctly currently. If we have a way to
>>> automatically get it right every time, there's really no
>>> need for this setting to be exposed.
>> If we shouldn't expose it... Lets get rid of it...
>> You added the param in the fall 2012... If it hasn't
>> been used correctly or can't be used correctly for
>> all theses years... why does it exist?
> 
> Because back then we didn't care about container awareness
> enough to make it an initial part of the feature. We were
> trying to address the problem of how to ensure that the
> nfs4_client_id is unique. But clearly it was only half a
> solution.
Right... I was just trying to build a mechanism to
set the value, and not worrying (yet) about what the
value is set to... 

So at this point, all of the nfs kernel module parameter
can be set through the sysfs/udev interface? 

If that is the cause... have the variables in 
nfs.conf create sysfs/udev file would work better?

steved.

> 
> The module parameter still exists because the general rule
> about these things is that module parameters are part of the
> kernel API, and can't just be removed. If there's a process
> for removing it, then I would agree to that now that we have
> a sysfs API to manage the nfs4_client_id setting.
> 
> 
>>> I do agree that it's long past time we should be setting
>>> nfs4_client_id properly. I would rather see a udev script
>>> developed (you, me, or Alice could do it in an afternoon)
>>> first. If that doesn't meet the actual customer need, then
>>> we can revisit.
>> I'll address this in Trond's reply... 
>>
>> thanks!
>>
>> steved.
> 
> --
> Chuck Lever
> 
> 
> 

