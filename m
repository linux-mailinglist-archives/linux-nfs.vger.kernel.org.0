Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5432D804
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 17:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhCDQrQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 11:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233320AbhCDQqs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 11:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614876321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/u5imEjklvHnBBt4vtNuvzGzkdLnzmKxKFZwijIbaNU=;
        b=HqxSBWrhvh/Fp9mVBWMRu1CVbGaNjTobHrSYrgm6eHyNIhWul6/AkeizRoKTBePIXtt3cH
        QSG9+pvTzlr53cz691b10GGzCgJB1SEqs3HeG1qM/JWjoogJe+Ymf0tQbn6Jv/AURr0y5k
        sVMq3fRbXggeWvIwCL6cgmnAekkV5wI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-SaotgZo6M6Ww7nlyI6naYA-1; Thu, 04 Mar 2021 11:45:17 -0500
X-MC-Unique: SaotgZo6M6Ww7nlyI6naYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 041C2801814;
        Thu,  4 Mar 2021 16:45:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-51.phx2.redhat.com [10.3.114.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E6EA60C0F;
        Thu,  4 Mar 2021 16:45:13 +0000 (UTC)
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
 <16b186ea-1abc-511d-3c38-1014b470eaa0@RedHat.com>
 <20210304140123.GA17512@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <942471b7-f300-aedb-50da-26bb958915f4@RedHat.com>
Date:   Thu, 4 Mar 2021 11:47:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304140123.GA17512@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/4/21 9:01 AM, J. Bruce Fields wrote:
> On Thu, Mar 04, 2021 at 08:42:24AM -0500, Steve Dickson wrote:
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
>> The point with rpcbind is it not going to be started which means
>> it not opening up listening connection that may never be used.
>> This has pissed of people for years! :-)
> 
> OK, but we can do that without replacing mountd and changing the way
> everyone installs nfs-utils and runs the nfs server.
I'm not replacing mounts in nfs-utils and I not changing how the
server is started in nfs-utils... I'm just  giving people options

If you want this particular function install this package
If you want that particular function install that package
If you want the entire kit and caboodle use this package. 

Since these new package will have different names things
will work slightly different, but that all will be using
the same code base. 

steved.
  
> 
> --b.
> 

