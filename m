Return-Path: <linux-nfs+bounces-18557-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id at1iEu+UeWmyxgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18557-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D39D16B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7847130086C2
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD832264A8;
	Wed, 28 Jan 2026 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xMPVHiPR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68DF285C80
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575660; cv=none; b=U3DRIwQkc5LIrRcaU4tJPYFPuZmShAxIdfJ48rkm4Y2UwITAwJfphFLqfD5YcFe+/+GcuQ6/L845TVUOXUtCEYD1Uv6PrT1it3sPRtBMHwpqcTxpsWYcBSzc9ye29qMRaMxPVQjGaY2fJPAcVtrXZwiOIdX+uezorNvd4cQhLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575660; c=relaxed/simple;
	bh=qc2OcNG1sPc6ZPte8wo53riOzoyW1PjbEIXAt5fFzn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRSdIYpVthtDX+lRZXaHPZOUxdAWcYWPAqQVuYUoUojeZuhT9U51X7hccg57JQNEU84JJJbX53TZTHyTCFkSCndOpVMzQwrQW2k0E304ge4foqcUw1Ia+ygGdjw3lmkMDv3Vrf7RcWykIebXG7lYGzkPAWg4ltVaWycheXhI8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xMPVHiPR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8YL0gJNuG+urciRbxiD437LTQNDvTPwjKzUaVOiCkH8=; b=xMPVHiPRhNz322oWXEop45e85o
	ggE0oV/lyY+pQm0BPXW/j4yxKYDg/BHdbAYyhGLY0Vm6jXSOhT48rMzgebWS7Glm2oCxIS+oD0/d9
	ILMCGjzYsbaBrvqCL04FAWxevCBlZFCSthUakoAaR7JLDpCq27Lz6XrrgGireihkJhlAypJMMVD8U
	fsao6+L8yT6Ng/8is4SyXifEYcSfsZAlngOojm2uyVBoZRNr3M/ZbxdXbJNZXqOm7f5aHyYx///Dr
	wnDPZhzwZ7EY5fzlFj5BAnsx8eYjJ6orgGRUDRosbhT/76F1vK1q7cWXACF918vWwbZqstFdcuwPf
	tfwqi5kQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxSr-0000000FRIf-38CG;
	Wed, 28 Jan 2026 04:47:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] NFS: fix delayed delegation return handling
Date: Wed, 28 Jan 2026 05:46:09 +0100
Message-ID: <20260128044706.556046-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128044706.556046-1-hch@lst.de>
References: <20260128044706.556046-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18557-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: BC4D39D16B
X-Rspamd-Action: no action

Rework this code that was totally busted at least as of my most
recent changes.  Introduce a separate list for delayed delegations
so that they can't get lost and don't clutter up the returns list.
Add a missing spin_unlock in the helper marking it as a regular
pending return.

Fixes: 0ebe655bd033 ("NFS: add a separate delegation return list")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/client.c           |  1 +
 fs/nfs/delegation.c       | 30 ++++++++++++------------------
 fs/nfs/delegation.h       |  1 -
 fs/nfs/nfs4trace.h        |  3 +--
 include/linux/nfs_fs_sb.h |  2 +-
 5 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 62aece00f810..4c0bba1488cc 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1063,6 +1063,7 @@ struct nfs_server *nfs_alloc_server(void)
 	spin_lock_init(&server->delegations_lock);
 	INIT_LIST_HEAD(&server->delegations_return);
 	INIT_LIST_HEAD(&server->delegations_lru);
