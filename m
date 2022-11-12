Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DF626841
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Nov 2022 10:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiKLJEx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Nov 2022 04:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLJEw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Nov 2022 04:04:52 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D49FD4
        for <linux-nfs@vger.kernel.org>; Sat, 12 Nov 2022 01:04:52 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8V4y2ZdCz15Lxh;
        Sat, 12 Nov 2022 17:04:34 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:04:50 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:04:49 +0800
Subject: Re: Question about CVE-2022-43945
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <yi.zhang@huawei.com>
References: <48b858aa-028b-1f56-3740-e59eb7a5fca2@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <265166ff-cd0b-ea5f-ad28-fed756dfd4ff@huawei.com>
Date:   Sat, 12 Nov 2022 17:04:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <48b858aa-028b-1f56-3740-e59eb7a5fca2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2022/11/12 13:01, yangerkun wrote:
> Hi, Chuck Lever,
> 
> CVE-2022-43945(https://nvd.nist.gov/vuln/detail/CVE-2022-43945) describe 
> that a normal request header ended with garbage data can trigger the 
> nfsd overflow since nfsd share the request and response with the same 
> pages array.
> 
> It seems that the 
> patchset(https://lore.kernel.org/linux-nfs/166204973526.1435.6068003336048840051.stgit@manet.1015granger.net/T/#t) 
> has solved NFSv2/NFSv3, but leave NFSv4 still vulnerably?
> 
> Another question, for stable branch like lts-5.10, since NFSv2/NFSv3 did 
> not switch to xdr_stream, the nfs_request_too_big in nfsd_dispatch will 
> reject the request like READ/READDIR with too large request. So it seems 
> branch without that "switch" seems ok for NFSv2/NFSv3, but NFSv3 still 
> vulnerably. right?
> 
> Looking forward to your reply!

Sorry, notice that 76ce4dcec0dc"NFSD: Cap rsize_bop result based on send 
buffer size") fix same problem for NFSv4.

So, for the stable branch like lts-5.10 which NFSv2/NFSv3 do not switch 
to xdr_stream, it seems we only need 76ce4dcec0dc"NFSD: Cap rsize_bop 
result based on send buffer size"). Right?

> 
> Thanks,
> Erkun Yang
> .
