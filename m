Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D733F3BF3F2
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 04:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGHC0A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 22:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhGHC0A (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Jul 2021 22:26:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 451F861CCC
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jul 2021 02:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625710999;
        bh=gTAHYSESYb1Xfe24W5vDIWRBvnLepJKioyVwSu9XLAc=;
        h=From:To:Subject:Date:From;
        b=KesqN5/nyM+CgglAFyPHEUKOd50dm1y91o0VUm78bSYG1HcpEdP1ugdsrJJ56v/Le
         KrC0yF3nX++095PNnyzYnEgh3JqAC8Y9ErP+rWWW++nWwWqvDvKpGfwsGvyIEpJkjo
         xe6rRnzL3cQI7kuKy8xgLucHcFKYlDApR3h8Fpa3RFfE6okvCQjsBE5t9ff0mpZJi+
         oZv25N5HFxvJVK2mNidk4x3x5pkKNqm7jjXllT6BNCPMUYdQdSK3U5XXn6ScfhOR2q
         mVjZkP8ZKkjZ6KUbFVmX+LV6EmGbQ8PflJZ2qHHSnfh6qcIUUOFVYFr57XoDKmieZF
         FjZ6j0vrLRzxw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Label the dentry with a verifier in nfs_link(), nfs_symlink()
Date:   Wed,  7 Jul 2021 22:23:17 -0400
Message-Id: <20210708022318.71364-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

After the success of an operation such as link(), or symlink(), we
expect to add the dentry back to the dcache as an ordinary positive
dentry.
However in NFS, unless it is labelled with the appropriate verifier for
the parent directory state, then nfs_lookup_revalidate will end up
discarding that dentry and forcing a new lookup.

The fix is to ensure that we relabel the dentry appropriately on
success.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1a6d2867fba4..baca036f3890 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2352,6 +2352,8 @@ int nfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		return error;
 	}
 
+	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
+
 	/*
 	 * No big deal if we can't add this page to the page cache here.
 	 * READLINK will get the missing page from the server if needed.
@@ -2385,6 +2387,7 @@ nfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 	d_drop(dentry);
 	error = NFS_PROTO(dir)->link(inode, dir, &dentry->d_name);
 	if (error == 0) {
+		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 		ihold(inode);
 		d_add(dentry, inode);
 	}
-- 
2.31.1

