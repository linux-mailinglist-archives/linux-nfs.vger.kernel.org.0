Return-Path: <linux-nfs+bounces-17357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E39DCE9E8A
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 15:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F9113017209
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297B2248B0;
	Tue, 30 Dec 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTeEdze3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6A222599
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104328; cv=none; b=NyY07JKGKm8c+7UgfA3dty38fxt6QvjR1PvFzLqkTCL2nUaN06NNKjEETpq+02r/t4Jqg5h2NxRiZyazJLLojl/xUujtiqk90apfviT0HfZxDgBmjkpzlNRBJMbMfjxqKUk2l+k88cYUO+7ZckvU1foY/LXfg23wdoBE//Vleuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104328; c=relaxed/simple;
	bh=oBaEOnDU7shz0ZEVsUqUz14ebWLGyQYmiUqu753VlkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK46dXZBmZcoCkG73WJvJ8AoKyT7jlS4V2/DoeCt5PJdim6mxACORedTKo9SfVo5W7cuaX2iizfaiEZ+k+vjA9+l4o5tx5RpwYcQn704BVDiih2AeCDxPg0axO3MHHLgc9lPvov1V6TyRom4XRK5kM2ep/quGW9TM+pAjhGUA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTeEdze3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953EEC116C6;
	Tue, 30 Dec 2025 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767104326;
	bh=oBaEOnDU7shz0ZEVsUqUz14ebWLGyQYmiUqu753VlkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTeEdze3SEW24G3R2E59hyJjOjA/HbVL0cK4RmMAHryd3vJsUZ1KWG/Eu5beP2eEM
	 DyOG9JZv0fZP+6uKT+ZKEkq0gebwdox4GI6KdKXes+JsvReSJ9OS4I8f+EVfyDOhkV
	 7UO33hC+wtRcdK+1CjI2RFQ+4ohH9vDJwaNp/J/c64L3D/LJzb14Hnm38LE99ELWm7
	 Okjoi5njQK+2bc/9E0G7WnfFhGdAhX76VXNLlMB544lDWXvbXHeGaPlDqzC25luqOM
	 Y2KJRra7BstajtG+E44ly0cngQXFmMEC28L4XRPOPL+y9OifHI6uUiHss/0+bl9y9w
	 0L0WNnv0Cn9XA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 5/5] nfsd: close cached files on filesystem unmount
Date: Tue, 30 Dec 2025 09:18:38 -0500
Message-ID: <20251230141838.2547848-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230141838.2547848-1-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When a filesystem is unmounted while NFS is exporting it, the
unmount can fail with EBUSY even after NFSv4 state has been revoked.
This is because the nfsd_file cache can hold open NFSv2/3 file
handles that pin the filesystem, preventing the unmount from
completing.

Extend the mechanism that revokes NFSv4 state on unmount to also
close cached file handles. nfsd_file_close_sb() walks the nfsd_file
cache and disposes of entries belonging to the target superblock.
It runs after NFSv4 state revocation, so it handles only NFSv2/3
file handles that remain in the cache.

Entries still under construction (with nf_file not yet set) are
skipped; these have no open file to close.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 39 +++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/pin.c       |  6 ++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 93798575b807..bbef58c1caa9 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -894,6 +894,45 @@ __nfsd_file_cache_purge(struct net *net)
 	nfsd_file_dispose_list(&dispose);
 }
 
+/**
+ * nfsd_file_close_sb - close GC-managed cached files for a superblock
+ * @sb: target superblock
+ *
+ * Walk the nfsd_file cache and close out GC-managed entries (those
+ * acquired via nfsd_file_acquire_gc) that belong to @sb. Called during
+ * filesystem unmount after NFSv4 state revocation to release remaining
+ * cached file handles that may be pinning the filesystem.
+ */
+void nfsd_file_close_sb(struct super_block *sb)
+{
+	struct rhashtable_iter iter;
+	struct nfsd_file *nf;
+	LIST_HEAD(dispose);
+
+	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0)
+		return;
+
+	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		nf = rhashtable_walk_next(&iter);
+		while (!IS_ERR_OR_NULL(nf)) {
+			if (test_bit(NFSD_FILE_GC, &nf->nf_flags) == 0)
+				goto next;
+			if (nf->nf_file && file_inode(nf->nf_file)->i_sb == sb)
+				nfsd_file_cond_queue(nf, &dispose);
+next:
+			nf = rhashtable_walk_next(&iter);
+		}
+
+		rhashtable_walk_stop(&iter);
+	} while (nf == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&iter);
+
+	nfsd_file_dispose_list(&dispose);
+}
+
 static struct nfsd_fcache_disposal *
 nfsd_alloc_fcache_disposal(void)
 {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b383dbc5b921..66ca7fc6189b 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -70,6 +70,7 @@ struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
+void nfsd_file_close_sb(struct super_block *sb);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
diff --git a/fs/nfsd/pin.c b/fs/nfsd/pin.c
index f8d0d7cda404..0c1de8fd0e43 100644
--- a/fs/nfsd/pin.c
+++ b/fs/nfsd/pin.c
@@ -19,6 +19,7 @@
 #include "nfsd.h"
 #include "netns.h"
 #include "state.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PROC
 
@@ -49,8 +50,8 @@ static void nfsd_fs_pin_free_rcu(struct rcu_head *rcu)
 
 /*
  * Work function for nfsd_fs_pin - runs in process context.
- * Cancels async COPYs, releases NLM locks, and revokes NFSv4 state for
- * the superblock.
+ * Cancels async COPYs, releases NLM locks, revokes NFSv4 state, and closes
+ * cached NFSv2/3 files for the superblock.
  */
 static void nfsd_fs_pin_work(struct work_struct *work)
 {
@@ -63,6 +64,7 @@ static void nfsd_fs_pin_work(struct work_struct *work)
 	/* Errors are logged by lockd; no recovery is possible. */
 	(void)nlmsvc_unlock_all_by_sb(p->sb);
 	nfsd4_revoke_states(nn, p->sb);
+	nfsd_file_close_sb(p->sb);
 
 	pr_info("nfsd: state revocation for %s complete\n", p->sb->s_id);
 
-- 
2.52.0


