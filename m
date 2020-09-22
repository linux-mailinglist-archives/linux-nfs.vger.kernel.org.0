Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982842745AE
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVPqa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 11:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbgIVPqa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 11:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600789589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u34/bLwRNxQ0Og4eCpfWDTkQOocAqTuyI7/a+R+m1gE=;
        b=hCKE/Ch3a/R63+s5fDhSNDHnY4LjKD656J2FAAi3sqMp+gYPVm7pLZe+pqfw2M2LRD2Dis
        by/rOELhlR4YqjPAQLtWPo41aidwfkp8fC8/mM93ZRpxn7EkkNmpoSqwGlLYvhkHD1qjVp
        aFOxk6BbDo/prSjErxowWWGz2pjuo7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-5mK7sTHDN5K-Y_SP78_3nw-1; Tue, 22 Sep 2020 11:46:25 -0400
X-MC-Unique: 5mK7sTHDN5K-Y_SP78_3nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C10A48015DB;
        Tue, 22 Sep 2020 15:46:24 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2AC778825;
        Tue, 22 Sep 2020 15:46:23 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Anna Schumaker" <anna.schumaker@netapp.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps
 state sequence
Date:   Tue, 22 Sep 2020 11:46:21 -0400
Message-ID: <EEE7BF42-07C5-4593-93AB-068F8DDCCD9A@redhat.com>
In-Reply-To: <CAFX2JfkQSonD=Hnn40Y8A62rfmoQ2d8_ugNvOmg+Ny8zJ6dLAg@mail.gmail.com>
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
 <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com>
 <8DB79D4D-6986-4114-B031-43157089C2B5@redhat.com>
 <CAFX2JfmH-oP94jdwcnjkqoOQOCaEg5PvC0G5Q1P5q3C5J9A0Ug@mail.gmail.com>
 <CAFX2JfkQSonD=Hnn40Y8A62rfmoQ2d8_ugNvOmg+Ny8zJ6dLAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Sep 2020, at 10:43, Anna Schumaker wrote:

> On Tue, Sep 22, 2020 at 10:31 AM Anna Schumaker
> <anna.schumaker@netapp.com> wrote:
>>
>> On Tue, Sep 22, 2020 at 10:22 AM Benjamin Coddington
>> <bcodding@redhat.com> wrote:
>>>
>>> On 22 Sep 2020, at 10:03, Anna Schumaker wrote:
>>>> Hi Ben,
>>>>
>>>> Once I apply this patch I have trouble with generic/478 doing lock 
>>>> reclaim:
>>>>
>>>> [  937.460505] run fstests generic/478 at 2020-09-22 09:59:14
>>>> [  937.607990] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
>>>>
>>>> And the test just hangs until I kill it.
>>>>
>>>> Just thought you should know!
>>>
>>> Yes, thanks!  I'm not seeing that..  I've tested these based on 
>>> v5.8.4, I'll
>>> rebase and check again.  I see a wirecap of generic/478 is only 515K 
>>> on my
>>> system, would you be willing to share a capture of your test 
>>> failing?
>>
>> I have it based on v5.9-rc6 (plus the patches I have queued up for
>> v5.10), so there definitely could be a difference there! I'm using a
>> stock kernel on my server, though :)
>>
>> I can definitely get you a packet trace once I re-apply the patch and
>> rerun the test.
>
> Here's the packet trace, I reran the test with just this patch applied
> on top of v5.9-rc6 so it's not interacting with something else in my
> tree. Looks like it's ending up in an NFS4ERR_OLD_STATEID loop.

Thanks very much!

Did you see this failure with all three patches applied, or just with 
the
first patch?

I see the client get two OPEN responses, but then is sending 
TEST_STATEID
with the first seqid.  Seems like seqid 2 is getting lost.  I wonder if
we're making a bad assumption that NFS_OPEN_STATE can only be toggled 
under
the so_lock.

Ben

