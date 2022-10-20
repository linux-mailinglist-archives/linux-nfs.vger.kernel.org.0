Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB15605569
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Oct 2022 04:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiJTCSD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 22:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiJTCSD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 22:18:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C5170DF6
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 19:18:00 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtB2y22dtzmVGw;
        Thu, 20 Oct 2022 10:13:14 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 10:17:35 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <linux-nfs@vger.kernel.org>,
        <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <chuck.lever@oracle.com>
Subject: [PATCH] nfs4: Fix kmemleak when allocate slot failed
Date:   Thu, 20 Oct 2022 11:20:54 +0800
Message-ID: <20221020032054.3260615-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If one of the slot allocate failed, should cleanup all the other
allocated slots, otherwise, the allocated slots will leak:

  unreferenced object 0xffff8881115aa100 (size 64):
    comm ""mount.nfs"", pid 679, jiffies 4294744957 (age 115.037s)
    hex dump (first 32 bytes):
      00 cc 19 73 81 88 ff ff 00 a0 5a 11 81 88 ff ff  ...s......Z.....
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<000000007a4c434a>] nfs4_find_or_create_slot+0x8e/0x130
      [<000000005472a39c>] nfs4_realloc_slot_table+0x23f/0x270
      [<00000000cd8ca0eb>] nfs40_init_client+0x4a/0x90
      [<00000000128486db>] nfs4_init_client+0xce/0x270
      [<000000008d2cacad>] nfs4_set_client+0x1a2/0x2b0
      [<000000000e593b52>] nfs4_create_server+0x300/0x5f0
      [<00000000e4425dd2>] nfs4_try_get_tree+0x65/0x110
      [<00000000d3a6176f>] vfs_get_tree+0x41/0xf0
      [<0000000016b5ad4c>] path_mount+0x9b3/0xdd0
      [<00000000494cae71>] __x64_sys_mount+0x190/0x1d0
      [<000000005d56bdec>] do_syscall_64+0x35/0x80
      [<00000000687c9ae4>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: abf79bb341bf ("NFS: Add a slot table to struct nfs_client for NFSv4.0 transport blocking")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/nfs/nfs4client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 7a5162afa5c0..1378e228bc04 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -346,6 +346,7 @@ int nfs40_init_client(struct nfs_client *clp)
 	ret = nfs4_setup_slot_table(tbl, NFS4_MAX_SLOT_TABLE,
 					"NFSv4.0 transport Slot table");
 	if (ret) {
+		nfs4_shutdown_slot_table(tbl);
 		kfree(tbl);
 		return ret;
 	}
-- 
2.31.1

