Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C99660558D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Oct 2022 04:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJTCjl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 22:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJTCjj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 22:39:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B62F001
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 19:39:32 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MtBZB4qkRzJn6f;
        Thu, 20 Oct 2022 10:36:50 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 10:38:57 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <linux-nfs@vger.kernel.org>,
        <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <chuck.lever@oracle.com>, <kolga@netapp.com>
Subject: [PATCH] SUNRPC: Fix null-ptr-deref when xps sysfs alloc failed
Date:   Thu, 20 Oct 2022 11:42:17 +0800
Message-ID: <20221020034217.3289013-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is a null-ptr-deref when xps sysfs alloc failed:
  BUG: KASAN: null-ptr-deref in sysfs_do_create_link_sd+0x40/0xd0
  Read of size 8 at addr 0000000000000030 by task gssproxy/457

  CPU: 5 PID: 457 Comm: gssproxy Not tainted 6.0.0-09040-g02357b27ee03 #9
  Call Trace:
   <TASK>
   dump_stack_lvl+0x34/0x44
   kasan_report+0xa3/0x120
   sysfs_do_create_link_sd+0x40/0xd0
   rpc_sysfs_client_setup+0x161/0x1b0
   rpc_new_client+0x3fc/0x6e0
   rpc_create_xprt+0x71/0x220
   rpc_create+0x1d4/0x350
   gssp_rpc_create+0xc3/0x160
   set_gssp_clnt+0xbc/0x140
   write_gssp+0x116/0x1a0
   proc_reg_write+0xd6/0x130
   vfs_write+0x177/0x690
   ksys_write+0xb9/0x150
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

When the xprt_switch sysfs alloc failed, should not add xprt and
switch sysfs to it, otherwise, maybe null-ptr-deref; also initialize
the 'xps_sysfs' to NULL to avoid oops when destroy it.

Fixes: 2a338a543163 ("sunrpc: add a symlink from rpc-client directory to the xprt_switch")
Fixes: d408ebe04ac5 ("sunrpc: add add sysfs directory per xprt under each xprt_switch")
Fixes: baea99445dd4 ("sunrpc: add xprt_switch direcotry to sunrpc's sysfs")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 net/sunrpc/sysfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index c65c90ad626a..c1f559892ae8 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -518,13 +518,16 @@ void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
 			    struct net *net)
 {
 	struct rpc_sysfs_client *rpc_client;
+	struct rpc_sysfs_xprt_switch *xswitch =
+		(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+
+	if (!xswitch)
+		return;
 
 	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj,
 					    net, clnt->cl_clid);
 	if (rpc_client) {
 		char name[] = "switch";
-		struct rpc_sysfs_xprt_switch *xswitch =
-			(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
 		int ret;
 
 		clnt->cl_sysfs = rpc_client;
@@ -558,6 +561,8 @@ void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 		rpc_xprt_switch->xprt_switch = xprt_switch;
 		rpc_xprt_switch->xprt = xprt;
 		kobject_uevent(&rpc_xprt_switch->kobject, KOBJ_ADD);
+	} else {
+		xprt_switch->xps_sysfs = NULL;
 	}
 }
 
@@ -569,6 +574,9 @@ void rpc_sysfs_xprt_setup(struct rpc_xprt_switch *xprt_switch,
 	struct rpc_sysfs_xprt_switch *switch_obj =
 		(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
 
+	if (!switch_obj)
+		return;
+
 	rpc_xprt = rpc_sysfs_xprt_alloc(&switch_obj->kobject, xprt, gfp_flags);
 	if (rpc_xprt) {
 		xprt->xprt_sysfs = rpc_xprt;
-- 
2.31.1

