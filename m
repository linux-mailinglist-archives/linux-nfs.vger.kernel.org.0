Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E979D405DED
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhIIUOu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbhIIUOq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:46 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93A2C061574
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:36 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bk29so3256247qkb.8
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJKocMvOnsXd9WKsKEkKjeKGSk6qJFfBHikdmzl2R58=;
        b=KphMDik8uTHymtDRgKns3pTL96jOTt3Fr/OI5729Do2yKHCat4WjkmUvKNNIyorTDZ
         8xXKjdVjl9X5KirV4n1+TKylJPNe41saK3vGRKdjuLsdvb6fvj29o2vTfi5fxFsVJJeG
         hQsig3XF6vPc0adPfjY90bqTIbRYaukJoFkIsowQDryi4UwIFns38fS7m5aAmO5gi+8N
         boZSGrKVtfE9dQnVjlhoYEsll+jIGq2yDCrSokrc2RmcgYRX1J0pOx90TvJ1841rGeEo
         lRVJbxv4/gLIZ2pSuI93jm4xx4MYY/m+nQ+DONBBgC3eA1VaCLZpMjgpz/IKc3v2VGFU
         G9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xJKocMvOnsXd9WKsKEkKjeKGSk6qJFfBHikdmzl2R58=;
        b=uN599YZ+Fm/MRRjPr/XxnOunv+aBbOutWcwBCU8qDAIutlhHLg9Xt+eKmT9CYAeDUy
         wUgVQEY33R/EQ4UZ62Z3OWk53xbe+U7V7oyQqq3WBbUYbW5MgNsK/aJVM5Ab4GDFZz+G
         2fx8pWZ0wAP0UiRo/SO670EsKFirYnbWEibdsAkK0m1pGsWXQ+LDMfn8uEqPxACtI7Js
         NXzu+jJxcES9Yxk0zGYGH8Ggt1Dd0lAg+lscT3iEZVojeViiG+juDj4UI3Br2QMp4NNj
         J9u9VJdMhpQIiz2PloWIhZcooOczjooo2MAIBRaPs1dDlcT6t5enRYvUjp02+lvR0CQ9
         vmig==
X-Gm-Message-State: AOAM530H25i8sJSnYsTsosTgVEpsZzlbMYyRixU8LyrsNDtnnYsB0cjn
        y/F5sY9AFBdq+XzyZUu06ek=
X-Google-Smtp-Source: ABdhPJzkHSJ5acapx99fHIDdyOS2Khw0+0kNyS9Sx4wQa54D+wqYdpobl/Zlp2WiV/9iBXEmyshyVw==
X-Received: by 2002:ae9:eb91:: with SMTP id b139mr4330216qkg.149.1631218416052;
        Thu, 09 Sep 2021 13:13:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:35 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 12/14] NFS: Remove the nfs4_label argument from nfs_fhget()
Date:   Thu,  9 Sep 2021 16:13:25 -0400
Message-Id: <20210909201327.108759-13-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
References: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/dir.c           | 6 +++---
 fs/nfs/export.c        | 4 ++--
 fs/nfs/getroot.c       | 2 +-
 fs/nfs/inode.c         | 4 ++--
 fs/nfs/nfs4file.c      | 3 +--
 fs/nfs/nfs4proc.c      | 2 +-
 include/linux/nfs_fs.h | 2 +-
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cf7d0280155a..a34cbdd2b632 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -695,7 +695,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		goto out;
 	}
 
-	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr, entry->fattr->label);
+	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr);
 	alias = d_splice_alias(inode, dentry);
 	d_lookup_done(dentry);
 	if (alias) {
@@ -1780,7 +1780,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		res = ERR_PTR(error);
 		goto out;
 	}
-	inode = nfs_fhget(dentry->d_sb, fhandle, fattr, fattr->label);
+	inode = nfs_fhget(dentry->d_sb, fhandle, fattr);
 	res = ERR_CAST(inode);
 	if (IS_ERR(res))
 		goto out;
@@ -2057,7 +2057,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 		if (error < 0)
 			goto out_error;
 	}
-	inode = nfs_fhget(dentry->d_sb, fhandle, fattr, fattr->label);
+	inode = nfs_fhget(dentry->d_sb, fhandle, fattr);
 	d = d_splice_alias(inode, dentry);
 out:
 	dput(parent);
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 8e01572fc0dd..01596f2d0a1e 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -103,7 +103,7 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 		goto out_free_fattr;
 	}
 
-	inode = nfs_fhget(sb, server_fh, fattr, fattr->label);
+	inode = nfs_fhget(sb, server_fh, fattr);
 
 out_found:
 	dentry = d_obtain_alias(inode);
@@ -138,7 +138,7 @@ nfs_get_parent(struct dentry *dentry)
 		goto out;
 	}
 
-	pinode = nfs_fhget(sb, &fh, fattr, fattr->label);
+	pinode = nfs_fhget(sb, &fh, fattr);
 	parent = d_obtain_alias(pinode);
 out:
 	nfs_free_fattr(fattr);
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 7604cb6a0ac2..0aedee201166 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -91,7 +91,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		goto out_fattr;
 	}
 
-	inode = nfs_fhget(s, ctx->mntfh, fsinfo.fattr, NULL);
+	inode = nfs_fhget(s, ctx->mntfh, fsinfo.fattr);
 	if (IS_ERR(inode)) {
 		dprintk("nfs_get_root: get root inode failed\n");
 		error = PTR_ERR(inode);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 99ee138a0a5e..4b20ce19c90e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -431,7 +431,7 @@ nfs_ilookup(struct super_block *sb, struct nfs_fattr *fattr, struct nfs_fh *fh)
  * instead of inode number.
  */
 struct inode *
-nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, struct nfs4_label *label)
+nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 {
 	struct nfs_find_desc desc = {
 		.fh	= fh,
@@ -563,7 +563,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 			   fattr->size != 0)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
 
-		nfs_setsecurity(inode, fattr, label);
+		nfs_setsecurity(inode, fattr, fattr->label);
 
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 		nfsi->attrtimeo_timestamp = now;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index cffc5c900d5c..ec7fd2c5f7f6 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -345,8 +345,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		goto out;
 	snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
 
-	r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, &fattr,
-			NULL);
+	r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, &fattr);
 	if (IS_ERR(r_ino)) {
 		res = ERR_CAST(r_ino);
 		goto out_free_name;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b36cea00977d..975177959e07 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2012,7 +2012,7 @@ nfs4_opendata_get_inode(struct nfs4_opendata *data)
 		if (!(data->f_attr.valid & NFS_ATTR_FATTR))
 			return ERR_PTR(-EAGAIN);
 		inode = nfs_fhget(data->dir->d_sb, &data->o_res.fh,
-				&data->f_attr, data->f_attr.label);
+				&data->f_attr);
 		break;
 	default:
 		inode = d_inode(data->dentry);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 457c5a7c1e1c..6fd5ee9c23bb 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -378,7 +378,7 @@ extern void nfs_zap_caches(struct inode *);
 extern void nfs_set_inode_stale(struct inode *inode);
 extern void nfs_invalidate_atime(struct inode *);
 extern struct inode *nfs_fhget(struct super_block *, struct nfs_fh *,
-				struct nfs_fattr *, struct nfs4_label *);
+				struct nfs_fattr *);
 struct inode *nfs_ilookup(struct super_block *sb, struct nfs_fattr *, struct nfs_fh *);
 extern int nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_post_op_update_inode(struct inode *inode, struct nfs_fattr *fattr);
-- 
2.33.0

