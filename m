Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BE32C6B4
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386023AbhCDA3w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378365AbhCCVYW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 16:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614806574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viwvzjR2s5Zie8Gv/bbevmV4eG1k87byV0xxWRblENw=;
        b=WzBlskvFlbSm744fEkfP3DkoLKJb4yF76okQiep5RXwyhG+fdbBPSqBnCGazve6H+58wT7
        atDoIeBWOgGxExAe74vXX8jDf+pxIXxQcR0FQunJwYbpd1a9WxS8Mcbe6dg0WnI84vb9MN
        yun7Hbfo7CQLyuZn3oYOgBO9T9BrH8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-iNkEOJ6bM0-Hq8DB8zGiFQ-1; Wed, 03 Mar 2021 16:22:53 -0500
X-MC-Unique: iNkEOJ6bM0-Hq8DB8zGiFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 218281966320;
        Wed,  3 Mar 2021 21:22:52 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-45.phx2.redhat.com [10.3.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4CE9226EE;
        Wed,  3 Mar 2021 21:22:51 +0000 (UTC)
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224204944.GG11591@fieldses.org>
 <0dcefec0-1fbf-d43a-b508-cb06edfea866@RedHat.com>
 <06F2DFB7-8EA1-4ACE-BEA9-A68ACB99B361@oracle.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6c56eef3-6629-648d-4581-9f63ffeffd37@RedHat.com>
Date:   Wed, 3 Mar 2021 16:24:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <06F2DFB7-8EA1-4ACE-BEA9-A68ACB99B361@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/3/21 1:10 PM, Chuck Lever wrote:
> 
> 
>> On Mar 2, 2021, at 5:39 PM, Steve Dickson <SteveD@RedHat.com> wrote:
>>
>>
>>
>> On 2/24/21 3:49 PM, J. Bruce Fields wrote:
>>> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
>>>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
>>>> The idea is to allow distros to build a v4 only package
>>>> which will have a much smaller footprint than the
>>>> entire nfs-utils package.
>>>>
>>>> exportd uses no RPC code, which means none of the 
>>>> code or arguments that deal with v3 was ported, 
>>>> this again, makes the footprint much smaller. 
>>>>
>>>> The following options were ported:
>>>>    * multiple threads
>>>>    * state-directory-path option
>>>>    * junction support (not tested)
>>>>
>>>> The rest of the mountd options were v3 only options.
>>>>
>>>> V2:
>>>>  * Added two systemd services: nfsv4-exportd and nfsv4-server
>>>>  * nfsv4-server starts rpc.nfsd -N 3, so nfs.conf mod not needed.
>>>
>>> We really shouldn't make users change how they do things.
>> If they only want v4 support...  I'm thinking is a lot easier to
>> simple do a nfsv4.server start verse edit config files.
>>
>>>
>>> Whatever we do, "systemctl start nfs-server" should still be how they
>>> start the NFS server.
>> Again.. if they install the nfsv4-utils verse the nfs-utils package
>> they should expect change... IMHO..
> 
> I would prefer having a single nfs-utils package. I don't see
> a need for a proliferation of these extra little programs --
> let's just make the usual suspects behave better.
nfs-utils is not going anywhere!! :-)

I'm just trying to give people the option of only
install a v4 client or v4 server. If they want it
all... nfs-utils will be there!!

steved.

