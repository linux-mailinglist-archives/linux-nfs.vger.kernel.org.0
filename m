Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EEC54BF49
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 03:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiFOBeh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jun 2022 21:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFOBeg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jun 2022 21:34:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F3E205DB;
        Tue, 14 Jun 2022 18:34:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LN78g3bTxzgZK5;
        Wed, 15 Jun 2022 09:32:35 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 09:34:33 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 09:34:32 +0800
Message-ID: <d82be232-8df4-86ff-ade5-4b9864e9cf40@huawei.com>
Date:   Wed, 15 Jun 2022 09:34:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
Subject: Re: [PATCH -next,v2] NFS: report and clear ENOSPC/EFBIG/EDQUOT
 writeback error on close() file
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
References: <20220614152817.271507-1-chenxiaosong2@huawei.com>
 <806ae30d4d53886e7d394cc9abb0b2045a314f01.camel@hammerspace.com>
In-Reply-To: <806ae30d4d53886e7d394cc9abb0b2045a314f01.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

在 2022/6/15 3:48, Trond Myklebust 写道:
> NACK. How many times do I have to repeat that we do NOT clear the error
> log in flush()?
> 

close(2) manpage described:

> ENOSPC, EDQUOT: On NFS, these errors are not normally reported
> against the first write which exceeds the available storage space,
> but instead against a subsequent write(2), fsync(2), or close(2).

> A  careful programmer will check the return value of close(), since
> it is quite possible that errors on a previous write(2) operation are
> reported only on the final close() that releases the open file
> description.  Failing to check the return value when closing a file
> may lead to silent loss of data.  This can especially be observed 
> with NFS and with disk quota.

write(2) manpage described:

> Since Linux 4.13, errors from write-back come with a promise that they
> may be reported by subsequent.  write(2) requests, and will be
> reported by a subsequent fsync(2) (whether or not they were also
> reported by write(2)).

Both close(2) and write(2) manpage described: report writeback error 
(not clear error), especially the write(2) manpage described: will be 
reported by a subsequent fsync(2) whether or not they were also reported 
by write(2).

If ENOSPC/EFBIG/EDQUOT writeback error can be cleared on write(), maybe 
it is better to be cleared on close() instead of saving the error for 
next open().
