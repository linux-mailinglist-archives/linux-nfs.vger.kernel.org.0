Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487324FE3B7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbiDLO2N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356506AbiDLO2N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 10:28:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C656C04
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 07:25:53 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kd7JL50xNzgYhP;
        Tue, 12 Apr 2022 22:24:02 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 22:25:51 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 22:25:50 +0800
Message-ID: <d319b6b9-13b5-6ce0-5aba-1635fb381e15@huawei.com>
Date:   Tue, 12 Apr 2022 22:25:49 +0800
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
 <52552874-01a4-d0da-8904-1b81659e5d1c@huawei.com>
In-Reply-To: <52552874-01a4-d0da-8904-1b81659e5d1c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

在 2022/4/12 21:29, chenxiaosong (A) 写道:
> 在 2022/4/12 21:13, chenxiaosong (A) 写道:
> On other filesystem, wb error is only cleared when doing fsync() or sync 
> write(), it should not clear the wb error when doing async write(). Your 
> patch will clear the wb error when doing async write().
> 
> And my patchset mainly fix following problem:
> 
> filemap_sample_wb_err() always return 0 if old writeback error
> have not been consumed. filemap_check_wb_err() will return the old error
> even if there is no new writeback error between filemap_sample_wb_err() and
> filemap_check_wb_err().
> 
> ```c
>    since = filemap_sample_wb_err() = 0
>      errseq_sample
>        if (!(old & ERRSEQ_SEEN)) // nobody see the error
>          return 0;
>    nfs_wb_all // no new error
>    error = filemap_check_wb_err(..., since) != 0 // unexpected error
> ```
> 

After merging your patchset, NFS will report and clear wb error on 
_async_ write(), even there is no new wb error while nfs_wb_all, is this 
reasonable?

And more importantly, we can not detect new error by using 
filemap_sample_wb_err()/filemap_check_wb_err() while nfs_wb_all(),just 
as I described:

```c
   since = filemap_sample_wb_err() = 0
     errseq_sample
       if (!(old & ERRSEQ_SEEN)) // nobody see the error
         return 0;
   nfs_wb_all // no new error
   error = filemap_check_wb_err(..., since) != 0 // unexpected error
```
.
