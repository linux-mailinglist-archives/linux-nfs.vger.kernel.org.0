Return-Path: <linux-nfs+bounces-17537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA00CFC5AF
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F172230A6AFD
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FF5279DC0;
	Wed,  7 Jan 2026 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IjCSitK7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCC1A9F9F
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770902; cv=none; b=bCcDrJ85eTlSbcNJbjLqd6VjOaClNAzCnRXLbJWmw+b0kGHKSqEnvcrtWxoKktwlIn0397RNuBkoEA465bFPIfY9ja0E7mGLPo0FMVEXBudrHHW1mNAYaW1rSIEHe5p+v4icF5QnHJx4QL4H1xYIrtpJryS2CkWOlKfQNkWKlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770902; c=relaxed/simple;
	bh=uckptuftgY9bmYmOtVjKbYtslBt7z4LgcgoRgDtYjgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwPJ0ada2kCxDpbQx4QyxIKA75RW9mbDnW014/96zAkLf8eYLCzund03Cd7p92sMeorVirk3Wkp327n2+jUsl0YByhdxHHM/T/G8uytYAF4bhNmhcvC0te8GfYCdA8SoMf5lQaQL4Y02Eh+p/kBvzftnV6veBSh+mWFCLEecCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IjCSitK7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5MHzjSEHdv4zVAf9PHK3wEIZKXZQ5V5xDGMexmdKte0=; b=IjCSitK7WhQnewCti222irPDsa
	9npDQyULDqzMe5dTLMtmf3k9YuD0508/zyPXIyyuOtIcovec/fsVAOqjrC7KbF/3SqmmNhnj7Lrq+
	7HYo1lRDX+8900R2wuG4OFuiC/4Yb0hEnq3aFQOddZiOAiLv1SeEUt4Db62hcAeAJDqFPwsrYufC/
	YTxUpivuqeKHRhBJ6/Og9LCPWmE7OwmsC25+DGUQpye6miKjfSvWslwsqSaA0WM3XhaVf+pV3u0SG
	anKdjYBaRSlbyaIdpkPer8R7VBFLt7vKaFZVCHjTcVXRa2FgtzU5NgurdM9j6TXHe2Rf2odV0wb0m
	LrTOWLOA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxr-0000000EHnj-3doX;
	Wed, 07 Jan 2026 07:28:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 15/24] NFS: move the deleg_cur check out of nfs_detach_delegation_locked
Date: Wed,  7 Jan 2026 08:27:06 +0100
Message-ID: <20260107072720.1744129-16-hch@lst.de>
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

nfs_inode_set_delegation as the only direct caller of
nfs_detach_delegation_locked already check this under cl_lock, so
don't repeat it.

Replace the lockdep coverage for the lock that was implicitly provided by
the rcu_dereference_protected call that is removed with an explicit
lockdep assert to keep the coverage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6946b48584f8..f7d5622c625a 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -350,15 +350,10 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		struct nfs_delegation *delegation,
 		struct nfs_client *clp)
 {
-	struct nfs_delegation *deleg_cur =
-		rcu_dereference_protected(nfsi->delegation,
-				lockdep_is_held(&clp->cl_lock));
+	lockdep_assert_held(&clp->cl_lock);
 
 	trace_nfs4_detach_delegation(&nfsi->vfs_inode, delegation->type);
 
-	if (delegation != deleg_cur)
-		return false;
-
 	spin_lock(&delegation->lock);
 	if (!delegation->inode) {
 		spin_unlock(&delegation->lock);
@@ -378,10 +373,14 @@ static bool nfs_detach_delegation(struct nfs_inode *nfsi,
 		struct nfs_server *server)
 {
 	struct nfs_client *clp = server->nfs_client;
-	bool ret;
+	struct nfs_delegation *deleg_cur;
+	bool ret = false;
 
 	spin_lock(&clp->cl_lock);
-	ret = nfs_detach_delegation_locked(nfsi, delegation, clp);
+	deleg_cur = rcu_dereference_protected(nfsi->delegation,
+				lockdep_is_held(&clp->cl_lock));
+	if (delegation == deleg_cur)
+		ret = nfs_detach_delegation_locked(nfsi, delegation, clp);
 	spin_unlock(&clp->cl_lock);
 	return ret;
 }
-- 
2.47.3


