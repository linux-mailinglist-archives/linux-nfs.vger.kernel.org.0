Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1732C6C2
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhCDA36 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1390403AbhCCWHk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 17:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614809170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhye6Dkm3xAg1yhDhC+YLH9/9RWUmCyzG9nOq/K5ezQ=;
        b=T1EzijHH4tSPlA8IktNRiKmI5s4LFIRX7AZETWO1xDCdQ8wVD+OGNuT65uh+uk2VopxhC9
        eZ6/gi4GPKj/mG874YhQq7ErnFClKmXeQ5Sq8bCFAXhU6MAg+ZULgEgQI5OYMk87IiAERs
        puKVvZRP7uaiafL/onizUFnCRglUnoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-dVzfUNr4M6u6p_KP9tHeug-1; Wed, 03 Mar 2021 17:06:08 -0500
X-MC-Unique: dVzfUNr4M6u6p_KP9tHeug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3258A106BB23;
        Wed,  3 Mar 2021 22:06:07 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-45.phx2.redhat.com [10.3.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0E0160D01;
        Wed,  3 Mar 2021 22:06:06 +0000 (UTC)
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <d9e766cb-9af8-0c66-efb1-a3d0a291aa48@RedHat.com>
Date:   Wed, 3 Mar 2021 17:07:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303215415.GE3949@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/3/21 4:54 PM, J. Bruce Fields wrote:
> On Wed, Mar 03, 2021 at 04:22:28PM -0500, Steve Dickson wrote:
>> Hey!
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
>>>
>>> $ strip utils/mountd/mountd
>>> $ ls -lh utils/mountd/mountd
>>> -rwxrwxr-x. 1 bfields bfields 128K Mar  3 10:12 utils/mountd/mountd
>>> $ strip utils/exportd/exportd
>>> $ ls -lh utils/exportd/exportd
>>> -rwxrwxr-x. 1 bfields bfields 106K Mar  3 10:12 utils/exportd/exportd
>>>
>>> So replacing mountd by exportd saves us about 20K out of 1.2M.  Is it
>>> worth it?
>> In smaller foot print I guess I meant no v3 daemons, esp rpcbind. 
> 
> The rpcbind rpm is 120K installed, so if the new v4-only rpm has no
> dependency on rpcbind then we save 120K.
I believe it is more of a functionally thing than a size thing
WRT to containers. 

> 
> So, for stuff needed in both v4-only and full cases, would we package
> that in a common rpm that they both depend on?
Well... if we want the packages to be compatible yes there would
have to be a common rpm (aka nfs.conf, nfsmount.conf, upcall stuff)
But if one only wants a client or server then they don't have
to be compatible...  

steved.

