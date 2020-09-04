Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913D925E16F
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 20:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIDSUf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 14:20:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35658 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgIDSUf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 14:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599243633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPXtz5ZfKvX1uv2oIf6GgF7/x/KtxIBFjy2PIX6dvcc=;
        b=f1QRjTJAUJY5xBh2Y/QgDFrmJM56i/DTYDXj7bHnC5Aua0J4zfSYkgEtYH0NHhjq0W4QQc
        jZwH5J53F2fTX4Hov+jyUOZ5Re92Y+r8Z1eeyKfRnGbx3z+QOq1xCqrxfrwRX+Bo9+18Fx
        qVGx9vkwUiN0miD685TV2631y0Uck+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-CUc-NVqvO6ij1qHvpMbYGQ-1; Fri, 04 Sep 2020 14:20:29 -0400
X-MC-Unique: CUc-NVqvO6ij1qHvpMbYGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27FFD801ABB;
        Fri,  4 Sep 2020 18:20:28 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D0987E41F;
        Fri,  4 Sep 2020 18:20:27 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     Pradeep <pradeepthomas@gmail.com>
Cc:     bjschuma@netapp.com, Trond.Myklebust@netapp.com,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Wrong mode bits in stat of NFSv4 referral directories.
Date:   Fri, 04 Sep 2020 14:20:26 -0400
Message-ID: <A1BD3037-ED80-4D52-B6C8-6F837F2522E9@redhat.com>
In-Reply-To: <CAD8zhTD7mPjiUkRn_crywXDNP2kWGpMc8M4QFTG1T9eihuz9XQ@mail.gmail.com>
References: <CAD8zhTCZmZTosrtKbBatXo40Lt40OfzsZGw7tzHdcP4xo9rWCg@mail.gmail.com>
 <CAD8zhTDOZyhDnOqqO0uUVfscPFXj391frTEKT3dLu9rNZVNtzQ@mail.gmail.com>
 <CAD8zhTAA2c+cSNxDWwHnEa3-DTm8AEZKVMo7Xw9Wwpv8Wfsfzg@mail.gmail.com>
 <0226355B-58CD-4792-B7B9-B4447CC4FD7F@redhat.com>
 <CAD8zhTD7mPjiUkRn_crywXDNP2kWGpMc8M4QFTG1T9eihuz9XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I don't understand how the client can create a directory that can be a
referral.  Doesn't the directory have to be a mountpoint on the server?

I don't think that rsync can copy a namespace that contains refferal 
mounts
from the client side, but maybe I am really misunderstanding things..

Ben

On 4 Sep 2020, at 14:09, Pradeep wrote:

> Thanks Benjamin. Looks like it is added as part of commit
> 72de53ec4bca39c26709122a8f78bfefe7b6bca4 by Bryan Schumaker.
>
> Given that neither chmod nor readdir traverses the referral mount
> points, wouldn't this be an issue to return mode bits as 0555?
> The issue I see is with rsync. rsync first creates the directory and
> calls chmod. If this directory happens to be a referral mount, then
> chmod fails because the user doesn't have write access (0555).
>
> Thanks
>
> On Fri, Sep 4, 2020 at 10:15 AM Benjamin Coddington 
> <bcodding@redhat.com> wrote:
>>
>> Probably in nfs_fixup_secinfo_attributes(), and looks deliberate.  
>> I'm not
>> sure about the reasoning behind it, though.  Maybe it's to clarify 
>> that you
>> can't traverse this directory.
>>
>> Ben
>>
>> On 4 Sep 2020, at 12:57, Pradeep wrote:
>>
>>> Just to add, if you look at packet 100 (READDIR response) in 
>>> tcpdump,
>>> the mode bits are set to 0755. But what is displayed by "ls" is 
>>> 0555.
>>> I'm trying to figure out where that one bit gets lost.
>>>
>>> On Fri, Sep 4, 2020 at 8:55 AM Pradeep <pradeepthomas@gmail.com> 
>>> wrote:
>>>>
>>>> Hello,
>>>>
>>>> I'm seeing an issue where stat (and ls) reports wrong mode bits on
>>>> referral directories. Actual permissions are 755; but Linux client
>>>> displays 555. This causes some operations like setattr (chmod) to
>>>> fail. Traversing to the directory fixes the issue.
>>>>
>>>> Kernel version : 5.8.6-2.el7.elrepo.x86_64
>>>>
>>>> [nfstest@centos77 ~]$ mkdir /mnt/nfsh1/dir.{1..5}
>>>> [nfstest@centos77 ~]$ ls -l /mnt/nfsh1
>>>> total 3
>>>> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.1
>>>> drwxr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.2
>>>> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.3
>>>> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.4
>>>> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.5
>>>> [nfstest@centos77 ~]$ stat /mnt/nfsh1/dir.1
>>>>   File: ‘/mnt/nfsh1/dir.1’
>>>>   Size: 2               Blocks: 1          IO Block: 1048576 
>>>> directory
>>>> Device: 30h/48d Inode: 3940649673949864  Links: 2
>>>> Access: (0555/dr-xr-xr-x)  Uid: ( 2000/ nfstest)   Gid: (   10/   
>>>> wheel)
>>>> Context: system_u:object_r:nfs_t:s0
>>>> Access: 2020-09-03 17:55:59.082327209 -0400
>>>> Modify: 2020-09-03 17:55:59.082327209 -0400
>>>> Change: 2020-09-03 17:55:59.082327209 -0400
>>>>  Birth: -
>>>> [nfstest@centos77 ~]$ ls /mnt/nfsh1/dir.1  <-- Try traversing into 
>>>> the
>>>> dir, see the mode bits in stat after traversal.
>>>> [nfstest@centos77 ~]$ stat /mnt/nfsh1/dir.1
>>>>   File: ‘/mnt/nfsh1/dir.1’
>>>>   Size: 2               Blocks: 1          IO Block: 32768  
>>>> directory
>>>> Device: 32h/50d Inode: 3940649673949864  Links: 2
>>>> Access: (0755/drwxr-xr-x)  Uid: ( 2000/ nfstest)   Gid: (   10/   
>>>> wheel)
>>>> Context: system_u:object_r:nfs_t:s0
>>>> Access: 2020-09-03 17:55:59.082327209 -0400
>>>> Modify: 2020-09-03 17:55:59.082327209 -0400
>>>> Change: 2020-09-03 17:55:59.082327209 -0400
>>>>  Birth: -
>>>>
>>>> Attached is the tcpdump for requests. It looks like the server 
>>>> sends
>>>> back correct attributes; but the client somehow is ignoring it. Any
>>>> ideas why?
>>>>
>>>> Thanks,
>>>> Pradeep
>>

