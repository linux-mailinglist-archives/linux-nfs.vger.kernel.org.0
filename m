Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE64FE293
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiDLNb7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355952AbiDLNb4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 09:31:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEBF10FE0
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 06:29:34 -0700 (PDT)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kd60W62N7zBrX8;
        Tue, 12 Apr 2022 21:25:15 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500022.china.huawei.com (7.221.188.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 21:29:32 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 21:29:32 +0800
Message-ID: <52552874-01a4-d0da-8904-1b81659e5d1c@huawei.com>
Date:   Tue, 12 Apr 2022 21:29:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 3/5] NFS: Don't report ENOSPC write errors twice
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
References: <20220411213346.762302-1-trondmy@kernel.org>
 <20220411213346.762302-2-trondmy@kernel.org>
 <20220411213346.762302-3-trondmy@kernel.org>
 <20220411213346.762302-4-trondmy@kernel.org>
 <a2babe9f-e85e-3c72-9132-35aa6ae3888b@huawei.com>
 <5fde4fd533805990cfbd0f23964db786cfda2cd7.camel@hammerspace.com>
 <3536f67c-95f3-efbf-3d0f-0b7e8b4549b9@huawei.com>
In-Reply-To: <3536f67c-95f3-efbf-3d0f-0b7e8b4549b9@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

在 2022/4/12 21:13, chenxiaosong (A) 写道:
> 在 2022/4/12 20:16, Trond Myklebust 写道:
>> I understand all that. The point you appear to be missing is that this
>> is in fact in agreement with the documented behaviour in the write(2)
>> and fsync(2) manpages. These errors are supposed to be reported once,
>> even if they were caused by a write to a different file descriptor.
>>
>> In fact, even with your change, if you make the second 'dd' call fsync
>> (by adding a conv=fsync), I would expect it to report the exact same
>> ENOSPC error, and that would be correct behaviour!
>>
>> So my patches are more concerned with the fact that we appear to be
>> reporting the same error more than once, rather than the fact that
>> we're reporting them in the second attempt at I/O. As far as I'm
>> concerned, that is the main change that is needed to meet the behaviour
>> that is documented in the manpages.
> 
> 
> After merging my patchset, when make the second 'dd' call fsync (by 
> adding a conv=fsync), it can report ENOSPC error by calling fsync() 
> syscall.
> 
> And when make the second 'dd' sync write (by adding a oflag=sync), it 
> can report ENOSPC error too:
> 
> ```c
> write
>    ksys_write
>      vfs_write
>        new_sync_write
>          call_write_iter
>            nfs_file_write
>              generic_write_sync
>                vfs_fsync_range
>                  nfs_file_fsync
> ```
> 

On other filesystem, wb error is only cleared when doing fsync() or sync 
write(), it should not clear the wb error when doing async write(). Your 
patch will clear the wb error when doing async write().

And my patchset mainly fix following problem:

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


