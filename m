Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC40140D227
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Sep 2021 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhIPDt1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 23:49:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16263 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhIPDtW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 23:49:22 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H931l5wrtz8t7Y;
        Thu, 16 Sep 2021 11:47:23 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 11:48:01 +0800
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 11:48:01 +0800
Subject: Re: Questions about nfs_sb_active
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luo Meng <luomeng12@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <ce24474a-39a6-dc3b-0580-378cdfedf0c5@huawei.com>
 <30A81685-4F45-44D3-B497-117BF7B33903@hammerspace.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <951cd849-d6fe-55c0-6f8d-2fbe3ab348f7@huawei.com>
Date:   Thu, 16 Sep 2021 11:48:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <30A81685-4F45-44D3-B497-117BF7B33903@hammerspace.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



ÔÚ 2021/9/15 21:05, Trond Myklebust Ð´µÀ:
> 
> 
>> On Sep 15, 2021, at 04:03, zhangxiaoxu (A) <zhangxiaoxu5@huawei.com> wrote:
>>
>> Hi Trond,
>>
>> I have some confuse about 'nfs_sb_active'.
>>
>> The following commit increase the 'sb->s_active' to prevent concurrent with umount process when handle the callback rpc message.
>>
>>   e39d8a186ed0 ("NFSv4: Fix an Oops during delegation callbacks")
>>   113aac6d567b ("NFS: nfs_delegation_find_inode_server must first reference the superblock")
>>
>> But it also delay the process in function 'generic_shutdown_super', such as 'sync_filesystem' and 'fsnotify_sb_delete'.
>>
>> For the common file system, when umount success, the data should be stable to the disk, but in nfs, it maybe delay?
>>
>> I want know :
>>   1. whether we _must_ stable the data to the server?
>>   2. how to ensure the data not lost when umount success but client crash?
>>   3. the delayed fsnotify umount event is reasonable or not?
>>   4. the 'nfs_sb_active' should be used under what scenario?
>>
>> Thanks.
> 
> That has nothing to do with I/O. Delegations are state.
Since the callbacks hold the 'sb->s_active',
the umount maybe return success without shutdown the superblock.

In general, the superblock should be shutdown before umount success,
but in the concurrent scenario, the superblock is shutdown after the callbacks finish.

If the system is crashed in this period, we may lost 'sync_filesystem',
then the page caches (which not flush to server since hold the write delegation when close the file)
and metadata caches maybe lost?

And the 'fsnotify_sb_delete' is also called after the callbacks finish.
IOW, the umount already return with success, but the FS_UNMOUNT event maybe delay?

I have no idea about it is reasonable or not.
> 
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> .
> 
