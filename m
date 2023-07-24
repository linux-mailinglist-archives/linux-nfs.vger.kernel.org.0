Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDFD75EBE6
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGXGpb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 02:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGXGp2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 02:45:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBE7107;
        Sun, 23 Jul 2023 23:45:27 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R8VwC4S0xzHqc5;
        Mon, 24 Jul 2023 14:42:51 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 14:45:23 +0800
Subject: Re: [PATCH -next] sunrpc: Remove unused extern declarations
To:     NeilBrown <neilb@suse.de>
CC:     <chuck.lever@oracle.com>, <jlayton@kernel.org>, <kolga@netapp.com>,
        <Dai.Ngo@oracle.com>, <tom@talpey.com>,
        <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230722033116.17988-1-yuehaibing@huawei.com>
 <169017533908.11078.1160756498004010060@noble.neil.brown.name>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <d8178e7c-d0ec-9e5d-9367-53f554e0392e@huawei.com>
Date:   Mon, 24 Jul 2023 14:45:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <169017533908.11078.1160756498004010060@noble.neil.brown.name>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2023/7/24 13:08, NeilBrown wrote:
> On Sat, 22 Jul 2023, YueHaibing wrote:
>> Since commit 49b28684fdba ("nfsd: Remove deprecated nfsctl system call and related code.")
>> these declarations are unused, so can remove it.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Thanks.
> Could you remove the declaration of auth_unix_lookup too?
> It was removed in that commit, but the declaration is still with us.

Sure, will do this.
> 
> Thanks!
> NeilBrown
> 
>> ---
>>  include/linux/sunrpc/svcauth.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
>> index 6d9cc9080aca..2402b7ca5d1a 100644
>> --- a/include/linux/sunrpc/svcauth.h
>> +++ b/include/linux/sunrpc/svcauth.h
>> @@ -157,11 +157,9 @@ extern void	svc_auth_unregister(rpc_authflavor_t flavor);
>>  
>>  extern struct auth_domain *unix_domain_find(char *name);
>>  extern void auth_domain_put(struct auth_domain *item);
>> -extern int auth_unix_add_addr(struct net *net, struct in6_addr *addr, struct auth_domain *dom);
>>  extern struct auth_domain *auth_domain_lookup(char *name, struct auth_domain *new);
>>  extern struct auth_domain *auth_domain_find(char *name);
>>  extern struct auth_domain *auth_unix_lookup(struct net *net, struct in6_addr *addr);
>> -extern int auth_unix_forget_old(struct auth_domain *dom);
>>  extern void svcauth_unix_purge(struct net *net);
>>  extern void svcauth_unix_info_release(struct svc_xprt *xpt);
>>  extern int svcauth_unix_set_client(struct svc_rqst *rqstp);
>> -- 
>> 2.34.1
>>
>>
> 
> .
> 
