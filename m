Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B88CB1DA3
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfIMM3F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 08:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfIMM3F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Sep 2019 08:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1661B309174E;
        Fri, 13 Sep 2019 12:29:05 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9B5F608AB;
        Fri, 13 Sep 2019 12:29:04 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 29D4C109AF41; Fri, 13 Sep 2019 08:29:04 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv3: use nfs_add_or_obtain() to create and reference inodes
Date:   Fri, 13 Sep 2019 08:29:03 -0400
Message-Id: <157982bc982443f8c675d4269e70da55afa82821.1568377101.git.bcodding@redhat.com>
In-Reply-To: <cover.1568377101.git.bcodding@redhat.com>
References: <cover.1568377101.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 12:29:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

---
 fs/nfs/nfs3proc.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index a3ad2d46fd42..9eb2f1a503ab 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -279,15 +279,17 @@ static struct nfs3_createdata *nfs3_alloc_createdata(void)
 	return data;
 }
 
-static int nfs3_do_create(struct inode *dir, struct dentry *dentry, struct nfs3_createdata *data)
+static struct dentry *
+nfs3_do_create(struct inode *dir, struct dentry *dentry, struct nfs3_createdata *data)
 {
 	int status;
 
 	status = rpc_call_sync(NFS_CLIENT(dir), &data->msg, 0);
 	nfs_post_op_update_inode(dir, data->res.dir_attr);
-	if (status == 0)
-		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr, NULL);
-	return status;
+	if (status != 0)
+		return ERR_PTR(status);
+
+	return nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr, NULL);
 }
 
 static void nfs3_free_createdata(struct nfs3_createdata *data)
@@ -304,6 +306,7 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 {
 	struct posix_acl *default_acl, *acl;
 	struct nfs3_createdata *data;
+	struct dentry *d_alias;
 	int status = -ENOMEM;
 
 	dprintk("NFS call  create %pd\n", dentry);
@@ -330,7 +333,8 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		goto out;
 
 	for (;;) {
-		status = nfs3_do_create(dir, dentry, data);
+		d_alias = nfs3_do_create(dir, dentry, data);
+		status = PTR_ERR_OR_ZERO(d_alias);
 
 		if (status != -ENOTSUPP)
 			break;
@@ -355,6 +359,9 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	if (status != 0)
 		goto out_release_acls;
 
+	if (d_alias)
+		dentry = d_alias;
+
 	/* When we created the file with exclusive semantics, make
 	 * sure we set the attributes afterwards. */
 	if (data->arg.create.createmode == NFS3_CREATE_EXCLUSIVE) {
@@ -372,11 +379,13 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		nfs_post_op_update_inode(d_inode(dentry), data->res.fattr);
 		dprintk("NFS reply setattr (post-create): %d\n", status);
 		if (status != 0)
-			goto out_release_acls;
+			goto out_dput;
 	}
 
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
 
+out_dput:
+	dput(d_alias);
 out_release_acls:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
@@ -504,6 +513,7 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 		  unsigned int len, struct iattr *sattr)
 {
 	struct nfs3_createdata *data;
+	struct dentry *d_alias;
 	int status = -ENOMEM;
 
 	if (len > NFS3_MAXPATHLEN)
@@ -522,7 +532,11 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 	data->arg.symlink.pathlen = len;
 	data->arg.symlink.sattr = sattr;
 
-	status = nfs3_do_create(dir, dentry, data);
+	d_alias = nfs3_do_create(dir, dentry, data);
+	status = PTR_ERR_OR_ZERO(d_alias);
+
+	if (status == 0)
+		dput(d_alias);
 
 	nfs3_free_createdata(data);
 out:
@@ -535,6 +549,7 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
 	struct posix_acl *default_acl, *acl;
 	struct nfs3_createdata *data;
+	struct dentry *d_alias;
 	int status = -ENOMEM;
 
 	dprintk("NFS call  mkdir %pd\n", dentry);
@@ -553,12 +568,18 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 	data->arg.mkdir.len = dentry->d_name.len;
 	data->arg.mkdir.sattr = sattr;
 
-	status = nfs3_do_create(dir, dentry, data);
+	d_alias = nfs3_do_create(dir, dentry, data);
+	status = PTR_ERR_OR_ZERO(d_alias);
+
 	if (status != 0)
 		goto out_release_acls;
 
+	if (d_alias)
+		dentry = d_alias;
+
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
 
+	dput(d_alias);
 out_release_acls:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
@@ -660,6 +681,7 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 {
 	struct posix_acl *default_acl, *acl;
 	struct nfs3_createdata *data;
+	struct dentry *d_alias;
 	int status = -ENOMEM;
 
 	dprintk("NFS call  mknod %pd %u:%u\n", dentry,
@@ -698,12 +720,17 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		goto out;
 	}
 
-	status = nfs3_do_create(dir, dentry, data);
+	d_alias = nfs3_do_create(dir, dentry, data);
+	status = PTR_ERR_OR_ZERO(d_alias);
 	if (status != 0)
 		goto out_release_acls;
 
+	if (d_alias)
+		dentry = d_alias;
+
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
 
+	dput(d_alias);
 out_release_acls:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
-- 
2.20.1

