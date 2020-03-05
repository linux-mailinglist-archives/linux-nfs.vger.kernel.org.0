Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA0B179E64
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2020 04:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgCEDqW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 22:46:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgCEDqW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Mar 2020 22:46:22 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 794E7EBDBB5B7903EDA3;
        Thu,  5 Mar 2020 11:46:20 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Mar 2020
 11:46:18 +0800
Subject: Re: [PATCH] nfsd: Fix build error
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20200304131803.46560-1-yuehaibing@huawei.com>
 <BC0E3531-B282-4C04-9540-C39C6F4A1A5D@oracle.com>
 <20200304200609.GA26924@fieldses.org>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <ff3a1cae-c628-9324-f32f-c7e694585686@huawei.com>
Date:   Thu, 5 Mar 2020 11:46:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200304200609.GA26924@fieldses.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020/3/5 4:06, Bruce Fields wrote:
> On Wed, Mar 04, 2020 at 01:00:12PM -0500, Chuck Lever wrote:
>> Hi-
>>
>>> On Mar 4, 2020, at 8:18 AM, YueHaibing <yuehaibing@huawei.com> wrote:
>>>
>>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
>>> nfs4proc.c:(.text+0x23b7): undefined reference to `nfs42_ssc_close'
>>> fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
>>> nfs4proc.c:(.text+0x5d2a): undefined reference to `nfs_sb_deactive'
>>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
>>> nfs4proc.c:(.text+0x61d5): undefined reference to `nfs42_ssc_open'
>>> nfs4proc.c:(.text+0x6389): undefined reference to `nfs_sb_deactive'
>>>
>>> Add dependency to NFSD_V4_2_INTER_SSC to fix this.
>>>
>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>> fs/nfsd/Kconfig | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>>> index f368f32..fc587a5 100644
>>> --- a/fs/nfsd/Kconfig
>>> +++ b/fs/nfsd/Kconfig
>>> @@ -136,6 +136,7 @@ config NFSD_FLEXFILELAYOUT
>>>
>>> config NFSD_V4_2_INTER_SSC
>>> 	bool "NFSv4.2 inter server to server COPY"
>>> +	depends on !(NFSD=y && NFS_FS=m)
>>
>> The new dependency is not especially clear to me; more explanation
>> in the patch description about the cause of the build failure
>> would definitely be helpful.
>>
>> NFSD_V4 can't be set unless NFSD is also set.
>>
>> NFS_V4_2 can't be set unless NFS_V4_1 is also set, and that cannot
>> be set unless NFS_FS is also set.
>>
>> So what's really going on here?
> 
> I don't understand that "depends" either.
> 
> The fundamental problem, though, is that nfsd is calling nfs code
> directly.

Yes

> 
> Which I noticed in earlier review and then forgot to follow up on,
> sorry.
> 
> So either we:
> 
> 	- let nfsd depend on nfs, fix up Kconfig to reflect the fact, or

It only fails while NFSD=y && NFS_FS=m, other cases works fine as Chuck Lever pointed.

> 	- write some code so nfsd can load nfs and find those symbols at
> 	  runtime if it needs to do a copy.
> 
> The latter's certainly doable, but it'd be simplest to do the former.
> Are there actually a lot of people who want nfsd but not nfs?  Does that
> cause a real problem for anyone?
> 
> --b.
> 
> .
> 

