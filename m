Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C8A261B63
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 21:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgIHTCf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 15:02:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33657 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731246AbgIHQIB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599581260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dqrwLrSz74T5A+ccgX3XD/bc6eP53kVtfONjGG7fws=;
        b=Z54OsuWi58JuAv/Li0dRp62bDceucHW9D0+HW37y1GEPGTca52k+jnKY2KMIBPaoF1qMK7
        8ejkWxiG4PtjmPinffL7PZJtdf3TcWmTVZMB61KtxXQZP+bHvIoWFddKyxluKBI/aIcTDt
        9TDQBkjw3lETaC+ONeG0NvtWq6u16do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-j2kxPdzZPsCW0dhpNvXUxw-1; Tue, 08 Sep 2020 08:43:50 -0400
X-MC-Unique: j2kxPdzZPsCW0dhpNvXUxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4961E18BFEC0;
        Tue,  8 Sep 2020 12:43:49 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B73F960C0F;
        Tue,  8 Sep 2020 12:43:48 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Murphy Zhou" <jencce.kernel@gmail.com>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
Date:   Tue, 08 Sep 2020 08:43:47 -0400
Message-ID: <3ABDF891-C6AE-4EA8-BCB1-D8BD3015280C@redhat.com>
In-Reply-To: <BE205FBB-E5BC-40B2-8F3D-B7B6A7EBEB53@oracle.com>
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <f81d80f09c59d78c32fddd535b5604bc05c2a2b5.camel@hammerspace.com>
 <20191011084910.joa3ptovudasyo7u@xzhoux.usersys.redhat.com>
 <cbe6a84f9cd61a8f60e70c05a07b3247030a262f.camel@hammerspace.com>
 <6AAFBD30-1931-49A8-8120-B7171B0DA01C@redhat.com>
 <20200904030411.enioqeng4wxftucd@xzhoux.usersys.redhat.com>
 <B6AA10F3-072D-4BFD-9D96-275EC1A9D990@redhat.com>
 <BE205FBB-E5BC-40B2-8F3D-B7B6A7EBEB53@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Sep 2020, at 10:14, Chuck Lever wrote:

>> On Sep 4, 2020, at 6:55 AM, Benjamin Coddington <bcodding@redhat.com> 
>> wrote:
>>
>> On 3 Sep 2020, at 23:04, Murphy Zhou wrote:
>>
>>> Hi Benjamin,
>>>
>>> On Thu, Sep 03, 2020 at 01:54:26PM -0400, Benjamin Coddington wrote:
>>>>
>>>> On 11 Oct 2019, at 10:14, Trond Myklebust wrote:
>>>>> On Fri, 2019-10-11 at 16:49 +0800, Murphy Zhou wrote:
>>>>>> On Thu, Oct 10, 2019 at 02:46:40PM +0000, Trond Myklebust wrote:
>>>>>>> On Thu, 2019-10-10 at 15:40 +0800, Murphy Zhou wrote:
>>>> ...
>>>>>>>> @@ -3367,14 +3368,16 @@ static bool
>>>>>>>> nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
>>>>>>>> 			break;
>>>>>>>> 		}
>>>>>>>> 		seqid_open = state->open_stateid.seqid;
>>>>>>>> -		if (read_seqretry(&state->seqlock, seq))
>>>>>>>> -			continue;
>>>>>>>>
>>>>>>>> 		dst_seqid = be32_to_cpu(dst->seqid);
>>>>>>>> -		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
>>>>>>>> +		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > 0)
>>>>>>>> 			dst->seqid = cpu_to_be32(dst_seqid + 1);
>>>>>>>
>>>>>>> This negates the whole intention of the patch you reference in 
>>>>>>> the
>>>>>>> 'Fixes:', which was to allow us to CLOSE files even if seqid 
>>>>>>> bumps
>>>>>>> have
>>>>>>> been lost due to interrupted RPC calls e.g. when using 'soft' or
>>>>>>> 'softerr' mounts.
>>>>>>> With the above change, the check could just be tossed out
>>>>>>> altogether,
>>>>>>> because dst_seqid will never become larger than seqid_open.
>>>>>>
>>>>>> Hmm.. I got it wrong. Thanks for the explanation.
>>>>>
>>>>> So to be clear: I'm not saying that what you describe is not a 
>>>>> problem.
>>>>> I'm just saying that the fix you propose is really no better than
>>>>> reverting the entire patch. I'd prefer not to do that, and would 
>>>>> rather
>>>>> see us look for ways to fix both problems, but if we can't find 
>>>>> such as
>>>>> fix then that would be the better solution.
>>>>
>>>> Hi Trond and Murphy Zhou,
>>>>
>>>> Sorry to resurrect this old thread, but I'm wondering if any 
>>>> progress was
>>>> made on this front.
>>>
>>> This failure stoped showing up since v5.6-rc1 release cycle
>>> in my records. Can you reproduce this on latest upstream kernel?
>>
>> I'm seeing it on generic/168 on a v5.8 client against a v5.3 knfsd 
>> server.
>> When I test against v5.8 server, the test takes longer to complete 
>> and I
>> have yet to reproduce the livelock.
>>
>> - on v5.3 server takes ~50 iterations to produce, each test completes 
>> in ~40
>> seconds
>> - on v5.8 server my test has run ~750 iterations without getting into
>> the lock, each test takes ~60 seconds.
>>
>> I suspect recent changes to the server have changed the timing of 
>> open
>> replies such that the problem isn't reproduced on the client.
>
> The Linux NFS server in v5.4 does behave differently than earlier
> kernels with NFSv4.0, and it is performance-related. The filecache
> went into v5.4, and that seems to change the frequency at which
> the server offers delegations.

Just a point of reference - finally reproduced it on a v5.8 server after
4900 runs.  This took several days, and helped to heat the basement.

Ben

