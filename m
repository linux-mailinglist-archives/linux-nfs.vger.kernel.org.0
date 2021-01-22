Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A5300602
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 15:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbhAVOu0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 09:50:26 -0500
Received: from p3plsmtpa12-08.prod.phx3.secureserver.net ([68.178.252.237]:51037
        "EHLO p3plsmtpa12-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728984AbhAVOtT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 09:49:19 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 2xjflmTBrQ0Kc2xjglO3Ju; Fri, 22 Jan 2021 07:48:28 -0700
X-CMAE-Analysis: v=2.4 cv=R7PGpfdX c=1 sm=1 tr=0 ts=600ae5bc
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=mJjC6ScEAAAA:8 a=EteVbA96QvwO699y0qkA:9 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: nfsd vurlerability submit
To:     Patrick Goetz <pgoetz@math.utexas.edu>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
 <eb09db3a-9b43-cf03-5db4-3af33cb160e6@math.utexas.edu>
 <20210121220402.GF20964@fieldses.org>
 <a6429a2c-ce90-caec-0704-6626cd564300@math.utexas.edu>
 <20210122013019.GA30323@fieldses.org>
 <db4ccb47-370c-7f05-ae15-41b7cd90c2d7@math.utexas.edu>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b270b5cc-4477-80a1-a602-11c13e8afa89@talpey.com>
Date:   Fri, 22 Jan 2021 09:48:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <db4ccb47-370c-7f05-ae15-41b7cd90c2d7@math.utexas.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJ7GB/Xib+FIam9XRqCzQ6CXRCylP1c2NWFabOKA1MTXgvBbrNaL9SUwIwTo4fn9LlFx6vZGYh7NMqnWhlgtZv8FdAwIBNZ2Tfz64Jur047XxcTTjxuH
 RJbKmyxmR6ZKIK6maQ0QVm8m/qw/Vd3IPgj6Cga9AHKueEqCDi+k7Pe1AGPK2H+FG8CigkZDzoGKnFOkGOZkgnOp4WsqhIuKrPyqa+ZtcoCj9vbxnHCtfh3k
 lzE9WGJ6ogA4Us0e0aZjUOOLp2FDamvE3fYZ4t/MIqkFwdt/2id/QJfFXJjOKr71ixghrH9KW8fq5lS1QNi/BGSnMq4B6OThCr6FlW/k9goxioth8TKHepA4
 0TRxY5AqXL7J/76/1xiY2eHkGA310kwsFX96iOeNd6EI03tApnFKDlPaS2GbC6WbQk3AI8tiCtMN6rSCMFEpdIICbs1Qxg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/22/2021 8:20 AM, Patrick Goetz wrote:
> Thanks for engaging; this has been informative.
> 
> On 1/21/21 7:30 PM, bfields@fieldses.org wrote:
>> On Thu, Jan 21, 2021 at 05:19:32PM -0600, Patrick Goetz wrote:
>>> On 1/21/21 4:04 PM, bfields@fieldses.org wrote:
>>>> As I said, NFS allows you to look up objects by filehandle (so,
>>>> basically by inode number), not just by path
>>>
>>> Except surely this doesn't buy you much if you don't have root
>>> access to the system?  Is this all only an issue when the
>>> filesystems are exported with no_root_squash?
>>>
>>> I feel like I must be missing something, but it seems to me that if
>>> I'm not root, I'm not going to be able to access inodes I don't have
>>> permissions to access even when directly connected to the exporting
>>> server.
>>
>> If an attacker has access to the network (so they can send their own
>> hand-crafted NFS requests), then filehandle guessing allows them to
>> bypass the normal process of looking up a file.  So if you were
>> depending on lookup permissions along that path, or on hiding that path
>> somehow, you're out of luck.
>>
>> But it doesn't let them bypass the permissions on the file itself once
>> they get there.  If the permissions on the file don't allow read, the
>> server still won't let them read it.
>>
> 
> That's probably good enough. Security through obscurity isn't a good 
> idea, so file/directory level permissions should be atomically correct 
> and not rely on directory hierarchies, restricted direct access by 
> users, or anything like this.
> 
> I didn't not know about the filehandle guessing thing and will keep that 
> in mind for the next NFS server I deploy.

There are some NFS clients which implement open-by-filehandle, and don't
rely on lookup at all in normal operation. It is highly efficient, and
provides a very low latency file access. I believe Yahoo was the first
to implement it at scale in production, but it's a very straightforward
cache operation.

Tom.

>>>>> It's not practical to making everything you export its own partition;
>>>>> although I suppose one could do this with ZFS datasets.
>>>>
>>>> I'd be happy to hear about any use cases where that's not practical.
>>>
>>> Sure. The xray example is taken from one of my research groups which
>>> collects thousands of very large electron microscopy images, along
>>> with some xray data. I will certainly design this differently in the
>>> next iteration (most likely using ZFS), but our current server has a
>>> 519T attached storage device which presents itself as a single
>>> device: /dev/sdg.  Different groups need access to different classes
>>> of data, which I export separately and with are presented on the
>>> workstations as /xray, /EM, etc..
>>>
>>> Yes, I could partition the storage device, but then I run into the
>>> usual issues where one partition runs out of space while others are
>>> barely utilized. This is one good reason to switch to ZFS datasets.
>>> The other is that -- with 450T+ of ever changing data, currently
>>> rsync backups are almost impossible.  I'm hoping zfs send/receive is
>>> going to save me here.
>>>
>>>> As Christophe pointed out, xfs/ext4 project ids are another option.
>>>
>>> I must have missed this one, but it just leaves me more confused.
>>> Project ID's are filesystem metadata, yet this affords better
>>> boundary enforcement than a bind mount?
>>
>> Right.  The project ID is stored in the inode, so it's easy to look up
>> from the filehandle.  (Whereas figuring out what paths might lead to
>> that inode is a little tricker.)
>>
>>> Also, the only use case for Project ID's I was able to find are
>>> project quotas, so am not even sure how this would be implemented, and
>>> used by NFS.
>>
>> Project ID's were implemented for quotas, but they also have the
>> characteristics to work well as NFS export boundaries.
>>
>> That said, I think Christoph was suggesting this is something we *could*
>> support, not something that we now do.  Though looking at it quickly, I
>> think it shouldn't take much code at all.  I'll put it on my list....
>>
>> Other options for doing this kind of thing might be btrfs subvolumes or
>> lvm thin provisioning.  I haven't personally used either, but they
>> should both work now.
>>
>> --b.
>>
> 
