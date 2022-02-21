Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C3C4BE3D0
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379991AbiBUQP2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 11:15:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379986AbiBUQPZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 11:15:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5027B09
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 08:15:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7064D612A3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18203C340F1
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645460102;
        bh=KmywsLUD8y02FPy3fCK28yoWL5oPPleON/q3PmiX2QY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=C0cw1GpTo2ZOa8TIvI9vGhgXLMXRtfKJRwQLT+pnbF+L0om6U3xcxWNk+Kc3kcIVx
         H5EDXZDhRUNk8bNHob1MF3RHaWTz1KWvOdoEi70Vql12t2BxGF5NIeLp5faxe2SNwB
         +JyWK17E6nVXxllWSsEcDZNnqGeTa5YCYwrkizj4h3H1J39Xj5JyTa1gFMy/o9d6G9
         9ys6DWt02rA3B2IztL1vDrFmfAspa+u0Lm45U3Y0mRwjaxGAurh046hfXAtfG+EZRU
         sqdMcptzf7yKFXBa8GFSp7sDUxuKEh3GNG0eOsERqzirb6po2gRxdUuNbFzTWcoeG3
         nU4FTC4Kk2L4Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 07/13] NFS: Don't ask for readdirplus unless it can help nfs_getattr()
Date:   Mon, 21 Feb 2022 11:08:45 -0500
Message-Id: <20220221160851.15508-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221160851.15508-7-trondmy@kernel.org>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
 <20220221160851.15508-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If attribute caching is turned off, then use of readdirplus is not going
to help stat() performance.
Readdirplus also doesn't help if a file is being written to, since we
will have to flush those writes in order to sync the mtime/ctime.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 1bef81f5373a..9d2af9887715 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -782,24 +782,26 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 }
 EXPORT_SYMBOL_GPL(nfs_setattr_update_inode);
 
-static void nfs_readdirplus_parent_cache_miss(struct dentry *dentry)
+/*
+ * Don't request help from readdirplus if the file is being written to,
+ * or if attribute caching is turned off
+ */
+static bool nfs_getattr_readdirplus_enable(const struct inode *inode)
 {
-	struct dentry *parent;
+	return nfs_server_capable(inode, NFS_CAP_READDIRPLUS) &&
+	       !nfs_have_writebacks(inode) && NFS_MAXATTRTIMEO(inode) > 5 * HZ;
+}
 
-	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_READDIRPLUS))
-		return;
-	parent = dget_parent(dentry);
+static void nfs_readdirplus_parent_cache_miss(struct dentry *dentry)
+{
+	struct dentry *parent = dget_parent(dentry);
 	nfs_readdir_record_entry_cache_miss(d_inode(parent));
 	dput(parent);
 }
 
 static void nfs_readdirplus_parent_cache_hit(struct dentry *dentry)
 {
-	struct dentry *parent;
-
-	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_READDIRPLUS))
-		return;
-	parent = dget_parent(dentry);
+	struct dentry *parent = dget_parent(dentry);
 	nfs_readdir_record_entry_cache_hit(d_inode(parent));
 	dput(parent);
 }
@@ -837,6 +839,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
 	bool do_update = false;
+	bool readdirplus_enabled = nfs_getattr_readdirplus_enable(inode);
 
 	trace_nfs_getattr_enter(inode);
 
@@ -845,7 +848,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			STATX_INO | STATX_SIZE | STATX_BLOCKS;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
-		nfs_readdirplus_parent_cache_hit(path->dentry);
+		if (readdirplus_enabled)
+			nfs_readdirplus_parent_cache_hit(path->dentry);
 		goto out_no_revalidate;
 	}
 
@@ -895,15 +899,12 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
 
 	if (do_update) {
-		/* Update the attribute cache */
-		if (!(server->flags & NFS_MOUNT_NOAC))
+		if (readdirplus_enabled)
 			nfs_readdirplus_parent_cache_miss(path->dentry);
-		else
-			nfs_readdirplus_parent_cache_hit(path->dentry);
 		err = __nfs_revalidate_inode(server, inode);
 		if (err)
 			goto out;
-	} else
+	} else if (readdirplus_enabled)
 		nfs_readdirplus_parent_cache_hit(path->dentry);
 out_no_revalidate:
 	/* Only return attributes that were revalidated. */
-- 
2.35.1

