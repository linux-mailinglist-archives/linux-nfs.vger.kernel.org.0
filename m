Return-Path: <linux-nfs+bounces-17540-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A037BCFC5BB
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E26F3027D88
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4F2765F8;
	Wed,  7 Jan 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LewrI5Xq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9C13AA2F
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770914; cv=none; b=SCwvgRbOa9YAnDbmmA/T7mXn3cyusBZrH2ILAtL0fJwHtWuyWOtvTjDGaCUaGTSafYVt5qJO0rACQ6FSIHgflbHz2u4ah2DvfyGc4JgjOO6CONdrn79ONwiAa/xriEgsp1iXdXxJNJElWPCfmXt81KwEigW2e0uHhT9E00AkVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770914; c=relaxed/simple;
	bh=jIcbmV7c1Xgyn54/+VvJc7IO6sJ0GfNOLMYBrenuB6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t96UFAAp7DMrlUEGErG460GL4ZfNYlj17OEDzqTSM4nqm743y9VRIKebAy4gp6nHNPcURixkJhNRJAtVDK0ZnHBRkHmRTIaqzFeSynoyCxln53yBnr9bssCoHnkuRXStsReYI7+Q3w8ucGwq+ckCV3YHOSPj/BD03d4V70hCXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LewrI5Xq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sCUD1oZwj36PbsHrzN88R+QL9IBCrCwU3RP9qpFJQEM=; b=LewrI5Xqn5GQWxZZopeMWGcodf
	B5Q7Aik2lDMXM2JoF6AN+xlTQ/8Pk7fHXNFKwgBWZRNSTeqB97d8nIDdVXOkg/p3YG2ugjCOeFcXc
	UlyLyf7nZEr2ydNxsCFoc40Lbq9C/IR/dJrHUVEJctIzneLGr+qC4gdHNlQbAt2WPzvz3tPFDZ98d
	BR2gQW3/Ndn+xPTK08lp4111fOlhbKgUlD+AJdv0AwhZbNc+GssWOmDFQqcpaSzqLzvLL7RCzA4d+
	uV/m2+13nnXgvLWYBgk7EvwB2pnhrsbm5u862QnmkChuubHd/gTDc0opggFDimYZGQucXXABaWBAK
	mNOWwKOA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNy4-0000000EHqk-1V6N;
	Wed, 07 Jan 2026 07:28:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 18/24] NFS: don't consume a delegation reference in nfs_end_delegation_return
Date: Wed,  7 Jan 2026 08:27:09 +0100
Message-ID: <20260107072720.1744129-19-hch@lst.de>
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

All callers now hold references to the delegation as part of the lookup,
removing the need for an extra reference for those that are actually
returned which is then dropped in nfs_end_delegation_return.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/delegation.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 811e84b559ee..5fb48a140169 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -325,7 +325,6 @@ nfs_start_delegation_return(struct nfs_inode *nfsi)
 	if (delegation->inode &&
 	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
 		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
-		/* Refcount matched in nfs_end_delegation_return() */
 		ret = nfs_get_delegation(delegation);
 	}
 	spin_unlock(&delegation->lock);
@@ -574,14 +573,10 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 
 	if (err) {
 		nfs_abort_delegation_return(delegation, server, err);
-		goto out;
+		return err;
 	}
 
-	err = nfs_do_return_delegation(inode, delegation, issync);
-out:
-	/* Refcount matched in nfs_start_delegation_return() */
-	nfs_put_delegation(delegation);
-	return err;
+	return nfs_do_return_delegation(inode, delegation, issync);
 }
 
 static int nfs_server_return_marked_delegations(struct nfs_server *server,
@@ -647,7 +642,11 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 
 		iput(to_put);
 
-		err = nfs_end_delegation_return(inode, delegation, 0);
+		if (delegation) {
+			err = nfs_end_delegation_return(inode, delegation, 0);
+			nfs_put_delegation(delegation);
+		}
+
 		iput(inode);
 		cond_resched();
 		if (!err)
@@ -763,6 +762,7 @@ int nfs4_inode_return_delegation(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
+	int err;
 
 	rcu_read_lock();
 	delegation = nfs_start_delegation_return(nfsi);
@@ -775,7 +775,9 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	break_lease(inode, O_WRONLY | O_RDWR);
 	if (S_ISREG(inode->i_mode))
 		nfs_wb_all(inode);
-	return nfs_end_delegation_return(inode, delegation, 1);
+	err = nfs_end_delegation_return(inode, delegation, 1);
+	nfs_put_delegation(delegation);
+	return err;
 }
 
 /**
@@ -789,7 +791,7 @@ int nfs4_inode_return_delegation(struct inode *inode)
 void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
 {
 	struct nfs_delegation *delegation;
-	struct nfs_delegation *ret = NULL;
+	bool return_now = false;
 
 	if (!inode)
 		return;
@@ -802,17 +804,17 @@ void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
 	if (!delegation->inode)
 		goto out_unlock;
 	if (list_empty(&NFS_I(inode)->open_files) &&
-	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
-		/* Refcount matched in nfs_end_delegation_return() */
-		ret = nfs_get_delegation(delegation);
-	} else
+	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
+		return_now = true;
+	else
 		set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
 out_unlock:
 	spin_unlock(&delegation->lock);
-	if (ret)
+	if (return_now) {
 		nfs_clear_verifier_delegated(inode);
+		nfs_end_delegation_return(inode, delegation, 0);
+	}
 	nfs_put_delegation(delegation);
-	nfs_end_delegation_return(inode, ret, 0);
 }
 
 /**
@@ -825,7 +827,7 @@ void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
 void nfs4_inode_return_delegation_on_close(struct inode *inode)
 {
 	struct nfs_delegation *delegation;
-	struct nfs_delegation *ret = NULL;
+	bool return_now = false;
 
 	delegation = nfs4_get_valid_delegation(inode);
 	if (!delegation)
@@ -839,16 +841,16 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 		    list_empty(&NFS_I(inode)->open_files) &&
 		    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
 			clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
-			/* Refcount matched in nfs_end_delegation_return() */
-			ret = nfs_get_delegation(delegation);
+			return_now = true;
 		}
 		spin_unlock(&delegation->lock);
-		if (ret)
-			nfs_clear_verifier_delegated(inode);
 	}
 
+	if (return_now) {
+		nfs_clear_verifier_delegated(inode);
+		nfs_end_delegation_return(inode, delegation, 0);
+	}
 	nfs_put_delegation(delegation);
-	nfs_end_delegation_return(inode, ret, 0);
 }
 
 /**
-- 
2.47.3


