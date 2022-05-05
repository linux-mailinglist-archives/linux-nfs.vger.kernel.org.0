Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA251B618
	for <lists+linux-nfs@lfdr.de>; Thu,  5 May 2022 04:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiEECvx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 May 2022 22:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbiEECvw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 May 2022 22:51:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE128E0B;
        Wed,  4 May 2022 19:48:14 -0700 (PDT)
Received: from kwepemi100026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ktyjj3Tw4zGpXT;
        Thu,  5 May 2022 10:45:29 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100026.china.huawei.com (7.221.188.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 10:48:12 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 10:48:11 +0800
Message-ID: <67d6a536-9027-1928-99b6-af512a36cd1a@huawei.com>
Date:   Thu, 5 May 2022 10:48:10 +0800
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
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <f794d0aaef654bffacda9159321d66e0@epfl.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

"NVD Last Modified" date of CVE-2022-24448 is updated as 04/29/2022, but 
the content of the cve is old.

https://nvd.nist.gov/vuln/detail/CVE-2022-24448
