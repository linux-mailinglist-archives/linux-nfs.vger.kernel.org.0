Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79966437B8A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhJVRNp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbhJVRNd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:33 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1359C061766
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j12so5295736qkk.5
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TlUoDNI6gjQ3bF7gQnXIUNEqr/12MDT6JBnLNFSRDQc=;
        b=ElkduZccNpncOYpC9RQmLJtaEsWXeHkh7Rty5BCOMD19/8s3hMUPrwHudToqMtHPcO
         zagiNFtMkwqoGrp3Abdt5mI1cuGx7bKFspWMXQBalhHoeNHQICWYna/RXrHbGiZ40gt1
         W+SVB3Exs80cwzy/Elud0rnDw5WZy+L3Mffn2bTaRbotBArh5h92gLDvOArzOhgruoo3
         xshI+Vc9b1u2GSVbfK4FpHJGuBZDWMjVZdz4d8JZk4MuDvwj9ll5GIcFGngZ7WfSndq+
         CUlU2P7U/9Gy2oku5Wwa1YmblQBfmFizu4hVh/E6badw7TiMncyVd+/VdZ9Gzl25GCen
         h38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TlUoDNI6gjQ3bF7gQnXIUNEqr/12MDT6JBnLNFSRDQc=;
        b=FFR3xxfbFr6JIZyMmlC7jHK+8kuo5TJSreJOev9abxuuBxAgCDNiy2vxWPG3CAwoLj
         6EgCwijBBgBu5XPBuxjpvzR8Zb3xMXBuoKC3KaErsT737fz8zMPmO/i1Z/tmo0jeNGqH
         IVL1rbBG4LHQk39jRcL2r+zRzdzsesx6qz5eV0SaAfw8Fj/e3CjXedaObxrRT0Vta05U
         uT6hOG5vU088/vCtXzQST+GhzvfZqeph8wCI5mIYWyAAmNKzPloKjhqTNBbsrCyj8y/C
         5KMs5PzyqKrY6htlOeWJwpKlGZJujAf8+o9owmpAppo1aCXbNqh9RppXa2CcGxzGBeqG
         UI+Q==
X-Gm-Message-State: AOAM5315chER4A0TRMNaCKYQoUKPyQpsyvOgrUqfjVTMzlQrFvCgSjsR
        6MhsBIwqbfsTedEGoQorQPg=
X-Google-Smtp-Source: ABdhPJwDPZ0OgFGhmx/zc2P9JDd/5HqzU5HIyaHEG3bTId03F5P/OogcgpwJs/lH7/QQ/LlxHDuopg==
X-Received: by 2002:a37:67cc:: with SMTP id b195mr1074818qkc.99.1634922674913;
        Fri, 22 Oct 2021 10:11:14 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:14 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 01/14] NFS: Create a new nfs_alloc_fattr_with_label() function
Date:   Fri, 22 Oct 2021 13:11:00 -0400
Message-Id: <20211022171113.16739-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

For creating fattrs with the label field already allocated for us. I
also update nfs_free_fattr() to free the label in the end.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/getroot.c       | 17 ++++++-----------
 fs/nfs/inode.c         | 17 +++++++++++++++++
 fs/nfs/internal.h      |  9 ---------
 include/linux/nfs_fs.h | 13 +++++++++++++
 4 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 59355c106ece..7604cb6a0ac2 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -80,18 +80,15 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		goto out;
 
 	/* get the actual root for this mount */
-	fsinfo.fattr = nfs_alloc_fattr();
+	fsinfo.fattr = nfs_alloc_fattr_with_label(server);
 	if (fsinfo.fattr == NULL)
 		goto out_name;
 
-	fsinfo.fattr->label = nfs4_label_alloc(server, GFP_KERNEL);
-	if (IS_ERR(fsinfo.fattr->label))
-		goto out_fattr;
 	error = server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsinfo);
 	if (error < 0) {
 		dprintk("nfs_get_root: getattr error = %d\n", -error);
 		nfs_errorf(fc, "NFS: Couldn't getattr on root");
-		goto out_label;
+		goto out_fattr;
 	}
 
 	inode = nfs_fhget(s, ctx->mntfh, fsinfo.fattr, NULL);
