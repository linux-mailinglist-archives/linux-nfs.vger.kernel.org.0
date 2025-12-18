Return-Path: <linux-nfs+bounces-17151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC96CCA607
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 744CF304CC20
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205383126DD;
	Thu, 18 Dec 2025 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jGYPutii"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B93161BB
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037413; cv=none; b=N81mkq+3+AIn6AaYfGEszppWGHX0RHMi86VDRYQxTOIYaqTOWEXrZAJZubvLHsCbf1IaO6BCTuWSGP332pIYp0wLny4TnOjpzJV7yPw3LF6bRiXiWY3XKXTSXS5IpyAe7PrvZJmXc3RW+ppNRQ7LzAgaBI+Dnt7UCSxRzGAf3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037413; c=relaxed/simple;
	bh=EUYkJ8X3brZmyvzYY4WIoIAfsfKpOVUohMtT+A22F0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXW/RZc34UrvvKgDqi3j50gISxaufQY2tvz8Tt3HtvgAMd7sWul3KA4nygOXHk0Wel4jloKWbr/mkJo6W3EVg33FYy4wQqZH2DTBQZ7QAfzPwcr5jagznRJy4SF/tZ6j2Vxw0b1OlBFYCy3nSXynRhY2ERwCuZt8wuJkHAmRS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jGYPutii; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gmXvVERKt1MkiyUv5Pp3EA8BiG/lR/18RXjEfmSm+lM=; b=jGYPutiiY/So5ziMYVB76phd7D
	syTmnZBc9fvt9ueHiXy6kbNMfr8jc1onCyWrjoFkGjz1GHLYTa8ZI23eVe2FH/MlxXVsHHAYhJLr9
	mwdob2aJsM5JpkhqE4Ir85bsstpAmYsPSVYV/MzD/esPMOsIMIdFnCLqjAYpWVQHkcMfweBPoMzQa
	+R+KwskzuWDn7zTpr0U3USPiyCDpjJFdV47m+S8uaIY9nbZVN2HxUbHM/eogaQITYcVGuTNZCDgRh
	68Lnvg/eas8iGuvkEkf4lmWvMjDky7Pm7CdEtxJFNGK+wkej9FCPkcZgsi1YU5Aq37CaRESg9Nbud
	2sGgtcyw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70L-00000007rSc-2lmC;
	Thu, 18 Dec 2025 05:56:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 03/24] NFS: remove nfs_client_mark_return_all_delegations
Date: Thu, 18 Dec 2025 06:56:07 +0100
Message-ID: <20251218055633.1532159-4-hch@lst.de>
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

Fold nfs_client_mark_return_all_delegations into
nfs_expire_all_delegations, which is the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5648f1f0943b..2ef8fe01ef4a 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -938,16 +938,6 @@ static bool nfs_server_mark_return_all_delegations(struct nfs_server *server)
 	return ret;
 }
 
-static void nfs_client_mark_return_all_delegations(struct nfs_client *clp)
-{
-	struct nfs_server *server;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link)
-		nfs_server_mark_return_all_delegations(server);
-	rcu_read_unlock();
-}
-
 static void nfs_delegation_run_state_manager(struct nfs_client *clp)
 {
 	if (test_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state))
@@ -961,7 +951,13 @@ static void nfs_delegation_run_state_manager(struct nfs_client *clp)
  */
 void nfs_expire_all_delegations(struct nfs_client *clp)
 {
-	nfs_client_mark_return_all_delegations(clp);
+	struct nfs_server *server;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link)
+		nfs_server_mark_return_all_delegations(server);
+	rcu_read_unlock();
+
 	nfs_delegation_run_state_manager(clp);
 }
 
-- 
2.47.3


