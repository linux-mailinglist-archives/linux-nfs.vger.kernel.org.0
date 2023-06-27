Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1103B740370
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jun 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjF0SeG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Jun 2023 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjF0Sdz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Jun 2023 14:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC662358A
        for <linux-nfs@vger.kernel.org>; Tue, 27 Jun 2023 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687890714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0EZWm8l8JyZ8/z4mgpRO80wwIsHmr8ARu+FRb8E5pRU=;
        b=CXHjhzOsWOkwKwLiFf7pTEHBao5ilo+a44BnUsszXMMYEQAzIseP1cDuUUvBwnME+KZwN7
        48mFmFbEw8Pmyr5Wyj5Ej4t6SInDEOer+rOHyKW6EiqoeAX4Ocu+NMEa9mbw8a/ezFqYgh
        y/KUsdkeA32ciyzpFl2r+/UV9J6btsw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-dNdI6C6ZPKS23QBr6O3u9w-1; Tue, 27 Jun 2023 14:31:52 -0400
X-MC-Unique: dNdI6C6ZPKS23QBr6O3u9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 031C23823A02;
        Tue, 27 Jun 2023 18:31:52 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 437C2200A3AD;
        Tue, 27 Jun 2023 18:31:51 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     Olga.Kornievskaia@netapp.com, linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] Revert "NFSv4: Retry LOCK on OLD_STATEID during delegation return"
Date:   Tue, 27 Jun 2023 14:31:49 -0400
Message-Id: <5577791deaa898578c8e8f86336eaca053d9efdd.1687890438.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga Kornievskaia reports that this patch breaks NFSv4.0 state recovery.
It also introduces additional complexity in the error paths for cases not
related to the original problem.  Let's revert it for now, and address the
original problem in another manner.

This reverts commit f5ea16137a3fa2858620dc9084466491c128535f.

Fixes: f5ea16137a3f ("NFSv4: Retry LOCK on OLD_STATEID during delegation return")
Reported-by: Kornievskaia, Olga <Olga.Kornievskaia@netapp.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d3665390c4cb..6bb14f6cfbc0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7159,7 +7159,6 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_lockdata *data = calldata;
 	struct nfs4_lock_state *lsp = data->lsp;
-	struct nfs_server *server = NFS_SERVER(d_inode(data->ctx->dentry));
 
 	if (!nfs4_sequence_done(task, &data->res.seq_res))
 		return;
@@ -7167,7 +7166,8 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 	data->rpc_status = task->tk_status;
 	switch (task->tk_status) {
 	case 0:
-		renew_lease(server, data->timestamp);
+		renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
+				data->timestamp);
 		if (data->arg.new_lock && !data->cancelled) {
 			data->fl.fl_flags &= ~(FL_SLEEP | FL_ACCESS);
 			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0)
@@ -7188,8 +7188,6 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 			if (!nfs4_stateid_match(&data->arg.open_stateid,
 						&lsp->ls_state->open_stateid))
 				goto out_restart;
-			else if (nfs4_async_handle_error(task, server, lsp->ls_state, NULL) == -EAGAIN)
-				goto out_restart;
 		} else if (!nfs4_stateid_match(&data->arg.lock_stateid,
 						&lsp->ls_stateid))
 				goto out_restart;
-- 
2.40.1

