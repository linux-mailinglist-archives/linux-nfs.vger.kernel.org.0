Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26172437B99
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhJVRN5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhJVRNl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:41 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8CFC061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:23 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id v10so2843627qvb.10
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ed6xmdf6+DG/JZiOm/5yoAzgmbYZVFaFoix/dDQ/0U=;
        b=psV2drZvQ1n17EQaOv6KWZ6rEyH7JWx+CgsnwboY4g1UAljVtDtpUOTydJkbdnTh/S
         f5nKfdOTdt+uZlI7bhhZtAaGk/Jkhac50r/yxv74Qb+0mX7IdvXpznxBuUhJzNLXAfRs
         CLzro3gZEGnrFZ9Ov2eNQxj26sBls+U+m7+1etsoXOYbu5HkCVvCJNz9IdMJHBWY57uh
         8rzu6wHPaH1V26On/1yAlS1EQnvtRMwtm+vZne1SEuGXUlgvvPT8GQscs/0g/EJNvW7J
         m1WJRGmfiVLEgtqxCiWF+JaK75dSSAXVW6T+GzuDoPmYDzBLGVaDLZmUnqd07zr5YKij
         E6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8ed6xmdf6+DG/JZiOm/5yoAzgmbYZVFaFoix/dDQ/0U=;
        b=eQXVkgoMsAZ4qkWEOSmC3yPX39WCHUhm8O33sMUrcZ815iMntxT78KQtBCBk7d7pQF
         dnQOJnitkniDIh1yUThReR0LWjZ19BtJZJziOrpIlf+xPtDdBcdvsYEl0vcomgwoqrDJ
         tFMMhl2DLqBI32OB+E1A+csNz8tbB1/gUtFw0sKSFuiWGZRZJV/NEaV33EZ7jByWuy1Z
         Hx5yQ3NcV+wtFsgGYx4cTWPry3NpcvEPmZSvzshPQI1PC2WDaKfbJ4tL/PT+B47ScfoA
         LglWpK9oVPtE2bECIigpJEjOhE+7/t5q3IMPganeSUwNLbTBMs1GQEoV+0sUrlw45NDt
         g+yQ==
X-Gm-Message-State: AOAM533dzbb4dv9ulQ4d5wzAu1L2ljIDTv6DPlYayBgOSTYkfMMtYfQA
        f885BzMewCms38Gnkb5C32c=
X-Google-Smtp-Source: ABdhPJyh4q0HfibMrOBPkbpUKJyUUx4+18U4CETGfF/R1lyUkkY+8OgoK02ggvT9JQDGYZJrDTJBEw==
X-Received: by 2002:a05:6214:dab:: with SMTP id h11mr930620qvh.48.1634922682715;
        Fri, 22 Oct 2021 10:11:22 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:22 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 13/14] NFS: Remove the nfs4_label argument from nfs_setsecurity
Date:   Fri, 22 Oct 2021 13:11:12 -0400
Message-Id: <20211022171113.16739-14-Anna.Schumaker@Netapp.com>
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
 fs/nfs/dir.c           |  5 ++---
 fs/nfs/getroot.c       |  2 +-
 fs/nfs/inode.c         | 20 +++++++++-----------
 fs/nfs/nfs4proc.c      |  9 ++++-----
 include/linux/nfs_fs.h |  3 +--
 5 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a34cbdd2b632..bb8b1f7dcbed 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -680,8 +680,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 			nfs_set_verifier(dentry, dir_verifier);
 			status = nfs_refresh_inode(d_inode(dentry), entry->fattr);
 			if (!status)
