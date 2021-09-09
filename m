Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55372405DEB
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhIIUOt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbhIIUOp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA537C061574
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:35 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id w78so3264212qkb.4
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwAbs3wDGAVnfY2/5dZoA7jR6MbS7MCArmExUy9Gbnk=;
        b=avbU+grUo+/gnYaBS3XmdykzIsfIa+GAz7DTAwu/tLslEG86ZQAWlpQLGmPsmIqxKR
         xhq4+jyUhpL0X3p5j6o9hpkwprXg3qyYp8H9LH+0JmyEnapfA/3GZvfg//vkx2Hl0mmS
         tGPhvHQrm0cPTtOzV8xSBB0s8xmwudKNlPLVtRC2J8HwubRDZphibDxTEb4zuIydIM89
         yuFiOqd0bCdgYGAbS3635GDj0IIVlMqWHq0HoA7pyf7GsEMkWXRP5li0u7kManA1AYsX
         8VI3e/fF6sl3ymyFPYfIjw/+fDAafz5ILa0/1unBgXc3k7FsE3wPrLqLVX2pxojNYA3O
         g8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lwAbs3wDGAVnfY2/5dZoA7jR6MbS7MCArmExUy9Gbnk=;
        b=vfhPVVv3vNEiLFc19jUfHoS85joM3nzxM0xlw3qQ/wbC/PODFDR4RHnnTKhbCg+k+D
         AZ1uHFM8AIi9JBVMQFpZgoEbz755u/hCK7vK0eLn7dXqN1eoVJ42iQ+WjrexF9QfB6il
         /LfH6SDaTE1RD/h+BWZDouGuU/rCueX7DNn/BBMBZ2k4URiK81nogkPeinvAqrW8HEVN
         lJjhx6GiCLKDj7NG+7PBvXlBY4IuD+fypbTITQ09g/B+XvZGeGAUwpIZncBjmh/DoqZ/
         YXIJVfvzlbjerSIZhYA4i+BmozlbefAhlHJRTl9PR7I7wjT2JlA+3ylx1JWurHNDCpIb
         txRQ==
X-Gm-Message-State: AOAM533i3QDRnBtM3cpqIcIpHrAvfAMA4e4/YdGGkpYpo1hp+OiMwfDv
        Cv/sEh778K1EdSDQatFriVu6CVW185g=
X-Google-Smtp-Source: ABdhPJxB/I/VneLJUwcClVgAq9r117rdexc+y5j2u3VvzlYjjKm8pBCYHVr50wgFo0AsfLhHvkj9sQ==
X-Received: by 2002:a37:68d0:: with SMTP id d199mr4441664qkc.96.1631218414861;
        Thu, 09 Sep 2021 13:13:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:34 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 10/14] NFS: Remove the nfs4_label argument from nfs_instantiate()
Date:   Thu,  9 Sep 2021 16:13:23 -0400
Message-Id: <20210909201327.108759-11-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
References: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Pull the label from the fattr instead.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/dir.c           | 5 ++---
 fs/nfs/nfs4proc.c      | 2 +-
 fs/nfs/proc.c          | 8 ++++----
 include/linux/nfs_fs.h | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 7692d932add9..77bcafc692c3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2073,12 +2073,11 @@ EXPORT_SYMBOL_GPL(nfs_add_or_obtain);
  * Code common to create, mkdir, and mknod.
  */
 int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
-				struct nfs_fattr *fattr,
-				struct nfs4_label *label)
+				struct nfs_fattr *fattr)
 {
 	struct dentry *d;
 
-	d = nfs_add_or_obtain(dentry, fhandle, fattr, label);
+	d = nfs_add_or_obtain(dentry, fhandle, fattr, fattr->label);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a3b204f2f85c..b36cea00977d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4860,7 +4860,7 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
 					      data->res.fattr->time_start,
 					      NFS_INO_INVALID_DATA);
 		spin_unlock(&dir->i_lock);
-		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr, data->res.fattr->label);
+		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr);
 	}
 	return status;
 }
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index d941cd0fe34d..3d494057dbfc 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -255,7 +255,7 @@ nfs_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_mark_for_revalidate(dir);
 	if (status == 0)
-		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr, NULL);
+		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr);
 	nfs_free_createdata(data);
 out:
 	dprintk("NFS reply create: %d\n", status);
@@ -302,7 +302,7 @@ nfs_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	}
 	if (status == 0)
-		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr, NULL);
+		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr);
 	nfs_free_createdata(data);
 out:
 	dprintk("NFS reply mknod: %d\n", status);
@@ -434,7 +434,7 @@ nfs_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 	 * should fill in the data with a LOOKUP call on the wire.
 	 */
 	if (status == 0)
-		status = nfs_instantiate(dentry, fh, fattr, NULL);
+		status = nfs_instantiate(dentry, fh, fattr);
 
 out_free:
 	nfs_free_fattr(fattr);
@@ -463,7 +463,7 @@ nfs_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_mark_for_revalidate(dir);
 	if (status == 0)
-		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr, NULL);
+		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr);
 	nfs_free_createdata(data);
 out:
 	dprintk("NFS reply mkdir: %d\n", status);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 597311a063fd..07d4cd27111f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -522,7 +522,7 @@ extern struct dentry *nfs_add_or_obtain(struct dentry *dentry,
 			struct nfs_fh *fh, struct nfs_fattr *fattr,
 			struct nfs4_label *label);
 extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
-			struct nfs_fattr *fattr, struct nfs4_label *label);
+			struct nfs_fattr *fattr);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
 extern void nfs_access_zap_cache(struct inode *inode);
 extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res,
-- 
2.33.0

