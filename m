Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102FDCC744
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2019 03:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfJEBv6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Oct 2019 21:51:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbfJEBv5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 4 Oct 2019 21:51:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 67616907C4681D54F309;
        Sat,  5 Oct 2019 09:51:55 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.145) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sat, 5 Oct 2019
 09:51:53 +0800
Subject: Re: [PATCH] nfs: Fix nfsi->nrequests count error on
 nfs_inode_remove_request
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
References: <1569479378-128669-1-git-send-email-zhangxiaoxu5@huawei.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <08ce0101-e8df-509a-f3e5-07063aa5492e@huawei.com>
Date:   Sat, 5 Oct 2019 09:51:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569479378-128669-1-git-send-email-zhangxiaoxu5@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.145]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping.

On 2019/9/26 14:29, ZhangXiaoxu wrote:
> When xfstests testing, there are some WARNING as below:
> 
> WARNING: CPU: 0 PID: 6235 at fs/nfs/inode.c:122 nfs_clear_inode+0x9c/0xd8
> Modules linked in:
> CPU: 0 PID: 6235 Comm: umount.nfs
> Hardware name: linux,dummy-virt (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO)
> pc : nfs_clear_inode+0x9c/0xd8
> lr : nfs_evict_inode+0x60/0x78
> sp : fffffc000f68fc00
> x29: fffffc000f68fc00 x28: fffffe00c53155c0
> x27: fffffe00c5315000 x26: fffffc0009a63748
> x25: fffffc000f68fd18 x24: fffffc000bfaaf40
> x23: fffffc000936d3c0 x22: fffffe00c4ff5e20
> x21: fffffc000bfaaf40 x20: fffffe00c4ff5d10
> x19: fffffc000c056000 x18: 000000000000003c
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000040 x14: 0000000000000228
> x13: fffffc000c3a2000 x12: 0000000000000045
> x11: 0000000000000000 x10: 0000000000000000
> x9 : 0000000000000000 x8 : 0000000000000000
> x7 : 0000000000000000 x6 : fffffc00084b027c
> x5 : fffffc0009a64000 x4 : fffffe00c0e77400
> x3 : fffffc000c0563a8 x2 : fffffffffffffffb
> x1 : 000000000000764e x0 : 0000000000000001
> Call trace:
>   nfs_clear_inode+0x9c/0xd8
>   nfs_evict_inode+0x60/0x78
>   evict+0x108/0x380
>   dispose_list+0x70/0xa0
>   evict_inodes+0x194/0x210
>   generic_shutdown_super+0xb0/0x220
>   nfs_kill_super+0x40/0x88
>   deactivate_locked_super+0xb4/0x120
>   deactivate_super+0x144/0x160
>   cleanup_mnt+0x98/0x148
>   __cleanup_mnt+0x38/0x50
>   task_work_run+0x114/0x160
>   do_notify_resume+0x2f8/0x308
>   work_pending+0x8/0x14
> 
> The nrequest should be increased/decreased only if PG_INODE_REF flag
> was setted.
> 
> But in the nfs_inode_remove_request function, it maybe decrease when
> no PG_INODE_REF flag, this maybe lead nrequests count error.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>   fs/nfs/write.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 85ca495..52cab65 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -786,7 +786,6 @@ static void nfs_inode_remove_request(struct nfs_page *req)
>   	struct nfs_inode *nfsi = NFS_I(inode);
>   	struct nfs_page *head;
>   
> -	atomic_long_dec(&nfsi->nrequests);
>   	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
>   		head = req->wb_head;
>   
> @@ -799,8 +798,10 @@ static void nfs_inode_remove_request(struct nfs_page *req)
>   		spin_unlock(&mapping->private_lock);
>   	}
>   
> -	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags))
> +	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
>   		nfs_release_request(req);
> +		atomic_long_dec(&nfsi->nrequests);
> +	}
>   }
>   
>   static void
> 

