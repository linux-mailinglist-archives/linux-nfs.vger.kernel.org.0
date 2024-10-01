Return-Path: <linux-nfs+bounces-6771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1892098C6DA
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 22:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F6B285A42
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7681BC9FF;
	Tue,  1 Oct 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2jAALXz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88129A1
	for <linux-nfs@vger.kernel.org>; Tue,  1 Oct 2024 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814839; cv=none; b=iVDx0P4qaVa8AITH9ClS+GIY0qpfu5poaRQYvXVPkfxjnGPnerv31229m81wXGOC4BSABAjXxUhTj6rdBEtWtJPvcexyUPDswDjqMLRcsIRpFLIeohBairrNqjL55Ks6O7eJzbdXAhFNzb/peoAVPeAGsn4TnfjXKH+F2U+USRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814839; c=relaxed/simple;
	bh=KVG+JDGwdymjA/64VP+6MuqLk+zdm+v4lYTz1BieZtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdKxPGLRB03/WrWa+4BOjlVpCYs44MdtIcr4wJ3qLSs82C00bg6XYL30w1Gn6skVksW/rzBAi1HS0PVB1n3dXieyoZkmP/sG7OF3VZAzNXansMfb3bXED23ApgHSIpZduBhmBO/l64OrAqghnSdnCT+9NZm8xmKKdlZTEWf7ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2jAALXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A5EC4CEC6;
	Tue,  1 Oct 2024 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727814839;
	bh=KVG+JDGwdymjA/64VP+6MuqLk+zdm+v4lYTz1BieZtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2jAALXzwzjPiHKzf1TU2mZsjpe0ZE6JQxTYFx9mmWqiU+Gpa0/WDFS/Gbb8YiCKQ
	 T+p20s0Gc/5ckxxs4+h96+P2mjQHq7/gCbzdc/FLGGIVMXeDmEfE6Z+sKt90h9V3yI
	 i7+n51/cfsyY8YA5MlPVI0j5ijoaT4roCcM95SOWAYi5MMUd2zWi+V/nFGnpAaqx8g
	 nUR6xAGfZVoulE4pDiam/ZLk4kvB9rgylZVaDa6vrAJWRv5XBELmvZJrWSAKt98gU1
	 h+rzQb5gUA/6sVS+Etqo9KtaS3FflBpkqhRzYsN2xU9xUfLIYD8Ct6OG9WOX96w6E1
	 6MeUFp1eW3TSg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 2/5] NFS: Convert the NFS module list into an array
Date: Tue,  1 Oct 2024 16:33:41 -0400
Message-ID: <20241001203344.327044-3-anna@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001203344.327044-1-anna@kernel.org>
References: <20241001203344.327044-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Using a linked list here seems unnecessarily complex, especially since
possible index values are '2', '3', and '4'. Let's just use an array for
direct access.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/client.c | 26 ++++++++++++++------------
 fs/nfs/nfs.h    |  1 -
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 15340df117a7..f5c2be89797a 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -56,7 +56,12 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(nfs_client_active_wq);
 static DEFINE_RWLOCK(nfs_version_lock);
-static LIST_HEAD(nfs_versions);
+
+static struct nfs_subversion *nfs_version_mods[5] = {
+	[2] = NULL,
+	[3] = NULL,
+	[4] = NULL,
+};
 
 /*
  * RPC cruft for NFS
@@ -78,17 +83,14 @@ const struct rpc_program nfs_program = {
 static struct nfs_subversion *find_nfs_version(unsigned int version)
 {
 	struct nfs_subversion *nfs;
+
 	read_lock(&nfs_version_lock);
-
-	list_for_each_entry(nfs, &nfs_versions, list) {
-		if (nfs->rpc_ops->version == version) {
-			read_unlock(&nfs_version_lock);
-			return nfs;
-		}
-	}
-
+	nfs = nfs_version_mods[version];
 	read_unlock(&nfs_version_lock);
-	return ERR_PTR(-EPROTONOSUPPORT);
+
+	if (nfs == NULL)
+		return ERR_PTR(-EPROTONOSUPPORT);
+	return nfs;
 }
 
 struct nfs_subversion *get_nfs_version(unsigned int version)
@@ -114,7 +116,7 @@ void register_nfs_version(struct nfs_subversion *nfs)
 {
 	write_lock(&nfs_version_lock);
 
-	list_add(&nfs->list, &nfs_versions);
+	nfs_version_mods[nfs->rpc_ops->version] = nfs;
 	nfs_version[nfs->rpc_ops->version] = nfs->rpc_vers;
 
 	write_unlock(&nfs_version_lock);
@@ -126,7 +128,7 @@ void unregister_nfs_version(struct nfs_subversion *nfs)
 	write_lock(&nfs_version_lock);
 
 	nfs_version[nfs->rpc_ops->version] = NULL;
-	list_del(&nfs->list);
+	nfs_version_mods[nfs->rpc_ops->version] = NULL;
 
 	write_unlock(&nfs_version_lock);
 }
diff --git a/fs/nfs/nfs.h b/fs/nfs/nfs.h
index 0d3ce0460e35..0329fc3023d0 100644
--- a/fs/nfs/nfs.h
+++ b/fs/nfs/nfs.h
@@ -19,7 +19,6 @@ struct nfs_subversion {
 	const struct nfs_rpc_ops *rpc_ops;	/* NFS operations */
 	const struct super_operations *sops;	/* NFS Super operations */
 	const struct xattr_handler * const *xattr;	/* NFS xattr handlers */
-	struct list_head list;		/* List of NFS versions */
 };
 
 struct nfs_subversion *get_nfs_version(unsigned int);
-- 
2.46.2


