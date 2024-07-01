Return-Path: <linux-nfs+bounces-4465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E991D76D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 07:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BF1B2355D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 05:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65D2B9BF;
	Mon,  1 Jul 2024 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ASyBhfI9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E61A269
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811646; cv=none; b=OSuKjWKC8sXJdViXK3T4+32TarmWZQEJrVjO+k902wsgc6QgxvoqSkS20oLHt/vxaaFHPwBJZewBNhPAeKR2mKgB5z4nOk1jSkp/UZva9ijdGbXwqr7mIwHqhXddudLffRm97u36OG/Ghj1ruzHfKvrdkhbaQSoVfJW3tOicJp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811646; c=relaxed/simple;
	bh=cB667PGDBjImW6X9VY7SO0kyFIiVYwdkNaKiI7Vm2tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M68oiK6Wole3CGgiLe4iHsEL/X9+69Ff9AXJHFsgGl/qYHZdcqGqLR214sVemxZ+vQHrT3IiMMuI9ZHTh8D4DTsuOdngFF9NIiDTcCb5LtR/erJd4jal8Dh0QzmleHWLtdfrXXkHpVOOslE8y3EGFPOO+ahR53LUBX0PtAwSXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ASyBhfI9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fGaAMMBhnoMsV4dOqN+0giAG380R4reTMPBJd3NyI/8=; b=ASyBhfI9Hbz+RzIuJtkBzQRtXu
	SOHoWK18euCiBBi8oo5JKDJBHMZhxF0q3nAcnpKqu9GnAzVwaNDEXyf1BlS08HyhvtNy+hruqEjUp
	2iv2u5qh3dksy1Pi/L8lx4nhpc25Ik3en56bs1zqLXxWAVqUdjcynJx/oXOzioWOTTQIRswZPjdhU
	6Dx7OTBzNxIx2HTbJddYXoPms4PBIkEvJkXJLSWMAy6n6Xj2dJF3v0j87Jig3gGGVb7JEOc+8/VAG
	mlXW1mNJwvhxbatF8mSl7nj8cUm6+MXz7ydFIvM9H8rFCbcDpLsA8ciq3mwYELucw7r0iBuRkFhl+
	cTjHTnZA==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9ZU-00000001kCs-0h3c;
	Mon, 01 Jul 2024 05:27:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 5/7] nfs: fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests
Date: Mon,  1 Jul 2024 07:26:52 +0200
Message-ID: <20240701052707.1246254-6-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701052707.1246254-1-hch@lst.de>
References: <20240701052707.1246254-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests to
prepare for future changes to this code, and move the helpers to write.c
as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/pagelist.c        | 77 ----------------------------------------
 fs/nfs/write.c           | 67 ++++++++++++++++++++++++++++++++--
 include/linux/nfs_page.h |  1 -
 3 files changed, 64 insertions(+), 81 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index e48cc69a2361aa..fa7971072900b3 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -187,83 +187,6 @@ nfs_async_iocounter_wait(struct rpc_task *task, struct nfs_lock_context *l_ctx)
 }
 EXPORT_SYMBOL_GPL(nfs_async_iocounter_wait);
 
-/*
- * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
- * @head: head request of page group, must be holding head lock
- * @req: request that couldn't lock and needs to wait on the req bit lock
- *
- * This is a helper function for nfs_lock_and_join_requests
- * returns 0 on success, < 0 on error.
- */
-static void
-nfs_unroll_locks(struct nfs_page *head, struct nfs_page *req)
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
-/*
- * nfs_page_group_lock_subreq -  try to lock a subrequest
- * @head: head request of page group
- * @subreq: request to lock
- *
- * This is a helper function for nfs_lock_and_join_requests which
- * must be called with the head request and page group both locked.
- * On error, it returns with the page group unlocked.
- */
-static int
-nfs_page_group_lock_subreq(struct nfs_page *head, struct nfs_page *subreq)
-{
-	int ret;
-
-	if (!kref_get_unless_zero(&subreq->wb_kref))
-		return 0;
-	while (!nfs_lock_request(subreq)) {
-		nfs_page_group_unlock(head);
-		ret = nfs_wait_on_request(subreq);
-		if (!ret)
-			ret = nfs_page_group_lock(head);
-		if (ret < 0) {
-			nfs_unroll_locks(head, subreq);
-			nfs_release_request(subreq);
-			return ret;
-		}
-	}
-	return 0;
-}
-
-/*
- * nfs_page_group_lock_subrequests -  try to lock the subrequests
- * @head: head request of page group
- *
- * This is a helper function for nfs_lock_and_join_requests which
- * must be called with the head request locked.
- */
-int nfs_page_group_lock_subrequests(struct nfs_page *head)
-{
-	struct nfs_page *subreq;
-	int ret;
-
-	ret = nfs_page_group_lock(head);
-	if (ret < 0)
-		return ret;
-	/* lock each request in the page group */
-	for (subreq = head->wb_this_page; subreq != head;
-			subreq = subreq->wb_this_page) {
-		ret = nfs_page_group_lock_subreq(head, subreq);
-		if (ret < 0)
-			return ret;
-	}
-	nfs_page_group_unlock(head);
-	return 0;
-}
-
 /*
  * nfs_page_set_headlock - set the request PG_HEADLOCK
  * @req: request that is to be locked
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2b139493168d87..3ba298ebb0be14 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -476,6 +476,57 @@ void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
 	nfs_destroy_unlinked_subrequests(destroy_list, head, inode);
 }
 
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
 /*
  * nfs_lock_and_join_requests - join all subreqs to the head req
  * @folio: the folio used to lookup the "page group" of nfs_page structures
@@ -494,7 +545,7 @@ void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
 static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
-	struct nfs_page *head;
+	struct nfs_page *head, *subreq;
 	struct nfs_commit_info cinfo;
 	int ret;
 
@@ -524,11 +575,21 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 	if (ret < 0)
 		goto out_unlock;
 
-	/* lock each request in the page group */
-	ret = nfs_page_group_lock_subrequests(head);
+	ret = nfs_page_group_lock(head);
 	if (ret < 0)
 		goto out_unlock;
 
+	/* lock each request in the page group */
+	for (subreq = head->wb_this_page;
+	     subreq != head;
+	     subreq = subreq->wb_this_page) {
+		ret = nfs_page_group_lock_subreq(head, subreq);
+		if (ret < 0)
+			goto out_unlock;
+	}
+
+	nfs_page_group_unlock(head);
+
 	nfs_init_cinfo_from_inode(&cinfo, inode);
 	nfs_join_page_group(head, &cinfo, inode);
 	return head;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index e799d93626f117..63eed97a18ade9 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -155,7 +155,6 @@ extern size_t nfs_generic_pg_test(struct nfs_pageio_descriptor *desc,
 extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
-extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
 extern void nfs_join_page_group(struct nfs_page *head,
 				struct nfs_commit_info *cinfo,
 				struct inode *inode);
-- 
2.43.0


