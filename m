Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4292D2B3B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgLHMj6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 07:39:58 -0500
Received: from smtp-o-2.desy.de ([131.169.56.155]:55585 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgLHMj6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Dec 2020 07:39:58 -0500
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id EABDD160FE7
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 13:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de EABDD160FE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1607431155; bh=t/iB3fMj5wIDVREUgL8Cf2zGHFAmIZicMFyc3dxPiBc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OIzJqQeVpUGublp5QfH5vG0QiW+mCPo6pjg2aGU0D5c1t7caM/COjWc+otyVRaThR
         PD3CromO5cBOKDFr/eSYBVOAKQn9uiOXXvHYw9+mJeqQa0R/Ofti6OkJddFSTMg0sK
         2uck/kR5QDMYPxd8uKvrPYbselAMifpx5d3IC4Qo=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id E21771A0118;
        Tue,  8 Dec 2020 13:39:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id B2E981001A7;
        Tue,  8 Dec 2020 13:39:14 +0100 (CET)
Date:   Tue, 8 Dec 2020 13:39:14 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     schumaker anna <schumaker.anna@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
Message-ID: <1111815800.2958679.1607431154107.JavaMail.zimbra@desy.de>
In-Reply-To: <1013351928.2746343.1607356477964.JavaMail.zimbra@desy.de>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com> <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de> <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com> <1368097703.2347355.1607122227971.JavaMail.zimbra@desy.de> <1275679128.2737941.1607354764999.JavaMail.zimbra@desy.de> <1013351928.2746343.1607356477964.JavaMail.zimbra@desy.de>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Mac)/8.8.15_GA_3980)
Thread-Topic: Disable READ_PLUS by default
Thread-Index: CVXkTobkLp+LUmxBgVQ7J6y9MaGlng1S/xZ1aDQrBX/CYLAwQA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Hi Anna et al.,

I run some more test and found two issues:

1. our server returns on getdeviceinfo notification bitmap of size 2.
   Though, only the first element has non zero values, some how this
   makes client unhappy, probably due to definition on decode_getdeviceinfo_maxsz
   that expects bitmap length to be 1.

2. The client uses READ_PLUS to DS despite the fact that flex file
   layout stated that DS supports nfs v4.1

Network File System, Ops(3): SEQUENCE, PUTFH, READ_PLUS
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
    minorversion: 1
    Operations (count: 3): SEQUENCE, PUTFH, READ_PLUS
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: READ_PLUS (68)
            StateID
            offset: 0
            count: 10016
    [Main Opcode: READ_PLUS (68)]


I should re-run some tests with Trond's tree as I was checking the
DS errors in during the test I run last weeks.

Regards,
   Tigran.

----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "Anna Schumaker" <Anna.Schumaker@netapp.com>
> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Olga Kornievskaia"
> <aglo@umich.edu>
> Sent: Monday, 7 December, 2020 16:54:37
> Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default

