Return-Path: <linux-nfs+bounces-10079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1068A33F27
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 13:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55011188CC82
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0338221577;
	Thu, 13 Feb 2025 12:28:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02F21D3F9;
	Thu, 13 Feb 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449690; cv=none; b=n9SEMj2lgw269b94rhAg1hAArrRdySl7vvICEGYRMPE03CbCz84zMoNwhiNcdYrk6D7v15Ssp3K+W4csyYOHymJfvWXWt1jE0AyNokNJ5Od2p+VxkeCBGeIph5G9p+ekFkCX36XMVtQ/3z61U2eJbFdyNRS6BKSboHO91b6CSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449690; c=relaxed/simple;
	bh=EAxsE2di2w+Suc7tMK3XIoJ7C/4rGfr/+ZDTxhdOA/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AxUbumStcBMGH0HMEVh3LeT5OUgf+CxAheXGMmsMzp7rPzRNywFsy2c3DAEE5TjxRaXt+fYgaFTuOXJ8T4hQjPl84T9+ovOLRo1NYh0y/ZQ/BwIX036qDRjVFnmcb22A8fWi35t9zEDctl8r9c8ypzvcJF9RrtHSn/wxgxTngCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YtvW50wk7z1ltXT;
	Thu, 13 Feb 2025 20:24:17 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EEE2180214;
	Thu, 13 Feb 2025 20:28:04 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 20:28:03 +0800
Message-ID: <d4c3b347-477f-4016-8093-edac22213cec@huawei.com>
Date: Thu, 13 Feb 2025 20:28:02 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: put dl_stid if fail to queue dl_recall
To: Jeff Layton <jlayton@kernel.org>, <chuck.lever@oracle.com>,
	<neilb@suse.de>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250213072536.69986-1-lilingfeng3@huawei.com>
 <7df4de2bff617dc5c2bb482df6dbc5ef21ba0d01.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <7df4de2bff617dc5c2bb482df6dbc5ef21ba0d01.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/2/13 19:49, Jeff Layton 写道:
