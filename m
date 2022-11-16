Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C926B62BCA2
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Nov 2022 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiKPLyM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 06:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiKPLxt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 06:53:49 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDB612D07;
        Wed, 16 Nov 2022 03:45:06 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NC1Rv07ZDz15Md6;
        Wed, 16 Nov 2022 19:44:43 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 19:45:04 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 19:45:03 +0800
Message-ID: <eef82083-c158-4afa-645c-0bf1518d5db7@huawei.com>
Date:   Wed, 16 Nov 2022 19:45:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 0/2] NFS: check FMODE_EXEC from open context mode
To:     <trond.myklebust@hammerspace.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>, <anna@kernel.org>
References: <20220923054015.2890271-1-chenxiaosong2@huawei.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <20220923054015.2890271-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond:

Do you have any suggestions for this patchset ?

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
