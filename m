Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1874036F
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jun 2023 20:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjF0SeF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Jun 2023 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjF0Sdx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Jun 2023 14:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045C358B
        for <linux-nfs@vger.kernel.org>; Tue, 27 Jun 2023 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687890715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZIwHKoZ2Q0MBCw+53Zg48a81zOE65M97HqJdLz39Sg=;
        b=UuAaIf33IEKxW0nrK09p/Yfv7Fap2+FmhkpxG5O2axX5YdjXqJchPrFx9DpoMA09HCE6hY
        yfRf3IzxNVXYghxMcnxz+qveWCuMxJtbMB7newFHT60kJWIbWT5NEFXMNG93SbBsYYv89J
        e3f5rRmTBvbwJ9x4wOLdsT0UgriUEmw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-G5UIng78OFWZawy30wS5Yg-1; Tue, 27 Jun 2023 14:31:53 -0400
X-MC-Unique: G5UIng78OFWZawy30wS5Yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACF458631DB;
        Tue, 27 Jun 2023 18:31:52 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2914F200BA86;
        Tue, 27 Jun 2023 18:31:52 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     Olga.Kornievskaia@netapp.com, linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Fix dropped lock for racing OPEN and delegation return
Date:   Tue, 27 Jun 2023 14:31:50 -0400
Message-Id: <01047e4baa85ca541a5a43f88f588b15163292dc.1687890438.git.bcodding@redhat.com>
In-Reply-To: <5577791deaa898578c8e8f86336eaca053d9efdd.1687890438.git.bcodding@redhat.com>
References: <5577791deaa898578c8e8f86336eaca053d9efdd.1687890438.git.bcodding@redhat.com>
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

Commmit f5ea16137a3f ("NFSv4: Retry LOCK on OLD_STATEID during delegation
return") attempted to solve this problem by using nfs4's generic async error
handling, but introduced a regression where v4.0 lock recovery would hang.
The additional complexity introduced by overloading that error handling is
not necessary for this case.

The problem as originally explained in the above commit is:

    There's a small window where a LOCK sent during a delegation return can
    race with another OPEN on client, but the open stateid has not yet been
    updated.  In this case, the client doesn't handle the OLD_STATEID error
    from the server and will lose this lock, emitting:
    "NFS: nfs4_handle_delegation_recall_error: unhandled error -10024".

We want a fix that is much more focused to the original problem.  Fix this
issue by returning -EAGAIN from the nfs4_handle_delegation_recall_error() on
OLD_STATEID, and use that as a signal for the delegation return code to
retry the LOCK operation.  We should at this point be able to send along
the updated stateid.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/delegation.c | 4 +++-
 fs/nfs/nfs4proc.c   | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cf7365581031..23aeb02319a5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -160,7 +160,9 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 		if (nfs_file_open_context(fl->fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
-		status = nfs4_lock_delegation_recall(fl, state, stateid);
+		do {
+			status = nfs4_lock_delegation_recall(fl, state, stateid);
+		} while (status == -EAGAIN);
 		if (status < 0)
 			goto out;
 		spin_lock(&flctx->flc_lock);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6bb14f6cfbc0..399db73a57f4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2262,6 +2262,7 @@ static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct
 		case -NFS4ERR_BAD_HIGH_SLOT:
 		case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
 		case -NFS4ERR_DEADSESSION:
+		case -NFS4ERR_OLD_STATEID:
 			return -EAGAIN;
 		case -NFS4ERR_STALE_CLIENTID:
 		case -NFS4ERR_STALE_STATEID:
-- 
2.40.1

