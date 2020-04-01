Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7B19B619
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgDAS7F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732214AbgDAS7E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:04 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DDED2078C
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767543;
        bh=G5TppZMZ1J0KU+OS1FcXMVneLS8iJ6/A9gDPepe5kMw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dr1uQ5YEOvytHdw5uaMQiguXjz5rSbCPTgmhFNh1DXGFBFDqyJ4iuL3XZMPbpofRw
         ddnjzRiqBy4UDxMh1kua+52uAmShJrH85YXVOle+07qrVJDrCOSVxRNUaA1i/Mu+aM
         f1Rm7QrKG62s2MYctI6r8ZEfTKLFTbjzO08tJKKY=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/10] NFS: Clean up nfs_lock_and_join_requests()
Date:   Wed,  1 Apr 2020 14:56:49 -0400
Message-Id: <20200401185652.1904777-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401185652.1904777-7-trondmy@kernel.org>
References: <20200401185652.1904777-1-trondmy@kernel.org>
 <20200401185652.1904777-2-trondmy@kernel.org>
 <20200401185652.1904777-3-trondmy@kernel.org>
 <20200401185652.1904777-4-trondmy@kernel.org>
 <20200401185652.1904777-5-trondmy@kernel.org>
 <20200401185652.1904777-6-trondmy@kernel.org>
 <20200401185652.1904777-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Clean up nfs_lock_and_join_requests() to simplify the calculation
of the range covered by the page group, taking into account the
presence of mirrors.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c        | 74 ++++++++++++++++++++++++++++++++
 fs/nfs/write.c           | 91 +++++++++-------------------------------
 include/linux/nfs_page.h |  1 +
 3 files changed, 95 insertions(+), 71 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index f535a92403bf..261236157e33 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -130,6 +130,80 @@ nfs_async_iocounter_wait(struct rpc_task *task, struct nfs_lock_context *l_ctx)
 }
 EXPORT_SYMBOL_GPL(nfs_async_iocounter_wait);
 
