Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEF3437B98
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhJVRNz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhJVRNj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:39 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D1C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:21 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o20so2839344qvk.7
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9byFL9ZYKIXoEzX0bX5NspITpcO7hh4c701ZZ04+cg=;
        b=qegxFXY7H9HZLOUN35P1PKZFKGO9qhwMiRh1VDxtSWuiFH7PFcCbznxoPYZG/AFmpk
         CQ+IPnVyYhDkg8tjLs5QjLVR4CR9a/E/O+BOB30iMo1mQFunCbf+HpRnbtc5Ut9J6kin
         QokoDWAo5G08X0NMtc5cfjmoaAzwA06hL4aC7Y71L8N62kH6aTbJ+pS7EU2uujfOThmD
         8g8xFs9WidJzXIEsP4Ey8ySdGU0Nle5zxg7+VcIKtXYbtQXoHci6xFCEJYkm7XDS2ude
         nmoiEa5KoElmy5zjxIr+OBTd1LTgUs3RUqfJ1zoTiA/2fHRZSqBnYSTy1ZOiy7FguzlM
         H57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=z9byFL9ZYKIXoEzX0bX5NspITpcO7hh4c701ZZ04+cg=;
        b=fTpDNBtaE0iXJ4g5iRmsS54ENehj73RnT7Tdnc6gdvVG4OnL5cITByK6wcmjoDrdPa
         Qn74Ba6xEhjWiNu8QUl8PVMu/cJu2MWlqQ62A4w8o0O8gKeQAJSF3ud6zSVlJRnN/djx
         eW6nqDlWqhBXpuQPGRvNDziUxHSkij4ytVRYDT1lsjo1T2emTTdIYrA3+cHYudV6ADgw
         zwl8a2zn8JgJJ7bVmuttvnkVLucaTTO8Rh9nRiqu3gzr8/htxxTdti0t4hHzmt2fUVwL
         vnr8FYJMNW7lI5AGIDcHAIMdiFCL4CsokGCVxScZL9r7JrBBRR2pOArPcSOaysSr2Zw9
         SoWA==
X-Gm-Message-State: AOAM53200/rL3f4lXGkdPt/ssUO7RQsx2CXrFYLfomD2voxeMQmbvRhF
        9h7PEAVYt9zO4VvhA4si8n0=
X-Google-Smtp-Source: ABdhPJyFdeYaeODvL88Nv5P75xeM9A7WYpIMrOyxmOpPLK8t9/Q/F7ZrQQdVq+GD/9SIAi65xuR3qg==
X-Received: by 2002:a0c:e64e:: with SMTP id c14mr842570qvn.56.1634922680673;
        Fri, 22 Oct 2021 10:11:20 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:20 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 10/14] NFS: Remove the nfs4_label argument from nfs_instantiate()
Date:   Fri, 22 Oct 2021 13:11:09 -0400
Message-Id: <20211022171113.16739-11-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
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
index 56ba52ec2228..052f9c367d17 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -527,7 +527,7 @@ extern struct dentry *nfs_add_or_obtain(struct dentry *dentry,
 			struct nfs_fh *fh, struct nfs_fattr *fattr,
 			struct nfs4_label *label);
 extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
-			struct nfs_fattr *fattr, struct nfs4_label *label);
+			struct nfs_fattr *fattr);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
 extern void nfs_access_zap_cache(struct inode *inode);
 extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res,
-- 
2.33.1

