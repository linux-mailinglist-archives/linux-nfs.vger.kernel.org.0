Return-Path: <linux-nfs+bounces-17527-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB73CFC582
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321F73041A5B
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70527AC41;
	Wed,  7 Jan 2026 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JjOMECcM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2B230BCC
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770861; cv=none; b=cQp21b+u2fFO6t6yrHO+X780y3o5N6VcVBPk+TwjCmvLP+mJdAsceLKnL77iJC4XLIiEh+xK31iyDUvjf/LC/IQdHE51Oo4K0aq65PWgltMFX/kWmzIgoZtebg/vUK4X8WUBkAYZYwUBeSTGgwrnGsVSQXrcNaBhOeRSp1ALox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770861; c=relaxed/simple;
	bh=XKW7Njwx4ck2czFwcYNY0T/LSNyMqkKwlInzWyLAujw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVqSxrY3ZHB0Ua29pVbse8M4cvS+77yPg47B23V4rufwoB14OOr84p8VXwZY/KooLWoQbmYLlwfhcK7JPQKjAkbHYlZ8fMGULkwZCaB6Jj+QS8p3FzZAnhkEMBLoNh1RIJadEx0Tfu2nb4ROpwROCwSBxnj/fdsvSc45xkQyEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JjOMECcM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DpW0hH+iczYkbEUubbEf6TeFkw0vln8xHLjwg5wAOLA=; b=JjOMECcM8Hx0F0k/5iF42gbB65
	ANRK42eY+g1KhQgLptZu2ClCuY+ddF4PwMeY4S4J+4IwRow2AQ5ANUicflf9qKsWeQAn6368xJxem
	s/mAYlB/dSAEAFZxiNT46vi2ytpqk/ooGZGgxvvHULuLzhFHOXHTt4FjCFLYcXFxIdkED1uodNvPH
	5dzVCv9HzTVRipoUYPDtLP0F78u0LyqFa2sMlHRobS4k+12Pgyo7gT8Q2yZ9OqXtdFzCG+H3LDb1Z
	0rPjKzwYGxD+lM/e0jf4p/U1Kbm1AEBjEJ0MhZy/v68OhZ4yNzh1DPDsVWoDd759IiAsVg7Y+MxSA
	BccDv5jg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxD-0000000EHkY-3UU3;
	Wed, 07 Jan 2026 07:27:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 05/24] NFS: remove nfs_inode_detach_delegation
Date: Wed,  7 Jan 2026 08:26:56 +0100
Message-ID: <20260107072720.1744129-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107072720.1744129-1-hch@lst.de>
References: <20260107072720.1744129-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Fold it into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index b44e39a50499..cf01ebd3b3c5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -402,21 +402,6 @@ static struct nfs_delegation *nfs_detach_delegation(struct nfs_inode *nfsi,
 	return delegation;
 }
 
-static struct nfs_delegation *
-nfs_inode_detach_delegation(struct inode *inode)
-{
-	struct nfs_inode *nfsi = NFS_I(inode);
-	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs_delegation *delegation;
-
-	rcu_read_lock();
-	delegation = rcu_dereference(nfsi->delegation);
-	if (delegation != NULL)
-		delegation = nfs_detach_delegation(nfsi, delegation, server);
-	rcu_read_unlock();
-	return delegation;
-}
-
 static void
 nfs_update_delegation_cred(struct nfs_delegation *delegation,
 		const struct cred *cred)
@@ -769,15 +754,23 @@ int nfs_client_return_marked_delegations(struct nfs_client *clp)
  */
 void nfs_inode_evict_delegation(struct inode *inode)
 {
+	struct nfs_inode *nfsi = NFS_I(inode);
+	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_delegation *delegation;
 
-	delegation = nfs_inode_detach_delegation(inode);
-	if (delegation != NULL) {
-		set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
-		nfs_do_return_delegation(inode, delegation, 1);
-		nfs_free_delegation(NFS_SERVER(inode), delegation);
-	}
+	rcu_read_lock();
+	delegation = rcu_dereference(nfsi->delegation);
+	if (delegation)
+		delegation = nfs_detach_delegation(nfsi, delegation, server);
+	rcu_read_unlock();
+
+	if (!delegation)
+		return;
+
+	set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+	set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
+	nfs_do_return_delegation(inode, delegation, 1);
+	nfs_free_delegation(server, delegation);
 }
 
 /**
-- 
2.47.3


