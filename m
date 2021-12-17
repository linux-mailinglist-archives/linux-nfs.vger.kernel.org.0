Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA94795A1
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbhLQUnN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:43:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46544 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbhLQUnJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:43:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4029CB82A9B
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C29C36AE9;
        Fri, 17 Dec 2021 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639773787;
        bh=cSy/ZhFuOqpo5SDmXj4hF26QWMsDTqccO2jxA4XbK2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBvdY9xexoSt6cLpskX1rnN1DOsrUHYOv5f2UwDut/2Htho96iwf4a3KM88O3LyVq
         3WZ/RyvlGoTryf2blrN9EOpB5gR+XoNn6ZANsDiJhNSw5ODDiXiSoU1EYpJptRR6bB
         jTYvatQE1ycXCA8dKP9YKzWbqewybw5lVCLUysELLsMnG62B217dh7gSnd/byBFJ6Q
         scvqZVEpTDq4DyROu+Ny3IdMFzpAEU7ueI8RbbM0cquCJddfdGSQsGqykR2LXTAIL7
         L26fQNSRwROLOzexb/sIz5+ZztGrzxxw5zAYDJoC+uemA9KIoRSq2ukSEWFlpo0RFR
         YNc2MizeZW7mg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] NFS: Invalidate negative dentries on all case insensitive directory changes
Date:   Fri, 17 Dec 2021 15:36:56 -0500
Message-Id: <20211217203658.439352-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217203658.439352-3-trondmy@kernel.org>
References: <20211217203658.439352-1-trondmy@kernel.org>
 <20211217203658.439352-2-trondmy@kernel.org>
 <20211217203658.439352-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we create a file, rename it, or hardlink it, then we need to assume
that cached negative dentries need to be revalidated.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2822681192b0..8ed943081e3d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1324,6 +1324,14 @@ void nfs_clear_verifier_delegated(struct inode *inode)
 EXPORT_SYMBOL_GPL(nfs_clear_verifier_delegated);
 #endif /* IS_ENABLED(CONFIG_NFS_V4) */
 
+static int nfs_dentry_verify_change(struct inode *dir, struct dentry *dentry)
+{
+	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE) &&
+	    d_really_is_negative(dentry))
+		return dentry->d_time == inode_peek_iversion_raw(dir);
+	return nfs_verify_change_attribute(dir, dentry->d_time);
+}
+
 /*
  * A check for whether or not the parent directory has changed.
  * In the case it has, we assume that the dentries are untrustworthy
@@ -1337,7 +1345,7 @@ static int nfs_check_verifier(struct inode *dir, struct dentry *dentry,
 		return 1;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_LOOKUP_CACHE_NONE)
 		return 0;
-	if (!nfs_verify_change_attribute(dir, dentry->d_time))
+	if (!nfs_dentry_verify_change(dir, dentry))
 		return 0;
 	/* Revalidate nfsi->cache_change_attribute before we declare a match */
 	if (nfs_mapping_need_revalidate_inode(dir)) {
@@ -1346,7 +1354,7 @@ static int nfs_check_verifier(struct inode *dir, struct dentry *dentry,
 		if (__nfs_revalidate_inode(NFS_SERVER(dir), dir) < 0)
 			return 0;
 	}
-	if (!nfs_verify_change_attribute(dir, dentry->d_time))
+	if (!nfs_dentry_verify_change(dir, dentry))
 		return 0;
 	return 1;
 }
@@ -1539,7 +1547,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	 * If the lookup failed despite the dentry change attribute being
 	 * a match, then we should revalidate the directory cache.
 	 */
-	if (!ret && nfs_verify_change_attribute(dir, dentry->d_time))
+	if (!ret && nfs_dentry_verify_change(dir, dentry))
 		nfs_mark_dir_for_revalidate(dir);
 	return nfs_lookup_revalidate_done(dir, dentry, inode, ret);
 }
@@ -1778,8 +1786,11 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 	dir_verifier = nfs_save_change_attribute(dir);
 	trace_nfs_lookup_enter(dir, dentry, flags);
 	error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
-	if (error == -ENOENT)
+	if (error == -ENOENT) {
+		if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+			dir_verifier = inode_peek_iversion_raw(dir);
 		goto no_entry;
+	}
 	if (error < 0) {
 		res = ERR_PTR(error);
 		goto out;
-- 
2.33.1

