Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA452AE217
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgKJVsG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732002AbgKJVsE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:48:04 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6111B20781
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044883;
        bh=PZrE/PvcVjZKdZ3mAu7JFmys+cQonAS+F+T3rcSDTm0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vr1T4jDm7vuaiHuYxu3OAdgnQ9XiAd+vXCmJ40cQMp9Wcgell4WvcRpDhf6byv9AX
         g7irg49xvYDXTRS7c6l1It2F+JAL3dWqJ3/AQRpLkJP/526ueV2DySP5Bo2xIB25Ho
         npb/Lcu1UknwJm+f5k3b1RQXs81dVK9lQpLG7GFE=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 21/22] NFS: Reduce number of RPC calls when doing uncached readdir
Date:   Tue, 10 Nov 2020 16:37:40 -0500
Message-Id: <20201110213741.860745-22-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-21-trondmy@kernel.org>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <20201110213741.860745-2-trondmy@kernel.org>
 <20201110213741.860745-3-trondmy@kernel.org>
 <20201110213741.860745-4-trondmy@kernel.org>
 <20201110213741.860745-5-trondmy@kernel.org>
 <20201110213741.860745-6-trondmy@kernel.org>
 <20201110213741.860745-7-trondmy@kernel.org>
 <20201110213741.860745-8-trondmy@kernel.org>
 <20201110213741.860745-9-trondmy@kernel.org>
 <20201110213741.860745-10-trondmy@kernel.org>
 <20201110213741.860745-11-trondmy@kernel.org>
 <20201110213741.860745-12-trondmy@kernel.org>
 <20201110213741.860745-13-trondmy@kernel.org>
 <20201110213741.860745-14-trondmy@kernel.org>
 <20201110213741.860745-15-trondmy@kernel.org>
 <20201110213741.860745-16-trondmy@kernel.org>
 <20201110213741.860745-17-trondmy@kernel.org>
 <20201110213741.860745-18-trondmy@kernel.org>
 <20201110213741.860745-19-trondmy@kernel.org>
 <20201110213741.860745-20-trondmy@kernel.org>
 <20201110213741.860745-21-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're doing uncached readdir, allocate multiple pages in order to
try to avoid duplicate RPC calls for the same getdents() call.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 105 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b6c3501e8f61..93c6f22cdc62 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -199,6 +199,23 @@ void nfs_readdir_clear_array(struct page *page)
 	kunmap_atomic(array);
 }
 
+static struct page *
+nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
+{
+	struct page *page = alloc_page(gfp_flags);
+	if (page)
+		nfs_readdir_page_init_array(page, last_cookie);
+	return page;
+}
+
+static void nfs_readdir_page_array_free(struct page *page)
+{
+	if (page) {
+		nfs_readdir_clear_array(page);
+		put_page(page);
+	}
+}
+
 static void nfs_readdir_array_set_eof(struct nfs_cache_array *array)
 {
 	array->page_is_eof = 1;
@@ -694,12 +711,14 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				   struct nfs_entry *entry,
 				   struct page **xdr_pages,
-				   struct page *fillme, unsigned int buflen)
+				   unsigned int buflen,
+				   struct page **arrays,
+				   size_t narrays)
 {
 	struct address_space *mapping = desc->file->f_mapping;
 	struct xdr_stream stream;
 	struct xdr_buf buf;
-	struct page *scratch, *new, *page = fillme;
+	struct page *scratch, *new, *page = *arrays;
 	int status;
 
 	scratch = alloc_page(GFP_KERNEL);
@@ -725,15 +744,25 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 		if (status != -ENOSPC)
 			continue;
 
-		if (page->mapping != mapping)
-			break;
-		new = nfs_readdir_page_get_next(mapping, page->index + 1,
-						entry->prev_cookie);
-		if (!new)
-			break;
-		if (page != fillme)
-			nfs_readdir_page_unlock_and_put(page);
-		page = new;
+		if (page->mapping != mapping) {
+			if (!--narrays)
+				break;
+			new = nfs_readdir_page_array_alloc(entry->prev_cookie,
+							   GFP_KERNEL);
+			if (!new)
+				break;
+			arrays++;
+			*arrays = page = new;
+		} else {
+			new = nfs_readdir_page_get_next(mapping,
+							page->index + 1,
+							entry->prev_cookie);
+			if (!new)
+				break;
+			if (page != *arrays)
+				nfs_readdir_page_unlock_and_put(page);
+			page = new;
+		}
 		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
 
@@ -750,7 +779,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 		break;
 	}
 
-	if (page != fillme)
+	if (page != *arrays)
 		nfs_readdir_page_unlock_and_put(page);
 
 	put_page(scratch);
@@ -790,10 +819,11 @@ static struct page **nfs_readdir_alloc_pages(size_t npages)
 }
 
 static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
-				    struct page *page, __be32 *verf_arg,
-				    __be32 *verf_res)
+				    __be32 *verf_arg, __be32 *verf_res,
+				    struct page **arrays, size_t narrays)
 {
 	struct page **pages;
+	struct page *page = *arrays;
 	struct nfs_entry *entry;
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
@@ -835,7 +865,8 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 			break;
 		}
 
-		status = nfs_readdir_page_filler(desc, entry, pages, page, pglen);
+		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
+						 arrays, narrays);
 	} while (!status && nfs_readdir_page_needs_filling(page));
 
 	nfs_readdir_free_pages(pages, array_size);
@@ -884,8 +915,8 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
-		res = nfs_readdir_xdr_to_array(desc, desc->page,
-					       nfsi->cookieverf, verf);
+		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
+					       &desc->page, 1);
 		if (res < 0) {
 			nfs_readdir_page_unlock_and_put_cached(desc);
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
@@ -976,37 +1007,39 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
  */
 static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 {
-	struct page	*page = NULL;
+	struct page	**arrays;
+	size_t		i, sz = 512;
 	__be32		verf[NFS_DIR_VERIFIER_SIZE];
-	int		status;
+	int		status = -ENOMEM;
 
-	dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie %Lu\n",
+	dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie %llu\n",
 			(unsigned long long)desc->dir_cookie);
 
-	page = alloc_page(GFP_HIGHUSER);
-	if (!page) {
-		status = -ENOMEM;
+	arrays = kcalloc(sz, sizeof(*arrays), GFP_KERNEL);
+	if (!arrays)
+		goto out;
+	arrays[0] = nfs_readdir_page_array_alloc(desc->dir_cookie, GFP_KERNEL);
+	if (!arrays[0])
 		goto out;
-	}
 
 	desc->page_index = 0;
 	desc->last_cookie = desc->dir_cookie;
-	desc->page = page;
 	desc->duped = 0;
 
-	nfs_readdir_page_init_array(page, desc->dir_cookie);
-	status = nfs_readdir_xdr_to_array(desc, page, desc->verf, verf);
-	if (status < 0)
-		goto out_release;
+	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
 
-	nfs_do_filldir(desc);
+	for (i = 0; !desc->eof && i < sz && arrays[i]; i++) {
+		desc->page = arrays[i];
+		nfs_do_filldir(desc);
+	}
+	desc->page = NULL;
 
- out_release:
-	nfs_readdir_clear_array(desc->page);
-	nfs_readdir_page_put(desc);
- out:
-	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
-			__func__, status);
+
+	for (i = 0; i < sz && arrays[i]; i++)
+		nfs_readdir_page_array_free(arrays[i]);
+out:
+	kfree(arrays);
+	dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
 	return status;
 }
 
-- 
2.28.0

