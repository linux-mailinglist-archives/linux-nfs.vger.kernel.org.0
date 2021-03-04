Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB01B32D787
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 17:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhCDQUE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 11:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236813AbhCDQUC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 11:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614874717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONsUiehrh9q2JVSQU/LEasz+ot2nCwRmFP06gtkWKps=;
        b=fTv5Bbfvwb9UyVX57fLYsKgmUPFTf+ATGgTCpSIhnTaBnZANiWZ4tmbvAkcmTddayDLuRq
        I46DC+7NNxs8YrfPcEQePLmHW+SHEmhQQ2vLLkcNvC6pJGQ9ow18dRjZcPLgkXEgANakxD
        qmmBNPd4N1RDlT+TqqivrnYYiv+Rkmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-DONAJDpkMverWf_IRkrx4Q-1; Thu, 04 Mar 2021 11:18:33 -0500
X-MC-Unique: DONAJDpkMverWf_IRkrx4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67EF8193248A;
        Thu,  4 Mar 2021 16:18:32 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-51.phx2.redhat.com [10.3.114.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2212C19C84;
        Thu,  4 Mar 2021 16:18:32 +0000 (UTC)
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <fce1f95d-a4a5-88a8-3768-c81f7c09f193@RedHat.com>
 <20210304142450.GC17512@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e52d7764-3002-d3ce-31d8-406179fc194b@RedHat.com>
Date:   Thu, 4 Mar 2021 11:20:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304142450.GC17512@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/4/21 9:24 AM, J. Bruce Fields wrote:
> On Thu, Mar 04, 2021 at 08:34:45AM -0500, Steve Dickson wrote:
>>
>>
>> On 3/3/21 10:23 AM, J. Bruce Fields wrote:
>>> On Tue, Mar 02, 2021 at 05:33:23PM -0500, Steve Dickson wrote:
>>>>
>>>>
>>>> On 2/24/21 3:30 PM, J. Bruce Fields wrote:
>>>>> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
>>>>>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
>>>>>> The idea is to allow distros to build a v4 only package
>>>>>> which will have a much smaller footprint than the
>>>>>> entire nfs-utils package.
>>>>>>
>>>>>> exportd uses no RPC code, which means none of the 
>>>>>> code or arguments that deal with v3 was ported, 
>>>>>> this again, makes the footprint much smaller. 
>>>>>
>>>>> How much smaller?
>>>> Will a bit smaller... but a number of daemons like nfsd[cld,clddb,cldnts]
>>>> need to also come a long. 
>>>
>>> Could we get some numbers?
>>>
>>> Looks like nfs-utils in F33 is about 1.2M:
>>>
>>> $ rpm -qi nfs-utils|grep ^Size
>>> Size        : 1243512
>> Here are the numbers. Remember things are still in development so
>> these may not be the final numbers
>>
>> For the v4 only client
>> rpm -qi nfsv4-client-utils-2* | grep ^Size
>> Size        : 374573
>>
>> for the v4only server:
>> rpm -qi nfsv4-utils-2* | grep ^Size
>> Size        : 942088
> 
> $ rpm -qi nfs-utils|grep ^Size
> Size        : 1243512
> $ echo $((374573+942088))
> 1316661
> 
> So, they're a little bigger than nfs-utils, taken together.  Like you
> say, under development, probably there's just something overlooked that
> could be removed from one or the other or moved to an nfs-common
> package.
With containers in mind, I was thinking it would be one or the other
not both. I can see a container only wanting an client or server
but not both.

> 
> That might make a case for splitting up client and server sides for
> minimal installs that need only one or the other.
> 
> If it's installed size we're working on, though, do we have some target
> in mind here, though?  
No. 

Do we know what the container people are aiming for?  
No. I'm sure they don't know this is going on.

> I had some idea glic is more in the 10s of megabytes, and a
> minimal Fedora install is in the 100s, so I just wonder if it's worth
> chasing after 10s-100s of K.
I really don't think we need a target size... The size 
will be smaller because how the packages are broken up. 
Installing one of the v4 packages will always have 
smaller footprint than the entire nfs-utils package.

steved.
> 
> --b.
> 

