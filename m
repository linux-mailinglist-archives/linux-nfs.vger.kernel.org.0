Return-Path: <linux-nfs+bounces-9191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC7A0FE52
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 02:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E4318882E3
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 01:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB181C54A7;
	Tue, 14 Jan 2025 01:54:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51E1805A;
	Tue, 14 Jan 2025 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736819665; cv=none; b=MFO9rXAxRZlOtIEI1Nj28h+QbDNiJ2kjJ1fDf2aRae/5M3nPQ9TDsz4mvEr/sZpTHc5m45Ye2t52980StKst8Umt8hBQpxhYYG1NCPyzeQvaOO/JpTCIaSEXRmea2w715IRIoh0yQSlQCC8ixMWsyDOjcPtLo6M28QPMDVgyksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736819665; c=relaxed/simple;
	bh=kglWDEOM7fHmFfE3fJz5B5+uS6JHLnAKeLbPIfAzFxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LScjXLAiLxLoUlaAx/UWaflr73fHSAZU8vPRowdB2ichRFzPRLvCT2AV61WFSxYzqeZEJejhYlBtNSHcz4UphKhHqyD+vq0Wko5TBIgsj36sLILUC9tktHc0f4r82GHeul1p8E4Q89Hdes7Dc7/9zcq5+MDFdUsXMqS8u8Eo7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YXBtQ5SQmz1V4nP;
	Tue, 14 Jan 2025 09:51:10 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id E062F1402DB;
	Tue, 14 Jan 2025 09:54:19 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jan 2025 09:54:18 +0800
Message-ID: <48364ac5-8417-4f3b-8d9f-350d00a24d0b@huawei.com>
Date: Tue, 14 Jan 2025 09:54:18 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
To: Chuck Lever <chuck.lever@oracle.com>, <jlayton@kernel.org>,
	<neilb@suse.de>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250113025957.1253214-1-lilingfeng3@huawei.com>
 <37d6dab7-5031-4b96-b66e-9ba8f17d1adc@oracle.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <37d6dab7-5031-4b96-b66e-9ba8f17d1adc@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/1/13 22:07, Chuck Lever 写道:
> Hello!
>
> On 1/12/25 9:59 PM, Li Lingfeng wrote:
>> In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_lru
>> list, gc may be triggered in another thread and immediately release this
>> nfsd_file, which will lead to a UAF when accessing this nfsd_file again.
>
> Do you happen to have a reproducer that can trigger this issue?
>
Hi, thanks for your reply.

Here is the reproducer:

Patch:
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c

