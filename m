Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF381538B79
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 08:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbiEaGkL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 02:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiEaGkK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 02:40:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35524948;
        Mon, 30 May 2022 23:40:08 -0700 (PDT)
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LC2cs0cBzzBrpZ;
        Tue, 31 May 2022 14:37:01 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 14:40:06 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 14:40:05 +0800
Message-ID: <db55c8f7-6a6f-410e-74ca-4040364bd38a@huawei.com>
Date:   Tue, 31 May 2022 14:40:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE flag
To:     Lyu Tao <tao.lyu@epfl.ch>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjschuma@netapp.com" <bjschuma@netapp.com>,
        "anna@kernel.org" <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
 <68b65889-3b2c-fb72-a0a8-d0afc15a03e0@huawei.com>
 <e0c2d7ec62b447cabddbc8a9274be955@epfl.ch>
 <0b6546f7-8a04-9d6e-50c3-483c8a1a6591@huawei.com>
 <d73a51a2-6b63-b536-61e6-3d18563f027d@huawei.com>
 <3ee78045f18b4932b1651de776ee73c4@epfl.ch>
 <f927bec5-1078-dcb9-6f3e-a64d304efd5b@huawei.com>
 <55415e44b4b04bbfa66c42d5f2788384@epfl.ch>
 <88231dee-760f-b992-f1d1-81309076071e@huawei.com>
 <f794d0aaef654bffacda9159321d66e0@epfl.ch>
 <67d6a536-9027-1928-99b6-af512a36cd1a@huawei.com>
 <018da3c0453845329d5ae2ec8924af06@epfl.ch>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <018da3c0453845329d5ae2ec8924af06@epfl.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tao:

"NVD Last Modified" date of 
[CVE-2022-24448](https://nvd.nist.gov/vuln/detail/CVE-2022-24448) is 
already updated to 05/12/2022, but the description of the cve is still 
wrong, and the hyperlink of [unrelated patch: NFSv4: Handle case where 
the lookup of a directory 
fails](https://github.com/torvalds/linux/commit/ac795161c93699d600db16c1a8cc23a65a1eceaf) 
is still shown in the web.

There is two fix patches of the cve, the web just show one of my patches.

one patch is already shown in the web: [Revert "NFSv4: Handle the 
special Linux file open access 
mode"](https://github.com/torvalds/linux/commit/ab0fc21bc7105b54bafd85bd8b82742f9e68898a)

second patch is not shown in the web: [NFSv4: fix open failure with 
O_ACCMODE 
flag](https://github.com/torvalds/linux/commit/b243874f6f9568b2daf1a00e9222cacdc15e159c)

在 2022/5/6 15:40, Lyu Tao 写道:
>> From: chenxiaosong (A) <chenxiaosong2@huawei.com>
>> Sent: Thursday, May 5, 2022 4:48 AM
>> To: Lyu Tao
>> Cc: linux-nfs@vger.kernel.org; linux-kernel@vger.kernel.org; bjschuma@netapp.com; anna@kernel.org; Trond Myklebust; liuyongqiang13@huawei.com; yi.zhang@huawei.com; zhangxiaoxu5@huawei.com
>> Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE flag
>      
>> "NVD Last Modified" date of CVE-2022-24448 is updated as 04/29/2022, but the content of the cve is old.
>> https://nvd.nist.gov/vuln/detail/CVE-2022-24448
>   
> Hi,
> 
> Thanks for reaching out.
> 
> I've requested to update the CVE description and they replied me that it would be updated yesterday. Maybe the system need some time to reflesh. Let's wait a few more days.
> 
> Best,
> Tao.
> 
