Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B811B8CE
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2019 17:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfLKQaN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Dec 2019 11:30:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35387 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730220AbfLKQaM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Dec 2019 11:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576081811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KM6Kl1I/3sXPCQw9Jvr/LcwA7RN2oH6r8pxWjmKW4bY=;
        b=HBjZlfshdvedPwr0m8/cBd8JRVFNU2+mOZNA8TgO3CR3X/RBVT2hngo97YZ/tkXEkYVrCK
        9QbBG2P+dXWl9kf7UmWR+IkrBDcHCoEzvdbZx0iTm7Lrk9qLL/GQZ3vFN3Jhtrq9ASRkDg
        6zu3Fz8Dr0fW7cYLVI+I0LRWNZesruM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-goMHQSttNJabAvpSjo8Bwg-1; Wed, 11 Dec 2019 11:30:09 -0500
X-MC-Unique: goMHQSttNJabAvpSjo8Bwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC351100EEFC;
        Wed, 11 Dec 2019 16:30:08 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-200.phx2.redhat.com [10.3.116.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A25A605FF;
        Wed, 11 Dec 2019 16:30:08 +0000 (UTC)
Subject: Re: gssd question/patch
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyHJg4C5j72_CrCJhZ8hyzDe71Q9zw1USgmyxePg+3juZw@mail.gmail.com>
 <8c69eee5-9dc1-2a14-1bd2-cf812bdb39a4@RedHat.com>
 <CAN-5tyH-m=n2m8-qWbV-4iYJUhx4yMFz_uWUWAzYGArN5yxJaw@mail.gmail.com>
 <47f12fef-bf43-62d8-adda-303e3e551f36@RedHat.com>
 <CAN-5tyEjwEm7TohcHGPtub=DAM0=J9K0mN+epaNQu+E3+OB_FQ@mail.gmail.com>
 <CAN-5tyH_6tyxk2_eY4=K1E2tDB88usDt5ipg-wX+0AwPb_FY_A@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <583a32ec-15ae-1646-fe68-246371e8e978@RedHat.com>
Date:   Wed, 11 Dec 2019 11:29:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAN-5tyH_6tyxk2_eY4=K1E2tDB88usDt5ipg-wX+0AwPb_FY_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/10/19 7:44 PM, Olga Kornievskaia wrote:
> On Mon, Dec 9, 2019 at 3:20 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>
>> On Mon, Dec 9, 2019 at 3:06 PM Steve Dickson <SteveD@redhat.com> wrote:
>>>
>>>
>>>
>>> On 12/9/19 11:49 AM, Olga Kornievskaia wrote:
>>>> Hi Steve,
>>>>
>>>> On Mon, Dec 9, 2019 at 11:10 AM Steve Dickson <SteveD@redhat.com> wrote:
>>>>>
>>>>> Hey,
>>>>>
>>>>> On 12/6/19 1:29 PM, Olga Kornievskaia wrote:
>>>>>> Hi Steve,
>>>>>>
>>>>>> Question: Is this an interesting failure scenario (bug) that should be
>>>>>> fixed: client did a mount which acquired gss creds and stored in the
>>>>>> credential cache. Then say it umounts at some point. Then for some
>>>>>> reason the Kerberos cache is deleted (rm -f /tmp/krb5cc*). Now client
>>>>>> mounts again. This currently fails. Because gssd uses internal cache
>>>>>> to store creds lifetimes and thinks that tgt is still valid but then
>>>>>> trying to acquire a service ticket it fails (since there is no tgt).
>>>>> I'm unable reproduce the scenario....
>>>>>
>>>>> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
>>>>> (as kuser) kinit kuser
>>>>> (as kuser) touch /mnt/tmp/foobar
>>>>> (as root) umount /mnt/tmp/
>>>>> (as root) rm -f /tmp/krb5cc*
>>>>> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
>>>>> (as kuser) touch /mnt/tmp/foobar # which succeeds
>>>>>
>>>>> Where am I going wrong?
>>>>
>>>> Not sure. Can you please post gssd verbose output?
>>>>
>>>> Set up. Client kernel somewhat recent though the latest, but in
>>>> reality doesn't matter i think
>>>> gssd from nfs-utils commit 5a004c161ff6c671f73a92d818a502264367a896
>>>> "gssd: daemonize earlier"
>>>>
>>>> [aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
>>>> 192.168.1.72:/nfsshare /mnt
>>>> [aglo@localhost nfs-utils]$ touch /mnt/kerberos
>>> Is there a kinit before this?
>>
>> yep.
>>
>>>> [aglo@localhost nfs-utils]$ sudo umount /mnt
>>>> [aglo@localhost nfs-utils]$ sudo rm -fr /tmp/krb5cc*
>>>> [aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
>>>> 192.168.1.72:/nfsshare /mnt
>>>> mount.nfs: access denied by server while mounting 192.168.1.72:/nfsshare
>>>>
>>>> Here's the gssd error output: If you look at 1st "INFO: Credentials in
>>>> CC .... are good until..." is a lie as there isn't even a file there.
>>> Here is what I'm seeing:
>>>    https://paste.centos.org/view/9473f4a3
>>
>> Well, can't see anything there (well I'm seeing the same double INFO
>> which according to the code pass would not try to get the tgt and it
>> should fail).
>>
>> I'm not using gss_proxy. Are  you?
Yes I am... I'll try turning it off.. 

> 
> Any luck reproducing? I asked Jorge to try and he sees the same problem.
Not yet... but I'm still trying... 

steved.

> 
>>
>>>
>>> steved.
>>>
> 

