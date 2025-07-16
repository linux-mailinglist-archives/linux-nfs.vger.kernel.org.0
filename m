Return-Path: <linux-nfs+bounces-13105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF3AB076DF
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A31C2306C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED31A727D;
	Wed, 16 Jul 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mkg2UsjQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7931A5B96
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672426; cv=none; b=sgLdL2FnAjDamnS+an7azeXMnzjYhFPSIS9/P09sjJU/XY7OtRZ3Q3WyL53P+69evMm8OKcEB/O50wmUt5HAk3fJMCT8kwhyzNM1/L8NdG10Bl9H4LPJ7+t96iIMwy92rQryLZMYwUPfOya+0wYqaENuKmuG5hLeGAVGVTejiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672426; c=relaxed/simple;
	bh=05zz0dIFsUSV4YiT/ZBqByc82d/diVcBhszS8BcHmFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX/M9aS3r09CvJT7UwArcsvDovy7VzFo4sWwY5xrBZ/VRCgJ5yAk/UR1MHh8ZUaSoxOIRPq8Y5/tjAN4oxxMKOtdYXtXu4wNIbINcD9ysyRpV0qAltar3S1jJbrFYUpZUV56cBdkDWqNMur7BeTyGJFo6hja4mrYsMqGRKj1m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mkg2UsjQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oCn+VcW8MprDfpuRp+XvOMLYBG6YIoYzG5tG/I5jVbg=; b=Mkg2UsjQ41J85csemZ3ulI1zup
	k7QPdo4KPaF8Qd9jM1WA9WVi+WUQfs2e1fnnQJsUoItuApo/kCwNRkbe1FBFD9gHOoTl45mtO5NmZ
	wNkS0BLR2m5r1GOv9Z3n/hgW4Iqp0mMnfgT59zgqJ8zrTPdAdJ5EEsrvas/YdGDVMqkG7c7D8g4b2
	it6NOiSCcynbsQ/pSwzE51zckNYQW6K2P7vQj9RDuGRT/JbWvRfyaSEVaY9tkRvDUPSSdNp7dLUMN
	1VjEtIX77p/EWXZ1Y60mfQj+AiYRurjmrWBFGsLy9ytpZvMsqMYL31rdDyIir8DO11i8s7PYAiBIE
	QEMy1vyQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2A3-00000007n7v-1jgK;
	Wed, 16 Jul 2025 13:27:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 1/4] NFS: cleanup nfs_inode_reclaim_delegation
Date: Wed, 16 Jul 2025 15:26:31 +0200
Message-ID: <20250716132657.2167548-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716132657.2167548-1-hch@lst.de>
References: <20250716132657.2167548-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Reduce a level of indentation for most of the code in this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6f136c47eed7..568d2e6d65fa 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -237,34 +237,34 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 
 	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
-	if (delegation != NULL) {
-		spin_lock(&delegation->lock);
-		nfs4_stateid_copy(&delegation->stateid, stateid);
-		delegation->type = type;
-		delegation->pagemod_limit = pagemod_limit;
-		oldcred = delegation->cred;
-		delegation->cred = get_cred(cred);
-		switch (deleg_type) {
-		case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
-		case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
-			set_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
-			break;
-		default:
-			clear_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
-		}
-		clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
-		if (test_and_clear_bit(NFS_DELEGATION_REVOKED,
-				       &delegation->flags))
-			atomic_long_inc(&nfs_active_delegations);
-		spin_unlock(&delegation->lock);
-		rcu_read_unlock();
-		put_cred(oldcred);
-		trace_nfs4_reclaim_delegation(inode, type);
-	} else {
+	if (!delegation) {
 		rcu_read_unlock();
 		nfs_inode_set_delegation(inode, cred, type, stateid,
 					 pagemod_limit, deleg_type);
+		return;
+	}
+
+	spin_lock(&delegation->lock);
+	nfs4_stateid_copy(&delegation->stateid, stateid);
+	delegation->type = type;
+	delegation->pagemod_limit = pagemod_limit;
+	oldcred = delegation->cred;
+	delegation->cred = get_cred(cred);
+	switch (deleg_type) {
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+		set_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
+		break;
+	default:
+		clear_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags);
 	}
+	clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
+	if (test_and_clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
+		atomic_long_inc(&nfs_active_delegations);
+	spin_unlock(&delegation->lock);
+	rcu_read_unlock();
+	put_cred(oldcred);
+	trace_nfs4_reclaim_delegation(inode, type);
 }
 
 static int nfs_do_return_delegation(struct inode *inode,
-- 
2.47.2


