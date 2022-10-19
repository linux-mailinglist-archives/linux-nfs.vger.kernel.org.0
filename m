Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92759604CE6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJSQQu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJSQQt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 12:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97A918DA81
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666196208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ipavkRcmAY4dsPPX2PzRlgxbL2U3zURvA0A2b+szTqA=;
        b=VmS4wwKSUd62RrE4SqWFlydbtAlEXUYtt13EuDiALHaHOGDshwCRQtiqp2eTwGlp9SreD2
        pP0ghSH/fRVU7OBgawfX7WauhLHP1L9UZPVpGt42RaAU5jk+6q0nu6valpma5yo3K0Kaja
        wp5XbyP71oouz+H3WX4ZuZACgM10msY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-Lg5uMOqSMa-c8iAe32k98Q-1; Wed, 19 Oct 2022 12:16:45 -0400
X-MC-Unique: Lg5uMOqSMa-c8iAe32k98Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B66F03C10688;
        Wed, 19 Oct 2022 16:16:44 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87293C15BA5;
        Wed, 19 Oct 2022 16:16:44 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 1DCEE10C30F7; Wed, 19 Oct 2022 12:09:19 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, gsierohu@redhat.com
Subject: [PATCH] NFSv4: Retry LOCK on OLD_STATEID during delegation return
Date:   Wed, 19 Oct 2022 12:09:18 -0400
Message-Id: <76ffff8ae1b40821e404b7c3abd07a56e20e4f16.1666195626.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There's a small window where a LOCK sent during a delegation return can
race with another OPEN on client, but the open stateid has not yet been
updated.  In this case, the client doesn't handle the OLD_STATEID error
from the server and will lose this lock, emitting:
"NFS: nfs4_handle_delegation_recall_error: unhandled error -10024".

Fix this by sending the task through the nfs4 error handling in
nfs4_lock_done() when we may have to reconcile our stateid with what the
server believes it to be.  For this case, the result is a retry of the
LOCK operation with the updated stateid.

Reported-by: Gonzalo Siero Humet <gsierohu@redhat.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4553803538e5..f2ae36cfda40 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7138,6 +7138,7 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_lockdata *data = calldata;
 	struct nfs4_lock_state *lsp = data->lsp;
+	struct nfs_server *server = NFS_SERVER(d_inode(data->ctx->dentry));
 
 	if (!nfs4_sequence_done(task, &data->res.seq_res))
 		return;
@@ -7145,8 +7146,7 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 	data->rpc_status = task->tk_status;
 	switch (task->tk_status) {
 	case 0:
-		renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
-				data->timestamp);
+		renew_lease(server, data->timestamp);
 		if (data->arg.new_lock && !data->cancelled) {
 			data->fl.fl_flags &= ~(FL_SLEEP | FL_ACCESS);
 			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0)
@@ -7167,6 +7167,8 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 			if (!nfs4_stateid_match(&data->arg.open_stateid,
 						&lsp->ls_state->open_stateid))
 				goto out_restart;
+			else if (nfs4_async_handle_error(task, server, lsp->ls_state, NULL) == -EAGAIN)
+				goto out_restart;
 		} else if (!nfs4_stateid_match(&data->arg.lock_stateid,
 						&lsp->ls_stateid))
 				goto out_restart;
-- 
2.31.1

