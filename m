Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D959D762
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 22:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbfHZUYT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 16:24:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbfHZUYT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 16:24:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAA9330821AE;
        Mon, 26 Aug 2019 20:24:18 +0000 (UTC)
Received: from bcodding.csb (ovpn-112-84.rdu2.redhat.com [10.10.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69B1F6092D;
        Mon, 26 Aug 2019 20:24:18 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id CE657109C550; Mon, 26 Aug 2019 16:24:17 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv3: nfs_instantiate() might succeed leaving dentry negative unhashed
Date:   Mon, 26 Aug 2019 16:24:17 -0400
Message-Id: <d2076a27c1f3faa0d732e64d49bcbab054cae23b.1566850914.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 26 Aug 2019 20:24:18 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After adding commit b0c6108ecf64 ("nfs_instantiate(): prevent multiple
aliases for directory inode") my NFS client crashes while doing lustre race
tests simultaneously on a local filesystem and the same filesystem exported
via knfsd:

    BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
     Call Trace:
      ? iput+0x76/0x200
      ? d_splice_alias+0x307/0x3c0
      ? dput.part.31+0x96/0x110
      ? nfs_instantiate+0x45/0x160 [nfs]
      nfs3_proc_setacls+0xa/0x20 [nfsv3]
      nfs3_proc_create+0x1cc/0x230 [nfsv3]
      nfs_create+0x83/0x160 [nfs]
      path_openat+0x11aa/0x14d0
      do_filp_open+0x93/0x100
      ? __check_object_size+0xa3/0x181
      do_sys_open+0x184/0x220
      do_syscall_64+0x5b/0x1b0
      entry_SYSCALL_64_after_hwframe+0x65/0xca

   158 static int __nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
   159         struct posix_acl *dfacl)
   160 {
>> 161     struct nfs_server *server = NFS_SERVER(inode);

The 0x28 offset is i_sb in struct inode, we passed a NULL inode to
nfs3_proc_setacls().

After taking this apart, I find the dentry in R12 has a NULL inode after
nfs_instantiate(), which makes sense if we move it to the alias just after
nfs_fhget() (See the referenced commit above).  Indeed, on the list of
children is the identical positive dentry that is left behind after
d_splice_alias().  Moving it would usualy be fine for callers, except for
NFSv3 because we want the inode pointer to ride the dentry back up the
stack so we can set ACLs on it and/or set attributes in the case of EXCLUSIVE.

A similar problem existed in nfsd_create_locked(), and was fixed by commit
3819bb0d79f5 ("nfsd: vfs_mkdir() might succeed leaving dentry negative
unhashed").  This patch takes the same approach to fixing the problem: in
the rare case that we lost the race to the dentry, look it up and get the
inode from there.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: b0c6108ecf64 ("nfs_instantiate(): prevent multiple aliases for directory inode")
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs3proc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index a3ad2d46fd42..292c53c082f7 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -20,6 +20,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/freezer.h>
 #include <linux/xattr.h>
+#include <linux/namei.h>
 
 #include "iostat.h"
 #include "internal.h"
@@ -305,6 +306,7 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	struct posix_acl *default_acl, *acl;
 	struct nfs3_createdata *data;
 	int status = -ENOMEM;
+	struct dentry *d = NULL;
 
 	dprintk("NFS call  create %pd\n", dentry);
 
@@ -355,6 +357,22 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	if (status != 0)
 		goto out_release_acls;
 
+	/* Possible that nfs_instantiate() lost a race to open-by-fhandle,
+	 * in which case we don't have a reference to the dentry */
+	if (unlikely(d_unhashed(dentry))) {
+		d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
+							dentry->d_name.len);
+		if (IS_ERR(d)) {
+			status = PTR_ERR(d);
+			goto out_release_acls;
+		}
+		if (unlikely(d_is_negative(d))) {
+			status = -ENOENT;
+			goto out_put_d;
+		}
+		dentry = d;
+	}
+
 	/* When we created the file with exclusive semantics, make
 	 * sure we set the attributes afterwards. */
 	if (data->arg.create.createmode == NFS3_CREATE_EXCLUSIVE) {
@@ -372,11 +390,13 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		nfs_post_op_update_inode(d_inode(dentry), data->res.fattr);
 		dprintk("NFS reply setattr (post-create): %d\n", status);
 		if (status != 0)
-			goto out_release_acls;
+			goto out_put_d;
 	}
 
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
 
+out_put_d:
+	dput(d);
 out_release_acls:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
-- 
2.20.1

