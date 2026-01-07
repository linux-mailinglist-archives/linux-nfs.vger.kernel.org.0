Return-Path: <linux-nfs+bounces-17544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AC4CFC5F4
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1BD930478D8
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D414284671;
	Wed,  7 Jan 2026 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kuPKjpZW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0528641F
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770930; cv=none; b=PeS94qgko1aLrn0c3971Uc8/3hh/k5P+XO/c9UhuaQle6ELO1DmJ4nNlnoyHP2gtNwJFgB5RZCahLhOeH8aQVcTHAUiJUg7NqHL6Gb4of3pW5acQYu95PHXliFpaXYgC4tqXn+FTuk9FcuKTD+iaKv+W6Cgr3gfnH7P5iWJZbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770930; c=relaxed/simple;
	bh=zrqSjlYNzQC7IRsKZiVQKiF/go76LYWCn3g1bC5A8uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsRu2npxWzZQbqIro0vJLew1eeSdRhB3Smk5QcIbRd8JeSIyRzikwNV/bTgi8QACcWGI9S6CCWZLRLWwdisnZojCKc4mCEA968GJ9PmkVR2FBlUCl9dLsZNjH6PSGTqR3Ta0rpoQvp5iOelA9qe9TANC8zsx2nx3ziWyctgJRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kuPKjpZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=W46HhDlQRfk5/kt8U6Vxd0q2+Wy5/1LP5DH+8BjOP0s=; b=kuPKjpZWQd7F1Y02dNP40sl4xy
	frzc9TGJxW+PqQVooB5CjrjBASN3HSTNk4SCwZQw+ARNmQtg94oVg0egElU944K+if7cNuxNPBDEh
	9mOWfsMOiqgSvfGFtMHB5Zs8Az0DorVAaKRSLV8RrV5a0wNZPzoSzCPKD93jPvyHSA7uXh64zt734
	IQ2mjpPWRZ9xEfQbZVaKPApTPZzClcafiuFwzIs4cmeLrbbfGkrysk4WBGHBp6Ebcnp2I20l/SjB7
	AU+mA60uUos/AnAX2zwiGoNTafYVI8pAPQCMWXeqdhx6dFo57bHIZJMWkX+wP71Vc10BMvwXJXvDt
	uL6NfDIQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNyI-0000000EHti-06FA;
	Wed, 07 Jan 2026 07:28:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 22/24] NFS: add a separate delegation return list
Date: Wed,  7 Jan 2026 08:27:13 +0100
Message-ID: <20260107072720.1744129-23-hch@lst.de>
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

