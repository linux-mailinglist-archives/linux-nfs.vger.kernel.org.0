Return-Path: <linux-nfs+bounces-17165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56118CCA63D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41747306FB2C
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8363128D2;
	Thu, 18 Dec 2025 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="5CX76OtG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0B23F41A
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037472; cv=none; b=nONjA33CeN79JL7zOn56pZFxcLr5gFMUXEcUdaZlwe1r/ZmqurBQ0FFD27rtGRKDkEF5aZEyM4r2P0n7eI1+xJqVeVRjOKEq2jYPlx3lOS+4wYs/kRyEG4y/7F/XmSf/6ZieFa8VZQziGd5AfGYfD2L/tJCEwgZzxYkSK9+NYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037472; c=relaxed/simple;
	bh=9/7SiKVh0nNtutkrmMtXzyH9we8jQJSaDvAudGcn42Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNwGvYF4PFRupD0WR+cA1MnBMnJLN6zHKgLFkq67zf9Oo/yZ+m9X6uzpydp5D5sHqhL48uUmKGbNFbNr/y+/EASpKjisT4FS3rk3fXHF2AkMdx/2Ke1cTFDCVMoM5ignfSS5IHFFJVKccaVl93w/uflQfe5sUgeGmGMUVIBumqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=5CX76OtG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rQ0OVkNdq1G8sxE8E6r9UsdWbyFBfbm5QxksC2hNZEA=; b=5CX76OtGDCnb/hnv7RT4eNpru2
	I64hUTZjcfV07go+KJ4rnv8bPY0Og51NadfeMWQKtCu54rah/piTeb0KZGDVj24w65d/lNNSOyGr2
	umnqcp2zCqATge7xe5rKlXHbjjz+orYmKywlXFzIiY4JdOD2hQEaPXNUPrC87TkXeQmJPCthdJ2p/
	IyBBxst/ZxXP+Q1b7xMAsOH7XHVlFwNjfRjIbK2x46UunA4JzxfDxsH569kMu/ySOut8yClinRkNw
	mXhXoGp7GtUuzudpEDJxBVoCgeBUzO52RwN/KMaihbu8V/diij8bAcjGIcXjAt9HqmBPluCyOtyt5
	VpJbuuxA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW71K-00000007rlB-0lCY;
	Thu, 18 Dec 2025 05:57:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 17/24] NFS: take a delegation reference in nfs4_get_valid_delegation
Date: Thu, 18 Dec 2025 06:56:21 +0100
Message-ID: <20251218055633.1532159-18-hch@lst.de>
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

Currently most work on struct nfs_delegation happens directly under RCU
protection.  This is generally fine, despite that long RCU sections are
not good for performance.  But for operations later taking a reference
to the delegation to perform blocking work, refcount_inc is used, which
can be racy against dropping the last reference and thus lead to use
after frees in extremely rare cases.

Fix this by taking a reference in nfs4_get_valid_delegation using
refcount_inc_not_zero so that the callers have a stabilized reference
they can work with and can be moved outside the RCU critical section.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/callback_proc.c | 13 ++++++---
 fs/nfs/delegation.c    | 62 ++++++++++++++++++++++--------------------
 fs/nfs/delegation.h    |  1 +
 fs/nfs/nfs4proc.c      | 26 +++++++++---------
 4 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 8397c43358bd..57550020c819 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -51,12 +51,18 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 				-ntohl(res->status));
 		goto out;
 	}
-	rcu_read_lock();
+
 	delegation = nfs4_get_valid_delegation(inode);
-	if (delegation == NULL || (delegation->type & FMODE_WRITE) == 0)
+	if (!delegation)
 		goto out_iput;
-	res->size = i_size_read(inode);
+	if ((delegation->type & FMODE_WRITE) == 0) {
+		nfs_put_delegation(delegation);
+		goto out_iput;
+	}
 	res->change_attr = delegation->change_attr;
+	nfs_put_delegation(delegation);
+
+	res->size = i_size_read(inode);
 	if (nfs_have_writebacks(inode))
 		res->change_attr++;
 	res->atime = inode_get_atime(inode);
