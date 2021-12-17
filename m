Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6542D4795D5
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbhLQUzG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:55:06 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57902 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbhLQUzF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:55:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C3B6CE269B
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B627C36AE2;
        Fri, 17 Dec 2021 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639774502;
        bh=PlBAEStFqj2AjhFSgj+8SvvyMQgNls6jBnDftH2hE5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnZ2B3cQqYYGqh15jvI8M5/zzWLpG2mBXMwai5YqKI282nNE84LPjfMeRvthyRyOf
         OrSEi+T1HcqH5ayLqWgHaqajoEv4regBpwWzYyg54tRpGvZmZf4Vvmgvkdvt3IqTui
         /iErLiaFD8LlKLDFyq6vFMD961z8TK1P0MXIWRPlvYL/gvUDkQrEqFYPL5UKM3zNfO
         DdgeGP5gdFz2PeXxEq18VntnSLLfM365jLZlPF6ZGZPgNHSIG5WHyXpaTDWHm57jKU
         7l5P/Ibkh6K08ptOFWErVuiydhTInFKfkmO4Le/fNEFu68YTckxi8h2denJOD1gpFz
         /ZX/eIxoE8NCw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/8] NFS: Return the file btime in the statx results when appropriate
Date:   Fri, 17 Dec 2021 15:48:49 -0500
Message-Id: <20211217204854.439578-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217204854.439578-3-trondmy@kernel.org>
References: <20211217204854.439578-1-trondmy@kernel.org>
 <20211217204854.439578-2-trondmy@kernel.org>
 <20211217204854.439578-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server supports the NFSv4.x "create_time" attribute, then return
it as part of the statx results.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c     | 15 +++++++++++++--
 fs/nfs/nfs4trace.h |  3 ++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 908a62d6a29c..94268cab7613 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -815,6 +815,7 @@ static void nfs_readdirplus_parent_cache_hit(struct dentry *dentry)
 
 static u32 nfs_get_valid_attrmask(struct inode *inode)
 {
+	u64 fattr_valid = NFS_SERVER(inode)->fattr_valid;
 	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
 	u32 reply_mask = STATX_INO | STATX_TYPE;
 
@@ -834,6 +835,9 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
+	if (!(cache_validity & NFS_INO_INVALID_BTIME) &&
+	    (fattr_valid & NFS_ATTR_FATTR_BTIME))
+		reply_mask |= STATX_BTIME;
 	return reply_mask;
 }
 
@@ -842,6 +846,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct nfs_server *server = NFS_SERVER(inode);
+	u64 fattr_valid = server->fattr_valid;
 	unsigned long cache_validity;
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
@@ -851,7 +856,10 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS;
+			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME;
+
+	if (!(fattr_valid & NFS_ATTR_FATTR_BTIME))
+		request_mask &= ~STATX_BTIME;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		nfs_readdirplus_parent_cache_hit(path->dentry);
@@ -882,7 +890,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	/* Is the user requesting attributes that might need revalidation? */
 	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
 					STATX_MTIME|STATX_UID|STATX_GID|
-					STATX_SIZE|STATX_BLOCKS)))
+					STATX_SIZE|STATX_BLOCKS|STATX_BTIME)))
 		goto out_no_revalidate;
 
 	/* Check whether the cached attributes are stale */
@@ -905,6 +913,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
+	if (request_mask & STATX_BTIME)
+		do_update |= cache_validity & NFS_INO_INVALID_BTIME;
 
 	if (do_update) {
 		/* Update the attribute cache */
@@ -925,6 +935,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
+	stat->btime = NFS_I(inode)->btime;
 out:
 	trace_nfs_getattr_exit(inode, err);
 	return err;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 6ee6ad3674a2..186b851be5ba 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -30,7 +30,8 @@
 		{ NFS_ATTR_FATTR_CTIME, "CTIME" }, \
 		{ NFS_ATTR_FATTR_CHANGE, "CHANGE" }, \
 		{ NFS_ATTR_FATTR_OWNER_NAME, "OWNER_NAME" }, \
-		{ NFS_ATTR_FATTR_GROUP_NAME, "GROUP_NAME" })
+		{ NFS_ATTR_FATTR_GROUP_NAME, "GROUP_NAME" }, \
+		{ NFS_ATTR_FATTR_BTIME, "BTIME" })
 
 DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_PROTO(
-- 
2.33.1

