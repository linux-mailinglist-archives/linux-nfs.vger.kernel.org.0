Return-Path: <linux-nfs+bounces-17524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC223CFC562
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E654302C87E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B0A27BF93;
	Wed,  7 Jan 2026 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oOwWZQr3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9D27FD76
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770853; cv=none; b=oo5DMiHzDAyPWBGaUWgy12DJYEK5helRiYSSEwSYLEgeZp+tLI8zb0reCBbuaekPcgAEo1yi/GbIFuuEKG0chzQHnQ5hOHeKmHyYWJSdmDrK3GduJ6i1HCshpZz+bdDULhzm9sgk1mw238PtSe/ySygTM/Fp/A/6uxUjBZnbAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770853; c=relaxed/simple;
	bh=aFNpIjcNCwFiWTISi1TfuKXyQKD0vao/wKl8N2C5RZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGkpQg28xwe2r6IN/o+ReUgxSMY/5N1ARw2qCz4+XdXWNr8QYg8duzIem76GBhJcDQF5Lb3d28zLK09dcskDpxMWjxo1+Hnsvvfc3fSI8tmE/0bi7m0diPrUABIEWw3Y2T/IvUNIerP9xnJkANPFSPmuR5e/LByEZzUgHhiVes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oOwWZQr3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cYuqgMKNdw7L7GDosA34frowdiaCH0S4IsIoZppQ+KE=; b=oOwWZQr3j0+y4a7UtR/yOfRVZT
	uxByK5CDJgalpkMs8Yp4OCJ5qWy1gQ6tFfdsk9xIu/gSRL5msxh/KlPw4wEOf+wHR9OGCzqrKlQTg
	22EscoXdBCdqVaRK8fgOp0kAjOEEjLRb1qmOX2pKsSsZfrGilkYaEmdO7l5++zW5JfjknemJSJQOR
	EVZPeMUCk+7wUCoadYvQ9wQ/7ZplwtXVW58uJ7qMk0sj8odAvpToMQYVcS3yMeBFm7dZVUiz4BjRk
	venpw9SQEBOVshlEsb1VmsldXJYkc6RXBvGdFo5JKZ7H8et+WQVBtPdbrCLHQSQwyXCBfdnF/pacn
	fmy/RLCA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNx5-0000000EHju-0ttS;
	Wed, 07 Jan 2026 07:27:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 02/24] NFS: remove nfs_client_mark_return_unused_delegation_types
Date: Wed,  7 Jan 2026 08:26:53 +0100
Message-ID: <20260107072720.1744129-3-hch@lst.de>
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

nfs_client_mark_return_unused_delegation_types is only called by
nfs_expire_unused_delegation_types, so merge the two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 2248e3ad089a..5648f1f0943b 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1001,8 +1001,7 @@ static void nfs_mark_return_unused_delegation_types(struct nfs_server *server,
 	}
 }
 
-static void nfs_client_mark_return_unused_delegation_types(struct nfs_client *clp,
-							fmode_t flags)
+void nfs_expire_unused_delegation_types(struct nfs_client *clp, fmode_t flags)
 {
 	struct nfs_server *server;
 
@@ -1010,6 +1009,8 @@ static void nfs_client_mark_return_unused_delegation_types(struct nfs_client *cl
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link)
 		nfs_mark_return_unused_delegation_types(server, flags);
 	rcu_read_unlock();
+
+	nfs_delegation_run_state_manager(clp);
 }
 
 static void nfs_revoke_delegation(struct inode *inode,
@@ -1106,18 +1107,6 @@ void nfs_remove_bad_delegation(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
 
-/**
- * nfs_expire_unused_delegation_types
- * @clp: client to process
- * @flags: delegation types to expire
- *
- */
-void nfs_expire_unused_delegation_types(struct nfs_client *clp, fmode_t flags)
-{
-	nfs_client_mark_return_unused_delegation_types(clp, flags);
-	nfs_delegation_run_state_manager(clp);
-}
-
 static void nfs_mark_return_unreferenced_delegations(struct nfs_server *server)
 {
 	struct nfs_delegation *delegation;
-- 
2.47.3


