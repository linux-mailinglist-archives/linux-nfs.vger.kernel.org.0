Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B032B755
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhCCK6e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1443553AbhCCE3X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Mar 2021 23:29:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3FBF64E87;
        Wed,  3 Mar 2021 04:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614745718;
        bh=RttunO3a4ksYerltN+7+Q/OJzKaDBUEagtiS2FNa0KA=;
        h=From:To:Cc:Subject:Date:From;
        b=rss6LlX/aT5uzRgbYUtGVpWJ9mHbdRkMpDRAR1YSAGeInyxmDrs50an6x1DH6pwt2
         fXhyINs+X05jUXawVcq+SeLr6Caomq6Da1XrtnmkdU2sUL2yA1PGkO0xg3t167skAB
         81iS7QnJaIFUt5ND0k0m9cqungTjDNPRH9oKj3Br5zDM3rwJN9/AOghfhwTchTKYQ8
         IuWMxMcPqYscQECDP/o4ZJXXC1rzPO3T42zNKCpmwiIrsbPyuGzIB1dbElmSYYO6TC
         Xf41iSOjg3AMkwoR5oJBWa8ItSZzbn0ZOqMl3P6I016wTxkBu4gPfSG24smtfZi/iJ
         DN5eXNMREMvXQ==
From:   trondmy@kernel.org
To:     Geert Jansen <gerardu@amazon.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Don't revalidate the directory permissions on a lookup failure
Date:   Tue,  2 Mar 2021 23:28:35 -0500
Message-Id: <20210303042836.200413-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

There should be no reason to expect the directory permissions to change
just because the directory contents changed or a negative lookup timed
out. So let's avoid doing a full call to nfs_mark_for_revalidate() in
that case.
Furthermore, if this is a negative dentry, and we haven't actually done
a new lookup, then we have no reason yet to believe the directory has
changed at all. So let's remove the gratuitous directory inode
invalidation altogether when called from
nfs_lookup_revalidate_negative().

Reported-by: Geert Jansen <gerardu@amazon.com>
Fixes: 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 19a9f434442f..6350873cb8bd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1401,6 +1401,15 @@ int nfs_lookup_verify_inode(struct inode *inode, unsigned int flags)
 	goto out;
 }
 
+static void nfs_mark_dir_for_revalidate(struct inode *inode)
+{
+	struct nfs_inode *nfsi = NFS_I(inode);
+
+	spin_lock(&inode->i_lock);
+	nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE;
+	spin_unlock(&inode->i_lock);
+}
+
 /*
  * We judge how long we want to trust negative
  * dentries by looking at the parent inode mtime.
@@ -1435,7 +1444,6 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 			__func__, dentry);
 		return 1;
 	case 0:
-		nfs_mark_for_revalidate(dir);
 		if (inode && S_ISDIR(inode->i_mode)) {
 			/* Purge readdir caches. */
 			nfs_zap_caches(inode);
@@ -1525,6 +1533,8 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_free_fattr(fattr);
 	nfs_free_fhandle(fhandle);
 	nfs4_label_free(label);
+	if (!ret)
+		nfs_mark_dir_for_revalidate(dir);
 	return nfs_lookup_revalidate_done(dir, dentry, inode, ret);
 }
 
@@ -1567,7 +1577,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 		error = nfs_lookup_verify_inode(inode, flags);
 		if (error) {
 			if (error == -ESTALE)
-				nfs_zap_caches(dir);
+				nfs_mark_dir_for_revalidate(dir);
 			goto out_bad;
 		}
 		nfs_advise_use_readdirplus(dir);
@@ -2064,7 +2074,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	dput(parent);
 	return d;
 out_error:
-	nfs_mark_for_revalidate(dir);
+	nfs_mark_dir_for_revalidate(dir);
 	d = ERR_PTR(error);
 	goto out;
 }
-- 
2.29.2

