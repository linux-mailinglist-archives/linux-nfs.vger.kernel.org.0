Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31051BBC8
	for <lists+linux-nfs@lfdr.de>; Thu,  5 May 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352474AbiEEJXD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 May 2022 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiEEJXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 May 2022 05:23:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B754DF44
        for <linux-nfs@vger.kernel.org>; Thu,  5 May 2022 02:19:23 -0700 (PDT)
Received: from kwepemi100020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kv7Qw3zcFzfbML;
        Thu,  5 May 2022 17:18:16 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 kwepemi100020.china.huawei.com (7.221.188.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 17:19:21 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 17:19:20 +0800
Message-ID: <4438a80a-de11-8261-f705-49342e505579@huawei.com>
Date:   Thu, 5 May 2022 17:19:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] Revert "SUNRPC: attempt AF_LOCAL connect on setup"
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20220429173629.621418-1-trondmy@kernel.org>
 <20220429173629.621418-2-trondmy@kernel.org>
 <20220429173629.621418-3-trondmy@kernel.org>
 <20220429173629.621418-4-trondmy@kernel.org>
 <e10869294d391c9521f35c8564c73a45c21131b5.camel@hammerspace.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
In-Reply-To: <e10869294d391c9521f35c8564c73a45c21131b5.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


在 2022/4/30 8:56, Trond Myklebust 写道:
> On Fri, 2022-04-29 at 13:36 -0400, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> This reverts commit 7073ea8799a8cf73db60270986f14e4aae20fa80.
>>
>> We must not try to connect the socket while the transport is under
>> construction, because the mechanisms to safely tear it down are not
>> in
>> place.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Sorry. I intended to add a
>
> "Reported-by: wanghai (M) <wanghai38@huawei.com>"
>
> That has been added to the version in my "testing" branch.
>
Thanks for your help, I tested it carefully and this patchset can solve 
my problem.

By the way, when can this patchset be applied to linux mainline?

-- 
Wang Hai

