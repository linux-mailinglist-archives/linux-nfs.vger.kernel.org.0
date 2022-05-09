Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD951FB35
	for <lists+linux-nfs@lfdr.de>; Mon,  9 May 2022 13:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiEIL1F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 May 2022 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiEIL06 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 May 2022 07:26:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63865209543
        for <linux-nfs@vger.kernel.org>; Mon,  9 May 2022 04:23:01 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kxdzd45PRzfbNN;
        Mon,  9 May 2022 19:21:49 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 19:22:59 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 19:22:58 +0800
Message-ID: <bfe2ef55-31bb-805d-4551-6365230b9f0d@huawei.com>
Date:   Mon, 9 May 2022 19:22:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] SUNRPC: Ensure gss-proxy connects on setup
From:   "wanghai (M)" <wanghai38@huawei.com>
To:     <trondmy@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>
CC:     Chuck Lever <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>
References: <20220429173629.621418-1-trondmy@kernel.org>
 <20220429173629.621418-2-trondmy@kernel.org>
 <20220429173629.621418-3-trondmy@kernel.org>
 <10c0ad38-d28c-1916-9dcc-6f3fd5e19ab8@huawei.com>
In-Reply-To: <10c0ad38-d28c-1916-9dcc-6f3fd5e19ab8@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


在 2022/5/9 18:28, wanghai (M) 写道:
>
> 在 2022/4/30 1:36, trondmy@kernel.org 写道:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> For reasons best known to the author, gss-proxy does not implement a
>> NULL procedure, and returns RPC_PROC_UNAVAIL. However we still want to
>> ensure that we connect to the service at setup time.
>> So add a quirk-flag specially for this case.
>>
>> Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for 
>> RPCGSS auth")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>   include/linux/sunrpc/clnt.h          | 1 +
>>   net/sunrpc/auth_gss/gss_rpc_upcall.c | 2 +-
>>   net/sunrpc/clnt.c                    | 3 +++
>>   3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
>> index 267b7aeaf1a6..db5149567305 100644
>> --- a/include/linux/sunrpc/clnt.h
>> +++ b/include/linux/sunrpc/clnt.h
>> @@ -160,6 +160,7 @@ struct rpc_add_xprt_test {
>>   #define RPC_CLNT_CREATE_NO_RETRANS_TIMEOUT    (1UL << 9)
>>   #define RPC_CLNT_CREATE_SOFTERR        (1UL << 10)
>>   #define RPC_CLNT_CREATE_REUSEPORT    (1UL << 11)
>> +#define RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL (1UL << 12)
>>     struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>>   struct rpc_clnt    *rpc_bind_new_program(struct rpc_clnt *,
>> diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.c 
>> b/net/sunrpc/auth_gss/gss_rpc_upcall.c
>> index 61c276bddaf2..8ca1d809b78d 100644
>> --- a/net/sunrpc/auth_gss/gss_rpc_upcall.c
>> +++ b/net/sunrpc/auth_gss/gss_rpc_upcall.c
>> @@ -97,7 +97,7 @@ static int gssp_rpc_create(struct net *net, struct 
>> rpc_clnt **_clnt)
>>            * timeout, which would result in reconnections being
>>            * done without the correct namespace:
>>            */
>> -        .flags        = RPC_CLNT_CREATE_NOPING |
>> +        .flags        = RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL |
>>                     RPC_CLNT_CREATE_NO_IDLE_TIMEOUT
>>       };
>>       struct rpc_clnt *clnt;
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index 98133aa54f19..22c28cf43eba 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -479,6 +479,9 @@ static struct rpc_clnt *rpc_create_xprt(struct 
>> rpc_create_args *args,
>>         if (!(args->flags & RPC_CLNT_CREATE_NOPING)) {
>>           int err = rpc_ping(clnt);
>> +        if ((args->flags & RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL) &&
>> +            err == -EOPNOTSUPP)
>> +            err = 0;
>
> Hi, Trond and Bruce
>
> After I apply this patch, gssproxy.service does not work properly.
>
>
> The following is the abnormal working log
> [root@localhost ~]# systemctl restart gssproxy.service
> [root@localhost ~]# cat /proc/net/rpc/use-gss-proxy
> -1
> [root@localhost ~]#
>
> On failure, rpc_ping() returns -EIO. should the following change be 
> made here
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 22c28cf43eba..314b6fd60e2f 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -480,7 +480,7 @@ static struct rpc_clnt *rpc_create_xprt(struct 
> rpc_create_args *args,
>         if (!(args->flags & RPC_CLNT_CREATE_NOPING)) {
>                 int err = rpc_ping(clnt);
>                 if ((args->flags & 
> RPC_CLNT_CREATE_IGNORE_NULL_UNAVAIL) &&
> -                   err == -EOPNOTSUPP)
> +                   (err == -EOPNOTSUPP || err == -EIO))
>                         err = 0;
>                 if (err != 0) {
>                         rpc_shutdown_client(clnt);

Below is the rpc log

[root@localhost ~]# systemctl restart gssproxy.service

[  115.536788][ T2911] systemd-journald[2911]: Successfully sent stream 
file descriptor to service manager.
[  115.769042][ T6604] RPC:       set up xprt to /var/run/gssproxy.sock 
via AF_LOCAL
[  115.774253][ T6604] RPC:       worker connecting xprt 
ffff888116f24000 via AF_LOCAL to /var/run/gssproxy.sock
[  115.777719][ T6604] RPC:       xprt ffff888116f24000 connected to 
/var/run/gssproxy.sock
[  115.780634][ T6604] RPC:       xs_local_send_request(40) = 0

[  125.825668][ T6604] RPC:       failed to create AF_LOCAL gssproxy 
client (errno -5).
[  125.832021][   T31] RPC:       xs_destroy xprt ffff888116f24000
[  125.834805][   T31] RPC:       xs_close xprt ffff888116f24000
>
>>           if (err != 0) {
>>               rpc_shutdown_client(clnt);
>>               return ERR_PTR(err);
>
-- 
Wang Hai

