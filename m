Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801DC52F7FB
	for <lists+linux-nfs@lfdr.de>; Sat, 21 May 2022 05:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiEUDYR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 23:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354434AbiEUDYP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 23:24:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA819592E
        for <linux-nfs@vger.kernel.org>; Fri, 20 May 2022 20:24:14 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L4pnN1Vx8z1JC5R;
        Sat, 21 May 2022 11:22:48 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 11:24:12 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <bfields@fieldses.org>,
        <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>,
        <yi.zhang@huawei.com>, <luomeng12@huawei.com>, <dai.ngo@oracle.com>
Subject: [v2 2/2] nfsd: Fix null-ptr-deref in nfsd_fill_super()
Date:   Sat, 21 May 2022 12:08:45 +0800
Message-ID: <20220521040845.619409-3-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521040845.619409-1-zhangxiaoxu5@huawei.com>
References: <20220521040845.619409-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

KASAN report null-ptr-deref as follows:

  BUG: KASAN: null-ptr-deref in nfsd_fill_super+0xc6/0xe0 [nfsd]
  Write of size 8 at addr 000000000000005d by task a.out/852

  CPU: 7 PID: 852 Comm: a.out Not tainted 5.18.0-rc7-dirty #66
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x34/0x44
   kasan_report+0xab/0x120
   ? nfsd_mkdir+0x71/0x1c0 [nfsd]
   ? nfsd_fill_super+0xc6/0xe0 [nfsd]
   nfsd_fill_super+0xc6/0xe0 [nfsd]
   ? nfsd_mkdir+0x1c0/0x1c0 [nfsd]
   get_tree_keyed+0x8e/0x100
   vfs_get_tree+0x41/0xf0
   __do_sys_fsconfig+0x590/0x670
   ? fscontext_read+0x180/0x180
   ? anon_inode_getfd+0x4f/0x70
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

This can be reproduce by concurrent operations:
	1. fsopen(nfsd)/fsconfig
	2. insmod/rmmod nfsd

Since the nfsd file system is registered before than nfsd_net allocated,
the caller may get the file_system_type and use the nfsd_net before it
allocated, then null-ptr-deref occurred.

So init_nfsd() should call register_filesystem() last.

Fixes: bd5ae9288d64 ("nfsd: register pernet ops last, unregister first")
Cc: stable@kernel.org
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/nfsd/nfsctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 55949e60897d..0621c2faf242 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1535,25 +1535,25 @@ static int __init init_nfsd(void)
 	retval = create_proc_exports_entry();
 	if (retval)
 		goto out_free_lockd;
-	retval = register_filesystem(&nfsd_fs_type);
-	if (retval)
-		goto out_free_exports;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_filesystem;
+		goto out_free_exports;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
 	retval = nfsd4_create_laundry_wq();
+	if (retval)
+		goto out_free_cld;
+	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
 		goto out_free_all;
 	return 0;
 out_free_all:
+	nfsd4_destroy_laundry_wq();
+out_free_cld:
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_filesystem:
-	unregister_filesystem(&nfsd_fs_type);
 out_free_exports:
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
@@ -1571,6 +1571,7 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	unregister_filesystem(&nfsd_fs_type);
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
@@ -1581,7 +1582,6 @@ static void __exit exit_nfsd(void)
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
-	unregister_filesystem(&nfsd_fs_type);
 }
 
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
-- 
2.31.1

