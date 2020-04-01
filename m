Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC49A19B61A
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgDAS7G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731541AbgDAS7F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:05 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A6320787
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767544;
        bh=MKetfRiAoJ6gMAtmHOaUq82VqNYGDdavL/eLNN/n6FM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=wunil7Ij9n1joMP5laoZharE66h7QMtaX64fIQ4+W1PJ3USDwBblXhPl6yh/wYKyv
         7zPc8m0bLLsXlADzwUhRy7k6ifydexXuHRN0Jq7WJLF+K2WWyKf8y/3LiClMmDGM4C
         OLmqnLJFJ50hEOVOsH4LzadZLUcAVG8WlW2/rY6k=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/10] NFS: Refactor nfs_lock_and_join_requests()
Date:   Wed,  1 Apr 2020 14:56:51 -0400
Message-Id: <20200401185652.1904777-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401185652.1904777-9-trondmy@kernel.org>
References: <20200401185652.1904777-1-trondmy@kernel.org>
 <20200401185652.1904777-2-trondmy@kernel.org>
 <20200401185652.1904777-3-trondmy@kernel.org>
 <20200401185652.1904777-4-trondmy@kernel.org>
 <20200401185652.1904777-5-trondmy@kernel.org>
 <20200401185652.1904777-6-trondmy@kernel.org>
 <20200401185652.1904777-7-trondmy@kernel.org>
 <20200401185652.1904777-8-trondmy@kernel.org>
 <20200401185652.1904777-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Refactor nfs_lock_and_join_requests() in order to separate out the
subrequest merging into its own function nfs_lock_and_join_group()
that can be used by O_DIRECT.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c        |  26 ++++++-
 fs/nfs/write.c           | 164 +++++++++++++++++++++++----------------
 include/linux/nfs_page.h |   1 +
 3 files changed, 123 insertions(+), 68 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index b9805d1dac75..f61f96603df7 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -130,6 +130,25 @@ nfs_async_iocounter_wait(struct rpc_task *task, struct nfs_lock_context *l_ctx)
 }
 EXPORT_SYMBOL_GPL(nfs_async_iocounter_wait);
 
+/*
+ * nfs_page_lock_head_request - page lock the head of the page group
+ * @req: any member of the page group
+ */
+struct nfs_page *
+nfs_page_group_lock_head(struct nfs_page *req)
+{
+	struct nfs_page *head = req->wb_head;
+
+	while (!nfs_lock_request(head)) {
+		int ret = nfs_wait_on_request(head);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+	if (head != req)
+		kref_get(&head->wb_kref);
+	return head;
+}
+
 /*
  * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
  * @head: head request of page group, must be holding head lock
@@ -186,14 +205,16 @@ nfs_page_group_lock_subreq(struct nfs_page *head, struct nfs_page *subreq)
  * @head: head request of page group
  *
  * This is a helper function for nfs_lock_and_join_requests which
- * must be called with the head request and page group both locked.
- * On error, it returns with the page group unlocked.
+ * must be called with the head request locked.
  */
 int nfs_page_group_lock_subrequests(struct nfs_page *head)
 {
 	struct nfs_page *subreq;
 	int ret;
 
+	ret = nfs_page_group_lock(head);
+	if (ret < 0)
+		return ret;
 	/* lock each request in the page group */
 	for (subreq = head->wb_this_page; subreq != head;
 			subreq = subreq->wb_this_page) {
@@ -201,6 +222,7 @@ int nfs_page_group_lock_subrequests(struct nfs_page *head)
 		if (ret < 0)
 			return ret;
 	}
+	nfs_page_group_unlock(head);
 	return 0;
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 832cf57ea442..63b64333c3ea 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -149,6 +149,31 @@ static void nfs_io_completion_put(struct nfs_io_completion *ioc)
 		kref_put(&ioc->refcount, nfs_io_completion_release);
 }
 
+static void
+nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
+{
+	if (!test_and_set_bit(PG_INODE_REF, &req->wb_flags)) {
+		kref_get(&req->wb_kref);
+		atomic_long_inc(&NFS_I(inode)->nrequests);
+	}
+}
+
+static int
+nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
+{
+	int ret;
+
+	if (!test_bit(PG_REMOVE, &req->wb_flags))
+		return 0;
+	ret = nfs_page_group_lock(req);
+	if (ret)
+		return ret;
+	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
+		nfs_page_set_inode_ref(req, inode);
+	nfs_page_group_unlock(req);
+	return 0;
+}
+
 static struct nfs_page *
 nfs_page_private_request(struct page *page)
 {
@@ -218,6 +243,36 @@ static struct nfs_page *nfs_page_find_head_request(struct page *page)
 	return req;
 }
 
+static struct nfs_page *nfs_find_and_lock_page_request(struct page *page)
+{
+	struct inode *inode = page_file_mapping(page)->host;
+	struct nfs_page *req, *head;
+	int ret;
+
+	for (;;) {
+		req = nfs_page_find_head_request(page);
+		if (!req)
+			return req;
+		head = nfs_page_group_lock_head(req);
+		if (head != req)
+			nfs_release_request(req);
+		if (IS_ERR(head))
+			return head;
+		ret = nfs_cancel_remove_inode(head, inode);
+		if (ret < 0) {
+			nfs_unlock_and_release_request(head);
+			return ERR_PTR(ret);
+		}
+		/* Ensure that nobody removed the request before we locked it */
+		if (head == nfs_page_private_request(page))
+			break;
+		if (PageSwapCache(page))
+			break;
+		nfs_unlock_and_release_request(head);
+	}
+	return head;
+}
+
 /* Adjust the file length if we're writing beyond the end */
 static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int count)
 {
@@ -436,65 +491,22 @@ nfs_destroy_unlinked_subrequests(struct nfs_page *destroy_list,
 }
 
 /*
- * nfs_lock_and_join_requests - join all subreqs to the head req and return
- *                              a locked reference, cancelling any pending
- *                              operations for this page.
- *
- * @page - the page used to lookup the "page group" of nfs_page structures
+ * nfs_join_page_group - destroy subrequests of the head req
+ * @head: the page used to lookup the "page group" of nfs_page structures
+ * @inode: Inode to which the request belongs.
  *
  * This function joins all sub requests to the head request by first
  * locking all requests in the group, cancelling any pending operations
  * and finally updating the head request to cover the whole range covered by
  * the (former) group.  All subrequests are removed from any write or commit
  * lists, unlinked from the group and destroyed.
- *
- * Returns a locked, referenced pointer to the head request - which after
- * this call is guaranteed to be the only request associated with the page.
- * Returns NULL if no requests are found for @page, or a ERR_PTR if an
- * error was encountered.
  */
-static struct nfs_page *
-nfs_lock_and_join_requests(struct page *page)
+static void
+nfs_join_page_group(struct nfs_page *head, struct inode *inode)
 {
-	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_page *head, *subreq;
+	struct nfs_page *subreq;
 	struct nfs_page *destroy_list = NULL;
 	unsigned int pgbase, off, bytes;
-	int ret;
-
-try_again:
-	/*
-	 * A reference is taken only on the head request which acts as a
-	 * reference to the whole page group - the group will not be destroyed
-	 * until the head reference is released.
-	 */
-	head = nfs_page_find_head_request(page);
-	if (!head)
-		return NULL;
-
-	/* lock the page head first in order to avoid an ABBA inefficiency */
-	if (!nfs_lock_request(head)) {
-		ret = nfs_wait_on_request(head);
-		nfs_release_request(head);
-		if (ret < 0)
-			return ERR_PTR(ret);
-		goto try_again;
-	}
-
-	/* Ensure that nobody removed the request before we locked it */
-	if (head != nfs_page_private_request(page) && !PageSwapCache(page)) {
-		nfs_unlock_and_release_request(head);
-		goto try_again;
-	}
-
-	ret = nfs_page_group_lock(head);
-	if (ret < 0)
-		goto release_request;
-
-	/* lock each request in the page group */
-	ret = nfs_page_group_lock_subrequests(head);
-	if (ret < 0)
-		goto release_request;
 
 	pgbase = head->wb_pgbase;
 	bytes = head->wb_bytes;
@@ -531,30 +543,50 @@ nfs_lock_and_join_requests(struct page *page)
 		head->wb_this_page = head;
 	}
 
-	/* Postpone destruction of this request */
-	if (test_and_clear_bit(PG_REMOVE, &head->wb_flags)) {
-		set_bit(PG_INODE_REF, &head->wb_flags);
-		kref_get(&head->wb_kref);
-		atomic_long_inc(&NFS_I(inode)->nrequests);
-	}
+	nfs_destroy_unlinked_subrequests(destroy_list, head, inode);
+}
 
