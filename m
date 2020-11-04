Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5A2A69B3
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgKDQ1W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDQ1U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:20 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B9CC0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:20 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g17so4101542qts.5
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8EbaX/h/3RCq01aTlbpXpFc+qXn4adW1WPgCbxfQhE8=;
        b=R9rvG/lS3IOKvgKuKmO5sWnHY/n/9bvPgxLbKRnqp2ROAXpav1qVX9707iZXgZOz4p
         p6hd3Zrjf/J8/jZXlWvKvsx+ISoLc3TKSDr5TAz05KkRzMel6zgUdCj/JL32ih7wQeHN
         w92IELNQ8l30MU859IwggHXlyxfNnDMQ225iq+i1cCw/Kpbhe0Zz8LnhFYL7uK+tMowb
         OfFMDgklGb4gmMXwZ4/9zl8iHdmaalfINVpbnAdoLiT58lpIwyKp2L21/ty/DGboHmBC
         G1RrUS6H2C7zt49Qc3QxwD62YMQsN7v3tcVGl2xNBKIW79mz5StbR9u+aD0LGU4NPhiO
         0PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EbaX/h/3RCq01aTlbpXpFc+qXn4adW1WPgCbxfQhE8=;
        b=W78Z/RIFqhu5Szu+I+88usiz5ZUeHfWm4XUavxoZpqx+7omvAo1MAccbKH9t8X2GEm
         fpxBkMGvYXPxrHjWaxEUW9ESnZOkoHIZkQqyjKtjUOxKLAb8ml0s9pYDb6ZNYT+MzjXT
         gh8yiXYdzBwdm4+kEFsumwXVnO84SvmBh7TgJXvlq5WKIaE/AcPAMO3Ps0nrJkxKwiPp
         e2FYcR/DfCZybDDpE9m3/8APg3oEX06Wr4hlmUSngiRreZYJtJTLFtYgCyoEvxDsIfR/
         e+nwe8USdnIko/uTUSDJQ3eGFa+J0BgO/gZ68nt2FT6QBJPprv54aLaDCoJBGz0PVEt/
         Jp4A==
X-Gm-Message-State: AOAM532fjVZUdJ+IUX8I+Uo/IppTqgAj/ClD+G3h5rYrfni5qGe8c0Py
        nMLXhH7hmXIjdmqtq/X5W6EZnGGOLOIw
X-Google-Smtp-Source: ABdhPJwEGXzqiQHJ8x1eh0o9rP/z+Qq355grZlLW2ZHySyaKHThpDHGoqKXde2+FW7NMcRWTY7KmSg==
X-Received: by 2002:aed:2d82:: with SMTP id i2mr10517509qtd.10.1604507239088;
        Wed, 04 Nov 2020 08:27:19 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:18 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 16/17] NFS: Improve handling of directory verifiers
Date:   Wed,  4 Nov 2020 11:16:37 -0500
Message-Id: <20201104161638.300324-17-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-16-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com>
 <20201104161638.300324-9-trond.myklebust@hammerspace.com>
 <20201104161638.300324-10-trond.myklebust@hammerspace.com>
 <20201104161638.300324-11-trond.myklebust@hammerspace.com>
 <20201104161638.300324-12-trond.myklebust@hammerspace.com>
 <20201104161638.300324-13-trond.myklebust@hammerspace.com>
 <20201104161638.300324-14-trond.myklebust@hammerspace.com>
 <20201104161638.300324-15-trond.myklebust@hammerspace.com>
 <20201104161638.300324-16-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server insists on using the readdir verifiers in order to allow
cookies to expire, then we should ensure that we cache the verifier
with the cookie, so that we can return an error if the application
tries to use the expired cookie.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 35 +++++++++++++++++++++++------------
 fs/nfs/inode.c         |  7 -------
 include/linux/nfs_fs.h |  8 +++++++-
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3b44bef3a1b4..454377228167 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -155,6 +155,7 @@ struct nfs_readdir_descriptor {
 	loff_t		current_index;
 	loff_t		prev_index;
 
+	__be32		verf[NFS_DIR_VERIFIER_SIZE];
 	unsigned long	dir_verifier;
 	unsigned long	timestamp;
 	unsigned long	gencount;
@@ -466,15 +467,15 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 
 /* Fill a page with xdr information before transferring to the cache page */
 static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
-				  u64 cookie, struct page **pages,
-				  size_t bufsize)
+				  __be32 *verf, u64 cookie,
+				  struct page **pages, size_t bufsize,
+				  __be32 *verf_res)
 {
 	struct inode *inode = file_inode(desc->file);
-	__be32 verf_res[2];
 	struct nfs_readdir_arg arg = {
 		.dentry = file_dentry(desc->file),
 		.cred = desc->file->f_cred,
-		.verf = NFS_I(inode)->cookieverf,
+		.verf = verf,
 		.cookie = cookie,
 		.pages = pages,
 		.page_len = bufsize,
@@ -503,8 +504,6 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 	}
 	desc->timestamp = timestamp;
 	desc->gencount = gencount;
-	memcpy(NFS_I(inode)->cookieverf, res.verf,
-	       sizeof(NFS_I(inode)->cookieverf));
 error:
 	return error;
 }
@@ -770,11 +769,13 @@ static struct page **nfs_readdir_alloc_pages(size_t npages)
 }
 
 static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
