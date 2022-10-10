Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199DD5F967E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Oct 2022 03:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJJBSS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Oct 2022 21:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJJBSR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Oct 2022 21:18:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78427DD5;
        Sun,  9 Oct 2022 18:18:16 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mm1DV28X7zpVhw;
        Mon, 10 Oct 2022 09:15:06 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 09:18:14 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 09:18:13 +0800
Message-ID: <c57c461e-1e4a-e0fd-177b-af4943df1aca@huawei.com>
Date:   Mon, 10 Oct 2022 09:18:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 0/2] NFS: check FMODE_EXEC from open context mode
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
References: <20220923054015.2890271-1-chenxiaosong2@huawei.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <20220923054015.2890271-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Friendly ping...

在 2022/9/23 13:40, ChenXiaoSong 写道:
> Currently, we check FMODE_EXEC from file f_flags, and check FMODE_READ or
> FMODE_WRITE from open context mode.
> 
> After converting file f_flags to open context mode by flags_to_mode(),
> we can check all mode from open context mode.
> 
> ChenXiaoSong (2):
>    NFS: make sure open context mode have FMODE_EXEC when file open for
>      exec
>    NFSv4: check FMODE_EXEC from open context mode in
>      nfs4_opendata_access()
> 
>   fs/nfs/inode.c    |  3 ++-
>   fs/nfs/nfs4file.c | 12 ++++--------
>   fs/nfs/nfs4proc.c | 16 +++++-----------
>   3 files changed, 11 insertions(+), 20 deletions(-)
> 
