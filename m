Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097CE2AA5D5
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Nov 2020 15:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgKGONq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Nov 2020 09:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgKGONn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 7 Nov 2020 09:13:43 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624BE20719
        for <linux-nfs@vger.kernel.org>; Sat,  7 Nov 2020 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604758422;
        bh=8WGa6QyAelKXhFR4IP7grcPP+lRZcGnEynx4Kp6SGxM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rDy/kCryuoA2n+dXI1zgznf4OEH6PjH5jksDLzleeJJwZvIcuqvcS9AZ5/CAb5yS+
         mxYtI87b12J69+o+fF1c+5mPvAqUfWgcEVOl1sN5vh2LeZ6dZVWg24/UXU+U1oJLvq
         RqozeeD/+MeguSwWcPvz+3GRsqVpqv3wfDkC6/9w=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 14/21] NFS: Reduce readdir stack usage
Date:   Sat,  7 Nov 2020 09:03:18 -0500
Message-Id: <20201107140325.281678-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107140325.281678-14-trondmy@kernel.org>
References: <20201107140325.281678-1-trondmy@kernel.org>
 <20201107140325.281678-2-trondmy@kernel.org>
 <20201107140325.281678-3-trondmy@kernel.org>
 <20201107140325.281678-4-trondmy@kernel.org>
 <20201107140325.281678-5-trondmy@kernel.org>
 <20201107140325.281678-6-trondmy@kernel.org>
 <20201107140325.281678-7-trondmy@kernel.org>
 <20201107140325.281678-8-trondmy@kernel.org>
 <20201107140325.281678-9-trondmy@kernel.org>
 <20201107140325.281678-10-trondmy@kernel.org>
 <20201107140325.281678-11-trondmy@kernel.org>
 <20201107140325.281678-12-trondmy@kernel.org>
 <20201107140325.281678-13-trondmy@kernel.org>
 <20201107140325.281678-14-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The descriptor and the struct nfs_entry are both large structures,
so don't allocate them from the stack.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 58 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 48856cee10de..c3af54640f6c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -761,23 +761,24 @@ static
 int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page, struct inode *inode)
 {
 	struct page **pages;
-	struct nfs_entry entry;
+	struct nfs_entry *entry;
 	size_t array_size;
 	size_t dtsize = NFS_SERVER(inode)->dtsize;
 	int status = -ENOMEM;
 
-	entry.prev_cookie = 0;
-	entry.cookie = nfs_readdir_page_last_cookie(page);
-	entry.eof = 0;
-	entry.fh = nfs_alloc_fhandle();
-	entry.fattr = nfs_alloc_fattr();
-	entry.server = NFS_SERVER(inode);
-	if (entry.fh == NULL || entry.fattr == NULL)
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	entry->cookie = nfs_readdir_page_last_cookie(page);
+	entry->fh = nfs_alloc_fhandle();
+	entry->fattr = nfs_alloc_fattr();
+	entry->server = NFS_SERVER(inode);
+	if (entry->fh == NULL || entry->fattr == NULL)
 		goto out;
 
-	entry.label = nfs4_label_alloc(NFS_SERVER(inode), GFP_NOWAIT);
-	if (IS_ERR(entry.label)) {
-		status = PTR_ERR(entry.label);
+	entry->label = nfs4_label_alloc(NFS_SERVER(inode), GFP_NOWAIT);
+	if (IS_ERR(entry->label)) {
+		status = PTR_ERR(entry->label);
 		goto out;
 	}
 
@@ -788,7 +789,7 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 
 	do {
 		unsigned int pglen;
-		status = nfs_readdir_xdr_filler(desc, entry.cookie,
+		status = nfs_readdir_xdr_filler(desc, entry->cookie,
 						pages, dtsize);
 		if (status < 0)
 			break;
@@ -799,15 +800,16 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 			break;
 		}
 
-		status = nfs_readdir_page_filler(desc, &entry, pages, page, pglen);
+		status = nfs_readdir_page_filler(desc, entry, pages, page, pglen);
 	} while (!status && nfs_readdir_page_needs_filling(page));
 
 	nfs_readdir_free_pages(pages, array_size);
 out_release_label:
-	nfs4_label_free(entry.label);
+	nfs4_label_free(entry->label);
 out:
-	nfs_free_fattr(entry.fattr);
-	nfs_free_fhandle(entry.fh);
+	nfs_free_fattr(entry->fattr);
+	nfs_free_fhandle(entry->fh);
+	kfree(entry);
 	return status;
 }
 
@@ -974,13 +976,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry	*dentry = file_dentry(file);
 	struct inode	*inode = d_inode(dentry);
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
-	nfs_readdir_descriptor_t my_desc = {
-		.file = file,
-		.ctx = ctx,
-		.plus = nfs_use_readdirplus(inode, ctx),
-	},
-			*desc = &my_desc;
-	int res = 0;
+	struct nfs_readdir_descriptor *desc;
+	int res;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
 			file, (long long)ctx->pos);
@@ -992,10 +989,19 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	 * to either find the entry with the appropriate number or
 	 * revalidate the cookie.
 	 */
-	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode))
+	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
 		res = nfs_revalidate_mapping(inode, file->f_mapping);
-	if (res < 0)
+		if (res < 0)
+			goto out;
+	}
+
+	res = -ENOMEM;
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
 		goto out;
+	desc->file = file;
+	desc->ctx = ctx;
+	desc->plus = nfs_use_readdirplus(inode, ctx);
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
@@ -1040,6 +1046,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	spin_unlock(&file->f_lock);
 
+	kfree(desc);
+
 out:
 	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
 	return res;
-- 
2.28.0

