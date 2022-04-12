Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709924FCF73
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiDLG1E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 02:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiDLG1D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 02:27:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F5B35857
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 23:24:43 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kcwd91bdxzgYf7;
        Tue, 12 Apr 2022 14:22:53 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 14:24:41 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 14:24:41 +0800
Message-ID: <a2babe9f-e85e-3c72-9132-35aa6ae3888b@huawei.com>
Date:   Tue, 12 Apr 2022 14:24:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
Subject: Re: [PATCH v2 3/5] NFS: Don't report ENOSPC write errors twice
To:     <trondmy@kernel.org>, <linux-nfs@vger.kernel.org>
CC:     Scott Mayhew <smayhew@redhat.com>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20220411213346.762302-1-trondmy@kernel.org>
 <20220411213346.762302-2-trondmy@kernel.org>
 <20220411213346.762302-3-trondmy@kernel.org>
 <20220411213346.762302-4-trondmy@kernel.org>
In-Reply-To: <20220411213346.762302-4-trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

在 2022/4/12 5:33, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Any errors reported by the write() system call need to be cleared from
> the file descriptor's error tracking. The current call to nfs_wb_all()
> causes the error to be reported, but since it doesn't call
> file_check_and_advance_wb_err(), we can end up reporting the same error
> a second time when the application calls fsync().
> 
> Note that since Linux 4.13, the rule is that EIO may be reported for
> write(), but it must be reported by a subsequent fsync(), so let's just
> drop reporting it in write.
> 
> The check for nfs_ctx_key_to_expire() is just a duplicate to the one
> already in nfs_write_end(), so let's drop that too.
> 
> Reported-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> Fixes: ce368536dd61 ("nfs: nfs_file_write() should check for writeback errors")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/file.c | 33 +++++++++++++--------------------
>   1 file changed, 13 insertions(+), 20 deletions(-)


# 1. wb error mechanism of other filesystem

Other filesystem only clear the wb error when calling fsync(), async 
write will not clear the wb error.


# 2. still report unexpected error ... again

After merging this patchset(5 patches), second `dd` of the following 
reproducer will still report unexpected error: No space left on device.

Reproducer:
         nfs server            |       nfs client
------------------------------|---------------------------------------------
  # No space left on server    |
  fallocate -l 100G /svr/nospc |
                               | mount -t nfs $nfs_server_ip:/ /mnt
                               |
                               | # Expected error: No space left on device
                               | dd if=/dev/zero of=/mnt/file count=1 
ibs=10K
                               |
                               | # Release space on mountpoint
                               | rm /mnt/nospc
                               |
                               | # Unexpected error: No space left on device
                               | dd if=/dev/zero of=/mnt/file count=1 
ibs=10K


# 3. my patchset

https://patchwork.kernel.org/project/linux-nfs/list/?series=628066

My patchset can fix bug of above reproducer.

filemap_sample_wb_err() always return 0 if old writeback error
have not been consumed. filemap_check_wb_err() will return the old error
even if there is no new writeback error between filemap_sample_wb_err() and
filemap_check_wb_err().

```c
   since = filemap_sample_wb_err() = 0
     errseq_sample
       if (!(old & ERRSEQ_SEEN)) // nobody see the error
         return 0;
   nfs_wb_all // no new error
   error = filemap_check_wb_err(..., since) != 0 // unexpected error
```

So we still need record writeback error in address_space flags. The 
writeback
error in address_space flags is not used to be reported to userspace, it 
is just
used to detect if there is new error while writeback.

if we want to report nuanced writeback error, it is better to detect wb 
error from filemap_check_errors(), and then return 
-(file->f_mapping->wb_err & MAX_ERRNO) to userspace without consume it.

```c
   nfs_mapping_set_error
     mapping_set_error
       __filemap_set_wb_err // record error sequence
         errseq_set
       set_bit(..., &mapping->flags) // record address_space flag

   // it is not used to be reported, just used to detect
   error = filemap_check_errors // -ENOSPC or -EIO
     test_and_clear_bit(..., &mapping->flags) // error bit cleared

   // now we try to return nuanced writeback error
   if (error)
   return filemap_check_wb_err(file->f_mapping, 0);
     return -(file->f_mapping->wb_err & MAX_ERRNO)
```
