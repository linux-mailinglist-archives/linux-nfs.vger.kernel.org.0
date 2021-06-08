Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B52539EE89
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 08:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhFHGLC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 02:11:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4506 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFHGLB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 02:11:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzfrB2PkdzZdwk;
        Tue,  8 Jun 2021 14:06:18 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:08:38 +0800
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:08:37 +0800
Subject: Re: [PATCH 1/2] NFSv4: Fix deadlock between nfs4_evict_inode() and
 nfs4_opendata_get_inode()
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20210601173634.243152-1-trondmy@kernel.org>
 <49396167-ff9c-9363-ded7-732d14d60a8e@huawei.com>
 <be83f29458f219f3eaea831a3b8c1a32812820f5.camel@hammerspace.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <49605ca6-ef2c-4fa3-165e-d9a467e05433@huawei.com>
Date:   Tue, 8 Jun 2021 14:08:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <be83f29458f219f3eaea831a3b8c1a32812820f5.camel@hammerspace.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



在 2021/6/7 21:51, Trond Myklebust 写道:
>> 在 2021/6/2 1:36,trondmy@kernel.org  写道:
>>> From: Trond Myklebust<trond.myklebust@hammerspace.com>
>>>
>>> If the inode is being evicted, but has to return a delegation
>>> first,
>>> then it can cause a deadlock in the corner case where the server
>>> reboots
>>> before the delegreturn completes, but while the call to
>>> iget5_locked() in
>>> nfs4_opendata_get_inode() is waiting for the inode free to
>>> complete.
>>> Since the open call still holds a session slot, the reboot recovery
>>> cannot proceed.
>>>
>>> In order to break the logjam, we can turn the delegation return
>>> into a
>>> privileged operation for the case where we're evicting the inode.
>>> We
>>> know that in that case, there can be no other state recovery
>>> operation
>>> that conflicts.
>>>
>> it's looks good to me.
>>
>> but i have another confuse, how to ensure no writeback when evict nfs
>> inode?
>> because flush writes to server when close?
>> but not all close will flush writes to server.
> The struct nfs_open_context holds a reference to the dentry (which
> holds a reference to the inode) and to the superblock. The struct
> nfs_page that is tracking page dirtiness then holds a reference to the
> nfs_open_context.
> 
> That mechanism ensures the inode cannot be evicted until all dirty
> pages have been either flushed or cancelled. The only thing we need to
> worry about is the delegation and the pNFS layout since neither one is
> allowed to reference the inode in any way (because otherwise they would
> prevent the memory reclaim mechanisms from working).
> 
Yes, it is.
Thank you very much.
