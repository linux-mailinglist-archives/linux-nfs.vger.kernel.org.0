Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6317860E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2020 23:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgCCW6o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Mar 2020 17:58:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51751 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726766AbgCCW6n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Mar 2020 17:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583276322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=41cmoi2WBuoRJfhZcXC21IKnpzNXQPaxD3gBuaHiCh0=;
        b=PMm9SvHPOZ297PURk8omADCuecbMaOBN3Fu0xJtOJyGI4l/9v1oyeO82FPrFwoZwEOgy/R
        6q7kzD2SFmklYihFVVognt7TqmJ2PY+HkR2OOwOnaCkL3ljjXt/kJpRuasEl+pkeDAUjq4
        lyWFSuivJ7/DcJ0vJmoa4Qucf87Jy8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-PBJiAyt6O2KcwrH-kJJT8g-1; Tue, 03 Mar 2020 17:58:40 -0500
X-MC-Unique: PBJiAyt6O2KcwrH-kJJT8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFE66DB60;
        Tue,  3 Mar 2020 22:58:38 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-123-59.rdu2.redhat.com [10.10.123.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3473089A9C;
        Tue,  3 Mar 2020 22:58:38 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 7588A1A0107; Tue,  3 Mar 2020 17:58:37 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     richard_c_haines@btinternet.com, bfields@fieldses.org,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-nfs@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH] NFS: Ensure security label is set for root inode
Date:   Tue,  3 Mar 2020 17:58:37 -0500
Message-Id: <20200303225837.1557210-1-smayhew@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When using NFSv4.2, the security label for the root inode should be set
via a call to nfs_setsecurity() during the mount process, otherwise the
inode will appear as unlabeled for up to acdirmin seconds.  Currently
the label for the root inode is allocated, retrieved, and freed entirely
witin nfs4_proc_get_root().

Add a field for the label to the nfs_fattr struct, and allocate & free
the label in nfs_get_root(), where we also add a call to
nfs_setsecurity().  Note that for the call to nfs_setsecurity() to
succeed, it's necessary to also move the logic calling
security_sb_{set,clone}_security() from nfs_get_tree_common() down into
nfs_get_root()... otherwise the SBLABEL_MNT flag will not be set in the
super_block's security flags and nfs_setsecurity() will silently fail.

Reported-by: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/getroot.c        | 39 +++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs4proc.c       | 12 +++---------
 fs/nfs/super.c          | 25 -------------------------
 include/linux/nfs_xdr.h |  1 +
 4 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index b012c2668a1f..6d0628149390 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -73,6 +73,7 @@ int nfs_get_root(struct super_block *s, struct fs_conte=
xt *fc)
 	struct inode *inode;
 	char *name;
 	int error =3D -ENOMEM;
+	unsigned long kflags =3D 0, kflags_out =3D 0;
=20
 	name =3D kstrdup(fc->source, GFP_KERNEL);
 	if (!name)
@@ -83,11 +84,14 @@ int nfs_get_root(struct super_block *s, struct fs_con=
text *fc)
 	if (fsinfo.fattr =3D=3D NULL)
 		goto out_name;
=20
+	fsinfo.fattr->label =3D nfs4_label_alloc(server, GFP_KERNEL);
+	if (IS_ERR(fsinfo.fattr->label))
+		goto out_fattr;
 	error =3D server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsi=
nfo);
 	if (error < 0) {
 		dprintk("nfs_get_root: getattr error =3D %d\n", -error);
 		nfs_errorf(fc, "NFS: Couldn't getattr on root");
-		goto out_fattr;
+		goto out_label;
 	}
=20
 	inode =3D nfs_fhget(s, ctx->mntfh, fsinfo.fattr, NULL);
@@ -95,12 +99,12 @@ int nfs_get_root(struct super_block *s, struct fs_con=
text *fc)
 		dprintk("nfs_get_root: get root inode failed\n");
 		error =3D PTR_ERR(inode);
 		nfs_errorf(fc, "NFS: Couldn't get root inode");
-		goto out_fattr;
+		goto out_label;
 	}
=20
 	error =3D nfs_superblock_set_dummy_root(s, inode);
 	if (error !=3D 0)
-		goto out_fattr;
+		goto out_label;
=20
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
@@ -111,7 +115,7 @@ int nfs_get_root(struct super_block *s, struct fs_con=
text *fc)
 		dprintk("nfs_get_root: get root dentry failed\n");
 		error =3D PTR_ERR(root);
 		nfs_errorf(fc, "NFS: Couldn't get root dentry");
-		goto out_fattr;
+		goto out_label;
 	}
=20
 	security_d_instantiate(root, inode);
@@ -123,12 +127,39 @@ int nfs_get_root(struct super_block *s, struct fs_c=
ontext *fc)
 	}
 	spin_unlock(&root->d_lock);
 	fc->root =3D root;
