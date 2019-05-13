Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19E71AEC2
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2019 03:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfEMBwS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 May 2019 21:52:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfEMBwS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 12 May 2019 21:52:18 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0ADC0248A3493BF3EB84;
        Mon, 13 May 2019 09:48:40 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 May 2019
 09:48:36 +0800
Subject: Re: [PATCH] NFS4: Fix v4.0 client state corruption when mount
To:     <trond.myklebust@hammerspace.com>, <nna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
References: <1557115023-86769-1-git-send-email-zhangxiaoxu5@huawei.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <066b843e-33cc-e8a3-ad2b-f8d257d8a4df@huawei.com>
Date:   Mon, 13 May 2019 09:48:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1557115023-86769-1-git-send-email-zhangxiaoxu5@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping.

On 5/6/2019 11:57 AM, ZhangXiaoxu wrote:
> stat command with soft mount never return after server is stopped.
> 
> When alloc a new client, the state of the client will be set to
> NFS4CLNT_LEASE_EXPIRED.
> 
> When the server is stopped, the state manager will work, and accord
> the state to recover. But the state is NFS4CLNT_LEASE_EXPIRED, it
> will drain the slot table and lead other task to wait queue, until
> the client recovered. Then the stat command is hung.
> 
> When discover server trunking, the client will renew the lease,
> but check the client state, it lead the client state corruption.
> 
> So, we need to call state manager to recover it when detect server
> ip trunking.
> 
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>   fs/nfs/nfs4state.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 3de3647..f502f1c 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -159,6 +159,10 @@ int nfs40_discover_server_trunking(struct nfs_client *clp,
>   		/* Sustain the lease, even if it's empty.  If the clientid4
>   		 * goes stale it's of no use for trunking discovery. */
>   		nfs4_schedule_state_renewal(*result);
> +
> +		/* If the client state need to recover, do it. */
> +		if (clp->cl_state)
> +			nfs4_schedule_state_manager(clp);
>   	}
>   out:
>   	return status;
> 

