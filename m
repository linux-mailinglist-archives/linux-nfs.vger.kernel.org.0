Return-Path: <linux-nfs+bounces-17166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EBFCCA646
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC253074A99
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29E23F41A;
	Thu, 18 Dec 2025 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="csofhCXI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E40312834
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037477; cv=none; b=d41vof/WrBgR9UtE0pJmQ+s4rGZW9y8ZFAE4oMddzbSrHyGl/ruDUH0FzlG3ShL+70meXiZcJXBB/+I7e1+dLidq202porClNrggLvwSAKuiMq+eV/zu5ydnZyTef+9jIJSE8sTKpVlp7kXB7jcCprgGZNCm5yZBxb7im4nTOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037477; c=relaxed/simple;
	bh=jIcbmV7c1Xgyn54/+VvJc7IO6sJ0GfNOLMYBrenuB6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHzFpElln/nG/ry5LB7idqZ/I6ZMayJwLA9OZZU5ZDUdCjhMvv8ZKqRaZ6l/YYpgfu6WfBORORHjdeATLIf2LqB8rhEecMPJpXcyU5g64TbLV4uEFuQQk0VkZBdywC9quyDqb1xLcgglahAY9fLMLzjqsweZm8U81r5M/SCqiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=csofhCXI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sCUD1oZwj36PbsHrzN88R+QL9IBCrCwU3RP9qpFJQEM=; b=csofhCXI0Jo0ghm8xRBA6QsUn7
	AQdcb3zQQpKYcWjTj5zu8tjQASH7tpMed+Nri4VmdJUFdX7DcNuMGQSGsDbpDaddgVgXahnHhYG/I
	Lans6SqvSQm4BJZqVD2MqjwSUf7SQLCDzn6XU9rOrEqfxI0HhwbgkIwCiaOxAD0jVQTyQofWfkACm
	L18AxWq76uzkqDggsXVqE2asuoE1PO31L6g0G9FSwCM7tgFAcRy8uHeiNjrk/a3HZ+Z3fcHWLSMy4
	2V58kw7oagzHk1hsT8+Y8WMdl48WYIxPfOyMqffMHBrtsEIf0Y6kUNmPpwpOFqnYJxWhz+oJGzEiF
	C3z2yA4Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW71P-00000007rlp-0pKE;
	Thu, 18 Dec 2025 05:57:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 18/24] NFS: don't consume a delegation reference in nfs_end_delegation_return
Date: Thu, 18 Dec 2025 06:56:22 +0100
Message-ID: <20251218055633.1532159-19-hch@lst.de>
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


