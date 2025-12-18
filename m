Return-Path: <linux-nfs+bounces-17171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB60CCA661
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EDDC301CC6A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C2313E34;
	Thu, 18 Dec 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGrVxKm5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761931CA68
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037502; cv=none; b=jneJNjF9OPOyXHvqpnOWNwyNDxhH43jz4vKXyKcXwcR0FdOqnHxbrJhen+eds+If0+L+KXtmPUypiWp/nLanVbhdo0WdwRy2nAjvtMqZvFaGsg/eVTwvqMk2XJlQz36Z90/LA2tgVSHl3XEdVCir5xIW/RJxB23szRTL+XIVB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037502; c=relaxed/simple;
	bh=pmHACeUW5mI/Ph/pQC8uuIt3hO7w7fT0E/w5fig+8GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQPDroYP9FiHxubLRG7pKRfMTrj0QOKJfWX5YNlrwX720Wd3oJO0mOjtoYIZMe1m1goD4V5onDxVbwi0sTLn2MzLbWdRqxKcX8ceXyN+ivGy1thnbdhaJ+mHFQZnnHSnji9OLTu18UNfztgoUcfkMOUqNtNcXwctwPfa/gxh8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BGrVxKm5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hOSiM0iYaDdQm1ILotUSzUHpvSincPRgtl7nUDnlYag=; b=BGrVxKm5fVwHbwB7Y36qMuuokb
	MEeR24Pl1My2et9+WJSuAA/Nh4Ymg27pB1wp3ji2/arvhTdPE0iKKapOghOmCvY7sPcBCT7gKIXiV
	69oo+uGxX5RDyKm9DRogo7sG779tVtsXApCDjZIoRZyxNBDjbq1eHY0YhecFOAD7r2k15dOjnV3Yb
	9RnpdlcjU5R6q/OzQIZpRUnhBfDdjpAtf3LrwXOSicix8iFU4AiUOS78nnQbFq+XTDYo0IXVJzF/Z
	1rrA3IFDW4gEfIAvtM+0Z0TUxKa9ki3sOXJw51OHsq7LcPkyAtbd4LktDuwfVbQMOeToDmYlk07mw
	W4UI8fAg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW71n-00000007rom-2pOo;
	Thu, 18 Dec 2025 05:58:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 23/24] NFS: return delegations from the end of a LRU when over the watermark
Date: Thu, 18 Dec 2025 06:56:27 +0100
Message-ID: <20251218055633.1532159-24-hch@lst.de>
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

Directly returning delegations on close when over the watermark is
rather suboptimal as these delegations are much more likely to be reused
than those that have been unused for a long time.  Switch to returning
unused delegations from a new LRU list when we are above the threshold and
there are reclaimable delegations instead.

Pass over referenced delegations during the first pass to give delegations
that aren't in active used by frequently used for stat() or similar another
chance to not be instantly reclaimed.  This scheme works the same as the
referenced flags in the VFS inode and dentry caches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/client.c           |  1 +
 fs/nfs/delegation.c       | 61 +++++++++++++++++++++++++++++++++++++--
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 65b3de91b441..62aece00f810 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1062,6 +1062,7 @@ struct nfs_server *nfs_alloc_server(void)
 	INIT_LIST_HEAD(&server->delegations);
 	spin_lock_init(&server->delegations_lock);
 	INIT_LIST_HEAD(&server->delegations_return);
+	INIT_LIST_HEAD(&server->delegations_lru);
 	INIT_LIST_HEAD(&server->layouts);
 	INIT_LIST_HEAD(&server->state_owners_lru);
 	INIT_LIST_HEAD(&server->ss_copies);
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 25f4bb598fd8..712cdb3381ad 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -657,6 +657,60 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 	return err;
 }
 
+static inline bool nfs_delegations_over_limit(struct nfs_server *server)
+{
+	return !list_empty_careful(&server->delegations_lru) &&
+		atomic_long_read(&server->nr_active_delegations) >
+		nfs_delegation_watermark;
+}
+
+static void nfs_delegations_return_from_lru(struct nfs_server *server)
+{
+	struct nfs_delegation *d, *n;
+	unsigned int pass = 0;
+	bool moved = false;
+
+retry:
+	spin_lock(&server->delegations_lock);
+	list_for_each_entry_safe(d, n, &server->delegations_lru, entry) {
+		if (!nfs_delegations_over_limit(server))
+			break;
+		if (pass == 0 && test_bit(NFS_DELEGATION_REFERENCED, &d->flags))
+			continue;
+		list_move_tail(&d->entry, &server->delegations_return);
+		moved = true;
+	}
+	spin_unlock(&server->delegations_lock);
+
+	/*
+	 * If we are still over the limit, try to reclaim referenced delegations
+	 * as well.
+	 */
+	if (pass == 0 && nfs_delegations_over_limit(server)) {
+		pass++;
+		goto retry;
+	}
+
+	if (moved) {
+		set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
+		nfs4_schedule_state_manager(server->nfs_client);
+	}
+}
+
+static void nfs_delegation_add_lru(struct nfs_server *server,
+		struct nfs_delegation *delegation)
+{
+	spin_lock(&server->delegations_lock);
+	if (list_empty(&delegation->entry)) {
+		list_add_tail(&delegation->entry, &server->delegations_lru);
+		refcount_inc(&delegation->refcount);
+	}
+	spin_unlock(&server->delegations_lock);
+
+	if (nfs_delegations_over_limit(server))
+		nfs_delegations_return_from_lru(server);
+}
+
 static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
 {
 	struct nfs_delegation *d;
@@ -822,6 +876,7 @@ void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
  */
 void nfs4_inode_return_delegation_on_close(struct inode *inode)
 {
+	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_delegation *delegation;
 	bool return_now = false;
 
@@ -829,9 +884,7 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 	if (!delegation)
 		return;
 
-	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags) ||
-	    atomic_long_read(&NFS_SERVER(inode)->nr_active_delegations) >=
-	    nfs_delegation_watermark) {
+	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
 		spin_lock(&delegation->lock);
 		if (delegation->inode &&
 		    list_empty(&NFS_I(inode)->open_files) &&
@@ -845,6 +898,8 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 	if (return_now) {
 		nfs_clear_verifier_delegated(inode);
 		nfs_end_delegation_return(inode, delegation, 0);
+	} else {
+		nfs_delegation_add_lru(server, delegation);
 	}
 	nfs_put_delegation(delegation);
 }
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index e377b8c7086e..bb13a294b69e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -261,6 +261,7 @@ struct nfs_server {
 	struct list_head	delegations;
 	spinlock_t		delegations_lock;
 	struct list_head	delegations_return;
+	struct list_head	delegations_lru;
 	atomic_long_t		nr_active_delegations;
 	unsigned int		delegation_hash_mask;
 	struct hlist_head	*delegation_hash_table;
-- 
2.47.3


