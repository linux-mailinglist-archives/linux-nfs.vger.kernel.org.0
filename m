Return-Path: <linux-nfs+bounces-4467-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76091D76E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487FA1C222B9
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 05:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206136AF5;
	Mon,  1 Jul 2024 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kXWylXVC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28B2B9BF
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811651; cv=none; b=emOzrzsI4ta7FhTK8d0a3kyjTNw8w+DCABI8Ws/2tV2z7/D7NB7Gi48z1f6IClPOC7cJZeFBldWcjEdUOdCl27kr9zkxVSDwJBygf7rYLAanX5AYH8LxkRtkRb70yK0mcxvVrbhlPS7zkBBcUDJ7pl8IG9nfKtBIa0d4zXUuBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811651; c=relaxed/simple;
	bh=oV7nQN1EifSU0v4cqgYVaJIKplNON3+wrxjETY0Br/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1eNZrN73Hp4E8g2rO1PDLqsqXLq3uBMxBJVazWDv6j71WvDBPpJf5aJ4TI7MvOhlvAZcFz0JqSZT2+vcBtnXqhhvLvI11piymKKihpmOQmCrzhyDPE0zVEoGNGoZZHH+3F0SEi8bmOyenXerRwxAq9HX8QRbS94h8K984P8Wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kXWylXVC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wDVlN7FW9pZgEBXB6oVrItHNSRXsXL5XBqOIsrcVOZA=; b=kXWylXVCIAVVExhpHvAPmUJTaK
	AiNtGJDQKxdKM7Hd84RX9XY6ODA8SuV8DqwoHjLyBgyD6mUHBgweUmoSvZXcUh1JdwLWUsu+0uN3T
	haKU5d7CSwQcFHc5kb1bB8ijFeCaG1BiT/spE5eT3SkTOO0DIaTY02yQjPozWxZfEjnUbMV8s1aJG
	6tPKjQdBTBUd/zxHr/hNlAcC/h1ndq+DJKljBjvXVWhqGqFdLFPEHz+Qtc/6oF5bbs6UBrT3PyZly
	nrMMVTk5HmZNg6E+ieun42IxSuyTjjQzNlDzfHrDm2xt8PeA6GRBiVdiDk5YVhggZWBLgYfbtvjg/
	pbpBqRFw==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9ZZ-00000001kDr-2JXW;
	Mon, 01 Jul 2024 05:27:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] nfs: don't reuse partially completed requests in nfs_lock_and_join_requests
Date: Mon,  1 Jul 2024 07:26:54 +0200
Message-ID: <20240701052707.1246254-8-hch@lst.de>
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

When NFS requests are split into sub-requests, nfs_inode_remove_request
calls nfs_page_group_sync_on_bit to set PG_REMOVE on this sub-request and
only completes the head requests once PG_REMOVE is set on all requests.
This means that when nfs_lock_and_join_requests sees a PG_REMOVE bit, I/O
on the request is in progress and has partially completed.   If such a
request is returned to nfs_try_to_update_request, it could be extended
with the newly dirtied region and I/O for the combined range will be
re-scheduled, leading to extra I/O.

Change the logic to instead restart the search for a request when any
PG_REMOVE bit is set, as the completion handler will remove the request
as soon as it can take the page group lock.  This not only avoid
extending the I/O but also does the right thing for the callers that
want to cancel or flush the request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/write.c | 49 ++++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2c089444303982..4dffdc5aadb2e2 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -144,31 +144,6 @@ static void nfs_io_completion_put(struct nfs_io_completion *ioc)
 		kref_put(&ioc->refcount, nfs_io_completion_release);
 }
 
-static void
-nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
-{
-	if (!test_and_set_bit(PG_INODE_REF, &req->wb_flags)) {
-		kref_get(&req->wb_kref);
-		atomic_long_inc(&NFS_I(inode)->nrequests);
-	}
-}
-
-static int
-nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
-{
-	int ret;
-
-	if (!test_bit(PG_REMOVE, &req->wb_flags))
-		return 0;
-	ret = nfs_page_group_lock(req);
-	if (ret)
-		return ret;
-	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
-		nfs_page_set_inode_ref(req, inode);
-	nfs_page_group_unlock(req);
-	return 0;
-}
-
 /**
  * nfs_folio_find_head_request - find head request associated with a folio
  * @folio: pointer to folio
@@ -564,6 +539,7 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct nfs_page *head, *subreq;
 	struct nfs_commit_info cinfo;
+	bool removed;
 	int ret;
 
 	/*
@@ -588,18 +564,18 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 		goto retry;
 	}
 
-	ret = nfs_cancel_remove_inode(head, inode);
-	if (ret < 0)
-		goto out_unlock;
-
 	ret = nfs_page_group_lock(head);
 	if (ret < 0)
 		goto out_unlock;
 
+	removed = test_bit(PG_REMOVE, &head->wb_flags);
+
 	/* lock each request in the page group */
 	for (subreq = head->wb_this_page;
 	     subreq != head;
 	     subreq = subreq->wb_this_page) {
+		if (test_bit(PG_REMOVE, &subreq->wb_flags))
+			removed = true;
 		ret = nfs_page_group_lock_subreq(head, subreq);
 		if (ret < 0)
 			goto out_unlock;
@@ -607,6 +583,21 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 
 	nfs_page_group_unlock(head);
 
+	/*
+	 * If PG_REMOVE is set on any request, I/O on that request has
+	 * completed, but some requests were still under I/O at the time
+	 * we locked the head request.
+	 *
+	 * In that case the above wait for all requests means that all I/O
+	 * has now finished, and we can restart from a clean slate.  Let the
+	 * old requests go away and start from scratch instead.
+	 */
+	if (removed) {
+		nfs_unroll_locks(head, head);
+		nfs_unlock_and_release_request(head);
+		goto retry;
+	}
+
 	nfs_init_cinfo_from_inode(&cinfo, inode);
 	nfs_join_page_group(head, &cinfo, inode);
 	return head;
-- 
2.43.0


