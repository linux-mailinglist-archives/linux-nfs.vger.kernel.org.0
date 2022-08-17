Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADF8596706
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Aug 2022 03:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiHQBuK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 21:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbiHQBuJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 21:50:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8FC97D6D;
        Tue, 16 Aug 2022 18:50:09 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6rVJ2bC6zlWCD;
        Wed, 17 Aug 2022 09:47:04 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:50:07 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:50:06 +0800
Subject: Re: [PATCH] NFS: Fix missing unlock in nfs_unlink()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <linux-nfs@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <neilb@suse.de>
References: <20220812011440.3602849-1-sunke32@huawei.com>
 <5e947976-0808-1d32-e170-d85ef73972e7@huawei.com>
 <20220816082813.GR3438@kadam>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <1cc3d8f5-5853-17b5-749d-b821a1c57699@huawei.com>
Date:   Wed, 17 Aug 2022 09:50:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220816082813.GR3438@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



在 2022/8/16 16:28, Dan Carpenter 写道:
> On Tue, Aug 16, 2022 at 09:06:06AM +0800, Sun Ke wrote:
>> friendly ping...
>>
>> 在 2022/8/12 9:14, Sun Ke 写道:
>>> Add the missing unlock before goto.
> 
> 
> The patch is correct, but please wait at least two weeks before sending
> reminders.  Longer than two weeks if the merge window is open.

Sorry for that, two weeks, got it. By the way, I find the patch have 
merged to next.

Thanks.
Sun Ke
> 
> regards,
> dan carpenter
> 
> .
> 
