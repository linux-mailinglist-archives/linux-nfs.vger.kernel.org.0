Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCAD4FF880
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Apr 2022 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiDMOIE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Apr 2022 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiDMOID (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Apr 2022 10:08:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051925E8C;
        Wed, 13 Apr 2022 07:05:41 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KdkpY1KPQzgY8Z;
        Wed, 13 Apr 2022 22:03:49 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 22:05:38 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 22:05:38 +0800
Message-ID: <d73a51a2-6b63-b536-61e6-3d18563f027d@huawei.com>
Date:   Wed, 13 Apr 2022 22:05:37 +0800
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
In-Reply-To: <0b6546f7-8a04-9d6e-50c3-483c8a1a6591@huawei.com>
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

在 2022/4/13 21:42, chenxiaosong (A) 写道:
> 
> 在 2022/4/13 20:07, Lyu Tao 写道:
>>
>> Hi Xiaosong,
>>
>>
>> Thanks for keeping focusing on this bug.
>>
>>
>> I applied this CVE for the NULL dereference bug at 
>> nfs4_valid_open_stateid() and added the following description to this 
>> CVE due to the NFS maintainers replied that to me.
>>
>> "An issue was discovered in fs/nfs/dir.c in the Linux kernel before 
>> 5.16.5. If an application sets the O_DIRECTORY flag, and tries to open 
>> a regular file, nfs_atomic_open() performs a regular lookup. If a 
>> regular file is found, ENOTDIR should occur, but the server instead 
>> returns uninitialized data in the file descriptor.
>>
>>
>> Actually I'm still confused with the root cause of this bug. In the 
>> original PoC, there is no O_DIRECTORY flag but commit ac795161c936 
>> mentioned.
>>
>> Moreover, in your latest commit ab0fc21bc710, it said "After secondly 
>> opening a file with O_ACCMODE|O_DIRECT flags, 
>> nfs4_valid_open_stateid() will dereference NULL nfs4_state when 
>> lseek()." However, the original PoC opens the file only with 
>> O_RDWR|O_CREAT for the first time.
>>
>>
>> Original PoC:
>>
>> fd = openat("./file1", o_RDWR|O_CREAT, 000);
>>
>> open("./file1", 
>> O_ACCMODE|O_CREAT|O_DIRECT|O_LARGEFILE|O_NOFOLLOW|O_NOATIME|O_CLOEXEC|FASYNC|0xb3000008, 
>> 001);
>>
>> lseek(fd, 9, SEEK_HOLE);
>>
>>
>> I'll update this CVE's description after I figure out these.
>>
>>
>> Best Regards,
>>
>> Tao
>>
> 
> Hi Tao:
> 
> Yes, O_ACCEMODE is _not_ necessary when fistly open() file.
> 
> When open() the file secondly, O_ACCEMODE is necessary if we want to 
> reproduce the bug.
> 
> Waiting for your modification of the CVE's description.
> 
> Best Regards.
> .

My reproducer:
   1. mount -t nfs -o vers=4.2 $server_ip:/ /mnt/
   2. fd = open("/mnt/file", O_ACCMODE|O_DIRECT|O_CREAT)
   3. close(fd)
   4. fd = open("/mnt/file", O_ACCMODE|O_DIRECT)
   5. lseek(fd)

When firstly open() file, O_ACCMODE|O_DIRECT is _not_ necessary, we just 
use O_CREAT to create new file.

When secondly open() file, only O_ACCMODE|O_DIRECT is necessary, 
O_CREAT|O_LARGEFILE|O_NOFOLLOW|O_NOATIME|O_CLOEXEC|FASYNC|0xb3000008 in 
your original PoC is not necessary (however, they are harmless).
