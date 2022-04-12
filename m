Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A234FE388
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbiDLOPT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiDLOPT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 10:15:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7971D0C1;
        Tue, 12 Apr 2022 07:13:01 -0700 (PDT)
Received: from kwepemi500018.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kd71T5tNPzgYbW;
        Tue, 12 Apr 2022 22:11:09 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500018.china.huawei.com (7.221.188.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 22:12:58 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 22:12:58 +0800
Message-ID: <ccd017a4-31f1-297f-b2e2-e71eb16f1159@huawei.com>
Date:   Tue, 12 Apr 2022 22:12:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next 1/2] nfs: nfs{,4}_file_flush should consume
 writeback error
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
 <20220305124636.2002383-2-chenxiaosong2@huawei.com>
 <ca81e90788eabbf6b5df5db7ea407199a6a3aa04.camel@hammerspace.com>
 <5666cb64-c9e4-0549-6ddb-cfc877c9c071@huawei.com>
 <eab4bbb565a50bd09c2dbd3522177237fde2fad9.camel@hammerspace.com>
 <037054f5ac2cd13e59db14b12f4ab430f1ddef5d.camel@hammerspace.com>
 <4a8e21fb-d8bf-5428-67e5-41c47529e641@huawei.com>
 <0528423f710cd612262666b1533763943c717273.camel@hammerspace.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <0528423f710cd612262666b1533763943c717273.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

在 2022/4/12 21:56, Trond Myklebust 写道:
> On Tue, 2022-04-12 at 21:46 +0800, chenxiaosong (A) wrote:
>>
>> Other filesystem will _not_ clear writeback error on close().
>> And other filesystem will _not_ clear writeback error on async
>> write() too.
>>
>> Other filesystem _only_ clear writeback error on fsync() or sync
>> write().
>>
> 
> Yes. We might even consider not reporting writeback errors at all in
> close(), since most developers don't check it. We certainly don't want
> to clear those errors there because the manpages don't document that as
> being the case.
> 
>> Should NFS follow the same semantics as all the other filesystems?
> 
> It needs to follow the semantics described in the manpage for write(2)
> and fsync(2) as closely as possible, yes. That documentation is
> supposed to be normative for application developers.
> 
> We won't guarantee to immediately report ENOSPC like other filesystems
> do (because that would require us to only support synchronous writes),
> however that behaviour is already documented in the manpage.
> 
> We may also report some errors that are not documented in the manpage
> (e.g. EACCES or EROFS) simply because those errors cannot always be
> reported at open() time, as would be the case for a local filesystem.
> That's just how the NFS protocol works (particularly for the case of
> the stateless NFSv3 protocol).
> 

After merging your patchset, NFS will clear wb error on async write(), 
is this reasonable?

And more importantly, we can not detect new error by using 
filemap_sample_wb_err()/filemap_sample_wb_err() while nfs_wb_all(),just 
as I described:

```c
   since = filemap_sample_wb_err() = 0
     errseq_sample
       if (!(old & ERRSEQ_SEEN)) // nobody see the error
         return 0;
   nfs_wb_all // no new error
   error = filemap_check_wb_err(..., since) != 0 // unexpected error
```
