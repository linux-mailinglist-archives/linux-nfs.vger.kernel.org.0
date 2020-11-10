Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50892AE215
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgKJVsF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731910AbgKJVsB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:48:01 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C461F20781
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044881;
        bh=cMEWWMcCer6P+Uhg/Jcq2urGKl/+7vRQ6vchKX/BtHo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XjlE4fDFtC2Z5ENHVbbyzLGm6kOGfLRC/UY1FK9D3f5qwgJbLLb2s2kQ8r7+5qbl+
         6CdB8pClGvBYw+S1KWI5xzz9+/wIdf8UEldU8/mG5xUj+3WOjZvn8XV1mytTuc8cSG
         bLC+/5JH6iXcN4KdSEZFHdGHRJFFv7WP1o2RKBNI=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 16/22] NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
Date:   Tue, 10 Nov 2020 16:37:35 -0500
Message-Id: <20201110213741.860745-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-16-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c3af54640f6c..b226f6f3ae96 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -144,7 +144,7 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[];
 };
 
-typedef struct nfs_readdir_descriptor {
+struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
 	struct dir_context *ctx;
@@ -163,7 +163,7 @@ typedef struct nfs_readdir_descriptor {
 	signed char duped;
 	bool plus;
 	bool eof;
-} nfs_readdir_descriptor_t;
+};
 
 static void nfs_readdir_array_init(struct nfs_cache_array *array)
 {
@@ -362,8 +362,8 @@ bool nfs_readdir_use_cookie(const struct file *filp)
 	return true;
 }
 
-static
-int nfs_readdir_search_for_pos(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
+				      struct nfs_readdir_descriptor *desc)
 {
 	loff_t diff = desc->ctx->pos - desc->current_index;
 	unsigned int index;
@@ -394,8 +394,8 @@ nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
 	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
 }
 
-static
-int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
+					 struct nfs_readdir_descriptor *desc)
 {
 	int i;
 	loff_t new_pos;
@@ -443,8 +443,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 	return status;
 }
 
-static
-int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 {
 	struct nfs_cache_array *array;
 	int status;
@@ -497,7 +496,7 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 	return error;
 }
 
-static int xdr_decode(nfs_readdir_descriptor_t *desc,
+static int xdr_decode(struct nfs_readdir_descriptor *desc,
 		      struct nfs_entry *entry, struct xdr_stream *xdr)
 {
 	struct inode *inode = file_inode(desc->file);
@@ -757,8 +756,8 @@ static struct page **nfs_readdir_alloc_pages(size_t npages)
 	return NULL;
 }
 
-static
-int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page, struct inode *inode)
+static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
+				    struct page *page, struct inode *inode)
 {
 	struct page **pages;
 	struct nfs_entry *entry;
@@ -838,8 +837,7 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
  * Returns 0 if desc->dir_cookie was found on page desc->page_index
  * and locks the page to prevent removal from the page cache.
  */
-static
-int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
+static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 {
 	struct inode *inode = file_inode(desc->file);
 	struct nfs_inode *nfsi = NFS_I(inode);
@@ -864,8 +862,7 @@ int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
 }
 
 /* Search for desc->dir_cookie from the beginning of the page cache */
-static inline
-int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
+static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
@@ -930,8 +927,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
  *	 we should already have a complete representation of the
  *	 directory in the page cache by the time we get here.
  */
-static inline
-int uncached_readdir(nfs_readdir_descriptor_t *desc)
+static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 {
 	struct page	*page = NULL;
 	int		status;
-- 
2.28.0