+	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
+		kflags |=3D SECURITY_LSM_NATIVE_LABELS;
+	if (ctx->clone_data.sb) {
+		if (d_inode(fc->root)->i_fop !=3D &nfs_dir_operations) {
+			error =3D -ESTALE;
+			goto error_splat_root;
+		}
+		/* clone any lsm security options from the parent to the new sb */
+		error =3D security_sb_clone_mnt_opts(ctx->clone_data.sb, s, kflags,
+				&kflags_out);
+	} else {
+		error =3D security_sb_set_mnt_opts(s, fc->security,
+							kflags, &kflags_out);
+	}
+	if (error)
+		goto error_splat_root;
+	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
+		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
+		NFS_SB(s)->caps &=3D ~NFS_CAP_SECURITY_LABEL;
+
+	nfs_setsecurity(inode, fsinfo.fattr, fsinfo.fattr->label);
 	error =3D 0;
=20
+out_label:
+	nfs4_label_free(fsinfo.fattr->label);
 out_fattr:
 	nfs_free_fattr(fsinfo.fattr);
 out_name:
 	kfree(name);
 out:
 	return error;
+error_splat_root:
+	dput(fc->root);
+	fc->root =3D NULL;
+	goto out_label;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 69b7ab7a5815..cb34e840e4fb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4002,7 +4002,7 @@ static int nfs4_proc_get_root(struct nfs_server *se=
rver, struct nfs_fh *mntfh,
 {
 	int error;
 	struct nfs_fattr *fattr =3D info->fattr;
-	struct nfs4_label *label =3D NULL;
+	struct nfs4_label *label =3D fattr->label;
=20
 	error =3D nfs4_server_capabilities(server, mntfh);
 	if (error < 0) {
@@ -4010,23 +4010,17 @@ static int nfs4_proc_get_root(struct nfs_server *=
server, struct nfs_fh *mntfh,
 		return error;
 	}
=20
-	label =3D nfs4_label_alloc(server, GFP_KERNEL);
-	if (IS_ERR(label))
-		return PTR_ERR(label);
-
 	error =3D nfs4_proc_getattr(server, mntfh, fattr, label, NULL);
 	if (error < 0) {
 		dprintk("nfs4_get_root: getattr error =3D %d\n", -error);
-		goto err_free_label;
+		goto out;
 	}
=20
 	if (fattr->valid & NFS_ATTR_FATTR_FSID &&
 	    !nfs_fsid_equal(&server->fsid, &fattr->fsid))
 		memcpy(&server->fsid, &fattr->fsid, sizeof(server->fsid));
=20
-err_free_label:
-	nfs4_label_free(label);
-
+out:
 	return error;
 }
=20
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index dada09b391c6..bb14bede6da5 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1179,7 +1179,6 @@ int nfs_get_tree_common(struct fs_context *fc)
 	struct super_block *s;
 	int (*compare_super)(struct super_block *, struct fs_context *) =3D nfs=
_compare_super;
 	struct nfs_server *server =3D ctx->server;
-	unsigned long kflags =3D 0, kflags_out =3D 0;
 	int error;
=20
 	ctx->server =3D NULL;
@@ -1239,26 +1238,6 @@ int nfs_get_tree_common(struct fs_context *fc)
 		goto error_splat_super;
 	}
=20
-	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
-		kflags |=3D SECURITY_LSM_NATIVE_LABELS;
-	if (ctx->clone_data.sb) {
-		if (d_inode(fc->root)->i_fop !=3D &nfs_dir_operations) {
-			error =3D -ESTALE;
-			goto error_splat_root;
-		}
-		/* clone any lsm security options from the parent to the new sb */
-		error =3D security_sb_clone_mnt_opts(ctx->clone_data.sb, s, kflags,
-				&kflags_out);
-	} else {
-		error =3D security_sb_set_mnt_opts(s, fc->security,
-							kflags, &kflags_out);
-	}
-	if (error)
-		goto error_splat_root;
-	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
-		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
-		NFS_SB(s)->caps &=3D ~NFS_CAP_SECURITY_LABEL;
-
 	s->s_flags |=3D SB_ACTIVE;
 	error =3D 0;
=20
@@ -1268,10 +1247,6 @@ int nfs_get_tree_common(struct fs_context *fc)
 out_err_nosb:
 	nfs_free_server(server);
 	goto out;
-
-error_splat_root:
-	dput(fc->root);
-	fc->root =3D NULL;
 error_splat_super:
 	deactivate_locked_super(s);
 	goto out;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 94c77ed55ce1..6838c149f335 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -75,6 +75,7 @@ struct nfs_fattr {
 	struct nfs4_string	*owner_name;
 	struct nfs4_string	*group_name;
 	struct nfs4_threshold	*mdsthreshold;	/* pNFS threshold hints */
+	struct nfs4_label	*label;
 };
=20
 #define NFS_ATTR_FATTR_TYPE		(1U << 0)
--=20
2.24.1