@@ -71,7 +77,6 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 			  FATTR4_WORD2_TIME_DELEG_MODIFY) & args->bitmap[2];
 	res->status = 0;
 out_iput:
-	rcu_read_unlock();
 	trace_nfs4_cb_getattr(cps->clp, &args->fh, inode, -ntohl(res->status));
 	nfs_iput_and_deactive(inode);
 out:
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index f7d5622c625a..811e84b559ee 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -66,7 +66,7 @@ static struct nfs_delegation *nfs_get_delegation(struct nfs_delegation *delegati
 	return delegation;
 }
 
-static void nfs_put_delegation(struct nfs_delegation *delegation)
+void nfs_put_delegation(struct nfs_delegation *delegation)
 {
 	if (refcount_dec_and_test(&delegation->refcount))
 		__nfs_free_delegation(delegation);
@@ -104,10 +104,14 @@ struct nfs_delegation *nfs4_get_valid_delegation(const struct inode *inode)
 {
 	struct nfs_delegation *delegation;
 
+	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
-	if (nfs4_is_valid_delegation(delegation, 0))
-		return delegation;
-	return NULL;
+	if (!nfs4_is_valid_delegation(delegation, 0) ||
+	    !refcount_inc_not_zero(&delegation->refcount))
+		delegation = NULL;
+	rcu_read_unlock();
+
+	return delegation;
 }
 
 static int nfs4_do_check_delegation(struct inode *inode, fmode_t type,
@@ -789,10 +793,11 @@ void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
 
 	if (!inode)
 		return;
-	rcu_read_lock();
+
 	delegation = nfs4_get_valid_delegation(inode);
 	if (!delegation)
-		goto out;
+		return;
+
 	spin_lock(&delegation->lock);
 	if (!delegation->inode)
 		goto out_unlock;
@@ -806,8 +811,7 @@ void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
 	spin_unlock(&delegation->lock);
 	if (ret)
 		nfs_clear_verifier_delegated(inode);
-out:
-	rcu_read_unlock();
+	nfs_put_delegation(delegation);
 	nfs_end_delegation_return(inode, ret, 0);
 }
 
@@ -823,10 +827,10 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 	struct nfs_delegation *delegation;
 	struct nfs_delegation *ret = NULL;
 
-	rcu_read_lock();
 	delegation = nfs4_get_valid_delegation(inode);
 	if (!delegation)
-		goto out;
+		return;
+
 	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags) ||
 	    atomic_long_read(&NFS_SERVER(inode)->nr_active_delegations) >=
 	    nfs_delegation_watermark) {
@@ -842,8 +846,8 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 		if (ret)
 			nfs_clear_verifier_delegated(inode);
 	}
-out:
-	rcu_read_unlock();
+
+	nfs_put_delegation(delegation);
 	nfs_end_delegation_return(inode, ret, 0);
 }
 
@@ -858,17 +862,17 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 int nfs4_inode_make_writeable(struct inode *inode)
 {
 	struct nfs_delegation *delegation;
+	int error = 0;
 
-	rcu_read_lock();
 	delegation = nfs4_get_valid_delegation(inode);
-	if (delegation == NULL ||
-	    (nfs4_has_session(NFS_SERVER(inode)->nfs_client) &&
-	     (delegation->type & FMODE_WRITE))) {
-		rcu_read_unlock();
+	if (!delegation)
 		return 0;
-	}
-	rcu_read_unlock();
-	return nfs4_inode_return_delegation(inode);
+
+	if (!nfs4_has_session(NFS_SERVER(inode)->nfs_client) ||
+	    !(delegation->type & FMODE_WRITE))
+		error = nfs4_inode_return_delegation(inode);
+	nfs_put_delegation(delegation);
+	return error;
 }
 
 static void
@@ -1111,24 +1115,24 @@ int nfs_async_inode_return_delegation(struct inode *inode,
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs_delegation *delegation;
 
-	rcu_read_lock();
 	delegation = nfs4_get_valid_delegation(inode);
-	if (delegation == NULL)
-		goto out_enoent;
+	if (!delegation)
+		return -ENOENT;
+
 	if (stateid != NULL &&
-	    !clp->cl_mvops->match_stateid(&delegation->stateid, stateid))
-		goto out_enoent;
+	    !clp->cl_mvops->match_stateid(&delegation->stateid, stateid)) {
+		nfs_put_delegation(delegation);
+		return -ENOENT;
+	}
+
 	nfs_mark_return_delegation(server, delegation);
