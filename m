Return-Path: <linux-nfs+bounces-17172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F143CCA664
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF1533020384
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51C931ED60;
	Thu, 18 Dec 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dpYlDtSX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA431D750
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037506; cv=none; b=tMHM0t3jbvdeFSU/rYy1WxC0w4KH/ird2mvbVLmT/6TwEbnk8AupQZ2WCdD3ua4gdwsQ62vOh809xQt16J6+EJyFUFky1VvtiC80OxKan90HxUkRZRHWDFOTWCiEC+Nf7re252TqSZBoaklp24zl1lV9LTkBUEiOKH9VlQXMDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037506; c=relaxed/simple;
	bh=OGvkAXYvMLKydPADVRVEVvenetH2EjhxMxazBZ6XGQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXCxMx+W4EZ4cX4Lie0rktZGLVUQUdqA9L9/yBQ0PI/ovP6/990tvbzdPu6btySFJ8hdw3ZUseseF+NtXQBneShS5qbYk/u8CJb0XoM2w2qXdyunABCDShFxdvtYAsFC6YOMU+khS4mSgxj84cR36ywNG9WEXd09rgzV0XQJv7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dpYlDtSX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4AoQJ7V0W/oNZP4bu+u8IjBQ5W5AWcXNDnnRF7NsgWc=; b=dpYlDtSXidynwFCNems63ZqQj/
	MzKfZQ6zOH/O4r75QcEeOxM2NAwOjZQSQRZ1NKFlh/b02UZkYZ+qcyAfopNZaZNA0tYy653J70xIc
	aZEmFChwvLI5oz3gO7+qB3BGrW068MVcLUxi2ofK+zK6lUwFzG5QXBEtZp45JmPn0np/NAw56ZkoC
	2d6lQUwPEl61JFlGZJLtRMdJ1238QJP/T3bjkiejkN3IKk8aQkAFVGArkO26HZgR1iEqG9jBJiI6p
	IiFZn6umZBzwUJD3oH45qy4w5lyqYNVTxfIqsPhRSTvm8B2KlQA9an/AoabldytlHU3zysydSwHao
	EfHpWYgQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW71s-00000007roy-1ar9;
	Thu, 18 Dec 2025 05:58:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 24/24] NFS: make nfs_mark_return_unreferenced_delegations less aggressive
Date: Thu, 18 Dec 2025 06:56:28 +0100
Message-ID: <20251218055633.1532159-25-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218055633.1532159-1-hch@lst.de>
References: <20251218055633.1532159-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently nfs_mark_return_unreferenced_delegations marks all open but
not referenced delegations (i.e., those were found by a previous pass)
as return on close, which means that we'll return them on close without
a way out.

Replace this with only iterating delegations that are on the LRU list,
and avoid delegations that are in use by an open files to avoid this.

Delegations that were never referenced while open still are be prime
candidates for return from the LRU if the number of delegations is over
the watermark, or otherwise will be returned by the next
nfs_mark_return_unreferenced_delegations pass after they are closed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 712cdb3381ad..776020bdf8f3 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1126,15 +1126,21 @@ void nfs_remove_bad_delegation(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
 
-static void nfs_mark_return_unreferenced_delegations(struct nfs_server *server)
+static bool nfs_mark_return_unreferenced_delegations(struct nfs_server *server)
 {
-	struct nfs_delegation *delegation;
+	struct nfs_delegation *d, *n;
+	bool marked = false;
 
-	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
-		if (test_and_clear_bit(NFS_DELEGATION_REFERENCED, &delegation->flags))
+	spin_lock(&server->delegations_lock);
+	list_for_each_entry_safe(d, n, &server->delegations_lru, entry) {
+		if (test_and_clear_bit(NFS_DELEGATION_REFERENCED, &d->flags))
 			continue;
-		nfs_mark_return_if_closed_delegation(server, delegation);
+		list_move_tail(&d->entry, &server->delegations_return);
+		marked = true;
 	}
+	spin_unlock(&server->delegations_lock);
+
+	return marked;
 }
 
 /**
@@ -1145,13 +1151,17 @@ static void nfs_mark_return_unreferenced_delegations(struct nfs_server *server)
 void nfs_expire_unreferenced_delegations(struct nfs_client *clp)
 {
 	struct nfs_server *server;
+	bool marked = false;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link)
-		nfs_mark_return_unreferenced_delegations(server);
+		marked |= nfs_mark_return_unreferenced_delegations(server);
 	rcu_read_unlock();
 
-	nfs_delegation_run_state_manager(clp);
+	if (marked) {
+		set_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state);
+		nfs4_schedule_state_manager(clp);
+	}
 }
 
 /**
-- 
2.47.3


