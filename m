Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BB02CDCF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE1RlE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 13:41:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfE1Rky (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 May 2019 13:40:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 410BD5D672;
        Tue, 28 May 2019 17:40:51 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-47.phx2.redhat.com [10.3.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8A915D704;
        Tue, 28 May 2019 17:40:49 +0000 (UTC)
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chucklever@gmail.com" <chucklever@gmail.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
 <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
 <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
 <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
 <3503ff03-2895-ae1f-7fed-f30d08b0abfb@RedHat.com>
 <c7a5f97693c56ee0a7dd5a9c0848ee97ab3d2a9e.camel@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <0b65f710-f06a-cfd3-a30e-577db8267d5b@RedHat.com>
Date:   Tue, 28 May 2019 13:40:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c7a5f97693c56ee0a7dd5a9c0848ee97ab3d2a9e.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 28 May 2019 17:40:53 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/28/19 12:44 PM, Trond Myklebust wrote:
> On Tue, 2019-05-28 at 11:25 -0400, Steve Dickson wrote:
>>
>> On 5/21/19 3:58 PM, Trond Myklebust wrote:
>>> On Tue, 2019-05-21 at 15:06 -0400, Chuck Lever wrote:
>>>>> On May 21, 2019, at 2:17 PM, Trond Myklebust <
>>>>> trondmy@hammerspace.com> wrote:
>>>>>
>>>>> On Tue, 2019-05-21 at 13:40 -0400, Chuck Lever wrote:
>>>>>> Hi Trond -
>>>>>>
>>>>>>> On May 21, 2019, at 8:46 AM, Trond Myklebust <
>>>>>>> trondmy@gmail.com
>>>>>>> wrote:
>>>>>>>
>>>>>>> The following patchset adds support for the 'root_dir'
>>>>>>> configuration
>>>>>>> option for nfsd in nfs.conf. If a user sets this option to
>>>>>>> a
>>>>>>> valid
>>>>>>> directory path, then nfsd will act as if it is confined to
>>>>>>> a
>>>>>>> chroot
>>>>>>> jail based on that directory. All paths in /etc/exporfs and
>>>>>>> from
>>>>>>> exportfs are then resolved relative to that directory.
>>>>>>
>>>>>> What about files under /proc that mountd might access? I
>>>>>> assume
>>>>>> these
>>>>>> pathnames are not affected.
>>>>>>
>>>>> That's why we have 2 threads. One thread is root jailed using
>>>>> chroot,
>>>>> and is used to talk to knfsd. The other thread is not root
>>>>> jailed
>>>>> (or
>>>>> at least not by root_dir) and so has full access to /etc,
>>>>> /proc,
>>>>> /var,
>>>>> ...
>>>>>
>>>>>> Aren't there also one or two other files that maintain export
>>>>>> state
>>>>>> like /var/lib/nfs/rmtab? Are those affected?
>>>>>
>>>>> See above. They are not affected.
>>>>>
>>>>>> IMHO it could be less confusing to administrators to make
>>>>>> root_dir an
>>>>>> [exportfs] option instead of a [mountd] option, if this is
>>>>>> not a
>>>>>> true
>>>>>> chroot of mountd.
>>>>>
>>>>> It is neither. I made in a [nfsd] option, since it governs the
>>>>> way
>>>>> that
>>>>> both exportfs and mountd talk to nfsd.
>>>>
>>>> My point is not about implementation, it's about how this
>>>> functionality
>>>> is presented to administrators.
>>>>
>>>> In nfs.conf, [nfsd] looks like it controls what options are
>>>> passed
>>>> via
>>>> rpc.nfsd. That still seems like a confusing admin interface.
>>>>
>>>> IMO admins won't care about who is talking to whom. They will
>>>> care
>>>> about
>>>> how the export pathnames are interpreted. That seems like it
>>>> belongs
>>>> squarely with the exportfs interface.
>>>>
>>>
>>> With the exportfs interface, yes. However it is not specific to the
>>> exportfs utility, so to me [exportfs] is more confusing than what
>>> exists now.
>>>
>>> OK, so what if we put it in [general] instead, and perhaps rename
>>> it
>>> "export_rootdir"?
>>>
>> I'm just catching up... my apologies tartness...
>>
>> So setting root_dir effects *all* exports in /etc/exports? 
>> If that is the case, that one variable can change hundreds
>> of export... is that what we really want?
>>
>> Wouldn't be better to have a little more granularity? 
> 
> Can you explain what you mean? The intention here is that if you have
> all your exported filesystems set up in a subtree under
> /mnt/my/exports, then you can remove that unnecessary prefix.
> 
> So, for instance, if I'm trying to export /mnt/my/exports/foo and
> /mnt/my/exports/bar, then I can make those two filesystems appear as
> /foo, and /bar to the remote clients.
By granularity I meant have different roots for different exports.
Meaning /mnt/foo/exports/foo and /mnt/bar/exports/bar
would still appear as /foo and /bar

As you explain later in this thread, there is going to be a nfs.conf
and exports for each container so maybe this is not necessary?? 

Maybe I'm misunderstanding how this feature should/will be used.

> 
> If an admin wants to rearrange all the paths in /etc/exports, and make
> a custom namespace, then that is possible using bind mounts: just
> create a directory /my_exports, and use mount --bind to attach the
> necessary mountpoints into the right spots in /my_exports, then use
> export_rootdir to remove the /my_exports prefix.
> 
>> As for where root_dir should go, I think it makes senses
>> to create a new [exportfs] section and have mountd read it
>> from there. I think that would be more straightforward if
>> we continue with the big hammer approach where any and all
>> exports are effected. 
>>
> 
> Fair enough, I can add the [exports] section if you all agree that is
> an appropriate place.
> 
I think a new exports sections with a rootdir variable makes sense.
It is changing the root of the exports... 

But I could also live with a export_rootdir in the general section.

Question:
How is this different than pseudo root? 

Isn't this basically a way to set the pseudo for v3? 

What is going to override whom? Meaning if both 
fsid=/mnt/foo and rootdir=/mnt/bar which one will be used?

steved.

steved.