-	rcu_read_unlock();
+	nfs_put_delegation(delegation);
 
 	/* If there are any application leases or delegations, recall them */
 	break_lease(inode, O_WRONLY | O_RDWR | O_NONBLOCK);
 
 	nfs_delegation_run_state_manager(clp);
 	return 0;
-out_enoent:
-	rcu_read_unlock();
-	return -ENOENT;
 }
 
 static struct inode *
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index fef1f4126e8f..d1c5da3e66ea 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -80,6 +80,7 @@ bool nfs4_copy_delegation_stateid(struct inode *inode, fmode_t flags, nfs4_state
 bool nfs4_refresh_delegation_stateid(nfs4_stateid *dst, struct inode *inode);
 
 struct nfs_delegation *nfs4_get_valid_delegation(const struct inode *inode);
+void nfs_put_delegation(struct nfs_delegation *delegation);
 void nfs_mark_delegation_referenced(struct nfs_delegation *delegation);
 int nfs4_have_delegation(struct inode *inode, fmode_t type, int flags);
 int nfs4_check_delegation(struct inode *inode, fmode_t type);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 03b1f98eb989..2b28f56d8544 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1615,10 +1615,11 @@ static bool can_open_delegated(const struct inode *inode, fmode_t fmode,
 	struct nfs_delegation *delegation;
 	bool ret = false;
 
-	rcu_read_lock();
 	delegation = nfs4_get_valid_delegation(inode);
-	if (!delegation || (delegation->type & fmode) != fmode)
-		goto out_unlock;
+	if (!delegation)
+		return false;
+	if ((delegation->type & fmode) != fmode)
+		goto out_put_delegation;
 
 	switch (claim) {
 	case NFS4_OPEN_CLAIM_PREVIOUS:
@@ -1637,8 +1638,8 @@ static bool can_open_delegated(const struct inode *inode, fmode_t fmode,
 		break;
 	}
 
-out_unlock:
-	rcu_read_unlock();
+out_put_delegation:
+	nfs_put_delegation(delegation);
 	return ret;
 }
 
@@ -1913,10 +1914,11 @@ int update_open_stateid(struct nfs4_state *state,
 
 	fmode &= (FMODE_READ|FMODE_WRITE);
 
-	rcu_read_lock();
 	spin_lock(&state->owner->so_lock);
 	if (open_stateid != NULL) {
+		rcu_read_lock();
 		nfs_state_set_open_stateid(state, open_stateid, fmode, &freeme);
+		rcu_read_unlock();
 		ret = 1;
 	}
 
@@ -1940,11 +1942,11 @@ int update_open_stateid(struct nfs4_state *state,
 	ret = 1;
 no_delegation_unlock:
 	spin_unlock(&deleg_cur->lock);
+	nfs_put_delegation(deleg_cur);
 no_delegation:
 	if (ret)
 		update_open_stateflags(state, fmode);
 	spin_unlock(&state->owner->so_lock);
-	rcu_read_unlock();
 
 	if (test_bit(NFS_STATE_RECLAIM_NOGRACE, &state->flags))
 		nfs4_schedule_state_manager(clp);
@@ -1978,14 +1980,12 @@ static void nfs4_return_incompatible_delegation(struct inode *inode, fmode_t fmo
 	struct nfs_delegation *delegation;
 
 	fmode &= FMODE_READ|FMODE_WRITE;
-	rcu_read_lock();
 	delegation = nfs4_get_valid_delegation(inode);
-	if (delegation == NULL || (delegation->type & fmode) == fmode) {
-		rcu_read_unlock();
+	if (!delegation)
 		return;
-	}
-	rcu_read_unlock();
-	nfs4_inode_return_delegation(inode);
+	if ((delegation->type & fmode) != fmode)
+		nfs4_inode_return_delegation(inode);
+	nfs_put_delegation(delegation);
 }
 
 static struct nfs4_state *nfs4_try_open_cached(struct nfs4_opendata *opendata)
-- 
2.47.3


