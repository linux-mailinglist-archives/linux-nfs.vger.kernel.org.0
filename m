Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D214CE89F
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Mar 2022 04:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiCFDzB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Mar 2022 22:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiCFDzA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Mar 2022 22:55:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E1F580F2;
        Sat,  5 Mar 2022 19:54:08 -0800 (PST)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KB70N1WKNz9sR4;
        Sun,  6 Mar 2022 11:50:28 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 11:54:05 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 11:54:05 +0800
Message-ID: <5666cb64-c9e4-0549-6ddb-cfc877c9c071@huawei.com>
Date:   Sun, 6 Mar 2022 11:54:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next 1/2] nfs: nfs{,4}_file_flush should consume
 writeback error
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        ChenXiaoSong <chenxiaosong2@huawei.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
 <20220305124636.2002383-2-chenxiaosong2@huawei.com>
 <ca81e90788eabbf6b5df5db7ea407199a6a3aa04.camel@hammerspace.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <ca81e90788eabbf6b5df5db7ea407199a6a3aa04.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

It would be more clear if I update the reproducer like this:

         nfs server                 |       nfs client
  --------------------------------- |---------------------------------
  # No space left on server         |
  fallocate -l 100G /server/nospace |
                                    | mount -t nfs $nfs_server_ip:/ /mnt
                                    |
                                    | # Expected error
                                    | dd if=/dev/zero of=/mnt/file
                                    |
                                    | # Release space on mountpoint
                                    | rm /mnt/nospace
                                    |
                                    | # Unexpected error
                                    | dd if=/dev/zero of=/mnt/file

The Unexpected error (No space left on device) when doing second `dd`, 
is from unconsumed writeback error after close() the file when doing 
first `dd`. There is enough space when doing second `dd`, we should not 
report the nospace error.

We should report and consume the writeback error when userspace call 
close()->flush(), the writeback error should not be left for next open().

Currently, fsync() will consume the writeback error while calling 
file_check_and_advance_wb_err(), close()->flush() should also consume 
the writeback error.


在 2022/3/6 0:53, Trond Myklebust 写道:
> 'rm' doesn't open any files or do any I/O, so it shouldn't be returning
> any errors from the page cache.
> 
> IOW: The problem here is not that we're failing to clear an error from
> the page cache. It is that something in 'rm' is checking the page cache
> and returning any errors that it finds there.
> 
> Is 'rm' perhaps doing a stat() on the file it is deleting? If so, does
> this patch fix the bug?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm
> it/?id=d19e0183a883
> 
