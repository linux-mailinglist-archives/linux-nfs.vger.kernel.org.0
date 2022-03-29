Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB24EAF43
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Mar 2022 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbiC2OeA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiC2OeA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 10:34:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F7E1C907;
        Tue, 29 Mar 2022 07:32:16 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSX7x5ghhzcbPQ;
        Tue, 29 Mar 2022 22:31:57 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 22:32:14 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 22:32:13 +0800
Message-ID: <68b65889-3b2c-fb72-a0a8-d0afc15a03e0@huawei.com>
Date:   Tue, 29 Mar 2022 22:32:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE flag
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <bjschuma@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuyongqiang13@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <tao.lyu@epfl.ch>,
        ChenXiaoSong <chenxiaosong2@huawei.com>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
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

在 2022/3/29 19:32, ChenXiaoSong 写道:
> This series fixes following bugs:
> 
> When lseek() a file secondly opened with O_ACCMODE|O_DIRECT flags,
> nfs4_valid_open_stateid() will dereference NULL nfs4_state.
> 
> open() with O_ACCMODE|O_DIRECT flags secondly will fail.
> 
> ChenXiaoSong (2):
>    Revert "NFSv4: Handle the special Linux file open access mode"
>    NFSv4: fix open failure with O_ACCMODE flag
> 
>   fs/nfs/dir.c      | 10 ----------
>   fs/nfs/inode.c    |  1 -
>   fs/nfs/internal.h | 10 ++++++++++
>   fs/nfs/nfs4file.c |  6 ++++--
>   4 files changed, 14 insertions(+), 13 deletions(-)
> 

I wonder if these bugs related to 
[CVE-2022-24448](https://nvd.nist.gov/vuln/detail/CVE-2022-24448) ?

[Question about 
CVE-2022-24448](https://lore.kernel.org/all/1bb42908-8f58-bf56-c2da-42739ee48d16@huawei.com/T/)

Is there POC of patch ac795161c936 ("NFSv4: Handle case where the lookup 
of a directory fails") ?

CVE-2022-24448 Description:
An issue was discovered in fs/nfs/dir.c in the Linux kernel before 
5.16.5. If an application sets the O_DIRECTORY flag, and tries to open a 
regular file, nfs_atomic_open() performs a regular lookup. If a regular 
file is found, ENOTDIR should occur, but the server instead returns 
uninitialized data in the file descriptor.
