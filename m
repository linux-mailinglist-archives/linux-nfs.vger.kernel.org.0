Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3875154C1DC
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 08:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353478AbiFOGaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 02:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiFOGaB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 02:30:01 -0400
X-Greylist: delayed 128 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 23:30:00 PDT
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EAA3A5E9
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jun 2022 23:30:00 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id JCQ00149;
        Wed, 15 Jun 2022 14:27:49 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2308.27; Wed, 15 Jun 2022 14:27:48 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] NFSv4: Directly use ida_alloc()/free()
Date:   Wed, 15 Jun 2022 02:27:45 -0400
Message-ID: <20220615062745.2752-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022615142749efc7e55c7c8b159e3943ff0ba03ca600
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use ida_alloc()/ida_free() instead of
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/nfs/nfs4state.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 2540b35ec187..8f018d4d35d7 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -497,8 +497,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	sp = kzalloc(sizeof(*sp), gfp_flags);
 	if (!sp)
 		return NULL;
-	sp->so_seqid.owner_id = ida_simple_get(&server->openowner_id, 0, 0,
-						gfp_flags);
+	sp->so_seqid.owner_id = ida_alloc(&server->openowner_id, gfp_flags);
 	if (sp->so_seqid.owner_id < 0) {
 		kfree(sp);
 		return NULL;
@@ -534,7 +533,7 @@ static void nfs4_free_state_owner(struct nfs4_state_owner *sp)
 {
 	nfs4_destroy_seqid_counter(&sp->so_seqid);
 	put_cred(sp->so_cred);
-	ida_simple_remove(&sp->so_server->openowner_id, sp->so_seqid.owner_id);
+	ida_free(&sp->so_server->openowner_id, sp->so_seqid.owner_id);
 	kfree(sp);
 }
 
@@ -877,8 +876,7 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
 	refcount_set(&lsp->ls_count, 1);
 	lsp->ls_state = state;
 	lsp->ls_owner = fl_owner;
-	lsp->ls_seqid.owner_id = ida_simple_get(&server->lockowner_id,
-						0, 0, GFP_KERNEL_ACCOUNT);
+	lsp->ls_seqid.owner_id = ida_alloc(&server->lockowner_id, GFP_KERNEL_ACCOUNT);
 	if (lsp->ls_seqid.owner_id < 0)
 		goto out_free;
 	INIT_LIST_HEAD(&lsp->ls_locks);
@@ -890,7 +888,7 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
 
 void nfs4_free_lock_state(struct nfs_server *server, struct nfs4_lock_state *lsp)
 {
-	ida_simple_remove(&server->lockowner_id, lsp->ls_seqid.owner_id);
+	ida_free(&server->lockowner_id, lsp->ls_seqid.owner_id);
 	nfs4_destroy_seqid_counter(&lsp->ls_seqid);
 	kfree(lsp);
 }
-- 
2.27.0

