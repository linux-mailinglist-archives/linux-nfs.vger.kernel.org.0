Return-Path: <linux-nfs+bounces-17155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E37EDCCA616
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051EC30220F4
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DA31064A;
	Thu, 18 Dec 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gazl9erx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096F3126AF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037429; cv=none; b=W4BtEWvDB23EZK8MPS3qzko21wg0pqXZ8I1ZFhlVp3u3vrI4xkS/0nFyHO9/j3Ki+gK2CBnmV0gmc5EZ0JjxS5dlRnWWr7/hsRX1Jx6jlgiAUJW91niDnlJV80dwjn7fGW4lYtXz+/ymDj+mWjH7NxfhJEMrXpAaEyowyVRWK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037429; c=relaxed/simple;
	bh=UQP1XLi3hoLSZRDRD4cPvnUmInIw20/pt/pEwpOBoZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEXsO9d9R7U+YZ0cWh4Z4Q1ymz7aSVa5cuIS5Tvdhk/QKU15UVTHXowK5iyzpknWpCzZVG90aOsxy35FvB94/wMu0Nx/JlZ7+2lX1bZwUjLTqtFfipVlkQnrCUGB/nLRqPd5f4H5GM+tKUObHE/tkEynBKgukSi5O2gIuLrFP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gazl9erx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KwqLqyNJTFgVeKCLke7i5o7xzmNp7+KQaKYxAK3LHT8=; b=Gazl9erxhwxHnT4MFR9dr6x/To
	1RJ8LmvPcdyG4ztF1RkimW40nlEalo6EIwZm1wWt93JeqJ9NEC8vUnpHLHgcjMWUGp4ygVtbCQD5W
	5v2HfzExMiiJp9dxZO5ucBQhN63hFWQIr7BhEP+O0whbAbupKOgtV7Nvse+Q/ePW67XsG4LezjTy1
	61PnlLbduX3gczuz6zSX7nmo9H1CkqxRlLFUDEnIQODvZoGSk2qBuegrAOv5TL6XefuGTJraI5RC0
	fywfLznygJibBLwciEmlSDoxvaUZNlhp1VXIVZqcmMkRwjGkiqwXV1yPaDo8KlmJERi7U6v9y2jRc
	fSjesxOg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70b-00000007rZ4-2uJw;
	Thu, 18 Dec 2025 05:57:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 07/24] NFS: assert rcu_read_lock is held in nfs_start_delegation_return_locked
Date: Thu, 18 Dec 2025 06:56:11 +0100
Message-ID: <20251218055633.1532159-8-hch@lst.de>
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


