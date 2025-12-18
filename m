Return-Path: <linux-nfs+bounces-17153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46002CCA625
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C65B305884F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494A20DD51;
	Thu, 18 Dec 2025 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c7xqrH7o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5887031064A
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037422; cv=none; b=YthENjFq/Gk/u6TCeTeGxTGh/YHKDts6XJRotPD1jJlQcDDJhEUzYbbK0bzOTMUxoSyawhddT0wsHHRIYgvNgmqSiALDiUzXQCgWzck5Nhm8nT66MFZMCiaGh3xaU88wSQWVXF1R5VHwQTtnPNCNY/mUdvm4CrvqIJ1XGP1YvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037422; c=relaxed/simple;
	bh=XKW7Njwx4ck2czFwcYNY0T/LSNyMqkKwlInzWyLAujw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5a8E12IKabqTrQ8vEff6DXhc6A36LD6pgMkc/+0svqDyg/JjyF/tBtcyd+ZDx2mocIH0ELAZwMPhw+XoUFdN8o/Jm4MihPpOHH/ci2yM4MzoAtpfw4Z+fV/JZlJ6ZPXsFvHrHcCVFw1Wf5OZjawaLlAJieff+4uVRFhCz34gWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c7xqrH7o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DpW0hH+iczYkbEUubbEf6TeFkw0vln8xHLjwg5wAOLA=; b=c7xqrH7oMzOrG5uP44qtEKaqIW
	VxDWP2ZcuTmUQZqn/Bk3EBbqud2KwycDUQPv4m2fh3N+LYCdILr5wEtYrPCQ3yEU1JoUTnJXF1swo
	h8Rat6slwINEV3rCXuTwBd6lu4YGyNn2mak6pKePSjmu7bl3+JFBdWflJiuyxs58dKg86G9y09XPn
	T0icugAV4wWuDfzCSvBteoxx83UcRvRuJ8CIYpL2R8XhkN/fHDDlnyEniBNC7Z3pbBq+n1eM0JYOL
	aW6kChc648XIMk09kJx4i0CxtHsyjpFUUnxTN7FyNSfAKc2+92WWkuM0ZaHRCDEYtXrAirCgGkrau
	dedkpEOg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70U-00000007rWW-42QQ;
	Thu, 18 Dec 2025 05:56:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 05/24] NFS: remove nfs_inode_detach_delegation
Date: Thu, 18 Dec 2025 06:56:09 +0100
Message-ID: <20251218055633.1532159-6-hch@lst.de>
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


