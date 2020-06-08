Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6E1F116E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 04:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgFHCki (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jun 2020 22:40:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726662AbgFHCki (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Jun 2020 22:40:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B03B913608745C3D2846;
        Mon,  8 Jun 2020 10:40:31 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.138) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 10:40:21 +0800
Subject: Re: [PATCH v3] nfs: set invalid blocks after NFSv4 writes
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
References: <20200521091721.105622-1-zhengbin13@huawei.com>
 <5d7fbe2a-d365-2fdf-fe96-8f00d16795b5@huawei.com>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <95c62610-0e86-d18f-4fef-a6ef4997c201@huawei.com>
Date:   Mon, 8 Jun 2020 10:40:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <5d7fbe2a-d365-2fdf-fe96-8f00d16795b5@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.215.138]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping

On 2020/6/1 15:10, Zhengbin (OSKernel) wrote:
> ping
>
> On 2020/5/21 17:17, Zheng Bin wrote:
>> Use the following command to test nfsv4(size of file1M is 1MB):
>> mount -t nfs -o vers=4.0,actimeo=60 127.0.0.1/dir1 /mnt
>> cp file1M /mnt
>> du -h /mnt/file1M  -->0 within 60s, then 1M
>>
>> When write is done(cp file1M /mnt), will call this:
>> nfs_writeback_done
>>    nfs4_write_done
>>      nfs4_write_done_cb
>>        nfs_writeback_update_inode
>>          nfs_post_op_update_inode_force_wcc_locked(change, ctime, mtime
>> nfs_post_op_update_inode_force_wcc_locked
>>     nfs_set_cache_invalid
>>     nfs_refresh_inode_locked
>>       nfs_update_inode
>>
>> nfsd write response contains change, ctime, mtime, the flag will be
>> clear after nfs_update_inode. Howerver, write response does not contain
>> space_used, previous open response contains space_used whose value is 0,
>> so inode->i_blocks is still 0.
>>
>> nfs_getattr  -->called by "du -h"
>>    do_update |= force_sync || nfs_attribute_cache_expired -->false in 
>> 60s
>>    cache_validity = READ_ONCE(NFS_I(inode)->cache_validity)
>>    do_update |= cache_validity & (NFS_INO_INVALID_ATTR -->false
>>    if (do_update) {
>>          __nfs_revalidate_inode
>>    }
>>
>> Within 60s, does not send getattr request to nfsd, thus "du -h 
>> /mnt/file1M"
>> is 0.
>>
>> Add a NFS_INO_INVALID_BLOCKS flag, set it when nfsv4 write is done.
>>
>> Fixes: 16e143751727 ("NFS: More fine grained attribute tracking")
>> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
>> ---
>>
>> v1->v2: add STATX_BLOCKS check in nfs_getattr
>> v2->v3: need clear NFS_INO_INVALID_BLOCKS flag first in nfs_update_inode
>>
>>   fs/nfs/inode.c         | 14 +++++++++++---
>>   include/linux/nfs_fs.h |  1 +
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> index b9d0921cb4fe..0bf1f835de01 100644
>> --- a/fs/nfs/inode.c
>> +++ b/fs/nfs/inode.c
>> @@ -833,6 +833,8 @@ int nfs_getattr(const struct path *path, struct 
>> kstat *stat,
>>           do_update |= cache_validity & NFS_INO_INVALID_ATIME;
>>       if (request_mask & (STATX_CTIME|STATX_MTIME))
>>           do_update |= cache_validity & NFS_INO_REVAL_PAGECACHE;
>> +    if (request_mask & STATX_BLOCKS)
>> +        do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
>>       if (do_update) {
>>           /* Update the attribute cache */
>>           if (!(server->flags & NFS_MOUNT_NOAC))
>> @@ -1764,7 +1766,8 @@ int 
>> nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct 
>> nfs_fa
>>       status = nfs_post_op_update_inode_locked(inode, fattr,
>>               NFS_INO_INVALID_CHANGE
>>               | NFS_INO_INVALID_CTIME
>> -            | NFS_INO_INVALID_MTIME);
>> +            | NFS_INO_INVALID_MTIME
>> +            | NFS_INO_INVALID_BLOCKS);
>>       return status;
>>   }
>>
>> @@ -1871,7 +1874,8 @@ static int nfs_update_inode(struct inode 
>> *inode, struct nfs_fattr *fattr)
>>       nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
>>               | NFS_INO_INVALID_ATIME
>>               | NFS_INO_REVAL_FORCED
>> -            | NFS_INO_REVAL_PAGECACHE);
>> +            | NFS_INO_REVAL_PAGECACHE
>> +            | NFS_INO_INVALID_BLOCKS);
>>
>>       /* Do atomic weak cache consistency updates */
>>       nfs_wcc_update_inode(inode, fattr);
>> @@ -2033,8 +2037,12 @@ static int nfs_update_inode(struct inode 
>> *inode, struct nfs_fattr *fattr)
>>           inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
>>       } else if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
>>           inode->i_blocks = fattr->du.nfs2.blocks;
>> -    else
>> +    else {
>> +        nfsi->cache_validity |= save_cache_validity &
>> +                (NFS_INO_INVALID_BLOCKS
>> +                | NFS_INO_REVAL_FORCED);
>>           cache_revalidated = false;
>> +    }
>>
>>       /* Update attrtimeo value if we're out of the unstable period */
>>       if (attr_changed) {
>> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
>> index 73eda45f1cfd..6ee9119acc5d 100644
>> --- a/include/linux/nfs_fs.h
>> +++ b/include/linux/nfs_fs.h
>> @@ -230,6 +230,7 @@ struct nfs4_copy_state {
>>   #define NFS_INO_INVALID_OTHER    BIT(12)        /* other attrs are 
>> invalid */
>>   #define NFS_INO_DATA_INVAL_DEFER    \
>>                   BIT(13)        /* Deferred cache invalidation */
>> +#define NFS_INO_INVALID_BLOCKS    BIT(14)         /* cached blocks 
>> are invalid */
>>
>>   #define NFS_INO_INVALID_ATTR    (NFS_INO_INVALID_CHANGE \
>>           | NFS_INO_INVALID_CTIME \
>> -- 
>> 2.26.0.106.g9fadedd
>>
>>
>> .
>>

