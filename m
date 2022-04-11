Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF444FBE41
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Apr 2022 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiDKOFk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Apr 2022 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbiDKOFj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Apr 2022 10:05:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9B215
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 07:03:25 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KcVrv0p8NzgYgF;
        Mon, 11 Apr 2022 22:01:35 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 22:03:22 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 22:03:22 +0800
Message-ID: <6219ec61-d359-1272-aa8f-26a1f76c45c3@huawei.com>
Date:   Mon, 11 Apr 2022 22:03:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/2] NFS: Don't report write errors twice
To:     <trondmy@kernel.org>, <linux-nfs@vger.kernel.org>
CC:     Scott Mayhew <smayhew@redhat.com>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20220409200108.94208-1-trondmy@kernel.org>
 <20220409200108.94208-2-trondmy@kernel.org>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <20220409200108.94208-2-trondmy@kernel.org>
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

在 2022/4/10 4:01, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Any errors reported by the write() system call need to be cleared from
> the file descriptor's error tracking. The current call to nfs_wb_all()
> causes the error to be reported, but since it doesn't call
> file_check_and_advance_wb_err(), we can end up reporting the same error
> a second time when the application calls fsync().
> 
> Reported-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> Fixes: ce368536dd61 ("nfs: nfs_file_write() should check for writeback errors")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/file.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 81c80548a5c6..54dc6f176f5c 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -677,9 +677,10 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
>   	/* Return error values */
>   	error = filemap_check_wb_err(file->f_mapping, since);
>   	if (nfs_need_check_write(file, inode, error)) {
> -		int err = nfs_wb_all(inode);
> -		if (err < 0)
> -			result = err;
> +		nfs_wb_all(inode);
> +		error = file_check_and_advance_wb_err(file);
> +		if (error < 0)
> +			result = error;
>   	}
>   	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
>   out:
> 

After merging this patchset, second `dd` of the following reproducer 
will still report unexpected error: No space left on device.

Reproducer:
         nfs server            |       nfs client
 
-----------------------------|---------------------------------------------
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
