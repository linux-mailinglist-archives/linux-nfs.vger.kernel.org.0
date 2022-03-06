Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8D4CEA18
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Mar 2022 09:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiCFIvK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 03:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiCFIvJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 03:51:09 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFAA6580B;
        Sun,  6 Mar 2022 00:50:17 -0800 (PST)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KBFXp1MZhz1GBwq;
        Sun,  6 Mar 2022 16:45:30 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 16:50:14 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 16:50:14 +0800
Message-ID: <1789b0d7-edc1-8c66-602b-2ca66de7a2be@huawei.com>
Date:   Sun, 6 Mar 2022 16:50:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next 2/2] nfs: nfs_file_write() check writeback errors
 correctly
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
 <20220305124636.2002383-3-chenxiaosong2@huawei.com>
 <461aafe64a56836b8d248556052f8d00b6d37731.camel@hammerspace.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <461aafe64a56836b8d248556052f8d00b6d37731.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

filemap_sample_wb_err() -> errseq_sample() initialise errseq_t variable 
`since`, the caller of this function will checks for an error using 
filemap_check_wb_err(since) -> errseq_check().

filemap_sample_wb_err's purpose is just sampling consumed (seen) 
writeback error to initialise errseq_t variable. I understand that 
filemap_sample_wb_err()/filemap_check_wb_err() cannot detect the new 
error between filemap_sample_wb_err() and filemap_check_wb_err().

It would be better using file->f_mapping->wb_err instead of 
filemap_sample_wb_err() in nfs_file_write() to sample wb_err at that 
time point.

In do_dentry_open(), we just sample consumed(seen) writeback error. It 
is necessary to consume the writeback error before close() over.

There is some cases that writeback error have not been consumed(seen) 
after close() file over, I think it is unexpected behavior, is this a 
bug? It is worth noting that fsync() will not be called after close() in 
nfs.

在 2022/3/6 1:12, Trond Myklebust 写道:
> Hmm... Why isn't this considered a bug with filemap_sample_wb_err()? If
> what you say is true, then do_dentry_open() could be picking up
> existing errors from the filesystem and from the inode and propagating
> them to random processes.
> 
> It basically means everyone who cares about correctness of the error
> return values needs to do a fsync() immediately after open() in order
> to sync up the value in file->f_wb_err.
> 
