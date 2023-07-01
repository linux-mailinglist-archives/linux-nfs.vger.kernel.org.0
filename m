Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539C7449AE
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jul 2023 16:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjGAO2V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Jul 2023 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGAO2U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Jul 2023 10:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028FA35AB
        for <linux-nfs@vger.kernel.org>; Sat,  1 Jul 2023 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688221653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+tQHl7gxK3L9Cbnt7W9cJgMMju2COJSpKe1uJww0C5I=;
        b=QO4v+cqug4P/2w8kkEHwcSD0XmV2CG6ycxCA1oplTYuR+Tm5qvR74pUHaj5frZ2N4km4Si
        Y3O6ee47fCCtf3xhkbXI2enhmP8/6ggL8azUaIKi+y2nJrwEr2xeqMsfxzWs9AbK2t7n2Z
        MjWx6zVQU9/uyjYg84Puo6IzdIElMME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-8OGqM6umMsGABTuSnkPQ-Q-1; Sat, 01 Jul 2023 10:27:31 -0400
X-MC-Unique: 8OGqM6umMsGABTuSnkPQ-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5248C80123E;
        Sat,  1 Jul 2023 14:27:31 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F08FC00049;
        Sat,  1 Jul 2023 14:27:30 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     Olga.Kornievskaia@netapp.com, linux-nfs@vger.kernel.org
Subject: [PATCH v4] NFSv4: Fix dropped lock for racing OPEN and delegation return
Date:   Sat,  1 Jul 2023 10:27:30 -0400
Message-Id: <374ab3fe691e938cda4e239748dcb6b743705a3f.1688221596.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commmit f5ea16137a3f ("NFSv4: Retry LOCK on OLD_STATEID during delegation
return") attempted to solve this problem by using nfs4's generic async error
handling, but introduced a regression where v4.0 lock recovery would hang.
The additional complexity introduced by overloading that error handling is
not necessary for this case.  This patch expects that commit to be
reverted.

The problem as originally explained in the above commit is:

    There's a small window where a LOCK sent during a delegation return can
    race with another OPEN on client, but the open stateid has not yet been
    updated.  In this case, the client doesn't handle the OLD_STATEID error
    from the server and will lose this lock, emitting:
    "NFS: nfs4_handle_delegation_recall_error: unhandled error -10024".

Fix this by using the old_stateid refresh helpers if the server replies
with OLD_STATEID.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6bb14f6cfbc0..30c564f053fd 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7180,8 +7180,15 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 		} else if (!nfs4_update_lock_stateid(lsp, &data->res.stateid))
 			goto out_restart;
 		break;
-	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_OLD_STATEID:
+		if (data->arg.new_lock_owner != 0) {
+			if (nfs4_refresh_open_old_stateid(&data->arg.open_stateid,
+					lsp->ls_state))
+				goto out_restart;
+		} else if (nfs4_refresh_lock_old_stateid(&data->arg.lock_stateid, lsp))
+			goto out_restart;
+		fallthrough;
+	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_STALE_STATEID:
 	case -NFS4ERR_EXPIRED:
 		if (data->arg.new_lock_owner != 0) {
-- 
2.40.1

