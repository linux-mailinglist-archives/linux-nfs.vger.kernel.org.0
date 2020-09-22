Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4CA27487D
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVSrS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 14:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVSrR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 14:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600800436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0FB5loLfqOnMuDUjVPQGW+J3kXQfMd9WPTfDBece+4=;
        b=BZcmTWURwDKdIPjt6TaBbJ2pyxvWdrofF6Q9ug/JtFZUTepqcENKnJMW1hHEO92Pm8f+xY
        X7eT7lVV5noN45Zr4H8W/zunYU+FNhfYh6H9ihfJmK7XroG0yWyCjXMPUGalGyoyKcTH4C
        izKb9nYEZzrgCpLEDjqLziq238nLn7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-hiraVGOxP4i9XVWIPPaRIw-1; Tue, 22 Sep 2020 14:47:14 -0400
X-MC-Unique: hiraVGOxP4i9XVWIPPaRIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B15731007464;
        Tue, 22 Sep 2020 18:47:11 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 269983782;
        Tue, 22 Sep 2020 18:47:10 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Anna Schumaker" <anna.schumaker@netapp.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps
 state sequence
Date:   Tue, 22 Sep 2020 14:47:09 -0400
Message-ID: <068EFB54-D0B0-42C2-9408-603F10918FD7@redhat.com>
In-Reply-To: <CAFX2JfmPNMbM3FShzP-WbVf+=8iTNs__wRGk-M5waLoQpP1WUQ@mail.gmail.com>
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
 <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com>
 <8DB79D4D-6986-4114-B031-43157089C2B5@redhat.com>
 <CAFX2JfmH-oP94jdwcnjkqoOQOCaEg5PvC0G5Q1P5q3C5J9A0Ug@mail.gmail.com>
 <CAFX2JfkQSonD=Hnn40Y8A62rfmoQ2d8_ugNvOmg+Ny8zJ6dLAg@mail.gmail.com>
 <EEE7BF42-07C5-4593-93AB-068F8DDCCD9A@redhat.com>
 <CAFX2JfnDKhkM4b68haOtwSS+7W7CRABDqeCauvSXZf_zoEf8fw@mail.gmail.com>
 <CAFX2JfmPNMbM3FShzP-WbVf+=8iTNs__wRGk-M5waLoQpP1WUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Sep 2020, at 12:11, Anna Schumaker wrote:

> On Tue, Sep 22, 2020 at 11:53 AM Anna Schumaker
> <anna.schumaker@netapp.com> wrote:
>>
>> On Tue, Sep 22, 2020 at 11:49 AM Benjamin Coddington
>> <bcodding@redhat.com> wrote:
>>>
>>> On 22 Sep 2020, at 10:43, Anna Schumaker wrote:
>>>
>>>> On Tue, Sep 22, 2020 at 10:31 AM Anna Schumaker
>>>> <anna.schumaker@netapp.com> wrote:
>>>>>
>>>>> On Tue, Sep 22, 2020 at 10:22 AM Benjamin Coddington
>>>>> <bcodding@redhat.com> wrote:
>>>>>>
>>>>>> On 22 Sep 2020, at 10:03, Anna Schumaker wrote:
>>>>>>> Hi Ben,
>>>>>>>
>>>>>>> Once I apply this patch I have trouble with generic/478 doing lock
>>>>>>> reclaim:
>>>>>>>
>>>>>>> [  937.460505] run fstests generic/478 at 2020-09-22 09:59:14
>>>>>>> [  937.607990] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
>>>>>>>
>>>>>>> And the test just hangs until I kill it.
>>>>>>>
>>>>>>> Just thought you should know!
>>>>>>
>>>>>> Yes, thanks!  I'm not seeing that..  I've tested these based on
>>>>>> v5.8.4, I'll
>>>>>> rebase and check again.  I see a wirecap of generic/478 is only 515K
>>>>>> on my
>>>>>> system, would you be willing to share a capture of your test
>>>>>> failing?
>>>>>
>>>>> I have it based on v5.9-rc6 (plus the patches I have queued up for
>>>>> v5.10), so there definitely could be a difference there! I'm using a
>>>>> stock kernel on my server, though :)
>>>>>
>>>>> I can definitely get you a packet trace once I re-apply the patch and
>>>>> rerun the test.
>>>>
>>>> Here's the packet trace, I reran the test with just this patch applied
>>>> on top of v5.9-rc6 so it's not interacting with something else in my
>>>> tree. Looks like it's ending up in an NFS4ERR_OLD_STATEID loop.
>>>
>>> Thanks very much!
>>>
>>> Did you see this failure with all three patches applied, or just with
>>> the
>>> first patch?
>>
>> I saw it with the first patch applied, and with the first and third
>> applied. I initially hit it as I was wrapping up for the day
>> yesterday, but I left out #2 since I saw your retraction
>
> I reran with all three patches applied, and didn't have the issue. So
> something in the refactor patch fixes it.

That helped me see the case we're not handling correctly is when two OPENs
race and the second one tries to update the state first and gets dropped.
That is fixed by the 2/3 refactor patch since the refactor was being a bit
more explicit.

That means I'll need to fix those two patches and send them again.  I'm very
glad you caught this!  Thanks very much for helping me find the problem.

Ben

