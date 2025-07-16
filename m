Return-Path: <linux-nfs+bounces-13107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F5B076E0
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C92D3AFDF0
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CAD1A7253;
	Wed, 16 Jul 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwUfgoC0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D41A727D
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672432; cv=none; b=GV761cF+qyTyisid5sPVoqVX8VAaZ1dJupkkwjlas6Ra9LpnTt41J1aLm+SJUuAWZ+dSHjR10DVDGN+mlcRhGxcc76EOKBVF728nNOSIZ6BWTR0NEWo3wqE8+mZquOwzDrBJLW9vhkCnAMfD8aadVQwXGmCjbE5NJ4yOP3simi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672432; c=relaxed/simple;
	bh=wOZO6k0EalVJm1AcEPBUCxZmMRGURWgVSodyWmxk2sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n45u9b9XfjNQnioNUWR/BbQS2g8q7O0OY0C76HQZGNCJOeF8NY05gNyXq1qmRsRT9MMFJU2ivlXI3fg17XMuslFms/VYquyvhHpaz5bjbQPMhkXhM+JbTneYypKJ7F9q5m/2OAuqKaip1FeIeQ3FhYGXBislZy0GybNsOY0GcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZwUfgoC0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PGPOmvCM5Z5bMCTDN2GFovKb9YB1K/mQB+enZUS1PL0=; b=ZwUfgoC0m54NQkjbWdVtyj0R0v
	KVWv/pA4wCZm82Q/W5xL2yG6pRZkFntGNswcIngr6+r5l4D7nq5BO5VyS4YTMI4l6m5jldl+ag0ZO
	Zl3yfGPEjL7bIhUl3vw2+kSLtSn+e8HOw4bCSCwmQ3nfcPo/BV9+HiNxG84BMjfXV38WYFJy7ddgM
	fiZZd/x3EAfJrKC6zetr53ZLyAantgd2nwHNj+ExQgx0Gw+2KIcvGlx6x53t52vPxP65Nix64M9wn
	2i6P2WeYEoHfPhs4++mBgsG1YvUDZ1r9BF1ASvP55UCFzxzjG+UOvXRsRCXCyEhD2f5NZFtd8HLXv
	xqtN+5kw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2AA-00000007n8q-1bH5;
	Wed, 16 Jul 2025 13:27:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 3/4] NFS: track active delegations per-server
Date: Wed, 16 Jul 2025 15:26:33 +0200
Message-ID: <20250716132657.2167548-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716132657.2167548-1-hch@lst.de>
References: <20250716132657.2167548-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The active delegation watermark was added to avoid overloading servers.
Track the active delegation per-server instead of globally so that clients
talking to multiple servers aren't limited by the global limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/client.c           |  1 +
 fs/nfs/delegation.c       | 35 +++++++++++++++++++----------------
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 47258dc3af70..e13eb429b8b5 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1005,6 +1005,7 @@ struct nfs_server *nfs_alloc_server(void)
 	INIT_LIST_HEAD(&server->ss_src_copies);
 
 	atomic_set(&server->active, 0);
+	atomic_long_set(&server->nr_active_delegations, 0);
 
 	server->io_stats = nfs_alloc_iostats();
 	if (!server->io_stats) {
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5f85966d7709..ea96f77e38c2 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -27,7 +27,6 @@
 
 #define NFS_DEFAULT_DELEGATION_WATERMARK (5000U)
 
-static atomic_long_t nfs_active_delegations;
 static unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
 module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
 
@@ -38,11 +37,12 @@ static void __nfs_free_delegation(struct nfs_delegation *delegation)
 	kfree_rcu(delegation, rcu);
 }
 
