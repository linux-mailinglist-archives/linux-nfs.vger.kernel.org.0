Return-Path: <linux-nfs+bounces-17529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04BCFC588
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4611304DE15
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EB27991E;
	Wed,  7 Jan 2026 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTkB/Dfe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891F27FB1B
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770870; cv=none; b=o4a0A2yxw+i9duXQrrb2BAjgtA4poVxKzsVTUlM8DoXAB0+ohcGkY6gCxR6XlWEz7H8LdmXUuLEhumchH0eOAJ/KJccpnuyTlJ85xwKc7Lg8zaGBDGr/q4UciJMR4aaj1tWx+YrQh+ZQx4PkFwWOFlpZ0KpINnLjpTAietqHC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770870; c=relaxed/simple;
	bh=UQP1XLi3hoLSZRDRD4cPvnUmInIw20/pt/pEwpOBoZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st1d/bb/Tnt6yUdkG7oRkc2TG6CmzpkRR/yPgcC2k/gYegOvWewY1dk3su4aoGjGAHklzwFnkS7UJ4tAYl7ZVu7Fd5lc43YyEuQ1JdmzcfOVWLQhZFbM7o7Nn2PxnK+vwEPvMEpw5mtI3BdRbnhtnJDZVOW6eIgFLVSK4Xq0JgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZTkB/Dfe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KwqLqyNJTFgVeKCLke7i5o7xzmNp7+KQaKYxAK3LHT8=; b=ZTkB/DfeyVLXorGb8uWPNlP02F
	Jq/AVIheI8oL3LOCDfecCl6YKG44OYRm+w+xPTOOhwYHae3UldAUIjvfYnl04usRDJpWKPb7vGibQ
	DJW55fRxXtt4lbHaxtxQeoStE5PYlAkTgnuW6UwCHgeMoYczCwDfCGkZohTRsrprGM4KlICswaG53
	DEpGFnCE1/1j0Onp2IEpra1WJiH8HR7RSOwzz5WndgHeDYbn9Kn6m+Y1J995jCNbmCvVHLnOaW+Ld
	mfrMRcWKdzWWKHJfY6NLNcGl4aeGBhSzYWS8FRYMrnKjv2blrpOpctC8CqqqOC7XORaGbbN7mASGg
	kzfdvMKA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxL-0000000EHky-3qMM;
	Wed, 07 Jan 2026 07:27:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 07/24] NFS: assert rcu_read_lock is held in nfs_start_delegation_return_locked
Date: Wed,  7 Jan 2026 08:26:58 +0100
Message-ID: <20260107072720.1744129-8-hch@lst.de>
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

And clean up the dereference of the delegation a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index ec87463f196d..a5a3ecac8a43 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -318,10 +318,14 @@ static struct nfs_delegation *
 nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
 {
 	struct nfs_delegation *ret = NULL;
-	struct nfs_delegation *delegation = rcu_dereference(nfsi->delegation);
+	struct nfs_delegation *delegation;
+
+	lockdep_assert_in_rcu_read_lock();
+
+	delegation = rcu_dereference(nfsi->delegation);
+	if (!delegation)
+		return NULL;
 
-	if (delegation == NULL)
-		goto out;
 	spin_lock(&delegation->lock);
 	if (delegation->inode &&
 	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
@@ -332,7 +336,6 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
 	spin_unlock(&delegation->lock);
 	if (ret)
 		nfs_clear_verifier_delegated(&nfsi->vfs_inode);
-out:
 	return ret;
 }
 
-- 
2.47.3


