Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB13C4CE4C1
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Mar 2022 13:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiCEMc1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Mar 2022 07:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiCEMcZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Mar 2022 07:32:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694323F3DF;
        Sat,  5 Mar 2022 04:31:35 -0800 (PST)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K9kVc4yKpzbcBG;
        Sat,  5 Mar 2022 20:26:48 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 20:31:32 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 20:31:31 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <smayhew@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next 0/2] nfs: check writeback errors correctly
Date:   Sat, 5 Mar 2022 20:46:34 +0800
Message-ID: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series fixes nfs writeback error checking bugs.

If there is an error during the writeback process, it should be returned
when user space calls close() or fsync().

filemap_sample_wb_err() will return 0 if nobody has seen the error yet,
then filemap_check_wb_err() will return the unchanged writeback error.

ChenXiaoSong (2):
  nfs: nfs{,4}_file_flush should consume writeback error
  nfs: nfs_file_write() check writeback errors correctly

 fs/nfs/file.c     | 8 +++-----
 fs/nfs/nfs4file.c | 4 +---
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.31.1

