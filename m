Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732BA150CB
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2019 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfEFP7H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 May 2019 11:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfEFP7H (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 May 2019 11:59:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 179AB81DF1;
        Mon,  6 May 2019 15:59:07 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-85.rdu2.redhat.com [10.10.122.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1F225DAB9;
        Mon,  6 May 2019 15:59:05 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 6917B20A0C; Mon,  6 May 2019 11:59:05 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4: don't mark all open state for recovery when handling recallable state revoked flag
Date:   Mon,  6 May 2019 11:59:05 -0400
Message-Id: <20190506155905.16152-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 06 May 2019 15:59:07 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Only delegations and layouts can be recalled, so it shouldn't be
necessary to recover all opens when handling the status bit
SEQ4_STATUS_RECALLABLE_STATE_REVOKED.  We'll still wind up calling
nfs41_open_expired() when a TEST_STATEID returns NFS4ERR_DELEG_REVOKED.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/delegation.c | 12 ++++++++++++
 fs/nfs/delegation.h |  1 +
 fs/nfs/nfs4state.c  |  3 +--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 2f6b447cdd82..8b78274e3e56 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1033,6 +1033,18 @@ void nfs_mark_test_expired_all_delegations(struct nfs_client *clp)
 	rcu_read_unlock();
 }
 
+/**
+ * nfs_test_expired_all_delegations - test all delegations for a client
+ * @clp: nfs_client to process
+ *
+ * Helper for handling "recallable state revoked" status from server.
+ */
+void nfs_test_expired_all_delegations(struct nfs_client *clp)
+{
+	nfs_mark_test_expired_all_delegations(clp);
+	nfs4_schedule_state_manager(clp);
+}
+
 /**
  * nfs_reap_expired_delegations - reap expired delegations
  * @clp: nfs_client to process
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 35b4b02c1ae0..5799777df5ec 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -58,6 +58,7 @@ void nfs_delegation_mark_reclaim(struct nfs_client *clp);
 void nfs_delegation_reap_unclaimed(struct nfs_client *clp);
 
 void nfs_mark_test_expired_all_delegations(struct nfs_client *clp);
+void nfs_test_expired_all_delegations(struct nfs_client *clp);
 void nfs_reap_expired_delegations(struct nfs_client *clp);
 
 /* NFSv4 delegation-related procedures */
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 3de36479ed7a..7d0ee5a2aef9 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2346,8 +2346,7 @@ static void nfs41_handle_recallable_state_revoked(struct nfs_client *clp)
 {
 	/* FIXME: For now, we destroy all layouts. */
 	pnfs_destroy_all_layouts(clp);
-	/* FIXME: For now, we test all delegations+open state+locks. */
-	nfs41_handle_some_state_revoked(clp);
+	nfs_test_expired_all_delegations(clp);
 	dprintk("%s: Recallable state revoked on server %s!\n", __func__,
 			clp->cl_hostname);
 }
-- 
2.17.2