> Sorry, completely confused. It the same commit as before
> c567552612ece787b178e3b147b5854ad422a836
> 
> Tigran.
> 
> 
> ----- Original Message -----
>> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>> To: "Anna Schumaker" <Anna.Schumaker@netapp.com>
>> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs"
>> <linux-nfs@vger.kernel.org>, "Olga Kornievskaia"
>> <aglo@umich.edu>
>> Sent: Monday, 7 December, 2020 16:26:05
>> Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
> 
>> Hi Anna
>> 
>> I re-run bisect on your tree with tag nfs-for-5.10-1 as bad and 5.9.0 as good.
>> 
>> The bisect point to commit a14a63594cc2e5bdcbb1543d29df945da71e380f, which makes
>> more sense.
>> 
>> [centos@os-46-nfs-devel linux-nfs]$ git bisect good
>> c567552612ece787b178e3b147b5854ad422a836 is the first bad commit
>> commit c567552612ece787b178e3b147b5854ad422a836
>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> Date:   Wed May 28 13:41:22 2014 -0400
>> 
>>    NFS: Add READ_PLUS data segment support
>> 
>>    This patch adds client support for decoding a single NFS4_CONTENT_DATA
>>    segment returned by the server. This is the simplest implementation
>>    possible, since it does not account for any hole segments in the reply.
>> 
>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> 
>> fs/nfs/nfs42xdr.c         | 141 ++++++++++++++++++++++++++++++++++++++++++++++
>> fs/nfs/nfs4client.c       |   2 +
>> fs/nfs/nfs4proc.c         |  43 +++++++++++++-
>> fs/nfs/nfs4xdr.c          |   1 +
>> include/linux/nfs4.h      |   2 +-
>> include/linux/nfs_fs_sb.h |   1 +
>> include/linux/nfs_xdr.h   |   2 +-
>> 7 files changed, 187 insertions(+), 5 deletions(-)
>> 
>> 
>> Best regards,
>>   Tigran
>> 
>> ----- Original Message -----
>>> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>>> To: "Olga Kornievskaia" <aglo@umich.edu>
>>> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs"
>>> <linux-nfs@vger.kernel.org>, "Anna Schumaker"
>>> <Anna.Schumaker@netapp.com>
>>> Sent: Friday, 4 December, 2020 23:50:27
>>> Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
>> 
>>> I agree with Olga, especially that disabling doesn't fixes my issue.
>>> Unfortunately I have no idea how kernel's vm works, but I am
>>> ready to test as many times as needed.
>>> 
>>> Thanks,
>>>   Tigran.
>>> 
>>> ----- Original Message -----
>>>> From: "Olga Kornievskaia" <aglo@umich.edu>
>>>> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>>>> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs"
>>>> <linux-nfs@vger.kernel.org>, "Anna Schumaker"
>>>> <Anna.Schumaker@netapp.com>
>>>> Sent: Friday, 4 December, 2020 21:00:32
>>>> Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
>>> 
>>>> I object to putting the disable patch in, I think we need to fix the problem.
>>>> 
>>>> The current problem is generic/263 is failing because the end of the
>>>> buffer is corrupted since we lost the bytes when hole was expanded. I
>>>> don't know what the solution is: (1) hole expanding handling needs to
>>>> be fixed to not lose data or (2) we shouldnt be reporting that we read
>>>> the bytes we lost.
>>>> 
>>>> On Fri, Dec 4, 2020 at 10:49 AM Mkrtchyan, Tigran
>>>> <tigran.mkrtchyan@desy.de> wrote:
>>>>>
>>>>> Hi Anna,
>>>>>
>>>>> I see problems with gedeviceinfo and bisected it to
>>>>> c567552612ece787b178e3b147b5854ad422a836.
>>>>> The commit itself doesn't look that can break it, but might
>>>>> be can help you find the problem.
>>>>>
>>>>> What I see, that after xdr_read_pages call the xdr stream points
>>>>> to a some random point (or wrong page)
>>>>>
>>>>> Regards,
>>>>>    Tigran.
>>>>>
>>>>>
>>>>> ----- Original Message -----
>>>>> > From: "schumaker anna" <schumaker.anna@gmail.com>
>>>>> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
>>>>> > Cc: "Anna Schumaker" <Anna.Schumaker@Netapp.com>
>>>>> > Sent: Thursday, 3 December, 2020 21:18:38
>>>>> > Subject: [PATCH 0/3] NFS: Disable READ_PLUS by default
>>>>>
>>>>> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>> >
>>>>> > I've been scratching my head about what's going on with xfstests generic/091
>>>>> > and generic/263, but I'm not sure what else to look at at this point.
>>>>> > This patchset disables READ_PLUS by default by marking it as a
>>>>> > developer-only kconfig option.
>>>>> >
>>>>> > I also included a couple of patches fixing some other issues that were
>>>>> > noticed while inspecting the code. These patches don't help the tests
>>>>> > pass, but they do fail later on after applying so it does feel like
>>>>> > progress.
>>>>> >
>>>>> > I'm hopeful the remaning issues can be worked out in the future.
>>>>> >
>>>>> > Thanks,
>>>>> > Anna
>>>>> >
>>>>> >
>>>>> > Anna Schumaker (3):
>>>>> >  NFS: Disable READ_PLUS by default
>>>>> >  NFS: Allocate a scratch page for READ_PLUS
>>>>> >  SUNRPC: Keep buf->len in sync with xdr->nwords when expanding holes
>>>>> >
>>>>> > fs/nfs/Kconfig          |  9 +++++++++
>>>>> > fs/nfs/nfs42xdr.c       |  2 ++
>>>>> > fs/nfs/nfs4proc.c       |  2 +-
>>>>> > fs/nfs/read.c           | 13 +++++++++++--
>>>>> > include/linux/nfs_xdr.h |  1 +
>>>>> > net/sunrpc/xdr.c        |  3 ++-
>>>>> > 6 files changed, 26 insertions(+), 4 deletions(-)
>>>>> >
>>>>> > --
> > > > > > 2.29.2
