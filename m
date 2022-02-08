Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E74AD7DF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 12:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiBHLvE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 06:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358967AbiBHLuq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 06:50:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C1BC03E95F
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 03:49:01 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtLqL56yTzbkBr;
        Tue,  8 Feb 2022 19:47:58 +0800 (CST)
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 19:48:58 +0800
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
To:     <tao.lyu@epfl.ch>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
CC:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        yanaijie <yanaijie@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Question about CVE-2022-24448
Message-ID: <1bb42908-8f58-bf56-c2da-42739ee48d16@huawei.com>
Date:   Tue, 8 Feb 2022 19:48:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond and Tao,

I have some question about CVE-2022-24448[1].

It's description as:
   An issue was discovered in fs/nfs/dir.c in the Linux kernel before 5.16.5.
   If an application sets the O_DIRECTORY flag, and tries to open a regular
   file, nfs_atomic_open() performs a regular lookup. If a regular file is
   found, ENOTDIR should occur, but the server instead returns uninitialized
   data in the file descriptor.

It's fixed by ac795161c936 ("NFSv4: Handle case where the lookup of a directory fails")

When try to open a regular file with O_DIRECTORY flag,
it always return -ENOTDIR to userspace rather than a
valid file descriptor because the 'do_open' check the
dentry type.

My questions are:
1. which uninitialized data in the file description are returned from 'nfs_atomic_open'?
2. where use the uninitialized data?
3. which uninitialized data are returned from server?
4. is there a PoC reproducer or how to trigger it?


[1] https://nvd.nist.gov/vuln/detail/CVE-2022-24448
