Return-Path: <linux-nfs+bounces-17538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB30CFC5B5
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A3530AAD0E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCA13AA2F;
	Wed,  7 Jan 2026 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UdnfVq7D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C71A9F9F
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770907; cv=none; b=fKUGfAapG/dN2PzYmRcQFEPkYDLGrFOX91MQ2Xc8eg9d+h4GwjRZzgKeDhPijQ8hmlEBNdQNQWZfC6/wwXRIOyaXjxmqnc7P4p79mnOkpePx2OfzL3h35mUtMCaoRmYeRT9HSC0uCcTMvkACfbGbB1toOHdA8aZoKyy8rIFhbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770907; c=relaxed/simple;
	bh=lD86xC0FVhIQzEDJZCGJH9lyHL5pKqwPP4KLUsGZ+Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHo8kq6S33rPM1E0Lb28+0v1aNbTQDg8z6CVMliDeYboDPOU/+OrQ4h2NwOA1kjZNWysr1OIlcEUhR6QivwaR2IJlVk+zootTNjTkacyz827Npzs+T+bCMix6eiFq2Luj6zE8ebYUIpGoAGonQdjulruM28qexZ6gU1UtBiCPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UdnfVq7D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=97RDJdsFx3pXS0tJj474K13BuECSQd8mDNi0uDkWbCM=; b=UdnfVq7DoVNwCTxQpHj0JR0fg6
	rPfbEfm3HEHlsw9/FFe3IGMURRDNYgR5ni16fWZQjIkXB/4sBBSx3i+NVz+4O7LBScCpb9Lm5GRIA
	f5E9uFxGg/YrsJF0z5chsPhOf0FUlOUZWwVmLKXlExbDbH0ul15jgtaJtHQ9mO3mAkHiUz7aPgoFt
	EuwF4b8C/g5CfpkebGUEQDDUtCUeImHcHjZHeXOA8R7+9MsYZrEhbs/BQ4dvWznAzgUM32N8xUOvx
	vUWfefVuF61zynVmMlT0iCVVegbJUuRbPDxpGgoc3s95YeDZKRsDD4vlF8o0ktqo+RRRpUN2RrpE/
	XAVS79ww==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxw-0000000EHpY-2qFn;
	Wed, 07 Jan 2026 07:28:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 16/24] NFS: simplify the detached delegation check in update_open_stateid
Date: Wed,  7 Jan 2026 08:27:07 +0100
Message-ID: <20260107072720.1744129-17-hch@lst.de>
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

When nfs_detach_delegation_locked detaches a delegation from an inode,
it clears both nfsi->delegation and delegation->inode.  Use the later
in update_open_stateid to check for a detached inode, as that avoids
an extra local variable, and removes the need for a RCU derefernence
as we already hold the lock in the delegation.  This prepares for
removing the surrounding RCU critical section.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/nfs4proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3b4758e887e4..6be300e8551a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1907,7 +1907,6 @@ int update_open_stateid(struct nfs4_state *state,
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
 	struct nfs_client *clp = server->nfs_client;
-	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs_delegation *deleg_cur;
 	nfs4_stateid freeme = { };
 	int ret = 0;
@@ -1926,7 +1925,7 @@ int update_open_stateid(struct nfs4_state *state,
 		goto no_delegation;
 
 	spin_lock(&deleg_cur->lock);
-	if (rcu_dereference(nfsi->delegation) != deleg_cur ||
+	if (!deleg_cur->inode ||
 	   test_bit(NFS_DELEGATION_RETURNING, &deleg_cur->flags) ||
 	    (deleg_cur->type & fmode) != fmode)
 		goto no_delegation_unlock;
-- 
2.47.3


