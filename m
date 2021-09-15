Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA540C11D
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 10:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbhIOIG1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 04:06:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15419 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhIOIFg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 04:05:36 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8Xfp1ZFPzRB8v;
        Wed, 15 Sep 2021 15:59:14 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:03:20 +0800
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:03:20 +0800
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
CC:     Luo Meng <luomeng12@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Subject: Questions about nfs_sb_active
Message-ID: <ce24474a-39a6-dc3b-0580-378cdfedf0c5@huawei.com>
Date:   Wed, 15 Sep 2021 16:03:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I have some confuse about 'nfs_sb_active'.

The following commit increase the 'sb->s_active' to prevent concurrent with umount process when handle the callback rpc message.

   e39d8a186ed0 ("NFSv4: Fix an Oops during delegation callbacks")
   113aac6d567b ("NFS: nfs_delegation_find_inode_server must first reference the superblock")

But it also delay the process in function 'generic_shutdown_super', such as 'sync_filesystem' and 'fsnotify_sb_delete'.

For the common file system, when umount success, the data should be stable to the disk, but in nfs, it maybe delay?

I want know :
   1. whether we _must_ stable the data to the server?
   2. how to ensure the data not lost when umount success but client crash?
   3. the delayed fsnotify umount event is reasonable or not?
   4. the 'nfs_sb_active' should be used under what scenario?

Thanks.
