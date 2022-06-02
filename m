Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1DA53B32C
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jun 2022 07:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiFBF4y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jun 2022 01:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiFBF4v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jun 2022 01:56:51 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D15B05;
        Wed,  1 Jun 2022 22:56:47 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 2525uY8M014913-2525uY8P014913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 2 Jun 2022 13:56:38 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: nfsd: make destory function more elegant
Date:   Thu,  2 Jun 2022 13:56:32 +0800
Message-Id: <20220602055633.849545-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

In init_nfsd, the undo operation of create_proc_exports_entry is:

        remove_proc_entry("fs/nfs/exports", NULL);
        remove_proc_entry("fs/nfs", NULL);

This may lead to maintaince issue. Declare the undo function
destroy_proc_exports_entry based on CONFIG_PROC_FS

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/nfsd/nfsctl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0621c2faf242..83b34ccbef5a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1450,11 +1450,21 @@ static int create_proc_exports_entry(void)
 	}
 	return 0;
 }
+
+static void destroy_proc_exports_entry(void)
+{
+	remove_proc_entry("fs/nfs/exports", NULL);
+	remove_proc_entry("fs/nfs", NULL);
+}
 #else /* CONFIG_PROC_FS */
 static int create_proc_exports_entry(void)
 {
 	return 0;
 }
+
+static void destroy_proc_exports_entry(void)
+{
+}
 #endif
 
 unsigned int nfsd_net_id;
@@ -1555,8 +1565,7 @@ static int __init init_nfsd(void)
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
 out_free_exports:
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
+	destroy_proc_exports_entry();
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -1576,8 +1585,7 @@ static void __exit exit_nfsd(void)
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
 	nfsd_drc_slab_free();
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
+	destroy_proc_exports_entry();
 	nfsd_stat_shutdown();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
-- 
2.25.1

