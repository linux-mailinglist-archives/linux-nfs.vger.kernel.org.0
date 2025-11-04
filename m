Return-Path: <linux-nfs+bounces-16007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A074C31C1E
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 16:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6AD18842A0
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE712459ED;
	Tue,  4 Nov 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKKjFsMe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5D224244
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268808; cv=none; b=PstJNdE7m8XzApttvyYY9TH+FgahChndm3Htg7ykPfwJxVdlKYpfUEeQwx1swhyxeBY7l+y6tzAMxesplVMiZ0cPk3m0AeYlKkAuTIUSHvuEpKtq9YbD+rdKson255jbQniQOHvj0OqfoVKYUo2mQceRbwXvz/8RF+gx/dax6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268808; c=relaxed/simple;
	bh=5C3lQ2SAl23LawN8+oYiPo8HtgYG5KzH4jnC29EDgBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7rhBqyC49Q08d2aJNeBPtHkbbX7ZTBNDu2C3dP8iubfPN7nykv96ubRABdtd3csQwL6nIUUCKzL0UfqCdS4Ui2xzn3pIPw6MP7/8ISJV3EFtWnD/0ZomY+PD+pzIxWGW1NdAhrfJ01KPFVFu3YGvye9splynLxxsyaZdj4XMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKKjFsMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6474CC16AAE;
	Tue,  4 Nov 2025 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268808;
	bh=5C3lQ2SAl23LawN8+oYiPo8HtgYG5KzH4jnC29EDgBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKKjFsMezv06ay1wV2FA8uCaetElmth309sHsgmfw7taB1LwuwbJTcK56Cd2pCyvE
	 ++TTRP37M3o3GcZ5UGoIyZCEqjvMWR1ZSWVcynj7xzn+TmeFAWlr6vvTgrZRWo5BBh
	 dmocjv8rDliFrfw1ulEmHPkljHPy7R8B4mDNwYkNPjxrzCOxO3sLUM9h8RR3Kr1kQm
	 NkIT6caLvKIf8tPpUe9rdH6cFmaNn+MXFwMTK+pcg2AWHe08HGTOXSuSZ60oQn6dkT
	 RmS0+TvFJmLZ1HjlOk5hv2dVohysBJwBFZFSHIyWEVw44nsnJ3Tju1AuoFDE9foHCb
	 uf37RxGTjpNCw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 4/5] NFS: Shortcut lookup revalidations if we have a directory delegation
Date: Tue,  4 Nov 2025 10:06:44 -0500
Message-ID: <20251104150645.719865-5-anna@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104150645.719865-1-anna@kernel.org>
References: <20251104150645.719865-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Holding a directory delegation means we know that nobody else has
modified the directory on the server, so we can take a few revalidation
shortcuts.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/delegation.h |  5 +++++
 fs/nfs/dir.c        | 19 +++++++++++++++++++
 fs/nfs/inode.c      |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index def50e8a83bf..8968f62bf438 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -130,6 +130,11 @@ static inline void nfs_request_directory_delegation(struct inode *inode)
 		set_bit(NFS_INO_REQ_DIR_DELEG, &NFS_I(inode)->flags);
 }
 
+static inline bool nfs_have_directory_delegation(struct inode *inode)
+{
+	return S_ISDIR(inode->i_mode) && nfs_have_delegated_attributes(inode);
+}
+
 int nfs4_delegation_hash_alloc(struct nfs_server *server);
 
 #endif
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ea9f6ca8f30f..2cc784ae0581 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1514,6 +1514,15 @@ static int nfs_check_verifier(struct inode *dir, struct dentry *dentry,
 		return 0;
 	if (!nfs_dentry_verify_change(dir, dentry))
 		return 0;
+
+	/*
+	 * If we have a directory delegation then we don't need to revalidate
+	 * the directory. The delegation will either get recalled or we will
+	 * receive a notification when it changes.
+	 */
+	if (nfs_have_directory_delegation(dir))
+		return 0;
+
 	/* Revalidate nfsi->cache_change_attribute before we declare a match */
 	if (nfs_mapping_need_revalidate_inode(dir)) {
 		if (rcu_walk)
@@ -2202,6 +2211,13 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
 
+static int
+nfs_lookup_revalidate_delegated_parent(struct inode *dir, struct dentry *dentry,
+				       struct inode *inode)
+{
+	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
+}
+
 static int
 nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 		       struct dentry *dentry, unsigned int flags)
@@ -2229,6 +2245,9 @@ nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 	if (nfs_verifier_is_delegated(dentry))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
 
+	if (nfs_have_directory_delegation(dir))
+		return nfs_lookup_revalidate_delegated_parent(dir, dentry, inode);
+
 	/* NFS only supports OPEN on regular files */
 	if (!S_ISREG(inode->i_mode))
 		goto full_reval;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 18b57c7c2f97..6c92211835e7 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1383,6 +1383,9 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 		status = pnfs_sync_inode(inode, false);
 		if (status)
 			goto out;
+	} else if (nfs_have_directory_delegation(inode)) {
+		status = 0;
+		goto out;
 	}
 
 	status = -ENOMEM;
-- 
2.51.2


