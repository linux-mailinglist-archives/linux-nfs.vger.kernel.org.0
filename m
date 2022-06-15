Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4A54BFB3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 04:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiFOCgp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jun 2022 22:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFOCgp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jun 2022 22:36:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47F4EA27
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jun 2022 19:36:43 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LN8Z76YlvzDrH4;
        Wed, 15 Jun 2022 10:36:15 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 10:36:41 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 10:36:40 +0800
Message-ID: <74a9d72a-e6b7-913b-77b8-d45c128f5a50@huawei.com>
Date:   Wed, 15 Jun 2022 10:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 3/5] NFS: Don't report ENOSPC write errors twice
To:     <trondmy@kernel.org>, Anna Schumaker <anna.schumaker@netapp.com>
CC:     <linux-nfs@vger.kernel.org>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
References: <20220514142704.4149-1-trondmy@kernel.org>
 <20220514142704.4149-2-trondmy@kernel.org>
 <20220514142704.4149-3-trondmy@kernel.org>
 <20220514142704.4149-4-trondmy@kernel.org>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <20220514142704.4149-4-trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond:

If old writeback (such as -ERESTARTSYS or -EINTR, etc.) exist in struct 
address_space->wb_err, nfs_file_write() will always return the 
unexpected error. filemap_check_wb_err() will return the old error
even if there is no new writeback error between filemap_sample_wb_err() 
and filemap_check_wb_err().

```c
    since = filemap_sample_wb_err() = 0 // never be error
      errseq_sample
        if (!(old & ERRSEQ_SEEN)) // nobody see the error
          return 0;
    nfs_wb_all // no new error
    error = filemap_check_wb_err(..., since) != 0 // unexpected error
```

By the way, the following process have redundant code in nfs_file_write():

```c
if (mntflags & NFS_MOUNT_WRITE_WAIT) {
         result = filemap_fdatawait_range(file->f_mapping,
                                          iocb->ki_pos - written,
                                          iocb->ki_pos - 1);
         if (result < 0)
                 goto out;
}
```

filemap_fdatawait_range() will always return 0, since patch 6c984083ec24 
("NFS: Use of mapping_set_error() results in spurious errors") do not 
save the error in struct address_space->flags:

   filemap_fdatawait_range(file->f_mapping, ...) = 0
     filemap_check_errors(mapping) = 0
       test_bit(..., &mapping->flags) // flags always is 0

So the return value result is always 0, `if (result < 0)` is redundant

在 2022/5/14 22:27, trondmy@kernel.org 写道:
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
>   fs/nfs/file.c | 34 ++++++++++++++--------------------
>   1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 7c380e555224..87e4cd5e8fe2 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -598,18 +598,6 @@ static const struct vm_operations_struct nfs_file_vm_ops = {
>   	.page_mkwrite = nfs_vm_page_mkwrite,
>   };
>   
> -static int nfs_need_check_write(struct file *filp, struct inode *inode,
> -				int error)
> -{
> -	struct nfs_open_context *ctx;
> -
> -	ctx = nfs_file_open_context(filp);
> -	if (nfs_error_is_fatal_on_server(error) ||
> -	    nfs_ctx_key_to_expire(ctx, inode))
> -		return 1;
> -	return 0;
> -}
> -
>   ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
>   {
>   	struct file *file = iocb->ki_filp;
> @@ -637,7 +625,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
>   	if (iocb->ki_flags & IOCB_APPEND || iocb->ki_pos > i_size_read(inode)) {
>   		result = nfs_revalidate_file_size(inode, file);
>   		if (result)
> -			goto out;
> +			return result;
>   	}
>   
>   	nfs_clear_invalid_mapping(file->f_mapping);
> @@ -656,6 +644,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
>   
>   	written = result;
>   	iocb->ki_pos += written;
> +	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
>   
>   	if (mntflags & NFS_MOUNT_WRITE_EAGER) {
>   		result = filemap_fdatawrite_range(file->f_mapping,
> @@ -673,17 +662,22 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
>   	}
>   	result = generic_write_sync(iocb, written);
>   	if (result < 0)
> -		goto out;
> +		return result;
>   
> +out:
>   	/* Return error values */
>   	error = filemap_check_wb_err(file->f_mapping, since);
> -	if (nfs_need_check_write(file, inode, error)) {
> -		int err = nfs_wb_all(inode);
> -		if (err < 0)
> -			result = err;
> +	switch (error) {
> +	default:
> +		break;
> +	case -EDQUOT:
> +	case -EFBIG:
> +	case -ENOSPC:
> +		nfs_wb_all(inode);
> +		error = file_check_and_advance_wb_err(file);
> +		if (error < 0)
> +			result = error;
>   	}
> -	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
> -out:
>   	return result;
>   
>   out_swapfile:
> 
