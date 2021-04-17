Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B61363120
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Apr 2021 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhDQQRH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Apr 2021 12:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236537AbhDQQRH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Apr 2021 12:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618676200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0N5LV1+/icsuL2WmQTlQ0ff7Zyc8+mgRM+txdNV6p+Y=;
        b=OMAbL8ZJOlzEFu0WAw93BrLmCEjTcZxqsm2sK3ZI/vSAmyu4Ap8VzTxAHEaWRZVX3vsmyI
        +Jc3RW+DlYx3cMemgogelWoXYBq7/JOI0LL7SJ6i7lWHJJJEV36TGCjes47Fa7EvS7wi4s
        d7zxZhNVfpV0o8y2qx/pYJPdxN+gM+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-0vwx6hAfOJ-fN1qBmS32Kw-1; Sat, 17 Apr 2021 12:16:38 -0400
X-MC-Unique: 0vwx6hAfOJ-fN1qBmS32Kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56FC61898296;
        Sat, 17 Apr 2021 16:16:37 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-83.phx2.redhat.com [10.3.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC7035D9CD;
        Sat, 17 Apr 2021 16:16:36 +0000 (UTC)
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Alice J Mitchell <ajmitchell@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
 <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
 <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
Date:   Sat, 17 Apr 2021 12:18:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/15/21 12:37 PM, Chuck Lever III wrote:
> 
> 
>> On Apr 15, 2021, at 11:33 AM, Steve Dickson <SteveD@RedHat.com> wrote:
>>
>> Hey Chuck! 
>>
>> On 4/14/21 7:26 PM, Chuck Lever III wrote:
>>> Hi Steve-
>>>
>>>> On Apr 14, 2021, at 2:10 PM, Steve Dickson <SteveD@redhat.com> wrote:
>>>>
>>>> ﻿This is a tweak of the patch set Alice Mitchell posted last July [1].
>>>
>>> That approach was dropped last July because it is not container-aware.
>>> It should be simple for someone to write a udev script that uses the
>>> existing sysfs API that can update nfs4_client_id in a namespace. I
>>> would prefer the sysfs/udev approach for setting nfs4_client_id,
>>> since it is container-aware and makes this setting completely
>>> automatic (zero touch).
>> As I said in in my cover letter, I see this more as introduction of
>> a mechanism more than a way to set the unique id.
> 
> Yep, I got that.
> 
> I'm not addressing the question of whether adding a
> mechanism to set a module parameter in nfs.conf is good
> or not. I'm saying nfs4_client_id is not an appropriate
> parameter to add to nfs.conf. Can you pick another
> module parameter as an example for your mechanism?
The request was to set that parameter... 

> 
> 
>> The mechanism being
>> a way to set kernel module params from nfs.conf. The setting of
>> the id is just a side effect... 
>>
>> Why spread out the NFS configuration?  Why not
>> just keep it in one place... aka nfs.conf?
> 
> We need to understand whether a module parameter is not
> going to work in nfs.conf because that setting needs to
> be namespace-aware. In this case, this setting does indeed
> need to be namespace-aware. nfs.conf is not aware of
> network namespaces.
You probably can say that for every /etc/*.conf file...  
not being namespace aware... how can they be...

In the kernel document you say "Specifying a uniquifier string is 
not support for NFS clients running in containers."

Why isn't that enough? 

> 
> 
>> Plus we could document all the kernel params in nfs.conf
>> and the nfs.conf man page. The only documentation I know 
>> of is in the kernel tree.
> 
> OK, but that's not relevant to whether nfs.conf is the
> right place to set nfs4_client_id.
Point.

> 
> 
>> As far as not being container-aware... that might true
>> but it does not mean its not useful to set the id from
>> nfs.conf...
> 
> Yes, it does mean that in that case. It's completely
> broken to use the same nfs4_client_id in every network
> namespace.
How does this break? If all the clients have unique ids
what breaks?

Or are you saying setting the unique id like this:

options nfs nfs4_unique_id="64fd26280451566d648ab0e0b7384421"

in modprobe.d/nfs.conf is not namespace safe?

> 
>> Actual I have customers asking for this type
>> of functionality
> 
> Ask yourself why they might want it. It's probably because
> we don't set it correctly currently. If we have a way to
> automatically get it right every time, there's really no
> need for this setting to be exposed.
If we shouldn't expose it... Lets get rid of it... 
You added the param in the fall 2012... If it hasn't
been used correctly or can't be used correctly for
all theses years... why does it exist?

> 
> I do agree that it's long past time we should be setting
> nfs4_client_id properly. I would rather see a udev script
> developed (you, me, or Alice could do it in an afternoon)
> first. If that doesn't meet the actual customer need, then
> we can revisit.
I'll address this in Trond's reply... 

thanks!

steved.