Searching for returnable delegations in the per-server delegations list
can be very expensive.  While commit e04bbf6b1bbe ("NFS: Avoid quadratic
search when freeing delegations.") reduced the overhead a bit, the
fact that all the non-returnable delegations have to be searched limits
the amount of optimizations that can be done.

Fix this by introducing a separate list that only contains delegations
scheduled for return.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/client.c           |   2 +
 fs/nfs/delegation.c       | 160 +++++++++++++++++++-------------------
 fs/nfs/delegation.h       |   2 +-
 fs/nfs/nfs4trace.h        |   1 -
 include/linux/nfs_fs_sb.h |   7 +-
 5 files changed, 85 insertions(+), 87 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 2aaea9c98c2c..65b3de91b441 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1060,6 +1060,8 @@ struct nfs_server *nfs_alloc_server(void)
 	INIT_LIST_HEAD(&server->client_link);
 	INIT_LIST_HEAD(&server->master_link);
 	INIT_LIST_HEAD(&server->delegations);
+	spin_lock_init(&server->delegations_lock);
+	INIT_LIST_HEAD(&server->delegations_return);
 	INIT_LIST_HEAD(&server->layouts);
 	INIT_LIST_HEAD(&server->state_owners_lru);
 	INIT_LIST_HEAD(&server->ss_copies);
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index f46799448a0a..f0540c9843b3 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -52,6 +52,8 @@ static void __nfs_free_delegation(struct nfs_delegation *delegation)
 static void nfs_mark_delegation_revoked(struct nfs_server *server,
 		struct nfs_delegation *delegation)
 {
+	bool put_ref = false;
+
 	if (test_and_set_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
 		return;
 
@@ -59,6 +61,16 @@ static void nfs_mark_delegation_revoked(struct nfs_server *server,
 	atomic_long_dec(&server->nr_active_delegations);
 	if (!test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
 		nfs_clear_verifier_delegated(delegation->inode);
+
+	spin_lock(&server->delegations_lock);
+	if (!list_empty(&delegation->entry)) {
+		list_del_init(&delegation->entry);
+		put_ref = true;
+	}
+	spin_unlock(&server->delegations_lock);
+
+	if (put_ref)
+		nfs_put_delegation(delegation);
 }
 
 void nfs_put_delegation(struct nfs_delegation *delegation)
@@ -80,8 +92,12 @@ void nfs_mark_delegation_referenced(struct nfs_delegation *delegation)
 static void nfs_mark_return_delegation(struct nfs_server *server,
 				       struct nfs_delegation *delegation)
 {
-	set_bit(NFS_DELEGATION_RETURN, &delegation->flags);
-	set_bit(NFS4SERV_DELEGRETURN, &server->delegation_flags);
+	spin_lock(&server->delegations_lock);
+	if (list_empty(&delegation->entry))
+		refcount_inc(&delegation->refcount);
+	list_move_tail(&delegation->entry, &server->delegations_return);
+	spin_unlock(&server->delegations_lock);
+
 	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
 }
 
@@ -350,7 +366,7 @@ static void nfs_abort_delegation_return(struct nfs_delegation *delegation,
 }
 
 static bool
-nfs_detach_delegation_locked(struct nfs_inode *nfsi,
+nfs_detach_delegations_locked(struct nfs_inode *nfsi,
 		struct nfs_delegation *delegation,
 		struct nfs_client *clp)
 {
@@ -384,7 +400,7 @@ static bool nfs_detach_delegation(struct nfs_inode *nfsi,
 	deleg_cur = rcu_dereference_protected(nfsi->delegation,
 				lockdep_is_held(&clp->cl_lock));
 	if (delegation == deleg_cur)
-		ret = nfs_detach_delegation_locked(nfsi, delegation, clp);
+		ret = nfs_detach_delegations_locked(nfsi, delegation, clp);
 	spin_unlock(&clp->cl_lock);
 	return ret;
 }
@@ -454,6 +470,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	delegation->cred = get_cred(cred);
 	delegation->inode = inode;
 	delegation->flags = 1<<NFS_DELEGATION_REFERENCED;
+	INIT_LIST_HEAD(&delegation->entry);
 	switch (deleg_type) {
 	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
 	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
@@ -496,7 +513,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 					&old_delegation->flags))
 			goto out;
 	}
-	if (!nfs_detach_delegation_locked(nfsi, old_delegation, clp))
+	if (!nfs_detach_delegations_locked(nfsi, old_delegation, clp))
 		goto out;
 	freeme = old_delegation;
 add_new:
@@ -580,85 +597,61 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 	return nfs_do_return_delegation(inode, delegation, issync);
 }
 
-static int nfs_server_return_marked_delegations(struct nfs_server *server,
-		void __always_unused *data)
+static int nfs_return_one_delegation(struct nfs_server *server)
 {
 	struct nfs_delegation *delegation;
-	struct nfs_delegation *prev;
 	struct inode *inode;
-	struct inode *place_holder = NULL;
-	struct nfs_delegation *place_holder_deleg = NULL;
 	int err = 0;
 
-	if (!test_and_clear_bit(NFS4SERV_DELEGRETURN,
-				&server->delegation_flags))
-		return 0;
-restart:
-	/*
-	 * To avoid quadratic looping we hold a reference
-	 * to an inode place_holder.  Each time we restart, we
-	 * list delegation in the server from the delegations
-	 * of that inode.
-	 * prev is an RCU-protected pointer to a delegation which
-	 * wasn't marked for return and might be a good choice for
-	 * the next place_holder.
-	 */
-	prev = NULL;
-	delegation = NULL;
-	rcu_read_lock();
-	if (place_holder)
-		delegation = rcu_dereference(NFS_I(place_holder)->delegation);
-	if (!delegation || delegation != place_holder_deleg)
-		delegation = list_entry_rcu(server->delegations.next,
-					    struct nfs_delegation, super_list);
-	list_for_each_entry_from_rcu(delegation, &server->delegations, super_list) {
-		struct inode *to_put = NULL;
-
-		trace_nfs_delegation_need_return(delegation);
-
-		if (!test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags) ||
-		    test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
-		    test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
-		    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
-			if (nfs4_is_valid_delegation(delegation, 0))
-				prev = delegation;
-			continue;
-		}
+	spin_lock(&server->delegations_lock);
+	delegation = list_first_entry_or_null(&server->delegations_return,
+			struct nfs_delegation, entry);
+	if (!delegation) {
+		spin_unlock(&server->delegations_lock);
+		return 0; /* no more delegations */
+	}
+	list_del_init(&delegation->entry);
+	spin_unlock(&server->delegations_lock);
 
-		inode = nfs_delegation_grab_inode(delegation);
-		if (inode == NULL)
-			continue;
+	spin_lock(&delegation->lock);
+	inode = delegation->inode;
+	if (!inode || !igrab(inode)) {
+		spin_unlock(&delegation->lock);
+		goto out_put_delegation;
+	}
+	if (test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
+	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) ||
+	    test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
+		spin_unlock(&delegation->lock);
+		goto out_put_inode;
+	}
+	clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
+	spin_unlock(&delegation->lock);
 
-		if (prev) {
-			struct inode *tmp = nfs_delegation_grab_inode(prev);
-			if (tmp) {
-				to_put = place_holder;
-				place_holder = tmp;
-				place_holder_deleg = prev;
-			}
-		}
+	nfs_clear_verifier_delegated(inode);
 
-		delegation = nfs_start_delegation_return(NFS_I(inode));
-		rcu_read_unlock();
+	err = nfs_end_delegation_return(inode, delegation, 0);
+	if (err) {
+		nfs_mark_return_delegation(server, delegation);
+		goto out_put_inode;
+	}
 
-		iput(to_put);
+out_put_inode:
+	iput(inode);
+out_put_delegation:
+	nfs_put_delegation(delegation);
+	if (err)
+		return err;
+	return 1; /* keep going */
+}
 
-		if (delegation) {
-			err = nfs_end_delegation_return(inode, delegation, 0);
-			nfs_put_delegation(delegation);
-		}
+static int nfs_server_return_marked_delegations(struct nfs_server *server,
+		void __always_unused *data)
+{
+	int err;
 
-		iput(inode);
+	while ((err = nfs_return_one_delegation(server)) > 0)
 		cond_resched();
-		if (!err)
-			goto restart;
-		set_bit(NFS4SERV_DELEGRETURN, &server->delegation_flags);
-		set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
-		goto out;
-	}
-	rcu_read_unlock();
-out:
-	iput(place_holder);
 	return err;
 }
 
@@ -669,15 +662,15 @@ static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
 
 	if (!test_and_clear_bit(NFS4SERV_DELEGRETURN_DELAYED,
 				&server->delegation_flags))
-		goto out;
-	list_for_each_entry_rcu (d, &server->delegations, super_list) {
-		if (!test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
-			continue;
-		nfs_mark_return_delegation(server, d);
-		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
+		return false;
+
+	spin_lock(&server->delegations_lock);
+	list_for_each_entry_rcu(d, &server->delegations_return, entry) {
+		if (test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
+			clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
 		ret = true;
 	}
-out:
+
 	return ret;
 }
 
@@ -687,14 +680,17 @@ static bool nfs_client_clear_delayed_delegations(struct nfs_client *clp)
 	bool ret = false;
 
 	if (!test_and_clear_bit(NFS4CLNT_DELEGRETURN_DELAYED, &clp->cl_state))
-		goto out;
+		return false;
+
 	rcu_read_lock();
 	list_for_each_entry_rcu (server, &clp->cl_superblocks, client_link) {
 		if (nfs_server_clear_delayed_delegations(server))
 			ret = true;
 	}
 	rcu_read_unlock();
-out:
+
+	if (ret)
+		set_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state);
 	return ret;
 }
 
@@ -881,7 +877,7 @@ nfs_mark_return_if_closed_delegation(struct nfs_server *server,
 {
 	struct inode *inode;
 
-	if (test_bit(NFS_DELEGATION_RETURN, &delegation->flags) ||
+	if (!list_empty_careful(&server->delegations_return) ||
 	    test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags))
 		return;
 	spin_lock(&delegation->lock);
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index d1c5da3e66ea..a6733f034442 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -26,12 +26,12 @@ struct nfs_delegation {
 	unsigned long flags;
 	refcount_t refcount;
 	spinlock_t lock;
+	struct list_head entry;
 	struct rcu_head rcu;
 };
 
 enum {
 	NFS_DELEGATION_NEED_RECLAIM = 0,
-	NFS_DELEGATION_RETURN,
 	NFS_DELEGATION_RETURN_IF_CLOSED,
 	NFS_DELEGATION_REFERENCED,
 	NFS_DELEGATION_RETURNING,
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 18d02b4715bb..8ff6396bc206 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -990,7 +990,6 @@ DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_detach_delegation);
 #define show_delegation_flags(flags) \
 	__print_flags(flags, "|", \
 		{ BIT(NFS_DELEGATION_NEED_RECLAIM), "NEED_RECLAIM" }, \
-		{ BIT(NFS_DELEGATION_RETURN), "RETURN" }, \
 		{ BIT(NFS_DELEGATION_RETURN_IF_CLOSED), "RETURN_IF_CLOSED" }, \
 		{ BIT(NFS_DELEGATION_REFERENCED), "REFERENCED" }, \
 		{ BIT(NFS_DELEGATION_RETURNING), "RETURNING" }, \
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index c58b870f31ee..e377b8c7086e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -259,6 +259,8 @@ struct nfs_server {
 	struct list_head	state_owners_lru;
 	struct list_head	layouts;
 	struct list_head	delegations;
+	spinlock_t		delegations_lock;
+	struct list_head	delegations_return;
 	atomic_long_t		nr_active_delegations;
 	unsigned int		delegation_hash_mask;
 	struct hlist_head	*delegation_hash_table;
@@ -266,9 +268,8 @@ struct nfs_server {
 	struct list_head	ss_src_copies;
 
 	unsigned long		delegation_flags;
-#define NFS4SERV_DELEGRETURN		(1)
-#define NFS4SERV_DELEGATION_EXPIRED	(2)
-#define NFS4SERV_DELEGRETURN_DELAYED	(3)
+#define NFS4SERV_DELEGATION_EXPIRED	(1)
+#define NFS4SERV_DELEGRETURN_DELAYED	(2)
 	unsigned long		delegation_gen;
 	unsigned long		mig_gen;
 	unsigned long		mig_status;
-- 
2.47.3


