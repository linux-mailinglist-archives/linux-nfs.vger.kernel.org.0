Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823DFF14C4
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2019 12:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfKFLPF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Nov 2019 06:15:05 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18234 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfKFLPF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Nov 2019 06:15:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc2ab3b0000>; Wed, 06 Nov 2019 03:15:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Nov 2019 03:15:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Nov 2019 03:15:05 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Nov
 2019 11:15:03 +0000
Subject: Re: [PATCH] SUNRPC: Avoid RPC delays when exiting suspend
To:     Trond Myklebust <trondmy@gmail.com>
CC:     <linux-nfs@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <329228f8-e194-a021-9226-69a9b6a403ce@nvidia.com>
 <20191105142133.28741-1-trond.myklebust@hammerspace.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3f536791-dbd1-cc9a-c88a-ddc26dd57c00@nvidia.com>
Date:   Wed, 6 Nov 2019 11:15:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105142133.28741-1-trond.myklebust@hammerspace.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573038907; bh=aU4BFCTKtdYxbt1HsDsxLzOmT9xxsqov2Vc3M/YNja4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NjjXEVo6X7SZi8UgPF1ysH7veK4bLdMkCGKvKjya1AZ/Qu+oHZ8D1VgpHh0b81pgo
         qu7JJGSaq47Y5NToVVDC0zZbWQwEJzmLCd6yuJLEUsgJ0MKcO+IjCU0yLbGKkxWLSs
         Hv3zdCNuTcaGee/FmvF2ZIHmkAribiv0AUEjnrXmIo3tlhPF0d10OFErrCW2oqOVKG
         Z7W7o3LkmdYwyhjB7Iian/Gr32u+Drsim9VxlDKPbcorSQICZFAR9T2fcLcEXq69Fr
         9I5hUSdF4dxnQ4+/t0uVRb6/JuVKqtS2sGkl/nxgFBEmFBzoH42nDaX6IkLuSX8AJM
         83vHncpJEdzgA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 05/11/2019 14:21, Trond Myklebust wrote:
> Jon Hunter: "I have been tracking down another suspend/NFS related
> issue where again I am seeing random delays exiting suspend. The delays
> can be up to a couple minutes in the worst case and this is causing a
> suspend test we have to fail."
> 
> Change the use of a deferrable work to a standard delayed one.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 7e0a0e38fcfea ("SUNRPC: Replace the queue timer with a delayed work function")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 360afe153193..987c4b1f0b17 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -260,7 +260,7 @@ static void __rpc_init_priority_wait_queue(struct rpc_wait_queue *queue, const c
>  	rpc_reset_waitqueue_priority(queue);
>  	queue->qlen = 0;
>  	queue->timer_list.expires = 0;
> -	INIT_DEFERRABLE_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
> +	INIT_DELAYED_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
>  	INIT_LIST_HEAD(&queue->timer_list.list);
>  	rpc_assign_waitqueue_name(queue, qname);
>  }

Thanks!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
