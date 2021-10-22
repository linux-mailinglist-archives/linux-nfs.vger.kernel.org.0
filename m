Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE8437B9B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhJVRN7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhJVRNn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:43 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8FC061766
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:25 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id b1so919283qvk.5
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SHDA7YvQRnodq68TQ5EaK5vBfZ9KMV2Z6ZTLczSeX2c=;
        b=IDi6UhiNhuleYpZPW9W9mKRNOMBDxNHvqIDZ9BWqsZvV96+ftlsk7LZkTJXsxlju3D
         2bbDMEdbcj7JondLCAcMeLEeGegBgYKKJejE6QOcY0PG1CR+YAe+1yfNps9k0n4ijHHO
         bIXutq9E2pYbpSlzCWevjCjbMQJZhmhszG48sMhySJU4ITUGx/wMu6cZzcb17EBzJbGD
         wfNHQy+TeFLhuK1idlwjoiHWJOO8aSY54JCJLDiTTH5/BimjFYiZxZKM5Sk3s1wRf8Jx
         RNPWmZvJoym3pwaho5JExgzqljuJ1Wgq2ttZJB+dwq9sj/r7UIX3QuPV2JzZI2VRoANe
         VZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SHDA7YvQRnodq68TQ5EaK5vBfZ9KMV2Z6ZTLczSeX2c=;
        b=O/iQojFZ/A1StiJJHoyDBa/gL2DN6RX6cM+eLGx4AmYtiAL2Y9bpLjn+EX54cIxDW7
         T8RrYtVAY2EqBiZ4RXbOQLxrI9XSjLVgGUmUT9GW/4MiKJ00Sf0Ss8V3GPid/TRSwFNb
         j/LevdCQfApcilXvv5At+jfesY62oVPQaKOr4Y8YMXD/pLFuDcHGOroCSlyHRfqQhY9i
         4gASvykBFc60HZG7v9k5SITWDUr1fi3vVck0ZPAmrv3zALdKcbLMPJKyoRkvlYOzJMK3
         G37qbOKWzRrfFnMRXlXkZk/KBWHdMHFnhfc/88aSQ5QeVTMo0me5ABMPVqS1JoKTs3UX
         R8/A==
X-Gm-Message-State: AOAM533gBO9H3kC0CpAulayX7kdgF0tAPKbTZTBWQ0kpnIgwN1+u0dWm
        /FyZODsqfNAB7bq9tWjN+z8=
X-Google-Smtp-Source: ABdhPJxvqQ9it74AsJqzNqfEcL3th4lHgXALo9y6neNVs4iHVMtKvEAy/c+viN1pRYEzjuGgM/nfjw==
X-Received: by 2002:a0c:ea2a:: with SMTP id t10mr1216972qvp.35.1634922681940;
        Fri, 22 Oct 2021 10:11:21 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:21 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 12/14] NFS: Remove the nfs4_label argument from nfs_fhget()
Date:   Fri, 22 Oct 2021 13:11:11 -0400
Message-Id: <20211022171113.16739-13-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
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
index a0462f7e7e35..171c424cb6d5 100644
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
index ef78e06bcd21..f55236169645 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -343,8 +343,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
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
index 4566c2692cdd..ac4416ebf0ec 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -383,7 +383,7 @@ extern void nfs_zap_caches(struct inode *);
 extern void nfs_set_inode_stale(struct inode *inode);
 extern void nfs_invalidate_atime(struct inode *);
 extern struct inode *nfs_fhget(struct super_block *, struct nfs_fh *,
-				struct nfs_fattr *, struct nfs4_label *);
+				struct nfs_fattr *);
 struct inode *nfs_ilookup(struct super_block *sb, struct nfs_fattr *, struct nfs_fh *);
 extern int nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_post_op_update_inode(struct inode *inode, struct nfs_fattr *fattr);
-- 
2.33.1