@@ -99,12 +96,12 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		dprintk("nfs_get_root: get root inode failed\n");
 		error = PTR_ERR(inode);
 		nfs_errorf(fc, "NFS: Couldn't get root inode");
-		goto out_label;
+		goto out_fattr;
 	}
 
 	error = nfs_superblock_set_dummy_root(s, inode);
 	if (error != 0)
-		goto out_label;
+		goto out_fattr;
 
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
@@ -115,7 +112,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		dprintk("nfs_get_root: get root dentry failed\n");
 		error = PTR_ERR(root);
 		nfs_errorf(fc, "NFS: Couldn't get root dentry");
-		goto out_label;
+		goto out_fattr;
 	}
 
 	security_d_instantiate(root, inode);
@@ -154,8 +151,6 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 	nfs_setsecurity(inode, fsinfo.fattr, fsinfo.fattr->label);
 	error = 0;
 
-out_label:
-	nfs4_label_free(fsinfo.fattr->label);
 out_fattr:
 	nfs_free_fattr(fsinfo.fattr);
 out_name:
@@ -165,5 +160,5 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 error_splat_root:
 	dput(fc->root);
 	fc->root = NULL;
-	goto out_label;
+	goto out_fattr;
 }
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 853213b3a209..309a8921eea3 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1586,6 +1586,23 @@ struct nfs_fattr *nfs_alloc_fattr(void)
 }
 EXPORT_SYMBOL_GPL(nfs_alloc_fattr);
 
+struct nfs_fattr *nfs_alloc_fattr_with_label(struct nfs_server *server)
+{
+	struct nfs_fattr *fattr = nfs_alloc_fattr();
+
+	if (!fattr)
+		return NULL;
+
+	fattr->label = nfs4_label_alloc(server, GFP_NOFS);
+	if (IS_ERR(fattr->label)) {
+		kfree(fattr);
+		return NULL;
+	}
+
+	return fattr;
+}
+EXPORT_SYMBOL_GPL(nfs_alloc_fattr_with_label);
+
 struct nfs_fh *nfs_alloc_fhandle(void)
 {
 	struct nfs_fh *fh;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 66fc936834f2..7483f196c6ef 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -341,14 +341,6 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
 
 	return dst;
 }
-static inline void nfs4_label_free(struct nfs4_label *label)
-{
-	if (label) {
-		kfree(label->label);
-		kfree(label);
-	}
-	return;
-}
 
 static inline void nfs_zap_label_cache_locked(struct nfs_inode *nfsi)
 {
@@ -357,7 +349,6 @@ static inline void nfs_zap_label_cache_locked(struct nfs_inode *nfsi)
 }
 #else
 static inline struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags) { return NULL; }
-static inline void nfs4_label_free(void *label) {}
 static inline void nfs_zap_label_cache_locked(struct nfs_inode *nfsi)
 {
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b9a8b925db43..56ba52ec2228 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -421,9 +421,22 @@ extern void nfs_fattr_set_barrier(struct nfs_fattr *fattr);
 extern unsigned long nfs_inc_attr_generation_counter(void);
 
 extern struct nfs_fattr *nfs_alloc_fattr(void);
+extern struct nfs_fattr *nfs_alloc_fattr_with_label(struct nfs_server *server);
+
+static inline void nfs4_label_free(struct nfs4_label *label)
+{
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (label) {
+		kfree(label->label);
+		kfree(label);
+	}
+#endif
+}
 
 static inline void nfs_free_fattr(const struct nfs_fattr *fattr)
 {
+	if (fattr)
+		nfs4_label_free(fattr->label);
 	kfree(fattr);
 }
 
-- 
2.33.1