> On Thu, 2025-02-13 at 15:25 +0800, Li Lingfeng wrote:
>> Before calling nfsd4_run_cb to queue dl_recall to the callback_wq, we
>> increment the reference count of dl_stid.
>> We expect that after the corresponding work_struct is processed, the
>> reference count of dl_stid will be decremented through the callback
>> function nfsd4_cb_recall_release.
>> However, if the call to nfsd4_run_cb fails, the incremented reference
>> count of dl_stid will not be decremented correspondingly, leading to the
>> following nfs4_stid leak:
>> unreferenced object 0xffff88812067b578 (size 344):
>>    comm "nfsd", pid 2761, jiffies 4295044002 (age 5541.241s)
>>    hex dump (first 32 bytes):
>>      01 00 00 00 6b 6b 6b 6b b8 02 c0 e2 81 88 ff ff  ....kkkk........
>>      00 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 ad 4e ad de  .kkkkkkk.....N..
>>    backtrace:
>>      kmem_cache_alloc+0x4b9/0x700
>>      nfsd4_process_open1+0x34/0x300
>>      nfsd4_open+0x2d1/0x9d0
>>      nfsd4_proc_compound+0x7a2/0xe30
>>      nfsd_dispatch+0x241/0x3e0
>>      svc_process_common+0x5d3/0xcc0
>>      svc_process+0x2a3/0x320
>>      nfsd+0x180/0x2e0
>>      kthread+0x199/0x1d0
>>      ret_from_fork+0x30/0x50
>>      ret_from_fork_asm+0x1b/0x30
>> unreferenced object 0xffff8881499f4d28 (size 368):
>>    comm "nfsd", pid 2761, jiffies 4295044005 (age 5541.239s)
>>    hex dump (first 32 bytes):
>>      01 00 00 00 00 00 00 00 30 4d 9f 49 81 88 ff ff  ........0M.I....
>>      30 4d 9f 49 81 88 ff ff 20 00 00 00 01 00 00 00  0M.I.... .......
>>    backtrace:
>>      kmem_cache_alloc+0x4b9/0x700
>>      nfs4_alloc_stid+0x29/0x210
>>      alloc_init_deleg+0x92/0x2e0
>>      nfs4_set_delegation+0x284/0xc00
>>      nfs4_open_delegation+0x216/0x3f0
>>      nfsd4_process_open2+0x2b3/0xee0
>>      nfsd4_open+0x770/0x9d0
>>      nfsd4_proc_compound+0x7a2/0xe30
>>      nfsd_dispatch+0x241/0x3e0
>>      svc_process_common+0x5d3/0xcc0
>>      svc_process+0x2a3/0x320
>>      nfsd+0x180/0x2e0
>>      kthread+0x199/0x1d0
>>      ret_from_fork+0x30/0x50
>>      ret_from_fork_asm+0x1b/0x30
>> Fix it by checking the result of nfsd4_run_cb and call nfs4_put_stid if
>> fail to queue dl_recall.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfsd/nfs4state.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 153eeea2c7c9..0ccb87be47b7 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5414,6 +5414,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
>>   
>>   static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>>   {
>> +	bool queued;
>>   	/*
>>   	 * We're assuming the state code never drops its reference
>>   	 * without first removing the lease.  Since we're in this lease
>> @@ -5422,7 +5423,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>>   	 * we know it's safe to take a reference.
>>   	 */
>>   	refcount_inc(&dp->dl_stid.sc_count);
>> -	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>> +	queued = nfsd4_run_cb(&dp->dl_recall);
>> +	WARN_ON_ONCE(!queued);
>> +	if (!queued)
>> +		nfs4_put_stid(&dp->dl_stid);
>>   }
>>   
>>   /* Called from break_lease() with flc_lock held. */
>
> Have you actually seen the WARN_ON_ONCE() pop under normal usage, or
> was the problem you reproduced done via fault injection?

Hi,

I add mdelay for cb_work before processing it and add msleep in 
nfs_do_return_delegation to reproduce it.

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1188,6 +1188,8 @@ alloc_init_deleg(struct nfs4_client *clp, struct 
nfs4_file *fp,
      dp->dl_recalled = false;
      nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
                &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
+    dp->dl_recall.cb_work.debug_flag = 0x1234;
+    printk("%s init work func %px\n", __func__, 
dp->dl_recall.cb_work.func);
      get_nfs4_file(fp);
      dp->dl_stid.sc_file = fp;
      return dp;

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2708,6 +2708,12 @@ static void process_scheduled_works(struct worker 
*worker)
              worker->pool->watchdog_ts = jiffies;
              first = false;
          }
+        if (work->debug_flag == 0x1234) {
+            printk("%s func %px\n", __func__, work->func);
+            printk("%s delay before clear pending...\n", __func__);
+            mdelay(10 * 1000);
+            printk("%s delay done\n", __func__);
+        }
          process_one_work(worker, work);
      }
  }

--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -263,6 +263,15 @@ static int nfs_do_return_delegation(struct inode 
*inode, struct nfs_delegation *
      const struct cred *cred;
      int res = 0;

+    printk("sleep before deleg return...\n");
+    while (1) {
+        ifdebug(PROC)
+            msleep(10 * 1000);
+        else
+            break;
+    }
+    printk("sleep done\n");
+
      if (!test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
          spin_lock(&delegation->lock);
          cred = get_cred(delegation->cred);

> Unfortunately, this won't work. nfsd_break_one_deleg() is called from
> the ->break_lease callback with the flc->flc_lock held, and
> nfs4_put_stid can sleep in the sc_free callbacks.

Are you referring to nfs4_free_deleg? I didn't quite see where it might 
sleep. Could you please explain it to me?

Thanks.


