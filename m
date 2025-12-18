Return-Path: <linux-nfs+bounces-17154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49158CCA613
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0199E3031E6E
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7EB30C624;
	Thu, 18 Dec 2025 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BiMh9hUK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE9311C09
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037424; cv=none; b=q0uHjOdCWveAaYpzZmQW7i+nK+XH31GhbTOQvOOis5JejGE4hKBFyG8/9us/1vImxccDXxw0Q6cmEhADpig1rHSODoZ+aD/6aKYPaozRiVAbj26qA/CshHWtJMoCYL7WOuB7P7OYVl9HNi1FIefITGUkZ9rGbDwcopqvzxAxPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037424; c=relaxed/simple;
	bh=WSf/NaWBcbUiGLD9bP63TC9OCVFY8Q53Gxv4wSoo/Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9WrZbpYxWOjYZhUnk6XZCDeoeI0hDD/Whzt8PuqtBc/axzUyA036PJt68Xg/mEmf8f4lDrYXmlBH+qTyAefZwQbzFtnur108NbbAvCmx1th7Q1DZEBCzB4BW39LoutnTvPwTAJz1mwTA+sca1T8nIFEbPN8/TIaSqf3U8d2vVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BiMh9hUK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0TsBK5XY9byDTE44ffjydAaXEAe6Sj/myv6/vEWLCSs=; b=BiMh9hUKtIO4jC5FUCSVQG058K
	ImsQAHILAFsdxPTHhSP+Th1LhknrQ9p7AF+GM5TX1Otiy3IVfUMuvjQRuLJH3Dc6TuDRa9qJtFO5j
	R58z9v78KhLQgMzrAUi4B+jyeX+AFMI397uCPfcLerurJ3FgkZmpggeC/ySlZzQwwCpbs/9BwP350
	sRtddsoSA8kLX6z5V+fAh0kJUSu11RizZF0wZQTs/3L4AVfTP57depXaaeyZqIPfVFOWlMw5lQRrW
	+6MUYH4yb3KpEFIIixASh9N8hWRoRgDpWLRXmg0IPOOIe4Aw1KiZEUxg/NpRFAejiobz3gglpxcV5
	eUYuME4w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70Y-00000007rXv-2nb8;
	Thu, 18 Dec 2025 05:57:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 06/24] NFS: remove nfs_start_delegation_return
Date: Thu, 18 Dec 2025 06:56:10 +0100
Message-ID: <20251218055633.1532159-7-hch@lst.de>
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


