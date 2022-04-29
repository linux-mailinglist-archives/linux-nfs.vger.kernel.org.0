Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7651405B
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 03:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbiD2Bq4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 21:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiD2Bqz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 21:46:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0281BF333
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 18:43:38 -0700 (PDT)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KqFch1qy0zhYSP;
        Fri, 29 Apr 2022 09:43:16 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 09:43:36 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 09:43:36 +0800
Message-ID: <2bd62035-21eb-d4a4-0ad6-32e90a674d70@huawei.com>
Date:   Fri, 29 Apr 2022 09:43:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] SUNRPC: Don't leak sockets in xs_local_connect()
To:     <trondmy@kernel.org>, <linux-nfs@vger.kernel.org>
References: <20220428153001.9545-1-trondmy@kernel.org>
From:   "wanghai (M)" <wanghai38@huawei.com>
In-Reply-To: <20220428153001.9545-1-trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


在 2022/4/28 23:30, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If there is still a closed socket associated with the transport, then we
> need to trigger an autoclose before we can set up a new connection.
>
> Reported-by: wanghai (M) <wanghai38@huawei.com>
> Fixes: f00432063db1 ("SUNRPC: Ensure we flush any closed sockets before xs_xprt_free()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   net/sunrpc/xprtsock.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
Hi, Trond.
Thank you for taking the time to help!

I tested it with this patch and found that the problem still exists.
The path of the sock leak is as follows and is not in xs_local_connect()

write_ports
   nfsd_create_serv
     svc_bind
       rpcb_create_local
         rpcb_create_local_unix
           rpc_create
             xprt_create_transport
               xs_setup_local
                 xs_local_setup_socket
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 8ab64ea46870..f9849b297ea3 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1950,6 +1950,9 @@ static void xs_local_connect(struct rpc_xprt *xprt, struct rpc_task *task)
>   	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
>   	int ret;
>   
> +	if (transport->file)
> +		goto force_disconnect;
> +
>   	if (RPC_IS_ASYNC(task)) {
>   		/*
>   		 * We want the AF_LOCAL connect to be resolved in the
> @@ -1962,11 +1965,17 @@ static void xs_local_connect(struct rpc_xprt *xprt, struct rpc_task *task)
>   		 */
>   		task->tk_rpc_status = -ENOTCONN;
>   		rpc_exit(task, -ENOTCONN);
> -		return;
> +		goto out_wake;
>   	}
>   	ret = xs_local_setup_socket(transport);
>   	if (ret && !RPC_IS_SOFTCONN(task))
>   		msleep_interruptible(15000);
> +	return;
> +force_disconnect:
> +	xprt_force_disconnect(xprt);
> +out_wake:
> +	xprt_clear_connecting(xprt);
> +	xprt_wake_pending_tasks(xprt, -ENOTCONN);
>   }
>   
>   #if IS_ENABLED(CONFIG_SUNRPC_SWAP)

-- 
Wang Hai

