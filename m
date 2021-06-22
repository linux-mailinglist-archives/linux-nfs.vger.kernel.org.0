Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1D3B03F1
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jun 2021 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhFVMOX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Jun 2021 08:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231629AbhFVMOS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Jun 2021 08:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624363922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/UhTkYoMJb+0sswHRMTOrC/xAqTUgyIvFCMqWvCpVtI=;
        b=hkYwhIYGb7l5ppQqKD24QqekvUBvXo9QmZUrMyQfErILGl7EnD7sLJWrlpZtJnPMbBCWTW
        fSbKSF8eP70GKhGsTfIHeheofIo6r0LgPx+Kcy0TqcxhtI/jnYHvDHktFqU3rytZ4g4sWd
        C/JXWiI15xAUk7cfWrpeZVX4vWl7u4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-IUBuQXmnMR6C-_5VVZfH0Q-1; Tue, 22 Jun 2021 08:12:01 -0400
X-MC-Unique: IUBuQXmnMR6C-_5VVZfH0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35A7F19057A4;
        Tue, 22 Jun 2021 12:12:00 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-116-57.rdu2.redhat.com [10.10.116.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 035A9608BA;
        Tue, 22 Jun 2021 12:11:59 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 2C5701A001F; Tue, 22 Jun 2021 08:11:59 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: update has_sec_mnt_opts after cloning lsm options from parent
Date:   Tue, 22 Jun 2021 08:11:59 -0400
Message-Id: <20210622121159.756500-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After calling security_sb_clone_mnt_opts() in nfs_get_root(), it's
necessary to copy the value of has_sec_mnt_opts from the cloned
super_block's nfs_server.  Otherwise, calls to nfs_compare_super()
using this super_block may not return the correct result, leading to
mount failures.

For example, mounting an nfs server with the following in /etc/exports:
/export *(rw,insecure,crossmnt,no_root_squash,security_label)
and having /export/scratch on a separate block device.

mount -o v4.2,context=system_u:object_r:root_t:s0 server:/export/test /mnt/test
mount -o v4.2,context=system_u:object_r:swapfile_t:s0 server:/export/scratch /mnt/scratch

The second mount would fail with "mount.nfs: /mnt/scratch is busy or
already mounted or sharecache fail" and "SELinux: mount invalid.  Same
superblock, different security settings for..." would appear in the
syslog.

Also while we're in there, replace several instances of "NFS_SB(s)"
with "server", which was already declared at the top of the
nfs_get_root().

Fixes: ec1ade6a0448 ("nfs: account for selinux security context when deciding to share superblock")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/getroot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index aaeeb4659bff..59355c106ece 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -67,7 +67,7 @@ static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *i
 int nfs_get_root(struct super_block *s, struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
-	struct nfs_server *server = NFS_SB(s);
+	struct nfs_server *server = NFS_SB(s), *clone_server;
 	struct nfs_fsinfo fsinfo;
 	struct dentry *root;
 	struct inode *inode;
@@ -127,7 +127,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 	}
 	spin_unlock(&root->d_lock);
 	fc->root = root;
-	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
 		kflags |= SECURITY_LSM_NATIVE_LABELS;
 	if (ctx->clone_data.sb) {
 		if (d_inode(fc->root)->i_fop != &nfs_dir_operations) {
@@ -137,15 +137,19 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		/* clone lsm security options from the parent to the new sb */
 		error = security_sb_clone_mnt_opts(ctx->clone_data.sb,
 						   s, kflags, &kflags_out);
+		if (error)
+			goto error_splat_root;
+		clone_server = NFS_SB(ctx->clone_data.sb);
+		server->has_sec_mnt_opts = clone_server->has_sec_mnt_opts;
 	} else {
 		error = security_sb_set_mnt_opts(s, fc->security,
 							kflags, &kflags_out);
 	}
 	if (error)
 		goto error_splat_root;
-	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
+	if (server->caps & NFS_CAP_SECURITY_LABEL &&
 		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
-		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
+		server->caps &= ~NFS_CAP_SECURITY_LABEL;
 
 	nfs_setsecurity(inode, fsinfo.fattr, fsinfo.fattr->label);
 	error = 0;
-- 
2.31.1