-				    struct page *page, struct inode *inode)
+				    struct page *page, __be32 *verf_arg,
+				    __be32 *verf_res)
 {
 	struct page **pages;
 	struct nfs_entry *entry;
 	size_t array_size;
+	struct inode *inode = file_inode(desc->file);
 	size_t dtsize = NFS_SERVER(inode)->dtsize;
 	int status = -ENOMEM;
 
@@ -801,8 +802,9 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 
 	do {
 		unsigned int pglen;
-		status = nfs_readdir_xdr_filler(desc, entry->cookie,
-						pages, dtsize);
+		status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie,
+						pages, dtsize,
+						verf_res);
 		if (status < 0)
 			break;
 
@@ -854,13 +856,15 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 {
 	struct inode *inode = file_inode(desc->file);
 	struct nfs_inode *nfsi = NFS_I(inode);
+	__be32 verf[NFS_DIR_VERIFIER_SIZE];
 	int res;
 
 	desc->page = nfs_readdir_page_get_cached(desc);
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
-		res = nfs_readdir_xdr_to_array(desc, desc->page, inode);
+		res = nfs_readdir_xdr_to_array(desc, desc->page,
+					       nfsi->cookieverf, verf);
 		if (res < 0) {
 			nfs_readdir_page_unlock_and_put_cached(desc);
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
@@ -870,6 +874,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			}
 			return res;
 		}
+		memcpy(nfsi->cookieverf, verf, sizeof(nfsi->cookieverf));
 	}
 	res = nfs_readdir_search_array(desc);
 	if (res == 0) {
@@ -902,6 +907,7 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 {
 	struct file	*file = desc->file;
+	struct nfs_inode *nfsi = NFS_I(file_inode(file));
 	struct nfs_cache_array *array;
 	unsigned int i = 0;
 
@@ -915,6 +921,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 			desc->eof = true;
 			break;
 		}
+		memcpy(desc->verf, nfsi->cookieverf, sizeof(desc->verf));
 		if (i < (array->size-1))
 			desc->dir_cookie = array->array[i+1].cookie;
 		else
@@ -949,8 +956,8 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 {
 	struct page	*page = NULL;
+	__be32		verf[NFS_DIR_VERIFIER_SIZE];
 	int		status;
-	struct inode *inode = file_inode(desc->file);
 
 	dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie %Lu\n",
 			(unsigned long long)desc->dir_cookie);
@@ -967,7 +974,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->duped = 0;
 
 	nfs_readdir_page_init_array(page, desc->dir_cookie);
-	status = nfs_readdir_xdr_to_array(desc, page, inode);
+	status = nfs_readdir_xdr_to_array(desc, page, desc->verf, verf);
 	if (status < 0)
 		goto out_release;
 
@@ -1023,6 +1030,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->dup_cookie = dir_ctx->dup_cookie;
 	desc->duped = dir_ctx->duped;
 	desc->attr_gencount = dir_ctx->attr_gencount;
+	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
 
 	do {
@@ -1061,6 +1069,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->dup_cookie = desc->dup_cookie;
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
+	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
 	spin_unlock(&file->f_lock);
 
 	kfree(desc);
@@ -1101,6 +1110,8 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 			dir_ctx->dir_cookie = offset;
 		else
 			dir_ctx->dir_cookie = 0;
+		if (offset == 0)
+			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
 		dir_ctx->duped = 0;
 	}
 	spin_unlock(&filp->f_lock);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index aa6493905bbe..9b765a900b28 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -229,7 +229,6 @@ static void nfs_zap_caches_locked(struct inode *inode)
 	nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	nfsi->attrtimeo_timestamp = jiffies;
 
-	memset(NFS_I(inode)->cookieverf, 0, sizeof(NFS_I(inode)->cookieverf));
 	if (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) {
 		nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATTR
 					| NFS_INO_INVALID_DATA
@@ -1237,7 +1236,6 @@ EXPORT_SYMBOL_GPL(nfs_revalidate_inode);
 
 static int nfs_invalidate_mapping(struct inode *inode, struct address_space *mapping)
 {
-	struct nfs_inode *nfsi = NFS_I(inode);
 	int ret;
 
 	if (mapping->nrpages != 0) {
@@ -1250,11 +1248,6 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 		if (ret < 0)
 			return ret;
 	}
-	if (S_ISDIR(inode->i_mode)) {
-		spin_lock(&inode->i_lock);
-		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
-		spin_unlock(&inode->i_lock);
-	}
 	nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
 	nfs_fscache_wait_on_invalidate(inode);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index dd6b463dda80..681ed98e4ba8 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -45,6 +45,11 @@
  */
 #define NFS_RPC_SWAPFLAGS		(RPC_TASK_SWAPPER|RPC_TASK_ROOTCREDS)
 
+/*
+ * Size of the NFS directory verifier
+ */
+#define NFS_DIR_VERIFIER_SIZE		2
+
 /*
  * NFSv3/v4 Access mode cache entry
  */
@@ -89,6 +94,7 @@ struct nfs_open_context {
 struct nfs_open_dir_context {
 	struct list_head list;
 	unsigned long attr_gencount;
+	__be32	verf[NFS_DIR_VERIFIER_SIZE];
 	__u64 dir_cookie;
 	__u64 dup_cookie;
 	signed char duped;
@@ -156,7 +162,7 @@ struct nfs_inode {
 	 * This is the cookie verifier used for NFSv3 readdir
 	 * operations
 	 */
-	__be32			cookieverf[2];
+	__be32			cookieverf[NFS_DIR_VERIFIER_SIZE];
 
 	atomic_long_t		nrequests;
 	struct nfs_mds_commit_info commit_info;
-- 
2.28.0

