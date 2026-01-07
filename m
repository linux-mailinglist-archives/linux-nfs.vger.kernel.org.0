Return-Path: <linux-nfs+bounces-17541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1816ACFC5D9
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 262AD30C59FE
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E23275AFD;
	Wed,  7 Jan 2026 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3eEgL5yH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADF7283CA3
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770919; cv=none; b=pQkR/mZrznTgfo26dgF1B2c3qR7+UFr0mgKbtsDySc2g0HtDsL24CaL0urzymahHPVpzJkL+rhyQpkjhqhqWi31DPHbO7h46pIKSelvVSSx6+JFWgFpe4rRNG9QxjFrIFrn0gkPJWO8m6AptKYN0bjNEUIWV5JFe8T572fyFXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770919; c=relaxed/simple;
	bh=e0NMKnr1OnOjDuj65EEzkdkr/LKDuJ8o4TZ2DVNKn80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP9FjUYQVcSYdvsds1sYDPLNvW8SalVboZKFci7EBe+qbWNgzXH2RD3Rinn2hI5lokNtZkVKN9Q+h2v0FMk7dGBRxZrbPmS1i6x9H4rxuXV6EIGEdOR57YyoAL3AX8UuPVegQNrgfKipxCr2bQWPkfvvfUu5+RCaL5xzXEW9J28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3eEgL5yH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=offBVfE1RXqgqFWxoV9aGvk8DpKfpG4aA9atywIqOE8=; b=3eEgL5yHyIHaJWUp2Jja4ZBA5k
	EPzCk9l1m4D0iCHLXehLvE9bZBwQz2eVWOrwRaeq/EI/ue78RdjIVyf4obrs/IenSp7qZLu1GbBqo
	HN7/fvlKISa0mLlzH2XVSeYea/ZDU6tpptvRWzjJabzmcCk9v5Js/iBPDYFtsx+UYcHWsk5JbuRqy
	EpbnZmkCN0vcbAUmjIfb0tJSw/0LgJixz70waiOcrM9Ws+9eW5YhqfLVQqNuAtDaPgkLYT/zP+pQJ
	K3ZottqFiW9wXu2Z49/TMVdB6Ky9v5zLsoq92ZFQP8hCdYNayE9lNUZPhpyP0EHR+CD5NKQCLK/+j
	kELsdkDQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNy9-0000000EHrd-19F9;
	Wed, 07 Jan 2026 07:28:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 19/24] NFS: use refcount_inc_not_zero nfs_start_delegation_return
Date: Wed,  7 Jan 2026 08:27:10 +0100
Message-ID: <20260107072720.1744129-20-hch@lst.de>
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

Using the unconditional reference increment means we can take a
reference to a delegation already in the RCU grace period, which could
cause a use after free under very unlikely conditions.  Switch to use
refcount_inc_not_zero instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5fb48a140169..5d9dba7ab430 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -60,12 +60,6 @@ static void nfs_mark_delegation_revoked(struct nfs_server *server,
 	}
 }
 
-static struct nfs_delegation *nfs_get_delegation(struct nfs_delegation *delegation)
-{
-	refcount_inc(&delegation->refcount);
-	return delegation;
-}
-
 void nfs_put_delegation(struct nfs_delegation *delegation)
 {
 	if (refcount_dec_and_test(&delegation->refcount))
@@ -312,25 +306,29 @@ static struct inode *nfs_delegation_grab_inode(struct nfs_delegation *delegation
 static struct nfs_delegation *
 nfs_start_delegation_return(struct nfs_inode *nfsi)
 {
-	struct nfs_delegation *ret = NULL;
 	struct nfs_delegation *delegation;
+	bool return_now = false;
 
 	lockdep_assert_in_rcu_read_lock();
 
 	delegation = rcu_dereference(nfsi->delegation);
-	if (!delegation)
+	if (!delegation || !refcount_inc_not_zero(&delegation->refcount))
 		return NULL;
 
 	spin_lock(&delegation->lock);
 	if (delegation->inode &&
 	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
 		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
-		ret = nfs_get_delegation(delegation);
+		return_now = true;
 	}
 	spin_unlock(&delegation->lock);
-	if (ret)
-		nfs_clear_verifier_delegated(&nfsi->vfs_inode);
-	return ret;
+
+	if (!return_now) {
+		nfs_put_delegation(delegation);
+		return NULL;
+	}
+	nfs_clear_verifier_delegated(&nfsi->vfs_inode);
+	return delegation;
 }
 
 static void nfs_abort_delegation_return(struct nfs_delegation *delegation,
-- 
2.47.3