index 585163b4e11c..8a8245b0ce32 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -356,6 +356,7 @@ nfsd_file_get(struct nfsd_file *nf)
  void
  nfsd_file_put(struct nfsd_file *nf)
  {
+ static int count = 0;
         might_sleep();
         trace_nfsd_file_put(nf);

@@ -370,6 +371,11 @@ nfsd_file_put(struct nfsd_file *nf)

                 /* Try to add it to the LRU. If that fails, decrement. */
                 if (nfsd_file_lru_add(nf)) {
+ if (count++ % 3 == 0) {
+ printk("%s %d sleep before test...\n", __func__, __LINE__);
+ msleep(5000);
+ printk("%s %d sleep done\n", __func__, __LINE__);
+ }
                         /* If it's still hashed, we're done */
                         if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
                                 nfsd_file_schedule_laundrette();

Steps:
mkfs.ext4 -F /dev/sdb
mount /dev/sdb /mnt/sdb
echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt/sdb *(rw,no_root_squash,fsid=1)" >> /etc/exports
systemctl restart nfs-server

for i in {1..10}; do filename="file$i.txt"; echo "123" > 
/mnt/sdb/"$filename"; done
mount -t nfs -o rw,relatime,vers=3 127.0.0.1:/mnt/sdb /mnt/sdbb
sh test.sh

test.sh:
for i in {1..10}; do
     filename="file$i.txt"
     cat /mnt/sdbb/"$filename" &
done

[  205.114996][ T2409] 
==================================================================

[  205.115006][ T2409] BUG: KASAN: slab-use-after-free in 
nfsd_file_put+0x190/0x3b0
[  205.115055][ T2409] Read of size 8 at addr ffff88810798f3e8 by task 
nfsd/2409
[  205.115062][ T2409]
[  205.115068][ T2409] CPU: 1 UID: 0 PID: 2409 Comm: nfsd Not tainted 
6.13.0-rc6-00038-g09a0fa92e5b4-dirty #83
[  205.115078][ T2409] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
123[  205.115085][ T2409] Call Trace:
[  205.115095][ T2409]  <TASK>

[  205.115101][ T2409]  dump_stack_lvl+0x68/0xa0
[  205.115117][ T2409] print_address_description.constprop.0+0x2c/0x3d0
[  205.115132][ T2409]  ? nfsd_file_put+0x190/0x3b0
[  205.115140][ T2409]  print_report+0xb3/0x270
123[  205.115147][ T2409]  ? kasan_addr_to_slab+0xd/0xa0
[  205.115160][ T2409]  kasan_report+0x93/0xc0

[  205.115168][ T2409]  ? nfsd_file_put+0x190/0x3b0
[  205.115196][ T2409]  kasan_check_range+0xf6/0x1b0
[  205.115207][ T2409]  nfsd_file_put+0x190/0x3b0
[  205.115217][ T2409]  nfsd_read+0x151/0x3b0
[  205.115229][ T2409]  ? __pfx_nfsd_read+0x10/0x10
[  205.115238][ T2409]  ? lock_acquire+0x15c/0x3f0
[  205.115249][ T2409]  ? nfsd_init_request+0x6b/0x300
[  205.115259][ T2409]  ? rcu_is_watching+0x20/0x50
[  205.115272][ T2409]  nfsd3_proc_read+0x1c9/0x280
[  205.115285][ T2409]  nfsd_dispatch+0x1b7/0x4c0
[  205.115294][ T2409]  ? __pfx_nfsd_dispatch+0x10/0x10
[  205.115305][ T2409]  ? __asan_memset+0x24/0x50
[  205.115315][ T2409]  ? rcu_is_watching+0x20/0x50
[  205.115325][ T2409]  svc_process_common+0x615/0xd20
[  205.115346][ T2409]  ? __pfx_svc_process_common+0x10/0x10
[  205.115359][ T2409]  ? __pfx_nfsd_dispatch+0x10/0x10
[  205.115374][ T2409]  ? mark_held_locks+0x24/0x90
[  205.115388][ T2409]  ? xdr_init_decode+0x11d/0x190
[  205.115410][ T2409]  svc_process+0x2a8/0x430
[  205.115435][ T2409]  svc_handle_xprt+0x71c/0xb40
[  205.115458][ T2409]  svc_recv+0x5f1/0x9b0
[  205.115477][ T2409]  ? svc_recv+0xab/0x9b0
[  205.115501][ T2409]  nfsd+0x1e7/0x390
[  205.115522][ T2409]  ? __pfx_nfsd+0x10/0x10
[  205.115536][ T2409]  kthread+0x1a7/0x1f0
[  205.115551][ T2409]  ? kthread+0xfb/0x1f0
[  205.139288][ T2409]  ? __pfx_kthread+0x10/0x10
[  205.139769][ T2409]  ret_from_fork+0x34/0x60
[  205.140238][ T2409]  ? __pfx_kthread+0x10/0x10
[  205.140701][ T2409]  ret_from_fork_asm+0x1a/0x30
[  205.141226][ T2409]  </TASK>
[  205.141548][ T2409]
[  205.141809][ T2409] Allocated by task 2409:
[  205.142254][ T2409]  kasan_save_stack+0x24/0x50
[  205.142726][ T2409]  kasan_save_track+0x14/0x30
[  205.143214][ T2409]  __kasan_slab_alloc+0x87/0x90
[  205.143694][ T2409]  kmem_cache_alloc_noprof+0x162/0x4a0
[  205.144268][ T2409]  nfsd_file_do_acquire+0x3a2/0x1420
[  205.144812][ T2409]  nfsd_file_acquire_gc+0x5a/0x80
[  205.145338][ T2409]  nfsd_read+0xc6/0x3b0
[  205.145766][ T2409]  nfsd3_proc_read+0x1c9/0x280
[  205.146226][ T2409]  nfsd_dispatch+0x1b7/0x4c0
[  205.146682][ T2409]  svc_process_common+0x615/0xd20
[  205.147212][ T2409]  svc_process+0x2a8/0x430
[  205.147652][ T2409]  svc_handle_xprt+0x71c/0xb40
[  205.148140][ T2409]  svc_recv+0x5f1/0x9b0
[  205.148569][ T2409]  nfsd+0x1e7/0x390
[  205.148966][ T2409]  kthread+0x1a7/0x1f0
[  205.149388][ T2409]  ret_from_fork+0x34/0x60
[  205.149838][ T2409]  ret_from_fork_asm+0x1a/0x30
[  205.150330][ T2409]
[  205.150646][ T2409] Freed by task 0:
[  205.151120][ T2409]  kasan_save_stack+0x24/0x50
[  205.151778][ T2409]  kasan_save_track+0x14/0x30
[  205.152409][ T2409]  kasan_save_free_info+0x3a/0x60
[  205.153073][ T2409]  __kasan_slab_free+0x54/0x70
[  205.153677][ T2409]  kmem_cache_free+0x159/0x5f0
[  205.154169][ T2409]  rcu_do_batch+0x311/0x900
[  205.154643][ T2409]  rcu_core+0x58c/0x6f0
[  205.155065][ T2409]  handle_softirqs+0xf8/0x570
[  205.155526][ T2409]  irq_exit_rcu+0x141/0x160
[  205.156004][ T2409]  sysvec_apic_timer_interrupt+0x76/0x90
[  205.156575][ T2409]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  205.157196][ T2409]
[  205.157416][ T2409] Last potentially related work creation:
[  205.157986][ T2409]  kasan_save_stack+0x24/0x50
[  205.158404][ T2409]  __kasan_record_aux_stack+0xa6/0xc0
[  205.158893][ T2409]  __call_rcu_common.constprop.0+0xa5/0x8f0
[  205.159515][ T2409]  nfsd_file_dispose_list+0x93/0xc0
[  205.160067][ T2409]  nfsd_file_net_dispose+0x1ad/0x1f0
[  205.160613][ T2409]  nfsd+0x1ef/0x390
[  205.161021][ T2409]  kthread+0x1a7/0x1f0
[  205.161451][ T2409]  ret_from_fork+0x34/0x60
[  205.161908][ T2409]  ret_from_fork_asm+0x1a/0x30
[  205.162407][ T2409]
[  205.162663][ T2409] The buggy address belongs to the object at 
ffff88810798f3b8
[  205.162663][ T2409]  which belongs to the cache nfsd_file of size 128
[  205.164061][ T2409] The buggy address is located 48 bytes inside of
[  205.164061][ T2409]  freed 128-byte region [ffff88810798f3b8, 
ffff88810798f438)
[  205.165446][ T2409]
[  205.165678][ T2409] The buggy address belongs to the physical page:
[  205.166340][ T2409] page: refcount:1 mapcount:0 
mapping:0000000000000000 index:0xffff88810798f4a8 pfn:0x10798e
[  205.167356][ T2409] head: order:1 mapcount:0 entire_mapcount:0 
nr_pages_mapped:0 pincount:0
[  205.168204][ T2409] flags: 
0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
[  205.169071][ T2409] page_type: f5(slab)
[  205.169483][ T2409] raw: 0017ffffc0000240 ffff888443a06500 
ffff8881214b4bc8 ffff8881214b4bc8
[  205.170431][ T2409] raw: ffff88810798f4a8 0000000000220005 
00000001f5000000 0000000000000000
[  205.171554][ T2409] head: 0017ffffc0000240 ffff888443a06500 
ffff8881214b4bc8 ffff8881214b4bc8
[  205.172630][ T2409] head: ffff88810798f4a8 0000000000220005 
00000001f5000000 0000000000000000
[  205.173509][ T2409] head: 0017ffffc0000001 ffffea00041e6381 
ffffffffffffffff 0000000000000000
[  205.174587][ T2409] head: 0000000000000002 0000000000000000 
00000000ffffffff 0000000000000000
[  205.175538][ T2409] page dumped because: kasan: bad access detected
[  205.176193][ T2409]
[  205.176427][ T2409] Memory state around the buggy address:
[  205.176997][ T2409]  ffff88810798f280: fc fc fc fc fc fc fc fc fc fc 
fc fc fc fc fc fc
[  205.177810][ T2409]  ffff88810798f300: fc fc fc fc fc fc fc fc fc fc 
fc fc fc fc fc fc
[  205.178601][ T2409] >ffff88810798f380: fc fc fc fc fc fc fc fa fb fb 
fb fb fb fb fb fb
[  205.179420][ 
T2409]                                                           ^
[  205.180190][ T2409]  ffff88810798f400: fb fb fb fb fb fb fb fc fc fc 
fc fc fc fc fc fc
[  205.181000][ T2409]  ffff88810798f480: fc fc fc fc fc fc fc fc fc fc 
fc fc fc fc fc fc
[  205.181844][ T2409] 
==================================================================
[  205.182677][ T2409] Disabling lock debugging due to kernel taint

>
>> All the places where unhash is done will also perform lru_remove, so 
>> there
>> is no need to do lru_remove separately here. After inserting the 
>> nfsd_file
>> into the nfsd_file_lru list, it can be released by relying on gc.
>>
>> Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the filecache LRU")
>
> The code that is being replaced below was introduced in ac3a2585f018
> ("nfsd: rework refcounting in filecache"). This fix won't apply to
> kernels that have only 4a0e73e635e3 but not ac3a2585f018, for instance.
>
> At the very least we need to add "Cc: stable@vger.kernel.org # v6.2" but
> I'm not convinced "Fixes: 4a0e73e635e3" is correct.
The replaced code is indeed introduced by ac3a2585f018 ("nfsd: rework
refcounting in filecache").
However, commit 4a0e73e635e3 ("NFSD: Leave open files out of the filecache
LRU") added the nfsd_file_lru_add operation in nfsd_file_put, which
enables concurrent removal of the current nfsd_file by gc, potentially
triggering UAF when accessing nfsd_file below.
Therefore, I use 4a0e73e635e3 as the fix tag.
>
>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfsd/filecache.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index a1cdba42c4fa..37b65cb1579a 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
>>           /* Try to add it to the LRU.  If that fails, decrement. */
>>           if (nfsd_file_lru_add(nf)) {
>>               /* If it's still hashed, we're done */
>> -            if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>> +            if (list_lru_count(&nfsd_file_lru))
>>                   nfsd_file_schedule_laundrette();
>> -                return;
>> -            }
>
> The above change does not seem to be related to the fix described
> in the patch description. Can you help me understand why this is
> needed?
Firstly, I removed the access operations on nfsd_file, including checking
nf->nf_flags and nfsd_file_lru_remove, to prevent triggering UAF after
concurrent release of nfsd_file by gc.
Secondly, I kept nfsd_file_schedule_laundrette and used list_lru_count to
determine whether to trigger gc, with the aim of initiating gc and
reclaiming nfsd_file as soon as possible even if no other process triggers
gc.
>
>
>> -            /*
>> -             * We're racing with unhashing, so try to remove it from
>> -             * the LRU. If removal fails, then someone else already
>> -             * has our reference.
>> -             */
>> -            if (!nfsd_file_lru_remove(nf))
>> -                return;
>> +            return;
>>           }
>>       }
>>       if (refcount_dec_and_test(&nf->nf_ref))
>
>

