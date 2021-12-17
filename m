Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27AB4795A2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbhLQUnN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:43:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46548 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbhLQUnJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:43:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF8FBB82A9E
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF91C36AEA;
        Fri, 17 Dec 2021 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639773787;
        bh=HwJ5YopE+4D5zrRTk2s9jGagGYSgGbxS7KhL6mjmwNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIhIjJ08MIdhbHhXTzSLHA9fNuqAPSGt63DpdGMV/4KRTqEEsgrul8LFs3ypqJnzt
         4O6MLUDrsIbrh2AQQjAi8snFcvK5Q1HNfp07ewrqsMQVXVL5B9PT58KJKeM2zeZPrK
         N3MW8HUwopwS9mC6GpjP4hI6nYSIU+smFQ5OkwTr70ruRlRJ6BEiyLniGIuyziWzqF
         ihNYP8hJsFM8gTHai64nd485XMlDEIJXEs+WFeYEFIjBtwKavRfutH6i9YAXAhKK5g
         /bp8rDl30uOaOKNwb/7AC1fgaAQLRUxfLdY/HPQ/jHEAUh9CrMiYHKeX0tWRdugjHZ
         1f6+vNiO0vv2g==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] NFS: Add a helper to remove case-insensitive aliases
Date:   Fri, 17 Dec 2021 15:36:57 -0500
Message-Id: <20211217203658.439352-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217203658.439352-4-trondmy@kernel.org>
References: <20211217203658.439352-1-trondmy@kernel.org>
 <20211217203658.439352-2-trondmy@kernel.org>
 <20211217203658.439352-3-trondmy@kernel.org>
 <20211217203658.439352-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When dealing with case insensitive names, the client has no idea how the
server performs the mapping, so cannot collapse the dentries into a
single representative. So both rename and unlink need to deal with the
fact that there could be several dentries representing the file, and
have to somehow force them to be revalidated. Use d_prune_aliases() as a
big hammer approach.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 12 +++++++++++-
 fs/nfs/internal.h |  1 +
 fs/nfs/nfs4proc.c |  5 ++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8ed943081e3d..a490704e10ed 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1819,6 +1819,14 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 }
 EXPORT_SYMBOL_GPL(nfs_lookup);
 
+void nfs_d_prune_case_insensitive_aliases(struct inode *inode)
+{
+	/* Case insensitive server? Revalidate dentries */
+	if (inode && nfs_server_capable(inode, NFS_CAP_CASE_INSENSITIVE))
+		d_prune_aliases(inode);
+}
+EXPORT_SYMBOL_GPL(nfs_d_prune_case_insensitive_aliases);
+
 #if IS_ENABLED(CONFIG_NFS_V4)
 static int nfs4_lookup_revalidate(struct dentry *, unsigned int);
 
@@ -2199,8 +2207,10 @@ static void nfs_dentry_remove_handle_error(struct inode *dir,
 	switch (error) {
 	case -ENOENT:
 		d_delete(dentry);
-		fallthrough;
+		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
+		break;
 	case 0:
+		nfs_d_prune_case_insensitive_aliases(d_inode(dentry));
 		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 	}
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 12f6acb483bb..2de7c56a1fbe 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -373,6 +373,7 @@ extern unsigned long nfs_access_cache_count(struct shrinker *shrink,
 extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc);
 struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
+void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct user_namespace *, struct inode *, struct dentry *,
 	       umode_t, bool);
 int nfs_mkdir(struct user_namespace *, struct inode *, struct dentry *,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 422375149c7c..5e8be04dbe84 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4668,8 +4668,10 @@ static void nfs4_proc_unlink_setup(struct rpc_message *msg,
 
 	nfs_fattr_init(res->dir_attr);
 
-	if (inode)
+	if (inode) {
 		nfs4_inode_return_delegation(inode);
+		nfs_d_prune_case_insensitive_aliases(inode);
+	}
 }
 
 static void nfs4_proc_unlink_rpc_prepare(struct rpc_task *task, struct nfs_unlinkdata *data)
@@ -4735,6 +4737,7 @@ static int nfs4_proc_rename_done(struct rpc_task *task, struct inode *old_dir,
 		return 0;
 
 	if (task->tk_status == 0) {
+		nfs_d_prune_case_insensitive_aliases(d_inode(data->old_dentry));
 		if (new_dir != old_dir) {
 			/* Note: If we moved a directory, nlink will change */
 			nfs4_update_changeattr(old_dir, &res->old_cinfo,
-- 
2.33.1

