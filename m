Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3864FE291
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355515AbiDLNYa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355991AbiDLNWt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 09:22:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E5F41
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 06:13:22 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kd5h03kXZzFpdQ;
        Tue, 12 Apr 2022 21:10:56 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 21:13:20 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 21:13:19 +0800
Message-ID: <3536f67c-95f3-efbf-3d0f-0b7e8b4549b9@huawei.com>
Date:   Tue, 12 Apr 2022 21:13:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 3/5] NFS: Don't report ENOSPC write errors twice
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
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <5fde4fd533805990cfbd0f23964db786cfda2cd7.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

在 2022/4/12 20:16, Trond Myklebust 写道:
> I understand all that. The point you appear to be missing is that this
> is in fact in agreement with the documented behaviour in the write(2)
> and fsync(2) manpages. These errors are supposed to be reported once,
> even if they were caused by a write to a different file descriptor.
> 
> In fact, even with your change, if you make the second 'dd' call fsync
> (by adding a conv=fsync), I would expect it to report the exact same
> ENOSPC error, and that would be correct behaviour!
> 
> So my patches are more concerned with the fact that we appear to be
> reporting the same error more than once, rather than the fact that
> we're reporting them in the second attempt at I/O. As far as I'm
> concerned, that is the main change that is needed to meet the behaviour
> that is documented in the manpages.


After merging my patchset, when make the second 'dd' call fsync (by 
adding a conv=fsync), it can report ENOSPC error by calling fsync() syscall.

And when make the second 'dd' sync write (by adding a oflag=sync), it 
can report ENOSPC error too:

```c
write
   ksys_write
     vfs_write
       new_sync_write
         call_write_iter
           nfs_file_write
             generic_write_sync
               vfs_fsync_range
                 nfs_file_fsync
```

