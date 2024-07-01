Return-Path: <linux-nfs+bounces-4463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3B91D76B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 07:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD60F1C22206
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 05:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591F2BB0D;
	Mon,  1 Jul 2024 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BtdKBb2p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E81A269
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811641; cv=none; b=mv3l350FrcjRdknilH0/2rxBzKZf4UVJo5gMajH8EktNnoAlKvVtjyrOphEpdHc8+wAEAGFW540NGktreHadaJHdsl8DAgal35gqtQmesFcK0kQ73CdWzgGZ12CHAqAHK4tNy+DzA+xOBmWlOGfqYcpnqNMowCYiaTe+14j8HnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811641; c=relaxed/simple;
	bh=88+rjcrvbMeSi9b31vAgx8Hsi1Kd2iT1R9F1vxdZrII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naFcKSXRzFg9X8XcbHTbDWEdJdRfYK3ZvCN06XFGmKhK8ZOShW/76ua8s8XR80T9lJIRB7NC9b1rJ26K/KRRBbeH33+fAauGV3q/fwVNAr0aHahISLJxLOnmt0YwVe+zOyXkRdR54y3HGLM10Obn3pNJrmNtcaa0ch5fn+zgvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BtdKBb2p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ePdmQtY4eWl2yvY+UTjNtD/3zbOZUaSCBqGobzuAXfI=; b=BtdKBb2pRXNWFumkJFkQEmXPcl
	fkkpZiMxWrDKVYMZWaUN43RasUGxKwtMk7nerDR61Dwpiqk9tz18iJUCqmlo3XvFzCHYpjkPhFSyE
	I7u3P7wGfGeU8YrCXJt9uUCe6twyB9HPnr9R/4sLqsT5Dl7T/hWrPJms/CJDuni94xB9IxwsdArjj
	l3MOsAUTpmuBlWOTLN9ldXWXVLci37oFauFThqGOAH2x3bqQ+XLz4eNSCYLEsIc39Q2nHRr7aTGaA
	GEhzkc91xoLaa3V+DXScphOz9mq2z1rf4IiMNOwnZKkXbwpAamvf0eHRsE5ujz9u2WtarV2FXUCjj
	az+pDMow==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9ZP-00000001kBX-0UvM;
	Mon, 01 Jul 2024 05:27:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] nfs: simplify nfs_folio_find_and_lock_request
Date: Mon,  1 Jul 2024 07:26:50 +0200
Message-ID: <20240701052707.1246254-4-hch@lst.de>
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

nfs_folio_find_and_lock_request and the nfs_page_group_lock_head helper
called by it spend quite some effort to deal with head vs subrequests.
But given that only the head request can be stashed in the folio private
data, non of that is required.

Fold the locking logic from nfs_page_group_lock_head into
nfs_folio_find_and_lock_request and simplify the result based on the
invariant that we always find the head request in the folio private data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/pagelist.c        | 19 -------------------
 fs/nfs/write.c           | 38 +++++++++++++++++++++-----------------
 include/linux/nfs_page.h |  1 -
 3 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 3b006bcbcc87a2..e48cc69a2361aa 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -187,25 +187,6 @@ nfs_async_iocounter_wait(struct rpc_task *task, struct nfs_lock_context *l_ctx)
 }
 EXPORT_SYMBOL_GPL(nfs_async_iocounter_wait);
 
-/*
- * nfs_page_lock_head_request - page lock the head of the page group
- * @req: any member of the page group
- */
-struct nfs_page *
-nfs_page_group_lock_head(struct nfs_page *req)
-{
-	struct nfs_page *head = req->wb_head;
-
-	while (!nfs_lock_request(head)) {
-		int ret = nfs_wait_on_request(head);
-		if (ret < 0)
-			return ERR_PTR(ret);
-	}
-	if (head != req)
-		kref_get(&head->wb_kref);
-	return head;
-}
-
 /*
  * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
  * @head: head request of page group, must be holding head lock
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 5410c18a006937..58e5b78ff436b9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -197,28 +197,32 @@ static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
 static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
-	struct nfs_page *req, *head;
+	struct nfs_page *head;
 	int ret;
 
-	for (;;) {
-		req = nfs_folio_find_head_request(folio);
-		if (!req)
-			return req;
-		head = nfs_page_group_lock_head(req);
-		if (head != req)
-			nfs_release_request(req);
-		if (IS_ERR(head))
-			return head;
-		ret = nfs_cancel_remove_inode(head, inode);
-		if (ret < 0) {
-			nfs_unlock_and_release_request(head);
+retry:
+	head = nfs_folio_find_head_request(folio);
+	if (!head)
+		return NULL;
+
+	while (!nfs_lock_request(head)) {
+		ret = nfs_wait_on_request(head);
+		if (ret < 0)
 			return ERR_PTR(ret);
-		}
-		/* Ensure that nobody removed the request before we locked it */
-		if (head == folio->private)
-			break;
+	}
+
+	/* Ensure that nobody removed the request before we locked it */
+	if (head != folio->private) {
 		nfs_unlock_and_release_request(head);
+		goto retry;
 	}
+
+	ret = nfs_cancel_remove_inode(head, inode);
+	if (ret < 0) {
+		nfs_unlock_and_release_request(head);
+		return ERR_PTR(ret);
+	}
+
 	return head;
 }
 
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 7bc31df457ea58..e799d93626f117 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -155,7 +155,6 @@ extern size_t nfs_generic_pg_test(struct nfs_pageio_descriptor *desc,
 extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
-extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
 extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
 extern void nfs_join_page_group(struct nfs_page *head,
 				struct nfs_commit_info *cinfo,
-- 
2.43.0


