Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BAC4FF904
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Apr 2022 16:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiDMOhE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Apr 2022 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiDMOhD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Apr 2022 10:37:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D95F4BBB7;
        Wed, 13 Apr 2022 07:34:41 -0700 (PDT)
Received: from kwepemi500025.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KdlS16SF1zgYKd;
        Wed, 13 Apr 2022 22:32:49 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 22:34:39 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 22:34:38 +0800
Message-ID: <9b879bf5-53f1-663f-97ad-aeb91055bb05@huawei.com>
Date:   Wed, 13 Apr 2022 22:34:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE flag
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
To:     Lyu Tao <tao.lyu@epfl.ch>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "bjschuma@netapp.com" <bjschuma@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
 <68b65889-3b2c-fb72-a0a8-d0afc15a03e0@huawei.com>
 <e0c2d7ec62b447cabddbc8a9274be955@epfl.ch>
 <0b6546f7-8a04-9d6e-50c3-483c8a1a6591@huawei.com>
 <d73a51a2-6b63-b536-61e6-3d18563f027d@huawei.com>
In-Reply-To: <d73a51a2-6b63-b536-61e6-3d18563f027d@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I will give some detailed code process.

firstly open():

```c
open
   do_sys_open
     do_sys_openat2
       do_filp_open
         path_openat
           open_last_lookups
             lookup_open
               atomic_open
                 nfs_atomic_open
                   create_nfs_open_context
                     flags_to_mode() = FMODE_READ|FMODE_WRITE
                     alloc_nfs_open_context
                       ctx->mode = f_mode // FMODE_READ|FMODE_WRITE
                   // NFS_PROTO(dir)->open_context
                   nfs4_atomic_open
                     nfs4_do_open
                       _nfs4_do_open
                         fmode = _nfs4_ctx_to_openmode(ctx) = 3
                           ret = ctx->mode & (FMODE_READ|FMODE_WRITE) // 
ctx->mode = 3
                         nfs4_opendata_alloc
                           nfs4_map_atomic_open_share
                             return NFS4_SHARE_ACCESS_BOTH
```

secondly open():
```c
open
   do_sys_open
     do_sys_openat2
       do_filp_open
         path_openat
           open_last_lookups
             lookup_open
               return dentry // if (dentry->d_inode) {
           do_open
             vfs_open
               do_dentry_open
                 // f->f_op->open
                 nfs4_file_open
                   if ((openflags & O_ACCMODE) == 3)
                   nfs_open // without sunrpc request
                     alloc_nfs_open_context
                       ctx->state = NULL; // this is point
```

lseek() after secondly open():
```c
lseek
   ksys_lseek
     vfs_llseek
       // file->f_op->llseek
       nfs4_file_llseek
         nfs42_proc_llseek
           _nfs42_proc_llseek(lock)
             nfs4_set_rw_stateid(ctx=lock->open_context)
               nfs4_select_rw_stateid(state=ctx->state)
                 nfs4_valid_open_stateid(state)
                   state->flags // dereference NULL state
```

在 2022/4/13 22:05, chenxiaosong (A) 写道:
> 在 2022/4/13 21:42, chenxiaosong (A) 写道:
>>
>> 在 2022/4/13 20:07, Lyu Tao 写道:
>>>
>>> Hi Xiaosong,
>>>
>>>
>>> Thanks for keeping focusing on this bug.
>>>
>>>
>>> I applied this CVE for the NULL dereference bug at 
>>> nfs4_valid_open_stateid() and added the following description to this 
>>> CVE due to the NFS maintainers replied that to me.
>>>
>>> "An issue was discovered in fs/nfs/dir.c in the Linux kernel before 
>>> 5.16.5. If an application sets the O_DIRECTORY flag, and tries to 
>>> open a regular file, nfs_atomic_open() performs a regular lookup. If 
>>> a regular file is found, ENOTDIR should occur, but the server instead 
>>> returns uninitialized data in the file descriptor.
>>>
>>>
>>> Actually I'm still confused with the root cause of this bug. In the 
>>> original PoC, there is no O_DIRECTORY flag but commit ac795161c936 
>>> mentioned.
>>>
>>> Moreover, in your latest commit ab0fc21bc710, it said "After secondly 
>>> opening a file with O_ACCMODE|O_DIRECT flags, 
>>> nfs4_valid_open_stateid() will dereference NULL nfs4_state when 
>>> lseek()." However, the original PoC opens the file only with 
>>> O_RDWR|O_CREAT for the first time.
>>>
>>>
>>> Original PoC:
>>>
>>> fd = openat("./file1", o_RDWR|O_CREAT, 000);
>>>
>>> open("./file1", 
>>> O_ACCMODE|O_CREAT|O_DIRECT|O_LARGEFILE|O_NOFOLLOW|O_NOATIME|O_CLOEXEC|FASYNC|0xb3000008, 
>>> 001);
>>>
>>> lseek(fd, 9, SEEK_HOLE);
>>>
>>>
>>> I'll update this CVE's description after I figure out these.
>>>
>>>
>>> Best Regards,
>>>
>>> Tao
>>>
>>
>> Hi Tao:
>>
>> Yes, O_ACCEMODE is _not_ necessary when fistly open() file.
>>
>> When open() the file secondly, O_ACCEMODE is necessary if we want to 
>> reproduce the bug.
>>
>> Waiting for your modification of the CVE's description.
>>
>> Best Regards.
>> .
> 
> My reproducer:
>    1. mount -t nfs -o vers=4.2 $server_ip:/ /mnt/
>    2. fd = open("/mnt/file", O_ACCMODE|O_DIRECT|O_CREAT)
>    3. close(fd)
>    4. fd = open("/mnt/file", O_ACCMODE|O_DIRECT)
>    5. lseek(fd)
> 
> When firstly open() file, O_ACCMODE|O_DIRECT is _not_ necessary, we just 
> use O_CREAT to create new file.
> 
> When secondly open() file, only O_ACCMODE|O_DIRECT is necessary, 
> O_CREAT|O_LARGEFILE|O_NOFOLLOW|O_NOATIME|O_CLOEXEC|FASYNC|0xb3000008 in 
> your original PoC is not necessary (however, they are harmless).
