Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA39F32D417
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhCDNYD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 08:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234774AbhCDNXv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 08:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614864145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5GEGtp+5B7rSnc2dXQu5VRIFFXEfx9E7/3pypUiGUo=;
        b=dZp5ooBWQp+fySPIFO2/8zxLG+xy/1XnkiQmreM9QlscAw9HarzfN0PfqExvJ1DpQpANCF
        WDUp8YSz6I0E71dDOVrZl7afcO+ta6APK8nrcxphqcAwLGN6ARcR5RCzRVNhO35fEkd/EG
        J696u4bcPCyU0AK3/mqHLp0RJKSltvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-pLKnVquaP5Oy-xATSn79lw-1; Thu, 04 Mar 2021 08:22:23 -0500
X-MC-Unique: pLKnVquaP5Oy-xATSn79lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C652E814313;
        Thu,  4 Mar 2021 13:22:22 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-45.phx2.redhat.com [10.3.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2315D762;
        Thu,  4 Mar 2021 13:22:22 +0000 (UTC)
Subject: Re: [PATCH 0/5] nfs-utils: provide audit-logging of NFSv4 access
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <161422077024.28256.15543036625096419495.stgit@noble>
 <6ddbe801-d107-5cbd-7362-c3e84321f203@RedHat.com>
 <87pn0fhnxo.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e9bbf5bc-1d78-746b-1d93-8e414801dadd@RedHat.com>
Date:   Thu, 4 Mar 2021 08:24:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87pn0fhnxo.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/3/21 5:28 PM, NeilBrown wrote:
> On Tue, Mar 02 2021, Steve Dickson wrote:
> 
>> Hey!
>>
>> A couple comments... 
>>
>> On 2/24/21 9:42 PM, NeilBrown wrote:
>>> When NFSv3 is used mountd provides logs of successful and failed mount
>>> attempts which can be used for auditing.
>>> When NFSv4 is used there are no such logs as NFSv4 does not have a
>>> distinct "mount" request.
>>>
>>> However mountd still knows about which filesysytems are being accessed
>>> from which clients, and can actually provide more reliable logs than it
>>> currently does, though they must be more verbose - with periodic "is
>>> being accessed" message replacing a single "was mounted" message.
>>>
>>> This series adds support for that logging, and adds some related
>>> improvements to make the logs as useful as possible.
>>>
>>> NeilBrown
>>>
>>> ---
>>>
>>> NeilBrown (5):
>>>       mountd: reject unknown client IP when !use_ipaddr.
>>>       mountd: Don't proactively add export info when fh info is requested.
>>>       mountd: add logging for authentication results for accesses.
>> I wonder if we should mention setting "debug=auth" enables
>> this logging in the mountd manpage 
> 
> That is already in the mountd man page :-)
Sorry I must have missed it...

> 
>>
>>>       mountd: add --cache-use-ipaddr option to force use_ipaddr
>>>       mountd: make default ttl settable by option
>> These two probably need to be put into the nfs.conf file 
>> and the nfs.conf man page since the conf_get_num()
>> and conf_get_bool() calls were added.
> 
> That's done now too.
Thank you!

> 
>>
>> Finally, I'll add this to my plate, but I'm thinking
>> the new log-auth and ttl flags probably should be 
>> introduce into nfsv4.exported.
>>
> 
> I'll add that to my patches before resubmitting.
Thank you again!

> 
>> I didn't port over the use-ipaddr flag to exportd,
>> since I though it was only used in the v3 mount path
>> but may that was an oversight on my part. 
> 
> use-ipaddr it not at all v3 specific.
> It was originally introduced to handle the fact that a single host could
> be in a large number of netgroups, and concatenating the names of all
> those netgroups could produce a "domain" name that is too long.
> The new option to force it on is useful for access logging, particularly
> with NFSv4.
> 
> I'll add that to my patches too.
Perfect!

steved.
> 
> Thanks,
> NeilBrown
> 
> 
>>
>> Thoughts?
>>
>> steved.
>>>
>>>
>>>  support/export/auth.c      |  4 +++
>>>  support/export/cache.c     | 32 +++++++++++------
>>>  support/export/v4root.c    |  3 +-
>>>  support/include/exportfs.h |  3 +-
>>>  support/nfs/exports.c      |  4 ++-
>>>  utils/mountd/mountd.c      | 29 +++++++++++++++-
>>>  utils/mountd/mountd.man    | 70 ++++++++++++++++++++++++++++++++++++++
>>>  7 files changed, 130 insertions(+), 15 deletions(-)
>>>
>>> --
>>> Signature
>>>

