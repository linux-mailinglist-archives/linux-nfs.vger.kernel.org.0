Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1884A2A32B3
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgKBSR1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 13:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgKBSR0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:26 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64DB320786
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604341045;
        bh=/NZbFtpjQ9LNrTj2o/4jqBMF+yFXx0mmLcSITwPNazc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Rc5WLURzTBSYUxbKS4aG8yfE2LJGozi/c7y498No8dl1Vg+xWyFuR74xpYdOVsLjf
         Y+BInsLwi3swHrwb6tydPivovXQlYRBGhNEpEdxyE/MdyTREQ05+Yi8uea+UvFHEyF
         nnJ/UIo5ne0EtxYariaA6KLDxOJx6W2UtKyshVn8=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/12] NFS: More readdir cleanups
Date:   Mon,  2 Nov 2020 13:06:56 -0500
Message-Id: <20201102180658.6218-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102180658.6218-10-trondmy@kernel.org>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <20201102180658.6218-4-trondmy@kernel.org>
 <20201102180658.6218-5-trondmy@kernel.org>
 <20201102180658.6218-6-trondmy@kernel.org>
 <20201102180658.6218-7-trondmy@kernel.org>
 <20201102180658.6218-8-trondmy@kernel.org>
 <20201102180658.6218-9-trondmy@kernel.org>
 <20201102180658.6218-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Remove the redundant caching of the credential in struct
nfs_open_dir_context.
Pass the buffer size as an argument to nfs_readdir_xdr_filler().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 25 +++++++++++--------------
 include/linux/nfs_fs.h |  1 -
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 272b856147af..564e737ef93e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -68,7 +68,7 @@ const struct address_space_operations nfs_dir_aops = {
 	.freepage = nfs_readdir_clear_array,
 };
 
-static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir, const struct cred *cred)
+static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir)
 {
 	struct nfs_inode *nfsi = NFS_I(dir);
 	struct nfs_open_dir_context *ctx;
@@ -78,7 +78,6 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 		ctx->attr_gencount = nfsi->attr_gencount;
 		ctx->dir_cookie = 0;
 		ctx->dup_cookie = 0;
-		ctx->cred = get_cred(cred);
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
@@ -96,7 +95,6 @@ static void put_nfs_open_dir_context(struct inode *dir, struct nfs_open_dir_cont
 	spin_lock(&dir->i_lock);
 	list_del(&ctx->list);
 	spin_unlock(&dir->i_lock);
-	put_cred(ctx->cred);
 	kfree(ctx);
 }
 
@@ -113,7 +111,7 @@ nfs_opendir(struct inode *inode, struct file *filp)
 
 	nfs_inc_stats(inode, NFSIOS_VFSOPEN);
 
-	ctx = alloc_nfs_open_dir_context(inode, current_cred());
+	ctx = alloc_nfs_open_dir_context(inode);
 	if (IS_ERR(ctx)) {
 		res = PTR_ERR(ctx);
 		goto out;
@@ -464,12 +462,12 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 }
 
 /* Fill a page with xdr information before transferring to the cache page */
-static
-int nfs_readdir_xdr_filler(struct page **pages, nfs_readdir_descriptor_t *desc,
-			struct nfs_entry *entry, struct file *file, struct inode *inode)
+static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
+				  u64 cookie, struct page **pages,
+				  size_t bufsize)
 {
-	struct nfs_open_dir_context *ctx = file->private_data;
-	const struct cred *cred = ctx->cred;
+	struct file *file = desc->file;
+	struct inode *inode = file_inode(file);
 	unsigned long	timestamp, gencount;
 	int		error;
 
@@ -477,8 +475,8 @@ int nfs_readdir_xdr_filler(struct page **pages, nfs_readdir_descriptor_t *desc,
 	timestamp = jiffies;
 	gencount = nfs_inc_attr_generation_counter();
 	desc->dir_verifier = nfs_save_change_attribute(inode);
-	error = NFS_PROTO(inode)->readdir(file_dentry(file), cred, entry->cookie, pages,
-					  NFS_SERVER(inode)->dtsize, desc->plus);
+	error = NFS_PROTO(inode)->readdir(file_dentry(file), file->f_cred,
+					  cookie, pages, bufsize, desc->plus);
 	if (error < 0) {
 		/* We requested READDIRPLUS, but the server doesn't grok it */
 		if (error == -ENOTSUPP && desc->plus) {
@@ -764,7 +762,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 {
 	struct page **pages;
 	struct nfs_entry entry;
-	struct file	*file = desc->file;
 	size_t array_size;
 	size_t dtsize = NFS_SERVER(inode)->dtsize;
 	int status = -ENOMEM;
@@ -791,8 +788,8 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 
 	do {
 		unsigned int pglen;
-		status = nfs_readdir_xdr_filler(pages, desc, &entry, file, inode);
-
+		status = nfs_readdir_xdr_filler(desc, entry.cookie,
+						pages, dtsize);
 		if (status < 0)
 			break;
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a2c6455ea3fa..dd6b463dda80 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -88,7 +88,6 @@ struct nfs_open_context {
 
 struct nfs_open_dir_context {
 	struct list_head list;
-	const struct cred *cred;
 	unsigned long attr_gencount;
 	__u64 dir_cookie;
 	__u64 dup_cookie;
-- 
2.28.0

