Return-Path: <linux-nfs+bounces-17162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202C1CCA631
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD08E300DC92
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B9319857;
	Thu, 18 Dec 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5l8I3T4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DE311C38
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037460; cv=none; b=HKBh4YDVNjb/bNEPA1sTitqqXdr5ojG8P216fQJm6xjuF5FubmxPKLE1+KmMVpGKA/rYAmbP3aGE+KUeXTmJiLTIGMo9QCgdEFqVWo/xKoDhFbnZDwq68u6ZtOWV5kSU0ugVFymdo50UtNtuVNkriCuuefFaKyP4sA9REEEpYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037460; c=relaxed/simple;
	bh=flU3GauvlQ6EwG7uHSGRzVN+UkFNRe7OndK8ercjFzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvkCvwYSMcl+1H/Pv+NkOuhP9pqtX2r67MmAr4mzXwHP2Y/wv58yNkjpccCvYOcCQuS+PeCXqpHQIpySlfUi7AkGYCtJrKmR9BE5CyOTquy/4x2wGlMl3hdSESvu2ataahz47MmTFnD5zAIfadMqexl1TapYrY7YRW/z41Bki8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A5l8I3T4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C9V4AqoH893EcmxxBgVz71lLnnKCpqTMA956yiGcZCE=; b=A5l8I3T4jvo0clkZKZo/c+EuBV
	Vu7VfBHE0xWQItCS54JTgY5EpWB9Jh+B0ATVxUZKmnUFDBXK9gwY1I3YaV0RiTZNYQhwoNkc6Fyk1
	FaGg0miCHpoFHAVNNd52IX7O/JsiEm5eRkim90MT0NNZPPIoR59fqxumrSwumzfPiGjLDkYdu0Yru
	VZtxg3s9GNBBCWmkdLx9TOaYk2l6O5/6xk4w/P6kFCF5pTDs5Up2Hi19w/yGwgOdEhN6SD9T78PZC
	HYNCKtAVqQ9zChWRl2Bl5/UFEpZgbCCKIiDZdnDXQCkHxpgDaJXTBRYvM7/p/bk4AnbedSFlx/DXD
	CoDpATGA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW716-00000007rhR-1VZP;
	Thu, 18 Dec 2025 05:57:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 14/24] NFS: return bool from nfs_detach_delegation{,_locked}
Date: Thu, 18 Dec 2025 06:56:18 +0100
Message-ID: <20251218055633.1532159-15-hch@lst.de>
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

nfs_detach_delegation always returns either the passed in delegation
or NULL, simplify this to a bool return.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5141f6e5def1..6946b48584f8 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -345,7 +345,7 @@ static void nfs_abort_delegation_return(struct nfs_delegation *delegation,
 	spin_unlock(&delegation->lock);
 }
 
-static struct nfs_delegation *
+static bool
 nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		struct nfs_delegation *delegation,
 		struct nfs_client *clp)
@@ -356,13 +356,13 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 
 	trace_nfs4_detach_delegation(&nfsi->vfs_inode, delegation->type);
 
-	if (deleg_cur == NULL || delegation != deleg_cur)
-		return NULL;
+	if (delegation != deleg_cur)
+		return false;
 
 	spin_lock(&delegation->lock);
 	if (!delegation->inode) {
 		spin_unlock(&delegation->lock);
-		return NULL;
+		return false;
 	}
 	hlist_del_init_rcu(&delegation->hash);
 	list_del_rcu(&delegation->super_list);
@@ -370,19 +370,20 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 	rcu_assign_pointer(nfsi->delegation, NULL);
 	spin_unlock(&delegation->lock);
 	clear_bit(NFS_INO_REQ_DIR_DELEG, &nfsi->flags);
-	return delegation;
+	return true;
 }
 
-static struct nfs_delegation *nfs_detach_delegation(struct nfs_inode *nfsi,
+static bool nfs_detach_delegation(struct nfs_inode *nfsi,
 		struct nfs_delegation *delegation,
 		struct nfs_server *server)
 {
 	struct nfs_client *clp = server->nfs_client;
+	bool ret;
 
 	spin_lock(&clp->cl_lock);
-	delegation = nfs_detach_delegation_locked(nfsi, delegation, clp);
+	ret = nfs_detach_delegation_locked(nfsi, delegation, clp);
 	spin_unlock(&clp->cl_lock);
-	return delegation;
+	return ret;
 }
 
 static void
@@ -492,9 +493,9 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 					&old_delegation->flags))
 			goto out;
 	}
-	freeme = nfs_detach_delegation_locked(nfsi, old_delegation, clp);
-	if (freeme == NULL)
+	if (!nfs_detach_delegation_locked(nfsi, old_delegation, clp))
 		goto out;
+	freeme = old_delegation;
 add_new:
 	/*
 	 * If we didn't revalidate the change attribute before setting
@@ -732,8 +733,8 @@ void nfs_inode_evict_delegation(struct inode *inode)
 
 	rcu_read_lock();
 	delegation = rcu_dereference(nfsi->delegation);
-	if (delegation)
-		delegation = nfs_detach_delegation(nfsi, delegation, server);
+	if (delegation && !nfs_detach_delegation(nfsi, delegation, server))
+		delegation = NULL;
 	rcu_read_unlock();
 
 	if (!delegation)
@@ -1240,7 +1241,7 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 		rcu_read_unlock();
 		if (delegation != NULL) {
 			if (nfs_detach_delegation(NFS_I(inode), delegation,
-						server) != NULL) {
+					server)) {
 				nfs_mark_delegation_revoked(server, delegation);
 				nfs_put_delegation(delegation);
 			}
-- 
2.47.3


