Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A514A9EC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 19:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgA0SjZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 13:39:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30409 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725845AbgA0SjZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 13:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580150363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMCked3fUhSZVEHK8Y2siL8oP+ldvZyJQqiXbxWzWXo=;
        b=Go84ZcM5IwlD5KES9hjZplPDTgTtug5kxdPoZu2xJ/lLrF9I+OiVLuu91nQzZMIpmlH77g
        e+0xWZt3sqJKlZhyeHDCwcRmNwE4hsIuS/iDGQFH4HMRlUiFBzLkXJKviQa3c7DoIkmtjz
        DZW06LHOpjhCWZvNBLn9oSzYWuvAw6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-gIG0zUF7N1ahPcOeopTFBQ-1; Mon, 27 Jan 2020 13:39:05 -0500
X-MC-Unique: gIG0zUF7N1ahPcOeopTFBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFDF13FF;
        Mon, 27 Jan 2020 18:39:04 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-75.phx2.redhat.com [10.3.117.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 760693B7;
        Mon, 27 Jan 2020 18:39:03 +0000 (UTC)
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
 <81b8fd1b-6882-5edf-fcab-1a7d4c9d4d47@RedHat.com>
 <bd7f5ace305738f37b657fe86761339956bf66c3.camel@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3e85d5f8-bcdc-b8ee-3ea4-b918f084fd19@RedHat.com>
Date:   Mon, 27 Jan 2020 13:39:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bd7f5ace305738f37b657fe86761339956bf66c3.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/22/20 7:23 PM, Trond Myklebust wrote:
> On Mon, 2020-01-20 at 10:35 -0500, Steve Dickson wrote:
>> Hello,
>>
>> On 1/16/20 2:08 PM, Olga Kornievskaia wrote:
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>  fs/nfs/nfs4client.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
>>> index 460d625..4df3fb0 100644
>>> --- a/fs/nfs/nfs4client.c
>>> +++ b/fs/nfs/nfs4client.c
>>> @@ -881,7 +881,7 @@ static int nfs4_set_client(struct nfs_server
>>> *server,
>>>  
>>>  	if (minorversion == 0)
>>>  		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
>>> -	else if (proto == XPRT_TRANSPORT_TCP)
>>> +	if (proto == XPRT_TRANSPORT_TCP)
>>>  		cl_init.nconnect = nconnect;
>>>  
>>>  	if (server->flags & NFS_MOUNT_NORESVPORT)
>>>
>> Tested-by: Steve Dickson <steved@redhat.com>
>>
>> With this patch v4.0 mounts act just like v4.1/v4.2 mounts
>> But is that a good thing. :-)  
>>
>> Here is what I've found in my testing...
>>
>> mount -onconnect=12 172.31.1.54:/home/tmp /mnt/tmp
>>
>> Will create 12 TCP connections and maintain those 12 
>> connections until the umount happens. By maintain I mean 
>> if the connection times out, it is reconnected 
>> to maintain the 12 connections 
>>
>> # mount -onconnect=12 172.31.1.54:/home/tmp /mnt/tmp
>> # netstat -an | grep 172.31.1.54 | wc -l
>> 12
>> # netstat -an | grep 172.31.1.54        
>> tcp        0      0
>> 172.31.1.24:901         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:667         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:746         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:672         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:832         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:895         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:673         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:732         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:795         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:918         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:674         172.31.1.54:2049        ESTABLISHED
>> tcp        0      0
>> 172.31.1.24:953         172.31.1.54:2049        ESTABLISHED
>>
>> # umount /mnt/tmp
>> # netstat -an | grep 172.31.1.54 | wc -l
>> 12
>> # netstat -an | grep 172.31.1.54
>> tcp        0      0
>> 172.31.1.24:901         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:667         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:746         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:672         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:832         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:895         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:673         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:732         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:795         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:918         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:674         172.31.1.54:2049        TIME_WAIT  
>> tcp        0      0
>> 172.31.1.24:953         172.31.1.54:2049        TIME_WAIT 
>>
>> Is this the expected behavior? 
>>
>> If so I have a few concerns...
>>
>> * The connections walk all over the /etc/services namespace. Meaning
>> using ports that are reserved for registered services, something
>> we've tried to avoid in userland by not binding to privilege ports
>> and
>> use of backlist ports via /etc/bindresvport.blacklist
>>
>> * When the unmount happens, all those connections go into TIME_WAIT
>> on 
>> privilege ports and there are only so many of those. Not good during
>> mount 
>> storms (when a server reboots and thousand of home dirs are
>> remounted).
>>
>> * No man page describing the new feature.
>>
>> I realize there is not much we can do about some of these
>> (aka umount==>TIME_WAIT) but I think we need to document 
>> what we are doing to people's connection namespace when 
>> they use this feature. 
> 
> I'm not sure that I understand the concern. The connections are limited
> to a specific window of ports by the min_resvport/max_resvport sunrpc
> module parameters just as they were before we added 'nconnect'. Nothing
> has changed in the way we choose ports...
> 
Maybe this problem has existed for a while... 

Here are the mins/max ports
RPC_DEF_MIN_RESVPORT    (665U)
RPC_DEF_MAX_RESVPORT    (1023U)

From /etc/services there are the services in that range
acp(674), ha-cluster(694), kerberos-adm(749), kerberos-iv(750)
webster(765), phonebook(767), rsync(873), rquotad(875), 
telnets(992), imaps(993), pop3s(995)

Granted a lot of these are unused/legacy services, but some of
them, like imaps and rsync, are still used. 

My point is since the nconnect connections are persistent, for
the life of the mount, we could end up squatting on ports other
services will needed.

Maybe there is not much we can do about this... But we should explain
somewhere, like the man page, that nconnect will create up to 16
persistent connection on register privilege ports.

steved.

