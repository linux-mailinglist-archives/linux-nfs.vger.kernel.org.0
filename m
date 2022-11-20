Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1CF6312AF
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Nov 2022 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKTG0u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Nov 2022 01:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTG0t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Nov 2022 01:26:49 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54B99E0AC
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 22:26:48 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NFL7V2wSHzFqPc;
        Sun, 20 Nov 2022 14:23:34 +0800 (CST)
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 14:26:46 +0800
Message-ID: <9d9c05f9-3c9f-a532-6829-4a36821d0f36@huawei.com>
Date:   Sun, 20 Nov 2022 14:26:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] xprtrdma: Fix regbuf data not freed in
 rpcrdma_req_create()
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20221119043437.1396270-1-zhangxiaoxu5@huawei.com>
 <1A22DD8E-CA7B-4071-9DC7-7434174192A3@oracle.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
In-Reply-To: <1A22DD8E-CA7B-4071-9DC7-7434174192A3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2022/11/20 0:13, Chuck Lever III wrote:
> 
> 
>> On Nov 18, 2022, at 11:34 PM, Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrote:
>>
>> If rdma receive buffer allocate failed, should call rpcrdma_regbuf_free()
>> to free the send buffer, otherwise, the buffer data will be leaked.
>>
>> Fixes: 8cec3dba76a4 ("xprtrdma: rpcrdma_regbuf alignment")
> 
> Actually Fixes: bb93a1ae2bf4 ("xprtrdma: Allocate req's regbufs
> at xprt create time") might be better. bb93a1ae2bf4 is the commit
> that incorrectly added the kfree() to rpcrdma_req_create().
> Even though 8cec3dba76a4 is what split the regbufs into two
> allocations, your fix isn't applicable to the rpcrdma_req_create()
> that's in 8cec3dba76a4.
>Thanks, I will change the fix tag and add your reviewed-by in v2.
> 
>> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> 
> I'm guessing the error path is getting exercised more once
> f20f18c95630 ("xprtrdma: Prevent memory allocations from driving
> a reclaim") has been applied. Good catch!
> 
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> 
> 
>> ---
>> net/sunrpc/xprtrdma/verbs.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>> index 44b87e4274b4..b098fde373ab 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -831,7 +831,7 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt,
>> 	return req;
>>
>> out3:
>> -	kfree(req->rl_sendbuf);
>> +	rpcrdma_regbuf_free(req->rl_sendbuf);
>> out2:
>> 	kfree(req);
>> out1:
>> -- 
>> 2.31.1
>>
> 
> --
> Chuck Lever
> 
> 
> 
> 
