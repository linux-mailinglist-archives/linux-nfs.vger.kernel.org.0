Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962753B1402
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 08:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFWGla (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 02:41:30 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48258 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbhFWGl3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 02:41:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UdOd0Cx_1624430336;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UdOd0Cx_1624430336)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Jun 2021 14:39:10 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-nfs@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v2 2/2] nfs: NFSv3: fix SGID bit dropped when inheriting ACLs
Date:   Wed, 23 Jun 2021 14:38:55 +0800
Message-Id: <1624430335-10322-2-git-send-email-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624430335-10322-1-git-send-email-hsiangkao@linux.alibaba.com>
References: <1624430335-10322-1-git-send-email-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

generic/444 fails with NFSv3 as shown above, "
     QA output created by 444
     drwxrwsr-x
    -drwxrwsr-x
    +drwxrwxr-x
", which tests "SGID inheritance with default ACLs" fs regression
and looks after the following commits:

a3bb2d558752 ("ext4: Don't clear SGID when inheriting ACLs")
073931017b49 ("posix_acl: Clear SGID bit when setting file permissions")

commit 055ffbea0596 ("[PATCH] NFS: Fix handling of the umask when
an NFSv3 default acl is present.") sets acls explicitly when
when files are created in a directory that has a default ACL.
However, after commit a3bb2d558752 and 073931017b49, SGID can be
dropped if user is not member of the owning group with
set_posix_acl() called.

Since underlayfs will handle ACL inheritance when creating
files in a directory that has the default ACL and the umask is
supposed to be ignored for such case. Therefore, I think no need
to set acls explicitly (to avoid SGID bit cleared) but only apply
client umask if the default ACL of the parent directory doesn't
exist.

With this patch, generic/444 can pass now.

Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/1624007545-142045-1-git-send-email-hsiangkao@linux.alibaba.com 
changes since v1:
 fix a build error reported by:
  https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/GKZF3ZU6EI2WA45RV5QJ7OT6ZWMCW2BG/
  https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/S5GPZNHDQOEUCIITEQXLMIXD5IGN5QS7/
 also, some previous test results:
 https://lore.kernel.org/r/YNA03%2FY3KxHYuoLu@B-P7TQMD6M-0146.local/
 and I've also tested the nfs fstests default set w/o difference.

 fs/nfs/nfs3_fs.h  |  5 +++++
 fs/nfs/nfs3proc.c | 43 ++++++++++++++++---------------------------
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index c8a192802dda..aec803ca4afb 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -18,12 +18,17 @@ extern int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 		struct posix_acl *dfacl);
 extern ssize_t nfs3_listxattr(struct dentry *, char *, size_t);
 extern const struct xattr_handler *nfs3_xattr_handlers[];
+#define nfs3_proc_getacl	get_acl
 #else
 static inline int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 		struct posix_acl *dfacl)
 {
 	return 0;
 }
+static inline struct posix_acl *nfs3_proc_getacl(struct inode *inode, int type)
+{
+	return NULL;
+}
 #define nfs3_listxattr NULL
 #endif /* CONFIG_NFS_V3_ACL */
 
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2299446b3b89..f95e75269d83 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -339,7 +339,7 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
 nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		 int flags)
 {
-	struct posix_acl *default_acl, *acl;
+	struct posix_acl *pacl;
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -350,6 +350,10 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
 	if (data == NULL)
 		goto out;
 
+	pacl = nfs3_proc_getacl(dir, ACL_TYPE_DEFAULT);
+	if (!pacl || pacl == ERR_PTR(-EOPNOTSUPP))
+		sattr->ia_mode &= ~current_umask();
+
 	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_CREATE];
 	data->arg.create.fh = NFS_FH(dir);
 	data->arg.create.name = dentry->d_name.name;
@@ -363,10 +367,6 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
 		data->arg.create.verifier[1] = cpu_to_be32(current->pid);
 	}
 
-	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
-	if (status)
-		goto out;
-
 	for (;;) {
 		d_alias = nfs3_do_create(dir, dentry, data);
 		status = PTR_ERR_OR_ZERO(d_alias);
@@ -416,14 +416,10 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
 		if (status != 0)
 			goto out_dput;
 	}
-
-	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
-
 out_dput:
 	dput(d_alias);
 out_release_acls:
-	posix_acl_release(acl);
-	posix_acl_release(default_acl);
+	posix_acl_release(pacl);
 out:
 	nfs3_free_createdata(data);
 	dprintk("NFS reply create: %d\n", status);
@@ -582,7 +578,7 @@ static void nfs3_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renam
 static int
 nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
-	struct posix_acl *default_acl, *acl;
+	struct posix_acl *pacl;
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -593,10 +589,9 @@ static void nfs3_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renam
 	if (data == NULL)
 		goto out;
 
-	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
-	if (status)
-		goto out;
-
+	pacl = nfs3_proc_getacl(dir, ACL_TYPE_DEFAULT);
+	if (!pacl || pacl == ERR_PTR(-EOPNOTSUPP))
+		sattr->ia_mode &= ~current_umask();
 	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKDIR];
 	data->arg.mkdir.fh = NFS_FH(dir);
 	data->arg.mkdir.name = dentry->d_name.name;
@@ -612,12 +607,9 @@ static void nfs3_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renam
 	if (d_alias)
 		dentry = d_alias;
 
-	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
-
 	dput(d_alias);
 out_release_acls:
-	posix_acl_release(acl);
-	posix_acl_release(default_acl);
+	posix_acl_release(pacl);
 out:
 	nfs3_free_createdata(data);
 	dprintk("NFS reply mkdir: %d\n", status);
@@ -713,7 +705,7 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *nr_arg,
 nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		dev_t rdev)
 {
-	struct posix_acl *default_acl, *acl;
+	struct posix_acl *pacl;
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -725,9 +717,9 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *nr_arg,
 	if (data == NULL)
 		goto out;
 
-	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
-	if (status)
-		goto out;
+	pacl = nfs3_proc_getacl(dir, ACL_TYPE_DEFAULT);
+	if (!pacl || pacl == ERR_PTR(-EOPNOTSUPP))
+		sattr->ia_mode &= ~current_umask();
 
 	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKNOD];
 	data->arg.mknod.fh = NFS_FH(dir);
@@ -762,12 +754,9 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *nr_arg,
 	if (d_alias)
 		dentry = d_alias;
 
-	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
-
 	dput(d_alias);
 out_release_acls:
-	posix_acl_release(acl);
-	posix_acl_release(default_acl);
+	posix_acl_release(pacl);
 out:
 	nfs3_free_createdata(data);
 	dprintk("NFS reply mknod: %d\n", status);
-- 
1.8.3.1

