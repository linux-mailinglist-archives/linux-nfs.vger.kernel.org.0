Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB628647B6D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Dec 2022 02:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLIB2F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Dec 2022 20:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIB2F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Dec 2022 20:28:05 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D71801E4
        for <linux-nfs@vger.kernel.org>; Thu,  8 Dec 2022 17:28:04 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NStbY5cf4zJp6q;
        Fri,  9 Dec 2022 09:24:25 +0800 (CST)
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 09:27:57 +0800
Message-ID: <127311ec-74ad-1e8b-57f7-64daf313aefe@huawei.com>
Date:   Fri, 9 Dec 2022 09:27:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] NFSv4.x: Fail client initialisation if state manager
 thread can't run
To:     <trondmy@kernel.org>, <linux-nfs@vger.kernel.org>
References: <20221206190249.438037-1-trondmy@kernel.org>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <20221206190249.438037-1-trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFSv4.0 do not have this bug, maybe the subject shoud begin with "NFS4.1".

在 2022/12/7 3:02, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If the state manager thread fails to start, then we should just mark the
> client initialisation as failed so that other processes or threads don't
> get stuck in nfs_wait_client_init_complete().
> 
> Reported-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> Fixes: 4697bd5e9419 ("NFSv4: Fix a race in the net namespace mount notification")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/nfs4state.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 7c1f43507813..5720196141e1 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1230,6 +1230,8 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
>   	if (IS_ERR(task)) {
>   		printk(KERN_ERR "%s: kthread_run: %ld\n",
>   			__func__, PTR_ERR(task));
> +		if (!nfs_client_init_is_complete(clp))
> +			nfs_mark_client_ready(clp, PTR_ERR(task));
>   		nfs4_clear_state_manager_bit(clp);
>   		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
>   		nfs_put_client(clp);
> 