+	INIT_LIST_HEAD(&server->delegations_delayed);
 	INIT_LIST_HEAD(&server->layouts);
 	INIT_LIST_HEAD(&server->state_owners_lru);
 	INIT_LIST_HEAD(&server->ss_copies);
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cff49a934c9e..94103f8d3f21 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -336,10 +336,8 @@ nfs_start_delegation_return(struct nfs_inode *nfsi)
 
 	spin_lock(&delegation->lock);
 	if (delegation->inode &&
-	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
-		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
+	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
 		return_now = true;
-	}
 	spin_unlock(&delegation->lock);
 
 	if (!return_now) {
@@ -586,8 +584,11 @@ static int nfs_end_delegation_return(struct inode *inode,
 out_return:
 	return nfs_do_return_delegation(inode, delegation, issync);
 delay:
-	set_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
-	set_bit(NFS4SERV_DELEGRETURN_DELAYED, &server->delegation_flags);
+	spin_lock(&server->delegations_lock);
+	if (list_empty(&delegation->entry))
+		refcount_inc(&delegation->refcount);
+	list_move_tail(&delegation->entry, &server->delegations_return);
+	spin_unlock(&server->delegations_lock);
 	set_bit(NFS4CLNT_DELEGRETURN_DELAYED, &server->nfs_client->cl_state);
 abort:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
@@ -616,22 +617,16 @@ static int nfs_return_one_delegation(struct nfs_server *server)
 		spin_unlock(&delegation->lock);
 		goto out_put_delegation;
 	}
-	if (test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
-	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) ||
+	if (test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) ||
 	    test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
 		spin_unlock(&delegation->lock);
 		goto out_put_inode;
 	}
-	clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
 	spin_unlock(&delegation->lock);
 
 	nfs_clear_verifier_delegated(inode);
 
 	err = nfs_end_delegation_return(inode, delegation, false);
-	if (err) {
-		nfs_mark_return_delegation(server, delegation);
-		goto out_put_inode;
-	}
 
 out_put_inode:
 	iput(inode);
@@ -708,19 +703,18 @@ static void nfs_delegation_add_lru(struct nfs_server *server,
 
 static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
 {
-	struct nfs_delegation *d;
 	bool ret = false;
 
-	if (!test_and_clear_bit(NFS4SERV_DELEGRETURN_DELAYED,
-				&server->delegation_flags))
+	if (list_empty_careful(&server->delegations_delayed))
 		return false;
 
 	spin_lock(&server->delegations_lock);
-	list_for_each_entry_rcu(d, &server->delegations_return, entry) {
-		if (test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
-			clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
+	if (!list_empty(&server->delegations_delayed)) {
+		list_splice_tail_init(&server->delegations_delayed,
+				      &server->delegations_return);
 		ret = true;
 	}
+	spin_unlock(&server->delegations_lock);
 
 	return ret;
 }
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index eda39fcb032b..fba4699952b8 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -37,7 +37,6 @@ enum {
 	NFS_DELEGATION_RETURNING,
 	NFS_DELEGATION_REVOKED,
 	NFS_DELEGATION_TEST_EXPIRED,
-	NFS_DELEGATION_RETURN_DELAYED,
 	NFS_DELEGATION_DELEGTIME,
 };
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 8ff6396bc206..bf44aabb844c 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -994,8 +994,7 @@ DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_detach_delegation);
 		{ BIT(NFS_DELEGATION_REFERENCED), "REFERENCED" }, \
 		{ BIT(NFS_DELEGATION_RETURNING), "RETURNING" }, \
 		{ BIT(NFS_DELEGATION_REVOKED), "REVOKED" }, \
-		{ BIT(NFS_DELEGATION_TEST_EXPIRED), "TEST_EXPIRED" }, \
-		{ BIT(NFS_DELEGATION_RETURN_DELAYED), "RETURN_DELAYED" })
+		{ BIT(NFS_DELEGATION_TEST_EXPIRED), "TEST_EXPIRED" })
 
 DECLARE_EVENT_CLASS(nfs4_delegation_event,
 		TP_PROTO(
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index bb13a294b69e..cfda0ff0174d 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -262,6 +262,7 @@ struct nfs_server {
 	spinlock_t		delegations_lock;
 	struct list_head	delegations_return;
 	struct list_head	delegations_lru;
+	struct list_head	delegations_delayed;
 	atomic_long_t		nr_active_delegations;
 	unsigned int		delegation_hash_mask;
 	struct hlist_head	*delegation_hash_table;
@@ -270,7 +271,6 @@ struct nfs_server {
 
 	unsigned long		delegation_flags;
 #define NFS4SERV_DELEGATION_EXPIRED	(1)
-#define NFS4SERV_DELEGRETURN_DELAYED	(2)
 	unsigned long		delegation_gen;
 	unsigned long		mig_gen;
 	unsigned long		mig_status;
-- 
2.47.3


