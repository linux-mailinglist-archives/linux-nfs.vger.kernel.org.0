Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2650840A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Apr 2022 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiDTIxZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Apr 2022 04:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376899AbiDTIxY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Apr 2022 04:53:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195A33EBE;
        Wed, 20 Apr 2022 01:50:36 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KjvW21g3Fz1J9sP;
        Wed, 20 Apr 2022 16:49:50 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 16:50:34 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 16:50:34 +0800
Message-ID: <a3300d4d-6428-8157-b2dc-eaeb9f249858@huawei.com>
Date:   Wed, 20 Apr 2022 16:50:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
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
 <ccd017a4-31f1-297f-b2e2-e71eb16f1159@huawei.com>
 <9fc83915a24d7b65d743910dd0f0e5f3d0373596.camel@hammerspace.com>
In-Reply-To: <9fc83915a24d7b65d743910dd0f0e5f3d0373596.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

在 2022/4/12 22:27, Trond Myklebust 写道:

>
> It will clear ENOSPC, EDQUOT and EFBIG. It should not clear other
> errors that are not supposed to be reported by write().
> 
> As I keep repeating, that is _documented behaviour_!
> 

Hi Trond:

You may mean that write(2) manpage described:

> Since Linux 4.13, errors from write-back come with a promise that
> they may be reported by subsequent.  write(2) requests, and will be
> reported by a subsequent fsync(2) (whether or not they were also
> reported by write(2)).

The manpage mentioned that "reported by a subsequent fsync(2)", your 
patch[1] clear the wb err on _async_ write(), and wb err will _not_ be 
reported by subsequent fsync(2), is it documented behaviour?

All other filesystems will _not_ clear any wb err on _async_ write().

[1] 
https://patchwork.kernel.org/project/linux-nfs/patch/20220411213346.762302-4-trondmy@kernel.org/