-	nfs_page_group_unlock(head);
+/*
+ * nfs_lock_and_join_requests - join all subreqs to the head req
+ * @page: the page used to lookup the "page group" of nfs_page structures
+ *
+ * This function joins all sub requests to the head request by first
+ * locking all requests in the group, cancelling any pending operations
+ * and finally updating the head request to cover the whole range covered by
+ * the (former) group.  All subrequests are removed from any write or commit
+ * lists, unlinked from the group and destroyed.
+ *
+ * Returns a locked, referenced pointer to the head request - which after
+ * this call is guaranteed to be the only request associated with the page.
+ * Returns NULL if no requests are found for @page, or a ERR_PTR if an
+ * error was encountered.
+ */
+static struct nfs_page *
+nfs_lock_and_join_requests(struct page *page)
+{
+	struct inode *inode = page_file_mapping(page)->host;
+	struct nfs_page *head;
+	int ret;
 
-	nfs_destroy_unlinked_subrequests(destroy_list, head, inode);
+	/*
+	 * A reference is taken only on the head request which acts as a
+	 * reference to the whole page group - the group will not be destroyed
+	 * until the head reference is released.
+	 */
+	head = nfs_find_and_lock_page_request(page);
+	if (IS_ERR_OR_NULL(head))
+		return head;
 
-	/* Did we lose a race with nfs_inode_remove_request()? */
-	if (!(PagePrivate(page) || PageSwapCache(page))) {
+	/* lock each request in the page group */
+	ret = nfs_page_group_lock_subrequests(head);
+	if (ret < 0) {
 		nfs_unlock_and_release_request(head);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
-	/* still holds ref on head from nfs_page_find_head_request
-	 * and still has lock on head from lock loop */
-	return head;
+	nfs_join_page_group(head, inode);
 
-release_request:
-	nfs_unlock_and_release_request(head);
-	return ERR_PTR(ret);
+	return head;
 }
 
 static void nfs_write_error(struct nfs_page *req, int error)
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index dd205bc6bc58..99198c039bd6 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -139,6 +139,7 @@ extern size_t nfs_generic_pg_test(struct nfs_pageio_descriptor *desc,
 extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
+extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
 extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
-- 
2.25.1

