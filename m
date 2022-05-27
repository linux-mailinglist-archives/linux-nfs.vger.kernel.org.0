Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D444153594F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 08:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiE0G21 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 May 2022 02:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbiE0G20 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 May 2022 02:28:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097239BBB;
        Thu, 26 May 2022 23:28:24 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L8ZbX15V2zjX79;
        Fri, 27 May 2022 14:27:20 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:28:22 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:28:22 +0800
From:   keliu <liuke94@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] nfs: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 06:49:51 +0000
Message-ID: <20220527064951.2358639-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 fs/nfs/nfs4state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9e1c987c81e7..e4c311dc8b93 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -497,7 +497,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	sp = kzalloc(sizeof(*sp), gfp_flags);
 	if (!sp)
 		return NULL;
-	sp->so_seqid.owner_id = ida_simple_get(&server->openowner_id, 0, 0,
+	sp->so_seqid.owner_id = ida_alloc(&server->openowner_id,
 						gfp_flags);
 	if (sp->so_seqid.owner_id < 0) {
 		kfree(sp);
@@ -534,7 +534,7 @@ static void nfs4_free_state_owner(struct nfs4_state_owner *sp)
 {
 	nfs4_destroy_seqid_counter(&sp->so_seqid);
 	put_cred(sp->so_cred);
-	ida_simple_remove(&sp->so_server->openowner_id, sp->so_seqid.owner_id);
+	ida_free(&sp->so_server->openowner_id, sp->so_seqid.owner_id);
 	kfree(sp);
 }
 
@@ -877,8 +877,8 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
 	refcount_set(&lsp->ls_count, 1);
 	lsp->ls_state = state;
 	lsp->ls_owner = fl_owner;
-	lsp->ls_seqid.owner_id = ida_simple_get(&server->lockowner_id,
-						0, 0, GFP_KERNEL_ACCOUNT);
+	lsp->ls_seqid.owner_id = ida_alloc(&server->lockowner_id,
+						GFP_KERNEL_ACCOUNT);
 	if (lsp->ls_seqid.owner_id < 0)
 		goto out_free;
 	INIT_LIST_HEAD(&lsp->ls_locks);
@@ -890,7 +890,7 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
 
 void nfs4_free_lock_state(struct nfs_server *server, struct nfs4_lock_state *lsp)
 {
-	ida_simple_remove(&server->lockowner_id, lsp->ls_seqid.owner_id);
+	ida_free(&server->lockowner_id, lsp->ls_seqid.owner_id);
 	nfs4_destroy_seqid_counter(&lsp->ls_seqid);
 	kfree(lsp);
 }
-- 
2.25.1

