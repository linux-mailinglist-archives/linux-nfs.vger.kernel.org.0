Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DD33177C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCHTnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 14:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhCHTm5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Mar 2021 14:42:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89672652AC;
        Mon,  8 Mar 2021 19:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615232576;
        bh=r/bqLqezxeyDvwyXn9GvOJ6VJVoOlhCbXywltyxVttY=;
        h=From:To:Cc:Subject:Date:From;
        b=R7M2ffWTTWnhlfN5+xNUE37Qkz5CIERLoJxythMYzgOBOWxAqtRUZt8AEbDIvtIvg
         V3bAXh/fOk23iu3N+6ysyoNONMbLA1pgXRTQgp3SD9LI/eAu/1apCXIbxNQZHZIpkE
         edaooIUfgzSjoEAFIz/rhNjaOib+xvxiy9IOCk7Dc0MFvipJ1Lk8V5atkEGafeZ+0b
         ETos84RqKmT+60hGt05RHRdy7licv6pISdgClTuE/PMpFgjqppdzhOcZgHOCojVZOp
         tuxqpSp3H35uy9uJPCyKxjPsji6NBjmob4bk7xdCHI7PWOkjop5tsqYgyFXDlNtZea
         u8t/UIWJnVAJQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Geert Jansen <gerardu@amazon.com>
Subject: [PATCH v2 1/5] NFS: Don't revalidate the directory permissions on a lookup failure
Date:   Mon,  8 Mar 2021 14:42:51 -0500
Message-Id: <20210308194255.7873-1-trondmy@kernel.org>
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
 fs/nfs/dir.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 19a9f434442f..08b162de627f 100644
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
@@ -1525,6 +1533,13 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_free_fattr(fattr);
 	nfs_free_fhandle(fhandle);
 	nfs4_label_free(label);
+
+	/*
+	 * If the lookup failed despite the dentry change attribute being
+	 * a match, then we should revalidate the directory cache.
+	 */
+	if (!ret && nfs_verify_change_attribute(dir, dentry->d_time))
+		nfs_mark_dir_for_revalidate(dir);
 	return nfs_lookup_revalidate_done(dir, dentry, inode, ret);
 }
 
@@ -1567,7 +1582,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 		error = nfs_lookup_verify_inode(inode, flags);
 		if (error) {
 			if (error == -ESTALE)
-				nfs_zap_caches(dir);
+				nfs_mark_dir_for_revalidate(dir);
 			goto out_bad;
 		}
 		nfs_advise_use_readdirplus(dir);
@@ -2064,7 +2079,6 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	dput(parent);
 	return d;
 out_error:
-	nfs_mark_for_revalidate(dir);
 	d = ERR_PTR(error);
 	goto out;
 }
-- 
2.29.2

