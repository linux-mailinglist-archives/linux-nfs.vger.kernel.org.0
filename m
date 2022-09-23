Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA125E72FB
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 06:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIWEf3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 00:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIWEf1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 00:35:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E99EA5A9;
        Thu, 22 Sep 2022 21:35:26 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYfNf6SlZzlX87;
        Fri, 23 Sep 2022 12:31:14 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 12:35:24 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 12:35:23 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH v2 0/2] NFS: check FMODE_EXEC from open context mode
Date:   Fri, 23 Sep 2022 13:36:03 +0800
Message-ID: <20220923053605.2723395-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, we check FMODE_EXEC from file f_flags, and check FMODE_READ or
FMODE_WRITE from open context mode.

ChenXiaoSong (2):
  NFS: make sure open context mode have FMODE_EXEC when file open for
    exec
  NFSv4: check FMODE_EXEC from open context mode in
    nfs4_opendata_access()

 fs/nfs/inode.c    |  3 ++-
 fs/nfs/nfs4file.c | 12 ++++--------
 fs/nfs/nfs4proc.c | 16 +++++-----------
 3 files changed, 11 insertions(+), 20 deletions(-)

-- 
v1->v2: use FMODE_EXEC instead of __FMODE_EXEC in nfs4_opendata_access to
	fix compiler warning

2.31.1

