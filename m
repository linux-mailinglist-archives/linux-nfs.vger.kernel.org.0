Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6FD2CA4F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfE1PZX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 11:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfE1PZX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 May 2019 11:25:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EAF5C0703C6;
        Tue, 28 May 2019 15:25:18 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-47.phx2.redhat.com [10.3.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78005348E5;
        Tue, 28 May 2019 15:25:16 +0000 (UTC)
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chucklever@gmail.com" <chucklever@gmail.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
 <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
 <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
 <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3503ff03-2895-ae1f-7fed-f30d08b0abfb@RedHat.com>
Date:   Tue, 28 May 2019 11:25:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 28 May 2019 15:25:23 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/21/19 3:58 PM, Trond Myklebust wrote:
> On Tue, 2019-05-21 at 15:06 -0400, Chuck Lever wrote:
>>> On May 21, 2019, at 2:17 PM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>
>>> On Tue, 2019-05-21 at 13:40 -0400, Chuck Lever wrote:
>>>> Hi Trond -
>>>>
>>>>> On May 21, 2019, at 8:46 AM, Trond Myklebust <trondmy@gmail.com
>>>>>>
>>>>> wrote:
>>>>>
>>>>> The following patchset adds support for the 'root_dir'
>>>>> configuration
>>>>> option for nfsd in nfs.conf. If a user sets this option to a
>>>>> valid
>>>>> directory path, then nfsd will act as if it is confined to a
>>>>> chroot
>>>>> jail based on that directory. All paths in /etc/exporfs and
>>>>> from
>>>>> exportfs are then resolved relative to that directory.
>>>>
>>>> What about files under /proc that mountd might access? I assume
>>>> these
>>>> pathnames are not affected.
>>>>
>>> That's why we have 2 threads. One thread is root jailed using
>>> chroot,
>>> and is used to talk to knfsd. The other thread is not root jailed
>>> (or
>>> at least not by root_dir) and so has full access to /etc, /proc,
>>> /var,
>>> ...
>>>
>>>> Aren't there also one or two other files that maintain export
>>>> state
>>>> like /var/lib/nfs/rmtab? Are those affected?
>>>
>>> See above. They are not affected.
>>>
>>>> IMHO it could be less confusing to administrators to make
>>>> root_dir an
>>>> [exportfs] option instead of a [mountd] option, if this is not a
>>>> true
>>>> chroot of mountd.
>>>
>>> It is neither. I made in a [nfsd] option, since it governs the way
>>> that
>>> both exportfs and mountd talk to nfsd.
>>
>> My point is not about implementation, it's about how this
>> functionality
>> is presented to administrators.
>>
>> In nfs.conf, [nfsd] looks like it controls what options are passed
>> via
>> rpc.nfsd. That still seems like a confusing admin interface.
>>
>> IMO admins won't care about who is talking to whom. They will care
>> about
>> how the export pathnames are interpreted. That seems like it belongs
>> squarely with the exportfs interface.
>>
> 
> With the exportfs interface, yes. However it is not specific to the
> exportfs utility, so to me [exportfs] is more confusing than what
> exists now.
> 
> OK, so what if we put it in [general] instead, and perhaps rename it
> "export_rootdir"?
> 
I'm just catching up... my apologies tartness...

So setting root_dir effects *all* exports in /etc/exports? 
If that is the case, that one variable can change hundreds
of export... is that what we really want?

Wouldn't be better to have a little more granularity? 

As for where root_dir should go, I think it makes senses
to create a new [exportfs] section and have mountd read it
from there. I think that would be more straightforward if
we continue with the big hammer approach where any and all
exports are effected. 

steved.  
