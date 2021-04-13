Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7724A35E3C9
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhDMQYu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 12:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232263AbhDMQXz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 12:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618331015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtKk9I/OnOQnzHiz0OZYI4PEHqrXZ1NYVdNFLdgEEfU=;
        b=gDuypMFpvncP9GBxI2ywBSX91ApSZve6wFzjXQuXrSz8b5rLaYgX6n7tQhVuxfvcWC9rdE
        vMAbbkTYY+qOkmLR5mPwrXQ4Fye22C14TEoI+KhcaCNABXk/guC+SzVixgKkWM4NyTlf+0
        0fsGMHnQJvMTzTqELT+G/el+yvcOb+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Jfl1SVdpOHKi8g2QsTMyCQ-1; Tue, 13 Apr 2021 12:23:33 -0400
X-MC-Unique: Jfl1SVdpOHKi8g2QsTMyCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22E23801984;
        Tue, 13 Apr 2021 16:23:32 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B60441000358;
        Tue, 13 Apr 2021 16:23:31 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     hedrick@rutgers.edu
Cc:     "Patrick Goetz" <pgoetz@math.utexas.edu>, linux-nfs@vger.kernel.org
Subject: Re: safe versions of NFS
Date:   Tue, 13 Apr 2021 12:23:30 -0400
Message-ID: <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>
In-Reply-To: <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

(resending this as it bounced off the list - I accidentally embedded 
HTML)

Yes, if you're pretty sure your hostnames are all different, the 
client_ids
should be different.  For v4.0 you can turn on debugging (rpcdebug -m 
nfs -s
proc) and see the client_id in the kernel log in lines that look like: 
"NFS
call setclientid auth=%s, '%s'\n", which will happen at mount time, but 
it
doesn't look like we have any debugging for v4.1 and v4.2 for 
EXCHANGE_ID.

You can extract it via the crash utility, or via systemtap, or by doing 
a
wire capture, but nothing that's easily translated to running across a 
large
number of machines.  There's probably other ways, perhaps we should tack
that string into the tracepoints for exchange_id and setclientid.

If you're interested in troubleshooting, wire capture's usually the most
informative.  If the lockup events all happen at the same time, there
might be some network event that is triggering the issue.

You should expect NFSv4.1 to be rock-solid.  Its rare we have reports
that it isn't, and I'd love to know why you're having these problems.

Ben

On 13 Apr 2021, at 11:38, hedrick@rutgers.edu wrote:

> The server is ubuntu 20, with a ZFS file system.
>
> I don’t set the unique ID. Documentation claims that it is set from 
> the hostname. They will surely be unique, or the whole world would 
> blow up. How can I check the actual unique ID being used? The kernel 
> reports a blank one, but I think that just means to use the hostname. 
> We could obviously set a unique one if that would be useful.
>
>> On Apr 13, 2021, at 11:35 AM, Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>
>> It would be interesting to know why your clients are failing to 
>> reclaim their locks.  Something is misconfigured.  What server are 
>> you using, and is there anything fancy on the server-side (like HA)?  
>> Is it possible that you have clients with the same nfs4_unique_id?
>>
>> Ben
>>
>> On 13 Apr 2021, at 11:17, hedrick@rutgers.edu wrote:
>>
>>> many, though not all, of the problems are “lock reclaim failed”.
>>>
>>>> On Apr 13, 2021, at 10:52 AM, Patrick Goetz 
>>>> <pgoetz@math.utexas.edu> wrote:
>>>>
>>>> I use NFS 4.2 with Ubuntu 18/20 workstations and Ubuntu 18/20 
>>>> servers and haven't had any problems.
>>>>
>>>> Check your configuration files; the last time I experienced 
>>>> something like this it's because I inadvertently used the same fsid 
>>>> on two different exports. Also recommend exporting top level 
>>>> directories only.  Bind mount everything you want to export into 
>>>> /srv/nfs and only export those directories. According to Bruce F. 
>>>> this doesn't buy you any security (I still don't understand why), 
>>>> but it makes for a cleaner system configuration.
>>>>
>>>> On 4/13/21 9:33 AM, hedrick@rutgers.edu wrote:
>>>>> I am in charge of a large computer science dept computing 
>>>>> infrastructure. We have a variety of student and develo9pment 
>>>>> users. If there are problems we’ll see them.
>>>>> We use an Ubuntu 20 server, with NVMe storage.
>>>>> I’ve just had to move Centos 7 and Ubuntu 18 to use NFS 4.0. We 
>>>>> had hangs with NFS 4.1 and 4.2. Files would appear to be locked, 
>>>>> although eventually the lock would time out. It’s too soon to be 
>>>>> sure that moving back to NFS 4.0 will fix it. Next is either NFS 3 
>>>>> or disabling delegations on the server.
>>>>> Are there known versions of NFS that are safe to use in production 
>>>>> for various kernel versions? The one we’re most interested in is 
>>>>> Ubuntu 20, which can be anything from 5.4 to 5.8.
>>