-static void nfs_mark_delegation_revoked(struct nfs_delegation *delegation)
+static void nfs_mark_delegation_revoked(struct nfs_server *server,
+		struct nfs_delegation *delegation)
 {
 	if (!test_and_set_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
 		delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
-		atomic_long_dec(&nfs_active_delegations);
+		atomic_long_dec(&server->nr_active_delegations);
 		if (!test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
 			nfs_clear_verifier_delegated(delegation->inode);
 	}
@@ -60,9 +60,10 @@ static void nfs_put_delegation(struct nfs_delegation *delegation)
 		__nfs_free_delegation(delegation);
 }
 
-static void nfs_free_delegation(struct nfs_delegation *delegation)
+static void nfs_free_delegation(struct nfs_server *server,
+		struct nfs_delegation *delegation)
 {
-	nfs_mark_delegation_revoked(delegation);
+	nfs_mark_delegation_revoked(server, delegation);
 	nfs_put_delegation(delegation);
 }
 
@@ -261,7 +262,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 	}
 	clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
 	if (test_and_clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
-		atomic_long_inc(&nfs_active_delegations);
+		atomic_long_inc(&NFS_SERVER(inode)->nr_active_delegations);
 	spin_unlock(&delegation->lock);
 	rcu_read_unlock();
 	put_cred(oldcred);
@@ -413,7 +414,8 @@ nfs_update_delegation_cred(struct nfs_delegation *delegation,
 }
 
 static void
-nfs_update_inplace_delegation(struct nfs_delegation *delegation,
+nfs_update_inplace_delegation(struct nfs_server *server,
+		struct nfs_delegation *delegation,
 		const struct nfs_delegation *update)
 {
 	if (nfs4_stateid_is_newer(&update->stateid, &delegation->stateid)) {
@@ -426,7 +428,7 @@ nfs_update_inplace_delegation(struct nfs_delegation *delegation,
 			nfs_update_delegation_cred(delegation, update->cred);
 			/* smp_mb__before_atomic() is implicit due to xchg() */
 			clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
-			atomic_long_inc(&nfs_active_delegations);
+			atomic_long_inc(&server->nr_active_delegations);
 		}
 	}
 }
@@ -481,7 +483,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	if (nfs4_stateid_match_other(&old_delegation->stateid,
 				&delegation->stateid)) {
 		spin_lock(&old_delegation->lock);
-		nfs_update_inplace_delegation(old_delegation,
+		nfs_update_inplace_delegation(server, old_delegation,
 				delegation);
 		spin_unlock(&old_delegation->lock);
 		goto out;
@@ -530,7 +532,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	rcu_assign_pointer(nfsi->delegation, delegation);
 	delegation = NULL;
 
-	atomic_long_inc(&nfs_active_delegations);
+	atomic_long_inc(&server->nr_active_delegations);
 
 	trace_nfs4_set_delegation(inode, type);
 
@@ -544,7 +546,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 		__nfs_free_delegation(delegation);
 	if (freeme != NULL) {
 		nfs_do_return_delegation(inode, freeme, 0);
-		nfs_free_delegation(freeme);
+		nfs_free_delegation(server, freeme);
 	}
 	return status;
 }
@@ -756,7 +758,7 @@ void nfs_inode_evict_delegation(struct inode *inode)
 		set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 		nfs_do_return_delegation(inode, delegation, 1);
-		nfs_free_delegation(delegation);
+		nfs_free_delegation(NFS_SERVER(inode), delegation);
 	}
 }
 
@@ -842,7 +844,8 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 	if (!delegation)
 		goto out;
 	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags) ||
-	    atomic_long_read(&nfs_active_delegations) >= nfs_delegation_watermark) {
+	    atomic_long_read(&NFS_SERVER(inode)->nr_active_delegations) >=
+	    nfs_delegation_watermark) {
 		spin_lock(&delegation->lock);
 		if (delegation->inode &&
 		    list_empty(&NFS_I(inode)->open_files) &&
@@ -1018,7 +1021,7 @@ static void nfs_revoke_delegation(struct inode *inode,
 		}
 		spin_unlock(&delegation->lock);
 	}
-	nfs_mark_delegation_revoked(delegation);
+	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
 	ret = true;
 out:
 	rcu_read_unlock();
@@ -1050,7 +1053,7 @@ void nfs_delegation_mark_returned(struct inode *inode,
 			delegation->stateid.seqid = stateid->seqid;
 	}
 
-	nfs_mark_delegation_revoked(delegation);
+	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 	spin_unlock(&delegation->lock);
 	if (nfs_detach_delegation(NFS_I(inode), delegation, NFS_SERVER(inode)))
@@ -1270,7 +1273,7 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 		if (delegation != NULL) {
 			if (nfs_detach_delegation(NFS_I(inode), delegation,
 						server) != NULL)
-				nfs_free_delegation(delegation);
+				nfs_free_delegation(server, delegation);
 			/* Match nfs_start_delegation_return_locked */
 			nfs_put_delegation(delegation);
 		}
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d2d36711a119..a9b44f12623f 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -254,6 +254,7 @@ struct nfs_server {
 	struct list_head	state_owners_lru;
 	struct list_head	layouts;
 	struct list_head	delegations;
+	atomic_long_t		nr_active_delegations;
 	struct list_head	ss_copies;
 	struct list_head	ss_src_copies;
 
-- 
2.47.2


