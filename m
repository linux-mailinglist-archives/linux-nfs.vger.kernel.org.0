Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4B3F2578
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2019 03:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfKGCea (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Nov 2019 21:34:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727924AbfKGCea (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 6 Nov 2019 21:34:30 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 207EE97F2AC58024BB86;
        Thu,  7 Nov 2019 10:34:28 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.145) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 7 Nov 2019
 10:34:24 +0800
Subject: Re: [PATCH] NFS4: Fix v4.0 client state corruption when mount
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
References: <1557115023-86769-1-git-send-email-zhangxiaoxu5@huawei.com>
 <21D6F3D9-C1B6-4F5C-98A0-87B067C6E198@redhat.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <6348ccfd-4a61-5e82-fd2a-03b2c18fe220@huawei.com>
Date:   Thu, 7 Nov 2019 10:34:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <21D6F3D9-C1B6-4F5C-98A0-87B067C6E198@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.145]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



在 2019/11/7 0:47, Benjamin Coddington 写道:
> Hi ZhangXiaoxu,
> 
> I'm having a bit of trouble with this fix (which went upstream in
> f02f3755dbd14fb935d24b14650fff9ba92243b8).
> 
> Since this change, my client calls SETCLIENTID/SETCLIENTID_CONFIRM twice in
> quick succession on mount, and the second SETCLIENTID_CONFIRM sent by the state
> manager can sometimes have the same verifier sent back by the first
> SETCLIENTID's response.  I think we're missing a memory barrier somewhere..

nfs40_discover_server_trunking
	nfs4_proc_setclientid # the first time
	
after nfs4_schedule_state_manager, the state manager:
nfs4_run_state_manager
   nfs4_state_manager
     # 'nfs4_alloc_client' init state to NFS4CLNT_LEASE_EXPIRED
     nfs4_reclaim_lease
       nfs4_establish_lease
         nfs4_init_clientid
           nfs4_proc_setclientid # the second time.

> 
> But, I do not understand how the client was able to corrupt the state before
> this patch, and I don't understand how the patch fixes state corruption.
> 
> Can anyone enlighten me as to how we were corrupting state here?
when 'nfs4_alloc_client', the client state initialized with 'NFS4CLNT_LEASE_EXPIRED',
So, we should recover it when the client init.

After the first setclientid, maybe we should clear the 'NFS4CLNT_LEASE_EXPIRED', then
the state manager won't be called it again.

> 
> Ben
> 
> On 5 May 2019, at 23:57, ZhangXiaoxu wrote:
> 
>> stat command with soft mount never return after server is stopped.
>>
>> When alloc a new client, the state of the client will be set to
>> NFS4CLNT_LEASE_EXPIRED.
>>
>> When the server is stopped, the state manager will work, and accord
>> the state to recover. But the state is NFS4CLNT_LEASE_EXPIRED, it
>> will drain the slot table and lead other task to wait queue, until
>> the client recovered. Then the stat command is hung.
>>
>> When discover server trunking, the client will renew the lease,
>> but check the client state, it lead the client state corruption.
>>
>> So, we need to call state manager to recover it when detect server
>> ip trunking.
>>
>> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
>> ---
>>  fs/nfs/nfs4state.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
>> index 3de3647..f502f1c 100644
>> --- a/fs/nfs/nfs4state.c
>> +++ b/fs/nfs/nfs4state.c
>> @@ -159,6 +159,10 @@ int nfs40_discover_server_trunking(struct nfs_client *clp,
>>          /* Sustain the lease, even if it's empty.  If the clientid4
>>           * goes stale it's of no use for trunking discovery. */
>>          nfs4_schedule_state_renewal(*result);
>> +
>> +        /* If the client state need to recover, do it. */
>> +        if (clp->cl_state)
>> +            nfs4_schedule_state_manager(clp);
>>      }
>>  out:
>>      return status;
>> -- 
>> 2.7.4
> 
> 
> .