+/*
+ * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
+ * @head: head request of page group, must be holding head lock
+ * @req: request that couldn't lock and needs to wait on the req bit lock
+ *
+ * This is a helper function for nfs_lock_and_join_requests
+ * returns 0 on success, < 0 on error.
+ */
+static void
+nfs_unroll_locks(struct nfs_page *head, struct nfs_page *req)
+{
+	struct nfs_page *tmp;
+
+	/* relinquish all the locks successfully grabbed this run */
+	for (tmp = head->wb_this_page ; tmp != req; tmp = tmp->wb_this_page) {
+		if (!kref_read(&tmp->wb_kref))
+			continue;
+		nfs_unlock_and_release_request(tmp);
+	}
+}
+
+/*
+ * nfs_page_group_lock_subreq -  try to lock a subrequest
+ * @head: head request of page group
+ * @subreq: request to lock
+ *
+ * This is a helper function for nfs_lock_and_join_requests which
+ * must be called with the head request and page group both locked.
+ * On error, it returns with the page group unlocked.
+ */
+static int
+nfs_page_group_lock_subreq(struct nfs_page *head, struct nfs_page *subreq)
+{
+	int ret;
+
+	if (!kref_get_unless_zero(&subreq->wb_kref))
+		return 0;
+	while (!nfs_lock_request(subreq)) {
+		nfs_page_group_unlock(head);
+		ret = nfs_wait_on_request(subreq);
+		if (!ret)
+			ret = nfs_page_group_lock(head);
+		if (ret < 0) {
+			nfs_unroll_locks(head, subreq);
+			nfs_release_request(subreq);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+/*
+ * nfs_page_group_lock_subrequests -  try to lock the subrequests
+ * @head: head request of page group
+ *
+ * This is a helper function for nfs_lock_and_join_requests which
+ * must be called with the head request and page group both locked.
+ * On error, it returns with the page group unlocked.
+ */
+int nfs_page_group_lock_subrequests(struct nfs_page *head)
+{
+	struct nfs_page *subreq;
+	int ret;
+
+	/* lock each request in the page group */
+	for (subreq = head->wb_this_page; subreq != head;
+			subreq = subreq->wb_this_page) {
+		ret = nfs_page_group_lock_subreq(head, subreq);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
 /*
  * nfs_page_set_headlock - set the request PG_HEADLOCK
  * @req: request that is to be locked
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index a6d7926b0653..832cf57ea442 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -379,34 +379,6 @@ static void nfs_end_page_writeback(struct nfs_page *req)
 		clear_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
 }
 
-/*
- * nfs_unroll_locks_and_wait -  unlock all newly locked reqs and wait on @req
- *
- * this is a helper function for nfs_lock_and_join_requests
- *
- * @inode - inode associated with request page group, must be holding inode lock
- * @head  - head request of page group, must be holding head lock
- * @req   - request that couldn't lock and needs to wait on the req bit lock
- *
- * NOTE: this must be called holding page_group bit lock
- *       which will be released before returning.
- *
- * returns 0 on success, < 0 on error.
- */
-static void
-nfs_unroll_locks(struct inode *inode, struct nfs_page *head,
-			  struct nfs_page *req)
-{
-	struct nfs_page *tmp;
-
-	/* relinquish all the locks successfully grabbed this run */
-	for (tmp = head->wb_this_page ; tmp != req; tmp = tmp->wb_this_page) {
-		if (!kref_read(&tmp->wb_kref))
-			continue;
-		nfs_unlock_and_release_request(tmp);
-	}
-}
-
 /*
  * nfs_destroy_unlinked_subrequests - destroy recently unlinked subrequests
  *
@@ -487,7 +459,7 @@ nfs_lock_and_join_requests(struct page *page)
 	struct inode *inode = page_file_mapping(page)->host;
 	struct nfs_page *head, *subreq;
 	struct nfs_page *destroy_list = NULL;
-	unsigned int total_bytes;
+	unsigned int pgbase, off, bytes;
 	int ret;
 
 try_again:
@@ -520,49 +492,30 @@ nfs_lock_and_join_requests(struct page *page)
 		goto release_request;
 
 	/* lock each request in the page group */
-	total_bytes = head->wb_bytes;
+	ret = nfs_page_group_lock_subrequests(head);
+	if (ret < 0)
+		goto release_request;
+
+	pgbase = head->wb_pgbase;
+	bytes = head->wb_bytes;
+	off = head->wb_offset;
 	for (subreq = head->wb_this_page; subreq != head;
 			subreq = subreq->wb_this_page) {
-
-		if (!kref_get_unless_zero(&subreq->wb_kref)) {
-			if (subreq->wb_offset == head->wb_offset + total_bytes)
-				total_bytes += subreq->wb_bytes;
-			continue;
-		}
-
-		while (!nfs_lock_request(subreq)) {
-			/*
-			 * Unlock page to allow nfs_page_group_sync_on_bit()
-			 * to succeed
-			 */
-			nfs_page_group_unlock(head);
-			ret = nfs_wait_on_request(subreq);
-			if (!ret)
-				ret = nfs_page_group_lock(head);
-			if (ret < 0) {
-				nfs_unroll_locks(inode, head, subreq);
-				nfs_release_request(subreq);
-				goto release_request;
-			}
-		}
-		/*
-		 * Subrequests are always contiguous, non overlapping
-		 * and in order - but may be repeated (mirrored writes).
-		 */
-		if (subreq->wb_offset == (head->wb_offset + total_bytes)) {
-			/* keep track of how many bytes this group covers */
-			total_bytes += subreq->wb_bytes;
-		} else if (WARN_ON_ONCE(subreq->wb_offset < head->wb_offset ||
-			    ((subreq->wb_offset + subreq->wb_bytes) >
-			     (head->wb_offset + total_bytes)))) {
-			nfs_page_group_unlock(head);
-			nfs_unroll_locks(inode, head, subreq);
-			nfs_unlock_and_release_request(subreq);
-			ret = -EIO;
-			goto release_request;
+		/* Subrequests should always form a contiguous range */
+		if (pgbase > subreq->wb_pgbase) {
+			off -= pgbase - subreq->wb_pgbase;
+			bytes += pgbase - subreq->wb_pgbase;
+			pgbase = subreq->wb_pgbase;
 		}
+		bytes = max(subreq->wb_pgbase + subreq->wb_bytes
+				- pgbase, bytes);
 	}
 
+	/* Set the head request's range to cover the former page group */
+	head->wb_pgbase = pgbase;
+	head->wb_bytes = bytes;
+	head->wb_offset = off;
+
 	/* Now that all requests are locked, make sure they aren't on any list.
 	 * Commit list removal accounting is done after locks are dropped */
 	subreq = head;
@@ -576,10 +529,6 @@ nfs_lock_and_join_requests(struct page *page)
 		/* destroy list will be terminated by head */
 		destroy_list = head->wb_this_page;
 		head->wb_this_page = head;
-
-		/* change head request to cover whole range that
-		 * the former page group covered */
-		head->wb_bytes = total_bytes;
 	}
 
 	/* Postpone destruction of this request */
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 7e9419d74b86..dd205bc6bc58 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -139,6 +139,7 @@ extern size_t nfs_generic_pg_test(struct nfs_pageio_descriptor *desc,
 extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
+extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
-- 
2.25.1

