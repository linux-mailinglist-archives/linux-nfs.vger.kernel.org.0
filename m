Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38819B614
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgDAS7C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgDAS7C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:02 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41599206F5
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767541;
        bh=OmgAVK6bTWzuG2IQfmjq1oW6E74fa81T2HCJUHpmPpM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AExqx48NC9Oo/qSb8aHn459jCHk6NvwkaWxPiq7RHe1in43AGkKJOIr+uAuiOHtDo
         UPwGjtjgR2skm0ox37hZkFo6s4WQb1ZSoaSfkEnV3gGM2DU8FEin1DxONX5Nd0yIYS
         c1uA7OUHupwkzbbANplQw6F1MDn4T2jgHDSn7QV0=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/10] NFS: Fix races nfs_page_group_destroy() vs nfs_destroy_unlinked_subrequests()
Date:   Wed,  1 Apr 2020 14:56:44 -0400
Message-Id: <20200401185652.1904777-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401185652.1904777-2-trondmy@kernel.org>
References: <20200401185652.1904777-1-trondmy@kernel.org>
 <20200401185652.1904777-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When a subrequest is being detached from the subgroup, we want to
ensure that it is not holding the group lock, or in the process
of waiting for the group lock.

Fixes: 5b2b5187fa85 ("NFS: Fix nfs_page_group_destroy() and nfs_lock_and_join_requests() race cases")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c        | 67 +++++++++++++++++++++++++++-------------
 fs/nfs/write.c           | 10 ++++--
 include/linux/nfs_page.h |  2 ++
 3 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index be5e209399ea..0e3f0f241d83 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -133,47 +133,70 @@ nfs_async_iocounter_wait(struct rpc_task *task, struct nfs_lock_context *l_ctx)
 EXPORT_SYMBOL_GPL(nfs_async_iocounter_wait);
 
 /*
- * nfs_page_group_lock - lock the head of the page group
- * @req - request in group that is to be locked
+ * nfs_page_set_headlock - set the request PG_HEADLOCK
+ * @req: request that is to be locked
  *
- * this lock must be held when traversing or modifying the page
- * group list
+ * this lock must be held when modifying req->wb_head
  *
  * return 0 on success, < 0 on error
  */
 int
-nfs_page_group_lock(struct nfs_page *req)
+nfs_page_set_headlock(struct nfs_page *req)
 {
-	struct nfs_page *head = req->wb_head;
-
-	WARN_ON_ONCE(head != head->wb_head);
-
-	if (!test_and_set_bit(PG_HEADLOCK, &head->wb_flags))
+	if (!test_and_set_bit(PG_HEADLOCK, &req->wb_flags))
 		return 0;
 
-	set_bit(PG_CONTENDED1, &head->wb_flags);
+	set_bit(PG_CONTENDED1, &req->wb_flags);
 	smp_mb__after_atomic();
-	return wait_on_bit_lock(&head->wb_flags, PG_HEADLOCK,
+	return wait_on_bit_lock(&req->wb_flags, PG_HEADLOCK,
 				TASK_UNINTERRUPTIBLE);
 }
 
 /*
- * nfs_page_group_unlock - unlock the head of the page group
- * @req - request in group that is to be unlocked
+ * nfs_page_clear_headlock - clear the request PG_HEADLOCK
+ * @req: request that is to be locked
  */
 void
-nfs_page_group_unlock(struct nfs_page *req)
+nfs_page_clear_headlock(struct nfs_page *req)
 {
-	struct nfs_page *head = req->wb_head;
-
-	WARN_ON_ONCE(head != head->wb_head);
-
 	smp_mb__before_atomic();
-	clear_bit(PG_HEADLOCK, &head->wb_flags);
+	clear_bit(PG_HEADLOCK, &req->wb_flags);
 	smp_mb__after_atomic();
-	if (!test_bit(PG_CONTENDED1, &head->wb_flags))
+	if (!test_bit(PG_CONTENDED1, &req->wb_flags))
 		return;
-	wake_up_bit(&head->wb_flags, PG_HEADLOCK);
+	wake_up_bit(&req->wb_flags, PG_HEADLOCK);
+}
+
+/*
+ * nfs_page_group_lock - lock the head of the page group
+ * @req: request in group that is to be locked
+ *
+ * this lock must be held when traversing or modifying the page
+ * group list
+ *
+ * return 0 on success, < 0 on error
+ */
+int
+nfs_page_group_lock(struct nfs_page *req)
+{
+	int ret;
+
+	ret = nfs_page_set_headlock(req);
+	if (ret || req->wb_head == req)
+		return ret;
+	return nfs_page_set_headlock(req->wb_head);
+}
+
+/*
+ * nfs_page_group_unlock - unlock the head of the page group
+ * @req: request in group that is to be unlocked
+ */
+void
+nfs_page_group_unlock(struct nfs_page *req)
+{
+	if (req != req->wb_head)
+		nfs_page_clear_headlock(req->wb_head);
+	nfs_page_clear_headlock(req);
 }
 
 /*
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 626e99cbb50e..a6d7926b0653 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -428,22 +428,28 @@ nfs_destroy_unlinked_subrequests(struct nfs_page *destroy_list,
 		destroy_list = (subreq->wb_this_page == old_head) ?
 				   NULL : subreq->wb_this_page;
 
+		/* Note: lock subreq in order to change subreq->wb_head */
+		nfs_page_set_headlock(subreq);
 		WARN_ON_ONCE(old_head != subreq->wb_head);
 
 		/* make sure old group is not used */
 		subreq->wb_this_page = subreq;
+		subreq->wb_head = subreq;
 
 		clear_bit(PG_REMOVE, &subreq->wb_flags);
 
 		/* Note: races with nfs_page_group_destroy() */
 		if (!kref_read(&subreq->wb_kref)) {
 			/* Check if we raced with nfs_page_group_destroy() */
-			if (test_and_clear_bit(PG_TEARDOWN, &subreq->wb_flags))
+			if (test_and_clear_bit(PG_TEARDOWN, &subreq->wb_flags)) {
+				nfs_page_clear_headlock(subreq);
 				nfs_free_request(subreq);
+			} else
+				nfs_page_clear_headlock(subreq);
 			continue;
 		}
+		nfs_page_clear_headlock(subreq);
 
-		subreq->wb_head = subreq;
 		nfs_release_request(old_head);
 
 		if (test_and_clear_bit(PG_INODE_REF, &subreq->wb_flags)) {
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 0bbd587fac6a..7e9419d74b86 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -142,6 +142,8 @@ extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
+extern	int nfs_page_set_headlock(struct nfs_page *req);
+extern void nfs_page_clear_headlock(struct nfs_page *req);
 extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
 
 /*
-- 
2.25.1

