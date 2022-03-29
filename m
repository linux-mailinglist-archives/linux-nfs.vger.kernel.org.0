Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD66E4EAEAC
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Mar 2022 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiC2NqX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiC2NqV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 09:46:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766EF28E10;
        Tue, 29 Mar 2022 06:44:36 -0700 (PDT)
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KSW0b6dCTzBrhd;
        Tue, 29 Mar 2022 21:40:31 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 21:44:34 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 21:44:33 +0800
Message-ID: <78ed2de5-84c9-708d-bab0-3bab4455593c@huawei.com>
Date:   Tue, 29 Mar 2022 21:44:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next 2/2] NFSv4: fix open failure with O_ACCMODE flag
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "bjschuma@netapp.com" <bjschuma@netapp.com>
CC:     "tao.lyu@epfl.ch" <tao.lyu@epfl.ch>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
 <20220329113208.2466000-3-chenxiaosong2@huawei.com>
 <4b0d16161fab58dcfba912eb0266a6cd1f83d47e.camel@hammerspace.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <4b0d16161fab58dcfba912eb0266a6cd1f83d47e.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

在 2022/3/29 21:05, Trond Myklebust 写道:
> No. This will not fit the definition of open(2) in the manpage.
> 
>         Linux reserves the special, nonstandard access mode 3  (binary  11)  in
>         flags  to mean: check for read and write permission on the file and re‐
>         turn a file descriptor that can't be used for reading or writing.  This
>         nonstandard  access mode is used by some Linux drivers to return a file
>         descriptor that is to be used only for device-specific ioctl(2)  opera‐
>         tions.
 > Your patch will now cause FMODE_READ and FMODE_WRITE to be set on the
 > file, allowing the file descriptor to be usable for I/O.

Reproducer:
```
   1. mount -t nfs -o vers=4.2 $server_ip:/ /mnt/
   2. fd = open("/mnt/file", O_ACCMODE|O_DIRECT|O_CREAT) = 3
   3. close(fd)
   4. fd = open("/mnt/file", O_ACCMODE|O_DIRECT) = -1
```

When firstly open with O_ACCMODE|O_DIRECT flags:
```c
   path_openat
     open_last_lookups
       lookup_open
         atomic_open
           nfs_atomic_open
             create_nfs_open_context
               f_mode = flags_to_mode
               alloc_nfs_open_context(..., f_mode, ...)
                 ctx->mode = f_mode // FMODE_READ|FMODE_WRITE
```

When secondly open with O_ACCMODE|O_DIRECT flags:
```c
   path_openat
     do_open
       vfs_open
         do_dentry_open
           nfs4_file_open
             f_mode = filp->f_mode | flags_to_mode(openflags)
             alloc_nfs_open_context(..., f_mode, ...)
               ctx->mode = f_mode // FMODE_READ|FMODE_WRITE
```

Before merging this patch, when firstly open, we does not set FMODE_READ 
and FMODE_WRITE to file mode of client, FMODE_READ and FMODE_WRITE just 
be set to context mode.

After merging this patch, when secondly open, I just do the same thing, 
file mode of client will not have FMODE_READ and FMODE_WRITE bits, file 
descriptor can't be used for reading or writing.
