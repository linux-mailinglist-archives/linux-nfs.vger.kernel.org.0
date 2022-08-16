Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AC8594F8C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 06:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiHPE1m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 00:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiHPE11 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 00:27:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964B1A6CD6;
        Mon, 15 Aug 2022 18:06:10 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6Cb15V6RzmVpd;
        Tue, 16 Aug 2022 09:03:57 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 09:06:08 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 09:06:07 +0800
Subject: Re: [PATCH] NFS: Fix missing unlock in nfs_unlink()
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <neilb@suse.de>
References: <20220812011440.3602849-1-sunke32@huawei.com>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <5e947976-0808-1d32-e170-d85ef73972e7@huawei.com>
Date:   Tue, 16 Aug 2022 09:06:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220812011440.3602849-1-sunke32@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

friendly ping...

ÔÚ 2022/8/12 9:14, Sun Ke Ð´µÀ:
> Add the missing unlock before goto.
> 
> Fixes: 3c59366c207e ("NFS: don't unhash dentry during unlink/rename")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>   fs/nfs/dir.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index dbab3caa15ed..1b879584d4fe 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2484,8 +2484,10 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
>   	 */
>   	error = -ETXTBSY;
>   	if (WARN_ON(dentry->d_flags & DCACHE_NFSFS_RENAMED) ||
> -	    WARN_ON(dentry->d_fsdata == NFS_FSDATA_BLOCKED))
> +	    WARN_ON(dentry->d_fsdata == NFS_FSDATA_BLOCKED)) {
> +		spin_unlock(&dentry->d_lock);
>   		goto out;
> +	}
>   	if (dentry->d_fsdata)
>   		/* old devname */
>   		kfree(dentry->d_fsdata);
> 
