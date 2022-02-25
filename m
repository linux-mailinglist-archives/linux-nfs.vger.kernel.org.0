Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB324C4DCD
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiBYSfX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiBYSfQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A9C1AAFE9
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0368FB8330C
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7295AC340F1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814081;
        bh=lM9XrmPi10WZoh8XtAcXdB0KwhFEAfra12xDra+VbPo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=D6SJRPE/AYQFLBriXR77KBoFg6OlELDEKv5bpJF2zV1Yr1Y7lVNda+XiVT4H6IP5H
         rKMP92dt38HiXYsnKOg4E6i6z/Yr7WY+wmyKMR8GHeYTi9pQO0hskDYe8OOxaYq3N7
         KuE4qXmw9M2y8roFlNYAQWgH/pv098moByVfK4JFgU7qVZKHZHkH9UjtmM7RY+RZJO
         luodv0qJP2UClQo9fKzIHhP6zgeO0BUrn+Oc1nlPs0bYbBh4UeC2TmS/UNJ2Oy5Koq
         ATjMnKHIeOB+stzGPieUBDSXIeGTQW721mOpv0/Kff6rcthcK/7Zh/0d+RrmaD34mR
         zwAlZL5g5THZw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 14/24] NFS: Don't ask for readdirplus unless it can help nfs_getattr()
Date:   Fri, 25 Feb 2022 13:28:19 -0500
Message-Id: <20220225182829.1236093-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-14-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
 <20220225182829.1236093-10-trondmy@kernel.org>
 <20220225182829.1236093-11-trondmy@kernel.org>
 <20220225182829.1236093-12-trondmy@kernel.org>
 <20220225182829.1236093-13-trondmy@kernel.org>
 <20220225182829.1236093-14-trondmy@kernel.org>
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
index bbf4357ff727..10d17cfb8639 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -780,24 +780,26 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
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
@@ -835,6 +837,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
 	bool do_update = false;
+	bool readdirplus_enabled = nfs_getattr_readdirplus_enable(inode);
 
 	trace_nfs_getattr_enter(inode);
 
@@ -843,7 +846,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			STATX_INO | STATX_SIZE | STATX_BLOCKS;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
-		nfs_readdirplus_parent_cache_hit(path->dentry);
+		if (readdirplus_enabled)
+			nfs_readdirplus_parent_cache_hit(path->dentry);
 		goto out_no_revalidate;
 	}
 
@@ -893,15 +897,12 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
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

