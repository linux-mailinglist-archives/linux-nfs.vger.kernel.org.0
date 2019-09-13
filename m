Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F63B1DA4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfIMM3G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 08:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbfIMM3F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Sep 2019 08:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FF1810DCC80;
        Fri, 13 Sep 2019 12:29:05 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6F4110016EB;
        Fri, 13 Sep 2019 12:29:04 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 21EE3109AF40; Fri, 13 Sep 2019 08:29:04 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Refactor nfs_instantiate() for dentry referencing callers
Date:   Fri, 13 Sep 2019 08:29:02 -0400
Message-Id: <5f1de77be01d5729bf246dce8e2fd2d8d191c6bb.1568377101.git.bcodding@redhat.com>
In-Reply-To: <cover.1568377101.git.bcodding@redhat.com>
References: <cover.1568377101.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Fri, 13 Sep 2019 12:29:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit b0c6108ecf64 ("nfs_instantiate(): prevent multiple aliases for
directory inode"), nfs_instantiate() may succeed without actually
instantiating the dentry that was passed in.  That can be problematic for
some callers in NFSv3, so this patch breaks things up so we can get the
actual dentry obtained.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c           | 41 +++++++++++++++++++++++++++--------------
 include/linux/nfs_fs.h |  3 +++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0adfd8840110..cb6ee1b41ab5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1669,24 +1669,23 @@ static int nfs4_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 
 #endif /* CONFIG_NFSV4 */
 
-/*
- * Code common to create, mkdir, and mknod.
- */
-int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
+struct dentry *
+nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr,
 				struct nfs4_label *label)
 {
 	struct dentry *parent = dget_parent(dentry);
 	struct inode *dir = d_inode(parent);
 	struct inode *inode;
-	struct dentry *d;
-	int error = -EACCES;
+	struct dentry *d = NULL;
+	int error;
 
 	d_drop(dentry);
 
 	/* We may have been initialized further down */
 	if (d_really_is_positive(dentry))
 		goto out;
+
 	if (fhandle->size == 0) {
 		error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, fhandle, fattr, NULL);
 		if (error)
@@ -1702,18 +1701,32 @@ int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
 	}
 	inode = nfs_fhget(dentry->d_sb, fhandle, fattr, label);
 	d = d_splice_alias(inode, dentry);
-	if (IS_ERR(d)) {
-		error = PTR_ERR(d);
-		goto out_error;
-	}
-	dput(d);
 out:
 	dput(parent);
-	return 0;
+	return d;
 out_error:
 	nfs_mark_for_revalidate(dir);
-	dput(parent);
-	return error;
+	d = ERR_PTR(error);
+	goto out;
+}
+EXPORT_SYMBOL_GPL(nfs_add_or_obtain);
+
+/*
+ * Code common to create, mkdir, and mknod.
+ */
+int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
+				struct nfs_fattr *fattr,
+				struct nfs4_label *label)
+{
+	struct dentry *d;
+
+	d = nfs_add_or_obtain(dentry, fhandle, fattr, label);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	/* Callers don't care */
+	dput(d);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_instantiate);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 0a11712a80e3..570a60c2f4f4 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -490,6 +490,9 @@ extern const struct file_operations nfs_dir_operations;
 extern const struct dentry_operations nfs_dentry_operations;
 
 extern void nfs_force_lookup_revalidate(struct inode *dir);
+extern struct dentry *nfs_add_or_obtain(struct dentry *dentry,
+			struct nfs_fh *fh, struct nfs_fattr *fattr,
+			struct nfs4_label *label);
 extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 			struct nfs_fattr *fattr, struct nfs4_label *label);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
-- 
2.20.1

