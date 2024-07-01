Return-Path: <linux-nfs+bounces-4464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF291D76C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 07:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465691F228A8
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 05:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4E52BB0D;
	Mon,  1 Jul 2024 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RT2cqM14"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937511A269
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811643; cv=none; b=SKpOW3ZclPi2VjsvRpo+zhIwL7SHd/zXuDu9eVgETJfa04L08jhxba4n8uzU6XTeQnu8pEUKdiMrna0i+AEHLAEEu/csEipo8J1ckexRnnfHcl8s2YWp3432vfLnsCJdFKHUv0QQ7lDAGAmhe1XufzoN0ADhuGQNFxbquXNsW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811643; c=relaxed/simple;
	bh=2JVjBiQEl8kesG8/hIX5GZ0ad8D3N5FAQRLxRcBu/gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGFMo9tA6WbM6myyy6VWJ7QIfZD1sDJIluDzkcnfATj63qnTEs5ag5qwqlQcVYGNT6VCnRYlgXmVr069G1Ai3Z+i3aI2J1m4311gjr+tJ08g3XLnUxaAr422xYEtEz/mnbaJ/LIIZA4azbu5SMNeiD0RyfilG6AASRNQP8iKnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RT2cqM14; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=omnIiNy8Dii4B5oTyQv5WO7JU8qbKav8sdr0aVz78wI=; b=RT2cqM14PGw0K2nFDQYH3g9xwE
	b375ORMmmI3dleB/wE6AlRXEIzCM65vTFl3MSLw6OYS3mo7+zSTD+BOJ5FAS5D1CJcpNUP2gFRuN4
	d3M1iQoqBPQa3kSNHp1IOKL564mXYeJUtIM4SKlglhaF3ERsDUwpwAwSkkubwREK5PItHILrHLalw
	PtT0Gg3kYOloJxJfGXP+MMa7BSa0f2WSq37WCXGVANYNb1VIAVu+SQiuSYiowxFEiAx3t5Rj6Xc5p
	nxG7sMr7CvbCeEAY0WuL2v75WJtI4hmm675CZmXkUEEEEOxpHCmqO5eObIGW+fCJs+613ljqI+WCt
	pJxJt+jw==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9ZR-00000001kCD-2y4L;
	Mon, 01 Jul 2024 05:27:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 4/7] nfs: fold nfs_folio_find_and_lock_request into nfs_lock_and_join_requests
Date: Mon,  1 Jul 2024 07:26:51 +0200
Message-ID: <20240701052707.1246254-5-hch@lst.de>
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

Fold nfs_folio_find_and_lock_request into the only caller to prepare
for changes to this code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 68 ++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 58e5b78ff436b9..2b139493168d87 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -194,38 +194,6 @@ static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
 	return req;
 }
 
-static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
-{
-	struct inode *inode = folio->mapping->host;
-	struct nfs_page *head;
-	int ret;
-
-retry:
-	head = nfs_folio_find_head_request(folio);
-	if (!head)
-		return NULL;
-
-	while (!nfs_lock_request(head)) {
-		ret = nfs_wait_on_request(head);
-		if (ret < 0)
-			return ERR_PTR(ret);
-	}
-
-	/* Ensure that nobody removed the request before we locked it */
-	if (head != folio->private) {
-		nfs_unlock_and_release_request(head);
-		goto retry;
-	}
-
-	ret = nfs_cancel_remove_inode(head, inode);
-	if (ret < 0) {
-		nfs_unlock_and_release_request(head);
-		return ERR_PTR(ret);
-	}
-
-	return head;
-}
-
 /* Adjust the file length if we're writing beyond the end */
 static void nfs_grow_file(struct folio *folio, unsigned int offset,
 			  unsigned int count)
@@ -530,26 +498,44 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 	struct nfs_commit_info cinfo;
 	int ret;
 
-	nfs_init_cinfo_from_inode(&cinfo, inode);
 	/*
 	 * A reference is taken only on the head request which acts as a
 	 * reference to the whole page group - the group will not be destroyed
 	 * until the head reference is released.
 	 */
-	head = nfs_folio_find_and_lock_request(folio);
-	if (IS_ERR_OR_NULL(head))
-		return head;
+retry:
+	head = nfs_folio_find_head_request(folio);
+	if (!head)
+		return NULL;
 
-	/* lock each request in the page group */
-	ret = nfs_page_group_lock_subrequests(head);
-	if (ret < 0) {
+	while (!nfs_lock_request(head)) {
+		ret = nfs_wait_on_request(head);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+
+	/* Ensure that nobody removed the request before we locked it */
+	if (head != folio->private) {
 		nfs_unlock_and_release_request(head);
-		return ERR_PTR(ret);
+		goto retry;
 	}
 
-	nfs_join_page_group(head, &cinfo, inode);
+	ret = nfs_cancel_remove_inode(head, inode);
+	if (ret < 0)
+		goto out_unlock;
 
+	/* lock each request in the page group */
+	ret = nfs_page_group_lock_subrequests(head);
+	if (ret < 0)
+		goto out_unlock;
+
+	nfs_init_cinfo_from_inode(&cinfo, inode);
+	nfs_join_page_group(head, &cinfo, inode);
 	return head;
+
+out_unlock:
+	nfs_unlock_and_release_request(head);
+	return ERR_PTR(ret);
 }
 
 static void nfs_write_error(struct nfs_page *req, int error)
-- 
2.43.0


