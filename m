Return-Path: <linux-nfs+bounces-3878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9190A1C4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068FE1F21714
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B81C2BD;
	Mon, 17 Jun 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxtX1MPs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923801C287
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587517; cv=none; b=HBA6SxVXrabG0sEXhpsybsJ7h1A2rM/H6nLQgKFT+Pxj4pbCk6t3b3W2xPNGBODGZ+wy/znKJqrYGnIMD0OXuVsTcy7vZm7mVXeE9OvgpARdQZ/WgD/m9Eg1HqsI1GYHpc6nbauiSRMB+jyKQtdm/OSFTEegWyUezvP51sYX4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587517; c=relaxed/simple;
	bh=BJa88K7CAgwegAtT+DCa/WBZL/OoqL5mRXBaazxouks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkWStoM60gb1fZYnuDIy1BTR7hlK28eTDB6hf2CO+JC2zkfdmZLKW0nkGV5fLCf5InONc9fQryUMYvmSjNwo9GHxBllaX69xlXaQG+LZ5DjhBlfHbtQ+plv98JiwmoRhLPBWL56L73Et3mzuJ5bKM3VRcN07GODqP6UYG1uxVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxtX1MPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9031C2BBFC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587517;
	bh=BJa88K7CAgwegAtT+DCa/WBZL/OoqL5mRXBaazxouks=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BxtX1MPs5t1suus77aiOKtZobdhf7oVfZtOk3AT7hkeUROdIzEew7prVzY2bIRNRN
	 SsTreAEOLWFz7EhsLb7LqO4+ey49dDcMzLr0rDc1sCr/7Uh3bGJ4zr1z6rW07zjjhq
	 DNIXhgHVfj73+7FpHKkAZ8d3ZS0q201Hwr1Ykdg8UcqnCbIHWTxqi4lEP0B7zwo2Yo
	 kUUaUn9tNV6fqpeoy93KBy2ybso/sJDnc2wi4+F5s1MUD3j4jDuA+I9tcTs/3UBiVq
	 nEjPyEKCwYZosNwxm1KQVPOqlnZM8NRaiSwVXX4xW9lTAz4P1FLF46L8b63FbI/lIf
	 aa46s/7a3Tlow==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 18/19] Return the delegation when deleting sillyrenamed files
Date: Sun, 16 Jun 2024 21:21:36 -0400
Message-ID: <20240617012137.674046-19-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-18-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
 <20240617012137.674046-11-trondmy@kernel.org>
 <20240617012137.674046-12-trondmy@kernel.org>
 <20240617012137.674046-13-trondmy@kernel.org>
 <20240617012137.674046-14-trondmy@kernel.org>
 <20240617012137.674046-15-trondmy@kernel.org>
 <20240617012137.674046-16-trondmy@kernel.org>
 <20240617012137.674046-17-trondmy@kernel.org>
 <20240617012137.674046-18-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Shelton <lance.shelton@primarydata.com>

Add a callback to return the delegation in order to allow generic NFS
code to return the delegation when appropriate.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3proc.c       | 8 ++++++++
 fs/nfs/nfs4proc.c       | 1 +
 fs/nfs/proc.c           | 8 ++++++++
 fs/nfs/unlink.c         | 2 ++
 include/linux/nfs_xdr.h | 1 +
 5 files changed, 20 insertions(+)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index cab6c73d25d6..1566163c6d85 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -984,6 +984,13 @@ static int nfs3_have_delegation(struct inode *inode, fmode_t type, int flags)
 	return 0;
 }
 
+static int nfs3_return_delegation(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		nfs_wb_all(inode);
+	return 0;
+}
+
 static const struct inode_operations nfs3_dir_inode_operations = {
 	.create		= nfs_create,
 	.atomic_open	= nfs_atomic_open_v23,
@@ -1062,6 +1069,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.clear_acl_cache = forget_all_cached_acls,
 	.close_context	= nfs_close_context,
 	.have_delegation = nfs3_have_delegation,
+	.return_delegation = nfs3_return_delegation,
 	.alloc_client	= nfs_alloc_client,
 	.init_client	= nfs_init_client,
 	.free_client	= nfs_free_client,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b1376571f6ef..9376b5031acf 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10871,6 +10871,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.close_context  = nfs4_close_context,
 	.open_context	= nfs4_atomic_open,
 	.have_delegation = nfs4_have_delegation,
+	.return_delegation = nfs4_inode_return_delegation,
 	.alloc_client	= nfs4_alloc_client,
 	.init_client	= nfs4_init_client,
 	.free_client	= nfs4_free_client,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 995cc42b0fa0..6c09cd090c34 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -692,6 +692,13 @@ static int nfs_have_delegation(struct inode *inode, fmode_t type, int flags)
 	return 0;
 }
 
+static int nfs_return_delegation(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		nfs_wb_all(inode);
+	return 0;
+}
+
 static const struct inode_operations nfs_dir_inode_operations = {
 	.create		= nfs_create,
 	.lookup		= nfs_lookup,
@@ -757,6 +764,7 @@ const struct nfs_rpc_ops nfs_v2_clientops = {
 	.lock_check_bounds = nfs_lock_check_bounds,
 	.close_context	= nfs_close_context,
 	.have_delegation = nfs_have_delegation,
+	.return_delegation = nfs_return_delegation,
 	.alloc_client	= nfs_alloc_client,
 	.init_client	= nfs_init_client,
 	.free_client	= nfs_free_client,
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 0110299643a2..bf77399696a7 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -232,6 +232,8 @@ nfs_complete_unlink(struct dentry *dentry, struct inode *inode)
 	dentry->d_fsdata = NULL;
 	spin_unlock(&dentry->d_lock);
 
+	NFS_PROTO(inode)->return_delegation(inode);
+
 	if (NFS_STALE(inode) || !nfs_call_unlink(dentry, inode, data))
 		nfs_free_unlinkdata(data);
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index af510a7ec46a..01efacae4634 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1840,6 +1840,7 @@ struct nfs_rpc_ops {
 				struct iattr *iattr,
 				int *);
 	int (*have_delegation)(struct inode *, fmode_t, int);
+	int (*return_delegation)(struct inode *);
 	struct nfs_client *(*alloc_client) (const struct nfs_client_initdata *);
 	struct nfs_client *(*init_client) (struct nfs_client *,
 				const struct nfs_client_initdata *);
-- 
2.45.2


