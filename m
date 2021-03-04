Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E010E32D4B9
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 14:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhCDN5j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 08:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233485AbhCDN5H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 08:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614866141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMvAeCEktMdz+D9aCnw76gT81Ro1wc0BtvAjQaA7cOw=;
        b=PO8kMlW0hfVQYA/OsyqgiDO0pq4Vvtlp80+cgoH8x9+9K4BzVvsxauJNC8Mb2f/D2KHeuN
        0EKsFJkEcPUYN4Os8ethDUmceXa83bn3fBe0Plfott0DglTA7kFCvwR4DQKsys73aRV+GZ
        /WwBGvLN0+ks8vWvTM7wmOOosdx+3u0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-evuzhI0hNRCzBacBaXxs9Q-1; Thu, 04 Mar 2021 08:55:40 -0500
X-MC-Unique: evuzhI0hNRCzBacBaXxs9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29CB91923761;
        Thu,  4 Mar 2021 13:55:39 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-45.phx2.redhat.com [10.3.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D813919C48;
        Thu,  4 Mar 2021 13:55:38 +0000 (UTC)
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
 <d9e766cb-9af8-0c66-efb1-a3d0a291aa48@RedHat.com>
 <20210303221730.GH3949@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <80610f08-6f8d-1390-1875-068e63e744eb@RedHat.com>
Date:   Thu, 4 Mar 2021 08:57:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303221730.GH3949@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/3/21 5:17 PM, J. Bruce Fields wrote:
> On Wed, Mar 03, 2021 at 05:07:56PM -0500, Steve Dickson wrote:
>>
>>
>> On 3/3/21 4:54 PM, J. Bruce Fields wrote:
>>> On Wed, Mar 03, 2021 at 04:22:28PM -0500, Steve Dickson wrote:
>>>> Hey!
>>>>
>>>> On 3/3/21 10:23 AM, J. Bruce Fields wrote:
>>>>> On Tue, Mar 02, 2021 at 05:33:23PM -0500, Steve Dickson wrote:
>>>>>>
>>>>>>
>>>>>> On 2/24/21 3:30 PM, J. Bruce Fields wrote:
>>>>>>> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
>>>>>>>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
>>>>>>>> The idea is to allow distros to build a v4 only package
>>>>>>>> which will have a much smaller footprint than the
>>>>>>>> entire nfs-utils package.
>>>>>>>>
>>>>>>>> exportd uses no RPC code, which means none of the 
>>>>>>>> code or arguments that deal with v3 was ported, 
>>>>>>>> this again, makes the footprint much smaller. 
>>>>>>>
>>>>>>> How much smaller?
>>>>>> Will a bit smaller... but a number of daemons like nfsd[cld,clddb,cldnts]
>>>>>> need to also come a long. 
>>>>>
>>>>> Could we get some numbers?
>>>>>
>>>>> Looks like nfs-utils in F33 is about 1.2M:
>>>>>
>>>>> $ rpm -qi nfs-utils|grep ^Size
>>>>> Size        : 1243512
>>>>>
>>>>> $ strip utils/mountd/mountd
>>>>> $ ls -lh utils/mountd/mountd
>>>>> -rwxrwxr-x. 1 bfields bfields 128K Mar  3 10:12 utils/mountd/mountd
>>>>> $ strip utils/exportd/exportd
>>>>> $ ls -lh utils/exportd/exportd
>>>>> -rwxrwxr-x. 1 bfields bfields 106K Mar  3 10:12 utils/exportd/exportd
>>>>>
>>>>> So replacing mountd by exportd saves us about 20K out of 1.2M.  Is it
>>>>> worth it?
>>>> In smaller foot print I guess I meant no v3 daemons, esp rpcbind. 
>>>
>>> The rpcbind rpm is 120K installed, so if the new v4-only rpm has no
>>> dependency on rpcbind then we save 120K.
>> I believe it is more of a functionally thing than a size thing
>> WRT to containers. 
> 
> OK.  But if it's not about size, then we can use "rpc.mountd -N2 -N3",
> we don't need a separate daemon.
Personally I see this is the first step away from V3... 

So what we don't need is all that RPC code, all the different mounting
versions... no RPC code at all,  which also means no need for libtirpc... 
That is a lot of code that goes away, which I think is a good thing.

I never thought it was a good idea to have mountd process
the v4 upcalls... I always thought it should be a different
deamon... and now we have one.

A simple daemon that only processes v4 upcalls.

steved.

