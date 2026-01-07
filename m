Return-Path: <linux-nfs+bounces-17528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1891CFC56A
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3721830034A7
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EEF27A461;
	Wed,  7 Jan 2026 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OzpWwaU7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F827991E
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770865; cv=none; b=RQy2AEseKjQjAXDDr1yaepVqIN+0DbMdDK7Ou9DXa3O2D322sUsUah9m6MWS6SkUB3+ZlPgIV3RhbPggNPuVAhmlL3LrEbAU2vdYOZuCKx7+duWkIsxfGLS1ZomKtzMSeC0HLUyVddRfjc4cyMLlqqD+Q0cMj1gC4Ea//bmPFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770865; c=relaxed/simple;
	bh=WSf/NaWBcbUiGLD9bP63TC9OCVFY8Q53Gxv4wSoo/Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ3MLLnkYWRNohkmQwEfybZqSVDTDAPwcSvHBsJ3lCZZy3c1pvXkEdJNQgkJMHmyc++KVEfVy6QahQ7zETM+nLZ8FFWPF6Wc25hYH/PvNvFLioGeejP+A6SJsG6EBT6gv5pspZ+uv26znyWc634qy8vmwetepxPyE+szzDvOGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OzpWwaU7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0TsBK5XY9byDTE44ffjydAaXEAe6Sj/myv6/vEWLCSs=; b=OzpWwaU7kUB0b4tifjdattbUtI
	zXUXo8A255HQ7/E3M705JIt0X/rxVfSSyJz0uQpIOa0Ebb/oKJ+ilbM1I2uB1m6DH+y6IAtQLEjaS
	ox4czdDXThw1J5w/OkTRoGlM4Rkhcfwn+UHbYYOWMrYjTx9w+4XCU1jw+HUWhHBklMxDFKnx57842
	bsH7lUXev0e31hqyF9qZLFo7ct4mtNGZHhOaMCIWaSEfhHaBNMvB4v77CiWjAIpRiJqNoDs9t5VsX
	DL0TNuI6ljsbwXl+R8NQz5vRnOIaNR/SnQjc/znIDit2KfVOuvIEYO8PkI3jEBgdCC+BX58aArAjX
	d8tFgnsw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxH-0000000EHkg-0su9;
	Wed, 07 Jan 2026 07:27:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 06/24] NFS: remove nfs_start_delegation_return
Date: Wed,  7 Jan 2026 08:26:57 +0100
Message-ID: <20260107072720.1744129-7-hch@lst.de>
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

There is only one caller, so fold it into that.  With that,
nfs_start_delegation_return

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cf01ebd3b3c5..ec87463f196d 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -336,17 +336,6 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
 	return ret;
 }
 
-static struct nfs_delegation *
-nfs_start_delegation_return(struct nfs_inode *nfsi)
-{
-	struct nfs_delegation *delegation;
-
-	rcu_read_lock();
-	delegation = nfs_start_delegation_return_locked(nfsi);
-	rcu_read_unlock();
-	return delegation;
-}
-
 static void nfs_abort_delegation_return(struct nfs_delegation *delegation,
 					struct nfs_server *server, int err)
 {
@@ -788,15 +777,18 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 
-	delegation = nfs_start_delegation_return(nfsi);
-	if (delegation != NULL) {
-		/* Synchronous recall of any application leases */
-		break_lease(inode, O_WRONLY | O_RDWR);
-		if (S_ISREG(inode->i_mode))
-			nfs_wb_all(inode);
-		return nfs_end_delegation_return(inode, delegation, 1);
-	}
-	return 0;
+	rcu_read_lock();
+	delegation = nfs_start_delegation_return_locked(nfsi);
+	rcu_read_unlock();
+
+	if (!delegation)
+		return 0;
+
+	/* Synchronous recall of any application leases */
+	break_lease(inode, O_WRONLY | O_RDWR);
+	if (S_ISREG(inode->i_mode))
+		nfs_wb_all(inode);
+	return nfs_end_delegation_return(inode, delegation, 1);
 }
 
 /**
-- 
2.47.3