-				nfs_setsecurity(d_inode(dentry), entry->fattr,
-						entry->fattr->label);
+				nfs_setsecurity(d_inode(dentry), entry->fattr);
 			goto out;
 		} else {
 			d_invalidate(dentry);
@@ -1517,7 +1516,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	if (nfs_refresh_inode(inode, fattr) < 0)
 		goto out;
 
-	nfs_setsecurity(inode, fattr, fattr->label);
+	nfs_setsecurity(inode, fattr);
 	nfs_set_verifier(dentry, dir_verifier);
 
 	/* set a readdirplus hint that we had a cache miss */
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 0aedee201166..11ff2b2e060f 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -148,7 +148,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
 		server->caps &= ~NFS_CAP_SECURITY_LABEL;
 
-	nfs_setsecurity(inode, fsinfo.fattr, fsinfo.fattr->label);
+	nfs_setsecurity(inode, fsinfo.fattr);
 	error = 0;
 
 out_fattr:
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4b20ce19c90e..d109df27c8c6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -350,23 +350,22 @@ static void nfs_clear_label_invalid(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
-void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
-					struct nfs4_label *label)
+void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr)
 {
 	int error;
 
-	if (label == NULL)
+	if (fattr->label == NULL)
 		return;
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
-		error = security_inode_notifysecctx(inode, label->label,
-				label->len);
+		error = security_inode_notifysecctx(inode, fattr->label->label,
+				fattr->label->len);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
 					__func__,
-					(char *)label->label,
-					label->len, error);
+					(char *)fattr->label->label,
+					fattr->label->len, error);
 		nfs_clear_label_invalid(inode);
 	}
 }
@@ -397,8 +396,7 @@ struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(nfs4_label_alloc);
 #else
-void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
-					struct nfs4_label *label)
+void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr)
 {
 }
 #endif
@@ -563,7 +561,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			   fattr->size != 0)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
 
-		nfs_setsecurity(inode, fattr, fattr->label);
+		nfs_setsecurity(inode, fattr);
 
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 		nfsi->attrtimeo_timestamp = now;
@@ -1233,7 +1231,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACL)
 		nfs_zap_acl_cache(inode);
 
-	nfs_setsecurity(inode, fattr, fattr->label);
+	nfs_setsecurity(inode, fattr);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) revalidation complete\n",
 		inode->i_sb->s_id,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 975177959e07..02c546f1cf5d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3179,8 +3179,7 @@ static int _nfs4_do_open(struct inode *dir,
 			if (status == 0) {
 				nfs_setattr_update_inode(state->inode, sattr,
 						opendata->o_res.f_attr);
-				nfs_setsecurity(state->inode, opendata->o_res.f_attr,
-						opendata->o_res.f_attr->label);
+				nfs_setsecurity(state->inode, opendata->o_res.f_attr);
 			}
 			sattr->ia_valid = ia_old;
 		}
@@ -4262,7 +4261,7 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 	status = nfs4_do_setattr(inode, cred, fattr, sattr, ctx, NULL);
 	if (status == 0) {
 		nfs_setattr_update_inode(inode, sattr, fattr);
-		nfs_setsecurity(inode, fattr, fattr->label);
+		nfs_setsecurity(inode, fattr);
 	}
 	return status;
 }
@@ -4783,7 +4782,7 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 		nfs4_inc_nlink(inode);
 		status = nfs_post_op_update_inode(inode, res.fattr);
 		if (!status)
-			nfs_setsecurity(inode, res.fattr, res.fattr->label);
+			nfs_setsecurity(inode, res.fattr);
 	}
 
 out:
@@ -6080,7 +6079,7 @@ nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 
 	status = nfs4_do_set_security_label(inode, &ilabel, fattr);
 	if (status == 0)
-		nfs_setsecurity(inode, fattr, fattr->label);
+		nfs_setsecurity(inode, fattr);
 
 	return status;
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index ac4416ebf0ec..525e2a6ef3b3 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -404,8 +404,7 @@ extern int nfs_revalidate_mapping(struct inode *inode, struct address_space *map
 extern int nfs_revalidate_mapping_rcu(struct inode *inode);
 extern int nfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 extern void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr, struct nfs_fattr *);
-extern void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
-				struct nfs4_label *label);
+extern void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr);
 extern struct nfs_open_context *get_nfs_open_context(struct nfs_open_context *ctx);
 extern void put_nfs_open_context(struct nfs_open_context *ctx);
 extern struct nfs_open_context *nfs_find_open_context(struct inode *inode, const struct cred *cred, fmode_t mode);
-- 
2.33.1

