Return-Path: <linux-nfs+bounces-17168-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1EDCCA64C
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C70B302A3AA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF452475CF;
	Thu, 18 Dec 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B98kWUjd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38A20DD51
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037487; cv=none; b=fLtWkCtWjaT4tdgmUdVjs51wMKGFn+W7n6m9/HW1PeSz2iIhqxiRr06d3FnDOFWT0d9YX5S86GObx4FSmztH70ga7tKDrMVWtKkK2dj0uvHhQXLXIUgV/S5a15xaWrQjWx4s/QVi9eQAnYupuLkRtp+5nf6j81yV4Riqe90xJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037487; c=relaxed/simple;
	bh=r8C3UE6KMhb/eOhpoH6l+TVCmvaqvxXs2DYgEBU0YKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXsqWGJ9zoDSa7UVTSK6qFnXK4PMCWJ0A9f6MlxQps1TglD61LVBadfGzzRFu+KFZ23jRJ+f8rIYtkpO5ReU2AySBr5+DNBPHFFeNLsp8f9UnAbf27HbxS4kFILrv6azI5QeGU2f3RV5j3jxpgk7sqEpab8p5XRrXcOwhRYOHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B98kWUjd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GAAkH74hbo1RU14IbNFPzeXFNeS5ZGi0JELnYMWbV60=; b=B98kWUjd8vW6wDjVIEOYHlbWbd
	3oTRZEyrh6h3yYtDcr/f6BxoZcBPkrlDZdzyz8V+ap8KjzQPSGNpQeoOIyT5u9v6pFx+V4GSrc8Wk
	83yTlhKBeNODlb25lEtziT+QoY/l9RUD+ss+Ne9Y58LgqZ+vbAGjDtvvDPR6tvvq5+Htv5/N7NQjE
	BswP7cK5OklxkKOdV8/d2tgaeFwxpViOrOrUg5BYS/1k9HNZzFCfoM4S9nfaCHPXTZFEMrRuaSbCs
	P7tdap+AhYeUBSRneE9JvvudAmtWYXiktUyRBwpjPFuWY1xlXB+bNE+eELpQAh/ggA/76hru38mi3
	Ll0D8Awg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW71Z-00000007rnb-0Yei;
	Thu, 18 Dec 2025 05:58:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 20/24] NFS: use a local RCU critical section in nfs_start_delegation_return
Date: Thu, 18 Dec 2025 06:56:24 +0100
Message-ID: <20251218055633.1532159-21-hch@lst.de>
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

Nested RCU critical sections are fine and very cheap.  Have a local one
in nfs_start_delegation_return so that the function is self-contained
and to prepare for simplifying the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5d9dba7ab430..2ac897f67b01 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -309,11 +309,13 @@ nfs_start_delegation_return(struct nfs_inode *nfsi)
 	struct nfs_delegation *delegation;
 	bool return_now = false;
 
-	lockdep_assert_in_rcu_read_lock();
-
+	rcu_read_lock();
 	delegation = rcu_dereference(nfsi->delegation);
-	if (!delegation || !refcount_inc_not_zero(&delegation->refcount))
+	if (!delegation || !refcount_inc_not_zero(&delegation->refcount)) {
+		rcu_read_unlock();
 		return NULL;
+	}
+	rcu_read_unlock();
 
 	spin_lock(&delegation->lock);
 	if (delegation->inode &&
@@ -762,10 +764,7 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	struct nfs_delegation *delegation;
 	int err;
 
-	rcu_read_lock();
 	delegation = nfs_start_delegation_return(nfsi);
-	rcu_read_unlock();
-
 	if (!delegation)
 		return 0;
 
-- 
2.47.3


