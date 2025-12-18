Return-Path: <linux-nfs+bounces-17156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FBCCA60D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 040FB3012559
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879920DD51;
	Thu, 18 Dec 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvvBLavt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804E313541
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037431; cv=none; b=s+Yf2AQgY2DsiXKCQOsOcvaZGE5R4WzCALSnHc84WZlH+4aE7wZfkoJgsPDkAtzxr20LyDT8a3z8gABsZCNJNRW/9tTdnxesusiwpaVKr44Hht+YZASHZIZuXB2ENuLoEx3pQuhPijBngiQEJtAl/IEiVBCQRkZwkO0BeVXI5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037431; c=relaxed/simple;
	bh=W4QVs5bhk3oToeuKIOhGK+pn7BhJuTrwfESDkDoPX0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8iJmpp5HhV3MOgQcmU7TsK9XHJQjxSOLi3KbDWWF1qGAOiEankHlEgL1ICGdgCIhYA63sA6y4lqtkiUIrYQ9xaQepM9RD9f28k2zxEzUHllc0XaFcpKr6WvLTmYjjlT4cVOURZn+xhqKBuE8v/js8rdsnu2nEyD5K33evz1C3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qvvBLavt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xlUxy+ujTslerA434mGbJ3FYFTrJ9mtmyMa3qWpi24Q=; b=qvvBLavtIANP3u9zDaJ61NySyg
	70tuaypA3OPWFg0YxzYEFC1/w4imWpNQV/X9Ia7ChoMnZX2N3yJFoDEnRdvYTK3KKXFNANJm6gaRG
	Jz/ac9pLlseQBmaWiT4CYTEM8wHgvpPHefNVKEOFAWVwbBx2MuZk1SrFEEROfJuTezmw9IPOqaXQZ
	rFQr1vtddl0OcgHEYNwHqkuGAcMuRriRotC7/kDa1WNIyfozYxDPn4IYxz+bVXFxRYB88PwyyEp6j
	GWc44oNUlzbYusYlrkp7wK1dnEF9NCizs4dIYC/0FgMAjqpxMECe8V13IVqSCfxArDXXmiz79HQd5
	EMMxn0mg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70e-00000007raS-47QU;
	Thu, 18 Dec 2025 05:57:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 08/24] NFS: drop the _locked postfix from nfs_start_delegation_return
Date: Thu, 18 Dec 2025 06:56:12 +0100
Message-ID: <20251218055633.1532159-9-hch@lst.de>
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

Now that nfs_start_delegation_return_locked is gone, and we have
RCU locking asserts, drop the extra postfix.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index a5a3ecac8a43..5049c65cc8e5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -315,7 +315,7 @@ static struct inode *nfs_delegation_grab_inode(struct nfs_delegation *delegation
 }
 
 static struct nfs_delegation *
-nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
+nfs_start_delegation_return(struct nfs_inode *nfsi)
 {
 	struct nfs_delegation *ret = NULL;
 	struct nfs_delegation *delegation;
@@ -583,7 +583,7 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 
 	err = nfs_do_return_delegation(inode, delegation, issync);
 out:
-	/* Refcount matched in nfs_start_delegation_return_locked() */
+	/* Refcount matched in nfs_start_delegation_return() */
 	nfs_put_delegation(delegation);
 	return err;
 }
@@ -658,7 +658,7 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 			}
 		}
 
-		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
+		delegation = nfs_start_delegation_return(NFS_I(inode));
 		rcu_read_unlock();
 
 		iput(to_put);
@@ -781,7 +781,7 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	struct nfs_delegation *delegation;
 
 	rcu_read_lock();
-	delegation = nfs_start_delegation_return_locked(nfsi);
+	delegation = nfs_start_delegation_return(nfsi);
 	rcu_read_unlock();
 
 	if (!delegation)
@@ -1258,13 +1258,13 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
 			continue;
-		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
+		delegation = nfs_start_delegation_return(NFS_I(inode));
 		rcu_read_unlock();
 		if (delegation != NULL) {
 			if (nfs_detach_delegation(NFS_I(inode), delegation,
 						server) != NULL)
 				nfs_free_delegation(server, delegation);
-			/* Match nfs_start_delegation_return_locked */
+			/* Match nfs_start_delegation_return */
 			nfs_put_delegation(delegation);
 		}
 		iput(inode);
-- 
2.47.3


