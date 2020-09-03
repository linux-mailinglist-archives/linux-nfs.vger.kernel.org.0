Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B448F25C83E
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Sep 2020 19:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgICRyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Sep 2020 13:54:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726025AbgICRyb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Sep 2020 13:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599155671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QHKyILDK+DU+kwf20MFqRxPmC+YPmqZbsInm48ic+xU=;
        b=cCAoXwCpM+xKxvzQ8ZdWsXQcN+owt/no7qTowMjIEqOJvdD59j4dGLkWQ7y2d3Ocd+4Rct
        8GQTnZCeq3ckOAxYrO+Q7tkyFBqwtg22vDdHheefIubAvOG6twhgKr3eDk2fXgxIr2RAUE
        jqCWvV3VNYcb6XmgFNr5IhfSs+7PwGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-t_Q1E3rpOxqjXEsZBbmlRQ-1; Thu, 03 Sep 2020 13:54:29 -0400
X-MC-Unique: t_Q1E3rpOxqjXEsZBbmlRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE8D3800688;
        Thu,  3 Sep 2020 17:54:27 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1F8F6198B;
        Thu,  3 Sep 2020 17:54:27 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     jencce.kernel@gmail.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
Date:   Thu, 03 Sep 2020 13:54:26 -0400
Message-ID: <6AAFBD30-1931-49A8-8120-B7171B0DA01C@redhat.com>
In-Reply-To: <cbe6a84f9cd61a8f60e70c05a07b3247030a262f.camel@hammerspace.com>
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <f81d80f09c59d78c32fddd535b5604bc05c2a2b5.camel@hammerspace.com>
 <20191011084910.joa3ptovudasyo7u@xzhoux.usersys.redhat.com>
 <cbe6a84f9cd61a8f60e70c05a07b3247030a262f.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11 Oct 2019, at 10:14, Trond Myklebust wrote:
> On Fri, 2019-10-11 at 16:49 +0800, Murphy Zhou wrote:
>> On Thu, Oct 10, 2019 at 02:46:40PM +0000, Trond Myklebust wrote:
>>> On Thu, 2019-10-10 at 15:40 +0800, Murphy Zhou wrote:
...
>>>> @@ -3367,14 +3368,16 @@ static bool
>>>> nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
>>>>  			break;
>>>>  		}
>>>>  		seqid_open = state->open_stateid.seqid;
>>>> -		if (read_seqretry(&state->seqlock, seq))
>>>> -			continue;
>>>>
>>>>  		dst_seqid = be32_to_cpu(dst->seqid);
>>>> -		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
>>>> +		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > 0)
>>>>  			dst->seqid = cpu_to_be32(dst_seqid + 1);
>>>
>>> This negates the whole intention of the patch you reference in the
>>> 'Fixes:', which was to allow us to CLOSE files even if seqid bumps
>>> have
>>> been lost due to interrupted RPC calls e.g. when using 'soft' or
>>> 'softerr' mounts.
>>> With the above change, the check could just be tossed out
>>> altogether,
>>> because dst_seqid will never become larger than seqid_open.
>>
>> Hmm.. I got it wrong. Thanks for the explanation.
>
> So to be clear: I'm not saying that what you describe is not a problem.
> I'm just saying that the fix you propose is really no better than
> reverting the entire patch. I'd prefer not to do that, and would rather
> see us look for ways to fix both problems, but if we can't find such as
> fix then that would be the better solution.

Hi Trond and Murphy Zhou,

Sorry to resurrect this old thread, but I'm wondering if any progress was
made on this front.

I'm seeing this race manifest when process is never able to escape from the
loop in nfs_set_open_stateid_locked() if CLOSE comes through first and
clears out the state.  We can play bit-fiddling games to fix that, but I
feel like we'll just end up breaking it again later with another fix.

Either we should revert 0e0cb35b417f, or talk about how to fix it.  Seems
like we should be able to put the CLOSE on the nfs4_state->waitq as well,
and see if we can't just take that approach anytime our operations get out
of sequence.  Do you see any problems with this approach?

Ben

