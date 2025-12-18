Return-Path: <linux-nfs+bounces-17150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA35ACCA60A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B84D303C039
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4431ED94;
	Thu, 18 Dec 2025 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHFcl1pd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543831ED87
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037407; cv=none; b=L/sbF8KbH3n1vVgWTmtAjAzTyEaMfniDXQwBd+4Tp0YDjUJQuCRyoOFUb5bRZS2UbeENg7/KNIbTZ6b/+JbBNfWvLyK3vptHoJterFlN1HGvXBIE/lt+DHSOlCgYbtjDe8KxlA7VMLhXA8sarm9PdPcgKsANac/N6xdwFCps5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037407; c=relaxed/simple;
	bh=aFNpIjcNCwFiWTISi1TfuKXyQKD0vao/wKl8N2C5RZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSzge1UNL7hKo3p03TYzEZWQaUVA5//ZgQ7LkqhDmQKPbz/1zXLMPJDJu4r2w2IEClSGHXvtaxWGJ1AVyGCbkFI5dbueG/mGWopKcUjuQbZjh4/Y3H2Wn1Ja9fhGK37iRbSj+Juef6Gm1+E58fvOc+VYjyRifV7Wu44Ice/KMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BHFcl1pd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cYuqgMKNdw7L7GDosA34frowdiaCH0S4IsIoZppQ+KE=; b=BHFcl1pddWo/Jcuf1+G3x760Hk
	Qdht+bbGEyrxQGPh2wIeCb9//Vf5cHNIxwX4cTfL911/caiFTKbc3x+bkMd4ZZqArxJjwrSkk/Hy2
	3UpALqogpo+8r+3MwbLqYlomHxQbE/zo9Ywq+ripjkFvVGWFiCrxyr7nTP82Es8s6/HwhpZcj9XJZ
	UjQLXZuhiRTU9Ee64+hPZcnRdK08n3JMshPh5Ht1uG691Bg+2EQISjwVqIf6mgJxMEoVL0ScnIAef
	+HopLrHMFeamLtWHQ1YgZhGqT2WEicXnaI59wQmcIwE6LsS8E4yQTDCIgryvDW8oqmmghV0aNISfc
	lCP0cRyA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW70G-00000007rRB-3YUI;
	Thu, 18 Dec 2025 05:56:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 02/24] NFS: remove nfs_client_mark_return_unused_delegation_types
Date: Thu, 18 Dec 2025 06:56:06 +0100
Message-ID: <20251218055633.1532159-3-hch@lst.de>
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


