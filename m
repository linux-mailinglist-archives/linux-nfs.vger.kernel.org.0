Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4F4EE8B9
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiDAHFd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 03:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiDAHFc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 03:05:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9362AF;
        Fri,  1 Apr 2022 00:03:41 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KV9yW2txtzBrvc;
        Fri,  1 Apr 2022 14:59:31 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:03:36 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:03:35 +0800
Message-ID: <3381d7df-7254-e0ba-648c-6e763bda2ea4@huawei.com>
Date:   Fri, 1 Apr 2022 15:03:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next,v2 0/3] nfs: handle writeback errors correctly
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <smayhew@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuyongqiang13@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
References: <20220401034409.256770-1-chenxiaosong2@huawei.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <20220401034409.256770-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

在 2022/4/1 11:44, ChenXiaoSong 写道:
> v1:
> cover letter: (nfs: check writeback errors correctly)
> 
> v2:
> - return more nuanced writeback errors in nfs_file_write().
> - return writeback error in close()->flush() without consumed it.
> - fix: nfs_file_write() will always call nfs_wb_all() even if there is no
> new writeback error.
> 
> 
> ChenXiaoSong (3):
>    NFS: return more nuanced writeback errors in nfs_file_write()
>    NFS: nfs{,4}_file_flush() return correct writeback errors
>    Revert "nfs: nfs_file_write() should check for writeback errors"
> 
>   fs/nfs/file.c     | 23 ++++++++++-------------
>   fs/nfs/nfs4file.c |  8 ++++----
>   fs/nfs/write.c    |  5 +----
>   3 files changed, 15 insertions(+), 21 deletions(-)
> 

It is not a good idea to modify error sequence mechanism, as the 
`lib/errseq.c` described:

	22  * Note that there is a risk of collisions if new errors are being 
recorded
	23  * frequently, since we have so few bits to use as a counter. 

	24  *
	25  * To mitigate this, one bit is used as a flag to tell whether the 
value has
	26  * been sampled since a new value was recorded. That allows us to 
avoid bumping
	27  * the counter if no one has sampled it since the last time an error was
	28  * recorded.


So, if we want to report nuanced writeback error, it is better to detect 
wb error from filemap_check_errors(), and then return 
-(file->f_mapping->wb_err & MAX_ERRNO) to userspace without consume it.

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

