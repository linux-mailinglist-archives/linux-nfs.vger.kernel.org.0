Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78945480454
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhL0TLe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:11:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45260 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhL0TLe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:11:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BFE3B81148
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A72C36AED;
        Mon, 27 Dec 2021 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640632292;
        bh=PlBAEStFqj2AjhFSgj+8SvvyMQgNls6jBnDftH2hE5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CisosqmWr117BAJULCJxrcfIy4EW7pEY3oieixY7eo6oRCCfNxAVEZLX5aeC6ew26
         3F1yM0FcpDhwQb/X2a2PkZ+Q9QZlkvHMSm1zQ9UdHWwlbVPkHEslvtRNoT/hYYNult
         OnytkdXU1VCc65UnBzXJPh7VYV5r/LD5WCHDknPDd6IAbUwvXVsPYBxrMP2chc6WVT
         e+vDE+nUG2ZjxdfgSpbDdQpfhHbZT8XuX9Qf/NoVoSnGDPfT30qh+CGYIftlsWVf+l
         wRjeGiwVaf/IXmJisZBvBx9tJ3rrCOg6e49wIFDLOxh7CAquWMcNdIrW1XvK9p+nJB
         TJSMgtSIxWQ/g==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/8] NFS: Return the file btime in the statx results when appropriate
Date:   Mon, 27 Dec 2021 14:04:59 -0500
Message-Id: <20211227190504.309612-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227190504.309612-3-trondmy@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
 <20211227190504.309612-2-trondmy@kernel.org>
 <20211227190504.309612-3-trondmy@kernel.org>
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

